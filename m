Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF66E0F05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDMNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDMNlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:41:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C7AD14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:38:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Py0yH4GVfz4xDp;
        Thu, 13 Apr 2023 23:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681393081;
        bh=D6Yngrhf/77tbyzUv4PHE1XGjdrZLdCsqxFpA13UCAc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DE1UbYm3G/dtwFS3saRQY9viWkm9YPf6SYiwBKDezYKRSZsoGJluHPEiDVazFNVrX
         fq0CsWzpl6jsdpkLr4x1ITotU2R/RhlLKfEcBzDggs50gaFgJ2egum+6YHgqKaV7WG
         ArZm5tX2ZJ2U4/+IhNW07HBRxDur2c+MvnR9DJ5B1+7oWMZO8ONqLrO3sGOD9N3K+t
         KdfagfefIKVTYPfqqaHbYWYgLkr4efpVK9ANA5EoqXTAREVamcEVEvGbH9xqe7ssQI
         e7B21Qxau0K/G+TTnRco/wnq+MiHJux6HZN+vGZnsLtHDgTW2fXs9zbJuqHOLBv0IY
         aAV4xJfaMFMJw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     msuchanek@suse.de, nathanl@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pseries/smp: export the smt level in the SYS FS.
In-Reply-To: <20230331153905.31698-2-ldufour@linux.ibm.com>
References: <20230331153905.31698-1-ldufour@linux.ibm.com>
 <20230331153905.31698-2-ldufour@linux.ibm.com>
Date:   Thu, 13 Apr 2023 23:37:59 +1000
Message-ID: <87ttxjaonc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Laurent Dufour <ldufour@linux.ibm.com> writes:
> There is no SMT level recorded in the kernel neither in user space.
> Indeed there is no real constraint about that and mixed SMT levels are
> allowed and system is working fine this way.
>
> However when new CPU are added, the kernel is onlining all the threads
> which is leading to mixed SMT levels and confuse end user a bit.
>
> To prevent this exports a SMT level from the kernel so user space
> application like the energy daemon, could read it to adjust their settings.
> There is no action unless recording the value when a SMT value is written
> into the new sysfs entry. User space applications like ppc64_cpu should
> update the sysfs when changing the SMT level to keep the system consistent.
>
> Suggested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/pseries.h |  3 ++
>  arch/powerpc/platforms/pseries/smp.c     | 39 ++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

There is a generic sysfs interface for smt in /sys/devices/system/cpu/smt

I think we should be enabling that on powerpc and then adapting it to
our needs, rather than adding a pseries specific file.

Currently the generic code is only aware of SMT on/off, so it would need
to be taught about SMT4 and 8 at least.

There are already hooks in the generic code to check the SMT level when
bringing CPUs up, see cpu_smt_allowed(), they may work for the pseries
hotplug case too, though maybe we need some additional logic.

Wiring up the basic support is pretty straight forward, something like
the diff below.

cheers


diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0f123f1f62a1..a48576f1c579 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -260,6 +260,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HOTPLUG_SMT			if HOTPLUG_CPU
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 8a4d4f4d9749..bd23ba716d23 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -143,5 +143,8 @@ static inline int cpu_to_coregroup_id(int cpu)
 #endif
 #endif

+bool topology_is_primary_thread(unsigned int cpu);
+bool topology_smt_supported(void);
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 265801a3e94c..8619609809d5 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1769,4 +1769,20 @@ void __noreturn arch_cpu_idle_dead(void)
 	start_secondary_resume();
 }

+/**
+ * topology_is_primary_thread - Check whether CPU is the primary SMT thread
+ * @cpu:	CPU to check
+ */
+bool topology_is_primary_thread(unsigned int cpu)
+{
+	return cpu == cpu_first_thread_sibling(cpu);
+}
+
+/**
+ * topology_smt_supported - Check whether SMT is supported by the CPUs
+ */
+bool topology_smt_supported(void)
+{
+	return threads_per_core > 1;
+}
 #endif
