Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659026E338B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDOUbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7264F35AE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E0D16111F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 20:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA2C433EF;
        Sat, 15 Apr 2023 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681590673;
        bh=i5GIioSf0Xagm1uczfllya6UUnQgFEnr94mjAe6aR1k=;
        h=From:To:Cc:Subject:Date:From;
        b=KidSGpB/qqYjRRsKOrGI1vKoD7GttY1sahsPLKin7Q/O6JExL6qG8Gt8JODqNxxRb
         NVqzPRgTwVP0B6QpfPxy74DdnBAhhODjkS6I9CCKaLoKmdUYbtvSOfwPq16AxOS1kZ
         zvEuQaIKUV2cWiP1H7jKLJbDQjHWVavOh9PEFBptECHWkMw0DytjqmZEA34GJ/sWVM
         gSPMDBb/8PHPnWv46EQLyIXDx3i6AMNzk7kqb16u+LNx9gcenvHRw93sAzDLuEJLpS
         jbIwjo2paToG6pnbHGrAi0l5WYVV521s5r0qKyOOba2pvOzVJq5sD04ARq4UJNVp0U
         qzXQcbyeF/Hhg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Ricardo Pardini <ricardo@pardini.net>
Subject: [PATCH] tools/Makefile: do missed s/vm/mm/
Date:   Sat, 15 Apr 2023 20:31:10 +0000
Message-Id: <20230415203110.13858-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 799fb82aa132 ("tools/vm: rename tools/vm to tools/mm") missed
renaming 'vm' in 'tools/Makefile' to 'mm'.  As a result, 'make clean'
under 'tools/' directory fails as below:

    $ make -C tools clean
      DESCEND vm
    make[1]: Entering directory '/linux/tools/vm'
    make[1]: *** No rule to make target 'clean'.  Stop.
    make[1]: Leaving directory '/linux/tools/vm'
    make: *** [Makefile:173: vm_clean] Error 2
    make: Leaving directory '/linux/tools'

Do the missed rename.

Reported-by: Ricardo Pardini <ricardo@pardini.net>
Link: https://lore.kernel.org/linux-mm/20230415202454.13558-1-sj@kernel.org/
Fixes: 799fb82aa132 ("tools/vm: rename tools/vm to tools/mm")
Tested-by: Ricardo Pardini <ricardo@pardini.net>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index e497875fc7e3..37e9f6804832 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -39,7 +39,7 @@ help:
 	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
 	@echo '  usb                    - USB testing tools'
 	@echo '  virtio                 - vhost test module'
-	@echo '  vm                     - misc vm tools'
+	@echo '  mm                     - misc mm tools'
 	@echo '  wmi			- WMI interface examples'
 	@echo '  x86_energy_perf_policy - Intel energy policy tool'
 	@echo ''
@@ -69,7 +69,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+cgroup counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -118,7 +118,7 @@ kvm_stat: FORCE
 
 all: acpi cgroup counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
-		virtio vm bpf x86_energy_perf_policy \
+		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
 		pci debugging tracing thermal thermometer thermal-engine
 
@@ -128,7 +128,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -158,7 +158,7 @@ kvm_stat_install:
 install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install \
 		perf_install selftests_install turbostat_install usb_install \
-		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
+		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install pci_install debugging_install intel-speed-select_install \
 		tracing_install thermometer_install thermal-engine_install
@@ -169,7 +169,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -211,7 +211,7 @@ build_clean:
 
 clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
-		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
+		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
 		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean
-- 
2.25.1

