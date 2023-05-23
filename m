Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615DB70D6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjEWIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjEWIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:07:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496CE4B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:06:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33164ec77ccso121085ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684829207; x=1687421207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0Qlrnd0R6kSqL86O88QBELK4XlmSu/G3+eVbSMXROU=;
        b=h06wA/q+C7KtXuWsKjus/5S5OeCMphpGUE8E/w4PytjQyGSGv/OJSRLCUygrOQPrBK
         9ib1EzRxb0Zk9OO8EbkJbPmsBhEMlung3et5g7rnXzUqadfSElRzbjvrJofNk+JziuXL
         F4wnlchljisIjPZC2QQ5cv5KglQj2igBc4405o8lGd6d5ogkwjOht6XpmyQz0XCg1Nmo
         N9Qp222rxah+zy2GxnSc6uhlToQqTuHiwdXX7Irkvj16pa1+iMODZKjuW6y255EBkw+C
         HIWeurntunUbR95KVosRaPmmRSKy79Gx+/HncZRmsdfcqPt2GbNGCoSi7X1ybR1+gCWx
         G5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684829207; x=1687421207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0Qlrnd0R6kSqL86O88QBELK4XlmSu/G3+eVbSMXROU=;
        b=Op84J5ev7G5QKFXZexK2Lm2jTayVyHsT3YhasnI2cgFqAx86BnNgNQwmGxWKeb6VRx
         6seXHRv0/dk8m6OqL/VnX54qaBf7J9EyCpvL0fGCGxoLYFdQ1mrgFrJeXwYbU+YW6Oex
         QZJoIt/vuiQGcJRWkbFYEo4xAQbGk2BMRCFW/MftGqoWaDCRCEuc9W3QQKSDwYfnrqUD
         srewYtG1cDB2M28cskGjdT5IDB+xdcK5nYQVxCQTLsKT7vfvp6k/9ujGLgsamXcrF53z
         IpQn1KuU9/gmSLdVvNzolXuRfG9NVR6md2Agm4PcW+MLd7v39cPLCQgQMD0RGg13vp8a
         nCZg==
X-Gm-Message-State: AC+VfDyG+1L16gOUYlfPohP9j0MP7RXnGkGP0EYPTEiXBP91zO1gEye7
        EZ/4fkdULKxMnfnDvqLm/Fx575UocYyCK1EcSGuJ6JptblnFbA/HlLw=
X-Google-Smtp-Source: ACHHUZ6GgCcfaHRO+RcoEiu9TcPl4COQ1hHtVxoAHRksHQKAV2bSus5PClfM3Xko0bVoPhF/7C7t6CgipxxRPVUwAhk=
X-Received: by 2002:a05:622a:1a09:b0:3f6:97b4:1a51 with SMTP id
 f9-20020a05622a1a0900b003f697b41a51mr103568qtb.27.1684828704735; Tue, 23 May
 2023 00:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com> <20230510205054.2667898-5-mshavit@google.com>
 <ZFwLph9WXByeHxAW@nvidia.com> <CAKHBV2535Dsbm_w0LQYi=NuyqrYmXdPLjd1JrUVEHo+DiO0=ZA@mail.gmail.com>
 <20230511195928.GA288490@myrica>
