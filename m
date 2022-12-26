Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09716562D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLZNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:22:08 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F487108E;
        Mon, 26 Dec 2022 05:22:08 -0800 (PST)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ngdjq4r8HzDqLj;
        Mon, 26 Dec 2022 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1672060927; bh=vEYts1uMHyn4/h2FyWsp/C9eLztnREVMaaqa0shY+YE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U9ATEQLEKlBv0rJ82ll+3zsWcQKWbbiC0QwYHzIRcQYAiaRo60jlZVtiKjO12Brf1
         XFwI6+DK0DTybVuYSAJe/NINCxgC5k0GoPDI0oEEff0YDpYxSsqTyEnpL8MhTNgIdi
         lgBhn7xPsYASrF0H2b4Dm/OFqLd9xcycmZotD/zQ=
X-Riseup-User-ID: 01D9A1F4E75E980968F1411AAE4D9A50DB0BF7FB0060C386A51B1181B5729B22
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ngdjn5rMBz5vtm;
        Mon, 26 Dec 2022 13:22:05 +0000 (UTC)
Message-ID: <6cf1bb06-86b5-2c55-aec2-e2c414a05b66@riseup.net>
Date:   Mon, 26 Dec 2022 10:22:02 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] HID: uclogic: Use KUNIT_EXPECT_MEMEQ
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, mairacanal@riseup.net,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221226125736.18053-1-jose.exposito89@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20221226125736.18053-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 09:57, José Expósito wrote:
> Commit b8a926bea8b1 ("kunit: Introduce KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ macros") introduced a new macro to compare blocks of
> memory and, if the test fails, print the result in a human friendly
> format. For example, this is the output of a test failure:
> 
>   Expected res == params->expected, but
>       res ==
>        01  02  aa  00  00  00  03  bb  00 <00> 00  04  05
>       params->expected ==
>        01  02  aa  00  00  00  03  bb  00 <01> 00  04  05
> 
> Use this new macro to replace KUNIT_EXPECT_EQ + memcmp.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> ---
>   drivers/hid/hid-uclogic-rdesc-test.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
> index b429c541bf2f..90bf4e586e01 100644
> --- a/drivers/hid/hid-uclogic-rdesc-test.c
> +++ b/drivers/hid/hid-uclogic-rdesc-test.c
> @@ -197,8 +197,7 @@ static void hid_test_uclogic_template(struct kunit *test)
>   					   params->param_list,
>   					   params->param_num);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
> -	KUNIT_EXPECT_EQ(test, 0,
> -			memcmp(res, params->expected, params->template_size));
> +	KUNIT_EXPECT_MEMEQ(test, res, params->expected, params->template_size);
>   	kfree(res);
>   }
>   
