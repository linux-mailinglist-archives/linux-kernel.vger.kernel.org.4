Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F236B186A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCIBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCIBDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:03:49 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388791B6C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:03:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id d34-20020a630e22000000b005039e28b68cso62598pgl.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 17:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678323821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eLrm9fDiRBcPQp3b31j/DpW4EfSCKANv/2wGm8l5Z0w=;
        b=FI11iTobWjTUbGawAnDCrACDLyZdJVydKvQZlRejApyFnD6DqtNLx9JxKXgN4ISNXZ
         aV2ZyUvIGNeuRnY9WRYjTVVTyjcDStqsOMeC2V3Ndr+7WBn3DGcAypV/sv7VlF3S01eC
         50yXbaCXhmBLX6I/4qZVz8Uct8YPhnokFmt9aVwu4SVUadmHAtmXkF3A80kikj/31Foi
         2hDsnPSObNSQS+wT3sBE9Q/ZWHZoPKdvxKOhnR9KeYtFLLqWgQwCNbPtulUMCyjh8kGU
         qAHyV6ez8Ht//J24sPk+92ZMuBi/ycUc2/C36lnOKOAxOba3n7vknI0/6tr1rCsfGckb
         HZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678323821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLrm9fDiRBcPQp3b31j/DpW4EfSCKANv/2wGm8l5Z0w=;
        b=AafIKsxuMQ0Nnd18JrK8bpM2xjg+zzZAOLbjRCdh1i5wQGPF4tS57PRTv/8zsuIqOQ
         kUw1h8PAtdquXRBhp6nrqjE8QMrqnN8p5+ZAs6HvKytox/DYkxbpQBm00gqcRZgbgd/y
         cd7awrYXpLE+P4Tx3nn6+hmvvt8Bhkoo2ejth2FDs+3NU5s+PUg6uSgsK3ggDroG1pzA
         VvGtOzbvSV2yieXJKv4Uz7w6f9MwiSLU1oolPlmOJ1yo1kdUaWfkPHI39WxqfaIoTC54
         xKNt8elTJtcKLQf0/BEkWyt5Hg1pXZVhGtk59tEQnxcHS4MyF2ApYNFeqxdKHJs31bik
         Jqeg==
X-Gm-Message-State: AO0yUKVIDPtu1tskFmSR0M9gOby/g0UkqwBYsvfTEUVracnYNo1BanF4
        /4/LHMPmyvjOLpdGPF0V5yr1bbRfcT4=
X-Google-Smtp-Source: AK7set9pjM4WjDhtCijXKLdAzulTvTyMZDnBV+LVC3pXBtYjx4Xm0BGS2RlOlvl5eBNwp1vXLFdTABoe+7w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:278d:b0:19c:1869:3558 with SMTP id
 jw13-20020a170903278d00b0019c18693558mr7700376plb.5.1678323821086; Wed, 08
 Mar 2023 17:03:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Mar 2023 17:03:35 -0800
In-Reply-To: <20230309010336.519123-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230309010336.519123-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230309010336.519123-2-seanjc@google.com>
Subject: [PATCH v2 1/2] Documentation/process: Add a label for the tip tree
 handbook's coding style
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Shier <pshier@google.com>,
        Anish Ghulati <aghulati@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Anish Moorthy <amoorthy@google.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Babu Moger <babu.moger@amd.com>, Chao Gao <chao.gao@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Guang Zeng <guang.zeng@intel.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jing Liu <jing2.liu@intel.com>,
        Junaid Shahid <junaids@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Leonardo Bras <leobras@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Li RongQing <lirongqing@baidu.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Luczaj <mhal@rbox.co>,
        Mingwei Zhang <mizhang@google.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Paul Durrant <pdurrant@amazon.com>,
        Peng Hao <flyingpenghao@gmail.com>,
        Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>,
        Robert Hoo <robert.hu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Add a label for the tip tree's "Coding style notes" so that a forthcoming
KVM x86 handbook can reference/piggyback the tip tree's preferred coding
style.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/process/maintainer-tip.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 572a3289c9cb..ad0540d6882b 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -452,6 +452,8 @@ and can be added to an existing kernel config by running:
 Some of these options are x86-specific and can be left out when testing
 on other architectures.
 
+.. _maintainer-tip-coding-style:
+
 Coding style notes
 ------------------
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

