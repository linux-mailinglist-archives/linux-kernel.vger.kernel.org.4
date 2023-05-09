Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85566FC6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjEIMpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CC46B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683636295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0atVn8hE4TWtYprE3l2D/bldVae4vEGU9rmhpIuRuRM=;
        b=PmyruTNEzw7HovU/HV9iveBkbWlNB8EnkFevYa5hcY2BwRdGUr2EdBaTflGXIO7+46kg1U
        OwDHg90yWqyu1e4Bks3i/Gk8F1m0JpcZE8F1zj0LD3gdgt80rYtO34U9ocKapWYCG/oLn3
        0Iw/7Gz9D+TEuHdCpI5kAk8YB3JOZCY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308--eZuews5NmOVm5kbun0V2g-1; Tue, 09 May 2023 08:44:54 -0400
X-MC-Unique: -eZuews5NmOVm5kbun0V2g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506b0b75731so5503617a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 05:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636292; x=1686228292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0atVn8hE4TWtYprE3l2D/bldVae4vEGU9rmhpIuRuRM=;
        b=Cb64EGw8zAis6Gdww0OR/7VQv5QTu/Pihy0wzYb9UYO0z36IQVgdIfWyjKNkJVAvMt
         mzloW2H7+Rw8pDfzKvcLzCIEXf3aWyGSJ41P6cvAWsVfsT6SIzBpSd0CuLxiW4GjUHJD
         FWypsKVc6BjNeKJKRrF7YqiN0sUUTH1EFCLaTv8lPNUkAEz4XEU7apretNMem7VZqTcu
         NNxpXY2kzWPAvBRtdcV2swAwN1QiDcWQ6AYmpDY7Mfkb5uL4I3zVpZaY0C0bIEe0v8nw
         bAj+yZe97/uvbSGbnccsper3f5yzS0Hp0KF+4AIslV7zdr62lq2vjRw8pQWlStd30wKM
         A0WA==
X-Gm-Message-State: AC+VfDxyz0lg7J6aXg1/FYHJRupUrFXL3QRUrG5ssKfqKQUI7zhv7eFQ
        kssb6BQjaRH6GFl3XxDOdZdYWsblQDkqfdOdzrFe5W5UjU8pe5gIl0lTGcYqpr7ydMvi5TCjNbI
        63vrrp/xlmf1WiJo/nEYek1/06kCS9L5cH5IPkpD69et5DoTcxaMv9aO4dYo0rz0KwqDN8YpEcv
        wI00VCyzoU
X-Received: by 2002:aa7:c74b:0:b0:506:b228:7b08 with SMTP id c11-20020aa7c74b000000b00506b2287b08mr11570184eds.17.1683636292222;
        Tue, 09 May 2023 05:44:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7CLeiKvojA8ol97ghYKS30L3xlPs1xNBy2YAqxITFwcuJFzajIjrQY8KNJX/UTo8/nCkIk6w==
X-Received: by 2002:aa7:c74b:0:b0:506:b228:7b08 with SMTP id c11-20020aa7c74b000000b00506b2287b08mr11570148eds.17.1683636291806;
        Tue, 09 May 2023 05:44:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y15-20020a50e60f000000b0050bc27a4967sm746733edm.21.2023.05.09.05.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 05:44:51 -0700 (PDT)
Date:   Tue, 9 May 2023 14:44:50 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
        lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230509144450.2bc3aea8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230424191557.2464760-1-imammedo@redhat.com>
References: <20230424191557.2464760-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 21:15:57 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

Bjorn,

I've fixed up issues you've mentioned on v1 review,
is it good enough to take it in now?

> When using ACPI PCI hotplug, hotplugging a device with
> large BARs may fail if bridge windows programmed by
> firmware are not large enough.
> 
> Reproducer:
>   $ qemu-kvm -monitor stdio -M q35  -m 4G \
>       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
>       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
>       disk_image
> 
>  wait till linux guest boots, then hotplug device
>    (qemu) device_add qxl,bus=rp1
> 
>  hotplug on guest side fails with:
>    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
>    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
>    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
>    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
>    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
>    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
>    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
>    qxl 0000:01:00.0: enabling device (0000 -> 0003)
>    Unable to create vram_mapping
>    qxl: probe of 0000:01:00.0 failed with error -12
> 
> However when using native PCIe hotplug
>   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> it works fine, since kernel attempts to reassign unused resources.
> Use the same machinery as native PCIe hotplug to (re)assign resources.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> tested in QEMU with Q35 machine on PCIE root port and also
> with nested conventional bridge attached to root port.
> 
> v2:
>   * fixup subject to match expected style
>   * drop no longer needed __pci_bus_size_bridges() to avoid
>     memory leak (Bjorn Helgaas <helgaas@kernel.org>)
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5b1f271c6034..328d1e416014 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -498,7 +498,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				acpiphp_native_scan_bridge(dev);
>  		}
>  	} else {
> -		LIST_HEAD(add_list);
>  		int max, pass;
>  
>  		acpiphp_rescan_slot(slot);
> @@ -512,12 +511,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> -					__pci_bus_size_bridges(dev->subordinate,
> -							       &add_list);
>  				}
>  			}
>  		}
> -		__pci_bus_assign_resources(bus, &add_list, NULL);
> +		pci_assign_unassigned_bridge_resources(bus->self);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);

