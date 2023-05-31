Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3817180DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjEaM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjEaM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:58:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C17E47;
        Wed, 31 May 2023 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KHl92zkNVfdNHhlnKg6mvCa7i8PxAKjKJMOEl5EMWfo=; b=zXlbDoNSylqL4+rXHY59rvAEzn
        Psl/83vgjcjxeiijFDRueZw4ZP9le8jp/jttNlMDkxj8IDlYOW9esWEYrIhI3DBEvOCaQosxnQwiC
        3iktIQuAIhFWLW+JW3Ni4cqfvgfaB2xIIzS/rmgyNOUk8mAiHJeHGWzbrtXwxJi+JevIs7Wkd0pbd
        MEm69n1jz/6nsgkRqtdGlTq/2z31G3mOe7C0owkV4F0r76f85j/wTDnGJPppUudlT34uj90Qf9t1i
        4+mzMJhW4bZK0RmsgHOGGOIiH650kf2cSttm+Y2UPmkMMcYdu2k/SEqZMtYwg3WRM9h71LjEA9j3e
        mNzlbfmA==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LOF-00HS45-0A;
        Wed, 31 May 2023 12:57:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 21/24] PM: hibernate: don't use early_lookup_bdev in resume_store
Date:   Wed, 31 May 2023 14:55:32 +0200
Message-Id: <20230531125535.676098-22-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531125535.676098-1-hch@lst.de>
References: <20230531125535.676098-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resume_store is a sysfs attribute written during normal kernel runtime,
and it should not use the early_lookup_bdev API that bypasses all normal
path based permission checking, and might cause problems with certain
container environments renaming devices.

Switch to lookup_bdev, which does a normal path lookup instead, and fall
back to trying to parse a numeric dev_t just like early_lookup_bdev did.

Note that this strictly speaking changes the kernel ABI as the PARTUUID=
and PARTLABEL= style syntax is now not available during a running
systems.  They never were intended for that, but this breaks things
we'll have to figure out a way to make them available again.  But if
avoidable in any way I'd rather avoid that.

Fixes: 421a5fa1a6cf ("PM / hibernate: use name_to_dev_t to parse resume")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 kernel/power/hibernate.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index c52dedb9f7c8e8..7ae95ec72f9902 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1178,7 +1178,23 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!name)
 		return -ENOMEM;
 
-	error = early_lookup_bdev(name, &dev);
+	error = lookup_bdev(name, &dev);
+	if (error) {
+		unsigned maj, min, offset;
+		char *p, dummy;
+
+		if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
+		    sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset,
+				&dummy) == 3) {
+			dev = MKDEV(maj, min);
+			if (maj != MAJOR(dev) || min != MINOR(dev))
+				error = -EINVAL;
+		} else {
+			dev = new_decode_dev(simple_strtoul(name, &p, 16));
+			if (*p)
+				error = -EINVAL;
+		}
+	}
 	kfree(name);
 	if (error)
 		return error;
-- 
2.39.2

