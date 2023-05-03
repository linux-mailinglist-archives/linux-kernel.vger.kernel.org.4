Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2576F6225
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjECXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjECXjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C1902E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683157098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+hnDTiFptpp0wY89WivAhn6oJplw+7n7FAUqnfvNKTk=;
        b=Oo2gODbWz781Rah1g0x4UHjuTs+X0kbTYEe2Dx6DrxPH+61LR60Hbk+x70JxCSN5maMFUm
        GyeBMsYP3P5LDVMcAyn8M0uGnFeiPUdixxGdpuIIkqXEVCpin/Y2OnTnCuNAMTfRWCE3WQ
        e3PnZ+JTU5TDU7VQngDNfvV98hObD8A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-tYZudwhfMLCf1ivWulXdIg-1; Wed, 03 May 2023 19:38:16 -0400
X-MC-Unique: tYZudwhfMLCf1ivWulXdIg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ea572ef499so4363326d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 16:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157095; x=1685749095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hnDTiFptpp0wY89WivAhn6oJplw+7n7FAUqnfvNKTk=;
        b=ejrgBceThRisTbhlQKNR3uf5hMOh2QCseDQ/5J/kut4apdQXnt8thmbsNRn/K14Fv0
         lAmpxwvkrY9t9w5iSYwR6CFMHeW7eOfpR8mneN6OukorCsvSWnHnbs7iJow1tWFnIo3R
         PyITIFJ4p4+orx56F/6cID57eZZUBgZOTf3SjCkLiKknJPQirVwf0vRRihLrObaARAIg
         cMuiCjm6c15DH1kFHJFLoEJH2T9fOjJkvg6Lqd+SNKBmX2FedomPeXQTC1C8j0RoMIbi
         nWyoQ7+LY+NHVuGJGxUCwi7co31SC/jr+8I16454DJ3rdiwh/OLKTe9Cjhgk/hb8O2eA
         QbtQ==
X-Gm-Message-State: AC+VfDy07SQ8vKvgxJlRNFDog6r6KeyW4XMI6rYi38k/hy6KvpM1kHOB
        Mnyvg9Wfa0iwtMKuT0raHxr6/sx6xu+9ECNI/dkmwLfhqJq22G40MNZ59fKrFf7nOPl9XiPgdWL
        irHijdABc4eOcQZzUFuCvwzNCnUQQyOIQrHs3qGl1LpHeL9yjhNHTUE+vHjDn8fxLiM4mWOWJED
        BCKK4rrQ==
X-Received: by 2002:a05:6214:5199:b0:616:870c:96b8 with SMTP id kl25-20020a056214519900b00616870c96b8mr29070335qvb.3.1683157095109;
        Wed, 03 May 2023 16:38:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Zq0U3hOSWcDejw17/+ECI8vQTrGk+JSwDDo8vtjeBuE/h+SQikxQcQ5A1dGTwx9NyTZs8iQ==
X-Received: by 2002:a05:6214:5199:b0:616:870c:96b8 with SMTP id kl25-20020a056214519900b00616870c96b8mr29070315qvb.3.1683157094789;
        Wed, 03 May 2023 16:38:14 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cdd12000000b005e1235e6f2esm10911718qvk.12.2023.05.03.16.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:38:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        James Houghton <jthoughton@google.com>,
        Anish Moorthy <amoorthy@google.com>
Subject: [PATCH] selftests/kvm: Allow specify physical cpu list in demand paging test
Date:   Wed,  3 May 2023 19:38:12 -0400
Message-Id: <20230503233812.2743269-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimic dirty log test to allow specify physical cpu pinning for vcpu threads.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index bdb8e0748154..d709b65fda2f 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -220,12 +220,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 static void help(char *name)
 {
 	puts("");
-	printf("usage: %s [-h] [-m vm_mode] [-u uffd_mode] [-a]\n"
+	printf("usage: %s [-h] [-m vm_mode] [-u uffd_mode] [-a] [-c cpu_list]\n"
 		   "          [-d uffd_delay_usec] [-r readers_per_uffd] [-b memory]\n"
 		   "          [-s type] [-v vcpus] [-o]\n", name);
 	guest_modes_help();
 	printf(" -u: use userfaultfd to handle vCPU page faults. Mode is a\n"
 	       "     UFFD registration mode: 'MISSING' or 'MINOR'.\n");
+	printf(" -c: physical cores to pin vcpu threads (e.g. 1,2,3,...)\n");
 	printf(" -a: Use a single userfaultfd for all of guest memory, instead of\n"
 		   "     creating one for each region paged by a unique vCPU\n"
 		   "     Set implicitly with -o, and no effect without -u.\n");
@@ -247,6 +248,7 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	const char *cpulist = NULL;
 	struct test_params p = {
 		.src_type = DEFAULT_VM_MEM_SRC,
 		.partition_vcpu_memory_access = true,
@@ -257,7 +259,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ahom:u:d:b:s:v:r:")) != -1) {
+	while ((opt = getopt(argc, argv, "ac:hom:u:d:b:s:v:r:")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -272,6 +274,9 @@ int main(int argc, char *argv[])
 		case 'a':
 			p.single_uffd = true;
 			break;
+		case 'c':
+			cpulist = optarg;
+			break;
 		case 'd':
 			p.uffd_delay = strtoul(optarg, NULL, 0);
 			TEST_ASSERT(p.uffd_delay >= 0, "A negative UFFD delay is not supported.");
@@ -309,6 +314,12 @@ int main(int argc, char *argv[])
 		TEST_FAIL("userfaultfd MINOR mode requires shared memory; pick a different -s");
 	}
 
+	if (cpulist) {
+		kvm_parse_vcpu_pinning(cpulist, memstress_args.vcpu_to_pcpu,
+				       nr_vcpus);
+		memstress_args.pin_vcpus = true;
+	}
+
 	for_each_guest_mode(run_test, &p);
 
 	return 0;
-- 
2.39.1

