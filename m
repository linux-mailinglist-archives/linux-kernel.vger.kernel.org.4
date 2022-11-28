Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9D63AD21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiK1P71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiK1P7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:59:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5FF24943
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669651161; x=1701187161;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBuxU49LUQ4uKW0JjDLf2e9bsk7OGzzJsrGbayCoQb0=;
  b=jAnyIHlQGoB+gKWaU94BYh2FaKHACPYvWe59GCESd7pOJR0smRAfN+0b
   1qoGgZJKvlnVb0y71EO2dBl4f0Gj9ZvU3tbNhrZ/iquC11CyZlUxlCzkl
   aVgP1+xlC/2f1g6z+H0dfdcfXxm/xOoOVRUuBykTOZSEizAzGRI8/kGvg
   zjD+k5U7VKkLbcnX6eL/NqqGS7fxpTvhRumaK4hsiAlFsp4wwovxORA0y
   lBOS2IdimQtwuEXyWbQ+95a7AsCAqYdLTjyrrsbvNIck0o3EPJNLEAnba
   fQ9H0nihzPrWvzb39TSKDcw6DNzivgo+XTXextY43tkoTQP4mre71tWT9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316700556"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316700556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:58:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643435705"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="643435705"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:58:34 -0800
Date:   Mon, 28 Nov 2022 08:02:25 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Message-ID: <20221128080225.6d51a474@jacob-builder>
In-Reply-To: <992ba86c-73e6-8db0-0216-c2a8b7d1f58f@linux.intel.com>
References: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
        <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
        <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <c085f67d-7874-4a83-a12c-703d1638d940@linux.intel.com>
        <BN9PR11MB527642B1DA920C78742036FD8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <53678e27-1bbc-a7e8-a1b0-0427fc0e5b62@arm.com>
        <992ba86c-73e6-8db0-0216-c2a8b7d1f58f@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, 24 Nov 2022 10:52:32 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 11/23/22 7:32 PM, Robin Murphy wrote:
> > On 2022-11-23 05:18, Tian, Kevin wrote: =20
> >>> From: Baolu Lu <baolu.lu@linux.intel.com>
> >>> Sent: Wednesday, November 23, 2022 1:04 PM
> >>>
> >>> On 2022/11/23 9:02, Tian, Kevin wrote: =20
> >>>>> From: Robin Murphy <robin.murphy@arm.com>
> >>>>> Sent: Wednesday, November 23, 2022 1:49 AM
> >>>>> =20
> >>>>>> +
> >>>>>> +/* Impacted QAT device IDs ranging from 0x4940 to 0x4943 */
> >>>>>> +#define BUGGY_QAT_DEVID_MASK 0x494c
> >>>>>> +static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
> >>>>>> +{
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (pdev->vendor !=3D PCI_VENDOR_ID_INTEL)
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0 if ((pdev->device & 0xfffc) !=3D BUGGY_QAT_DEV=
ID_MASK)
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0 if (risky_device(pdev))
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false; =20
> >>>>>
> >>>>> Hmm, I'm not sure that that makes much sense to me - what privilege=
=20
> >>>>> can
> >>>>> the device gain from being told to invalidate things twice? Why=20
> >>>>> would we
> >>>>> want to implicitly *allow* a device to potentially keep using a
> >>>>> stale translation if for some bizarre reason firmware has marked it
> >>>>> as external, surely that's worse? =20
> >>>
> >>> =C2=A0 From the perspective of IOMMU, any quirk is only applicable to
> >>> trusted devices. If the IOMMU driver detects that a quirk is being
> >>> applied to an untrusted device, it is already buggy or malicious. The
> >>> IOMMU driver should let the users know by:
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0pci_info(pdev,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Skipping IOMMU quir=
k for dev [%04X:%04X] on untrusted
> >>> PCI link\n",
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdev->vendor, pdev->=
device);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0pci_info(pdev, "Please check with your BIOS/P=
latform vendor about
> >>> this\n");
> >>>
> >>> and stop applying any quirk.
> >>> =20
> >>
> >> A quirk usually relaxes something then you want it only on trusted=20
> >> devices.
> >>
> >> but the quirk in this patch is trying to fix a vulnerability. In=20
> >> concept it's
> >> weird to skip it on untrusted devices. This iiuc was the part causing=
=20
> >> confusion
> >> to Robin. =20
> >=20
> > Right, it's that reasoning in general that seems bogus to me. Clearly=20
> > any quirk that effectively grants additional privileges, like an=20
> > identity mapping quirk, should not be applied to untrusted external=20
> > devices which may be spoofing an affected VID/DID to gain that=20
> > privilege, but not all quirks imply privilege. If, say, a WiFI=20
> > controller needs something innocuous like a DMA alias or address width=
=20
> > quirk to function correctly, it will still need that regardless of=20
> > whether it's soldered to a motherboard or to a removable expansion
> > card, and it would do nobody any good to deny correct functionality
> > based on that unnecessary distinction. Yes, I appreciate that in
> > practice many of those kind of quirks will be applied in other layers
> > anyway, but I still think it's wrong to make a sweeping assumption that
> > all IOMMU-level quirks are precious treasure not to be shared with
> > outsiders, rather than assess their impact individually. The detriment
> > in this case is small (just needless code churn), but even that's still
> > not nothing. =20
>=20
> Fair enough. I agreed here.
>=20
> Can we put some comments here so that people can still easily read the
> discussion here after a long time?

Sure, I will remove risky_device(pdev) check and add a comment explaining
the exemption.


Thanks,

Jacob
