Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3296217F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiKHPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKHPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:20:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5D65E69
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667920756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eYyte+kPGDx2cu07guaw9hX+mwjlEDk8BWb8kT+tCg=;
        b=IVQBzHlKakt/EMN77WjaTfGCbEKNrGbnq1MVJ2KInbc0k7FtdIvWKdRpJCTF4TLr/AIjXw
        oBPKJpMSYUkS4gfOlCk7PlCEbjknBOOQA7s2pA54gVwIPwk66MHNSXXzs+0s9LzRoeZ7G6
        IcXFzoMHhGfWGkJRy12bcYgVojb3sXI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-kZGSup3zMb-2GNeC195j0Q-1; Tue, 08 Nov 2022 10:19:15 -0500
X-MC-Unique: kZGSup3zMb-2GNeC195j0Q-1
Received: by mail-qv1-f69.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso9819034qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eYyte+kPGDx2cu07guaw9hX+mwjlEDk8BWb8kT+tCg=;
        b=ODlw5DLK44Hos9U+jwf7GtsI+LFSPkIeR1lyWuHz7MwVvf1EHi64HW0JIHBqWi3ut2
         z1FrIoM0F9RQu172k9+21WehIdVlzmd+YrhpUwgpCVjLp9luHFUspNh8sRODdWjAuIeR
         nVVydkxgr+gyHPJ4IKqUbgwy3tWfYSRS1q4JDM44sT5+5PQdwlB+P/iRXGTPrKKElWPI
         LiyKIadGKSd0I+Xcc21+tLqY2+3CZ5xSs083plV+b65qvxe7vCr/EnotRH0bfgdfAbVg
         1pw91JPdchxwicwEJ4HY3BCeeJUUP+CTt/uhnv6rpIMxgTbokFFGGANQEA8DGDmS5nvx
         hXLg==
X-Gm-Message-State: ACrzQf2xt1MrB3prYfFYWQ28FXnV5+NfcWjetH2+3PCVh0rs87QlS7DH
        8UO2c4x/nLzUkOhcSiThSXw4srEVg48SEl69AflmNcmBrS2x/7j2M2vr2Ea0X0tgFzxs2VLq+pu
        ijDmN47G3ZUK4YoS4vP0km+JH
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr40188573qkp.609.1667920754343;
        Tue, 08 Nov 2022 07:19:14 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5HRTL6BBYgWiKj4VNxx4x4EqfKrk8oTpbGAJ6VaO+NxtIKFXLFk2mXSHSFArlvJCkmKaOZYQ==
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr40188549qkp.609.1667920754068;
        Tue, 08 Nov 2022 07:19:14 -0800 (PST)
Received: from redhat.com ([138.199.52.3])
        by smtp.gmail.com with ESMTPSA id m13-20020ac8688d000000b0039467aadeb8sm8264644qtq.13.2022.11.08.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:19:13 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:19:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221108101209-mutt-send-email-mst@kernel.org>
References: <20221108145300.GA472813@bhelgaas>
 <20221108150228.GA473246@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108150228.GA473246@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > virtio uses the same driver for VFs and PFs.  Accordingly,
> > > pci_device_is_present is used to detect device presence. This function
> > > isn't currently working properly for VFs since it attempts reading
> > > device and vendor ID.
> > 
> > > As VFs are present if and only if PF is present,
> > > just return the value for that device.
> > 
> > VFs are only present when the PF is present *and* the PF has VF Enable
> > set.  Do you care about the possibility that VF Enable has been
> > cleared?
> 
> Can you also include a hint about how the problem manifests, and a URL
> to the report if available?

Here you go:
lore.kernel.org/all/20221108044819.GA861843%40zander/t.mbox.gz

is it enough to include this link or do you want me
to repost copying the text from there?

> It's beyond the scope of this patch, but I've never liked the
> semantics of pci_device_is_present() because it's racy by design.  All
> it tells us is that some time in the *past*, the device was present.
> It's telling that almost all calls test for !pci_device_is_present(),
> which does make a little more sense.

I agree. The problem is in the API really.
What people want is pci_device_was_removed()

With surprise removal at least at the pci express level
we know that there was a surprise removal event.
PCI subsystem seems to chose to discard that information.
There's nothing driver could do to reliably detect
that - if someone pulled the card out then stuck it back in
quickly driver will assume it's the old card and
attempt graceful removal, which is likely to fail.

However some of the problem is at the hardware level too.
If you are poking at the device's config and it's
pulled out and another is put back in quickly, your
config access might land at the new card.
Does not feel robust. I don't have a good solution for this
except "try to avoid config cycles as much as you can".




> > > Reported-by: Wei Gong <gongwei833x@gmail.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > 
> > > Wei Gong, thanks for your testing of the RFC!
> > > As I made a small change, would appreciate re-testing.
> > > 
> > > Thanks!
> > > 
> > > changes from RFC:
> > > 	use pci_physfn() wrapper to make the code build without PCI_IOV
> > > 
> > > 
> > >  drivers/pci/pci.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 2127aba3550b..899b3f52e84e 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6445,8 +6445,13 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
> > >  
> > >  bool pci_device_is_present(struct pci_dev *pdev)
> > >  {
> > > +	struct pci_dev *physfn = pci_physfn(pdev);
> > >  	u32 v;
> > >  
> > > +	/* Not a PF? Switch to the PF. */
> > > +	if (physfn != pdev)
> > > +		return pci_device_is_present(physfn);
> > > +
> > >  	if (pci_dev_is_disconnected(pdev))
> > >  		return false;
> > >  	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> > > -- 
> > > MST
> > > 

