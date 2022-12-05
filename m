Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D86642506
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiLEItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiLEIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:47:29 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA912AED;
        Mon,  5 Dec 2022 00:47:22 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id d13so7770295qvj.8;
        Mon, 05 Dec 2022 00:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2M6e7vkBDgSrCC9BD3sQ0rLf96pF/miUTqj+QzFjF8=;
        b=Xjf84yQlY9B9OkaQyzv1Xc+KZMInicqMtWob7W2Fv+21t9VTh7lKW4p7e8bkTDpHqe
         8TMurjTFlVcmXA0Mhxm73S09uhRzFqzcTPTg5NUifiQuDaauQFswbj03wn5ES06HnpQH
         QKrHZ+JmajAYKCCgxFtI5RRjNRzIPKZdSRgc+KfQYfeOhFg6bw7RFFjWNvql5K/7DxKn
         Muu4LoPwPWb7oGX+Bz1uov++tz4G/HNrEkiY8RDWIWmvF0uMlLEhNkHH25XVJm6uXWzA
         FUUfn7JFJKn+xSBg5LUxfoxQGJktee+0vx1wtVYTGt9+nJRV306x6MDuNKJJhoSjrdrK
         9s6A==
X-Gm-Message-State: ANoB5pnspsR7jZcsNfC4rNvT/00nn8gdWioViVn5fElAcUL7A2990NAt
        iX15AiyMGjTKB4Ru5nKna82n8G1tB0g9hQ==
X-Google-Smtp-Source: AA0mqf5Iz5Nx47mEecPSSU3TV2eHM6F0xJ4pE3Di3AxxrC1MvSbVkaPup92Pfntik9xL9plfiTthHQ==
X-Received: by 2002:a0c:edc2:0:b0:4b4:4a3e:d20c with SMTP id i2-20020a0cedc2000000b004b44a3ed20cmr57514363qvr.112.1670230041199;
        Mon, 05 Dec 2022 00:47:21 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a440f00b006fc2b672950sm12515423qkp.37.2022.12.05.00.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 00:47:20 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3c090251d59so110827697b3.4;
        Mon, 05 Dec 2022 00:47:20 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr60999579ywb.47.1670230040599; Mon, 05
 Dec 2022 00:47:20 -0800 (PST)
MIME-Version: 1.0
References: <202212051631391777945@zte.com.cn>
In-Reply-To: <202212051631391777945@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Dec 2022 09:47:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=ryCjskpYeh8vCo+ZUapuNBNFS22JktxARy+1XgSEtQ@mail.gmail.com>
Message-ID: <CAMuHMdV=ryCjskpYeh8vCo+ZUapuNBNFS22JktxARy+1XgSEtQ@mail.gmail.com>
Subject: Re: [PATCH linux-next v3] fbdev: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     deller@gmx.de, javierm@redhat.com, tzimmermann@suse.de,
        geert+renesas@glider.be, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

Thanks for your patch!

On Mon, Dec 5, 2022 at 9:31 AM <ye.xingchen@zte.com.cn> wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
> v2 -> v3
> Fix the mistakes in v2.

Indeed, that's usually what a v3 does ;-)
It would help if you listed the actual changes instead.

But "b4 diff 202212051631391777945@zte.com.cn" doesn't show any?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
