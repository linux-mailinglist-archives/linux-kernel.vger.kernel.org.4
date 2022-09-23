Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778C15E848F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIWVE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIWVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:04:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEC2F3B6;
        Fri, 23 Sep 2022 14:04:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lh5so3071282ejb.10;
        Fri, 23 Sep 2022 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=91mEpspGROP1Bxnk32+FmTIuy+A9uYPDvsM5BjwIlj8=;
        b=gEdnve3pkxAhEmVpz7ZPRVM9Tn5sR8zT98UZCGv/Zi7KbuhGPpaZebclX7GKHU3M3m
         OnSrpCb2ZGGfcNSl8joN/E0WoIUwDwxnaALTjL17rWhrQo8Xz8SImW6B+lp11n//N5PV
         kAdCOViLjESwaZQGRHFjxb9qiktbR1SRbpc/oRXONLIzzq1VnxGAVH+o62jl1WOJNLqv
         +1DfERTWC/ptN8BwVDjp5Z0wcXpxwausPew1mDlcFwVI8izn5cyTnQoMkTvEZkipznkI
         +B/pmNdTykePLF7Qd6V8u+iUcNWfJWnFBGA5g294rc08Bk1P+vUsRlmKVGslfSK3lC5Y
         LOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=91mEpspGROP1Bxnk32+FmTIuy+A9uYPDvsM5BjwIlj8=;
        b=tRR8+Whqi+WFlFv28Mrg6FDakQfT13da2CWpgZ4PeAR8WyB9Zykwm9hJYJaf6EeRQX
         nIh0owHrtZ3uTchCn+4IGVAIRM4TURUM1zPoHCN5j4vgKylL/BQzLM3wsz8joX4QK7qZ
         1d6x3xGbiZVkEBUA/QJSs646T+c6rcNoKzW2U0GyQ4SEKfuttKbAqjBwbrmVrO5eWsvZ
         Hjfdc2mZAxK/ZJrGCegvCN1eK6lyn00UtW1tD9w27J4kSS/7c4xCCNIqQ0o89PRnRvB9
         85W8N8GKZcdm9xTk4dMlQ1qCRr9yakYc2zHxeAvBCzG+L1Iz4LdGj0Hm7stxPho1DIjB
         Sp/Q==
X-Gm-Message-State: ACrzQf3w+ZATowZCEGVnyj7NALTntIqNtZGKSmTgsW8S39cqOMg+YraJ
        VQBUJWqMoCJ1C2kzYQ9NMNYjF4eFZhSvjjcbNbMFtS1tTF4YeBM8
X-Google-Smtp-Source: AMsMyM4A0M7KpFrWdBk4LCa/jQmEJHACVjTrtZlrJFE/r2Mw9PaOJ+A2VJenx2dA6NQArbwZOMArzWP6wtYSOvJEEh0=
X-Received: by 2002:a17:906:4fd2:b0:781:320f:b779 with SMTP id
 i18-20020a1709064fd200b00781320fb779mr8561180ejw.59.1663967090140; Fri, 23
 Sep 2022 14:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220923063533.239315-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220923063533.239315-1-ye.xingchen@zte.com.cn>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 23 Sep 2022 14:04:38 -0700
Message-ID: <CAPOBaE6-GjJBPb4k0aM3w-xuL0ZEEqF2RYrjVu1+oHkH8ijAgQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] backlight: lp8788: use sysfs_emit() to instead
 of scnprintf()
To:     cgel.zte@gmail.com
Cc:     lee@kernel.org, daniel.thompson@linaro.org, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han


> ---
>  drivers/video/backlight/lp8788_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
> index ba42f3fe0c73..00d79c0cfee9 100644
> --- a/drivers/video/backlight/lp8788_bl.c
> +++ b/drivers/video/backlight/lp8788_bl.c
> @@ -240,7 +240,7 @@ static ssize_t lp8788_get_bl_ctl_mode(struct device *dev,
>         else
>                 strmode = "Invalid mode";
>
> -       return scnprintf(buf, PAGE_SIZE, "%s\n", strmode);
> +       return sysfs_emit(buf, "%s\n", strmode);
>  }
>
>  static DEVICE_ATTR(bl_ctl_mode, S_IRUGO, lp8788_get_bl_ctl_mode, NULL);
> --
> 2.25.1
