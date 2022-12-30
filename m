Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6A659591
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiL3G7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiL3G7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:59:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1516012D34
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672383543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfQVFUk68QjEj99AgM4T7hbGZN2TqICY24ExGXMOCJA=;
        b=B2EpOZUHi1RFv0tFS7mdwq/eYWLP0mE9F6SUwAFegRzZGOyiU2heIN+n7Ky4ycNqZDH6yI
        G4UPDds4k6kdaCvPixHboso8Wct4I+ZNSulBeRYD86V/6jRasooAy0nrTk3n7kew4aEnSF
        3IQW2XcFdo7T2d2JPbu1/oYixVAescY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-i78ZC5LbOQeQm6l-gSX4NQ-1; Fri, 30 Dec 2022 01:59:01 -0500
X-MC-Unique: i78ZC5LbOQeQm6l-gSX4NQ-1
Received: by mail-pl1-f200.google.com with SMTP id i4-20020a17090332c400b0018f82951826so15308486plr.20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 22:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfQVFUk68QjEj99AgM4T7hbGZN2TqICY24ExGXMOCJA=;
        b=SGfxZ/EOtxef2l+11NAAma4rTONwhXTPG7lfGep1GJITB1uxtucULtOixiICkZJbbm
         Jsy4UBuYgh0h0pKfJRR7ec5hAbco/RlzXKHZI4fRZGFwmA3Yj4zFRIBUmf86anMEOrIg
         m9ZVVxCmHfO0+v0HqLx/h4Xr01hMYoDJttstaLkJbi+gVNqRcU4ywRF3DA0kVM5Tjy/P
         I98YbXqTQnBAS/VnI3FosgdbqRLBnxWea1Bv9J6300noc2CbNnx+cNB9e5PimmdzB1e+
         LWtebKH6QqaVJS3TNtVpnLO3T48WcifqcySKMVx0rvQEUPtcdx4LPgKDFydrzM0nwyT7
         KwRw==
X-Gm-Message-State: AFqh2koMy/0sOsPgmc47GREusJHZDJ8730Y5YeW2k9GRR/1v+tSQHvL8
        D0+p/kZQ3DCwQrm/ida+vDIfYEjEN5bWB8fzTO4xp55brdBKsUzaMvaRxqMfmJJBCG7V+c3MTw+
        rz5KMiJW1X6KY06Ly6z36R1kg
X-Received: by 2002:a17:902:d3d3:b0:192:8f38:7492 with SMTP id w19-20020a170902d3d300b001928f387492mr10901741plb.13.1672383539827;
        Thu, 29 Dec 2022 22:58:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvgQSu4eJrF7t9Ee8jFtrdmW2Mfrqq37xxbhi3CqTIuwlP91hv2uCBIjFGbYTi7mF+inP0IYw==
X-Received: by 2002:a17:902:d3d3:b0:192:8f38:7492 with SMTP id w19-20020a170902d3d300b001928f387492mr10901731plb.13.1672383539523;
        Thu, 29 Dec 2022 22:58:59 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b00176e6f553efsm14012757plb.84.2022.12.29.22.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 22:58:59 -0800 (PST)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] selftests/kexec: enable lockdown tests
Date:   Fri, 30 Dec 2022 14:58:50 +0800
Message-Id: <20221230065850.897967-2-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230065850.897967-1-coxu@redhat.com>
References: <20221230065850.897967-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When lockdown is enabled, kexec_load syscall should always fail.

For kexec_file_load, when lockdown is enabled, it should
 - fail of missing PE signature when KEXEC_SIG is enabled
 - fail of missing IMA signature when KEXEC_SIG is disabled

Before this patch, test_kexec_load.sh fails (false positive) and
test_kexec_file_load.sh fails without a reason when lockdown enabled and
KEXEC_SIG disabled,

    # kexec_load failed [FAIL]
    not ok 1 selftests: kexec: test_kexec_load.sh # exit=1
    # kexec_file_load failed [PASS]
    ok 2 selftests: kexec: test_kexec_file_load.sh

