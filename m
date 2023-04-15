Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D96E31E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDOOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDOOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:42:56 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B462D56;
        Sat, 15 Apr 2023 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1681569765;
        bh=JnyT8+dt75oOzt5U0jdm6k2Z5jJt9+vYzsqgY6mtjOA=;
        h=Message-ID:Subject:From:To:Date:From;
        b=I1HO4cW41wg5Pp0TMy2M5N74aVUpJivGXHPwcSAV+1mnlm97zgmKcdTu7aY75BXIH
         qsNNXoFt1jow1d+dtVzrtQqj1zBaw9Cfi/cE5ItQCiI61soz6sxuE4eUjelO8jRtE2
         MgtBb+r4jFPeSTk6E17aqY0CqK8gNZWPvoAZEvh0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E73191281076;
        Sat, 15 Apr 2023 10:42:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id lOMc3HZQ3Sxy; Sat, 15 Apr 2023 10:42:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1681569765;
        bh=JnyT8+dt75oOzt5U0jdm6k2Z5jJt9+vYzsqgY6mtjOA=;
        h=Message-ID:Subject:From:To:Date:From;
        b=I1HO4cW41wg5Pp0TMy2M5N74aVUpJivGXHPwcSAV+1mnlm97zgmKcdTu7aY75BXIH
         qsNNXoFt1jow1d+dtVzrtQqj1zBaw9Cfi/cE5ItQCiI61soz6sxuE4eUjelO8jRtE2
         MgtBb+r4jFPeSTk6E17aqY0CqK8gNZWPvoAZEvh0=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 413041280DCB;
        Sat, 15 Apr 2023 10:42:45 -0400 (EDT)
Message-ID: <ff2bbe531bf390edf7715809f654374905ef2297.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.3-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 15 Apr 2023 10:42:43 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One small fix to SCSI Enclosure Services to fix a regression caused by
another recent fix.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Jiri Kosina (1):
      scsi: ses: Handle enclosure with just a primary component gracefully

And the diffstat:

 drivers/scsi/ses.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index b11a9162e73a..b54f2c6c08c3 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -509,9 +509,6 @@ static int ses_enclosure_find_by_addr(struct enclosure_device *edev,
 	int i;
 	struct ses_component *scomp;
 
-	if (!edev->component[0].scratch)
-		return 0;
-
 	for (i = 0; i < edev->components; i++) {
 		scomp = edev->component[i].scratch;
 		if (scomp->addr != efd->addr)
@@ -602,8 +599,10 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 						components++,
 						type_ptr[0],
 						name);
-				else
+				else if (components < edev->components)
 					ecomp = &edev->component[components++];
+				else
+					ecomp = ERR_PTR(-EINVAL);
 
 				if (!IS_ERR(ecomp)) {
 					if (addl_desc_ptr) {
@@ -734,11 +733,6 @@ static int ses_intf_add(struct device *cdev,
 			components += type_ptr[1];
 	}
 
-	if (components == 0) {
-		sdev_printk(KERN_WARNING, sdev, "enclosure has no enumerated components\n");
-		goto err_free;
-	}
-
 	ses_dev->page1 = buf;
 	ses_dev->page1_len = len;
 	buf = NULL;
@@ -780,9 +774,11 @@ static int ses_intf_add(struct device *cdev,
 		buf = NULL;
 	}
 page2_not_supported:
-	scomp = kcalloc(components, sizeof(struct ses_component), GFP_KERNEL);
-	if (!scomp)
-		goto err_free;
+	if (components > 0) {
+		scomp = kcalloc(components, sizeof(struct ses_component), GFP_KERNEL);
+		if (!scomp)
+			goto err_free;
+	}
 
 	edev = enclosure_register(cdev->parent, dev_name(&sdev->sdev_gendev),
 				  components, &ses_enclosure_callbacks);

