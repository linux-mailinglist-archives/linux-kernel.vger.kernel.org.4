Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC162AF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKOXhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKOXhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C2F25C44
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668555417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XetoM6asLvbivro5LNSnOcG5/aoLdHsQPYTHt+rXSA=;
        b=c0kmxNsFhBoLQRvn0ssOwbZGKDI6G10qd1WzKiRov8WsEaX2JvHwYvIyAqWZwhgBLU5lJq
        aFh/Bhl0gjhKXplSFlCY36jS4wDq9L8U1Fa5Yo+gSyRkdEP+KO6HM/FMBZjyQx9e2B0sHs
        OUn/CIRc1TV97tJWLfwzqazXtmMFIYQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500--bERmD0CNRiuRacV1sW4Vw-1; Tue, 15 Nov 2022 18:36:56 -0500
X-MC-Unique: -bERmD0CNRiuRacV1sW4Vw-1
Received: by mail-wm1-f72.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so204633wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XetoM6asLvbivro5LNSnOcG5/aoLdHsQPYTHt+rXSA=;
        b=xx+bPkSoCC02+lFhsGmEwo2019pHLoN8JoWTzzfLDxsqED84bBYearwBYt1gqp6xqM
         8r0lTeTuoUTM/dibs8Zy44IgqqrocyAdKA6b4D8lEkpkcZk1pgBub647SUdkO/H6ARGu
         h1Jn9oM2o34AVt6Gh7rAifqZ/3uDKRNBbKnL+xSEqhxPvCr8I6w+fUEueFpG49+avtoe
         qv/ijlEGcc+fighfJemc5leYm0QakmSIVXOBagwHU2fVvonpn9t1wu7L5vXnD6PKROLb
         RzOCq8ePA7weU25mN1Sh8UehEL7PAkPc3+wRRFppaGmaMejnczMv5MeveV3PLk6C32Yq
         0E2g==
X-Gm-Message-State: ANoB5pmdQEljn3/fNrdQ5LwMyO1zVRbfQoBev1N4skOau9xsKg/myQ6S
        Xpgs0oZ380k0C4KGKcUCzw35hmeiI9cyOD8aB7V+ZXp0kZ8D0/Y4TEpjuhhe4OvLNpaxLAdu2m9
        sAAijcG0U/UAmpr+DbxDxqxha
X-Received: by 2002:adf:f0cd:0:b0:22e:344a:ec5e with SMTP id x13-20020adff0cd000000b0022e344aec5emr12775319wro.673.1668555415076;
        Tue, 15 Nov 2022 15:36:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44sAkEb9SFH8DlYi4u6Zl73rUGcsiZzrDiqrji/4ri1He1zDO1KBy7cZ0qLFGx2ppxCl+R5g==
X-Received: by 2002:adf:f0cd:0:b0:22e:344a:ec5e with SMTP id x13-20020adff0cd000000b0022e344aec5emr12775314wro.673.1668555414868;
        Tue, 15 Nov 2022 15:36:54 -0800 (PST)
Received: from redhat.com ([2.52.131.207])
        by smtp.gmail.com with ESMTPSA id s15-20020a7bc38f000000b003cf6a55d8e8sm239936wmj.7.2022.11.15.15.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:36:54 -0800 (PST)
Date:   Tue, 15 Nov 2022 18:36:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
Message-ID: <20221115183339-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx>
 <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx>
 <87o7t7rec7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7t7rec7.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:24:24AM +0100, Thomas Gleixner wrote:
> On Wed, Nov 16 2022 at 00:04, Thomas Gleixner wrote:
> 
> > On Tue, Nov 15 2022 at 17:44, Michael S. Tsirkin wrote:
> >> On Tue, Nov 15, 2022 at 11:19:47PM +0100, Thomas Gleixner wrote:
> >>> > We can see global_available drop from 15354 to 15273, is 81.
> >>> > And the total_allocated increase from 411 to 413. One config irq,and
> >>> > one vq irq.
> >>> 
> >>> Right. That's perfectly fine. At the point where you looking at it, the
> >>> matrix allocator has given out 2 vectors as can be seen via
> >>> total_allocated.
> >>> 
> >>> But then it also has another 79 vectors put aside for the other queues,
> >>
> >> What makes it put these vectors aside? pci_alloc_irq_vectors_affinity ?
> >
> > init_vq() -> virtio_find_vqs() -> vp_find_vqs() ->
> > vp_request_msix_vectors() -> pci_alloc_irq_vectors_affinity()
> >
> > init_vq() hands in a struct irq_affinity which means that
> > pci_alloc_irq_vectors_affinity() will spread out interrupts and have one
> > for config and one per queue if vp_request_msix_vectors() is invoked
> > with per_vq_vectors == true, which is what the first invocation in
> > vp_find_vqs() does.
> 
> I just checked on a random VM. The PCI device as advertised to the guest
> does not expose that many vectors. One has 2 and the other 4.
> 
> But as the interrupts are requested 'managed' the core ends up setting
> the vectors aside. That's a fundamental property of managed interrupts.
> 
> Assume you have less queues than CPUs, which is the case with 2 vectors
> and tons of CPUs, i.e. one ends up for config and the other for the
> actual queue. So the affinity spreading code will end up having the full
> cpumask for the queue vector, which is marked managed. And managed means
> that it's guaranteed e.g. in the CPU hotplug case that the interrupt can
> be migrated to a still online CPU.
> 
> So we end up setting 79 vectors aside (one per CPU) in the case that the
> virtio device only provides two vectors.
> 
> But that's not the end of the world as you really would need ~200 such
> devices to exhaust the vector space...
> 
> Thanks,
> 
>         tglx

Let's say we have 20 queues - then just 10 devices will exhaust the
vector space right?

-- 
MST

