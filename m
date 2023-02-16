Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B1B699B71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBPRnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:43:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECC24C3D2;
        Thu, 16 Feb 2023 09:43:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 887ED61760;
        Thu, 16 Feb 2023 17:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D63CC433EF;
        Thu, 16 Feb 2023 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676569414;
        bh=yjFdrf5URuxKcfaupImQzlljUh6WAuRwcY13YuisMos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q8E4zEPwDhpgojNgSf+AYlmRQ+QP3bSPX071+UzN4sndY9zHvIg/NQI3sSg+/W0J7
         QKV5G+uvwbOryR6v/fyOGlttXn4t+0cZ2+4bzX2L7bR8AzQkzsmbf7JtuLe1DkT9MK
         Ms/CeYNe5Pr6WkDGjbVmKDBOzsmaz/MQZgaBmMqUFObsGHhHjA7A+apcnLFD7jqyLU
         0os6U9znvDfvDboIEsbAAcG8OadYp/Qo4/FFAvqImPgvjls0aCcaoIsJQ+cEs4KA1Z
         akIU2JwIoK08hPpvXlP/A8U/bPp+Lcyfn/qa70Xw1fbqvvuP0npOLflUQ6lhvD3m/A
         nM3c8ywXNOVJQ==
Date:   Thu, 16 Feb 2023 11:43:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH v2 0/7] MODULE_LICENSE removals, first tranche
Message-ID: <20230216174333.GA3313434@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc PCI folks, who got the patches but not this cover letter, and
participants from the v1 posting]

On Thu, Feb 16, 2023 at 03:24:03PM +0000, Nick Alcock wrote:
> This series, based on current modules-next, is part of a treewide cleanup
> suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
> files/objects that are not tristate.  Due to recent changes to kbuild, these
> uses are now problematic.  See the commit logs for more details.
> 
> (The commit log prefixes and Cc lists are automatically determined using
> the script mentioned below.  I've eyeballed them, and they seem reasonable:
> my apologies if they are not.)
> 
> This is a small initial tranche to see if the general approach is valid:
> larger tranches can follow if desired and if these patches seem OK.
> I'll be sending a second 24-patch tranche in a few hours if this
> one meets with general approval.
> 
> (In total, there are 121 patches in this series.)
> 
> 
> Differences from v1:
>  - just remove MODULE_LICENSE, don't comment it out
>  - Cc: paid maintainers as well as unpaid ones
>  - improvements to the prefix determination code (notable in
>    PCI: versatile in particular)
> 
> The series at a whole can be found here:
>   https://github.com/nickalcock/linux module-license
> 
> The patch splitter (not for upstreaming!) used to prepare these
> commits can be found here:
>   https://github.com/nickalcock/linux mass-split
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Nick Alcock (7):
>   kbuild, PCI: versatile: remove MODULE_LICENSE in non-modules
>   kbuild, PCI: mobiveil: remove MODULE_LICENSE in non-modules
>   kbuild, PCI: tegra: remove MODULE_LICENSE in non-modules
>   kbuild, PCI: endpoint: remove MODULE_LICENSE in non-modules
>   kbuild, PCI: hip: remove MODULE_LICENSE in non-modules
>   kbuild, shpchp: remove MODULE_LICENSE in non-modules
>   kbuild, PCI: dwc: remove MODULE_LICENSE in non-modules
> 
>  drivers/pci/controller/dwc/pcie-histb.c              | 1 -
>  drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 1 -
>  drivers/pci/controller/pci-tegra.c                   | 1 -
>  drivers/pci/controller/pci-versatile.c               | 1 -
>  drivers/pci/controller/pcie-hisi-error.c             | 1 -
>  drivers/pci/endpoint/pci-ep-cfs.c                    | 1 -
>  drivers/pci/endpoint/pci-epc-core.c                  | 1 -
>  drivers/pci/endpoint/pci-epc-mem.c                   | 1 -
>  drivers/pci/endpoint/pci-epf-core.c                  | 1 -
>  drivers/pci/hotplug/shpchp_core.c                    | 1 -
>  10 files changed, 10 deletions(-)

