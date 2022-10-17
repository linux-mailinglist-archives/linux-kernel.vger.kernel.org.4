Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B86600699
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJQGKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJQGKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C844BD11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665987007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v20PsHQp4Qr88/YGRnhqDCcY6Y/q2BfOq83xhjsjfWE=;
        b=IyRydLO/K1lpGz4XBrmjNNpz6nogx0zzE8d1xoq4u/Ra1T++MnLcNx4Gfa1LVI5hnLcaqf
        SdTsWgvK8u9J7xQJ+4geKM8xYHcEpeSkGaz2gKAR8OyHT/NdDUW1BhcIum58ibLjwrxHmY
        Ihe0qN2ArLCudRtbuKLZwsYzL0nAwuo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-A-7u1w6OPpek-T6csY9D8g-1; Mon, 17 Oct 2022 02:09:57 -0400
X-MC-Unique: A-7u1w6OPpek-T6csY9D8g-1
Received: by mail-ot1-f71.google.com with SMTP id g18-20020a9d6a12000000b00661a4599b64so4567129otn.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v20PsHQp4Qr88/YGRnhqDCcY6Y/q2BfOq83xhjsjfWE=;
        b=iLt8wxWnUM35xkqsEsPuTA2Ho0by3un1rhvzzmR9mZG60cKuUqHnfSh0jL741V/cF4
         4gZViyx5hpE5rPJyq5b4nHK9ds/n8Q79+ntct0qTIRJ6Ayru1lZWxJ77k91a1a3OD3im
         5BmU9z7EwtCkFUs17UNRl+Qeuv7nT9k15HM4AQ2lMARvO8m/jhA7Lt+kM4dgCNi5ZXqP
         MTRsLNs277VcPuPA5L10y424R6nHyIlKFu9yYT2q7VsAOFn5xyPyhuY+Ojq4T1eJWST3
         zI+uBN+o67LtwjHDepnjTJH3UudISIinPNyh05RycI+hEq/ODEGwAZ4K0qzzqZd6L6YP
         Ht7g==
X-Gm-Message-State: ACrzQf1TF9E/3+Ndicoj4R3Yi7IyIbcXnK7/u4O0kK9j6CH8o1Ng8IC/
        D41QfhQ+Up1KnOv4Fza61r7fHg85CRuHdBYj24+smgtZN+3hOUUE2+GRW3APzdDRDSvsQV91OEy
        9Nf/NWPW2aeEw97jo36pIxUiXXrtNbUI+ecxKpA00
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id i19-20020a056870c1d300b00136c4f653afmr14165201oad.35.1665986997264;
        Sun, 16 Oct 2022 23:09:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM41XKqiAwqq1+LJqy0pjBH7CDaaGUaBJECgFukJbjvEBs+g6HV7XQp1KrgniibZS6klAviHK6cZxtQfuDC2mw8=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr14165187oad.35.1665986997103; Sun, 16
 Oct 2022 23:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221014042037.23639-1-jasowang@redhat.com> <87o7ueh5bd.fsf@meer.lwn.net>
In-Reply-To: <87o7ueh5bd.fsf@meer.lwn.net>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 17 Oct 2022 14:09:45 +0800
Message-ID: <CACGkMEuMX2b6pQwaKMQy+OEFoB7BLs0BmxqORYeP-D7oo5irmA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio: document virtio hardening status and TODO
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, liuwe@microsoft.com, kkashanjat@microsoft.com,
        cohuck@redhat.com, otubo@redhat.com, andavis@redhat.com,
        aadam@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:02 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Jason Wang <jasowang@redhat.com> writes:
>
> > This patch summarizes the status of hardening and TODO of hardening
> > virtio core and drivers.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  Documentation/security/virtio/core.rst | 49 ++++++++++++++++++++++++++
> >  MAINTAINERS                            |  1 +
> >  2 files changed, 50 insertions(+)
> >  create mode 100644 Documentation/security/virtio/core.rst
>
> Do you really need to create a new directory for a single file?
>

Not sure, but I think we can start without a dedicated directory.

> Regardless of where it sits, you'll need to add this file to an
> index.rst file so that it becomes part of the docs build.

Yes, I will fix it.

Thanks

>
> Thanks,
>
> jon
>

