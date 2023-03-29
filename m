Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FE46CD17E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC2FWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC2FWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9192D63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680067309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OpGviQRkMdN9wce+9FcdKHJnUT5elcV+86MUr/viZsA=;
        b=bHiLvMiluvyHbUPEfOZQkEBDf5VuOQ5B6JS/XLIN3fSIbuL5alJuhmkJe1oT+kqWJHNIEr
        2vTeKhO6mHo2LCpBTxd/BkVVp3tN8yCr7ZDaSIdQvYbw8SIE4JS1B6qj2DpYwo0ETvY4OV
        SVJM4sOAKC6tAzeMBlc4syfzX9u+Xkc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-8RPwxw7IOkqAbmIbhWScIw-1; Wed, 29 Mar 2023 01:21:47 -0400
X-MC-Unique: 8RPwxw7IOkqAbmIbhWScIw-1
Received: by mail-wm1-f70.google.com with SMTP id o28-20020a05600c511c00b003ef69894934so4325580wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680067306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpGviQRkMdN9wce+9FcdKHJnUT5elcV+86MUr/viZsA=;
        b=bCnnCE5Bpl/RaVS1S2V+VGk7rt3xEFzolaOa6oMJy1Z4bxlgFugAsq7JIsDTZE+MoF
         MBwP/iirhW7BLSnVNQnDvsN4sRWFPZ5lo7beBVb6Qkhy5Mkt/WTwkV0OXFEu0D1eVMM6
         d6kjZgn5R2NyS3M28b6DpelWzMNtVRWl5CqaSgtwo+xUHvDSVoHbpKgDdPzbgf4Sesqg
         27FywppYl2IZhThTr5mnlQ8zaBBOX57lAenHNKGD6fyKCp1TRU0K2o6bFUIVHE/Qv005
         dItRClNy085t0g3PtAapq7kXtVhi3f5u7Pe2Zcl/Y0bNgdAvQPGAMzL9P75z2imcZW5X
         so9g==
X-Gm-Message-State: AO0yUKXBO3IiCwxc8A4ykpWHkVA4ZUMKbfVq5zQvYpnkU64FQUmZZVDF
        eOKvU2FxgJIugaOeCPumFWi+Z0DVJ91FQroK47T9/CEtLx9O8O8fCk4mfsGw5Kxo4Y3rvP14Upq
        NnQg7jyyVQaLG2y5JcEi53lpo
X-Received: by 2002:a7b:cd87:0:b0:3ee:4bd1:39ca with SMTP id y7-20020a7bcd87000000b003ee4bd139camr14369621wmj.13.1680067306594;
        Tue, 28 Mar 2023 22:21:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set/tmTFTti71Jcmt7sCqKWDaOTmwRd2t6ytr8BVNSqDkPDfdxs7xKF1RNBRRGc20wi2FCQRbHw==
X-Received: by 2002:a7b:cd87:0:b0:3ee:4bd1:39ca with SMTP id y7-20020a7bcd87000000b003ee4bd139camr14369604wmj.13.1680067306240;
        Tue, 28 Mar 2023 22:21:46 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b002c71b4d476asm29084170wrt.106.2023.03.28.22.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:21:45 -0700 (PDT)
Date:   Wed, 29 Mar 2023 01:21:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
Message-ID: <20230329012038-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:39:59AM +0800, Jason Wang wrote:
> On Tue, Mar 28, 2023 at 11:09 AM 黄杰 <huangjie.albert@bytedance.com> wrote:
> >
> > Jason Wang <jasowang@redhat.com> 于2023年3月28日周二 10:59写道：
> > >
> > > On Tue, Mar 28, 2023 at 10:13 AM Dominique Martinet
> > > <asmadeus@codewreck.org> wrote:
> > > >
> > > > Hi Michael, Albert,
> > > >
> > > > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > > > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> > > > > the vq->event_triggered will be set to true. It will no longer be set to
> > > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > > virtqueue_enable_cb_prepare.
> > > >
> > > > This patch (commited as 35395770f803 ("virtio_ring: don't update event
> > > > idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> > > > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org
> > > >
> > > > I've just hit had a look at recent patches[1] and reverted this to test
> > > > and I can mount again, so I'm pretty sure this is the culprit, but I
> > > > didn't look at the content at all yet so cannot advise further.
> > > > It might very well be that we need some extra handling for 9p
> > > > specifically that can be added separately if required.
> > > >
> > > > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virtio/
> > > >
> > > >
> > > > This can be reproduced with a simple mount, run qemu with some -virtfs
> > > > argument and `mount -t 9p -o debug=65535 tag mountpoint` will hang after
> > > > these messages:
> > > > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > > > 9pnet: -- p9_virtio_request (83): virtio request kicked
> > > >
> > > > So I suspect we're just not getting a callback.
> > >
> > > I think so. The patch assumes the driver will call
> > > virtqueue_disable/enable_cb() which is not the case of the 9p driver.
> > >
> > > So after the first interrupt, event_triggered will be set to true forever.
> > >
> > > Thanks
> > >
> >
> > Hi: Wang
> >
> > Yes,  This patch assumes that all virtio-related drivers will call
> > virtqueue_disable/enable_cb().
> > Thank you for raising this issue.
> >
> > It seems that napi_tx is only related to virtue_net. I'm thinking if
> > we need to refactor
> > napi_tx instead of implementing it inside virtio_ring.
> 
> We can hear from others.
> 
> I think it's better not to workaround virtio_ring issues in a specific
> driver. It might just add more hacks. We should correctly set
> VRING_AVAIL_F_NO_INTERRUPT,

I am still stuck trying to understand why we don't set it.
How does event_triggered end up getting set without
event index support?

Thanks!

