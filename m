Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4456EDD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjDYHrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjDYHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041C4C0C;
        Tue, 25 Apr 2023 00:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50029622E0;
        Tue, 25 Apr 2023 07:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A18CBC433D2;
        Tue, 25 Apr 2023 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682408807;
        bh=P4ik3YtZtaRc6Wh+178aYQgH3s7csdz7KIDFbHZ86mc=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=lyUOriJjX34uw84XiGJDxmkYukd9ZY5lI0GKKOOGUTDkQOSGCl5whmkfHwWpKCeIR
         2g+2K0HW05qtxVahabgI1BAOhpWzO4SvnI5wzoVVtAlXz0ovwcHaSyKS24QMhecMjL
         48T0w206gGSJJgMokfHDWSoEaHF6+p3SCkjmDwDWc+DnqWL4gHQbaqVnSwrtbsYHP5
         rewTMtx2Gg3I1Tl+3ANKJhvNhZhALlROZDudivxaNS62BHYJVpK6Cjw7PXEs40kzoL
         6KjTu0p9H+ujIqROIgM8UXPPh9tKkMAlYwxi5XbHulRUFK+Swz5pXx9qndmIcPuURc
         BDnjZP2yHYHFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 86526C77B71;
        Tue, 25 Apr 2023 07:46:47 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/2] clk: fix corner case of
 clk_mux_determine_rate_flags()
Date:   Tue, 25 Apr 2023 15:46:38 +0800
Message-Id: <20230421-clk-v2-0-74c6cc2214d1@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF6FR2QC/1WNzQ6DIBCEX8XsuTSyWA899T0aD7AulfhDA0jaG
 N+96K3Hb+bLzAaRg+MI92qDwNlF55cCeKmABr28WLi+MGCNqm5QCppG0TbUmpZRUm+gmEZHFib
 ohYbDnXVMHI7iHdi6zzn/7AoPLiYfvudblkf6P5ylkMKYW60sWiSrHn5Nk/fjlfwM3b7vPyEk9
 IqxAAAA
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682408804; l=665;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=P4ik3YtZtaRc6Wh+178aYQgH3s7csdz7KIDFbHZ86mc=;
 b=kPLo/ER7VoJpG3MfRFJptHn3wXFBaCAJuBu6nHGpJwTDK2tJ/Y2FQ+ccTtTcM2GCZfGnVYhNM
 LTV8aVVH1yvB1fLPFfFRuVJRN/tzmuF9UNdu3c3aaBpauMzJ9GMkX9U
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- Add a unit test to clk_test.c
- Link to v1: https://lore.kernel.org/r/20230421-clk-v1-1-bb503f2f2cf3@outlook.com

---
Yang Xiwen (2):
      clk: use ULONG_MAX as the initial value for the iteration in clk_mux_determine_rate_flags()
      clk: tests: Add missing test case for mux determine_rate

 drivers/clk/clk.c      | 5 ++++-
 drivers/clk/clk_test.c | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
change-id: 20230421-clk-64c6b6e21cdb

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

