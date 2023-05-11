Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839C56FFAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjEKT7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbjEKT7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:59:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE72D74
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:59:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f475366522so17196435e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683835181; x=1686427181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wBDXKCkpVEq1bwFGFMMeLeeqkXqpJxo8a8UGx6Si6Y=;
        b=GcQfFAXuCHGnqAcHTCkxr+aJq6v+CbluNycHUzjX3Aw7EvwtwxzeaJLlGVk8OMMqNo
         Iu00lIPRxupuGQX0zslfvy1EvNyX8/IaGfQzZA6/KfiV4OCK4Nq3D0jDMpn40x2vVRcl
         2qAWuMR3Mx2zCcIlO4kucy7+gM3n3UOSMq+sdNNAkHdxb13sjMfKPKRITJ38/QW1YzbX
         8K1PUDvxJN26EUPn1dYhgBRg8j7Dm3FJGcFJTyo+qaWblD/J5pB6Yr6+Lq8XeHBX2kIn
         b050jpBTbmPsqjouf6a34Oo/mhyzOMFlZBOiMh0ddG2KVGZGNl/uHt7yM+wU1r9qsrcX
         ioCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683835181; x=1686427181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wBDXKCkpVEq1bwFGFMMeLeeqkXqpJxo8a8UGx6Si6Y=;
        b=b3Wbeev7S+XdnUWkl4SpS+OflALjZ0gj709fttvOhrTPMegKZdjA0sSzQ5kZADPWC4
         348pFUZD/m9HSObUcPbBsl7Qgmekqtr5vPy9Q5oRGOraqJOCkHNLz/ZLBoHHR0iBakOy
         8MhfjvCwV8Z80gGxu3+09Zq4g0jTEVcBd38/BTOuVfXsZKWAZZKV5JHhYb4Di+NYju6F
         rByHnO5jR2hOkXnOV0cUYvoEGwWA76JQV5UIJrhGeDvcm/XT6X+OLKevqOKNTcPdaXmn
         o15QQVJLdhR5jWSahawFffoVgORoujv4NZRLgqLABVkoisIW8hEcBuXXgCBHThLaAm5Z
         ibbg==
X-Gm-Message-State: AC+VfDxhXbiCSNeN8EP7rU3sdEA9H7XKzZV5OkgxUEB7CuFFffDGWmwB
        sZS7ly1rMbBRv6vuQapr77apog==
X-Google-Smtp-Source: ACHHUZ6unYTBL1RUjfUzxVGnEvN/MXeMwmHTTOYL7romj5b/rw+3DX5ZhkRjW3cIoJnEQbwmEUOE8g==
X-Received: by 2002:a5d:63c3:0:b0:307:809b:614a with SMTP id c3-20020a5d63c3000000b00307809b614amr16477070wrw.29.1683835181479;
        Thu, 11 May 2023 12:59:41 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id p8-20020a056000018800b002f28de9f73bsm21612243wrx.55.2023.05.11.12.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:59:40 -0700 (PDT)
Date:   Thu, 11 May 2023 20:59:28 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Michael Shavit <mshavit@google.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, nicolinc@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] iommu/arm-smmu-v3: Keep track of attached ssids
Message-ID: <20230511195928.GA288490@myrica>
References: <20230510205054.2667898-1-mshavit@google.com>
 <20230510205054.2667898-5-mshavit@google.com>
 <ZFwLph9WXByeHxAW@nvidia.com>
 <CAKHBV2535Dsbm_w0LQYi=NuyqrYmXdPLjd1JrUVEHo+DiO0=ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV2535Dsbm_w0LQYi=NuyqrYmXdPLjd1JrUVEHo+DiO0=ZA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:26:48PM +0800, Michael Shavit wrote:
> > You should be getting rid of mm->pasid in this series as well.
> >
> > When each domain keeps track of what STE/CD entries that point to it then
> > *ALL* invalidation should iterate over the list of pointing entires
> > and generate the correct invalidation for that pointer.
> >
> 
> Completely agree. The arm_smmu_atc_inv_domain_ssid function introduced
> by this patch is a stopgap to decompose this patch from the SVA
> refactor that's required to stop using ssid in these calls.
> I also agree that such a refactoring probably belongs in the same
> patch series. @Jean-Philippe Brucker and others: is there any way I
> can about testing or at least exercising the SVA flow without physical
> hardware that supports SVA?

Yes, there is a model with a simple test device that supports PASID and
I/O page faults. It's not completely straightforward to setup and the
driver needs to be rewritten from scratch, but it's the best we have at
the moment.  I'd like to do something equally useful for QEMU, so we can
have proper regression tests, but that requires a lot of preliminary work
to add PASID+PRI to PCI, virtio and IOMMUs.

You'll need a kernel with the driver and a rootfs with the smmute
tool [1]; the RevC model [2] and a boot-wrapper [3]. 

  $ ${BOOTWRAPPER}/configure --host=aarch64-linux-gnu
     --with-dtb=${KERNEL}/arch/arm64/boot/dts/arm/fvp-base-revc.dts
     --with-kernel-dir=${KERNEL}
     --with-initrd=${BUILDROOT}/images/rootfs.cpio
     --with-cmdline="console=ttyAMA0"
     --enable-psci --enable-gicv3
  $ make	# produces linux-system.axf

Run the model:
  $ FVP_Base_RevC-2xAEMvA 
     -C bp.secure_memory=0
     -C 'pctl.startup=0.*.*.*'
     -C bp.refcounter.non_arch_start_at_default=1
     -C cache_state_modelled=0
     -C bp.vis.disable_visualisation=1
     -C bp.virtio_net.enabled=1
     -C bp.virtio_net.hostbridge.userNetPorts=8022=22
     -C bp.virtio_net.hostbridge.userNetworking=1
     -C pci.pci_smmuv3.mmu.SMMU_IDR0=135100351
     -C pci.pci_smmuv3.mmu.SMMU_IDR3=4116
     -C pci.pci_smmuv3.mmu.SMMU_IDR5=8389749
     -C cluster0.NUM_CORES=4
     -C cluster1.NUM_CORES=4
     -a 'cluster*.cpu*=linux-system.axf'

Then run a job using the tool. The process allocates two buffers and
passes their VA to the device (via the kernel driver). The device memcpies
one buffer to the other:

   $ smmute -u mmap
   ... Success

With smmu and iommu trace events enabled, a trace should contain
smmu_mm_invalidate and dev_fault/dev_page_response events.

It's not entirely representative of SVA flow, where an assignable device
interface is mapped into the process and the process launches jobs
directly without going through the kernel (that would now use
drivers/misc/uacce), but it does exercise IOMMU SVA: sva_bind(), device
accessing the process address space with PASID and some IOPFs, which I
think is what you're looking for. However this model doesn't have a PCI
test device so you won't be able to test ATC invalidations with PASID.

Other useful tests would be enabling lockdep (some intricate locking
between IOPF, the driver and mm), killing bound processes (-k), triggering
invalid accesses to verify TLB invalidations (-f tlb, I think). There is a
lot more to test, like thp and oom, but I don't have those in this branch.

Thanks,
Jean

[1] https://jpbrucker.net/git/linux/log/?h=sva/smmute-revc
[2] https://developer.arm.com/downloads/-/arm-ecosystem-models
[3] https://git.kernel.org/pub/scm/linux/kernel/git/mark/boot-wrapper-aarch64.git/
