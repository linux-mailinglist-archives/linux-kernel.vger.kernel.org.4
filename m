Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B963808F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKXVVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKXVVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:21:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619F93CF6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A604F6223E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 21:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D3FC43470;
        Thu, 24 Nov 2022 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669324883;
        bh=KP45fkenUtVNkuekA5wpVSKSKg+M620wUBu7fatA2gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th1NC/9CqYR8H+krzv8GHNUBGsnG0hc0TrRpwJhni8NgC0Vtes22K4XcwXezWUksM
         LyjzdE4nUad+0bke+j02ePQEA8zAwN6Cac8orFTOTNMPBQWCxnhMib0zzA56qqlpei
         xpaxnY7lqe5wC9KZmKu9u3TiElifD1r3StC2Q9CivX1XLW1r/sOJn6vHuzQbHW4Fgg
         9Zl6sMngKWBZ6CBfrCrZuAobXtcmZJQklEnbtHFgcdldIGHDlNbRYYnQmbnTKnW4Nv
         eKwQgm4YSS08f/5slcVfre8qaNKKsm+WbfgQtJ3ccj2QZ23y0v6SjLY3z1SQVHV/0v
         575Ps2FI2RUMQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 06/11] mm/damon/sysfs-schemes: implement filter directory
Date:   Thu, 24 Nov 2022 21:21:09 +0000
Message-Id: <20221124212114.136863-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-1-sj@kernel.org>
References: <20221124212114.136863-1-sj@kernel.org>
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

Implement DAMOS filter directory which will be located under the filters
directory.  The directory provides three files, namely type, matching,
and memcg_path.  'type' and 'matching' will be directly connected to the
fields of 'struct damos_filter' having same name.  'memcg_path' will
receive the path of the memory cgroup of the interest and later
converted to memcg id when it's committed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 128 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 50c8148cb474..afbfc55a8e84 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -258,6 +258,134 @@ static struct kobj_type damon_sysfs_stats_ktype = {
 	.default_groups = damon_sysfs_stats_groups,
 };
 
+/*
+ * filter directory
+ */
+
+struct damon_sysfs_scheme_filter {
+	struct kobject kobj;
+	enum damos_filter_type type;
+	bool matching;
+	char *memcg_path;
+};
+
+/* Should match with enum damos_filter_type */
+static const char * const damon_sysfs_scheme_filter_type_strs[] = {
+	"anon",
+	"memcg",
+};
+
+static ssize_t type_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damon_sysfs_scheme_filter_type_strs[filter->type]);
+}
+
+static ssize_t type_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	enum damos_filter_type type;
+	ssize_t ret = -EINVAL;
+
+	for (type = 0; type < NR_DAMOS_FILTER_TYPES; type++) {
+		if (sysfs_streq(buf, damon_sysfs_scheme_filter_type_strs[
+					type])) {
+			filter->type = type;
+			ret = count;
+			break;
+		}
+	}
+	return ret;
+}
+
+static ssize_t matching_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%c\n", filter->matching ? 'Y' : 'N');
+}
+
+static ssize_t matching_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	bool matching;
+	int err = kstrtobool(buf, &matching);
+
+	if (err)
+		return err;
+
+	filter->matching = matching;
+	return count;
+}
+
+static ssize_t memcg_path_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			filter->memcg_path ? filter->memcg_path : "");
+}
+
+static ssize_t memcg_path_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
+
+	if (!path)
+		return -ENOMEM;
+
+	strncpy(path, buf, count);
+	path[count] = '\0';
+	filter->memcg_path = path;
+	return count;
+}
+
+static void damon_sysfs_scheme_filter_release(struct kobject *kobj)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	kfree(filter->memcg_path);
+	kfree(filter);
+}
+
+static struct kobj_attribute damon_sysfs_scheme_filter_type_attr =
+		__ATTR_RW_MODE(type, 0600);
+
+static struct kobj_attribute damon_sysfs_scheme_filter_matching_attr =
+		__ATTR_RW_MODE(matching, 0600);
+
+static struct kobj_attribute damon_sysfs_scheme_filter_memcg_path_attr =
+		__ATTR_RW_MODE(memcg_path, 0600);
+
+static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
+	&damon_sysfs_scheme_filter_type_attr.attr,
+	&damon_sysfs_scheme_filter_matching_attr.attr,
+	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
+
+static struct kobj_type damon_sysfs_scheme_filter_ktype = {
+	.release = damon_sysfs_scheme_filter_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damon_sysfs_scheme_filter_groups,
+};
+
 /*
  * filters directory
  */
-- 
2.25.1