After this patch, test_kexec_load.sh succeeds and
test_kexec_file_load.sh fails with the correct reason when lockdown
enabled and KEXEC_SIG disabled,

    # kexec_load failed [PASS]
    ok 1 selftests: kexec: test_kexec_load.sh
    # kexec_file_load failed (missing IMA sig) [PASS]
    ok 2 selftests: kexec: test_kexec_file_load.sh

Cc: kexec@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 .../selftests/kexec/kexec_common_lib.sh       | 16 +++++++++++
 .../selftests/kexec/test_kexec_file_load.sh   | 27 +++++++++++++++++++
 .../selftests/kexec/test_kexec_load.sh        | 12 ++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 641ef05863b2..06c298b46788 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -110,6 +110,22 @@ get_secureboot_mode()
 	return $secureboot_mode;
 }
 
+is_lockdown_enabled()
+{
+	local ret=0
+
+	if [ -f /sys/kernel/security/lockdown ] \
+	     && ! grep -qs "\[none\]" /sys/kernel/security/lockdown; then
+		ret=1
+	fi
+
+	if [ $ret -eq 0 ]; then
+		log_info "lockdown not enabled"
+	fi
+
+	return $ret
+}
+
 require_root_privileges()
 {
 	if [ $(id -ru) -ne 0 ]; then
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index c9ccb3c93d72..790f96938083 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -139,6 +139,16 @@ kexec_file_load_test()
 			log_fail "$succeed_msg (missing IMA sig)"
 		fi
 
+		if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 1 ] \
+		     && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing PE sig)"
+		fi
+
+		if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 0 ] && [ $ima_signed -eq 0 ] \
+		     && [ $ima_modsig -eq 0 ]; then
+			log_fail "$succeed_msg (missing IMA sig)"
+		fi
+
 		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
 		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
 	            && [ $ima_read_policy -eq 0 ]; then
@@ -181,6 +191,16 @@ kexec_file_load_test()
 		log_pass "$failed_msg (possibly missing IMA sig)"
 	fi
 
+	if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 1 ] \
+	    && [ $pe_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing PE sig)"
+	fi
+
+	if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 0 ] \
+	    && [ $ima_signed -eq 0 ] && [ $ima_modsig -eq 0 ]; then
+		log_pass "$failed_msg (missing IMA sig)"
+	fi
+
 	log_pass "$failed_msg"
 	return 0
 }
@@ -215,6 +235,10 @@ kconfig_enabled "CONFIG_KEXEC_SIG_FORCE=y" \
 	"kexec signed kernel image required"
 kexec_sig_required=$?
 
+kconfig_enabled "CONFIG_KEXEC_SIG=y" \
+	"KEXEC_SIG enabled"
+kexec_sig_enabled=$?
+
 kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
 	"PE signed kernel image required"
 pe_sig_required=$?
@@ -225,6 +249,9 @@ ima_sig_required=$?
 get_secureboot_mode
 secureboot=$?
 
+is_lockdown_enabled
+lockdown=$?
+
 # Are there pe and ima signatures
 if [ "$(get_arch)" == 'ppc64le' ]; then
 	pe_signed=0
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 49c6aa929137..0542887866c0 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -28,18 +28,24 @@ arch_policy=$?
 get_secureboot_mode
 secureboot=$?
 
-# kexec_load should fail in secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
+is_lockdown_enabled
+lockdown=$?
+
+# kexec_load should fail in either
+#   a) secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
+# or
+#   b) lockdown enabled
 kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
-	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
+	if [ $secureboot -eq 1 -a $arch_policy -eq 1 ] || [ $lockdown -eq 1 ]; then
 		log_fail "kexec_load succeeded"
 	elif [ $ima_appraise -eq 0 -o $arch_policy -eq 0 ]; then
 		log_info "Either IMA or the IMA arch policy is not enabled"
 	fi
 	log_pass "kexec_load succeeded"
 else
-	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] ; then
+	if [ $secureboot -eq 1 -a $arch_policy -eq 1 ] || [ $lockdown -eq 1 ]; then
 		log_pass "kexec_load failed"
 	else
 		log_fail "kexec_load failed"
-- 
2.38.1

