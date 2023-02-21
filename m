Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275B69DC68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjBUIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:51:22 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3EA023D82
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:51:15 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 62D2522425A;
        Tue, 21 Feb 2023 09:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1676969474;
        bh=x9WsyvGJ/BNVAAqSwl4JpFU98i9nTyZlPjeRW5BWdAs=;
        h=Date:From:To:Cc:Subject:From;
        b=wOskxfsHpgJ/Y+YcSSENztXPQwss70bg5LTENfzI6IVvvnY//6ErdWaZsi7ZqxipX
         m+2s6hlilRw2oRBdKvdnPYJTDDmQTcM8oeSZ3BSJPSMOaVdfFLmOTGK7jA0b7Kvgfy
         C0qsPuxrtepL1XmUxwiEIWPGm/kZkTjSkfrCZEtSq7Fe5F16OlnWm6NJ0xzzb7jLm9
         JOdMDrSo0yCymzUK1soaHaduB8CQDKbH365luFRoBq84detggTXMpqFrIq/hcJypxS
         RRqaoUgWpo/bkigFkUjnIR0Ab7ga8QqknXjyEurbGRaHVAjXJrq11v9d7RB+3W476P
         92Hk6WwMYHl2g==
Date:   Tue, 21 Feb 2023 09:51:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.3
Message-ID: <Y/SGAafMEGBn4fWy@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xsEv6tzStRkCI0Br"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xsEv6tzStRkCI0Br
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please note the first item in the tag-message, there is some potential
for conflicts between these changes and other trees due to changed
function signatures.

With that in mind, please consider:

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.3

