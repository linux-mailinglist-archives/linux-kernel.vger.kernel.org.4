Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0379608D78
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJVNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:44:41 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Oct 2022 06:44:37 PDT
Received: from sol.ermione.com (sol.ermione.com [95.255.240.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4813101CB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 06:44:36 -0700 (PDT)
Received: from sol.ermione.com (localhost.localdomain [127.0.0.1])
        by sol.ermione.com (8.15.2/8.15.2/Debian-22) with ESMTPS id 29MDd0C8009079
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:39:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ermione.com;
        s=erm201905; t=1666445940;
        bh=henH8CTDrahGgRSxDU9iVnBQqKI6BdXsd/xOm6kT2ew=;
        h=Date:From:To:Subject:From;
        b=h6y7HFxCyW4gmnKsj7WdGcUQdrNBUjw5d5Qe4vY6qnmUfzestt2N8wBwXp4gCQ8Pt
         49OgZVFb5iedFJhvr7k8CzNIVC4SZwgdKUdcuFF8ioHYS0huTjr9KSEotrzzEOQuA+
         4gcDLziFABj8x3os1Zwwsrd4h4EaFi8q1+DOYEw+N2IbiAN3rrEhSaMoNv4HiPL07x
         cbL1YvtGQpLQ+onetxEBozzobgObm2PyJUgPNihiAYjdvCnj+w0bg8dDfFbzjR36fF
         Kj5uluzt2HHkAFlBgdKPY8mvAaObRifK+EmAB+zZybEkgvk8TtLm2VbIvg4RGToYU5
         lhytsH+WW/aBg==
Received: (from ermione@localhost)
        by sol.ermione.com (8.15.2/8.15.2/Submit) id 29MDd0bj009078
        for linux-kernel@vger.kernel.org; Sat, 22 Oct 2022 15:39:00 +0200
X-Authentication-Warning: sol.ermione.com: ermione set sender to erm25d019@ermione.com using -f
Date:   Sat, 22 Oct 2022 15:39:00 +0200
From:   "Andrea Baldoni" <erm25d019@ermione.com>
To:     linux-kernel@vger.kernel.org
Subject: mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake
Message-ID: <Y1PydJnbL/9CRFFn@sol.ermione.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I am not subscribed to the list so please CC to my address.

I recently bought a new ASUS Laptop E210KA-GJ059WS with

00:1a.0 SD Host controller: Intel Corporation Device 4dc4 (rev 01) (prog-if 01)
	Subsystem: ASUSTeK Computer Inc. Device 1842
	Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 7
	Memory at 6001129000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
	Capabilities: [90] Vendor Specific Information: Len=14 <?>
	Kernel driver in use: sdhci-pci

I tried to install Linux (vanilla kernel 5.19.4) and found that the internal
128GB eMMC SSD was unuseable, unable to make a filesystem on it, dmesg shown

mmc0: running CQE recovery
and
mmc0: cqhci: timeout for tag 0
followed by register dump

(unfortunately I don't have the exact log now).

I found the patch to drivers/mmc/host/sdhci-pci-core.c posted by
Patrick Thompson date Thu, 13 Oct 2022 17:00:17 -0400, and applied it,
but the only way to make the eMMC work was to disable
CQE in its entirety by commenting

slot->host->mmc->caps2 |= MMC_CAP2_CQE;
and
slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;

If someone would like me to do any targeted test to be able to solve the
issue better, I will be happy to do it.

At the moment I am also searching how to get the touchpad to work, I would
appreciate any hint and/or a contact with someone who has experience on
this.

I think the relevant device should be this one, but it doesn't show in
/proc/bus/input/devices.

P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/ASUE1409:00
E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/ASUE1409:00
E: ID_VENDOR_FROM_DATABASE=Asuscom Network Inc
E: MODALIAS=acpi:ASUE1409:PNP0C50:
E: SUBSYSTEM=acpi
E: USEC_INITIALIZED=10378637

Thank you.

Best regards,
Andrea Baldoni
