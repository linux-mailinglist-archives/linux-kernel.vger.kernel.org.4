Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844E963E136
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiK3UKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiK3UJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:09:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD2D77223
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6268761DB5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE31C433B5;
        Wed, 30 Nov 2022 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669838985;
        bh=5gMO8cLybx9rIEkN5/YUfJzDl3RNG0bek/qaVakfGfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyEPngwuZpVCPKj0e4uOCSDx1BCpnCetVtcL2MqZ+HTFvvcTE+G86n+1jV6SP+6EO
         XZmbJPiZlX613JojRgXLTRSeb2MhX6AL1OsbR3a2aZJ5FoS7f9NRCK58qGKpvjNkRh
         ssiEsUhB0xW1+ku46FANT3BoQsRClM2BgOSZ1Tx1Qvw+5jZpi651bYaEP5HIqDCb3N
         GlYxUZI0asZT/EOpSD9bhKm6kfPLyNbmM9X1Ei6uhIpAqkJCO+tJJWA/X3EOW0BcBB
         +eiRVYe6zTRYYJ/iul6USKYxNXgTARb6RrYExJqSvZc+jkFtC8mF4Wl0J9uaCNTLdw
         H0ApioDCwbF1Q==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 07/11] mm/damon/sysfs-schemes: connect filter directory and filters directory
Date:   Wed, 30 Nov 2022 20:09:33 +0000
Message-Id: <20221130200937.118005-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
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

Implement 'nr_filters' file under 'filters' directory, which will be
used to populate specific number of 'filter' directory under the
directory, similar to other 'nr_*' files in DAMON sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index afbfc55a8e84..e79c678a69d5 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -269,6 +269,11 @@ struct damon_sysfs_scheme_filter {
 	char *memcg_path;
 };
 
+static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
+{
+	return kzalloc(sizeof(struct damon_sysfs_scheme_filter), GFP_KERNEL);
+}
+
 /* Should match with enum damos_filter_type */
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
@@ -392,6 +397,7 @@ static struct kobj_type damon_sysfs_scheme_filter_ktype = {
 
 struct damon_sysfs_scheme_filters {
 	struct kobject kobj;
+	struct damon_sysfs_scheme_filter **filters_arr;
 	int nr;
 };
 
@@ -401,6 +407,57 @@ damon_sysfs_scheme_filters_alloc(void)
 	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
 }
 
+static void damon_sysfs_scheme_filters_rm_dirs(
+		struct damon_sysfs_scheme_filters *filters)
+{
+	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
+	int i;
+
+	for (i = 0; i < filters->nr; i++)
+		kobject_put(&filters_arr[i]->kobj);
+	filters->nr = 0;
+	kfree(filters_arr);
+	filters->filters_arr = NULL;
+}
+
+static int damon_sysfs_scheme_filters_add_dirs(
+		struct damon_sysfs_scheme_filters *filters, int nr_filters)
+{
+	struct damon_sysfs_scheme_filter **filters_arr, *filter;
+	int err, i;
+
+	damon_sysfs_scheme_filters_rm_dirs(filters);
+	if (!nr_filters)
+		return 0;
+
+	filters_arr = kmalloc_array(nr_filters, sizeof(*filters_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!filters_arr)
+		return -ENOMEM;
+	filters->filters_arr = filters_arr;
+
+	for (i = 0; i < nr_filters; i++) {
+		filter = damon_sysfs_scheme_filter_alloc();
+		if (!filter) {
+			damon_sysfs_scheme_filters_rm_dirs(filters);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&filter->kobj,
+				&damon_sysfs_scheme_filter_ktype,
+				&filters->kobj, "%d", i);
+		if (err) {
+			kobject_put(&filter->kobj);
+			damon_sysfs_scheme_filters_rm_dirs(filters);
+			return err;
+		}
+
+		filters_arr[i] = filter;
+		filters->nr++;
+	}
+	return 0;
+}
+
 static ssize_t nr_filters_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -413,6 +470,7 @@ static ssize_t nr_filters_show(struct kobject *kobj,
 static ssize_t nr_filters_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
+	struct damon_sysfs_scheme_filters *filters;
 	int nr, err = kstrtoint(buf, 0, &nr);
 
 	if (err)
@@ -420,6 +478,15 @@ static ssize_t nr_filters_store(struct kobject *kobj,
 	if (nr < 0)
 		return -EINVAL;
 
+	filters = container_of(kobj, struct damon_sysfs_scheme_filters, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damon_sysfs_scheme_filters_add_dirs(filters, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
 	return count;
 }
 
@@ -1166,6 +1233,7 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
 	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	kobject_put(&scheme->watermarks->kobj);
+	damon_sysfs_scheme_filters_rm_dirs(scheme->filters);
 	kobject_put(&scheme->filters->kobj);
 	kobject_put(&scheme->stats->kobj);
 	damon_sysfs_scheme_regions_rm_dirs(scheme->tried_regions);
-- 
2.25.1