I squashed these and applied to pci/kbuild for v6.3, thanks!

I added examples from the v1 posting to the commit log; let me know if
I got anything wrong:

commit 84cee45bafcb ("PCI: Remove MODULE_LICENSE so boolean drivers don't look like modules")
Author: Nick Alcock <nick.alcock@oracle.com>
Date:   Thu Feb 16 15:24:04 2023 +0000

    PCI: Remove MODULE_LICENSE so boolean drivers don't look like modules
    
    Since 8b41fc4454e3 ("kbuild: create modules.builtin without
    Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations are
    used to identify modules. As a consequence, MODULE_LICENSE in non-modules
    causes modprobe to misidentify the object file as a module when it is not,
    and modprobe might succeed rather than failing with a suitable error
    message.
    
    For tristate modules that can be either built-in or loaded at runtime,
    modprobe succeeds in both cases:
    
      # modprobe ext4
      [exit status zero if CONFIG_EXT4_FS=y or =m]
    
    For boolean modules like the Standard Hot Plug Controller driver (shpchp)
    that cannot be loaded at runtime, modprobe should always fail like this:
    
      # modprobe shpchp
      modprobe: FATAL: Module shpchp not found in directory /lib/modules/...
      [exit status non-zero regardless of CONFIG_HOTPLUG_PCI_SHPC]
    
    but prior to this commit, shpchp_core.c contained MODULE_LICENSE, so
    "modprobe shpchp" silently succeeded when it should have failed.
    
    Remove MODULE_LICENSE in files that cannot be built as modules.
    
    [bhelgaas: commit log, squash]
    Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
    Link: https://lore.kernel.org/r/20230216152410.4312-1-nick.alcock@oracle.com/
    Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Luis Chamberlain <mcgrof@kernel.org>
    Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 43c27812dd6d..927ae05dc920 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -450,4 +450,3 @@ static struct platform_driver histb_pcie_platform_driver = {
 module_platform_driver(histb_pcie_platform_driver);
 
 MODULE_DESCRIPTION("HiSilicon STB PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
index f6fcd95c2bf5..c5bb87ff6d9a 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -56,6 +56,5 @@ static struct platform_driver mobiveil_pcie_driver = {
 
 builtin_platform_driver(mobiveil_pcie_driver);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
 MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 929f9363e94b..5bb05564d6f8 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2814,4 +2814,3 @@ static struct platform_driver tegra_pcie_driver = {
 	.remove = tegra_pcie_remove,
 };
 module_platform_driver(tegra_pcie_driver);
-MODULE_LICENSE("GPL");
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 7991d334e0f1..e9a6758fe2c1 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -169,4 +169,3 @@ static struct platform_driver versatile_pci_driver = {
 module_platform_driver(versatile_pci_driver);
 
 MODULE_DESCRIPTION("Versatile PCI driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index 7959c9c8d2bc..7d88eb696b06 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -324,4 +324,3 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
 module_platform_driver(hisi_pcie_error_handler_driver);
 
 MODULE_DESCRIPTION("HiSilicon HIP PCIe controller error handling driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d4850bdd837f..4b8ac0ac84d5 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -728,4 +728,3 @@ module_exit(pci_ep_cfs_exit);
 
 MODULE_DESCRIPTION("PCI EP CONFIGFS");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 2542196e8c3d..dd750ad29485 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -861,4 +861,3 @@ module_exit(pci_epc_exit);
 
 MODULE_DESCRIPTION("PCI EPC Library");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a97b56a6d2db..7dcf6f480b82 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -260,4 +260,3 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
 MODULE_DESCRIPTION("PCI EPC Address Space Management");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..2036e38be093 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -568,4 +568,3 @@ module_exit(pci_epf_exit);
 
 MODULE_DESCRIPTION("PCI EPF Library");
 MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 53692b048301..56c7795ed890 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -32,7 +32,6 @@ int shpchp_poll_time;
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 
 module_param(shpchp_debug, bool, 0644);
 module_param(shpchp_poll_mode, bool, 0644);
