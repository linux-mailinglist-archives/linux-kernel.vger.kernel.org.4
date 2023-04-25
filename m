Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52C6EEA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjDYWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDYWY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:24:57 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58808CC1E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-32b0cc0eb43so53434375ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682461495; x=1685053495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuJKxfEGJnOY6oqokaUbcqI0hvo9kY/6oilZjxK5wcg=;
        b=rtE+w3+EToaewzliFYao4Gx1k1pEZ50a7374ouPdyz4c9KyTOyvd0qX4+vebjUT91O
         1ehLcOt1ZPq7IzncS6xzKdJ79V0s3ZCo3kcZ75G/bvNsoRy14lqGkvTxe68CAylZVZYM
         qGyvp0tFX/j14geYVbbAFAT5byjRneS86DEmz9rYYvxcmaesNBelbG95489L/VrsFOtQ
         316WnTF7sBRgxos/V7TCcVznwNurt5hIIeXNeOLZoZx+G6jUUDWN255/qQfiAFtAz3kQ
         n6YtmMdgn8mX8nKUTx1zhh2ppHt9lHH1qB5AfIyGFFcAXG8avY/NWw6P0HIs7pAoYUPh
         2Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682461495; x=1685053495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuJKxfEGJnOY6oqokaUbcqI0hvo9kY/6oilZjxK5wcg=;
        b=J69Uf/BbpNEb+ZgqRtbbaeNS2G/uD+YGqTgZe6Zigy1lWri7/gG63hhcmlpLHuA6JD
         0pugitixXOoRdusAr9iHGSpA9z1TFZNNcNBwFEDHThL3yaq/d6YymM6m5V9uw2k7rL2U
         REr/BgsoglmvqRjtiNyYSytzc8TW5M026NlIrVVXkc80TDFp/lI9nuWrcoMrKddZtZ05
         xd6YAsQZe6zAAKSjicB9ifhl4DoE64e2lYK3eEQy8rfM/P3Q87UYhNJXeSabHJaImHMl
         yJfA2d6VPXAZm666zVhF+46u+cyk4xcAbTHRa8Y4U3fGzXGapFjOtIFQYL5WZo0Gwhlj
         59hw==
X-Gm-Message-State: AAQBX9fit6CfVUDftmbX8a8JTY+saFFKWxjlI6f3VqGvumBoqLIAfOd+
        WEVcKeThBr5hWtelmvmhz5I=
X-Google-Smtp-Source: AKy350a8yjGj8+9pDxme1/97N0vQc1KuCnae7bWnGIYBb0cQDqinbFIbGE3MZ3Vhrzx+/3bDXvetmA==
X-Received: by 2002:a92:d40d:0:b0:317:c80f:b416 with SMTP id q13-20020a92d40d000000b00317c80fb416mr8313209ilm.20.1682461495601;
        Tue, 25 Apr 2023 15:24:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 13-20020a92180d000000b003244d7f2292sm3833008ily.32.2023.04.25.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 15:24:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     catalin.marinas@arm.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/3] kmemleak report format changes
Date:   Tue, 25 Apr 2023 16:24:43 -0600
Message-Id: <20230425222446.170486-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If format changes are not /sys/** ABI violating, heres 3 minor ones:

1st strips "age <increasing>" from output.  This makes the output
idempotent; unchanging until a new leak is reported.

2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
user see repeats without actually reading the whole backtrace.  So now
the backtrace line looks like this:

  backtrace (ck 603070071):  # also see below

Q: should ck be spelled crc ? it feels more communicative.

NB: with ck exposed, it becomes possible to do a "selective clear",
something like:

  echo drop 603070071 > /sys/kernel/debug/kmemleak

The 3rd patch takes __init off of kmemleak_test_init().  This fixes a
bare-pointer in the 2nd line of the backtrace below, which previously
looked like:

    [<00000000ef738764>] 0xffffffffc02350a2

NB: this happens still/again, after rmmod kmemleak-test.

unreferenced object 0xffff888005d9ca40 (size 32):
  comm "modprobe", pid 412, jiffies 4294703300
  hex dump (first 32 bytes):
    00 cd d9 05 80 88 ff ff 40 cf d9 05 80 88 ff ff  ........@.......
    14 a7 c4 f6 7d f9 87 10 00 00 00 00 00 00 00 00  ....}...........
  backtrace (ck 1354775490):
    [<000000002c474f61>] kmalloc_trace+0x26/0x90
    [<00000000b26599c1>] kmemleak_test_init+0x58/0x2d0 [kmemleak_test]
    [<0000000044d13990>] do_one_initcall+0x43/0x210
    [<00000000131bc505>] do_init_module+0x4a/0x210
    [<00000000b2902890>] __do_sys_finit_module+0x93/0xf0
    [<00000000673fdce2>] do_syscall_64+0x34/0x80
    [<00000000357a2d80>] entry_SYSCALL_64_after_hwframe+0x46/0xb0


Jim Cromie (3):
  kmemleak: drop (age <increasing>) from leak record
  kmemleak: add checksum to backtrace report
  kmemleak-test: drop __init to get better backtrace

 mm/kmemleak.c                    | 8 +++-----
 samples/kmemleak/kmemleak-test.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.40.0

