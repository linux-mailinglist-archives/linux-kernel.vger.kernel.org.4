Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7E724B02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbjFFSOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbjFFSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534610DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686075233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uLli3yz1DYI1/D8uLJjLkh+ys9q2UvcidB0MAb3VgM=;
        b=bz00p86B1FtUAEThPIbfmT4Nfs/QKWAXJYs3LkekWhWukiH2+4/LyhYP7KQ9DDDsN3XSCw
        +B+ifnJsD0dYBeXA9QCTGqZjXqqE7iRIH9bWl7gxkl2dLe712YHefZmWcjxeeek7Brb7YD
        I5MN60hTPgjqCx5fLQmqMP5hbHHGyrc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-vUQ99C67P1-SyJjevdpajw-1; Tue, 06 Jun 2023 14:13:52 -0400
X-MC-Unique: vUQ99C67P1-SyJjevdpajw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-77a1f4e92cdso39023939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075231; x=1688667231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uLli3yz1DYI1/D8uLJjLkh+ys9q2UvcidB0MAb3VgM=;
        b=VGF9QdPRqMDNeq9a8DjLYXNWpdQUJrHNLGKQkGtdrSGJA3IqcTTdmPJgv7wLWgobz3
         VwNpr4shIfYSM14JdhhVVtc5jEKdbIVR7df3x1+3JUwH0quJuMgTnAmz+28kYRidDLZ2
         1uPp4QGEIWWyGjw2wKa857hS3WyvWHaNgtQ1KwMo5qj8EpNxNHMSfrGBLyzgE187jayt
         5mo8113lEN1GKW4FJbf17tmS4o2iDKMs3Z8iEgaOKCha0idmNnmdZKKpRqsEPxqznr3R
         s3RW0PLCL4vOLzvxh/unOLLQgALK6IJgzd1MisTPVHDIHtYoM1w8rrAmm/SfkGxGZZx+
         LcqA==
X-Gm-Message-State: AC+VfDyPyeYIre7wqqdvwBi+ZGqiTx7CPC+tX4duGbOvc9E6iWBwx/Sb
        Ul9GhXnPg6iNmfdC0JwMXpR5XJ+2ohPryX5TjaiUKRHryIPEmxcU2osYMs2SYmdOKizKCxVxT1O
        1io0mzJvXCLynuw7BGC4U7qs5
X-Received: by 2002:a05:6e02:128c:b0:331:85fa:74c5 with SMTP id y12-20020a056e02128c00b0033185fa74c5mr2620084ilq.1.1686075231122;
        Tue, 06 Jun 2023 11:13:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7k+blw9vPOLpvg+3qppUSS4w3PTeZqEhsRV5Mhqk3Ou+cjFTQOKYmh9jBA+88W34/P7aBrLg==
X-Received: by 2002:a05:6e02:128c:b0:331:85fa:74c5 with SMTP id y12-20020a056e02128c00b0033185fa74c5mr2620069ilq.1.1686075230879;
        Tue, 06 Jun 2023 11:13:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a22-20020a056638019600b0041abd81975bsm2931075jaq.153.2023.06.06.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:13:50 -0700 (PDT)
Date:   Tue, 6 Jun 2023 12:13:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, aniketa@nvidia.com, cjia@nvidia.com,
        kwankhede@nvidia.com, targupta@nvidia.com, vsethi@nvidia.com,
        acurrid@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com,
        danw@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20230606121348.670229ff.alex.williamson@redhat.com>
In-Reply-To: <ZH9p+giEs6bCYfw8@nvidia.com>
References: <20230606025320.22647-1-ankita@nvidia.com>
        <20230606083238.48ea50e9.alex.williamson@redhat.com>
        <ZH9RfXhbuED2IUgJ@nvidia.com>
        <20230606110510.0f87952c.alex.williamson@redhat.com>
        <ZH9p+giEs6bCYfw8@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 14:16:42 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 06, 2023 at 11:05:10AM -0600, Alex Williamson wrote:
> 
> > It actually seems more complicated this way.  We're masquerading this
> > region as a BAR, but then QEMU needs to know based on device IDs that
> > it's really not a BAR, it has special size properties, mapping
> > attributes, error handling, etc.    
> 
> This seems like something has gone wrong then. ie the SIGUBS error
> handling stuff should be totally generic in the qemu side. Mapping
> attributes are set by the kernel, qemu shouldn't know, doesn't need to
> know.

You asked me to look at the v1 posting to see why there's so much more
going on here than a quirk.  That's what I read from the first public
posting, a coherent memory region masqueraded as a BAR which requires
different memory mapping and participates in ECC.  I agree that the
actual mapping is done by the kernel, but it doesn't really make a
difference if that's a vfio-pci variant driver providing a different
mmap callback for a BAR region or a device specific region handler.

> The size issue is going to a be a problem in future anyhow, I expect
> some new standards coming to support non-power-two sizes and they will
> want to map to PCI devices in VMs still.

Ok, but a PCI BAR has specific constraints and a non-power-of-2 BAR is
not software compatible with those constraints.  That's obviously not
to say that a new capability couldn't expose arbitrary resources sizes
on a PCI-like device though.  I don't see how a non-power-of-2 BAR at
this stage helps or fits within any spec, which is exactly what's
being proposed through this BAR masquerade.
 
> It seems OK to me if qemu can do this generically for any "BAR"
> region, at least creating an entire "nvidia only" code path just for
> non power 2 BAR sizing seems like a bad ABI choice.

Have you looked at Ankit's QEMU series?  It's entirely NVIDIA-only code
paths.  Also nothing here precludes that shared code in QEMU might
expose some known arbitrary sized regions as a BAR, or whatever spec
defined thing allows that in the future.  It would only be a slight
modification in the QEMU code to key on the presence of a device
specific region rather than PCI vendor and device IDs, to then register
that region as a PCI BAR and proceed with all this NVIDIA specific
PXM/SRAT setup. IMO it makes a lot more sense to create memory-only
NUMA nodes based on a device specific region than it does a PCI BAR.

> > I'm not privy to a v1, the earliest I see is this (v3):
> > 
> > https://lore.kernel.org/all/20230405180134.16932-1-ankita@nvidia.com/
> > 
> > That outlines that we have a proprietary interconnect exposing cache
> > coherent memory which requires use of special mapping attributes vs a
> > standard PCI BAR and participates in ECC.  All of which seems like it
> > would be easier to setup in QEMU if the vfio-pci representation of the
> > device didn't masquerade this regions as a standard BAR.  In fact it
> > also reminds me of NVlink2 coherent RAM on POWER machines that was
> > similarly handled as device specific regions.    
> 
> It wasn't so good on POWER and if some of that stuff has been done
> more generally we would have been further ahead here..

Specifics?  Nothing here explained why masquerading the coherent memory
as a BAR in the vfio-pci ABI is anything more than a hack that QEMU
could assemble on its own with a device specific region.  Thanks,

Alex

