Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FA60C275
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJYEFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJYEFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BC1108
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666670706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGQAN5QfmAdIFxH4zxQ7DPOdP0CTozat81OxKPl1IMM=;
        b=SMyS4fuuL4lEN0CPibSS8It5eRCEWO9w4FmiG+eBFbg3hExfWNZUz0wA+eD2WgyxdDs2g+
        sdP6CP+WoDsLI4NIU1BKQ1yHNoxzh2u/bbhDcrfgglTDNdvNNt+4yaeP1A3UC+Dld432Xm
        gEpBSnwmSsWbXygG7OAyBNUlT1yWvuU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-iCJ_zHsqNRKBQflQJRGvTw-1; Tue, 25 Oct 2022 00:05:04 -0400
X-MC-Unique: iCJ_zHsqNRKBQflQJRGvTw-1
Received: by mail-wr1-f69.google.com with SMTP id s11-20020adfbc0b000000b0023659af24a8so3345277wrg.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGQAN5QfmAdIFxH4zxQ7DPOdP0CTozat81OxKPl1IMM=;
        b=FmulY+esKbQO/VFAXwg/wNKXwxuangomVdSFUsho+I2w6721/3gKhjjpiReOYn729S
         zR0X5P+xB9oAQdZ2UPdlnNcUyJZSr3BM3rmKRYkbS5lv9XJS8//YAytjTwjexSiVP/AR
         D66n5VkaVFFgwPjZGFNm7ACwm7CLF59ECUVie90bzF99Enqssv/eHPeeqdwywaUgJd3q
         G/kuplOzHIz6YoRkI2wraM/Hel187qxYa/AiRxlmawszjrjEdgG2qVtyTktGG9J6bL/K
         LfidZVq5U9k+jHrpLN7e/X/S2REQCaHvtvM3YqEGuAKGT7ixd+6MC54CubarEZOuZszA
         QUBA==
X-Gm-Message-State: ACrzQf1PAe0D+JGxWSsPIMxRsQPJ2ORGlKjLU0oghlXJ39ZQZ3pRiGG8
        xM9X8NL3tRQkvlwTZI7sdW8B72fc1KvLmYf5v99MWkkUe+/vxKf2ZHmtEj8dNjpi+sYYPfSyrLz
        htBffOZ6+PEjhlUTlVBNDe3sr
X-Received: by 2002:a05:600c:1822:b0:3c7:103:f9be with SMTP id n34-20020a05600c182200b003c70103f9bemr22816970wmp.195.1666670702988;
        Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6GrspV0Rv4ooc27M/ZkGRCgHDhw7hvK7fug9mQV9MrYrQcfzp+yqeg/SM+IxYTvSy/l/z7tw==
X-Received: by 2002:a05:600c:1822:b0:3c7:103:f9be with SMTP id n34-20020a05600c182200b003c70103f9bemr22816959wmp.195.1666670702802;
        Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
Received: from redhat.com ([2.52.24.36])
        by smtp.gmail.com with ESMTPSA id r7-20020a1c2b07000000b003c6f3e5ba42sm9660282wmr.46.2022.10.24.21.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
Date:   Tue, 25 Oct 2022 00:04:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] virtio_bt: Fix alignment in configuration struct
Message-ID: <20221025000433-mutt-send-email-mst@kernel.org>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:40:32PM +0200, Igor Skalkin wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure has non-aligned 16bit
> fields.
> 
> This patch adds a second, aligned  version of the configuration structure
> and a new feature bit indicating that this version is being used.


subject should be v4 but besides that, ok.
Will a spec patch be forthcoming?

> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
> 
> Changes in v4:
>   v3 was corrupted by our smtp server.
> Changes in v3:
>   v2 had been sent from the wrong address, fixed.
> Changes in v2:
>   The first version of this patch just changed the configuration
>   structure in uapi/linux/virtio_bt.h
>   This can not be done, because it will break the userspace, so the
>   second version offers a less radical approach - it introduces a new
>   feature bit and a new configuration structure that both the device
>   and the driver will use if this bit is negotiated.
> 
> Igor Skalkin (1):
>   virtio_bt: Fix alignment in configuration struct
> 
>  drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
>  include/uapi/linux/virtio_bt.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.37.2

