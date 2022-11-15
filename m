Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64E62AE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKOWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiKOWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E3D175BE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668552287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ySoNkDzpjpG+PGzliTMgnSc8ulhtJKr+ctFAbGLHSE=;
        b=RgnCDi/EIaHGFxsPIPzeBWpiILO8RRsb9iUSPlMAjLMEg/coKiFIQlrpmjn0IISbPV5ajk
        F+5/bqNRRF3jkaAGkFd9Lpit8ZsehcNjrG1L6VKCo+IZycxuajxYqy8TRWYSp44eeQumaH
        cQjk2LC4zUcBE4r8V+G94n38K6mNpvw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-hhuQPXVaPv-6EUlReJhB_g-1; Tue, 15 Nov 2022 17:44:46 -0500
X-MC-Unique: hhuQPXVaPv-6EUlReJhB_g-1
Received: by mail-wm1-f72.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so168737wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ySoNkDzpjpG+PGzliTMgnSc8ulhtJKr+ctFAbGLHSE=;
        b=d1pt+MCrnLGS/lAUXablRdHmdBzpKDRbTGMv3HDyUf1IlOynDx5UcLUg8wNmagtANJ
         S1xSTg239Zgz0ES9SBceRowfSy7g4ZUENUGUVTelJsLd1LAt4cdFd8u39pGburSdHQqq
         rytsoj54SWBk0YJo2dsBhl6znePfHRmcN9oG6cpKAqO2u75IgWZv0PiVS5Jvac9Mvv9K
         u1oBgBygakJ+SDutF5UGlauNRfPxA3oA3bIwojWZfIayfqFgaasP2X0aeWpXZuivPkHc
         URl4A1knCIStkw9yWZQxfTVR552Yn1YAJRReeUDLc94ZXkxaNqhnLKVt5/fNNtapMuQa
         djDQ==
X-Gm-Message-State: ANoB5pl2B3++QVFixJwpGOrF9us9BDmMlkFTSlQYUa9OQXc8yKfgfRtq
        /WvVrdBB0YPq9pizVqwC9Ds7T51CnDX48jyJBz5iwIpWohNEq0skq95soP8RcSvfRa6Ni2d3o48
        VegsA69tRDb4O1ELN/PY+kEov
X-Received: by 2002:a1c:7308:0:b0:3cf:cf89:90f with SMTP id d8-20020a1c7308000000b003cfcf89090fmr222362wmb.186.1668552285425;
        Tue, 15 Nov 2022 14:44:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ntKWZ1vGIjMiKSgHkj9e1DaAeaQUX28zDi7MInU3a8fxnozVW1JNP7z/DzPjy7nhbVISvGg==
X-Received: by 2002:a1c:7308:0:b0:3cf:cf89:90f with SMTP id d8-20020a1c7308000000b003cfcf89090fmr222349wmb.186.1668552285068;
        Tue, 15 Nov 2022 14:44:45 -0800 (PST)
Received: from redhat.com ([2.52.131.207])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b002417f35767asm10192296wrr.40.2022.11.15.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 14:44:44 -0800 (PST)
Date:   Tue, 15 Nov 2022 17:44:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
Message-ID: <20221115174152-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8nfrhbw.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Thomas, I have a question:

On Tue, Nov 15, 2022 at 11:19:47PM +0100, Thomas Gleixner wrote:
> On Tue, Nov 15 2022 at 03:40, Angus Chen wrote:
> > Before probe one virtio_blk.
> > crash_cts> p *vector_matrix
> > $44 = {
> >   matrix_bits = 256,
> >   alloc_start = 32,
> >   alloc_end = 236,
> >   alloc_size = 204,
> >   global_available = 15354,
> >   global_reserved = 154,
> >   systembits_inalloc = 3,
> >   total_allocated = 411,
> >   online_maps = 80,
> >   maps = 0x46100,
> >   scratch_map = {1160908723191807, 0, 1, 18435222497520517120},
> >   system_map = {1125904739729407, 0, 1, 18435221191850459136}
> > }
> > After probe one virtio_blk.
> > crash_cts> p *vector_matrix
> > $45 = {
> >   matrix_bits = 256,
> >   alloc_start = 32,
> >   alloc_end = 236,
> >   alloc_size = 204,
> >   global_available = 15273,
> >   global_reserved = 154,
> >   systembits_inalloc = 3,
> >   total_allocated = 413,
> >   online_maps = 80,
> >   maps = 0x46100,
> >   scratch_map = {25769803776, 0, 0, 14680064},
> >   system_map = {1125904739729407, 0, 1, 18435221191850459136}
> > }
> >
> > We can see global_available drop from 15354 to 15273, is 81.
> > And the total_allocated increase from 411 to 413. One config irq,and
> > one vq irq.
> 
> Right. That's perfectly fine. At the point where you looking at it, the
> matrix allocator has given out 2 vectors as can be seen via
> total_allocated.
> 
> But then it also has another 79 vectors put aside for the other queues,


What makes it put these vectors aside? pci_alloc_irq_vectors_affinity ?



> but those queues have not yet requested the interrupts so there is no
> allocation yet. But the vectors are guaranteed to be available when
> request_irq() for those queues runs, which does the actual allocation.
> 
> Btw, you can enable CONFIG_GENERIC_IRQ_DEBUGFS and then look at the
> content of /sys/kernel/debug/irq/domain/VECTOR which gives you a very
> clear picture of what's going on. No need for gdb.
> 
> > It is easy to expend the irq resource ,because virtio_blk device could
> > be more than 512.
> 
> How so? virtio_blk allocates a config interrupt and one queue interrupt
> per CPU. So in your case a total of 81.
> 
> How would you exhaust the vector space? Each CPU has about ~200 (in your
> case exactly 204) vectors which can be handed out to devices. You'd need
> to instantiate about 200 virtio_blk devices to get to the point of
> vector exhaustion.
> 
> So what are you actually worried about and which problem are you trying
> to solve?
> 
> Thanks,
> 
>         tglx
> 

