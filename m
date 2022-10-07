Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5E5F7890
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJGNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJGNDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9FAE0B0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665147790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Wu7zkDvh9Y7YMMhVMehTcCNW6maACM0iCCQHnBi68g=;
        b=DNzGyfMWO3CzRZzCZgEN8LIn5Am6xBJ46HDqrOKM0gI12ZC0I1E56qN/OC0uOXTuuZti7H
        FtX69h1eywmNBJNeljuVJoqWbzJkVjpIn6S8dYsDINUvFbx7BBx/9fNkbZxUijK9btVtmd
        mlGEkrdLFAL3JwmetusFzpEzg5e91Dg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-occgoVqSOrmKqk6gegyJNg-1; Fri, 07 Oct 2022 09:03:09 -0400
X-MC-Unique: occgoVqSOrmKqk6gegyJNg-1
Received: by mail-wm1-f72.google.com with SMTP id b7-20020a05600c4e0700b003bde2d860d1so2653003wmq.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wu7zkDvh9Y7YMMhVMehTcCNW6maACM0iCCQHnBi68g=;
        b=eeGK/4XT2z9Iodv9wqdtme8l4/dIHNjLMsw5MKNpIyetEl7NrDkDqEK8u3zlMowHeq
         kt1+gIjZ3YaC1beCJKapyvoyTI9bQpYXb4jYzNYctmHhjkGwz1/17enbjI+wEp32ZqMN
         p1F2TLb1A5W4sOxD6iS0r1WDv8/1WmiJNYf+zoc1b/PiF3IxtFT64sVY8bcUuuz7UOn5
         m2y/vVHWbOLF53ct+VLKPvu3RtHsVrSEF27PBkEX5CjNEloE4mIemKmnsnSRtxnPmlic
         O74E2OQLH+TxaYEwruAlNDeASQ+GTk0fQOR2uBURyZlHr73WLYUJT0tLICIwdPS+/0V+
         p48g==
X-Gm-Message-State: ACrzQf1Jhp38RHisrTX86+oBKigq3SmrtXFRo0yBuCvVzZS4/8BOewk4
        roL9PNsQ/gi9dEUu8pPlSiG7RU3SKhHaU4grxOQdbFH1ytWAjev6eLmwkIZGaNxejs2YTOKSxxF
        AeFnBiUPnP/thGHK/2NtkC/9l
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr3084362wrb.201.1665147788492;
        Fri, 07 Oct 2022 06:03:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6VJmA4yooQeEP6AWSZxrXCNMZ+Dd6ecWo+EA97vi7kYl5IewCjyra5zBCUEt/PMfgtrGiKeg==
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr3084320wrb.201.1665147788101;
        Fri, 07 Oct 2022 06:03:08 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bcd0a000000b003a5c999cd1asm2822460wmj.14.2022.10.07.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:03:07 -0700 (PDT)
Date:   Fri, 7 Oct 2022 09:03:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, mgo@opensynergy.com
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20221007090223-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> On 8/8/22 01:00, Michael S. Tsirkin wrote:
> 
>     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> 
>         According to specification [1], "For the device-specific configuration
>         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
>         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
>         and aligned accesses for 32 and 64 bit wide fields.".
> 
>         Current version of the configuration structure:
> 
>             struct virtio_bt_config {
>                 __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>             } __attribute__((packed));
> 
>         has both 16bit fields non-aligned.
> 
>         This commit fixes it.
> 
>         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> 
>         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> 
>     This is all true enough, but the problem is
>     1. changing uapi like this can't be done, will break userspace
>     2. the driver has more issues and no one seems to want to
>        maintain it.
>     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
>     to merge it for this release.
> 
> This is very sad. We already use this driver in our projects.

Ping. If we still have no maintainer I'm marking it broken, users
should at least be warned.


> Our virtio bluetooth device has two backends - HCI_USER socket backend for one
> platform and uart backend for the other, and works well (after applying your
> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
> removal" problem can probably be considered solved .
> We could help with the rest of the problems you listed that can be solved
> (specification, QEMU support).
> And the only problem that is difficult to solve (because of the need to change
> UAPI header files) is just this one with unaligned configuration fields.
> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
> (Indicates vendor command support) feature negotiated, the driver does not
> read the non-aligned configuration fields.
> 
> So, what would you advise us to do? Continuing to use the "marked broken"
> driver, start writing a specification for a new from scratch, better one?
> Or is there any way to bring this one back to life?
> 
> 
> 
>         ---
>          include/uapi/linux/virtio_bt.h | 2 +-
>          1 file changed, 1 insertion(+), 1 deletion(-)
> 
>         diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
>         index a7bd48daa9a9..adc03709cc4f 100644
>         --- a/include/uapi/linux/virtio_bt.h
>         +++ b/include/uapi/linux/virtio_bt.h
>         @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>          };
> 
>          struct virtio_bt_config {
>         -       __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>         +       __u8  type;
>          } __attribute__((packed));
> 
>          #endif /* _UAPI_LINUX_VIRTIO_BT_H */
>         --
>         2.34.1
> 
> --
> 
> Best regards,
> 
> Igor Skalkin
> Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> igor.skalkin@opensynergy.com
> www.opensynergy.com
> 
> registered: Amtsgericht Charlottenburg, HRB 108616B
> General Management: Rolf Morich, Stefaan Sonck Thiebaut
> 
> 
> Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hinweise zum
> Datenschutz gem. Art. 13 DSGVO finden Sie hier.

