Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307C6D21C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjCaNw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCaNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B824C2F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680270690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhnn+p8SXXVq0Hmrz+dveiqW4/RhoUEGRno8sT7zrPE=;
        b=ia1AUxWkUWNsxrHr4BWhyreQlJ27PWUpt1roWCCbjjhfY2qBdgVIFnnuIhmGugoQDVAiYx
        bxtY0fgP0rweMu3X/zFdkhN5ekcGAzKgcUvpr1z5ob6j7kQ8msiKXluV3WLvdceKb37QP3
        rnzie3TV503uxg/WatOd9Q55gb9G1/Q=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-5nXXUGBtMbudZR92mVFCrw-1; Fri, 31 Mar 2023 09:51:26 -0400
X-MC-Unique: 5nXXUGBtMbudZR92mVFCrw-1
Received: by mail-io1-f70.google.com with SMTP id g7-20020a056602242700b00758e7dbd0dbso13830463iob.16
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680270685;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhnn+p8SXXVq0Hmrz+dveiqW4/RhoUEGRno8sT7zrPE=;
        b=WEvZXE/wiKSQnCw4QY1kvk08Aezn0B9qHUx0twHIeBFPKWsVogoIIwlTezkrqMcdJl
         5bfJtpPhQOo/cwmK3yXwT7HdwwNeEE7yX3Nv24Epa8v0SiFyBu8cVrePio9V+nCaq+UV
         F0re0iaKUGkYdg/5OoRzccz+w4gZpY/YGge6ea+FtLP5OEI/bVH7jeWs9E7cd3YKjq+X
         V2JCRhXAyqXVFFTh/uwJRVHuRxph13wvRjcOmrOajcz5UASI/Y4x55sR8OsCnYAgWL2N
         5NRJk+BiNtRDPQiEI9xsa/xX07JdEm8xackxVRU0CIIzhylDOqG03xcYVFW/LhedN6zW
         bcaQ==
X-Gm-Message-State: AAQBX9cPcOtaZTi3S3esqoGTyUUPCJ+VVb2U6Z7kvDkVUH4S7Lr1zxkb
        fuEbVunJel6u9DHg7pCxOsNd2U4lTaldqI0lOIrpPBr1aW5c8LAvcQaR+UwBary7XMFzgyj4FQb
        KU8viE3tzfIUNAgI7mCSc67Gho7y7SHVp
X-Received: by 2002:a92:c501:0:b0:317:3f4:c06c with SMTP id r1-20020a92c501000000b0031703f4c06cmr18434455ilg.20.1680270684954;
        Fri, 31 Mar 2023 06:51:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350aGEGK0AyddMKuYPniyOTTAijvw35ZXcUTm1VZOP+EPSBRiPx0N2y59Czio3Tg1W9RsM9IwBQ==
X-Received: by 2002:a92:c501:0:b0:317:3f4:c06c with SMTP id r1-20020a92c501000000b0031703f4c06cmr18434429ilg.20.1680270684674;
        Fri, 31 Mar 2023 06:51:24 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 8-20020a056e0211a800b00312f2936087sm618510ilj.63.2023.03.31.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 06:51:24 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:51:22 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Jing2" <jing2.liu@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "darwi@linutronix.de" <darwi@linutronix.de>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 7/8] vfio/pci: Support dynamic MSI-x
Message-ID: <20230331075122.736bdb98.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB12456636D269F997D1812FF8A98F9@MWHPR11MB1245.namprd11.prod.outlook.com>
References: <cover.1680038771.git.reinette.chatre@intel.com>
        <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
        <MWHPR11MB12456636D269F997D1812FF8A98F9@MWHPR11MB1245.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 10:02:32 +0000
"Liu, Jing2" <jing2.liu@intel.com> wrote:

> Hi Reinette,
> 
> > @@ -409,33 +416,62 @@ static int vfio_msi_set_vector_signal(struct
> > vfio_pci_core_device *vdev,  {
> >  	struct pci_dev *pdev = vdev->pdev;
> >  	struct vfio_pci_irq_ctx *ctx;
> > +	struct msi_map msix_map = {};
> > +	bool allow_dyn_alloc = false;
> >  	struct eventfd_ctx *trigger;
> > +	bool new_ctx = false;
> >  	int irq, ret;
> >  	u16 cmd;
> > 
> > +	/* Only MSI-X allows dynamic allocation. */
> > +	if (msix && pci_msix_can_alloc_dyn(vdev->pdev))
> > +		allow_dyn_alloc = true;
> > +
> >  	ctx = vfio_irq_ctx_get(vdev, vector);
> > -	if (!ctx)
> > +	if (!ctx && !allow_dyn_alloc)
> >  		return -EINVAL;
> > +
> >  	irq = pci_irq_vector(pdev, vector);
> > +	/* Context and interrupt are always allocated together. */
> > +	WARN_ON((ctx && irq == -EINVAL) || (!ctx && irq != -EINVAL));
> > 
> > -	if (ctx->trigger) {
> > +	if (ctx && ctx->trigger) {
> >  		irq_bypass_unregister_producer(&ctx->producer);
> > 
> >  		cmd = vfio_pci_memory_lock_and_enable(vdev);
> >  		free_irq(irq, ctx->trigger);
> > +		if (allow_dyn_alloc) {
> > +			msix_map.index = vector;
> > +			msix_map.virq = irq;
> > +			pci_msix_free_irq(pdev, msix_map);
> > +			irq = -EINVAL;
> > +		}
> >  		vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >  		kfree(ctx->name);
> >  		eventfd_ctx_put(ctx->trigger);
> >  		ctx->trigger = NULL;
> > +		if (allow_dyn_alloc) {
> > +			vfio_irq_ctx_free(vdev, ctx, vector);
> > +			ctx = NULL;
> > +		}
> >  	}
> > 
> >  	if (fd < 0)
> >  		return 0;
> >   
> 
> While looking at this piece of code, one thought comes to me: 
> It might be possible that userspace comes twice with the same valid fd for a specific
> vector, this vfio code will free the resource in if(ctx && ctx->trigger) for the second
> time, and then re-alloc again for the same fd given by userspace. 
> 
> Would that help if we firstly check e.g. ctx->trigger with the given valid fd, to see if 
> the trigger is really changed or not?

It's rather a made-up situation, if userspace wants to avoid bouncing
the vector when the eventfd hasn't changed they can simply test this
before calling the ioctl.  Thanks,

Alex

