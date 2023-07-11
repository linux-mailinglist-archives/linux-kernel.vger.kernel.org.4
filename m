Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271EA74E565
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGKDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKDjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:39:08 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A8137
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:39:07 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0RS759sdzBJFS0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:39:03 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689046743; x=1691638744; bh=yZynzVUlk5mpXs9aHjvK7lG63wT
        C8Y75Je7Bu13k+DQ=; b=qBHnLJwW4VAlI7YyZq6Nr7+t6mUAn+OEotJDeMTpbLe
        gTtOGOlY/iG/2e0mVY3BMr5MTCuYqcya7b3VwEqnbwrlXHW8a9MpNRjS79XhJ56K
        GkyGe7NOxlcKcHbxh7VDQw9L9EcidqssvQ0PHgmcr35bEg9MMNjc/DXe4k/ovZ+b
        n1A2lZ8Yc1kfbdMfub1iN0AaaFVPdNNMN1PD6TxJCJJP+67q4FGa23890t+68kji
        BJEQE5TX52yzDV5rrsw0LXsBdEtlHvy3HPXcoXtxivQVZbkJ5Kj2Dz93kTrJHAEK
        VNM6kEQDr2Xyera+RseCEVC4DYoP2eIsctt1U0CK5tA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5vEp06B-5k0o for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:39:03 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0RS72jLFzBJ8kq;
        Tue, 11 Jul 2023 11:39:03 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 11:39:03 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/flcn/msgq: Move assignment outside if condition
In-Reply-To: <20230711033745.79190-1-xujianghui@cdjrlc.com>
References: <20230711033745.79190-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7ad788a6cf70f338a32690953531b439@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c 
b/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
index 16b246fda666..52af200b45bc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
@@ -203,7 +203,8 @@ nvkm_falcon_msgq_new(struct nvkm_falcon_qmgr *qmgr, 
const char *name,
  {
      struct nvkm_falcon_msgq *msgq = *pmsgq;

-    if (!(msgq = *pmsgq = kzalloc(sizeof(*msgq), GFP_KERNEL)))
+    msgq = *pmsgq = kzalloc(sizeof(*msgq), GFP_KERNEL);
+    if (!msgq)
          return -ENOMEM;

      msgq->qmgr = qmgr;
