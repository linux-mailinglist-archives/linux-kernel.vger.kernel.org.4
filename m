Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D26E3385
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDOUZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDOUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F1358C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78B2661189
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 20:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F80C433D2;
        Sat, 15 Apr 2023 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681590296;
        bh=OcdAMD4h6vpRlUyg25ns5nyLBp7B81xMjeVUfm1e5Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hh7ylH3TAq8W+WTOkeAwm1IeWriB8dot0jW5WMO7AtG6BP4uRV0KABZBdRADOcIbO
         3LhmL10ZA1Y7B8OBivvjbt3josXwGA5KV60XNwIjrgKOoW258ThaqYPaC6pddAYmf1
         K7b8veYM3k/iC6b1kPJVmBPXCY0/5znYRxpK1is8iO1li7HWaJSV3IYRn0Pxy84lI/
         clOdkgVvpgiXXwSxHeGIO1Z6gPNNaRy+T87AF6fT0JNg8fXOnDflMrfQSxr2gZ7VCY
         kj0EHIBhfhbKgT3dj1w3hQ6KXQfQkVlBJGWRHh6CwhFYqT0cQg0GYPCzw4hRRx8lH7
         be2qVaGntfg/A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Ricardo Pardini <ricardo@pardini.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux: change tools/vm to tools/mm breaks "make clean" in tools dir
Date:   Sat, 15 Apr 2023 20:24:54 +0000
Message-Id: <20230415202454.13558-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415173915.6915-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I got below breat bug report from Ricardo via personal mail.  Forwarding to
mailing lists under Ricardo's approval for sharing the context.


Thanks,
SJ

On Sat, 15 Apr 2023 17:39:15 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Ricardo,
> 
> On Sat, 15 Apr 2023 18:55:41 +0200 Ricardo Pardini <ricardo@pardini.net> wrote:
> 
> > Hey SJ, here's a hack I had to do. I'm not on the mailing list, sorry.
> 
> No problem.  If you don't mind, please feel free to send any mail to the
> mailing list even if you don't subscribe.  You can also read the mails from
> archives like lore.kernel.org.
> 
> > I figure the tools/Makefile needs love after the vm->mm rename, wanted
> > to give you a heads up.
> > 
> > + # Small detour: in v6.3-rc1, in commit
> > https://github.com/torvalds/linux/commit/799fb82aa132fa3a3886b7872997a5a84e820062,
> > + #               the tools/vm dir was renamed to tools/mm.
> > Unfortunately tools/Makefile still expects it to exist,
> > + #               and "make clean" in the "/tools" dir fails. Drop in
> > a fake Makefile there to work around this.
> > 
> > From https://patch-diff.githubusercontent.com/raw/armbian/build/pull/5059.patch
> 
> Thank you very much for this report!  I confirmed the issue can be reproduced
> on my machine and fixed with below patch.  If you see no problem with the
> patch, I will post it to the mailing list.
> 
> 
> Thanks,
> SJ
> 
> > 
> > Cordially,
> > 
> > -- 
> > Ricardo Pardini
> > Armbian
> 
> 
> ================================== 8< ==========================================
> 
> From de3d8d9a84e1b37aeefb01935dc8d5a390829a6c Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Sat, 15 Apr 2023 17:27:18 +0000
> Subject: [PATCH] tools/Makefile: do missed s/vm/mm/
> 
> Commit 799fb82aa132 ("tools/vm: rename tools/vm to tools/mm") missed
> renaming 'vm' in 'tools/Makefile' to 'mm'.  As a result, 'make clean'
> under 'tools/' directory fails as below:
> 
>     $ make -C tools clean
>       DESCEND vm
>     make[1]: Entering directory '/linux/tools/vm'
>     make[1]: *** No rule to make target 'clean'.  Stop.
>     make[1]: Leaving directory '/linux/tools/vm'
>     make: *** [Makefile:173: vm_clean] Error 2
>     make: Leaving directory '/linux/tools'
> 
> Do the missed rename.
> 
> Reported-by: Ricardo Pardini <ricardo@pardini.net>
> Fixes: 799fb82aa132 ("tools/vm: rename tools/vm to tools/mm")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  tools/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index e497875fc7e3..37e9f6804832 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -39,7 +39,7 @@ help:
>  	@echo '  turbostat              - Intel CPU idle stats and freq reporting tool'
>  	@echo '  usb                    - USB testing tools'
>  	@echo '  virtio                 - vhost test module'
> -	@echo '  vm                     - misc vm tools'
> +	@echo '  mm                     - misc mm tools'
>  	@echo '  wmi			- WMI interface examples'
>  	@echo '  x86_energy_perf_policy - Intel energy policy tool'
>  	@echo ''
> @@ -69,7 +69,7 @@ acpi: FORCE
>  cpupower: FORCE
>  	$(call descend,power/$@)
>  
> -cgroup counter firewire hv guest bootconfig spi usb virtio vm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
> +cgroup counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
>  	$(call descend,$@)
>  
>  bpf/%: FORCE
> @@ -118,7 +118,7 @@ kvm_stat: FORCE
>  
>  all: acpi cgroup counter cpupower gpio hv firewire \
>  		perf selftests bootconfig spi turbostat usb \
> -		virtio vm bpf x86_energy_perf_policy \
> +		virtio mm bpf x86_energy_perf_policy \
>  		tmon freefall iio objtool kvm_stat wmi \
>  		pci debugging tracing thermal thermometer thermal-engine
>  
> @@ -128,7 +128,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install vm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
> +cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
>  	$(call descend,$(@:_install=),install)
>  
>  selftests_install:
> @@ -158,7 +158,7 @@ kvm_stat_install:
>  install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
>  		hv_install firewire_install iio_install \
>  		perf_install selftests_install turbostat_install usb_install \
> -		virtio_install vm_install bpf_install x86_energy_perf_policy_install \
> +		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
>  		tmon_install freefall_install objtool_install kvm_stat_install \
>  		wmi_install pci_install debugging_install intel-speed-select_install \
>  		tracing_install thermometer_install thermal-engine_install
> @@ -169,7 +169,7 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
>  
> -cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean vm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
> +cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
>  	$(call descend,$(@:_clean=),clean)
>  
>  libapi_clean:
> @@ -211,7 +211,7 @@ build_clean:
>  
>  clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
> -		vm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
> +		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean \
>  		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
>  		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean
> -- 
> 2.25.1
