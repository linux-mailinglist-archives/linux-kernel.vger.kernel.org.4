Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F18461EC62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiKGHrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiKGHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:46:57 -0500
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD113E1B;
        Sun,  6 Nov 2022 23:46:56 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 044CC1AD9; Mon,  7 Nov 2022 08:46:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id F25BA8DA;
        Mon,  7 Nov 2022 08:46:52 +0100 (CET)
Date:   Mon, 7 Nov 2022 08:46:52 +0100 (CET)
From:   Nikolaus Voss <nv@vosn.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Gstir <david@sigma-star.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam: blob_gen.c: warn if key is insecure
In-Reply-To: <b1d90113-c69a-108c-7142-6a47db001a96@pengutronix.de>
Message-ID: <c4e399c0-ac28-767d-e0ee-f95c573c3fa7@vosn.de>
References: <20221019144108.48E1B1B0E@mail.steuer-voss.de> <b1d90113-c69a-108c-7142-6a47db001a96@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022, Ahmad Fatoum wrote:

> Hello Nikolaus,
>
> On 19.10.22 14:44, Nikolaus Voss wrote:
>> If CAAM is not in "trusted" or "secure" state, a fixed non-volatile key
>> is used instead of the unique device key. This is the default mode of
>> operation without secure boot (HAB). In this scenario, CAAM encrypted
>> blobs should be used only for testing but not in a production
>> environment, so issue a warning.
>
> Thanks for your patch.
>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
>> ---
>>  drivers/crypto/caam/blob_gen.c | 8 ++++++++
>>  drivers/crypto/caam/regs.h     | 3 +++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
>> index 6345c7269eb0..f3e741393f65 100644
>> --- a/drivers/crypto/caam/blob_gen.c
>> +++ b/drivers/crypto/caam/blob_gen.c
>> @@ -6,6 +6,7 @@
>>
>>  #define pr_fmt(fmt) "caam blob_gen: " fmt
>>
>> +#include <linux/bitfield.h>
>>  #include <linux/device.h>
>>  #include <soc/fsl/caam-blob.h>
>>
>> @@ -62,11 +63,13 @@ int caam_process_blob(struct caam_blob_priv *priv,
>>  		      struct caam_blob_info *info, bool encap)
>
> I agree with Herbert that this may not be the best place. I think
> a single warning during caam_blob_gen_init() would suffice.
>
>>  {
>>  	struct caam_blob_job_result testres;
>> +	const struct caam_drv_private *ctrlpriv;
>>  	struct device *jrdev = &priv->jrdev;
>>  	dma_addr_t dma_in, dma_out;
>>  	int op = OP_PCLID_BLOB;
>>  	size_t output_len;
>>  	u32 *desc;
>> +	u32 moo;
>>  	int ret;
>>
>>  	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
>> @@ -100,6 +103,11 @@ int caam_process_blob(struct caam_blob_priv *priv,
>>  		goto out_unmap_in;
>>  	}
>>
>> +	ctrlpriv = dev_get_drvdata(jrdev->parent);
>> +	moo = FIELD_GET(CSTA_MOO, ctrlpriv->ctrl->perfmon.status);
>> +	if (moo != CSTA_MOO_SECURE && moo != CSTA_MOO_TRUSTED)
>> +		dev_warn(jrdev, "using insecure test key!\n");
>
> I'd make the warning a bit more verbose, e.g.
>
>  "device not configured for trusted/secure mode: using insecure test key!"

I agree.

>
>> +
>>  	/*
>>  	 * A data blob is encrypted using a blob key (BK); a random number.
>>  	 * The BK is used as an AES-CCM key. The initial block (B0) and the
>> diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
>> index 66d6dad841bb..b7de5fb5e056 100644
>> --- a/drivers/crypto/caam/regs.h
>> +++ b/drivers/crypto/caam/regs.h
>> @@ -426,6 +426,9 @@ struct caam_perfmon {
>>  	u32 rsvd2;
>>  #define CSTA_PLEND		BIT(10)
>>  #define CSTA_ALT_PLEND		BIT(18)
>> +#define CSTA_MOO		GENMASK(9, 8)
>> +#define CSTA_MOO_SECURE	1
>> +#define CSTA_MOO_TRUSTED	3
>
> I just checked the i.MX6 and LS1046 security reference manuals and both
> have Trusted as 2 (10b). 3 is fail. Does you SoC differ? Either way, please
> note what SoC you were testing on in the commit message.

You're right, I will correct that.

Niko

