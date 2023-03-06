Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD96AC7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCFQYM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 11:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCFQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:23:33 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81772A5;
        Mon,  6 Mar 2023 08:22:12 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id bk32so7441131oib.10;
        Mon, 06 Mar 2023 08:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678119639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mupyAyevtyw777NCln3ZN8/0+T6wpA1bTYPrDt/CRuI=;
        b=50QnuEUqBeNHikUseouP2vP/iBZsEM3nKIY5nIfU9YrzAmk3nQMxQnJ/xMXcVsDnD9
         pYGjqSvmn85stmeHSqIKoq0sobzFFcuO+YKwNHNId/WV1+ruC2UQHpj/vvl0WMUD2XvO
         j8EDdKCBwpmSSGTyXigy4fFpztXdA4oLXF3vmyhcMDjiP6Ow4453EthNSe8OYKj+3zcY
         QE/FoOyFWT1WcAOu/5nXbXtciT6oUn7I7/ERp+aOtvnJ3serULj1+2cyfKTrEvIiI4iw
         GGE+PZu5PDedyCe3WVY9DVkA/VigB8PBBz91cEXFXa0aB2mW8AYCvyQnbW6JX1ta+DCE
         etfQ==
X-Gm-Message-State: AO0yUKVyVOUtws71wsvX+RRqaYi14mG0+2sT4sn0UrtBXR8VjtSnuRQO
        iMFUUFnUYdbO1wwZaXN6gJESVmpZylDF5Q==
X-Google-Smtp-Source: AK7set8UAU+KItRxBGyr0qHHIdmVXj93pjZrIF0CuNssDBoZeFJ2wK0HnNJ/jyFKqt77s8rJEDCVHw==
X-Received: by 2002:a05:6808:b2a:b0:37f:acda:9668 with SMTP id t10-20020a0568080b2a00b0037facda9668mr6432393oij.12.1678119638904;
        Mon, 06 Mar 2023 08:20:38 -0800 (PST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id r64-20020acac143000000b0037834b1a20bsm4171130oif.0.2023.03.06.08.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 08:20:38 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-17671fb717cso10427795fac.8;
        Mon, 06 Mar 2023 08:20:38 -0800 (PST)
X-Received: by 2002:a5b:18e:0:b0:967:f8b2:7a42 with SMTP id
 r14-20020a5b018e000000b00967f8b27a42mr5167551ybl.7.1678119226571; Mon, 06 Mar
 2023 08:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20230306160016.4459-1-tzimmermann@suse.de> <20230306160016.4459-12-tzimmermann@suse.de>
In-Reply-To: <20230306160016.4459-12-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 17:13:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDr19p3GtR4n_hJAtc_RX+VJwVfU1Mzvtka9er+WS8bg@mail.gmail.com>
Message-ID: <CAMuHMdVDr19p3GtR4n_hJAtc_RX+VJwVfU1Mzvtka9er+WS8bg@mail.gmail.com>
Subject: Re: [PATCH 11/99] fbdev/aty: Duplicate video-mode option string
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for your patch!

On Mon, Mar 6, 2023 at 5:00 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Assume that the driver does not own the option string or its substrings
> and hence duplicate the option string for the video mode. The driver only
> parses the option string once as part of module initialization, so use
> a static buffer to store the duplicated mode option. Linux automatically
> frees the memory upon releasing the module.

Are you sure about that?
All of this code is inside "#ifndef MODULE".
In the aty128fb case, the function is not marked __init.
Enabling these 3 drivers adds 3x256 bytes of static buffer, more
if you enable more fbdev drivers.

> Done in preparation of switching the driver to struct option_iter and
> constifying the option string.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -1723,7 +1723,17 @@ static int aty128fb_setup(char *options)
>                         continue;
>                 }
>  #endif /* CONFIG_PPC_PMAC */
> -               mode_option = this_opt;
> +               {
> +                       static char mode_option_buf[256];
> +                       int ret;
> +
> +                       ret = snprintf(mode_option_buf, sizeof(mode_option_buf), "%s", this_opt);
> +                       if (WARN(ret < 0, "aty128: ignoring invalid option, ret=%d\n", ret))
> +                               continue;
> +                       if (WARN(ret >= sizeof(mode_option_buf), "aty128fb: option too long\n"))
> +                               continue;
> +                       mode_option = mode_option_buf;
> +               }
>         }
>         return 0;
>  }
eturn 0;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
