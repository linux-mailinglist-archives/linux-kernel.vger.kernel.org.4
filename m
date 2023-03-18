Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B796BFB05
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjCROw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCROw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8AD30190
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679151094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ric6rrq7vGEm9xb0r4Sa8eTDN4DF7YKXYHcMI7FI7XE=;
        b=OO8kmj5J7MzkhevLqNTe0LgYaTh9ceUzKbnXNuY/Lc4s3SdQvtUuaC/LctdebTASz22dw6
        dVF6sNgxpKHRhHsotyWe7+TBaRDWgS2XAYcCKgp/xt9X/RX4drOW0dNtAqYoYNLxUxb1Ks
        0QIAy82O1ybz6MPX79h5sNcbkCRtPFo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Bas46kstOzC-Tk1ocaeNVw-1; Sat, 18 Mar 2023 10:51:33 -0400
X-MC-Unique: Bas46kstOzC-Tk1ocaeNVw-1
Received: by mail-qv1-f70.google.com with SMTP id e1-20020a0cd641000000b005b47df84f6eso4284447qvj.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151092;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ric6rrq7vGEm9xb0r4Sa8eTDN4DF7YKXYHcMI7FI7XE=;
        b=3wSCLCjmXUj8uwvtEokPQqTj/9jt9Vacr1T3kOkGQAKThJDB3cc0nY++aFKagYgg/v
         smyn2xu2tPLb00xsC7zRQhpoQQFVsHLTajOpzofLheCuJKMFupCTCqOL3bWqG/dsNKnc
         00WSns+UxzNpyC18e3qDfM3os1VDQuJuLwJNBQFwc5Zr2nyLQO20kaFQDra6LVlJUnCo
         bgw6lBBoDRg04anB1svuHgBAIe6AQQ7DUv5AQOsTm69hGcbDCWXhHjIc2AZ6J2exyk89
         DaNsHTPRe4GHqs49bjAmhndeWzAZ4WyY66qZjk0v7tkrtYBtoElf7SrnBDE+eSZIPKBc
         YPcQ==
X-Gm-Message-State: AO0yUKWLcz9Zbn3YeAaPt1juhltxJH2QmeuDGI4f1xHeVDAy1LHHdhBe
        GV81zeZjAHP9B9jK0ekPzAZUWetv0hPD9j2H1IiY1fodfC4N9IX0IVLGOrugFeE5V04LYcfibsJ
        ZW+ofpVdUVKcH53KMJC+IdV5CrJUJMvOGM4be+S8aMlfAGuf0HurHzimpLkQmbW2/NmDxSE61Pd
        GY9tM=
X-Received: by 2002:ac8:7dc6:0:b0:3bf:e05a:f2f2 with SMTP id c6-20020ac87dc6000000b003bfe05af2f2mr17551042qte.31.1679151092555;
        Sat, 18 Mar 2023 07:51:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ZDp5u9lmhVI2qPCcpmBGFzfulEDfgCvtscb10T98V7E/KIdzQazhy7kKih42X2QbSVFfU5g==
X-Received: by 2002:ac8:7dc6:0:b0:3bf:e05a:f2f2 with SMTP id c6-20020ac87dc6000000b003bfe05af2f2mr17551007qte.31.1679151092223;
        Sat, 18 Mar 2023 07:51:32 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n185-20020a3740c2000000b007402fdda195sm3729155qka.123.2023.03.18.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 07:51:31 -0700 (PDT)
Subject: Re: [PATCH] serial: imx: remove unused imx_uart_is_imx* functions
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230317205710.1672232-1-trix@redhat.com>
 <20230318143041.n6rymackf6p776rq@pengutronix.de>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b5c61356-02e8-76f1-3e2c-9388aa18462c@redhat.com>
Date:   Sat, 18 Mar 2023 07:51:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230318143041.n6rymackf6p776rq@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/23 7:30 AM, Uwe Kleine-König wrote:
> On Fri, Mar 17, 2023 at 04:57:10PM -0400, Tom Rix wrote:
>> clang with W=1 reports
>> drivers/tty/serial/imx.c:292:19: error:
>>    unused function 'imx_uart_is_imx21' [-Werror,-Wunused-function]
>> static inline int imx_uart_is_imx21(struct imx_port *sport)
>>                    ^
>> drivers/tty/serial/imx.c:297:19: error:
>>    unused function 'imx_uart_is_imx53' [-Werror,-Wunused-function]
>> static inline int imx_uart_is_imx53(struct imx_port *sport)
>>                    ^
>> drivers/tty/serial/imx.c:302:19: error:
>>    unused function 'imx_uart_is_imx6q' [-Werror,-Wunused-function]
>> static inline int imx_uart_is_imx6q(struct imx_port *sport)
>>                    ^
>> These static functions are not used, so remove them.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Funny, is_imx6q_uart() was introduced in
> a496e6284c482555db8078190bb689594d129fa9 and never used. Since that
> commit is_imx21_uart() also unused. And the imx53 variant was also never
> used.
>
> Looking at that a bit more, the following cleanup is also possible (only
> compile tested):
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8308a23c55a7..a38ee0ed2210 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -178,8 +178,6 @@
>   enum imx_uart_type {
>   	IMX1_UART,
>   	IMX21_UART,
> -	IMX53_UART,
> -	IMX6Q_UART,
>   };
>   
>   /* device type dependent stuff */
> @@ -241,30 +239,21 @@ struct imx_port_ucrs {
>   	unsigned int	ucr3;
>   };
>   
> -static struct imx_uart_data imx_uart_devdata[] = {
> -	[IMX1_UART] = {
> -		.uts_reg = IMX1_UTS,
> -		.devtype = IMX1_UART,
> -	},
> -	[IMX21_UART] = {
> -		.uts_reg = IMX21_UTS,
> -		.devtype = IMX21_UART,
> -	},
> -	[IMX53_UART] = {
> -		.uts_reg = IMX21_UTS,
> -		.devtype = IMX53_UART,
> -	},
> -	[IMX6Q_UART] = {
> -		.uts_reg = IMX21_UTS,
> -		.devtype = IMX6Q_UART,
> -	},
> +static const struct imx_uart_data imx_uart_imx1_devdata = {
> +	.uts_reg = IMX1_UTS,
> +	.devtype = IMX1_UART,
> +};
> +
> +static const struct imx_uart_data imx_uart_imx21_devdata = {
> +	.uts_reg = IMX21_UTS,
> +	.devtype = IMX21_UART,
>   };
>   
>   static const struct of_device_id imx_uart_dt_ids[] = {
> -	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
> -	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_devdata[IMX53_UART], },
> -	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
> -	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
> +	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_imx21_devdata, },
> +	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_imx21_devdata, },
> +	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_imx1_devdata, },
> +	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_imx21_devdata, },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
>
> If you feel like squashing that into your commit or put it into a
> separate commit with a nice commit log (after convincing yourself that
> the change is fine), feel free to do so.
>
> If you don't:

My interest is not in imx specifically, but rather cleaning up all the 
unused functions.

I _think_ I can get the list of around 70 down to around 10 but it will 
take a while.

Tom


>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>

