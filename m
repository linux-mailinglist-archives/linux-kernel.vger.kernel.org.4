Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564768A79D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjBDBqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBDBqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:46:01 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FFA07E7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 17:45:59 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b5-20020a170902d50500b00198f3be5233so63865plg.16
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9txupr188ZTVd9BV3x/AfFp8ENAeoHM2ArlGZz6pP2I=;
        b=bh0FhrsUKAKtYjvDabTdX+NurC1Th/ssoT5Gtf1eqVB3h9Uvhy5AynVg/c91SLmLy9
         EUHAwwHFtGeGl3cmkJE8y1Zo6ubnc7mdkDifRhzHdp9SFWp/gKV7vrKgIC/1wa7lEfSS
         bX8ECGmQxTW9H1lQAAfkW/XR5TjQKVPzGJmQFchON/7+n7wgUAx83dUSSqNrN1bWlv2D
         QZjgsT0tmOdS6jPbB29xUC7bZ6eYg0qn6xi9/KNYcz15C2JAZRwjlgjh/BK3gZYN0NVB
         CagvdCPu3qvkrdDi6e/0BFwijDU5clA5M5w01dP7ssczW8xMJCEjUwcSMsv5GbDLdARH
         6iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9txupr188ZTVd9BV3x/AfFp8ENAeoHM2ArlGZz6pP2I=;
        b=t8o7EtENpwq3es1bbSnXpxCpYwKqbHTIcn+Rz3LXJh5psyHgcun634dAXGn0ByxMHW
         nxZftqDWIKXGApz4h9AP8/Q3Bs5+LgXMeGxdcj2DbMDhpfGov45ELadp9hTsE211Aqgq
         sTwRqaHC6Ghi/SV/e7/mMb0B5hgdwruqsjgwbH7W4qdxmTdQDRXRWa9szn4YTtyTPSty
         hUKxnE1jzYMi4xjPbrrgIMsu5qyuCNermkChbKHO9X3M33i4j9m5T7ZMKTPj3aLA9gPB
         D08bAbd5armX4l4f7qVmKIFPBiB/ArA5TRh5QjYv6DywX36wIO1TMKaMerB4BBURD+7r
         c41g==
X-Gm-Message-State: AO0yUKVLP6XnJn6SNJZceXNyCrV7rEochDefXJCNjenMH1ZL2RtNxEcz
        s/oRd379d8xBnJiyikNCz+n96xKFexbw
X-Google-Smtp-Source: AK7set/BTTGppmnG3b1n/slVqEy5BCFND002TxMB6M5j3GGGsdubelBDsPr5zS7D2XInQwuUyvQjw1K+iZzS
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:903:20f:b0:194:6417:cd27 with SMTP id
 r15-20020a170903020f00b001946417cd27mr3003637plh.34.1675475158564; Fri, 03
 Feb 2023 17:45:58 -0800 (PST)
Date:   Fri,  3 Feb 2023 17:45:45 -0800
In-Reply-To: <20230204014547.583711-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230204014547.583711-1-vipinsh@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230204014547.583711-3-vipinsh@google.com>
Subject: [Patch v2 2/4] KVM: selftests: Print expected and actual exit reason
 in KVM exit reason assert
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, maz@kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com,
        oliver.upton@linux.dev, yuzenghui@huawei.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
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

Print what KVM exit reason a test was expecting and what it actually
got int TEST_ASSERT_KVM_EXIT_REASON().

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a13663557e2b..a6e9f215ce70 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -67,7 +67,8 @@ void test_assert(bool exp, const char *exp_str,
 	__u32 exit_reason = (vcpu)->run->exit_reason;			\
 									\
 	TEST_ASSERT(exit_reason == (expected),				\
-		    "Unexpected exit reason: %u (%s)",			\
+		    "Wanted KVM exit reason: %u (%s), got: %u (%s)",    \
+		    (expected), exit_reason_str((expected)),		\
 		    exit_reason, exit_reason_str(exit_reason));		\
 } while (0)
 
-- 
2.39.1.519.gcb327c4b5f-goog

