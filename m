Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE35FF143
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJNP0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJNPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD514D8CA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665761143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcB1Dd02qNnlRqWFqiLsXhM/mN0rl3i8dID4hmWEfyE=;
        b=Kry6QqRFG8RT+nZa6HXZ1sBMSlvBpY2bfBujzsK9+7Ooqu6i11J1EfgHfGnXhKHMUv42Ij
        AhWjamIen6J81cjheiUU6dB9hFnBUn0YtcMZ5cKJC0VfIqrlWunxK5i2PK7RFcWOQI9y+1
        HuuZLdJceObf9+hxNvG+2soSO0Ykolg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-BCOrfLvZP4S496lqMnUbDQ-1; Fri, 14 Oct 2022 11:25:35 -0400
X-MC-Unique: BCOrfLvZP4S496lqMnUbDQ-1
Received: by mail-oo1-f70.google.com with SMTP id x26-20020a4aea1a000000b00480a4135181so1711936ood.15
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcB1Dd02qNnlRqWFqiLsXhM/mN0rl3i8dID4hmWEfyE=;
        b=O6M93vtRvzKNBwmc4VeIv3bOhgZFinwJkH3ZPUUL+4lGLnf666HWNXwR1N6WbxRx0E
         YPe3Qgu09Wm68WtYSpKSN8yZ6SZfY2pEn9UPQiEAEeSZnYKKPu+r/TzmsTeC6pjrWW+0
         wDK8X2kwB/EZPlCtsYv8UXngOOmNFANbemNdkeFPL9DFdMs7whSFN/GKRR4xo1B+WCTK
         tWzlUxmK3eauP1muG9qTbyP4oSKerQC27amD1M+R1mWN4PnxR3uCLy/RnB1aaAKgyChA
         cilCKboyTU7m7nHWWh4C+sOnBatFsirpAl3L+KQuF/Zi7OnzvewYq9fP0zCAq5ru+BmT
         P6wA==
X-Gm-Message-State: ACrzQf0rAumsYBf7sgFdyi8H8EO9fKTIl+/HBgebgo5XtYrpsEk5WhE+
        1zfrnZdyQzv/UcdmtlV68t+xr44SpkhfsMLTYwP7lZo0zBIA5xK3y+lKGShvA3gIAHgHau0u9Z6
        XiB8gdRUkvPbMufWF3eJhTp2F
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id cj5-20020a0568081b8500b0034d8ce1d5b0mr7495297oib.194.1665761132900;
        Fri, 14 Oct 2022 08:25:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zU+ArUpFFyEkA/KWd8KMHJT/xhSJJp6HMhkG8Vcr+QLHKEFyN/XJaK70E5mLZQwZc0euAcg==
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id cj5-20020a0568081b8500b0034d8ce1d5b0mr7495280oib.194.1665761132631;
        Fri, 14 Oct 2022 08:25:32 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c11-20020a4ad8cb000000b0047f72b6988fsm1026153oov.45.2022.10.14.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:25:31 -0700 (PDT)
Date:   Fri, 14 Oct 2022 08:25:29 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221014152529.hy3s4f7wz3vfn7ae@cantor>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
 <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
 <20221014021043.4rpzufoleeg7z5gx@cantor>
 <ea7ea775-5b87-82d6-c30a-8e60f1462476@linux.intel.com>
 <20221014065259.5koqcoxiuegg6kzj@cantor>
 <c2fff623-a9e2-dd36-b420-5ebb9e9a0d01@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2fff623-a9e2-dd36-b420-5ebb9e9a0d01@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 12:01:21PM +0100, Robin Murphy wrote:
