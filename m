Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32D5BBB36
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIRDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIRDHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:07:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C672F27159
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:19 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d17so17666113qko.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xr5lvIEWCYm2deAgxuTo7u098jzW6t/xagXaYeIqBCw=;
        b=mMppUa/z/IENMaM2hZfHFXOTAYE+CysPF/jIpxdtgHUtBKuX/0uPITxJZ/YRFE9API
         63K5886gefIpumL1XIpOPFQOU3WSZWZ47r9pdBpONka7a6AugrHhfZCXZJSd8klqvBlr
         mqkc0IeEB9nBhfbS72kASVAhXPIy1/Vp1ETx3E+0C+gQ9PYk++EFh0YDb5Axp0xFRPJ2
         9Eh4IdGVWpZRVJg9/LGIUxI8GkTdr9AlHx5w/+Yy77EvIhePPSlw8ql27Cl83GKlnOcC
         snlTBx1eIh75M3LtTUcOBjNlMaobF5EYRqrn0TMCRmqLDHIw0Nz6wjbRi4UO2OxrmLRL
         m6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xr5lvIEWCYm2deAgxuTo7u098jzW6t/xagXaYeIqBCw=;
        b=rS97hbPT/JGmMmLRg73VlPd7Fvzp++DIL9oJtr+Jv82QDIS24ceVCnFKAaR0X6v3mZ
         We5/aG0KeqykMRV968TNS9o5rjbTlMh2jIJu5/6fTgcK9th6vPwRiNffBxaEtkm6AjtB
         eGnaq2VIioHdt1L7MJMCbg4fA9/g5sQXc9MQk2Ojp++i4SzWGbM2yzJU0irwR2Cg3VJ8
         nYbJBGwBiq9kDwHX/2ZOBvNjmk2aOd3CmFACE3Reqo1o3SlViR85RGM4FO/neNdn4rCt
         7UrKmjE+TbKL8Nf8zM5nf04nOEJ4F/TLTDTcBfZU7GbnjnAyCnWSVsBfMBZuNxmBvoOw
         8jpQ==
X-Gm-Message-State: ACrzQf1TUs126RhS8NYY873fyvfpfEy7lwnlk/UztsqrWYBz8rAMb0WO
        n5reGPGA40/ctU0dTt/Ns7LKvLPBcxo=
X-Google-Smtp-Source: AMsMyM7Q3UMWccnv7FFhYFGSeKmrUj69inEvIeIUMvmTuLoY8/IQNCaW3VanxooBe8OllyM6+V6WuQ==
X-Received: by 2002:a05:620a:892:b0:6ce:3d8e:3a58 with SMTP id b18-20020a05620a089200b006ce3d8e3a58mr8924108qka.133.1663470438690;
        Sat, 17 Sep 2022 20:07:18 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:a495:2224:867e:566a])
        by smtp.gmail.com with ESMTPSA id q50-20020a05620a2a7200b006ce2c3c48ebsm9871817qkp.77.2022.09.17.20.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:07:18 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 0/5] lib/find: add find_nth_bit()
Date:   Sat, 17 Sep 2022 20:07:10 -0700
Message-Id: <20220918030716.1252285-1-yury.norov@gmail.com>
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

Kernel lacks for a function that searches for Nth bit in a bitmap.
Usually people do it like this:
  for_each_set_bit(bit, mask, size)
          if (n-- == 0)
                  return bit;

Which is not so elegant and very slow.

This series adds fast routines for this task, and applies them where
appropriate.

v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
v2: https://lore.kernel.org/lkml/CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com/T/
v3:
 - add bitmap_weight_and() and use it in cpumask_local_spread();
 - rework find_nth_bit() family: similarly to [1], introduce
   FIND_NTH_BIT(), and optimize the function to return earlier when
   it's known that the rest of bitmap can't meet the requirement.
 - patch "lib/nodemask: inline next_node_in() and node_random()" has
   been merged, so drop it from this series.

On top of:
[1] https://lore.kernel.org/lkml/20220915020730.852234-1-yury.norov@gmail.com/T/

Yury Norov (6):
  lib/bitmap: don't call __bitmap_weight() in kernel code
  lib/bitmap: add bitmap_weight_and()
  lib: add find_nth(,and,andnot)_bit()
  lib/bitmap: add tests for find_nth_bit()
  lib/bitmap: remove bitmap_ord_to_pos
  cpumask: add cpumask_nth_{,and,andnot}

 fs/ntfs3/bitmap.c        |  4 +-
 include/linux/bitmap.h   | 13 +++++-
 include/linux/bitops.h   | 19 +++++++++
 include/linux/cpumask.h  | 55 +++++++++++++++++++++++++
 include/linux/find.h     | 86 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h |  3 +-
 lib/bitmap.c             | 68 ++++++++++++-------------------
 lib/cpumask.c            | 28 ++++++-------
 lib/find_bit.c           | 44 ++++++++++++++++++++
 lib/find_bit_benchmark.c | 18 +++++++++
 lib/test_bitmap.c        | 47 +++++++++++++++++++++-
 11 files changed, 320 insertions(+), 65 deletions(-)

-- 
2.34.1

