Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0F741DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjF2BfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjF2BfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:35:02 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623891B0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 18:35:00 -0700 (PDT)
X-UUID: 307ba47fb3324b44bec63d7fad732c0a-20230629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:b4ec874c-a06b-40cd-abd9-8a29c283655d,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.27,REQID:b4ec874c-a06b-40cd-abd9-8a29c283655d,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:01c9525,CLOUDID:ed537d82-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:2306290934523U986QMZ,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 307ba47fb3324b44bec63d7fad732c0a-20230629
X-User: huxiaoying@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <huxiaoying@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1959421970; Thu, 29 Jun 2023 09:34:49 +0800
From:   Hu Xiaoying <huxiaoying@kylinos.cn>
To:     linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Hu Xiaoying <huxiaoying@kylinos.cn>
Subject: [PATCH] samples/bpf: Fix outf leak in hbm's read_trace_pipe2
Date:   Thu, 29 Jun 2023 09:34:44 +0800
Message-Id: <20230629013444.50350-1-huxiaoying@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix outf being fopen'ed but then not subsequently fclose'd. In the affected
branch, outf is otherwise going out of scope.
---
 samples/bpf/hbm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index bf66277115e2..e28370741d9b 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -105,6 +105,8 @@ static void read_trace_pipe2(void)
 			}
 		}
 	}
+
+	fclose(outf);
 }
 
 static void do_error(char *msg, bool errno_flag)
-- 
2.25.1

