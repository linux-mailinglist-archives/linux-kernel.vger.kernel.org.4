Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7446D0768
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjC3N40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjC3N4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:56:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462C9773
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5416d3a321eso189188817b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680184578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhHLbziee4a81RNVkwycWkVgS8ETVW18Svhu+GP0co8=;
        b=TyIuTP4E/yt61TucQWoc7ll1E7roUOPolzxGJTLTcqFDT2S/awduj2ZxA31PhqG1eF
         pViFXGegRdXk1ZTQ1OZiFE84LpP8jzsgn5zGDzv8AfrdWtz6bUP4a38bqGQjQBPJ7ZPH
         VkpbiejhTh9WxOtxYFgi2Qmq/M4rZEvietQrflSUdzWuJf++ttuV3FQxBs8pvHzOH7dS
         pIF9Zlu0Zj8zj2b8UjbcSAC+Qa2zita4jFlJyqqgUMuEAE0ugdalIvKQZ0IclWc6ztrh
         2J5QMvqUqijxIcADyhc2S97LPFZtPxcQJxl2OXorPFY8J7zdu5g4232yUJThobhUeYdo
         WN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhHLbziee4a81RNVkwycWkVgS8ETVW18Svhu+GP0co8=;
        b=h1Z4pKfq4Pcr5ZBR9ha4gqmHXfjk7LR1xQcEyMkVPR+WdbYDSuoOmqo+ijLdPh+JTU
         SKQQMw/rWMvV7OEJqzKqoJJKdJuzXZ0SBhGTBSucP/fzoM3VjSsV0s1mQv6wmIEqC648
         HMJ/usjnXwIE73DUp9OaUMWI7jdVmNXsjp+o3DKhMRhstZcDIizfzx3YE2BTWLvuufxr
         oC1d5UZTAaD/Qs/kFzQbJuXQYA8tBF7N4ikMHjAdIle9tFwnxnrh58jtCZ7/b3PKbEWv
         K8/ubMZZzkGmJe8k74HQW+qd7noZpc/idg+M1+Jmf1VH3y46RKZCDfjjT3pfqj7WpmyD
         ChLg==
X-Gm-Message-State: AAQBX9cK3Uv+jTA62R8EhRcJONcftwy7RTPa7KCHrwiFC5G6X5mNCWAC
        0a6TffFLUbC46RWQDPIIVb3RVkoqLxv8HxtDvg==
X-Google-Smtp-Source: AKy350a7NVHkW7b+E9eQZDgipTjPNuxq0WUrIjvNLjxZxx04gbqK2cynLJX6DcxdOG/OpZw/AYC6JOo5r4i58SQb1A==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a05:6902:1024:b0:b77:3f5a:8a53 with
 SMTP id x4-20020a056902102400b00b773f5a8a53mr11703160ybt.12.1680184578517;
 Thu, 30 Mar 2023 06:56:18 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:55:58 +0200
In-Reply-To: <20230330135558.1019658-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230330135558.1019658-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330135558.1019658-4-peternewman@google.com>
Subject: [PATCH v5 3/3] Documentation/x86: Documentation for MON group move feature
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe new support for moving MON groups to a new parent CTRL_MON
group and its restrictions.

Signed-off-by: Peter Newman <peternewman@google.com>
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
2.40.0.348.gf938b09366-goog

