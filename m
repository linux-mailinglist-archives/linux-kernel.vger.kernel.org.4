Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC2B656CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiL0QC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiL0QCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:49 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7CF20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:47 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156964;
        bh=xSg7Iuav8suoTduBbOb9CQOu+RLLR8Kat74NxAQM5+M=;
        h=From:Subject:Date:To:Cc:From;
        b=pB7BvWCkxtxYBTl3id+BJnTPVNSz4l85aPymbB6t7MN5MOaoHoOsd0iRKzheEd4+B
         PRKiYXMoI9B7+X0wUG1yu4PgurHiPqOCwdo6s7WlRFtsyPAf8lOaVjj/7AfLNNxYbm
         cInKJbhKUPP7hf2HM2HA5iq0pmi03XmpJZwu0zJk=
Subject: [PATCH v2 0/8] reduce maximum memory usage
Date:   Tue, 27 Dec 2022 16:00:57 +0000
Message-Id: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALkWq2MC/3WNTQqDQAyFryJZN8VEsKWr3qO4cJzYmaIzMFFLE
 e/e0H1Xj+/xfnZQKVEUbtUORbaoMScDPlUwhD49BaM3Bq6ZianF7F5LzhPOMufywbr1rnFXNxIR
 WMn1KuhKn4ZgtbROk5kh6mLh38lGJo+/exthje3I3jfiLw3x/S1RVYewhnOSBbrjOL4wC4cGtgA
 AAA==
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=1789;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xSg7Iuav8suoTduBbOb9CQOu+RLLR8Kat74NxAQM5+M=;
 b=Pryh6ZlQfLoaMXdHAG1AJBDrwlIp9neEIvLGw8009KmFhCr53XZG0K5u0/QEq3qYZLhu21A1kdV7
 sHXaM4aWDQdzJLSD1//NBoDs13d7JzlLy1/533Lm9BhDNzyEndhe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The processing of vmlinux.o with objtool is the most memory-intensive step
of a kernel build. By reducing the maximum memory usage here we can reduce
the maximum memory usage of the whole kernel build.
Therefore memory pressure on memory starved machines is relieved during
kernel builds and the build is faster as less swapping has to occur.

To: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Changes in v2:
- Warn on out of range values for reloc->type
- Also reduce size of struct special_alt
- Note: v1 did not make it to the lists, only to individual recipients

---
Thomas Weißschuh (8):
      objtool: make struct entries[] static and const
      objtool: make struct check_options static
      objtool: allocate multiple structures with calloc()
      objtool: introduce function elf_reloc_set_type
      objtool: reduce memory usage of struct reloc
      objtool: optimize layout of struct symbol
      objtool: optimize layout of struct special_alt
      objtool: explicitly cleanup resources on success

 tools/objtool/builtin-check.c           |  4 ++-
 tools/objtool/check.c                   |  6 ++--
 tools/objtool/elf.c                     | 56 +++++++++++++++++++--------------
 tools/objtool/include/objtool/builtin.h |  2 --
 tools/objtool/include/objtool/elf.h     | 13 +++++---
 tools/objtool/include/objtool/special.h |  2 +-
 tools/objtool/special.c                 |  6 ++--
 7 files changed, 51 insertions(+), 38 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221216-objtool-memory-06db3b8bf111

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
