Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21648744EBF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGBRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:30:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA3DC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 10:30:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so1039997a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688319026; x=1690911026;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMWgXtpbTtA1G+1qa+Z7tPGIASfGFcwdKE/0BJBZ2dc=;
        b=dGJ27iAvk1G7Y/i9UmgCaTQnBVSBcgRN9iSviNqUSpY39RgRoromzXBkjlUtXCxnSX
         xfl2WHhSMm2WveQ9SXSEIXY2OdSBq2DnK6Zkh2Cki+YCHmmzHRNu9fDFlsItKsd4VDJQ
         2nrU33oTOTOrMW/Tu+pzxPYlDJDusyK8olm5yPjWMqXdQg2H6wRuzLj2l5NN5cOTL9WJ
         Qyc9A8aStbDOh5dNRH9B/2m6YoZK99dDEaW2K5lAIMcA67cK/LBzooJg3yWu8bJP9p4F
         D1qZw4yiT1kmVwlLF6Ul0UZzmJol8FgN8cnq3PA1wQ8CDz/PIpWZ9tQ5c1ZE2q3OLl+y
         YJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319026; x=1690911026;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMWgXtpbTtA1G+1qa+Z7tPGIASfGFcwdKE/0BJBZ2dc=;
        b=hdMgK3jc2FDg+qxurpwnLMy6MIGdFXMvOZU8GSXNCmkXV6pdwfOaThxm5hhpYAa0Tj
         Hv7yBnxZG6ZZkUK0Wq7t9jkbK9M9g6rCVvazYYM5GdAgYo+lyjAxkE10/dAjJOYJ/AaZ
         HPakJL8dqGzfyRCdAiKF4zeoeE8cY5vKZ9ovH/FEDs7e6piWt8CDYfi6nRtRX5DfTsvI
         +C+4I9n0Ko3Fqq/KhZmBqohzwPEYh7vhoBlqQll+WLUSYC3nDX3OkMGpcPBGBvKwi5Xs
         EZagltv44dgBaf6e8RnMAQss9GF6Zu0wp1pAN65kZPEfD+dkb0I/j6d638jPexfdgb+s
         XrKQ==
X-Gm-Message-State: ABy/qLafl6AeXewqHqpIuzQqOZYhWzZzG+Lo1tEXDhF1RUQvJsZWSbTe
        mgLVAWg9u5hPeaxori6HB0Q=
X-Google-Smtp-Source: APBJJlH+/4UCFRfpboo/g9fyMZyZOerQoIXPYfPBtfiHKYF/0jZyQZIMNeHZfHLWGA1l4YCHkfXfnQ==
X-Received: by 2002:a05:6a20:3c88:b0:12d:4c17:bb2d with SMTP id b8-20020a056a203c8800b0012d4c17bb2dmr9014196pzj.26.1688319025901;
        Sun, 02 Jul 2023 10:30:25 -0700 (PDT)
Received: from localhost ([63.142.197.32])
        by smtp.gmail.com with ESMTPSA id i22-20020aa78b56000000b006687198c3easm13199780pfd.179.2023.07.02.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:30:25 -0700 (PDT)
Date:   Sun, 2 Jul 2023 10:30:24 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gavin Shan <gshan@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] bitmap changes for v6.5-rc1
Message-ID: <ZKG0MO5/1SgEobf5@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull bitmap changes for 6.5-rc1. They spent for more than a
week in -next without any issues.

Thanks,
Yury

The following changes since commit dad9774deaf1cf8e8f7483310dfb2690310193d2:

  Merge tag 'timers-urgent-2023-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-06-21 12:36:34 -0700)

are available in the Git repository at:

  https://github.com:/norov/linux.git/bitmap-6.5-rc1 bitmap-6.5-rc1

for you to fetch changes up to 2a3110e3f97ddc0f53bb766797b926a35edd07e6:

  MAINTAINERS: Add bitfield.h to the BITMAP API record (2023-06-22 13:57:42 -0700)

----------------------------------------------------------------
bitmap patches for v6.5

Fixes for different bitmap pieces:

 - lib/test_bitmap: increment failure counter properly

   The tests that don't use expect_eq() macro to determine that a test is
   failured must increment failed_tests explicitly.

 - lib/bitmap: drop optimization of bitmap_{from,to}_arr64

   bitmap_{from,to}_arr64() optimization is overly optimistic on 32-bit LE
   architectures when it's wired to bitmap_copy_clear_tail().

 - nodemask: Drop duplicate check in for_each_node_mask()

   As the return value type of first_node() became unsigned, the node >= 0
   became unnecessary.

 - cpumask: fix function description kernel-doc notation

 - MAINTAINERS: Add bits.h to the BITMAP API record
 - MAINTAINERS: Add bitfield.h to the BITMAP API record

   Add linux/bits.h and linux/bitfield.h for visibility

----------------------------------------------------------------
Andy Shevchenko (2):
      MAINTAINERS: Add bits.h to the BITMAP API record
      MAINTAINERS: Add bitfield.h to the BITMAP API record

Gavin Shan (1):
      nodemask: Drop duplicate check in for_each_node_mask()

Randy Dunlap (1):
      cpumask: fix function description kernel-doc notation

Yury Norov (2):
      lib/test_bitmap: increment failure counter properly
      lib/bitmap: drop optimization of bitmap_{from,to}_arr64

 MAINTAINERS              |  6 ++++++
 include/linux/bitmap.h   |  8 +++-----
 include/linux/nodemask.h |  2 +-
 lib/bitmap.c             |  2 +-
 lib/cpumask.c            |  2 +-
 lib/test_bitmap.c        | 18 +++++++++++++++---
 6 files changed, 27 insertions(+), 11 deletions(-)
