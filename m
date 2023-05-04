Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AE6F738F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjEDToS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjEDTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829C39EE4;
        Thu,  4 May 2023 12:43:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5664463718;
        Thu,  4 May 2023 19:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0028BC433A1;
        Thu,  4 May 2023 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229386;
        bh=1B2peXEYSMNCkoc61RSuBI2zOAqfgLGgcQDhB+PqCbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+LeFGsCTvUBocHy3PM7y7nu91m7cbfU5nGBrM34Yh0tMu0ZCmQ9euJEy0SR2lLPp
         SmZXYRT9uy16/6AF2MnASqpxXSJoWkH2aQ/G1IjTpF7/mHkzwlQ4uzv0xxJWT/evbb
         YHHSRxpgexgb8db1dBZUAOANK0YQDO60PBc93kWHVYEJ+Q7GoxtOkJ7lb0OLVpmkvb
         6EeLuQ4ftJmSArdsZhb2v55LeormIGrlKOdeUcu3+Ym04o/cg1lVIMHTR7cJewuYPp
         jKT+VdD9IzaJDpVC8ky0lZWMSauF45LsLwccc+hG3TU7ad5P0fN4ycZF8z/pgkzkYO
         u55l/C6vnFbxw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hao Zeng <zenghao@kylinos.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 31/59] samples/bpf: Fix fout leak in hbm's run_bpf_prog
Date:   Thu,  4 May 2023 15:41:14 -0400
Message-Id: <20230504194142.3805425-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit 23acb14af1914010dd0aae1bbb7fab28bf518b8e ]

Fix fout being fopen'ed but then not subsequently fclose'd. In the affected
branch, fout is otherwise going out of scope.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230411084349.1999628-1-zenghao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/hbm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 516fbac28b716..7f89700a17b69 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -315,6 +315,7 @@ static int run_bpf_prog(char *prog, int cg_id)
 		fout = fopen(fname, "w");
 		fprintf(fout, "id:%d\n", cg_id);
 		fprintf(fout, "ERROR: Could not lookup queue_stats\n");
+		fclose(fout);
 	} else if (stats_flag && qstats.lastPacketTime >
 		   qstats.firstPacketTime) {
 		long long delta_us = (qstats.lastPacketTime -
-- 
2.39.2

