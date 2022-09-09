Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAB5B3282
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIII7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIII6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:58:33 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7F10BA6A;
        Fri,  9 Sep 2022 01:58:04 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1E34721F3;
        Fri,  9 Sep 2022 10:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662713882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKWpGy9Sm/h+vL8rknv+UFCIpuNP8hHTtInxhBqUUDg=;
        b=1q0wZefGZU+a4bo3O0XKv6aSKfvwAMAjX9kZILz6cFvd4hJc7n+RCZAqPbbJWnWs2NG9Ej
        XTKxJ5WMmUyE+Jf8aY30uRm4NMKCbE1Xr1RoiPmX23porTbAu35EWL/RGX+RjPMVu0CXR6
        s1l5XzVG6ytQ2dL3uB/L1QdwhTy7VXdS35mBIdH+eIdB62mbXYjITgDZSGY5Loanzmi0vM
        yiAOdWIIvKZqoHUfw5imLbdL92IbqSj6VznRJ8FU/rfP7o+UkMeGWusj+mf2TcBL9OgNiz
        kcsFcOTibFGsYngS5wygKrK9aqqO+wbqskG/E77XNAvy4JDWQaoYg9+Ep2fY3g==
MIME-Version: 1.0
Date:   Fri, 09 Sep 2022 10:58:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 13/20] nvmem: core: drop priv pointer in post process
 callback
In-Reply-To: <373b10aa-f5c8-28b3-88b0-f87a1a40b000@linaro.org>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-14-michael@walle.cc>
 <373b10aa-f5c8-28b3-88b0-f87a1a40b000@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <42bc3f6796cc75baafc15c6d2c71ec92@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-09 10:52, schrieb Srinivas Kandagatla:
> On 01/09/2022 23:18, Michael Walle wrote:
>> It doesn't make any more sense to have a opaque pointer set up by the
>> nvmem device. Usually, the layout isn't associated with a particular
>> nvmem device.
>> 
> This is really not a good idea to remove the context pointer, as this
> is the only way for callback to get context which it can make use of.

In which case? As I mentioned it's the priv to the nvmem driver and all
the "normal" callbacks can do very little with it. If there will be a
future need, then there should be a proper opaque pointer associated
with the layout and not the nvmem driver.

-michael

> I would prefer this to be left as it is.
> 
> --srini
> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> changes since v1:
>>   - new patch
>> 
>>   drivers/nvmem/core.c           | 4 ++--
>>   drivers/nvmem/imx-ocotp.c      | 4 ++--
>>   include/linux/nvmem-provider.h | 5 +++--
>>   3 files changed, 7 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index d31d3f0ab517..6910796937f9 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -1523,8 +1523,8 @@ static int __nvmem_cell_read(struct nvmem_device 
>> *nvmem,
>>   		nvmem_shift_read_buffer_in_place(cell, buf);
>>     	if (cell->read_post_process) {
>> -		rc = cell->read_post_process(nvmem->priv, id, index,
>> -					     cell->offset, buf, cell->bytes);
>> +		rc = cell->read_post_process(id, index, cell->offset, buf,
>> +					     cell->bytes);
>>   		if (rc)
>>   			return rc;
>>   	}
>> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
>> index ac0edb6398f1..5e869d4a81c5 100644
>> --- a/drivers/nvmem/imx-ocotp.c
>> +++ b/drivers/nvmem/imx-ocotp.c
>> @@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned 
>> int offset,
>>   	return ret;
>>   }
>>   -static int imx_ocotp_cell_pp(void *context, const char *id, int 
>> index,
>> -			     unsigned int offset, void *data, size_t bytes)
>> +static int imx_ocotp_cell_pp(const char *id, int index, unsigned int 
>> offset,
>> +			     void *data, size_t bytes)
>>   {
>>   	u8 *buf = data;
>>   	int i;
>> diff --git a/include/linux/nvmem-provider.h 
>> b/include/linux/nvmem-provider.h
>> index 9d22dc5a3fa5..46067a6a0395 100644
>> --- a/include/linux/nvmem-provider.h
>> +++ b/include/linux/nvmem-provider.h
>> @@ -19,8 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned 
>> int offset,
>>   typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>>   				 void *val, size_t bytes);
>>   /* used for vendor specific post processing of cell data */
>> -typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, 
>> int index,
>> -					 unsigned int offset, void *buf, size_t bytes);
>> +typedef int (*nvmem_cell_post_process_t)(const char *id, int index,
>> +					 unsigned int offset, void *buf,
>> +					 size_t bytes);
>>     enum nvmem_type {
>>   	NVMEM_TYPE_UNKNOWN = 0,
