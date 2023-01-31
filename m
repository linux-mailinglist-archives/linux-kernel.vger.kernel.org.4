Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC630683934
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjAaWUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAaWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:20:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B43AB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10BDDB81F05
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD43C433EF;
        Tue, 31 Jan 2023 22:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203650;
        bh=NrnRWovM/uOVy28g45NHj7VieIHy7lLhadVhP5aP4XQ=;
        h=From:Subject:Date:To:Cc:From;
        b=ZTP5/nC6hRu/a9gzWFeOAYuVGo98hb0IgoQrrsekr8b1X8srjPUWv9tddlfLLLSkO
         oTYGB3o+p4QLbHJrUh9UX7r4ZelEzkqT+6xMIs9XwQdkfPA8esUkWVZpEAJbTUMTeL
         +XIaio5zxn0CF+t70w7M8+1yh5uOgDPgenTxWV+Hi2QiRoKXmcf9n9xinPxBoz7ssx
         wj3PTj7N+egQ1ZHSUW+iRI0c0JMDWO/E6yk7WWcD6Z/Q2Piln3sX0T1ljCafkewR62
         4eOBBcPPf8U0tULd7WhNyXA8EAS9H59wmviH8dXY8xnGMpvr7tXEhM6AL7R+rgLNF2
         e60qUdFhSpBsg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/7] arm64/signal: Signal handling cleanups
Date:   Tue, 31 Jan 2023 22:20:38 +0000
Message-Id: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaU2WMC/4WPQW6DQAxFrxLNuk4YA2HoqveosjBgwCrMRB6KW
 kXcPUM2yS7y6sn679s3E1mFo/k83IzyKlGCT5B/HEw7kh8YpEtsMEO0aYB0PhcQZfA0QTsx+d8
 rNG1XYYUdl1SbFG0oMjRKvh33cFAZxJ9migvrvr8q9/L3qP2+JO41zLCMyvQss1jYvHTWHdFhX
 ZZgkzEEL/z1w+p5OgYddtkocQn6/3hhxV355toVIQNbkOtzzpxrqlfhZdu2OzgOg7MWAQAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NrnRWovM/uOVy28g45NHj7VieIHy7lLhadVhP5aP4XQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ7tWwqirrYPp7ZvBgqpbkq90OaPHMZITwFiPPy
 Kd2Yg0aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUOwAKCRAk1otyXVSH0FRSB/
 4kYYZl7mlOXQsEL/0oUyDXvyYda32i/VioKnjLR5zB1Nm7isy8dsi73J/4E75BX/Esnrl+pm+cF1Pv
 bMxIL4r2sDf19mqLhLZAf8i8cxrFA32H+UsBn7QZmIj4+gRQ1hCtu6joU+b/QBQ3mAedT5UftSG6ze
 dmWdc0dIsE+Z8csn/OzXHP+O7zlkiRe05RtvMpSy9K8HNVdktmFPkIDSOo8Oj9c5Zvzck7l2iMLCtn
 NZlG8hYRu8/P+3Tvlxx84UR4xyTJmfjkbcdt7B7xt4xmtjR/shQ8dbtUGf1CVaZHGaqY4Wo1gDCEYd
 BMaqK50ic4Msjuh24YjdnME1I+KGwu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series collects a number of small cleanups to the signal handling
code which removes redundant validation of size information and avoids
reading the same data from userspace twice.

There are some overlaps with both the TPIDR2 signal handling and SME2
serieses which are also in flight, applying this will require
adjustments in those serieses and vice versa.

Changes in v3:
- Rebase onto arm64/for-next/core, updating for the addition of ZT and
  TPIDR2 signal frames.
- Link to v2: https://lore.kernel.org/r/20221212-arm64-signal-cleanup-v2-0-14a8f3e088b7@kernel.org
v2:
 - Rebase onto v6.2-rc1

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (7):
      arm64/signal: Don't redundantly verify FPSIMD magic
      arm64/signal: Remove redundant size validation from parse_user_sigframe()
      arm64/signal: Make interface for restore_fpsimd_context() consistent
      arm64/signal: Avoid rereading context frame sizes
      arm64/signal: Only read new data when parsing the SVE context
      arm64/signal: Only read new data when parsing the ZA context
      arm64/signal: Only read new data when parsing the ZT context

 arch/arm64/kernel/signal.c | 121 +++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 60 deletions(-)
---
base-commit: 8154ffb7a51882c00730952ed21d80ed76f165d7
change-id: 20221212-arm64-signal-cleanup-bcd7272de5a9

Best regards,
-- 
Mark Brown <broonie@kernel.org>

