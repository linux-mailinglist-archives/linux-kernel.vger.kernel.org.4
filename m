Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCD70CD06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjEVVzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjEVVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F11F1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684792496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0L203m2GVaQLYviFxGrtioouT9iWCn/rX/S2k2svONk=;
        b=ZoJMNsJIcKuG5XxWjXNrlQ6Tmkayra9gnyjL0TooI6cSjrOcE9KSKXLA6KPKMH3j4Y7fFP
        Ah1/wcMlCxgBpyQGbFfkXk5tic7LE3aFz9XRlBIOkWhcpdwoPyfOKZLImV/2oyjKQwygYj
        1/vVJsOMnFFHK4garWUMPGUHyYQ+tuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-hA8kGFblPZun3KTy5fnRqw-1; Mon, 22 May 2023 17:54:54 -0400
X-MC-Unique: hA8kGFblPZun3KTy5fnRqw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30a8f6d7bbdso593030f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792493; x=1687384493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L203m2GVaQLYviFxGrtioouT9iWCn/rX/S2k2svONk=;
        b=UvgILoiZ2ZnVm9ZK3wkfD8d/Q99lot2IP1l2rR9qAxprg9kYhcGzhBKllkAwH4Uz8t
         lEMk/JngfsI2VEiGSeCIt3mvbxaCb9+O5vPWq6zIf69Mxlow/avx+qyhIX6Xi/2obs4l
         +45Xfv1Yb3etH16XyWpLmG1LAO2YNOV0aMYIKMFXvkFw8uGELE7cHmn/ocPLgN4D02on
         ynqIAc5X9qE9BxxxVc2NlElngFRsAvl3dwf86TT3YqgovScwvBW+XVEt4/u2JDV6WDtb
         I3a8+4Eyb8Dz5F/fbLwWjqp/ig973hQvgRJAUGFEyuToqZYw0KJXMFzEZk9xhGVtTZuo
         uoSg==
X-Gm-Message-State: AC+VfDwPZW2LKLB2Jg23/iiEVfcc792BZTjgP8jiNNpT00iJakmsB8YM
        jjwayyLdJwRUg2Fvg6X1aV4XRC+G8Y4J1WxzYMifDLjl4SPadAHAEuxwqz6dHun3I6RsRbmDB62
        jZYOi06v7imrwQx2FlYJ8piH1
X-Received: by 2002:adf:f1ce:0:b0:306:64b7:5413 with SMTP id z14-20020adff1ce000000b0030664b75413mr8021974wro.71.1684792493777;
        Mon, 22 May 2023 14:54:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FeA2pzJifNU77nJUGk9z4tuDbA0b89J6fc4WAGGvOFeetu5pLeSWt/hkyHu1VXNCroi2+DA==
X-Received: by 2002:adf:f1ce:0:b0:306:64b7:5413 with SMTP id z14-20020adff1ce000000b0030664b75413mr8021967wro.71.1684792493488;
        Mon, 22 May 2023 14:54:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.68])
        by smtp.gmail.com with ESMTPSA id z11-20020adff1cb000000b0030789698eebsm8895175wro.89.2023.05.22.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:54:52 -0700 (PDT)
Date:   Mon, 22 May 2023 17:54:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230522175415-mutt-send-email-mst@kernel.org>
References: <20230424191557.2464760-1-imammedo@redhat.com>
 <ZGvj7aqaY3InNqun@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGvj7aqaY3InNqun@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:51:41PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> > When using ACPI PCI hotplug, hotplugging a device with
> > large BARs may fail if bridge windows programmed by
> > firmware are not large enough.
> > 
> > Reproducer:
> >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> >       disk_image
> > 
> >  wait till linux guest boots, then hotplug device
> >    (qemu) device_add qxl,bus=rp1
> > 
> >  hotplug on guest side fails with:
> >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> >    Unable to create vram_mapping
> >    qxl: probe of 0000:01:00.0 failed with error -12
> > 
> > However when using native PCIe hotplug
> >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> > it works fine, since kernel attempts to reassign unused resources.
> > Use the same machinery as native PCIe hotplug to (re)assign resources.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> 
> Tentatively applied to pci/hotplug for v6.5.
> 
> Tentative only because I'm hoping for your ack or review, Rafael (I
> see you acked v1, but this one is a little different).
> 
> And I think you'd like a stable tag, Michael?  I'm happy to add one,
> but wasn't sure if you wanted a separate ack for that.


I'd like a stable tag, yes. Just was not sure whom best to ask.



> > ---
> > tested in QEMU with Q35 machine on PCIE root port and also
> > with nested conventional bridge attached to root port.
> > 
> > v2:
> >   * fixup subject to match expected style
> >   * drop no longer needed __pci_bus_size_bridges() to avoid
> >     memory leak (Bjorn Helgaas <helgaas@kernel.org>)
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 5b1f271c6034..328d1e416014 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -498,7 +498,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >  				acpiphp_native_scan_bridge(dev);
> >  		}
> >  	} else {
> > -		LIST_HEAD(add_list);
> >  		int max, pass;
> >  
> >  		acpiphp_rescan_slot(slot);
> > @@ -512,12 +511,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >  				if (pass && dev->subordinate) {
> >  					check_hotplug_bridge(slot, dev);
> >  					pcibios_resource_survey_bus(dev->subordinate);
> > -					__pci_bus_size_bridges(dev->subordinate,
> > -							       &add_list);
> >  				}
> >  			}
> >  		}
> > -		__pci_bus_assign_resources(bus, &add_list, NULL);
> > +		pci_assign_unassigned_bridge_resources(bus->self);
> >  	}
> >  
> >  	acpiphp_sanitize_bus(bus);
> > -- 
> > 2.39.1
> > 

