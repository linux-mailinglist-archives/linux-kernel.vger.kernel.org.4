Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC4643EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLFIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiLFIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:40:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AFFE87
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:40:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l11so19296837edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb4e4KLqX/W0EQ+pghx+Rj8+iOq0razwJhvVhFNSz+E=;
        b=ZqY6wWHvq0n02BHxpXLvp1TMRphD5VQQX7jlb3yrYeZEmfvbJCxjIn3Vfk0p4FL43K
         gNB8RN0wcVQXkhTekCC3hLu3mBvDavTNfgOOHjmJ+wqhJaV+gH8puR4mAg22WV+/m8Jk
         qhvfeU32KV9yUccCBt6pHIWW19QrKKhfSTtdaOgeGseeL9ie+PEpbeWtPYNGCaEE2TdQ
         V4hfO1OS95VpkNODFaLhNwWYv8pUBnBnjzO3pBc11je3VrlU908/HQYPqpYvEjCVcZ/0
         FsWOOb4mEa4KNN/YkvJ6wyinkxmiV6rM4laDfdutgeytwhu3CsMqcMYWEXriJiXstGH2
         z4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wb4e4KLqX/W0EQ+pghx+Rj8+iOq0razwJhvVhFNSz+E=;
        b=CeMSyCpGFcxzULL16+aduK/hIFp96MomWxpMosfaKPYBpgvKzXGX/oML02rPYIa5VC
         uyU7ZaKORPpFBk07mB4bGaC+UWMnOyJrl4W5wHh9DyFssD8rBCKwk9dIXG5/mKP/WT4L
         qFJLuRtGMiXZOTVzDeUj6qjvkPbHI5jmxSwAoSCdPyUa9vZ5njU1ZFiYsVG+ki/rmRjx
         ytPiwt9nx07P1NAFhxTxqlSjEyP2rSeWeOwJwPn4VNu1f4lyVzS3gKMFhqNHEvf4btB0
         xbpjWvbG+3uBlH1RjbCkmeMJTHNJlaaImGRpy05oVNoC1EkIQR10VnK/KsiwQLQ4gYC/
         BGvA==
X-Gm-Message-State: ANoB5pm0KJpvxO4qeubbuahQ9kIXKgJkAo6+aNN3RXS8W30kx5JKylXE
        HsVjEYCA1joaRnA8IaaOypV0SQ0NfX03uvtK9Q4T
X-Google-Smtp-Source: AA0mqf5Nb0jkYRIRIckdLjV5rgneBA+/lxQi57WmseMEMqgl2PnOsz1TUSekNIpFuM8m8I5SiDsNV40CqkCmq1BNvN4=
X-Received: by 2002:aa7:c98e:0:b0:46c:2cf2:e89f with SMTP id
 c14-20020aa7c98e000000b0046c2cf2e89fmr15699323edt.267.1670316048670; Tue, 06
 Dec 2022 00:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-2-xieyongji@bytedance.com>
 <20221206081847.GA8771@lst.de>
In-Reply-To: <20221206081847.GA8771@lst.de>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 6 Dec 2022 16:40:37 +0800
Message-ID: <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 4:18 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> > Export irq_create_affinity_masks() so that some modules
> > can make use of it to implement interrupt affinity
> > spreading mechanism.
>
> I don't think driver should be building low-level affinity masks.

With the vDPA framework, some drivers (vduse, vdpa-sim) can create
software-defined virtio devices and attach them to the virtio bus.
This kind of virtio device is not a pci device or a platform device.
So it would be needed to export this function if we want to implement
the automatic affinity management for the virtio device driver which
is binded to this device.

Thanks,
Yongji
