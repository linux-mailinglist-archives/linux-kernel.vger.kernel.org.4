Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147D768042E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjA3DIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjA3DIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:08:20 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C7E65A6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:07:55 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16332831ed0so13483326fac.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDdsLGnbwjXMf6AAv2TZ1fTBXdcA4ZARN+cATS/kf4A=;
        b=vY7vTFz9x2gbNxpfwfYkDN6V/AbZkZhiG1QbWcJLgx+PvzL5st+K7Hjd8J6jJMM00I
         4wWONZJw8kHIKaApTfB5RrvSq9Y5B6iFsvAWJ/m5dkopLFQybmXZMJQVq4Ah4SVBKzX8
         gHwwvf/i/NOy4adxSK3HX3Qhk0KElfHKKylxaf7lAgz2w3w9HTVrMPMV0n0n/umwVlmM
         Tv0DLXTiOUpddCYbUPERocb4DX/XumjBNiNU28qyACTCirOvVkjHxnFvl3vC00UPHHO5
         OPiw4mco6+/d834icvuvx5lQWFMaZBTNmkcIzvlobE6nopwZjPnV0Zna91Wwgw79TS7K
         oBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDdsLGnbwjXMf6AAv2TZ1fTBXdcA4ZARN+cATS/kf4A=;
        b=smMb1YEWufSZrSnnGCh3p+p7SXvvFXJhBbEOwFJJ0aoCMaR0WPsuzZSB7CNrm9jzNL
         ZAghj37c7Hgkckyq8MJpz6cNMC+RtmRAA/8CxI1TKPGooJQIzjpiqZZNHYMiQVlKebBF
         hnjLdw3Zk+KC8C66pMe0wvcfXnFGhNeL8mDE+zrMhi/SDyDVIWlU0ZVz/V0KxpzU8S4T
         ai5X4dfNUk4UPFuM144xrtB+hdTQv6nI1RonkgJ4SzfRoQUsTzBjFvJtDdYimK1UGPbF
         zZh/KoZknAqEdIXPXgigf44BT3SqAHTGuSnASSSHguVDjlZkdTYq3WVY4getZIL9FVww
         oFHw==
X-Gm-Message-State: AO0yUKWIo9jVPTgmGH4UdRJ/dKYwODKhMtBRhQl3hwKxlorncvCHU6TQ
        41NJ5M45llFE63iIy/ABlnBjDQ==
X-Google-Smtp-Source: AK7set+Hkm+FishLKI9RCflN+QwH3Spm8xjGJPBUNA9GCvyx2OXOZGFjWMzERaYlYsBo9wDtqhP1iA==
X-Received: by 2002:a05:6871:b11:b0:163:a45a:9fe1 with SMTP id fq17-20020a0568710b1100b00163a45a9fe1mr2226437oab.2.1675048073779;
        Sun, 29 Jan 2023 19:07:53 -0800 (PST)
Received: from [192.168.10.175] ([190.106.125.239])
        by smtp.gmail.com with ESMTPSA id ld24-20020a0568702b1800b00163b3472300sm837588oab.2.2023.01.29.19.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:07:52 -0800 (PST)
Date:   Mon, 30 Jan 2023 00:07:41 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v5 1/2] media: verisilicon: Do not change context bit
 depth before validating the format
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Message-Id: <TC3APR.E9HSCZZ5SCPF@vanguardiasur.com.ar>
In-Reply-To: <20230127092126.318268-2-benjamin.gaignard@collabora.com>
References: <20230127092126.318268-1-benjamin.gaignard@collabora.com>
        <20230127092126.318268-2-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Jan 27 2023 at 10:21:25 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> It is needed to check if the proposed pixels format is valid before
> updating context bit depth and other internal states.
> Stop using ctx->bit_depth to check format depth match and return
> result to the caller.
> 
> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---

..

>  	 */
>  	if (ctx->is_encoder)
> -		hantro_reset_raw_fmt(ctx);
> +		hantro_reset_raw_fmt(ctx, 0);


Explicit is better than implicit.

Please replace the "0" to imply default, and instead
pass HANTRO_DEFAULT_BIT_DEPTH explicitly.

Thanks!
> 


