Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C25FAD80
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJKHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJKHaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:30:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BC94D17F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:30:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f23so12447765plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXnUgcfBLglB+lvDTe8YnwsjeZcf2ivVVRRbAc6DYPM=;
        b=AhpI5ZJs5TSxELMbtWgbOcElxajihDyGzt+F5Yx8f5DubQHaVQyzObtIYHtPqNyUbT
         al9/ZumeQ3/0VYHmSZH2V5McuE7ZPRgjHHT3BdrqIOnv1Jqzt/jKtFWGNGVTBMcPfyDc
         HejhKgfQYjHpfg0vmcACwWOVO9mh/X9McKfqvnBUWMNirevMt4620kpXz9hg2so3xcjv
         Dyc+TLH24p/pzJVeOMWM5nC45NQrbMu6pjjjOw1Pr+Wu0ajyPlIhyM+sxsxoForUAUQz
         aAD23T35kYqGY9lnWgJMZLx8Kc4aSyhWhu6914SXXdTptUtsnBEETA/wQX30GQJ8H3XH
         2vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXnUgcfBLglB+lvDTe8YnwsjeZcf2ivVVRRbAc6DYPM=;
        b=HaqN4U3JUFOgYv2I0O9w/icGlzSalFTZva+wT0SsWI3r55F/1CK2mMlAMk+oUANlMY
         jau8DP2fhz5ZJiEXqfmLCW26eAOi8jwRDJP5e/+y2luiucWvJDmCn/6nWKPJ8OgIBq1R
         Oj9Q+vuQjo0f3wf05i8iRL0iQd8fqsOd0QA9ikGKkqZ/e8ASDC1VcO5NIlFP47wYybw8
         bIP4y6nOmqZoPOlFKmSQNqOutJ6A5G4a9WClaDmDpNzSuCcA8boQdhSbIIUAdgg9Qdeh
         RP5iRFRq3fBCiNyn4Jkm8jAuCYdyTGr9KLdRJBa0bv1lRmEo5INW7jt7PGQOinppkNAD
         s4xA==
X-Gm-Message-State: ACrzQf3+6qAxX145FU8XLSV9bNFzzV04f4/AudEDTyCooHFVGgAVkk8T
        /H6rRMXglTPTy3T9cu8qNtCJlwbYl0XHDh1/W0e3hA==
X-Google-Smtp-Source: AMsMyM4epbGzl7vH/xIIhaXv2nC0Y9kb67ikSJ7HeTSvkyzieiJOTwAzb+szI4SqNKGoIxFtJPCgVQ==
X-Received: by 2002:a17:90b:1c06:b0:20a:f070:9f3c with SMTP id oc6-20020a17090b1c0600b0020af0709f3cmr25626445pjb.151.1665473431422;
        Tue, 11 Oct 2022 00:30:31 -0700 (PDT)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b0017828ae6310sm7857315ple.2.2022.10.11.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 00:30:30 -0700 (PDT)
From:   "haifeng.xu" <haifeng.xu@shopee.com>
To:     hannes@cmpxchg.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, "haifeng.xu" <haifeng.xu@shopee.com>
Subject: [PATCH] cgroup: optimize the account of nr_cgrps
Date:   Tue, 11 Oct 2022 07:29:31 +0000
Message-Id: <20221011072931.10427-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use 'lscgroup' to account the number of cgroups in hierarchy,
we find that it's much less than the number showed by '/proc/cgroups'.

The reason is that the cgroup isn't freed even though remove the
directory, unless the percpu_ref of cgroup.self reaches zero.
For example, there are many page/buffer cache which obtain
references on the specified css. So only these memory are relcaimed,
the cgroup could be freed.

The cgroup is invisible for users after the corresponding directory
is removed. Therefore decrease the number of cgroups when call
'cgroup_rmdir'.

Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c37b8265c0a3..9443df5d86bb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5222,7 +5222,6 @@ static void css_free_rwork_fn(struct work_struct *work)
 			css_put(parent);
 	} else {
 		/* cgroup free path */
-		atomic_dec(&cgrp->root->nr_cgrps);
 		cgroup1_pidlist_destroy_all(cgrp);
 		cancel_work_sync(&cgrp->release_agent_work);
 
@@ -5781,6 +5780,7 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	/* clear and remove @cgrp dir, @cgrp has an extra ref on its kn */
 	css_clear_dir(&cgrp->self);
 	kernfs_remove(cgrp->kn);
+	atomic_dec(&cgrp->root->nr_cgrps);
 
 	if (cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
-- 
2.25.1

