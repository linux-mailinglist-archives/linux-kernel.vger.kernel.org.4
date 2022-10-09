Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5D5F8C5F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJIQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJIQjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:39:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC00C1E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:39:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h185so1517505pgc.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K10cqEZNRqAr4Ah3Zj5uTQYY0fyx/i6nLqRBPmuxKE=;
        b=YGcLzfWnQs+WR6WW8vmMtethQ/84yZTAS/I31DLiVko6nftcbr1AMZEzpgOYJmsEJ/
         AeJdwmqH8ZdkSt/+c8h/JVHCKwkRqweLtVIt1J4v8r65FSBTF07Rq+SCJWcqDkBfSJG0
         LUwftnuhUcTFaDeL+Ak0mOsuBqpe9Wgx1z4TYCN9SWVToJttmlUPbCdNSEYw3BlHtPLK
         Su/lm8krP3VidFsEh+IWbJQF8ojZDqWukRpNA666fy4A/Gzr2o7b2CUJ6zT/qOQNHVGO
         AI4DrNPQ5lVvoqJCKT6JzWPtkP3AxVStoKaMKjqZos20duj1rUNwmXF1Gkf0zkb4fhj6
         7t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K10cqEZNRqAr4Ah3Zj5uTQYY0fyx/i6nLqRBPmuxKE=;
        b=jIcoeAJbM9bt62TupfPQzqjbm3yDQ3NAnlA6oI9kk3ho9wMST+h0QxSTesY43xznnw
         5H3IynjYjUtUcjQ8SiAPGSYkKpPvy/jQlRvEnxSlAdZ3643IeQTjQiQ0t/Ghz7SI5eHW
         OXRnukbJMWlsH9v/90tpESxSmXYNWej3v4+GlU3NdWcxXRuggMstpx0RVBnfULuwSQct
         MBoZG1jTP+k4UNtKsSqSwWTXrWfOE9G97rjeGaND6k3UlDwexcqEsHRMbsYoYPs4j+2k
         W91xBP3FSr1Bij75EE6qVvcDtcno02WRfIY9TH+zLjiECh+qHvM576PFEkgXA5x3wFsB
         btQw==
X-Gm-Message-State: ACrzQf3aUiARFKJPyXdxXci0kCjmXfHTkSGDxtqfE0N24Iz05HPUYRzy
        tznO9KRbVrRZ5AVGlXmW/oY=
X-Google-Smtp-Source: AMsMyM7Dsfo4/STdJ3JtqLkZjtDhbSE733mtcYQ/DQwB70M1uLo2JRsyqV3b1rr9OqSyuGNKKEXyYQ==
X-Received: by 2002:a05:6a00:cd6:b0:546:d03:3dd7 with SMTP id b22-20020a056a000cd600b005460d033dd7mr15572944pfv.19.1665333586343;
        Sun, 09 Oct 2022 09:39:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7842d000000b0056234327070sm5366479pfn.95.2022.10.09.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 09:39:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 9 Oct 2022 09:39:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Message-ID: <20221009163942.GA630814@roeck-us.net>
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 05:08:11PM +0300, Andy Shevchenko wrote:
> Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
> definitions from DT") regmap MMIO parses DT itsef, no need to
> repeat this in the caller(s).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch results in reboot failures for all big endian mips emulations.

Sample log:

Network interface test passed
Boot successful.
Rebooting
reboot: Restarting system
Unable to restart system
Reboot failed -- System halted

The problem is not seen with little endian mips emulations. Reverting
this patch fixes the problem. Bisect log attached.

#regzbot introduced: 72a95859728a
#regzbot title: Reboot failure on big endian mips systems

Guenter

---
# bad: [a6afa4199d3d038fbfdff5511f7523b0e30cb774] Merge tag 'mailbox-v6.1' of git://git.linaro.org/landing-teams/working/fujitsu/integration
# good: [4c86114194e644b6da9107d75910635c9e87179e] Merge tag 'iomap-6.1-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect start 'HEAD' '4c86114194e6'
# bad: [6181073dd6a7e5deafc60e7981bd765b6c93da8c] Merge tag 'tty-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect bad 6181073dd6a7e5deafc60e7981bd765b6c93da8c
# bad: [94e8ca6ebd1bc20a193eb552dee4de884a954938] Merge tag 'rproc-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
git bisect bad 94e8ca6ebd1bc20a193eb552dee4de884a954938
# good: [9d84bb40bcb30a7fa16f33baa967aeb9953dda78] Merge tag 'drm-next-2022-10-07-1' of git://anongit.freedesktop.org/drm/drm
git bisect good 9d84bb40bcb30a7fa16f33baa967aeb9953dda78
# good: [5d435a3f7b6cb1db566d0f56f5f8dc33be0dde69] Merge tag 'media/v6.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 5d435a3f7b6cb1db566d0f56f5f8dc33be0dde69
# bad: [ae9559594cb851aff774d5bea243b84c6acf761d] Merge tag 'mfd-next-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect bad ae9559594cb851aff774d5bea243b84c6acf761d
# good: [834382ea32865a4bdeae83ec2dcb9321dc9489f2] mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
git bisect good 834382ea32865a4bdeae83ec2dcb9321dc9489f2
# good: [2f5b0059b31a3e554cb8c5a40682411a2f53f4d3] Merge branch 'for-6.1/nintendo' into for-linus
git bisect good 2f5b0059b31a3e554cb8c5a40682411a2f53f4d3
# good: [430257d8329b58170a92364597e474fa607e28b2] Merge branch 'for-6.1/uclogic' into for-linus
git bisect good 430257d8329b58170a92364597e474fa607e28b2
# good: [cb7c02e91c31f55d08760f04a09bf9334d809426] Merge branch 'for-6.1/google' into for-linus
git bisect good cb7c02e91c31f55d08760f04a09bf9334d809426
# good: [02010cf0093629b9eeadade1f2684d85eaa3390f] mfd: ocelot-spi: Add missing MODULE_DEVICE_TABLE
git bisect good 02010cf0093629b9eeadade1f2684d85eaa3390f
# bad: [72a95859728a7866522e6633818bebc1c2519b17] mfd: syscon: Remove repetition of the regmap_get_val_endian()
git bisect bad 72a95859728a7866522e6633818bebc1c2519b17
# first bad commit: [72a95859728a7866522e6633818bebc1c2519b17] mfd: syscon: Remove repetition of the regmap_get_val_endian()