In-Reply-To: <20230511195928.GA288490@myrica>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 23 May 2023 15:57:48 +0800
Message-ID: <CAKHBV25kgZFdO=w7tDJ6wTSXgY_Dx67ec3A5yTZdFTu_8PTC-g@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, nicolinc@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh nice, this is exactly what I was looking for (minus the missing ATC
inv, but that's somewhat easier to reason from code)! Thanks for the
detailed guide Jean!
I finally got around to trying it out and was able to see the page
fault followed by invalidations on this patch-series as it is. This
will be super useful to start refactoring SVA for a v2 of this patch.

On Fri, May 12, 2023 at 3:59=E2=80=AFAM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, May 11, 2023 at 11:26:48PM +0800, Michael Shavit wrote:
> > > You should be getting rid of mm->pasid in this series as well.
> > >
> > > When each domain keeps track of what STE/CD entries that point to it =
then
> > > *ALL* invalidation should iterate over the list of pointing entires
> > > and generate the correct invalidation for that pointer.
> > >
> >
> > Completely agree. The arm_smmu_atc_inv_domain_ssid function introduced
> > by this patch is a stopgap to decompose this patch from the SVA
> > refactor that's required to stop using ssid in these calls.
> > I also agree that such a refactoring probably belongs in the same
> > patch series. @Jean-Philippe Brucker and others: is there any way I
> > can about testing or at least exercising the SVA flow without physical
> > hardware that supports SVA?
>
> Yes, there is a model with a simple test device that supports PASID and
> I/O page faults. It's not completely straightforward to setup and the
> driver needs to be rewritten from scratch, but it's the best we have at
> the moment.  I'd like to do something equally useful for QEMU, so we can
> have proper regression tests, but that requires a lot of preliminary work
> to add PASID+PRI to PCI, virtio and IOMMUs.
>
> You'll need a kernel with the driver and a rootfs with the smmute
> tool [1]; the RevC model [2] and a boot-wrapper [3].
>
>   $ ${BOOTWRAPPER}/configure --host=3Daarch64-linux-gnu
>      --with-dtb=3D${KERNEL}/arch/arm64/boot/dts/arm/fvp-base-revc.dts
>      --with-kernel-dir=3D${KERNEL}
>      --with-initrd=3D${BUILDROOT}/images/rootfs.cpio
>      --with-cmdline=3D"console=3DttyAMA0"
>      --enable-psci --enable-gicv3
>   $ make        # produces linux-system.axf
>
> Run the model:
>   $ FVP_Base_RevC-2xAEMvA
>      -C bp.secure_memory=3D0
>      -C 'pctl.startup=3D0.*.*.*'
>      -C bp.refcounter.non_arch_start_at_default=3D1
>      -C cache_state_modelled=3D0
>      -C bp.vis.disable_visualisation=3D1
>      -C bp.virtio_net.enabled=3D1
>      -C bp.virtio_net.hostbridge.userNetPorts=3D8022=3D22
>      -C bp.virtio_net.hostbridge.userNetworking=3D1
>      -C pci.pci_smmuv3.mmu.SMMU_IDR0=3D135100351
>      -C pci.pci_smmuv3.mmu.SMMU_IDR3=3D4116
>      -C pci.pci_smmuv3.mmu.SMMU_IDR5=3D8389749
>      -C cluster0.NUM_CORES=3D4
>      -C cluster1.NUM_CORES=3D4
>      -a 'cluster*.cpu*=3Dlinux-system.axf'
>
> Then run a job using the tool. The process allocates two buffers and
> passes their VA to the device (via the kernel driver). The device memcpie=
s
> one buffer to the other:
>
>    $ smmute -u mmap
>    ... Success
>
> With smmu and iommu trace events enabled, a trace should contain
> smmu_mm_invalidate and dev_fault/dev_page_response events.
>
> It's not entirely representative of SVA flow, where an assignable device
> interface is mapped into the process and the process launches jobs
> directly without going through the kernel (that would now use
> drivers/misc/uacce), but it does exercise IOMMU SVA: sva_bind(), device
> accessing the process address space with PASID and some IOPFs, which I
> think is what you're looking for. However this model doesn't have a PCI
> test device so you won't be able to test ATC invalidations with PASID.
>
> Other useful tests would be enabling lockdep (some intricate locking
> between IOPF, the driver and mm), killing bound processes (-k), triggerin=
g
> invalid accesses to verify TLB invalidations (-f tlb, I think). There is =
a
> lot more to test, like thp and oom, but I don't have those in this branch=
.
>
> Thanks,
> Jean
>
> [1] https://jpbrucker.net/git/linux/log/?h=3Dsva/smmute-revc
> [2] https://developer.arm.com/downloads/-/arm-ecosystem-models
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aar=
ch64.git/
