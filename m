Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACB72F4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbjFNGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbjFNGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:30:43 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CC213F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:30:22 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686724221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxDjpsQsnHKyp+46A4IVR8UbFfLpDgOYCYup7v5oaqk=;
        b=W3Gfs6pVbddjBLmdgT5NvK6nsbXjzsjABQxhtvuX0NESqymciSDiL3+HcVhAaWEIaQh04w
        SlZXRj9DYw45Ek4PTgZWMb6HPM2nnZ7F0gVaqkinmaYULieA+doinqMaMfefDqZ9qv5vtj
        1u6UeZ8aUF2cdCUtcizm5aJEkKQwhimJy3VgSjv5bZ2MSLkZWubUg+TN6QOlFTtIoWd1gg
        xWIMO6VeHqJhaXHwUJfGjRfczemlTfq64ixgAU4Q+Y/8goyaztUjtxz+YpxBY6gNgewhCg
        everkFlE9xeAQvFBsoOXHE2GIrO/MkeZx8NUv6HUT23wWV+SizyPTZ60IB0ZVw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5174FF80B;
        Wed, 14 Jun 2023 06:30:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 2/4] sysfs: Skip empty folders creation
Date:   Wed, 14 Jun 2023 08:30:16 +0200
Message-Id: <20230614063018.2419043-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
References: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most sysfs attributes are statically defined, the goal with this design
being to be able to move all the filesystem description into read-only
memory. Anyway, it may be relevant in some cases to populate attributes
at run time. This leads to situation where an attribute may or may not be
present depending on conditions which are not known at compile
time, up to the point where no attribute at all gets added in a folder
which then becomes "sometimes" empty. Problem is, providing an attribute
group with a name and without .[bin_]attrs members will be loudly
refused by the core, leading in most cases to a device registration
failure.

The simple way to support such situation right now is to dynamically
allocate an empty attribute array, which is:
* a (small) waste of space
* a waste of time
* disturbing, to say the least, as an empty sysfs folder will be created
  anyway.

Another (even worse) possibility would be to dynamically overwrite a
member of the attribute_group list, hopefully the last, which is also
supposed to remain in the read-only section.

In order to avoid these hackish situations, while still giving a little
bit of flexibility, we might just check the validity of the .[bin_]attrs
list and, if empty, just skip the attribute group creation instead of
failing. This way, developers will not be tempted to workaround the
core with useless allocations or strange writes on supposedly read-only
structures.

The content of the WARN() message is kept but turned into a debug
message in order to help developers understanding why their sysfs
folders might now silently fail to be created.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 fs/sysfs/group.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 990309132c93..138676463336 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -118,11 +118,13 @@ static int internal_create_group(struct kobject *kobj, int update,
 	/* Updates may happen before the object has been instantiated */
 	if (unlikely(update && !kobj->sd))
 		return -EINVAL;
+
 	if (!grp->attrs && !grp->bin_attrs) {
-		WARN(1, "sysfs: (bin_)attrs not set by subsystem for group: %s/%s\n",
-			kobj->name, grp->name ?: "");
-		return -EINVAL;
+		pr_debug("sysfs: (bin_)attrs not set by subsystem for group: %s/%s, skipping\n",
+			 kobj->name, grp->name ?: "");
+		return 0;
 	}
+
 	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
 		if (update) {
-- 
2.34.1

