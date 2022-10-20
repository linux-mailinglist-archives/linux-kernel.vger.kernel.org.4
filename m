Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAA6055E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJTDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:22:44 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3B1D2B54
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:22:43 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso23078922fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZo2P0btegWzJjzezfawR0r1cS5ypDKFjzgQbfC4/vQ=;
        b=XB/FWk7GqUsa9t0mEGZQrGtNDBVz24LAJAge3DYogCxHXy9qgpHxwopFhZO2US4vQc
         aZTz1DPlSinA0LEC4Sa00ZTxeh/0HHs8U+W52L2C1c5y5e8GM07o5fBXhECIzVcZPBCa
         P9MAaSckHuZJS8aJ0mORgERwKUiFDe8ZwfAXJ2nV5F/IybzbIs7xmOkgM/UbjxcWBUZA
         si/EEMGGuLQU+sangBokqcTPuldoXiOGkVGx+iLkMw3op+Qf8JWLy426CMIi6B4bqVqX
         dVDFnn8vVv8AbfAm13EurfhSOdeecbOc5FExU66tymM7vBcUyHH3NYXwouxZ2gvOj81o
         92Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZo2P0btegWzJjzezfawR0r1cS5ypDKFjzgQbfC4/vQ=;
        b=2XgNEe9eHrd/hN6S/RJA/I4MBlqHH7GyQi+IU2pZbG8N+Z2hbrtiS89Bmjubi3cbl/
         xbhAXTl6LP+wfCp2jkKiPL1hybW0lg7gN7Wxn8c1EAuK2uBdSn1eIrih4zJrWwW/OHNm
         wEbT5oWfw1wS8W7PA00pdb5wFm1ijT5uIyR5ZaesTDrAMvLcuQlVrsJmXfEd6F7yN2U7
         TBC91oMUkm9GPKYQsTRs/LEQDRS5dvjAVeYjvaRTQ+xyOt+MCYhiD4A6cryk9+pBcMX7
         0hmygV94etI90sPxVkccHTaZs8+SEqQEwXj0j4OwcRLyYBcsHHpbZpeiPdvb+Z5xqEJV
         RUGw==
X-Gm-Message-State: ACrzQf12a7S1SgQ7jTXdaBMDc9tOvb/E44NqGDB4xsyJTg1TtUtIXDrb
        rHCvnHnrUhqYSkgQ1ir21gE=
X-Google-Smtp-Source: AMsMyM4AaB2l+THPi7j2p1SeZ7w0ABcLBVqTmvJey6coQB8VRdU/jFmzlPitgDAYh2l3ZasYT5WKAQ==
X-Received: by 2002:a05:6870:41ca:b0:12b:9637:1cda with SMTP id z10-20020a05687041ca00b0012b96371cdamr7307113oac.114.1666236162649;
        Wed, 19 Oct 2022 20:22:42 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id a19-20020a056808129300b00354b619a375sm7596815oiw.0.2022.10.19.20.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 20:22:42 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 0/2] Switch ARM to generic find_bit() API
Date:   Wed, 19 Oct 2022 20:20:22 -0700
Message-Id: <20221020032024.1804535-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell, all,

I'd like to respin a patch that switches ARM to generic find_bit()
functions.

Generic code works on par with arch or better, according to my
testing [1], and with recent improvements merged in v6.1, it should
be even faster.

ARM already uses many generic find_bit() functions - those that it
doesn't implement. So we are talking about migrating a subset of the
API; most of find_bit() family has only generic implementation on ARM.

The only concern about this migration is that ARM code supports
byte-aligned bitmap addresses, while generic code is optimized for
word-aligned bitmaps.

In my practice, I've never seen unaligned bitmaps. But to check that on
ARM, I added a run-time check for bitmap alignment. I gave it run on
several architectures and found nothing.

Can you please check that on your hardware and compare performance of
generic vs arch code for you? If everything is OK, I suggest switching
ARM to generic find_bit() completely.

Thanks,
Yury

[1] https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/

Yury Norov (2):
  bitmap: add sanity check function for find_bit()
  arm: drop arch implementation for find_bit() functions

 arch/arm/include/asm/bitops.h |  63 -----------
 arch/arm/kernel/armksyms.c    |  11 --
 arch/arm/lib/Makefile         |   2 +-
 arch/arm/lib/findbit.S        | 193 ----------------------------------
 include/linux/find.h          |  35 ++++++
 lib/Kconfig.debug             |   7 ++
 6 files changed, 43 insertions(+), 268 deletions(-)
 delete mode 100644 arch/arm/lib/findbit.S

-- 
2.34.1

