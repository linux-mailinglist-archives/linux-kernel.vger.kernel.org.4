Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39645B3A45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiIIOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiIIOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216A8708A;
        Fri,  9 Sep 2022 07:00:25 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIMIQ1QO8wTlqggqU+rlDVPCUCEJmWYlrk8F812BRtA=;
        b=j+C7D+kjeTIDpjtdS6rq4fuYF5fh2ROjgSaJTV7/Vef8pZFqxPZYF2viBfU4OHjK8qsrpU
        rJoTofNIq7zwI3+XlnEZQkzQPVmduAvn57U+A5uGKsgtaKpboYzYslBRrHTzJ6aVN3l3Nr
        jOpHguWn/fahqYFuV+b1Auntw+L1RWVjd5r+70KnKFVBhdGo2UnnfRXQbtIpYFRA3xlzF+
        PaTBChpN82iGTiMJuSdgYAhpcGPPsc9oNx6Kc9bwbw4XrYrvblUE2ZU7HglDpfKMscERWh
        +aS5yZj0Ntmnok2Yr/nlpP3A4t/VbvBNDWIW+7MsghEFVWqZsEoMsZl2ED+xvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIMIQ1QO8wTlqggqU+rlDVPCUCEJmWYlrk8F812BRtA=;
        b=ixPxfcLve//g1gddQTaXLZkk40Mfxd2bhExtDkj5mPqjxg7Znw6leaNvTqzISyX4E26g7k
        elU7DY1HbqYRyVCw==
From:   "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] class: use IS_ERR_OR_NULL() helper in class_unregister()
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822061922.3884113-1-yangyingliang@huawei.com>
References: <20220822061922.3884113-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <166273202287.401.13504362798914698931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     e9628e015fe205f10766f031f17e217f85650570
Gitweb:        https://git.kernel.org/tip/e9628e015fe205f10766f031f17e217f85650570
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Mon, 22 Aug 2022 14:19:22 +08:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:15:40 +02:00

class: use IS_ERR_OR_NULL() helper in class_unregister()

Use IS_ERR_OR_NULL() helper in class_unregister() to simplify code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20220822061922.3884113-1-yangyingliang@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 8feb85e..64f7b9a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(__class_create);
  */
 void class_destroy(struct class *cls)
 {
-	if ((cls == NULL) || (IS_ERR(cls)))
+	if (IS_ERR_OR_NULL(cls))
 		return;
 
 	class_unregister(cls);