for you to fetch changes up to bedd29d793da3312e1350a56245c4971a38d4453:

  Merge branches 'apple/dart', 'arm/exynos', 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next (2023-02-18 15:43:04 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.3:

Including:

	- Consolidate iommu_map/unmap functions. There have been
	  blocking and atomic variants so far, but that was problematic
	  as this approach does not scale with required new variants
	  which just differ in the GFP flags used.
	  So Jason consolidated this back into single functions that
	  take a GFP parameter. This has the potential to cause
	  conflicts with other trees, as they introduce new call-sites
	  for the changed functions. I offered them to pull in the
	  branch containing these changes and resolve it, but I am not
	  sure everyone did that. The conflicts this caused with
	  upstream up to v6.2-rc8 are resolved in the final merge
	  commit.

	- Retire the detach_dev() call-back in iommu_ops

	- Arm SMMU updates from Will:
	  - Device-tree binding updates:
	    * Cater for three power domains on SM6375
	    * Document existing compatible strings for Qualcomm SoCs
	    * Tighten up clocks description for platform-specific compatible strings
	  - Enable Qualcomm workarounds for some additional platforms that need them

	- Intel VT-d updates from Lu Baolu:
	  - Add Intel IOMMU performance monitoring support
	  - Set No Execute Enable bit in PASID table entry
	  - Two performance optimizations
	  - Fix PASID directory pointer coherency
	  - Fix missed rollbacks in error path
	  - Cleanups

	- Apple t8110 DART support

	- Exynos IOMMU:
	  - Implement better fault handling
	  - Error handling fixes

	- Renesas IPMMU:
	  - Add device tree bindings for r8a779g0

	- AMD IOMMU:
	  - Various fixes for handling on SNP-enabled systems and
	    handling of faults with unknown request-ids
	  - Cleanups and other small fixes

	- Various other smaller fixes and cleanups

----------------------------------------------------------------
Bartosz Golaszewski (1):
      dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P

Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS

Eric Curtin (1):
      iommu: dart: DART_T8110_ERROR range should be 0 to 5

Gavrilov Ilia (1):
      iommu/amd: Add a length limitation for the ivrs_acpihid command-line parameter

Hector Martin (7):
      dt-bindings: iommu: dart: add t8110 compatible
      iommu: dart: Add suspend/resume support
      iommu: dart: Support >64 stream IDs
      iommu: dart: Support a variable number of TTBRs per stream
      iommu: dart: Fix DART_PARAMS1/2 bit define names
      iommu: dart: Support different variants with different registers
      iommu: dart: Add t8110 DART support

Jacob Pan (2):
      iommu/vt-d: Avoid superfluous IOTLB tracking in lazy mode
      iommu/vt-d: Fix PASID directory pointer coherency

Jason Gunthorpe (12):
      iommu: Remove deferred attach check from __iommu_detach_device()
      iommu: Add a gfp parameter to iommu_map()
      iommu: Remove iommu_map_atomic()
      iommu: Add a gfp parameter to iommu_map_sg()
      iommu/dma: Use the gfp parameter in __iommu_dma_alloc_noncontiguous()
      iommufd: Use GFP_KERNEL_ACCOUNT for iommu_map()
      iommu/intel: Add a gfp parameter to alloc_pgtable_page()
      iommu/intel: Support the gfp argument to the map_pages op
      iommu/intel: Use GFP_KERNEL in sleepable contexts
      iommu/s390: Push the gfp parameter to the kmem_cache_alloc()'s
      iommu/s390: Use GFP_KERNEL in sleepable contexts
      iommu: Fix error unwind in iommu_group_alloc()

Joerg Roedel (5):
      iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
      iommu/fsl_pamu: Fix compile error after adding set_platform_dma_ops
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branch 'iommu-memory-accounting' into core
      Merge branches 'apple/dart', 'arm/exynos', 'arm/renesas', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next

Kan Liang (7):
      iommu/vt-d: Support size of the register set in DRHD
      iommu/vt-d: Retrieve IOMMU perfmon capability information
      iommu/vt-d: Support Enhanced Command Interface
      iommu/vt-d: Add IOMMU perfmon support
      iommu/vt-d: Support cpumask for IOMMU perfmon
      iommu/vt-d: Add IOMMU perfmon overflow handler support
      iommu/vt-d: Enable IOMMU perfmon support

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500

Krzysztof Kozlowski (1):
      dt-bindings: arm-smmu: disallow clocks when not used

Lu Baolu (10):
      iommu: Remove detach_dev callbacks
      iommu: Add set_platform_dma_ops iommu ops
      iommu: Add set_platform_dma_ops callbacks
      iommu: Remove detach_dev callback
      iommu/vt-d: Remove include/linux/intel-svm.h
      iommu/vt-d: Remove unused fields in svm structures
      iommu/vt-d: Remove users from intel_svm_dev
      iommu/vt-d: Remove sva from intel_svm_dev
      iommu/vt-d: Set No Execute Enable bit in PASID table entry
      iommu/vt-d: Fix error handling in sva enable/disable paths

Luca Weiss (1):
      dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible

Manivannan Sadhasivam (1):
      dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65

Marek Szyprowski (1):
      iommu/exynos: Add missing set_platform_dma_ops callback

Marijn Suijten (2):
      dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
      iommu/arm-smmu-qcom: Add SM8150 DPU compatible

Martin Botka (1):
      dt-bindings: arm-smmu: Document smmu-500 binding for SM6125

Randy Dunlap (1):
      iommu/of: mark an unused function as __maybe_unused

Robin Murphy (1):
      iommu: Tidy up io-pgtable dependencies

Sam Protsenko (2):
      iommu/exynos: Abstract getting the fault info
      iommu/exynos: Implement fault handling on SysMMU v7

Sven Peter (1):
      iommu/dart: Fix apple_dart_device_group for PCI groups

Thierry Reding (4):
      of: Introduce of_translate_dma_region()
      dt-bindings: reserved-memory: Document iommu-addresses
      iommu: Implement of_iommu_get_resv_regions()
      iommu: dma: Use of_iommu_get_resv_regions()

Tina Zhang (1):
      iommu/vt-d: Allow to use flush-queue when first level is default

Tom Lendacky (1):
      iommu/amd: Do not clear event/ppr log buffer when snp is enabled

Vasant Hegde (6):
      iommu/amd: Do not allocate io_pgtable_ops for passthrough domain
      iommu/amd: Fix error handling for pdev_pri_ats_enable()
      iommu/amd: Do not identity map v2 capable device when snp is enabled
      iommu/amd: Improve page fault error reporting
      iommu: Attach device group to old domain in error path
      iommu/amd: Skip attach device domain is same as new domain

Will Deacon (1):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/updates

Yang Yingliang (1):
      iommu/exynos: Fix error handling in exynos_iommu_init()

Yoshihiro Shimoda (1):
      dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779g0 support

 .../testing/sysfs-bus-event_source-devices-iommu   |  37 +
 .../devicetree/bindings/iommu/apple,dart.yaml      |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  66 +-
 .../devicetree/bindings/iommu/qcom,iommu.txt       |   1 +
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   1 +
 .../bindings/reserved-memory/reserved-memory.yaml  |  89 ++-
 MAINTAINERS                                        |   1 -
 arch/arm/mm/dma-mapping.c                          |  11 +-
 arch/s390/include/asm/pci_dma.h                    |   5 +-
 arch/s390/pci/pci_dma.c                            |  31 +-
 .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    |   3 +-
 drivers/gpu/drm/tegra/drm.c                        |   2 +-
 drivers/gpu/host1x/cdma.c                          |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |   8 +-
 drivers/iommu/Kconfig                              |  18 +-
 drivers/iommu/amd/init.c                           |  16 +-
 drivers/iommu/amd/iommu.c                          |  89 ++-
 drivers/iommu/apple-dart.c                         | 632 +++++++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   2 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  23 -
 drivers/iommu/dma-iommu.c                          |  21 +-
 drivers/iommu/exynos-iommu.c                       | 216 +++--
 drivers/iommu/fsl_pamu_domain.c                    |   6 +-
 drivers/iommu/intel/Kconfig                        |  11 +
 drivers/iommu/intel/Makefile                       |   1 +
 drivers/iommu/intel/dmar.c                         |  33 +-
 drivers/iommu/intel/iommu.c                        | 122 ++-
 drivers/iommu/intel/iommu.h                        | 115 ++-
 drivers/iommu/intel/pasid.c                        |  20 +-
 drivers/iommu/intel/perfmon.c                      | 877 +++++++++++++++++++++
 drivers/iommu/intel/perfmon.h                      |  64 ++
 drivers/iommu/intel/svm.c                          |  90 +--
 drivers/iommu/iommu-traces.c                       |   1 -
 drivers/iommu/iommu.c                              | 171 ++--
 drivers/iommu/iommufd/pages.c                      |   6 +-
 drivers/iommu/ipmmu-vmsa.c                         |  28 -
 drivers/iommu/msm_iommu.c                          |   6 +-
 drivers/iommu/mtk_iommu.c                          |   9 -
 drivers/iommu/mtk_iommu_v1.c                       |   4 +-
 drivers/iommu/of_iommu.c                           |  96 +++
 drivers/iommu/omap-iommu.c                         |   6 +-
 drivers/iommu/rockchip-iommu.c                     |   1 -
 drivers/iommu/s390-iommu.c                         |  22 +-
 drivers/iommu/sprd-iommu.c                         |  16 -
 drivers/iommu/sun50i-iommu.c                       |   1 -
 drivers/iommu/tegra-gart.c                         |   6 +-
 drivers/iommu/tegra-smmu.c                         |   5 +-
 drivers/media/platform/qcom/venus/firmware.c       |   2 +-
 drivers/net/ipa/ipa_mem.c                          |   6 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   4 +-
 drivers/of/address.c                               |  41 +
 drivers/remoteproc/remoteproc_core.c               |   5 +-
 drivers/vfio/vfio_iommu_type1.c                    |   9 +-
 drivers/vhost/vdpa.c                               |   2 +-
 include/acpi/actbl1.h                              |   2 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/dmar.h                               |   1 +
 include/linux/intel-svm.h                          |  16 -
 include/linux/iommu.h                              |  39 +-
 include/linux/of_address.h                         |   2 +
 include/linux/of_iommu.h                           |   8 +
 include/trace/events/iommu.h                       |   7 -
 63 files changed, 2493 insertions(+), 646 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h
 delete mode 100644 include/linux/intel-svm.h

Please pull.

Thanks,

	Joerg

--xsEv6tzStRkCI0Br
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmP0hgEACgkQK/BELZcB
GuOQdA//aUZOy5xpupEcBRTk5WYrnrDkYVMkgKF22iDqLnZxI6eWkXt5sYATODoe
sMlCekV6cZT6AdGWI091jt2+ZlagH9vywZpkzHMhBhsFZdtcsDGHsdKDrxZsA2dd
IWU4YCIuxNVgQufoNYBmU1D43IG5rCWc9rm0z3n+7bqzkTmBlv3+F4yoXixIKYpX
5LeNK7zRvtyru1HgZ6xJh5iiqRdMLkqu5mwvx0Bo5Qvkhs/zIilkdz7RO5c4T7ZI
lsP+5fO9rCpwMTQ0ju/GahSgOCWY8vONY3Vb1OcbrhKW6bwoVhpInh1YdNlywpBI
FDaxYPyZq5CphZdKNttz+iYb5Yfm0OGxcQREQD40zEE7bdLS+mgzwHBlgh2f+l1s
MHt9WYrmPavWR+1h9W/7Eggng1j40jjBP20Wbm6VrU9Y9/bpWRHj8f5A+FUSPt/l
tjxpU+hnUUcWtHbB6ciC18+fLTG9/Qjl79XwPUCvcJ1j6b/aig4nylG2tMgsV7y7
dxbANTF7gfsBb1MWTG6OGC5f5KqLTQHb/qn6gmRJFpyQPS0fHwB7sTkdBDvLBBx1
m2ujGQGJLsWLlaA9wm8SThvedxkVpDET5Q4f+28o6tGqkkc1TXcTzwYsYSNCpWOS
/6kaalkrsSO6kX/Uz6JFaqrLrhlYQLl+OxK2seMJrLN33VfqV6E=
=5tBc
-----END PGP SIGNATURE-----

--xsEv6tzStRkCI0Br--
