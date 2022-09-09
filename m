Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14135B36A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIILqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiIILqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:46:18 -0400
X-Greylist: delayed 101383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 04:46:16 PDT
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1F130D30
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662723972;
        bh=JaUPH4/Q0vN96/+Vw+Vuv/lvxKwxVz66jRJH6Y9rYYY=;
        h=From:To:Cc:Subject:Date;
        b=wpsE/SLQhf0cMrGGTVP2uR9IqD+jXc73qxMeleZ6CwOZrcgc9ODTa9bsGMHCTZHPU
         Emi3+fKisSCuWTenfCjQl5UUqH2i7uCLtynW9KHOOB7imccZX1gw93aeGgeNWueNMB
         G5jOxuU4f7GbXl14ChxEontgyocwvyuDbQUIET/8=
Received: from localhost.localdomain ([59.172.176.188])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id B899B0B2; Fri, 09 Sep 2022 19:46:09 +0800
X-QQ-mid: xmsmtpt1662723969t4hpcijh4
Message-ID: <tencent_1B6AAE10471D4556788892F8FF3E4812F306@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieD8sRyr3OETLiweek03JEOFg31QueNOIS1w/n09MKf+LD3CRuAd
         DAMKpEqXQxgLiqg0ztZfUvVnU/Ypzhk71hE1iL5wZ0HgUD/KNUtNZ66/oEFVtN5+yACoxuMsyy4j
         IJ2sYSHaCElmNvUgkvCPhxjbiPYqxtcopC0pc2lbgVxEpbFuelLbuhKkbFxrW7w/pB+DN5POdmAR
         nvTIpfJMQgHVarZVpYuvGALlbmK5xEyiQcqEeueTRKgWk6rXwzAxW5zxf6mdSBRnF1ed9GJYod3d
         lN31f/P9YXXUJXnqx0F5FIN2mf0EGovriaz8tlPKob30Y7jZcVUeFxwl1lgQKOWGP6iECePOJZe/
         R3EYHj6CVh8f1MAIyvmp+MxdQXH0yXHu8E8hT00FGatOU9pSBLPPoAvvfdXgD9NS0a9UpE70LuIp
         l/R8BTf7zDu3lMQeZdK9AuGn0EOMA6Eywv0zLnoiMbxI0lbyjAi9q2kcmZWJ7jl/dI3p08xtWpDZ
         b4yxC0hJ0qVk9Rd2nU7I635/xSv9XWXODGN9JHCPJrNOwJbIGYdxhRpEoNSu8Om1C5r+1Tx5yWIc
         QnZzNWgl7YnFQ95zeJLNqi5YDWML5QVUmyRf3Pc2ypbjQkyybyHTcZisEGHLFwf1MGBSJr1bHYVv
         iJuYYlJky7UR+/nvnwIWZYhNslD5S87zCLM4tDqvE9PZQHABAH3vlfmuWdPRR43Nb4/JZlmZiGtT
         piuWAHXnZx0mUi4+tDrha8sUrkkSB7j+3UGY4Yy2PTVip8h+g0i9OzblThUJZv/Nilk1otBp4nTl
         qKCktoUsHEVMEaXb+j9KAxSgN2zQKW6yC8E4pmbpDIhTL8k3ff0VyuZRjRkYDnW8t0whGuTMFRiO
         3IhE+r5JtnPpa2TqpzFabWsOanvLIsuc7lu/dCMAW1GcfvA5U8ZaIuCu7rbRbNnS9khGxIA26iyi
         0C5Jmomfp2lOP4P0hqp1HePoObABMSng8gX523FFM1ri/Tk2pGWm5EGRZS5+GC7mnN9/B+lLUq+R
         v7TWBxGA==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v6] staging: r8188eu: fix a potential memory leak in rtw_init_cmd_priv()
Date:   Fri,  9 Sep 2022 19:45:57 +0800
X-OQ-MSGID: <20220909114557.3707-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_init_cmd_priv(), if `pcmdpriv->rsp_allocated_buf` is allocated
in failure, then `pcmdpriv->cmd_allocated_buf` will not be properly
released. Besides, considering there are only two error paths and the
first one can directly return, we do not need to implicitly jump to the
`exit` tag to execute the error handling code.

So this patch added `kfree(pcmdpriv->cmd_allocated_buf);` on the error
path to release the resource and simplified the return logic of
rtw_init_cmd_priv(). As there is no proper device to test with, no
runtime testing was performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2: simplify the function.
v2->v3: rebase and recover some whitespace cleanups.
v3->v4: update the description.
v4->v5: rebase...
v5->v6: update the description.
 drivers/staging/r8188eu/core/rtw_cmd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 9c700ff..e38a826 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -58,8 +58,6 @@ static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 
 u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-	u32 res = _SUCCESS;
-
 	init_completion(&pcmdpriv->enqueue_cmd);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
 	init_completion(&pcmdpriv->start_cmd_thread);
@@ -74,27 +72,24 @@ u32	rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
 					      GFP_KERNEL);
 
-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return _FAIL;
 
 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));
 
 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
 
 	if (!pcmdpriv->rsp_allocated_buf) {
-		res = _FAIL;
-		goto exit;
+		kfree(pcmdpriv->cmd_allocated_buf);
+		return _FAIL;
 	}
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);
 
 	pcmdpriv->cmd_done_cnt = 0;
 	pcmdpriv->rsp_cnt = 0;
-exit:
 
-	return res;
+	return _SUCCESS;
 }
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv)
-- 
