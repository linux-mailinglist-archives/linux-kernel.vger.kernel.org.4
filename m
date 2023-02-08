Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5868FA5B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjBHWoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjBHWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:44:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69110263
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675896194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DGnMsd6uzzMNKUzgtHw1et4SDPC0G9pBMtrAjEIfwU=;
        b=EpbtnpV9fft+GEOoIWaGhsRdxSvyyshHt7Y5u2mH7+DI0CFZms0OGSvxNepi5S5pfyaBvC
        Cqmv45pVBF2hRIT3fk9cgLPoAe1xho+q0iJTQpHyWVX79731BPTx3XLP9bO72P3mt9ilbH
        iIBSr7rQTqGx2o6JxLt/Enoe4Vc10lc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-508-3Pf5SySqPAqDxbB-NwCOxQ-1; Wed, 08 Feb 2023 17:43:13 -0500
X-MC-Unique: 3Pf5SySqPAqDxbB-NwCOxQ-1
Received: by mail-il1-f197.google.com with SMTP id n18-20020a056e02101200b0030f2b79c2ffso210699ilj.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 14:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DGnMsd6uzzMNKUzgtHw1et4SDPC0G9pBMtrAjEIfwU=;
        b=zNdbWMHw2qiuW0GApTryMPAjf2HE7cKvnlK1gWOnNmt5NaeB3OsOxCXbg6q6bqDy7m
         sD2dQFI7sosXQZrWgLOLqNNSrowisgTT8LPM4sy/oDI2y7obZtO7XojAvRTmiSArxT92
         SfqN9uPvrr+pS7Cf9W8J9DAr6DtRtAGbknQdPGU6XFicBO2B7lobp8Z8WBsom4zVP8NO
         Ma/UEO3IlPP4qYFHNQ61LwAjOnukEN4ayZAHSN0mGsPpNWIDfk/Gy7I8L++jOi6lR5X0
         zrFdlyA2Cc9Mek/c0ExnDDfNYx9i0Pfe/RaBVMVvN2BBrcqjpx8L9bYkORyVlViR+ZJ6
         lxXA==
X-Gm-Message-State: AO0yUKUoSQM1Fdfi9PBrJWig/ZKlt+bII/1cfW4OJUEZJWiAst46lQ4c
        uu6Lu1PcX/54YEYjtLXYa3+XRQL4QhkbjafniJ5jJauTmJsUebo3/K3qjY01V8BXX8Ha4n2aKkM
        NCpRDPbeCTDPE0fpk56suUK1i
X-Received: by 2002:a6b:e306:0:b0:717:6e2d:34f0 with SMTP id u6-20020a6be306000000b007176e2d34f0mr7300719ioc.11.1675896191834;
        Wed, 08 Feb 2023 14:43:11 -0800 (PST)
X-Google-Smtp-Source: AK7set+9d+V9ot2flKn6Eg5HaBZz5uBMAMoUDOPuVHHG8Sz+1kwRf1cbBK0Z6arIAG22OWYn2EoG0A==
X-Received: by 2002:a6b:e306:0:b0:717:6e2d:34f0 with SMTP id u6-20020a6be306000000b007176e2d34f0mr7300699ioc.11.1675896191593;
        Wed, 08 Feb 2023 14:43:11 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id p1-20020a0566380e8100b003bf35a3cc3bsm4240532jas.85.2023.02.08.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 14:43:10 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:43:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Seunggyun Lee <sglee97@dankook.ac.kr>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] pci/mmap: add pci device EBUSY check
Message-ID: <20230208154309.2bd82a15.alex.williamson@redhat.com>
In-Reply-To: <20230208221010.GA2489371@bhelgaas>
References: <20230207113949.17943-1-sglee97@dankook.ac.kr>
        <20230208221010.GA2489371@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 16:10:10 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc VFIO folks, Leon]
> 
> On Tue, Feb 07, 2023 at 08:39:49PM +0900, Seunggyun Lee wrote:
> > When using a pci device through the vfio-pci driver, other software was
> > also able to access the pci device memory through sysfs.
> > 
> > To prevent this, when mmap is performed through sysfs, a process of
> > checking whether the device is in use is added.
> > 
> > Signed-off-by: Seunggyun Lee <sglee97@dankook.ac.kr>
> > ---
> >  drivers/pci/mmap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> > index 4504039056d1..4c9df2e23e03 100644
> > --- a/drivers/pci/mmap.c
> > +++ b/drivers/pci/mmap.c
> > @@ -25,6 +25,8 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
> >  {
> >  	unsigned long size;
> >  	int ret;
> > +	if (pdev->driver)

Maintain the blank line after variable declarations.

> > +		return -1;

Surely there's a better errno value for this.

> >  
> >  	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
> >  	if (vma->vm_pgoff + vma_pages(vma) > size)

Regardless of the above, what's the point of this?  There are already
checks for LOCKDOWN_PCI_ACCESS in the sysfs and proc interfaces to this
function, so we can already activate restrictions to protect this
scenario via kernel config, kernel cmdline options, or runtime with
securityfs.  This is redundant and a blanket restriction as implemented
here seems liable to break some obscure use case.  Thanks,

Alex

