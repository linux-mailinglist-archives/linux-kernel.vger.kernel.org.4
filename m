Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CADB6E96EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjDTOWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDTOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:21:59 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4A61A8;
        Thu, 20 Apr 2023 07:21:51 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so2800703e87.0;
        Thu, 20 Apr 2023 07:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000509; x=1684592509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+ntSNli+3961rRN83tx2G/slCSVpZgHaGQlcoQLCYo=;
        b=lQvPNWJmGGwtMzjPUGq/4D0NzJtsxs6Pmk/NIU6HT6cP5prFQk+0PiqYI0SDNO/8GU
         OJa5elomqh75sR3QgAzuxcoCl+bCo1yCYn6yZJzx20VNceAu9s9SvLMT36sdmxv+7M1p
         zgDtPgEn/DdSBoQ6DenjHIpj4QrbHOEyX3aSid3M8gPt0Jx4+O48mWuDTETlD396jNQh
         AflQnksst//wO3VUBJesN1GJ5BiTWFtc3pCK6IRYXvKPfDSh0jHiR/HOz067iP/LbRj5
         HmhiCosLrVCMwqdrtBlt6ZEM/NbM9xYVLaSL4gyoq3H+1Fmp29JI8Yg/3UINB7ygYRug
         8UOA==
X-Gm-Message-State: AAQBX9eOYiWkaHiVliFZ+0HeZ21fW2RDilChL4akrb5Mt2g4ihznOi58
        XUeElFiUtWfkTOxJuGoV7Bc9INOrsZf3FL2A
X-Google-Smtp-Source: AKy350brUzgFmXIzx22PvebSV88Jle3hfk/pWR/BkKBIgc6ZulxhVjTAOzLVBj8BYjLfG32uEjm7Uw==
X-Received: by 2002:a05:6512:3b9e:b0:4eb:2b62:134f with SMTP id g30-20020a0565123b9e00b004eb2b62134fmr1909742lfv.16.1682000508927;
        Thu, 20 Apr 2023 07:21:48 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q13-20020ac25a0d000000b004ec4f3810dcsm231860lfn.109.2023.04.20.07.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 07:21:47 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so2800576e87.0;
        Thu, 20 Apr 2023 07:21:47 -0700 (PDT)
X-Received: by 2002:ac2:5339:0:b0:4ed:d542:6f65 with SMTP id
 f25-20020ac25339000000b004edd5426f65mr515553lfh.5.1682000507607; Thu, 20 Apr
 2023 07:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230420030500.1578756-1-suijingfeng@loongson.cn>
 <8ec3734b-4bc2-ad8f-fc17-3002f22d1fc9@suse.de> <12c8efaa-7266-5436-dc53-009a0d23b53f@suse.de>
 <4a0fdbe0-cd4f-9c87-f73a-6d27f5c497bb@189.cn> <f541018f-bb7f-ac58-bbb8-797069e49c3f@suse.de>
 <CAMuHMdVGtvgcQuTR9bfMh1cM86TYXSByxJzW5eJtF9A0ZLRF3w@mail.gmail.com> <3d455074-bd51-51a0-7692-a0b4ca961355@suse.de>
In-Reply-To: <3d455074-bd51-51a0-7692-a0b4ca961355@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 16:21:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHMeiaew7wbj-aNL0oZ=X3gfoSBkMYAbbdyfe6bVZcfQ@mail.gmail.com>
Message-ID: <CAMuHMdXHMeiaew7wbj-aNL0oZ=X3gfoSBkMYAbbdyfe6bVZcfQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/fbdev-generic: prohibit potential out-of-bounds access
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-fbdev@vger.kernel.org, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        Sui Jingfeng <15330273260@189.cn>,
        loongson-kernel@lists.loongnix.cn, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Apr 20, 2023 at 2:59 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 20.04.23 um 14:25 schrieb Geert Uytterhoeven:
> > On Thu, Apr 20, 2023 at 1:10 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 20.04.23 um 12:04 schrieb Sui Jingfeng:
> >>> What will happen if the 'screen_size' is not page_size aligned and mmap
> >>> will mapping in the granularity of pages ?
> >>
> >> You need to map at page granularity. If screen_size is not page-size
> >> aligned, there's this trailing buffer that is accessible, but cannot be
> >> displayed. But userspace has no direct way of knowing that, so let's
> >> ignore that problem for now.
> >
> > Userspace can know, if fb_fix_screeninfo.smem_{start,len} match
> > the actual offset and size.
>
> Can you elaborate? How can userspace detect/compute the actually usable
> space?

By looking at fb_fix_screeninfo.smem_{start,len}, which are the (physical)
address and length of the frame buffer.

>  From grep'ing fbdev drivers, smem_len appears to be a multiple of the
> pagesize. (?) screen_size is not exported and line_length in the fixed
>
> portion. Or can line_length change between modes? In that case it should
> be (yres_virtual * line_length), right?

smem_{start,len} are not guaranteed to be page-aligned.
Fbtest[1] and Xorg should handle that fine.

line_length can change between modes.  It's part of fb_fix_screeninfo,
because it's fixed in the sense that it depends on the video mode, and
the user cannot specify its value.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git/tree/fb.c#n199

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
