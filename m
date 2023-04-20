Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF26E9435
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjDTMZd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjDTMZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:25:31 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4A8F;
        Thu, 20 Apr 2023 05:25:29 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id a11so2083236ybm.3;
        Thu, 20 Apr 2023 05:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993529; x=1684585529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXInmwaqBbfh6VGdRfeo5HdvJy20M73WF7/BcwOEW+c=;
        b=EdUCnQscPSboIGILIq2tKhbETz1HKNgnjL0hwA4jDTqD/YXSCrUYUmHlmt25ED5546
         upL4UnPt1frbp83O/V6hsqLKOaDxCBsQIUrRXL3DY6QzWz2Rogkw2UerayfuoQ65VNg1
         fK6VZMMdMIIxNQePVe2B6suJknqDYMv2dDQgvE+TQ3HtZMjB3XGrEUfDNclvkWI6aqFy
         19wVHqdx4bPDb949xpNWOCFEdskRzip/oggqCZz6a6iJwvlgmLcGT4hxcQSfGXAFEx/o
         aPfXsVf2GF1cyJuMJtMLornW6pQ9ZQyf/8hj9+sM/VOnogRPCaoFL+7MinAi8XaJ46iG
         oi7Q==
X-Gm-Message-State: AAQBX9easeFVuawVXedMQEe/tKn3A3QyJTrj2mKXIZvYmEe6uYwaLQHo
        2r1gqOl/sjmhIc2L+holm28EE8qBGoL01hi3
X-Google-Smtp-Source: AKy350YABQHgHqkbP+96QBb4a+NxXfG21E6i/be8k8IWUeJ3Yr+y+4jHRMG0DKeUToy9ljG8uH23Dw==
X-Received: by 2002:a25:5091:0:b0:b92:6588:b07e with SMTP id e139-20020a255091000000b00b926588b07emr1219468ybb.19.1681993528848;
        Thu, 20 Apr 2023 05:25:28 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id u73-20020a0deb4c000000b0054605c23114sm302234ywe.66.2023.04.20.05.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 05:25:28 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-555e170df98so37655757b3.10;
        Thu, 20 Apr 2023 05:25:27 -0700 (PDT)
X-Received: by 2002:a0d:eb41:0:b0:555:d531:fdf3 with SMTP id
 u62-20020a0deb41000000b00555d531fdf3mr634121ywe.32.1681993527822; Thu, 20 Apr
 2023 05:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230420030500.1578756-1-suijingfeng@loongson.cn>
 <8ec3734b-4bc2-ad8f-fc17-3002f22d1fc9@suse.de> <12c8efaa-7266-5436-dc53-009a0d23b53f@suse.de>
 <4a0fdbe0-cd4f-9c87-f73a-6d27f5c497bb@189.cn> <f541018f-bb7f-ac58-bbb8-797069e49c3f@suse.de>
In-Reply-To: <f541018f-bb7f-ac58-bbb8-797069e49c3f@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 14:25:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGtvgcQuTR9bfMh1cM86TYXSByxJzW5eJtF9A0ZLRF3w@mail.gmail.com>
Message-ID: <CAMuHMdVGtvgcQuTR9bfMh1cM86TYXSByxJzW5eJtF9A0ZLRF3w@mail.gmail.com>
Subject: Re: [PATCH v5] drm/fbdev-generic: prohibit potential out-of-bounds access
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        loongson-kernel@lists.loongnix.cn, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, Apr 20, 2023 at 1:10 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 20.04.23 um 12:04 schrieb Sui Jingfeng:
> > What will happen if the 'screen_size' is not page_size aligned and mmap
> > will mapping in the granularity of pages ?
>
> You need to map at page granularity. If screen_size is not page-size
> aligned, there's this trailing buffer that is accessible, but cannot be
> displayed. But userspace has no direct way of knowing that, so let's
> ignore that problem for now.

Userspace can know, if fb_fix_screeninfo.smem_{start,len} match
the actual offset and size.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
