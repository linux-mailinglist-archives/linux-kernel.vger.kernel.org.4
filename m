Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D965946A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 04:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiL3Dlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 22:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiL3Dle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 22:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A85BCB2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 19:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672371646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1F5+hQjkJhgkTWUhZtnbA0j58E86UDL3Nmc2tQULevg=;
        b=Ekrd4DNdP9c9qVN5PFtrZX5q20XFm8k7JJkJaIHIEo7+ExsLd5THZSs6g8CVL7N20/8TjI
        0WNHT/6PPQd76qeVK7fifu4f+SqmzNuZXQS6caBZ0ImILULoCIyuR8Rwt2n0OfYpyzfSg9
        WlvuJI7+fd9kidUMYaOjN0gmFMWQel8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-8X9ztmd-MdiMQPJzEmbqVA-1; Thu, 29 Dec 2022 22:40:44 -0500
X-MC-Unique: 8X9ztmd-MdiMQPJzEmbqVA-1
Received: by mail-ot1-f69.google.com with SMTP id l44-20020a0568302b2c00b006782da3829eso10928748otv.16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 19:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F5+hQjkJhgkTWUhZtnbA0j58E86UDL3Nmc2tQULevg=;
        b=RhOLOSsJjy0Jvpr9abNTF+NqIt3+Gr+hOebAPquVB7HNYS60eSCDEtAG11Dgb4agvL
         Psiuu5oow3mIe7TO5Gmwpuioi+U4VVWJzk3DwinCr1rzBt2D1MnPLTbWMDdD5tuZJWY+
         IztFQAPqwg/azXVRjvuUAWg8Co6jfizVbvC1S60EDK+7nzayLrzTo0A8GRLRB0D1RGmy
         lIv5ga7n7dU2VdkGYc9B9bvC7HMw7pyMTz1HsHK1j3+x+lrr3agQiEoVvYmNypQvUemK
         SFtHosgef705I4n+jcoZJJ7CBTXJ9VAKTKs+paksNSZjeRMT7tXT8ZZO8ytsx0lpVHP0
         vx1A==
X-Gm-Message-State: AFqh2kr482TXVc2qckfwxrPiFrvrUOc02l/3vTeBd4sYhSvSQTKk0sKA
        Ug6a1w+r/UK3k4PasRidsmpFi+rW/o8g+U4esDvb1az0+UZiiS2k0y/YiVO3Wc7za0VQWFqYQu0
        ut3CDxQSRCX+FQTGWtnkQKR9diToZeRKka16qHJjW
X-Received: by 2002:a4a:c989:0:b0:480:8f4a:7062 with SMTP id u9-20020a4ac989000000b004808f4a7062mr1398905ooq.57.1672371643843;
        Thu, 29 Dec 2022 19:40:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt7j5z1WBF0/DPB10FVuklqtEzv/3UxFifxJVoglD/g2yM0R+oXtjjD2Fs4H38z4VS9qlknIfSdxxEXjcWRmBs=
X-Received: by 2002:a4a:c989:0:b0:480:8f4a:7062 with SMTP id
 u9-20020a4ac989000000b004808f4a7062mr1398904ooq.57.1672371643572; Thu, 29 Dec
 2022 19:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com> <20221226074908.8154-2-jasowang@redhat.com>
 <20221227023447-mutt-send-email-mst@kernel.org> <6026e801-6fda-fee9-a69b-d06a80368621@redhat.com>
 <20221229185120.20f43a1b@kernel.org>
In-Reply-To: <20221229185120.20f43a1b@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 30 Dec 2022 11:40:32 +0800
Message-ID: <CACGkMEsL2Tm=J-nazDEebO0_8=S_4hW2vKdLpZy7ab=Yr92cPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-net: convert rx mode setting to use workqueue
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 10:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 27 Dec 2022 17:06:10 +0800 Jason Wang wrote:
> > > Hmm so user tells us to e.g enable promisc. We report completion
> > > but card is still dropping packets. I think this
> > > has a chance to break some setups.
> >
> > I think all those filters are best efforts, am I wrong?
>
> Are the flags protected by the addr lock which needs BH, tho?
>
> Taking netif_addr_lock_bh() to look at dev->flags seems a bit
> surprising to me.
>

Yes, RTNL should be sufficient here. Will fix it.

Thanks

