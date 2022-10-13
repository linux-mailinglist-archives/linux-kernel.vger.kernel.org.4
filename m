Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23A65FE583
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJMWpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJMWpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:45:01 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 15:44:56 PDT
Received: from resqmta-c1p-023463.sys.comcast.net (resqmta-c1p-023463.sys.comcast.net [IPv6:2001:558:fd00:56::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683F45F44
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:44:55 -0700 (PDT)
Received: from resomta-c1p-023267.sys.comcast.net ([96.102.18.232])
        by resqmta-c1p-023463.sys.comcast.net with ESMTP
        id j6RpojqbljS9Rj6uGop7ul; Thu, 13 Oct 2022 22:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665700944;
        bh=LV8/JcMHb+MmlhgjlVRQXW/dcI3Ijaatxb0kxbiP4wE=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=Bf/IvOWLEP/fzD0l0knDUzF8vrErgOOJD7mWZY2FHQhI6LBMR/fPjf+eFdEltgIfL
         Vyg3e0db4ZRkJnbukq6EGFMsWcl32u2BPQxWFHjJkkDU43jKOYZuWSYV4mkF820JI0
         xSbH5xIyOmXyN+ZIB86lmccpn6HbMMBy9XultRXTUIDTJpDng6yWI2lmlP5oCo97ZQ
         Pd843NeFvHzxM6Kr0LoDNxemzP4+nMd7LM1T4FnSahmm2pT+7TqSVkNq9c+ltu1EBl
         9YbtibG3+8zXI96C9t/e2hBJ77q1y/UgxK21ogksiTsX0G3gXwfB3/slJxswyil1N3
         F92l4sdjXwMQw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-c1p-023267.sys.comcast.net with ESMTPA
        id j6toofOVmA6uYj6tuozg6t; Thu, 13 Oct 2022 22:42:03 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghkse
 hsohhlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhushiirdhtkhgrtgiihihksehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 2/3] md/bitmap: Add sysfs interface for flush threshold
Date:   Thu, 13 Oct 2022 16:41:50 -0600
Message-Id: <20221013224151.300-3-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221013224151.300-1-jonathan.derrick@linux.dev>
References: <20221013224151.300-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a sysfs interface in the bitmap device for setting the chunk flush
threshold. This is an unsigned integer value which defines the amount of
dirty chunks allowed to be pending between bitmap flushes.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 Documentation/admin-guide/md.rst |  5 +++++
 drivers/md/md-bitmap.c           | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
index d8fc9a59c086..d688ae4065cf 100644
--- a/Documentation/admin-guide/md.rst
+++ b/Documentation/admin-guide/md.rst
@@ -401,6 +401,11 @@ All md devices contain:
      once the array becomes non-degraded, and this fact has been
      recorded in the metadata.
 
+  bitmap/flush_threshold
+     The number of outstanding dirty chunks that are allowed to be pending
+     before unplugging the bitmap queue. The default behavior is to always
+     unplugging the queue when requested.
+
   consistency_policy
      This indicates how the array maintains consistency in case of unexpected
      shutdown. It can be:
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index c5c77f8371a8..cd8250368860 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2652,6 +2652,38 @@ static struct md_sysfs_entry max_backlog_used =
 __ATTR(max_backlog_used, S_IRUGO | S_IWUSR,
        behind_writes_used_show, behind_writes_used_reset);
 
+static ssize_t
+bitmap_flush_threshold_show(struct mddev *mddev, char *page)
+{
+	ssize_t ret;
+	spin_lock(&mddev->lock);
+	if (mddev->bitmap == NULL)
+		ret = sprintf(page, "0\n");
+	else
+		ret = sprintf(page, "%u\n",
+			      mddev->bitmap_info.flush_threshold);
+	spin_unlock(&mddev->lock);
+	return ret;
+}
+
+static ssize_t
+bitmap_flush_threshold_store(struct mddev *mddev, const char *buf, size_t len)
+{
+	unsigned int thresh;
+	int ret;
+	if (!mddev->bitmap)
+		return -ENOENT;
+	ret = kstrtouint(buf, 10, &thresh);
+	if (ret)
+		return ret;
+	mddev->bitmap_info.flush_threshold = thresh;
+	return len;
+}
+
+static struct md_sysfs_entry bitmap_flush_threshold =
+__ATTR(flush_threshold, S_IRUGO | S_IWUSR,
+       bitmap_flush_threshold_show, bitmap_flush_threshold_store);
+
 static struct attribute *md_bitmap_attrs[] = {
 	&bitmap_location.attr,
 	&bitmap_space.attr,
@@ -2661,6 +2693,7 @@ static struct attribute *md_bitmap_attrs[] = {
 	&bitmap_metadata.attr,
 	&bitmap_can_clear.attr,
 	&max_backlog_used.attr,
+	&bitmap_flush_threshold.attr,
 	NULL
 };
 const struct attribute_group md_bitmap_group = {
-- 
2.31.1

