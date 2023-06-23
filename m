Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638C173B8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFWNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:33:00 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08617269E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:32:53 -0700 (PDT)
Received: from 8bytes.org (p549ad14e.dip0.t-ipconnect.de [84.154.209.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 406CA227283;
        Fri, 23 Jun 2023 15:32:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1687527173;
        bh=Q54e7WIgLPTFy5hsRz139Qi7qedo0TrtYw8JDo3t2a4=;
        h=Date:From:To:Cc:Subject:From;
        b=M7J3Nvk2U5ylUtv74BfyGl1Njkvwx8u/5TImFVrq2aGgax9+zsIUXGn1f/Q2r0Zjx
         Ekc8RlPWZc8k6iiAvErfgTMKPkhB522CV74Awj93sH9JMqAzZRe7qsh8IYXZJwKiTx
         jJrKeBeCffOOqwtHVNLszxKY+uxamKC7udltpwGQeasP2zZyhE8eVNf9Tzi7CXWBFe
         qjqTeYUTBiKACibCYFGco0IRbLirQg5Y0FlMpanqYgtYTfkmQzRSOkQ5UPWXo6cvYp
         QiLfJ6/q/owdGZkhRpDwCiBVbstax5nqiUiFCFh7OqOSx6j2NqNHDjejwIRCphF2lj
         zP92HuHo27O6A==
Date:   Fri, 23 Jun 2023 15:32:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.5
Message-ID: <ZJWfBNRk89N0jfgi@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aZ4VyP1ECE5alLZ3"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aZ4VyP1ECE5alLZ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This one comes a bit early, which is mainly due to me being offline and
busy with house moving most of next week, when the merge window likely
opens. It also includes the fix I sent you for 6.4-rc7, so if you pull
that into v6.4, please note that the diffstat might be slightly
different when pulling the 6.5 updates.

With that in mind:

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.5

for you to fetch changes up to a7a334076dd725b8c3b5d64f68e3992ffcfd1d25:

  Merge branches 'iommu/fixes', 'arm/smmu', 'ppc/pamu', 'virtio', 'x86/vt-d', 'core' and 'x86/amd' into next (2023-06-19 10:12:42 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.5

Including:

	- Core changes:
	  - iova_magazine_alloc() optimization
	  - Make flush-queue an IOMMU driver capability
	  - Consolidate the error handling around device attachment

	- AMD IOMMU changes:
	  - AVIC Interrupt Remapping Improvements
	  - Some minor fixes and cleanups

	- Intel VT-d changes from Lu Baolu:
	  - Small and misc cleanups

	- ARM-SMMU changes from Will Deacon:
	  - Device-tree binding updates:
	    * Add missing clocks for SC8280XP and SA8775 Adreno SMMUs
	    * Add two new Qualcomm SMMUs in SDX75 and SM6375
	  - Workarounds for Arm MMU-700 errata:
	    * 1076982: Avoid use of SEV-based cmdq wakeup
	    * 2812531: Terminate command batches with a CMD_SYNC
	    * Enforce single-stage translation to avoid nesting-related errata
	  - Set the correct level hint for range TLB invalidation on teardown

	- Some other minor fixes and cleanups (including Freescale PAMU and
	  virtio-iommu changes)

----------------------------------------------------------------
Bartosz Golaszewski (1):
      dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU

Bjorn Andersson (1):
      dt-bindings: arm-smmu: Fix SC8280XP Adreno binding

Carlos Bilbao (1):
      iommu/amd: Update copyright notice

Florian Fainelli (1):
      iommu: Suppress empty whitespaces in prints

Jason Gunthorpe (20):
      iommu: Replace iommu_group_device_count() with list_count_nodes()
      iommu: Add for_each_group_device()
      iommu: Make __iommu_group_set_domain() handle error unwind
      iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
      iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
      iommu: Replace __iommu_group_dma_first_attach() with set_domain
      iommu: Remove iommu_group_do_dma_first_attach() from iommu_group_add_device()
      iommu: Replace iommu_group_do_dma_first_attach with __iommu_device_set_domain
      iommu: Fix iommu_probe_device() to attach the right domain
      iommu: Do iommu_group_create_direct_mappings() before attach
      iommu: Remove the assignment of group->domain during default domain alloc
      iommu: Consolidate the code to calculate the target default domain type
      iommu: Revise iommu_group_alloc_default_domain()
      iommu: Consolidate the default_domain setup to one function
      iommu: Allow IOMMU_RESV_DIRECT to work on ARM
      iommu: Remove __iommu_group_for_each_dev()
      iommu: Tidy the control flow in iommu_group_store_type()
      iommu/fsl: Always allocate a group for non-pci devices
      iommu/fsl: Move ENODEV to fsl_pamu_probe_device()
      iommu/fsl: Use driver_managed_dma to allow VFIO to work

Jean-Philippe Brucker (2):
      iommu/virtio: Detach domain on endpoint release
      iommu/virtio: Return size mapped for a detached domain

Jerry Snitselaar (1):
      iommu/amd: Use page mode macros in fetch_pte()

Joao Martins (1):
      iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()

Joerg Roedel (3):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      iommu/amd: Fix compile error for unused function
      Merge branches 'iommu/fixes', 'arm/smmu', 'ppc/pamu', 'virtio', 'x86/vt-d', 'core' and 'x86/amd' into next

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Add SM6375 GPU SMMU

Lu Baolu (1):
      iommu/vt-d: Remove commented-out code

Robin Murphy (7):
      iommu: Add a capability for flush queue support
      iommu: Use flush queue capability
      iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
      iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
      iommu/arm-smmu-v3: Add explicit feature for nesting
      iommu/arm-smmu-v3: Document nesting-related errata
      iommu/arm-smmu-v3: Set TTL invalidation hint better

Rohit Agarwal (1):
      dt-bindings: arm-smmu: Add SDX75 SMMU compatible

Su Hui (1):
      iommu/amd: Fix possible memory leak of 'domain'

Suhui (1):
      iommu/vt-d: Remove unnecessary (void*) conversions

Suravee Suthikulpanit (4):
      iommu/amd: Remove the unused struct amd_ir_data.ref
      iommu/amd: Introduce Disable IRTE Caching Support
      iommu/amd: Do not Invalidate IRT when IRTE caching is disabled
      iommu/amd: Improving Interrupt Remapping Table Invalidation

Vasant Hegde (3):
      iommu/amd: Fix DTE_IRQ_PHYS_ADDR_MASK macro
      iommu/amd: Use BIT/BIT_ULL macro to define bit fields
      iommu/amd: Remove extern from function prototypes

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Yanfei Xu (2):
      iommu/vt-d: Handle the failure case of dmar_reenable_qi()
      iommu/vt-d: Remove two WARN_ON in domain_context_mapping_one()

Zhen Lei (1):
      iommu/iova: Optimize iova_magazine_alloc()

 .clang-format                                      |   1 +
 Documentation/admin-guide/kernel-parameters.txt    |   1 +
 Documentation/arm64/silicon-errata.rst             |   4 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  12 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   1 +
 drivers/iommu/amd/amd_iommu.h                      |  91 +--
 drivers/iommu/amd/amd_iommu_types.h                |  87 +--
 drivers/iommu/amd/init.c                           |  38 +-
 drivers/iommu/amd/io_pgtable.c                     |   4 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |   2 +-
 drivers/iommu/amd/iommu.c                          | 107 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  61 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   4 +-
 drivers/iommu/dma-iommu.c                          |   3 +-
 drivers/iommu/fsl_pamu_domain.c                    | 113 +---
 drivers/iommu/intel/iommu.c                        |  29 +-
 drivers/iommu/iommu.c                              | 694 +++++++++++----------
 drivers/iommu/iova.c                               |   8 +-
 drivers/iommu/virtio-iommu.c                       |  57 +-
 include/linux/iommu.h                              |   6 +
 21 files changed, 719 insertions(+), 612 deletions(-)

Please pull.

Thanks,

	Joerg

--aZ4VyP1ECE5alLZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmSVnwMACgkQK/BELZcB
GuMgWg/8Ckb8mgENYAqr/ooRaAmMZGP0cXoQ/7K/RdyMU9F9KyRYbuzamHaZfxMO
VJaitTUXM2SnRabLdgpMj6cbznc9U/NJeXHZr0G5b9Q101VBz2j3nIcHLeo8xHY7
UISBEi1rUJ4/n1WP1DJ/YXFwntDMoKNmcif85lX2jHdcvif46rIxgEpPSslI/GmX
aG8QooxKs106wG0lFfHU7KiCAFhGiD6b23k1eQdR5CEGI3NdU08090ITqcS2eDb+
kU/V/gg7X+EQWgl06JJL7Nfk8hBur/6luKaWq+wc9x/EWCCADAQgh+L9xaLh+C1R
Mb6bcFi3AwAbLdgWM9rg5zPptTNKkC4VxLF2YbkqyE2wsMSSXEUE40aZ2OrtcFfK
5RirR2kde5nS+ECIxgxXl7zPKUCtoyObo7XTIKnMGFJCHW2mbF22DSZ911lwa8kU
CFmcCyalTgDwU+IxGbPhUkDKkCMhDmvbAV1VvHuAA95VA4dk+3LvUS8s5uiQcSeJ
hv5YTnFGb02rZM+imaHu+zBNS/odkXssFFmDMUgRNBizcpufnzDhiJDiNEliwD/l
TIJyViRKgA4TIdBasecqE9tK78IcZ8QlcdIjpMZucv7IaOUAMFLSL3eg+I/qQH5Y
dTlvFMBIHO1ntFsDItbqUnTqR8S7H4KNEF19UpNL6Ou4TimHVVY=
=Yv/C
-----END PGP SIGNATURE-----

--aZ4VyP1ECE5alLZ3--
