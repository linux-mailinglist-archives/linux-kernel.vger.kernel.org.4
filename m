Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4266993A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbjAMN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbjAMN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:57:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813763C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:53:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D7A1B82161
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90000C433EF;
        Fri, 13 Jan 2023 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618026;
        bh=OJhTBUVSKCegb4i+9SFL4R/IowVrzTMekIJtJqHYazU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Tf+MwTF03EJ37hwcN2mCS6YdBNePhSnNDwRfJpoXiCj9Elw8kCVJzz1CCL58oyY/C
         UP9Two46IPYAKKgsJ266v5O/t20np8OOM6+Vxutkcf4dsbbJNuz5oUXNcHrAOivPEW
         o3yuLB+tT8Dr0cPuXoUG9EqE+OArcUhj2KP9Gx8LkN1pcxzFpUo39qL3QR0bsK6ZXj
         RV2t5MF+tbDt3U4Nf8qGbhkxYuX/K+C0bJ1HcDYUXucgdo/ON/F9xefc0gEmK6/UjE
         SBndq1lA6g+P30C1xI48H/j1+ZkgbbPuFmMvDksQq6E+vfRwvENT7mPn97J53uuTnL
         XM7yTpe0/9duQ==
Date:   Fri, 13 Jan 2023 07:53:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: RESEND: MMCONFIG related question
Message-ID: <20230113135343.GA1834989@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67449911D6906A753244AC8A92C29@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:15:45AM +0000, Duan, Zhenzhong wrote:
> Recently Lixiao reported sriov disappered for cards which supported
> sriov. We found it's related to commit "07eab0901ed efi/x86: Remove
> EfiMemoryMappedIO from E820 map" which removed EfiMemoryMappedIO
> regions from E820 map which lead to pci_mmcfg_reject_broken() check
> failed, raw_pci_ext_ops isn't set to pci_mmcfg finally, below is the
> related log. I know maybe bios should add MMCONFIG region into ACPI
> motherboard resources, just want to ask if we would support the case
> when MMCONFIG is missed in ACPI motherboard resources as I see it's
> treated as "Firmware Info" not "Firmware bug". Thanks

The patches here:
https://lore.kernel.org/linux-pci/20230110180243.1590045-1-helgaas@kernel.org/
should resolve this problem.

> Also has another question, if MMCONFIG happened to be in
> EfiMemoryMappedIO, even if it's removed from E820 map so that there
> is no CRS clip for that region, could it be used for BAR space?

MMCONFIG cannot be used for BAR space.  MMCONFIG should be reported
via PNP0C02 _CRS.  BAR space, i.e., a PCI host bridge aperture, should
be reported via PNP0A03 _CRS.

> Will there be conflict for BAR and MMCONFIG access?

I don't think so, but I don't completely understand the scenario
you're asking about.

The E820 clipping of PCI host bridge windows is only intended to work
around an issue where PNP0A03 _CRS reports space that is not part of
the host bridge windows.  E.g., there were a few platforms that seemed
to report host bridge register space via _CRS.

Bjorn

> [    0.000000] efi: EFI v2.60 by EDK II BIOS ID:SE5C620.86B.01.00.0763.022420181017
> [    0.000000] efi: SMBIOS=0x6ae78000 ACPI=0x6bbab000 ACPI 2.0=0x6bbab014 MEMATTR=0x67e99018 MOKvar=0x67b2d000
> [    0.000000] efi: Not removing mem06: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
> [    0.000000] efi: Remove mem09: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
> [    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
> [    3.351098] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [    3.351742] PCI: not using MMCONFIG
> [    4.867853] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [    4.904325] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> [    4.905061] PCI: not using MMCONFIG
> 
> Regards
> Zhenzhong
