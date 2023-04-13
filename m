Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAF6E0AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDMJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDMJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:58:07 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61C866583
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:58:06 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 6C50C243D2F;
        Thu, 13 Apr 2023 11:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681379885;
        bh=Y40rcWs5DQa6d27AKOzN6Tedv3haYVyMXAYVrYXRWL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0ypDiQk9tFmBmEF12v95LPN3aNT+EENoZyaqs8yktk1rvQ0r/tNUqE5/7k2zvhEm
         3f+d7Y9slV+hpe2eY+xQqOEso/LkDh7FGZQfs0LDx2NcHxcWnraIMSgrGZ/HQchWNZ
         dIeNYHn13zuGy0I5y/ipCupR8UViRg3lrGCxTL/pb4b1hgfjuBWpnH6WA4KDqv1CrF
         93ulzsPk+4pWA2kb/85ERr0eM3ACrdhzKbCdmaeE13LSYtpoetWnFbQNh93g+NWGbA
         j8Smn1FG6fPplfpFtCs58Kvjzf4bKh49f9CEHxcPVYedHKSHtgsyO0BXYsarSKoTBy
         19xbXhrwX0ePQ==
Date:   Thu, 13 Apr 2023 11:58:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kishon Vijay Abraham I <kvijayab@amd.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2] iommu/amd: Fix "Guest Virtual APIC Table Root
 Pointer" configuration in IRTE
Message-ID: <ZDfSLFAd0me3K6MQ@8bytes.org>
References: <20230405130317.9351-1-kvijayab@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405130317.9351-1-kvijayab@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 01:03:17PM +0000, Kishon Vijay Abraham I wrote:
> commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
> (de-)activation code") while refactoring guest virtual APIC
> activation/de-activation code, stored information for activate/de-activate
> in "struct amd_ir_data". It used 32-bit integer data type for storing the
> "Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
> "ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
> Table Entry).
> 
> This causes interrupts from PCIe devices to not reach the guest in the case
> of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
> bit in the "ga_root_ptr" is lost before writing it to the IRTE.
> 
> Fix it by using 64-bit data type for storing the "ga_root_ptr". While at
> that also change the data type of "ga_tag" to u32 in order to match
> the IOMMU spec.
> 
> Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
> Cc: stable@vger.kernel.org # v5.4+
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>

Applied, thanks.

