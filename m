Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020865FA3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJJS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJJS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2165C9C2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665428263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=H4dEUyv/GvCvxwPuE1Ie3nHYJS0AqpfIYFkaqAHSeuo=;
        b=fJ0ayOjzOKDkYQBO4Tyr6kBo0V+kqVFS06kvJidvncSzGmCbKPulXxXBUEkQFotJhTglxb
        kzq1dGShVblJwf+wCeKgSREryB+6ESpUr43ry4fqpJiyTpvDtQ7xtiDS5BmDjHUkxFpldD
        qHpQ6A51nslOEjj9DLBDS8t584tOn7A=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-MY5qqIKMPgq09hgnSUIhyw-1; Mon, 10 Oct 2022 14:57:42 -0400
X-MC-Unique: MY5qqIKMPgq09hgnSUIhyw-1
Received: by mail-oi1-f198.google.com with SMTP id o12-20020a056808124c00b00353f308fb4bso6717844oiv.22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4dEUyv/GvCvxwPuE1Ie3nHYJS0AqpfIYFkaqAHSeuo=;
        b=HX3/SL9T01MJFJtFxcEE251n+i62EMurEMp+ZniKU0GEq7HLEysJRn1O4shAdY40kz
         4gLuSh8w4aHD1ghENW/Rs4kbdB2va9/vCqFvL0TpciHGncX9r04ii8U4Gt3J1sKIg21U
         nKxLVPvvySCSWcOXrE9lrfacDJ7N15fDv/PcJ56NtLGiakJTrxoJOMlvLjFIzof51g2D
         PtHDj38mgnyhPeip/CsM2CXjWmGsvm1Xh46Zb/DQci5ctAAG61eWRNDwmYdr2D4E0jsa
         qr8efSRqTdF/F75TLhtmM0nZX+yZFeMSWuzAErTuCjiuUe9X0J/iF41h3HxzfZRaA2ga
         xcbA==
X-Gm-Message-State: ACrzQf23MTdZdhcYn3uFK0B45ne60XBKybb8KBRGQ9vYRTZ2wnAVdP7O
        maO1CKQP3LFvgSlJfABqeJ1nI6MII59o4L+9OejwB8i5S/y6Y+Y1r3E+nSjrFLrSKOgLxHXzmwL
        m6VS6YP4sSEo+8czZdinCtpO8
X-Received: by 2002:a05:6870:a9a0:b0:12b:45b6:80e1 with SMTP id ep32-20020a056870a9a000b0012b45b680e1mr16577370oab.209.1665428261313;
        Mon, 10 Oct 2022 11:57:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7C9JHqJuNrM8W7+RXHF7LmED4/MlJ8xMRXffGkYhrIzx6UVWlsYjFqQf0d7gpMSh3AOcEVEQ==
X-Received: by 2002:a05:6870:a9a0:b0:12b:45b6:80e1 with SMTP id ep32-20020a056870a9a000b0012b45b680e1mr16577359oab.209.1665428261137;
        Mon, 10 Oct 2022 11:57:41 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s63-20020acac242000000b0035173c2fddasm4579112oif.51.2022.10.10.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:57:40 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:57:39 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Issue seen since commit f5ff79fddf0e ("dma-mapping: remove
 CONFIG_DMA_REMAP")
Message-ID: <20221010185739.vgw27m7fpmftly3q@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at an odd issue that shows up with commit
f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP").  What is being
seen is the bnx2fc driver calling dma_free_coherent(), and eventually
hits the BUG_ON() in vunmap().  bnx2fc_free_session_resc() does a
spin_lock_bh() around the dma_free_coherent() calls, and looking at
preempt.h that will trigger in_interrupt() to return positive, so that
makes sense. The really odd part is this only happens with the
shutdown of the kernel after a system install. Reboots after that do not
hit the BUG_ON() in vunmap().

I still need to grab a system and try to see what it is doing on the
subsequent shutdowns, because it seems to me that any time
bnx2fc_free_session_resc() is called it will end up there, unless the
allocs are not coming from vmalloc() in the later boots. Between the
comments in dma_free_attrs(), and preempt.h, dma_free_coherent()
shouldn't be called under a spin_lock_bh(), yes? I think the comments
in dma_free_attrs() might be out of date with commit f5ff79fddf0e
("dma-mapping: remove CONFIG_DMA_REMAP") in place since now it is more
general that you can land in vunmap(). Also, should that WARN_ON() in
dma_free_attrs() trigger as well for the BH disabled case?

It was also reproduced with a 6.0-rc5 kernel build[1].

Regards,
Jerry


[1] https://koji.fedoraproject.org/koji/buildinfo?buildID=2061881