> On 2022-10-14 07:52, Jerry Snitselaar wrote:
> > On Fri, Oct 14, 2022 at 10:22:21AM +0800, Baolu Lu wrote:
> > > On 2022/10/14 10:10, Jerry Snitselaar wrote:
> > > > On Fri, Oct 14, 2022 at 09:52:44AM +0800, Baolu Lu wrote:
> > > > > On 2022/10/13 23:33, Jerry Snitselaar wrote:
> > > > > > iommu_sva_bind_device() should only be called if
> > > > > > iommu_dev_enable_feature() succeeded. There has been one case already
> > > > > > where that hasn't been the case, which resulted in a null pointer
> > > > > > deref in dev_iommu_ops(). To avoid that happening in the future if
> > > > > > another driver makes that mistake, sanity check dev->iommu and
> > > > > > dev->iommu->iommu_dev prior to calling dev_iommu_ops().
> > > > > > 
> > > > > > Cc: Joerg Roedel<joro@8bytes.org>
> > > > > > Cc: Will Deacon<will@kernel.org>
> > > > > > Cc: Robin Murphy<robin.murphy@arm.com>
> > > > > > Cc: Lu Baolu<baolu.lu@linux.intel.com>
> > > > > > Signed-off-by: Jerry Snitselaar<jsnitsel@redhat.com>
> > > > > > ---
> > > > > > drivers/iommu/iommu.c | 10 +++++++++-
> > > > > >     1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > > > index 4893c2429ca5..20ec75667529 100644
> > > > > > --- a/drivers/iommu/iommu.c
> > > > > > +++ b/drivers/iommu/iommu.c
> > > > > > @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> > > > > >     {
> > > > > >     	struct iommu_group *group;
> > > > > >     	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> > > > > > -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > > > > > +	const struct iommu_ops *ops;
> > > > > > +
> > > > > > +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> > > > > > +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> > > > > > +			__func__);
> > > > > > +		return ERR_PTR(-ENODEV);
> > > > > > +	}
> > > > > If that's the case, dev_iommu_ops() will warn a NULL pointer reference.
> > > > > This kind of error will be discovered at the first place.
> > > > > 
> > > > > Best regards,
> > > > > baolu
> > > > > 
> > > > It will warn this by crashing the system (example from back when idxd had the problem):
> > > > 
> > > >       [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
> > > >       [   21.445108] #PF: supervisor read access in kernel mode
> > > >       [   21.450912] #PF: error_code(0x0000) - not-present page
> > > >       [   21.456706] PGD 0
> > > >       [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > >       [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
> > > >       [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
> > > >       [   21.464015] Workqueue: events work_for_cpu_fn
> > > >       [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
> > > >       [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
> > > >       [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
> > > >       [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
> > > >       [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
> > > >       [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
> > > >       [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
> > > >       [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
> > > >       [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
> > > >       [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >       [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
> > > >       [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > >       [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > > >       [   21.464078] PKRU: 55555554
> > > >       [   21.464079] Call Trace:
> > > >       [   21.464083]  <TASK>
> > > >       [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
> > > >       [   21.464121]  local_pci_probe+0x3e/0x80
> > > >       [   21.464132]  work_for_cpu_fn+0x13/0x20
> > > >       [   21.464136]  process_one_work+0x1c4/0x380
> > > >       [   21.464143]  worker_thread+0x1ab/0x380
> > > >       [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
> > > >       [   21.464158]  ? process_one_work+0x380/0x380
> > > >       [   21.464161]  kthread+0xe6/0x110
> > > >       [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
> > > >       [   21.464172]  ret_from_fork+0x1f/0x30
> > > > 
> > > > 
> > > > It was doing that to SPR systems that didn't boot with
> > > > intel_iommu=on. They had to either enable the iommu, or blacklist the
> > > > idxd driver until the idxd driver had a fix. The idea here is to
> > > > avoid taking the system down, and just have the driver get an error back.
> > > 
> > > If IOMMU is disabled, the iommu_dev_enable_feat(SVA) will return an
> > > error, the idxd driver should not call the sva_bind() interfaces
> > > anymore. If the driver doesn't do like this, why not fixing it in the
> > > driver itself?
> > > 
> > > Best regards,
> > > baolu
> > 
> > The idxd case was found, and fixed by me back in June. I just was
> > showing the stack trace to show that it crashes the system, not just
> > puts out a warning.
> > 
> > Why would this stop someone fixing the problem in a driver that is
> > calling sva_bind() interface incorrectly?
> > 
> > Nothing else in the system cares that some driver forgot to call
> > iommu_dev_enable_feat(), or forgot to check the return value. Nothing
> > else would be impacted by it, except that the system is being allowed
> > to crash. If the idea is to get noticed more quickly, couldn't a
> > WARN_ON() + returning an error solve that without resorting to
> > crashing the system?
> 
> The point is really that this is the kind of obvious bug that should be
> found during development; it's not the IOMMU API's responsibility if some
> driver patch gets merged and gets as far as a distro release without ever
> being fully tested. If someone doesn't use an API properly it can go wrong
> in any number of ways, so the value of maintaining code to mitigate just one
> of those ways is questionable. In this case, consider if a driver *is*
> present but failed iommu_dev_enable_feat() for some other reason, then its
> ->sva_bind goes and dereferences some internal data that it expects the
> previous ->dev_enable_feat to have allocated. Boom, it just crashes
> somewhere else instead.
> 
> If you really think it's worth the effort to maintain code that only serves
> to give lazy developers a free pass (and I freely admit to being a lazy
> developer most of the time) then a robust approach would be some generic
> tracking in dev->iommu for which features have been successfully enabled.
> Certainly I'm not convinced this patch as-is is worthwhile.
> 
> However, if a bad driver isn't handling the return from
> iommu_dev_enable_feature(), who's to say it's actually handling the return
> from iommu_sva_bind_device() either, and wouldn't still end up crashing some
> other way? Ultimately it's a game you can't win.
> 
> Thanks,
> Robin.

Okay. Thank you for the explanation.

To better understand where that line is for the future, what is the
argument for device_iommu_capable(), another exported symbol, doing
the same check? The lack of a prerequisite caller in the comments?  To
be clear I'm asking this out of desire to better know when it should
be done, not say hey Robin you did it! :)

I'm just irked by the number of problems I've had to chase down lately
that are no fault of the iommu code. The past few months have been
drivers using the dma api incorrectly for years, and OEMs forgetting
to put RMRR or IVMD blocks in the DMAR and IVRS tables. Of course
if there is an iommu call in the stack trace, or it goes away if you
disable the iommu or set iommu.passthrough=1, then obviously the iommu
is at fault. :)

Thanks,
Jerry

