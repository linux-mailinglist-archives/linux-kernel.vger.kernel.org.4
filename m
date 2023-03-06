Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBA6AD1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCFWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCFWmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:42:16 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62D82AA4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:54 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q24-20020a17090a2e1800b00237c37964d4so7060816pjd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1N1Z8zVIXipYiULB/HP9W6AmAVLLJyV6vBxJYQxV+M=;
        b=FfApUJ58/AuBXxawVuRox/02qb6FsGRX+7YTDtxPU77jaZJBO4CnYJ1tmTBRvQoTf4
         1WxdM0Of9MHAMx7Iss3kdWr8ZALDta22kOBWVqiTaxdJ74ntgdGRN2qB0TvXnC7I/0DJ
         DKAOzvDiaXDO5KEGXKY8UECBsHAYEqJ3tyk786Zz1nA9hk88HjSUnQTCvIGVNTjyVyy+
         5Y3kjVTQAHALJm6tEh1ATDL4UpbYfcP1+OeksxLByOk0BGJfcJ+oj1jxbAPaJfx7D6EB
         3j0pXjmg8Bmy4YsD37thgFNRRjZd3v7whTdsYWmtsVHeTVu+dL5SruQ2kAGNnnPXe40q
         Vveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1N1Z8zVIXipYiULB/HP9W6AmAVLLJyV6vBxJYQxV+M=;
        b=R9EHvJVqo3OPUjzE8Khxwz3DASUnVIxU1Q4D3HxPge6B9ttBQ0OPBiN5gXza7MOzik
         J6eFmxNPoBThI/g4v+6czX3AsRyETE6QYYYS0sGJdyIOWS5+mKniQuY5dbhmSKCBiJJV
         dfdgAWVrLHbDvyvJEq3Ui0fS4r462dXt/zOEzjGxSmdTN2puyPeCLOftNftpCCnKy2rg
         JGwmcg+OBsSJB4PRsb37zDsfxZY0TdAOwXCJ5M7OqmDd3+dMP/bc9RbC93EEznwyeISZ
         kQ1ehzWNt+0o3P8wJcsuuDS2KaNI/bCFuyeHsSVcLIEjshoB1fWyxcBMkEpocDsd4Lst
         18Yg==
X-Gm-Message-State: AO0yUKX3gFZKvnDC5PhFPi8dgrw2PQY+oLwybEcpfFngmRQN0wErcs2I
        5d+6R+KdrZk4M21TG3hnUHmWH/XYggBw
X-Google-Smtp-Source: AK7set8snFnyvhJ+XXtlE8UT1yhT6chY+2StfCzR+MgJQQLYlG/aXCTvrRYV3Hglo9Y68BVO2tl7+OkABeGg
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a62:8245:0:b0:5a8:b093:ff67 with SMTP id
 w66-20020a628245000000b005a8b093ff67mr5451354pfd.4.1678142513657; Mon, 06 Mar
 2023 14:41:53 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:20 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-12-vipinsh@google.com>
Subject: [Patch v4 11/18] KVM: x86/mmu: Add documentation of NUMA aware page
 table capability
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for KVM_CAP_NUMA_AWARE_PAGE_TABLE capability and
explain why it is needed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 Documentation/virt/kvm/api.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 62de0768d6aa..7e3a1299ca8e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7669,6 +7669,35 @@ This capability is aimed to mitigate the threat that malicious VMs can
 cause CPU stuck (due to event windows don't open up) and make the CPU
 unavailable to host or other VMs.
 
+7.34 KVM_CAP_NUMA_AWARE_PAGE_TABLE
+------------------------------
+
+:Architectures: x86
+:Target: VM
+:Returns: 0 on success, -EINVAL if vCPUs are already created.
+
+This capability allows userspace to enable NUMA aware page tables allocations.
+NUMA aware page tables are disabled by default. Once enabled, prior to vCPU
+creation, any page table allocated during the life of a VM will be allocated
+preferably from the NUMA node of the leaf page.
+
+Without this capability, default feature is to use current thread mempolicy and
+allocate page table based on that.
+
+This capability is useful to improve page accesses by a guest. For example, an
+initialization thread which access lots of remote memory and ends up creating
+page tables on local NUMA node, or some service thread allocates memory on
+remote NUMA nodes and later worker/background threads accessing that memory
+will end up accessing remote NUMA node page tables. So, a multi NUMA node
+guest, can with high confidence access local memory faster instead of going
+through remote page tables first.
+
+This capability is also helpful for host to reduce live migration impact when
+splitting huge pages during dirty log operations. If the thread splitting huge
+page is on remote NUMA node it will create page tables on remote node. Even if
+guest is careful in making sure that it only access local memory they will end
+up accessing remote page tables.
+
 8. Other capabilities.
 ======================
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

