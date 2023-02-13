Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3469500B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjBMS5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBMS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:45 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBD1EBFB;
        Mon, 13 Feb 2023 10:57:43 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-16df32f2ffdso5614790fac.1;
        Mon, 13 Feb 2023 10:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93+b92UWCmZy6VySvJuCh4TVPqYjkOI8okcmzB71fqw=;
        b=cG9qVEqeS9lAveg/yWjd01g/qeKDyLfnZ/9KwI/5nLqvA74FWvZP0myvphwRqGrIpB
         7OqDXJcnpqOjkcofzMpFj4HI+y0Xxim4uPe+0dgiUQSenK1DB4SM9IljXtivepWa94bw
         wKIMvxNeSOzki7H7e4VsPQMV4a4PhaARjtO5P93IqXaaJ7xxq2PsYHpAalKTYGugQgwK
         b0Tr11GnXSTljGVeQ0dSuDTtSj85aQpmZ1ExU2ysF4qTI91iz8IMV2BPulbZ5uGFpfrg
         7yqd6YKzTcLKm/lZXXCJQPWWDEMSK/3PtJAm/TH4TuBdCnM9gW8epzF7ESmjqleMNp1D
         7cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93+b92UWCmZy6VySvJuCh4TVPqYjkOI8okcmzB71fqw=;
        b=NxPZ5lg5SxTEN9jquuvF3T0glMCjEGfXu47D/6yMo6Pqp0u70qL8qqNaCf2lrDMVbC
         mBO0HuZhJA3ueSOO8hE1ULQH9xXLk5ce91EXXS7bN54LRRCuSm5lChaMhbClJlfZqMgD
         gSMR5xM5f6Rw7hxke00IUBWJtJ1YEDpwBPQnkHzquYZbmpG23bhKKAiSCZbJrPpJTxgT
         tEhcG69g/eDRWmdJ8Lail0wTAtE0+mIxsckvsPjpPwtAHQdlM5kU2yohE28/qm4L85/N
         jDesBhX1RIY/Id2CL5f91LbjFIZoistKlhK/lJhV2I5WJhaz28D/G2gUxSsAzb3/sbjA
         /mXQ==
X-Gm-Message-State: AO0yUKVftUUnATj56cVnBLqo3AavvCFRhXDeKm4rVyIeeGCj3B3Ntdxl
        lWK6twtGTItxIniWqrPV90w=
X-Google-Smtp-Source: AK7set8rfhxUR5zIv2Ueop758HxG/TC3QKZLLbUSQNKMKoUBPeLJ9OXMZ+UjED6ld/U0jVPXJ86a0A==
X-Received: by 2002:a05:6870:a113:b0:16d:e3ce:a6f8 with SMTP id m19-20020a056870a11300b0016de3cea6f8mr4582816oae.30.1676314663161;
        Mon, 13 Feb 2023 10:57:43 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:42 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] of: unittest: new node lifecycle tests
Date:   Mon, 13 Feb 2023 12:56:55 -0600
Message-Id: <20230213185702.395776-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Create new devicetree node lifecycle tests.

The tests introduce use of EXPECT_NOT messages, similar to EXPECT
messages.  This requires updating scripts/dtc/of_unittest_expect
to process EXPECT_NOT messages.

The new tests revealed an issue in printk formatting when using
format "%pOF" on a node with a reference count of zero.  A patch
is included to the fix the caller which revealed the issue.

Update kconfig unittest help to further explain that unittests
should only be enabled for developer kernels.  Also add info
about using scripts/dtc/of_unittest_expect to process the output
of unittests.

Add an additional consistency check to of_node_release(), which
is the function that potentially frees node related memory when
the node's reference count is decremented to zero.

Add docbook documentation to the devicetree node creation functions
about caller responsibility to call of_node_put() and how the
memory free process works.

Frank Rowand (7):
  of: prepare to add processing of EXPECT_NOT to of_unittest_expect
  of: add processing of EXPECT_NOT to of_unittest_expect
  of: update kconfig unittest help
  of: unittest: add node lifecycle tests
  of: do not use "%pOF" printk format on node with refcount of zero
  of: add consistency check to of_node_release()
  of: dynamic: add lifecycle docbook info to node creation functions

 drivers/of/Kconfig                            |  14 +-
 drivers/of/dynamic.c                          |  31 ++-
 .../of/unittest-data/testcases_common.dtsi    |   1 +
 drivers/of/unittest-data/tests-lifecycle.dtsi |   8 +
 drivers/of/unittest.c                         | 148 +++++++++++++-
 include/linux/of.h                            |  11 ++
 scripts/dtc/of_unittest_expect                | 183 +++++++++++++++---
 7 files changed, 365 insertions(+), 31 deletions(-)
 create mode 100644 drivers/of/unittest-data/tests-lifecycle.dtsi

-- 
Frank Rowand <frowand.list@gmail.com>

