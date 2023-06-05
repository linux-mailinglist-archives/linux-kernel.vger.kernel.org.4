Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7C722787
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjFENek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjFENe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:34:28 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385BE6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:34:26 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685972065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnxJRDgHOO186L7ZZTLYXtl0YeXqHFhN/6nM2DacTKg=;
        b=TRpLEJJ5RPsMqlYRSwTrPxboO1YiZ9iFV9/0prjcNUVaAZxz218DVb2/7301Y5ZN8KPFD1
        q9GMln5iiWA2M0x2gMo336cxE1jlh6OHdn7j6IZ4aW1lazo9OjiPpxqcMPSoL/bh9EAnKi
        pH1Ghaep30P5YJSCBzvD+rphACpH/BUrCj9ecM2rei9R6o9HwmXTDBtwNT09YCrm/75dvd
        9XAVXeH8GNqKGQmIGcMweIDiB8aVl4M+7xY2lc8w57KPcIOV9+4fWTK0STLiq54DLGF/UX
        ZIsFDiceT+4m+HcKiwhMvGQkbbaIBKT4ha8upQQhxauX6rNYMbXjR2jGkdgTzA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70937FF80C;
        Mon,  5 Jun 2023 13:34:24 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 2/4] sysfs: Skip empty folders creation
Date:   Mon,  5 Jun 2023 15:34:20 +0200
Message-Id: <20230605133422.45840-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605133422.45840-1-miquel.raynal@bootlin.com>
References: <20230605133422.45840-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Hello Greg,
This is the solution I opted for to avoid core splats when creating
empty sysfs directories. The nice side effect is that the directories do
not even get created which seem the right approach in this case and
avoids to deal with any kind of cleanup either (or maybe I overlooked
something?). Let me know what you think of it. This is a try of course,
perhaps we need something way more robust, but at a first look it seemed
perfectly consistent.
Thanks,
Miquèl

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

