Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF1716C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjE3SRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjE3SRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E508B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685470607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LboiJrYnAi/py5cGBQDQMSaCfDnf6CASAq+urrSZpQ0=;
        b=JIp6OkyU4j51uq6HKLfj4Yg2Ubpkour7PHp8VvZHDnHe84IqZsgC2gHy9CPhIvP69+vFmt
        ZzQ/PW0yv1KDmSC9XuQr0vty1qP0vUqwnZn1Y5lk6P5tnoMPBCEehz87L6SlSask7dosBJ
        Mqo+IGazwGO5nk4Uk9lWvfiUJ73oFbA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-rdbkMR3-M0KnPW8xrj1w-A-1; Tue, 30 May 2023 14:16:45 -0400
X-MC-Unique: rdbkMR3-M0KnPW8xrj1w-A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2af2ffb4e5aso21521821fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685470604; x=1688062604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LboiJrYnAi/py5cGBQDQMSaCfDnf6CASAq+urrSZpQ0=;
        b=lPYRMPMuOcbv2l9G6m6Ayq+2tInfNJJ8TGAtBE6TCHjKNO+i7H4jXVhEJeJUe7PWfk
         Yufa7pGlLiDhJEjCvaHirgcdRrdru00b8W7GdOIAfMqmnT/MV9hLExN+3Kz0sns40Psp
         Td5yfNS+6nkRpg2nUG0+vOL3YiqvVI8z35500MG+akE6C+OuKRe6UGbQEX1MWuoWYc0Q
         mMqCNVs7JTKqOkilRvvQ4/3uUAmFAIVIMPChtG0e/FwMQ7PMsogoQCxnDlTFPQWYIxTv
         r6pzjzg7NOdr66fzDe60UhY1cA+xfJdmhDk8f9kb8jlrb2jETlh+u+GH04qnEC/Jd8u/
         e5nA==
X-Gm-Message-State: AC+VfDzSxDO30kRkeyKDTJMxmotDtLiw1e3fNHc1RM/i0BwQh5WHTeOM
        +lE9YQHGcIvxzQW2xOteeh0TOrq7yn/fCKDLKZwJTewUImuVUHpHfOaJQ0+Zxp4nE0iVuIvLaCv
        EMoAYjROD88ZkOLY742hiu6li
X-Received: by 2002:a2e:c52:0:b0:2a2:47a8:728b with SMTP id o18-20020a2e0c52000000b002a247a8728bmr1425276ljd.13.1685470603872;
        Tue, 30 May 2023 11:16:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6L+/RfkbhNFet6mCP3WipllloDSKB6gbN/OJcXr/yJVtnkSj+T0yms3k/Tma6Qn+mxAQxBOg==
X-Received: by 2002:a2e:c52:0:b0:2a2:47a8:728b with SMTP id o18-20020a2e0c52000000b002a247a8728bmr1425268ljd.13.1685470603541;
        Tue, 30 May 2023 11:16:43 -0700 (PDT)
Received: from redhat.com ([176.12.143.106])
        by smtp.gmail.com with ESMTPSA id c10-20020a2e9d8a000000b002af03f75edasm2932561ljj.80.2023.05.30.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:16:43 -0700 (PDT)
Date:   Tue, 30 May 2023 14:16:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if
 necessary
Message-ID: <20230530141321-mutt-send-email-mst@kernel.org>
References: <20230424191557.2464760-1-imammedo@redhat.com>
 <ZHYujEM3o6iWIB1B@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHYujEM3o6iWIB1B@bhelgaas>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:12:44PM -0500, Bjorn Helgaas wrote:
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
> 
> Ugh, I just noticed that we turned on PCI_COMMAND_MEMORY even though
> BARs 0 and 1 haven't been assigned.  How did that happen?  It looks
> like pci_enable_resources() checks for that, but there must be a hole
> somewhere.

Maybe because BAR2 was assigned? I think pci_enable_resources just
does
                if (r->flags & IORESOURCE_MEM)
                        cmd |= PCI_COMMAND_MEMORY;
in a loop so if any memory BARs are assigned then PCI_COMMAND_MEMORY
is set.

> >    Unable to create vram_mapping
> >    qxl: probe of 0000:01:00.0 failed with error -12

