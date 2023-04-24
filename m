Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED36ED558
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjDXT1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDXT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3069A35BD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682364376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8vaXfo2pCpLv+DTVhpUq3XFiaKJAAmExHREG2O0kvI=;
        b=NQ5VcE0Mr7h2y9uSc6g3tkYg6J5ZmMU84+beb9s9mp2cWMr7UwLpfmbDDJa4BA3fZLqRD2
        0lpDw5vbiyhbZzdyPaMMU3tq/m7OdtQOmTCGhYQ1Sh/hQo0ZyhI7Webu/ijCdqsQmO1RO5
        cEmU99YpqbPpcnHXTxpsBJpA28sED/A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-bJJCJVWPPJGXxPzNiO7cqQ-1; Mon, 24 Apr 2023 15:26:14 -0400
X-MC-Unique: bJJCJVWPPJGXxPzNiO7cqQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f43679bcf5so2684340f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682364373; x=1684956373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8vaXfo2pCpLv+DTVhpUq3XFiaKJAAmExHREG2O0kvI=;
        b=aXlqVeehB7vmLIzilkpbCy/QvnjR5zI8axYwP2cmAkiGAt2jVbLrdom7iEmsXsLJ/g
         d6c1337T4ARwsX9Dq+Ufic/rpp+DAsPSEIiIISOYtSOKfjjZ8IDDjQ5CuEPWwCh61wiT
         7Ns2fMDhYb22V/E6kZOQWglawjomdhn9mzptO/2d5Y/benp0ky6wSezj2Z8sGmoLRljr
         YBtJCISisPfkw5mgUw/ivl6VKbMWWQySaOru1LdXew/hcaWWHmj2F2nQE/Ed9U7EqFBG
         bbae+8kBbWfL+yJYmTGeRtD1IiOUkWDQL3JF/UVh9AIvEISrMvyf/DcI5c2KjhloK/Mf
         Mliw==
X-Gm-Message-State: AAQBX9db0tb+esCzTPVC0wF0g9Tyy9E2e/b/1Xy+XlIGnm78rOW4Slcq
        6zdxdUojGocF4eVWgQGjGqQPWAdOPefdri7y6pgsyh4Vdneq6xxsZaGedJklKWwCcibeYdrBDse
        ivzY8rRjRiy+wGktcUgzUcoQ2
X-Received: by 2002:a05:6000:1c9:b0:2fe:2f01:fc7e with SMTP id t9-20020a05600001c900b002fe2f01fc7emr9699717wrx.13.1682364373724;
        Mon, 24 Apr 2023 12:26:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yc4jkGt1VElJMxWkw+LfaHeIyyFF0IAv65mKcyFgnys6lhSCeCedLNmNGa2wbTebeyocsT0A==
X-Received: by 2002:a05:6000:1c9:b0:2fe:2f01:fc7e with SMTP id t9-20020a05600001c900b002fe2f01fc7emr9699710wrx.13.1682364373431;
        Mon, 24 Apr 2023 12:26:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003f179fc6d8esm12815917wml.44.2023.04.24.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:26:12 -0700 (PDT)
Date:   Mon, 24 Apr 2023 21:26:11 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, imammedo@redhat.com
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230424212611.6ec28e12@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230418070640-mutt-send-email-mst@kernel.org>
References: <20230418085030.2154918-1-imammedo@redhat.com>
        <20230418070640-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 07:08:09 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 18, 2023 at 10:50:30AM +0200, Igor Mammedov wrote:
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
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> And I think:
> 
> Fixes: d66ecb7220a7 ("PCI / ACPI: Use boot-time resource allocation rules during hotplug")

Probably not, this commit basically added pcibios_resource_survey_bus() and
nothing else important. Looking through history it was always broken this way.

> 
> > ---
> > tested in QEMU with Q35 machine on PCIE root port and also
> > with nested conventional bridge attached to root port.
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 5b1f271c6034..9aebde28a92f 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
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
> 

