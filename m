Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083A6F05E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbjD0Mf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjD0Mf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:35:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4E420A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:35:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so14583915a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682598922; x=1685190922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0QszDde8nFcOEA4DV9dWez8Vmn1d3+3MQK7HdYNTk0=;
        b=Ca1f7Q8QfwsxqnNXTzClKKFDeAyt7kiBMGkpSXoeJRu1dphQh0I2JCVODSjW04F8vi
         CjTjLl7H2NQ6vkJtEJby5nMlylaSHmZX+3X9P/QBhjFbFR7AEkFC8WLHv7BA7FfE2goN
         upf8jFn7C6RaZo7YWKMh/RG19f+lxewE/y3OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598922; x=1685190922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0QszDde8nFcOEA4DV9dWez8Vmn1d3+3MQK7HdYNTk0=;
        b=VnE6OkzQlEPhMlaLtGHgoga/A/39MgZ5Xm/SXrljMShufh0FiL2KptqymOV0qjyYa0
         0C/ik5YwHVKrK8jYakq0bKAi5S9MOjyNdVvtVfCPsVxIXK5hcT3poOeW7xTFycGaAqoT
         OGrrdvJdDORO6MN43raNisNmgIg+wccwPSjjeMmfmCKQlE0ah1PUHrgMrNGjpNDpfPml
         advQ3hd33e7itY3ts/sW38riGcaSiVe3R3EAMHTD8Z20xmqyGBDTcwBYYlHangOSymiM
         wFHo5PEaaz5/9Fve/LTXhhl5Gl1+0kX5FHG+eM+7PgFEs4iWvL43lroPQmZc14MNJSkR
         VmBw==
X-Gm-Message-State: AC+VfDyP7fjB6REkymk2PE1VGZDOOl4EoDScMRpEbNQyuBpss9CqoXLh
        ugyrnf5veMv2cBBn9gzroTCjy2irIMU4pXVgcRLS2w==
X-Google-Smtp-Source: ACHHUZ7MmYITJ6kQO4xKV6rvxaVEOOg18gzPAiCryL/tpudRIuT0AQEi3mmw5CFBtqHWXygrP5W2qA==
X-Received: by 2002:aa7:c94c:0:b0:505:4f7:8a50 with SMTP id h12-20020aa7c94c000000b0050504f78a50mr1328614edt.5.1682598921957;
        Thu, 27 Apr 2023 05:35:21 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7d054000000b004fc01b0aa55sm7969319edo.4.2023.04.27.05.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:35:21 -0700 (PDT)
Message-ID: <d1a14976-5f53-3373-0695-e10e6a9371de@rasmusvillemoes.dk>
Date:   Thu, 27 Apr 2023 14:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Content-Language: en-US, da
To:     =?UTF-8?Q?Konrad_Gr=c3=a4fe?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>
Cc:     stable@vger.kernel.org
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230427115120.241954-1-k.graefe@gateware.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 13.51, Konrad Gräfe wrote:
> The CDC-ECM specification requires an USB gadget to send the host MAC
> address as uppercase hex string. This change adds the appropriate
> modifier.
> 
> Cc: stable@vger.kernel.org

Why cc stable?

> Signed-off-by: Konrad Gräfe <k.graefe@gateware.de>
> ---
> Added in v3
> 
>  lib/vsprintf.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

The diffstat here, or for some other patch in the same series,
definitely ought to mention lib/test_printf.c.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index be71a03c936a..8aee1caabd9e 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1269,9 +1269,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>  {
>  	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
>  	char *p = mac_addr;
> -	int i;
> +	int i, pos;
>  	char separator;
>  	bool reversed = false;
> +	bool uppercase = false;
>  
>  	if (check_pointer(&buf, end, addr, spec))
>  		return buf;
> @@ -1281,6 +1282,10 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>  		separator = '-';
>  		break;
>  
> +	case 'U':
> +		uppercase = true;
> +		break;
> +
>  	case 'R':
>  		reversed = true;
>  		fallthrough;

This seems broken, and I'm surprised the compiler doesn't warn about
separator possibly being uninitialized further down. I'm also surprised
your testing hasn't caught this. For reference, the full switch
statement is currently

        switch (fmt[1]) {
        case 'F':
                separator = '-';
                break;

        case 'R':
                reversed = true;
                fallthrough;

        default:
                separator = ':';
                break;
        }

> @@ -1292,9 +1297,14 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>  
>  	for (i = 0; i < 6; i++) {
>  		if (reversed)
> -			p = hex_byte_pack(p, addr[5 - i]);
> +			pos = 5 - i;
> +		else
> +			pos = i;
> +
> +		if (uppercase)
> +			p = hex_byte_pack_upper(p, addr[pos]);
>  		else
> -			p = hex_byte_pack(p, addr[i]);
> +			p = hex_byte_pack(p, addr[pos]);

I think this becomes quite hard to follow. We have string_upper() in
linux/string_helpers.h, so I'd rather just leave this loop alone and do

  if (uppercase)
    string_upper(mac_addr, mac_addr);

after the nul-termination.

Rasmus

