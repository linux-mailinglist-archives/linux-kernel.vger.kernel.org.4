Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0F5FE6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJNCKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJNCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF0E4C26
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665713447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gn4RWbQ4OLsDK9fSmrJSAG/p4d/8VSCxdXA37Xs8VVg=;
        b=TouasGZjSiMFW8/sGD1IeJNMv/BsmqrNWcQfryXSvLmeUeIW3PxEcABCYkhs17Gq+V9PQY
        43SOh3+upreIrrugH5iZQsD5h2ncBhucFktovQn12GzGJLNOOYs6B7KwTM9rJdPSF2TIPd
        jhK94vZpQD9MDIBOO7fswi4evwf5zAg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-2baSiZfTMUiqcdDbBiISzw-1; Thu, 13 Oct 2022 22:10:46 -0400
X-MC-Unique: 2baSiZfTMUiqcdDbBiISzw-1
Received: by mail-ot1-f71.google.com with SMTP id a22-20020a0568300b9600b0065c0cef3662so779198otv.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn4RWbQ4OLsDK9fSmrJSAG/p4d/8VSCxdXA37Xs8VVg=;
        b=YiWwlva+nS8nLgtzplNc6bdpdLrX1H/O+Bi67BCe+i6josjKWb9X3ui0MEAEvQF93Y
         51pbkXCDCz1eC+vA6v7csXbo4dpvHGPqM2DrPYp6C5MAsWprciOiFHSm75l2fmFX6yLP
         CBYyudLAk4lgE5ZYrNOmv5LQ/apppEyRqEWxDtkoTjHu2r6lB7khR7GaEOQPdwVl4wFk
         PAronjLspsiKbJMoPeK29exlIL8foAaw70LDOql9XbeFiNjQmZvrMKlQa1yj8FU/YBM2
         NCmv6AGQNOOcbQJf2ryxG6vyGNyyI/59H+avGPRiJXFwvzCs3nFfqmfHPy5pX9kh3mp7
         GgbQ==
X-Gm-Message-State: ACrzQf1/qRqyiB8hlaK6Zq4saO5XXktQldx+HQABlWUbAUuyOUzRAWht
        y8h5ohlPXu+4QFTlnLcJ0PnZ8wzFqZxPUeDM70ZJ/t44SQHFRghX4tok/KDxDn8UEyubaHkNQrm
        s/zb+LBppT7UrqsOLpb4juylC
X-Received: by 2002:aca:db45:0:b0:354:b943:9e5b with SMTP id s66-20020acadb45000000b00354b9439e5bmr1350989oig.277.1665713445352;
        Thu, 13 Oct 2022 19:10:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM44UrufZNFRPiXG+GgJsVkhybbtYE/Dbzc2XbRoD67kJQ51+BaYbuVLveficnlRsaCW8XQ6RA==
X-Received: by 2002:aca:db45:0:b0:354:b943:9e5b with SMTP id s66-20020acadb45000000b00354b9439e5bmr1350976oig.277.1665713445079;
        Thu, 13 Oct 2022 19:10:45 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id d24-20020a056830045800b006618b23df05sm690372otc.21.2022.10.13.19.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 19:10:44 -0700 (PDT)
Date:   Thu, 13 Oct 2022 19:10:43 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221014021043.4rpzufoleeg7z5gx@cantor>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
 <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 09:52:44AM +0800, Baolu Lu wrote:
> On 2022/10/13 23:33, Jerry Snitselaar wrote:
> > iommu_sva_bind_device() should only be called if
> > iommu_dev_enable_feature() succeeded. There has been one case already
> > where that hasn't been the case, which resulted in a null pointer
> > deref in dev_iommu_ops(). To avoid that happening in the future if
> > another driver makes that mistake, sanity check dev->iommu and
> > dev->iommu->iommu_dev prior to calling dev_iommu_ops().
> > 
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> > drivers/iommu/iommu.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 4893c2429ca5..20ec75667529 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> >   {
> >   	struct iommu_group *group;
> >   	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> > -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > +	const struct iommu_ops *ops;
> > +
> > +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> > +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> > +			__func__);
> > +		return ERR_PTR(-ENODEV);
> > +	}
> 
> If that's the case, dev_iommu_ops() will warn a NULL pointer reference.
> This kind of error will be discovered at the first place.
> 
> Best regards,
> baolu
> 

It will warn this by crashing the system (example from back when idxd had the problem):

    [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
    [   21.445108] #PF: supervisor read access in kernel mode
    [   21.450912] #PF: error_code(0x0000) - not-present page
    [   21.456706] PGD 0
    [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
    [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
    [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
    [   21.464015] Workqueue: events work_for_cpu_fn
    [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
    [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
    [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
    [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
    [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
    [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
    [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
    [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
    [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
    [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
    [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
    [   21.464078] PKRU: 55555554
    [   21.464079] Call Trace:
    [   21.464083]  <TASK>
    [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
    [   21.464121]  local_pci_probe+0x3e/0x80
    [   21.464132]  work_for_cpu_fn+0x13/0x20
    [   21.464136]  process_one_work+0x1c4/0x380
    [   21.464143]  worker_thread+0x1ab/0x380
    [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
    [   21.464158]  ? process_one_work+0x380/0x380
    [   21.464161]  kthread+0xe6/0x110
    [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
    [   21.464172]  ret_from_fork+0x1f/0x30


It was doing that to SPR systems that didn't boot with
intel_iommu=on. They had to either enable the iommu, or blacklist the
idxd driver until the idxd driver had a fix. The idea here is to
avoid taking the system down, and just have the driver get an error back.

Regards,
Jerry

> > +
> > +	ops = dev_iommu_ops(dev);
> >   	if (!ops->sva_bind)
> >   		return ERR_PTR(-ENODEV);

