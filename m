Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D954B6E79FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDSMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjDSMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:50:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA1B76B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8b46f399so196280237b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681908646; x=1684500646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxACaIFQGSNpRzNrd0szUQtmVWzyEP8n7N2A/6ory1w=;
        b=f8BJoFC7tHMQtMMZnfHw8I7h0dvExKxzjkvC1CMzEqKyAmbkh0GKgpFLaAWbEVpRjA
         KwfORX59VwoQc9As8pK/qPW6dAwLa0GNz5YGckzd2SxjJAB+WusEdU5iE9hLk6K40ddH
         ewr//TybzLFRVfXLg43mMTSXfIThG52oMVeKsfCAnfnBfKGzuikbe8QyrRSsxmhsBMhm
         Tbuqw/GX+fnSmwH6+sk1ehjQgOV2M7TStxE5Cu6h1H1Xnn+tKVwb/Ft/TycpMOP5gvgD
         Lee6Gl6yu5sPMpAHI7kNDmwgdQYDFy1pHTXuYqKuSGsxnu1+HBkxrkyzN37oY0dSXHWK
         9vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908646; x=1684500646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxACaIFQGSNpRzNrd0szUQtmVWzyEP8n7N2A/6ory1w=;
        b=DVK7ovFmHkKEFkZpN6u/ZbehZQL9OlVhwSP9a7hCgvzk954WrkJaNRfENPS92V7NGn
         tAJr3LgM2QC9tMooxtWd2uLcCu4zi8TQxu03yjGdAX+ABbc9KD8ZjdGS2RBqY87jIpJV
         6HcntZIY3OFvYqT9Gn4PqMMqd6He36kBtwj1hXWu71TSvm0USQyNTWceD2hsWlXPxjUW
         pKceL2DUzgZ3KZf/c8wnSsyJK2OTgqkkTXpPAT+aF22b1VkqV/c+2xH586Yx/zWnpECt
         Ea+bPb6kLZnXZpnZacytwxKr455LpRpo8jSpdDWYGba55wxctUw60rGfgZRLo30BXfla
         s/ZQ==
X-Gm-Message-State: AAQBX9dn0WW74qmxiiQu/uztr3lt3JA5WL07KdC62SkclGi4t2izS4Qp
        syhTkOR/CHYf1/jdGG1gnCxhOfSstKy9ngdGJA==
X-Google-Smtp-Source: AKy350bCA68l2s/hyXv+80wcZIx+NsacgD3N8B5t1pOuM2ss3p58l/o9YBIxQPYG61AMyYvrkXbrRuBqKnLcwwOxgg==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:b36e:a25e:826d:b66a])
 (user=peternewman job=sendgmr) by 2002:a25:d256:0:b0:b95:6caa:a2cb with SMTP
 id j83-20020a25d256000000b00b956caaa2cbmr3621411ybg.10.1681908646729; Wed, 19
 Apr 2023 05:50:46 -0700 (PDT)
Date:   Wed, 19 Apr 2023 14:50:15 +0200
In-Reply-To: <20230419125015.693566-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230419125015.693566-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419125015.693566-4-peternewman@google.com>
Subject: [PATCH v6 3/3] Documentation/x86: Documentation for MON group move feature
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe new support for moving MON groups to a new parent CTRL_MON
group and its restrictions.

Signed-off-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/resctrl.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 387ccbcb558f..cb05d90111b4 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -287,6 +287,13 @@ Removing a directory will move all tasks and cpus owned by the group it
 represents to the parent. Removing one of the created CTRL_MON groups
 will automatically remove all MON groups below it.
 
+Moving MON group directories to a new parent CTRL_MON group is supported
+for the purpose of changing the resource allocations of a MON group
+without impacting its monitoring data or assigned tasks. This operation
+is not allowed for MON groups which monitor CPUs. No other move
+operation is currently allowed other than simply renaming a CTRL_MON or
+MON group.
+
 All groups contain the following files:
 
 "tasks":
-- 
2.40.0.634.g4ca3ef3211-goog

