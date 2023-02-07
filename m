Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D768E320
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBGVtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGVtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:49:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24A9EF4;
        Tue,  7 Feb 2023 13:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84138B819B5;
        Tue,  7 Feb 2023 21:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F68BC433EF;
        Tue,  7 Feb 2023 21:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675806540;
        bh=AJYL5kPWDIdLpgMxWaeB6NQXY96/NzStEDIpyzX5zn4=;
        h=From:To:Cc:Subject:Date:From;
        b=WUUyiK3XVirgB/9lBJEQZAvQU3nFG122w7HYlCTSpApdZaeR2Rpkf/QHCKt3FOJcu
         QPo2zZRlZf+FrybIiYhQ9ztRwKcRYC5SyiDtt9CIZlNVaRYdA7TFa6JMV30T65xMWH
         zeBRsdKFa1H1YBiGbTVJAe+nGNB7ZXZ8IM9MMk7qynjZIrSUN2472KJTvmdBE3R4Yj
         3AmMHtfvPrb2urdU1iyL3M36qcOCP6hLZR2B5fHK0oJw9wzFbDHJrO+p5bErDzU7wO
         WcU9bPVIOKPE1oC3n0s8nsfGiBVCLL76uc5qQGlz/G8ZoKD51dOchY5ATS1hbgAWdC
         tRUwqPhCj2Lsg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] rtla: Add hwnoise tool
Date:   Tue,  7 Feb 2023 22:48:49 +0100
Message-Id: <cover.1675805361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series present a new tool inside rtla. It is named hwnoise.

hwnoise dispatches the osnoise tracer and displays a summary of the noise.
The difference is that it runs the tracer with the OSNOISE_IRQ_DISABLE
option set, thus only allowing only hardware-related noise, resulting in
a simplified output. hwnoise has the same features of osnoise.

An example of the tool's output:

 # rtla hwnoise -c 1-5 -T 1 -d 10m -q
                                           Hardware-related Noise
 duration:   0 00:10:00 | time is in us
 CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI
   1 #599       599000000          138    99.99997           3            3           4           74
   2 #599       599000000           85    99.99998           3            3           4           75
   3 #599       599000000           86    99.99998           4            3           6           75
   4 #599       599000000           81    99.99998           4            4           2           75
   5 #599       599000000           85    99.99998           2            2           2           75

Changes from v2:
  Consolidate patches 1/5 into a single one (Steven)
  Change the osnoise option macro to code (Steven)
Changes from v1:
  Add rtla-hwnoise to the rtla documentation index
	(kernel test robot/Bagas Sanjaya)

Daniel Bristot de Oliveira (2):
  rtla: Add hwnoise tool
  Documentation/rtla: Add hwnoise man page

 Documentation/tools/rtla/index.rst        |   1 +
 Documentation/tools/rtla/rtla-hwnoise.rst | 107 ++++++++++++++++++++
 tools/tracing/rtla/Makefile               |   2 +
 tools/tracing/rtla/src/osnoise.c          | 117 ++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h          |   7 ++
 tools/tracing/rtla/src/osnoise_top.c      |  84 +++++++++++++---
 tools/tracing/rtla/src/rtla.c             |   4 +
 7 files changed, 306 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/tools/rtla/rtla-hwnoise.rst

-- 
2.38.1

