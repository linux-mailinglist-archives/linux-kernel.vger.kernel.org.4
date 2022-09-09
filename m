Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6095C5B3A12
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiIIOBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiIIOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9A83BC9;
        Fri,  9 Sep 2022 07:00:24 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmXv+2Vq7xlcJgmE4broRI/IR8cyC5RzFZWPgou2fUQ=;
        b=lV72/Kw6f/pVEa8TvjwM5faVBuOHMpqFvZq0ekGTLx8itUzxam9JmvAsET8p4KtqPLuvsM
        6nGxigEu2sSAVyMagwVWKHcObUEaZRvG+2ohW97Cio1Mij7S+yEFEESAgE2D0UD1KOT+2V
        pd9lRpQBcSathQgDSeUSPH3zrLq6trKNxwwmVe1lhAUBHQza3ENQLo8rh2Md+p0G/4ybho
        km+Hx50EMDJ8xfYnev+xOVLrUL8QwOdQA/VbXTS9t4EgXYJDDLZDdv9OQuN+3MUokHciyb
        oLLq1RSiVNxKaoF8tVUKoF8TMd5DMQXOi1ajmxKmsqUPkHTK01xBznCiRYHmdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmXv+2Vq7xlcJgmE4broRI/IR8cyC5RzFZWPgou2fUQ=;
        b=C+H75a9AsTruxBL43hbbq8Co+gP77X6mxSE2bOCm8D7t33RLsnXbzy7euIXxJ27v0D2FNM
        RmhZ59kHQkPTc6AA==
From:   "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] drivers: base: Print error code on synthetic uevent failure
Cc:     Brian Norris <briannorris@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824165213.1.Ifdb98af3d0c23708a11d8d5ae5697bdb7e96a3cc@changeid>
References: <20220824165213.1.Ifdb98af3d0c23708a11d8d5ae5697bdb7e96a3cc@changeid>
MIME-Version: 1.0
Message-ID: <166273202172.401.4074111270309086983.tip-bot2@tip-bot2>
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

Commit-ID:     6bb7ea3afd3eaae95eda6ef5589c3087f2cd70d8
Gitweb:        https://git.kernel.org/tip/6bb7ea3afd3eaae95eda6ef5589c3087f2cd70d8
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Wed, 24 Aug 2022 16:52:16 -07:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:15:50 +02:00

drivers: base: Print error code on synthetic uevent failure

If we're going to log the failure, we might as well log the return code
too.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/r/20220824165213.1.Ifdb98af3d0c23708a11d8d5ae5697bdb7e96a3cc@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cc..fd04103 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2509,7 +2509,7 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 	rc = kobject_synth_uevent(&dev->kobj, buf, count);
 
 	if (rc) {
-		dev_err(dev, "uevent: failed to send synthetic uevent\n");
+		dev_err(dev, "uevent: failed to send synthetic uevent: %d\n", rc);
 		return rc;
 	}
 
