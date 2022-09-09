Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDC5B3A11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiIIOBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiIIOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617CF7F13B;
        Fri,  9 Sep 2022 07:00:23 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lE5RwnibNt7wQdy94SVqKuvSwCROx+VoFtcIbDqU9Xs=;
        b=aNtzdobZMEXy6sDn+5AR+RkZdhiwo+49NJbpw1NCHDMzlXqMntFD/7kbEXjfAMR5K0YOeD
        JaOuDttMug8ocn3y7zJHpBpDTVNXYHkLBZEMo4n2DtqCww9YrJ5UQvyFTn8yiP47Nc/2tP
        CgnUKS9nGGydvMTpsk/Gb4pb3NwWAd0r4SyLbhI+QTjAUnFrF2I+e1rEoyZ5XCnyZaJq5g
        PsTafpi+Az2VLYJ5+ZYY/8eZLQcrg2elBlBMkAFdsWo8kFkKGrytfmQeVM1k++E730hxju
        y1wHqF5FBgn9QDJDa2N8GyWhLOEMhkWUGAeeFHqbxRb9aJwh6kzNjs/xTTLmzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lE5RwnibNt7wQdy94SVqKuvSwCROx+VoFtcIbDqU9Xs=;
        b=XqKyDXC13KBCZDZuk/nLTC9GJlgEUgs7VUHlChJoFjiKH0+5aGSZ2zsQ/kgHsv4kyGj29n
        rbqeatJq1Ro+iEDQ==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] devres: Slightly optimize alloc_dr()
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd255bd871484e63cdd628e819f929e2df59afb02=2E16583?=
 =?utf-8?q?52383=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Cd255bd871484e63cdd628e819f929e2df59afb02=2E165835?=
 =?utf-8?q?2383=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <166273202054.401.17562686262553239194.tip-bot2@tip-bot2>
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

Commit-ID:     61742a7cd5b194d2cc52d78de8ec6967634a4cd6
Gitweb:        https://git.kernel.org/tip/61742a7cd5b194d2cc52d78de8ec6967634a4cd6
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Wed, 20 Jul 2022 23:26:36 +02:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:17:14 +02:00

devres: Slightly optimize alloc_dr()

If the gfp flag used for the memory allocation already has __GFP_ZERO,
then there is no need to explicitly clear the "struct devres_node". It is
already zeroed.

This saves a few cycles when using devm_zalloc() and co.

In the case of devres_alloc() (which calls __devres_alloc_node()), the
compiler could remove the test and the memset() because it should be able
to see that the __GFP_ZERO flag is set.
So this would make the code both faster and smaller.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/d255bd871484e63cdd628e819f929e2df59afb02.1658352383.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/devres.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 864d0b3..4ab2b50 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -117,7 +117,9 @@ static __always_inline struct devres * alloc_dr(dr_release_t release,
 	if (unlikely(!dr))
 		return NULL;
 
-	memset(dr, 0, offsetof(struct devres, data));
+	/* No need to clear memory twice */
+	if (!(gfp & __GFP_ZERO))
+		memset(dr, 0, offsetof(struct devres, data));
 
 	INIT_LIST_HEAD(&dr->node.entry);
 	dr->node.release = release;
