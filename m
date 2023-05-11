Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE46FF665
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbjEKPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbjEKPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C6D26B3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683819916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbaF758nYgX15ESY7xACXZI0FlGL7YowE8ct7PgleW8=;
        b=H2Fx+4Ce9HLlA7sGzMHjbjsDyBaHpeZ2YcagRJwrFFgMfkXl7xPvaEAPGlfPElwphlqT0B
        DaWHvSZ4EEVbKlMzMpqIYmcQe0mo2CqT1LP/dr2Gv+RL4Y9l8GJHttN/7Nbtx7goLm5ozC
        EmtXdVFL7F74XDAVdMBT/6iY+ES9xi8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-F3mpir0fOAOZwWAQtqkq9w-1; Thu, 11 May 2023 11:45:15 -0400
X-MC-Unique: F3mpir0fOAOZwWAQtqkq9w-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3351d5ee486so39823755ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683819915; x=1686411915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbaF758nYgX15ESY7xACXZI0FlGL7YowE8ct7PgleW8=;
        b=OS5J+iK9aaAqW69h4iGitBvjIJdRNpnUMtwyVBxtxh5KU4woCO0gfnndcxaPRPhv5A
         mP2JnDO4Voasuwcan26xwPSpgPL7pYYYK+GHP01s+D7PpZc1jZ11IZPVzJPiJxveeI/x
         h3ilufSafDoOOEQkO1ODDYgwNVBhm4iUCN5XxNFN4whKuKQaNXtXLH/h+ztQO1hNhk/a
         i9NDxg7w9L096tMPmypUh4z4xfMb84VDGgbpChfB5ihqVgnhBzRgVSArzIS4TwsL12mZ
         BXaNZ3kcOGQt+06pTtgcEfnQJPLVmS3rEYuZ6mkCBF2vCF1I20GWJ1i5+RKlg0vQG3ql
         BVxQ==
X-Gm-Message-State: AC+VfDxrKT1zk/t4U3s6xsyao2vWeEre0gRuq+lYcb84YWN9CBU3zj8X
        DyPnF+2Nqgev3gcg31iA249uGutwPCqVA8JL4fydn1W1Vpohes0ZrKClQ89VWBrAW7mknMgi6pN
        KxiEefqjLk5EFgBjHeOlBwmty
X-Received: by 2002:a92:90c:0:b0:328:6e2d:5a2d with SMTP id y12-20020a92090c000000b003286e2d5a2dmr14857876ilg.6.1683819914809;
        Thu, 11 May 2023 08:45:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65xQV2GU9Ebkks3zdKwZUh2RMnTrcLm+7FSHWiTh8e5rnnmV/eWIYCHbSo6YbjQ09PsOo4Rg==
X-Received: by 2002:a92:90c:0:b0:328:6e2d:5a2d with SMTP id y12-20020a92090c000000b003286e2d5a2dmr14857867ilg.6.1683819914530;
        Thu, 11 May 2023 08:45:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id ck8-20020a0566383f0800b0040f7db6a264sm4122238jab.114.2023.05.11.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:45:13 -0700 (PDT)
Date:   Thu, 11 May 2023 09:45:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: vPASID capability for VF
Message-ID: <20230511094512.11b5bb7e.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52769ABFE779CE1D8838A7A78C749@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB52764BE569672A02FE2A8CCA8C769@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230510112449.4d766f6f.alex.williamson@redhat.com>
        <BN9PR11MB52769ABFE779CE1D8838A7A78C749@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 07:27:27 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, May 11, 2023 1:25 AM
> > 
> > On Tue, 9 May 2023 08:34:53 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > According to PCIe spec (7.8.9 PASID Extended Capability Structure):
> > >
> > >   The PASID configuration of the single non-VF Function representing
> > >   the device is also used by all VFs in the device. A PF is permitted
> > >   to implement the PASID capability, but VFs must not implement it.
> > >
> > > To enable PASID on VF then one open is where to locate the PASID
> > > capability in VF's vconfig space. vfio-pci doesn't know which offset
> > > may contain VF specific config registers. Finding such offset must
> > > come from a device specific knowledge.  
> > 
> > Backup for a moment, VFs are governed by the PASID capability on the
> > PF.  The PASID capability exposes control registers that imply the
> > ability to manage various feature enable bits.  The VF owner does not
> > have privileges to manipulate those bits.  For example, the PASID Enable
> > bit should restrict the endpoint from sending TLPs with a PASID prefix,
> > but this can only be changed at the PF level for all associated VFs.
> > 
> > The protocol specified in 7.8.9.3 defines this enable bit as RW.  How do
> > we virtualize that?  Either it's virtualized to be read-only and we
> > violate the spec or we allow it to be read-write and it has no effect,
> > which violates the spec.
> >   
> 
> Currently the PASID cap is enabled by default when a device is probed
> by iommu driver. Leaving it enabled in PF while guest wants it disabled
> in VF is harmless. W/o proper setup in iommu side the VF cannot
> do real work with PASID.
> 
> From this angle fully virtualizing it in software looks good to me.

So you're suggesting that the IOMMU setup for the VF to make use of
PASID would not occur until or unless PASID Enable is set in the
virtualized VF PASID capability and that support would be torn down
when PASID Enable is cleared?

This is still not strictly in adherence with the definition of the
PASID Enable bit which specifies that this bit controls whether the
endpoint is able to send or receive TLPs with the PASID prefix, which
clearly virtualization interacting with the IOMMU to block or allow
PASIDs from the VF RID cannot change.  Is it sufficient?

For example we can't use the vPASID capability to make any guarantees
about in-flight PASID TLPs when sequencing IOMMU operations since we
can't actually prevent VFs using PASID so long as PASID Enable is set
on the PF.

> In another thread it's suggested that enabling the PASID cap should be
> opted in by device driver instead of by iommu driver.
> 
> If that happens then vfio-pci may want to call into the PF driver
> when the vPASID cap is enabled in VF. If the physical PASID cap in PF
> hasn't been enabled then enable it. The PF driver will track which VF's
> or its own clients require the PASID cap and keep it enabled until
> no one wants it.

Why wouldn't we just require PASID support to be enabled and remain
enabled on the PF or else we don't expose the virtualized PASID
capability on the VF?

I don't particularly like the idea of allowing userspace VF drivers to
vote on the PASID Enable state of the PF driver.  The PF driver should
be able to control the policy whether PASID support is enabled,
especially given the interaction with ATS, as noted by Baolu.  Thanks,

Alex

