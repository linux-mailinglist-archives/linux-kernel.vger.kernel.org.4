Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC34636290
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiKWO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiKWO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C95E4A05E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F33B2B81F97
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94CEC433D7;
        Wed, 23 Nov 2022 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215490;
        bh=kFm0dxOVEfWcYylYJSjuvJyigStoiz/gTLwSGjrDOb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHMwyqfxNDeqbnKa/z67MPQ8hA29mBjlD//ywIPOi66HSfKuDQjjBDKk20GMXsDxc
         MvZAXYDrITeY87P3FE2W3VWv66p9s5gfuf7XtCmZnAsogyHqst1i0iRtFkS6gsNq83
         fnizsUxneAGCW9BmUlmdUZntQXSI/Wdcne5vaWwIVpZqBaZNcNNAWW5uWcHIv35eY6
         qa604ezqpL+7ZW+oeZTQUJ63vl64rYpiHR8uAJ3+cUVBrSvkk/ItwNEjNXu7axnDdW
         mBWETyJ0jmyF5u2zxSY+Ey190mNPx6NjSk4ypUKpjf8eILSKKSXPfDThgNSz+e+gcm
         hmDhRT0C/kIug==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/8] habanalabs: don't put context in hl_encaps_handle_do_release_sob()
Date:   Wed, 23 Nov 2022 16:57:57 +0200
Message-Id: <20221123145801.542029-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123145801.542029-1-ogabbay@kernel.org>
References: <20221123145801.542029-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

hl_encaps_handle_do_release_sob() can be called only when the last
reference to the context object is released and hl_ctx_do_release() is
initiated, and therefore it shouldn't call hl_ctx_put().

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 2f4620b7990c..ba6675960203 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -39,7 +39,6 @@ static void hl_encaps_handle_do_release_sob(struct kref *ref)
 	idr_remove(&mgr->handles, handle->id);
 	spin_unlock(&mgr->lock);
 
-	hl_ctx_put(handle->ctx);
 	kfree(handle);
 }
 
-- 
2.25.1

