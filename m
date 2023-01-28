Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D440A67F3F1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjA1CSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21ED5A806
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674872246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Nfb5TyV36RNZzOexJAnbr/uhWI9BYbLm6GvCjHYzrI=;
        b=XWdT1s43ktZCqtnYqBBSYptnHM29H5QYUzom+i3avAbVwLSdm5oIfpGP7VbW8F/XpHAc9O
        55OiSZw/HuHTcUsYx+zi9xjWgSiR30ZSXG49OD9FNhO2QLxf9as8Vg0tKIuhA0nFy5w/hP
        ED8wf3OA5LrE4NToRY4kz8bG2S9oO1g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-3SzMkpjzPpOnIGTAs_M60g-1; Fri, 27 Jan 2023 21:17:24 -0500
X-MC-Unique: 3SzMkpjzPpOnIGTAs_M60g-1
Received: by mail-ej1-f70.google.com with SMTP id du14-20020a17090772ce00b0087108bbcfa6so4427850ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nfb5TyV36RNZzOexJAnbr/uhWI9BYbLm6GvCjHYzrI=;
        b=m+Wz1HoSCUIjxc0v5m545QLrD7oWM1D4o7xMtH69FPoHehGQK49vA8IevtmVk+I+jf
         /MU7P28NW9nACfURDJNdTM9hHhqDQux1V8hYQudAUIwKWGkBZYhFbMqOooPholCfUdkh
         gohf1h44UtJIuzwzH28FV0Er107JVEeOMV06plVNcZgLgukEVbpx7bjwf5Lh96EcLcIc
         p5UM/orukirGOfnoIrhvFpAYOPKKv43Wr7nHFC5XQTVl9nkr/brGxRwiQoA4yA5Xc3EP
         G8fpcIQ9Rx/C0HrQemGW8rEYvYK8pxWQxxg3mEMcj/5Cnadl8e227Gy8Uj4uBkURY4D4
         pPcA==
X-Gm-Message-State: AFqh2kranE7mClEntgzbWVe1ywXHGhvl5YESf+EBFEw71UkRaJeWlbId
        pvS6IenkOudgV7LaaYij80nhs6K6XcWZfkKvteo94KfUY7z94Ksn/mUz3hRyZCI/hejyGqh653g
        SdqoUlsc7S6U2XCsjyNQ6kE0H
X-Received: by 2002:a17:907:d684:b0:870:4986:2ce with SMTP id wf4-20020a170907d68400b00870498602cemr51588155ejc.58.1674872243765;
        Fri, 27 Jan 2023 18:17:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXum01YGNXBgtWBiKpPeFfGkYkT0P2LOkTiVNvtA7VlleM4KOwoApiJmgjZunuCwGbsvP8dFdQ==
X-Received: by 2002:a17:907:d684:b0:870:4986:2ce with SMTP id wf4-20020a170907d68400b00870498602cemr51588140ejc.58.1674872243534;
        Fri, 27 Jan 2023 18:17:23 -0800 (PST)
Received: from WINDOWS. ([2a02:810d:4b3f:de78:34ca:d547:b407:3c1c])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906065500b007a4e02e32ffsm3202905ejb.60.2023.01.27.18.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 18:17:22 -0800 (PST)
Message-ID: <63d485b2.170a0220.4af4c.d54f@mx.google.com>
X-Google-Original-Message-ID: <Y9SFqwE50SA4NwMZ@WINDOWS.>
Date:   Sat, 28 Jan 2023 03:17:15 +0100
From:   Danilo Krummrich <dakr@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     bskeggs@redhat.com, alex000young@gmail.com, security@kernel.org,
        kherbst@redhat.com, nouveau@lists.freedesktop.org,
        hackerzheng666@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH] drm/nouveau/mmu: fix Use after Free bug in
 nvkm_vmm_node_split
References: <20221230072758.443644-1-zyytlz.wz@163.com>
 <87mt6zr9s4.wl-tiwai@suse.de>
 <87mt64qit5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt64qit5.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 01:10:46PM +0100, Takashi Iwai wrote:
> On Tue, 03 Jan 2023 15:07:55 +0100,
> Takashi Iwai wrote:
> > 
> > On Fri, 30 Dec 2022 08:27:58 +0100,
> > Zheng Wang wrote:
> > > 
> > > Here is a function call chain.
> > > nvkm_vmm_pfn_map->nvkm_vmm_pfn_split_merge->nvkm_vmm_node_split
> > > If nvkm_vma_tail return NULL in nvkm_vmm_node_split, it will
> > > finally invoke nvkm_vmm_node_merge->nvkm_vmm_node_delete, which
> > > will free the vma. However, nvkm_vmm_pfn_map didn't notice that.
> > > It goes into next label and UAF happens.
> > > 
> > > Fix it by returning the return-value of nvkm_vmm_node_merge
> > > instead of NULL.
> > > 
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > 
> > FWIW, CVE-2023-0030 has been assigned to this bug.
> > It's a question whether it really deserves as a security issue, but a
> > bug is a bug...
> > 
> > Ben, could you review this please?
> 
> A gentle ping as reminder.  The bug is still present.

This was also reported in [1]. I had a closer look and FWICT this code is fine
and there isn't a bug.

Zheng Wang, the reporter of the BZ, also confirmed this to be a false positive
from CodeQL.

Anyway, here's the explaination I also posted in the BZ:

"In nvkm_vmm_node_merge() nvkm_vmm_node_delete() is only called when prev is
set. However, prev is NULL unless we enter the "if (vma->addr != addr)" path in
nvkm_vmm_node_split(). In such a case the vma pointer, which is also passed to
nvkm_vmm_node_merge(), is set to a freshly allocated struct nvkm_vma with
nvkm_vma_tail() right before prev is set to the old vma pointer.

Hence, the only thing happening there when nvkm_vma_tail() fails in the
"if (vma->size != size)" path is that either nvkm_vmm_node_merge() does nothing
in case prev wasn't set or it merges and frees the new vma created in the
"if (vma->addr != addr)" path. Or in other words the proper cleanup for the
error condition is done.

I can't see any case where the original vma pointer given by nvkm_vmm_pfn_map()
is actually freed."

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2157041

- Danilo

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > > ---
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> > > index ae793f400ba1..84d6fc87b2e8 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
> > > @@ -937,8 +937,8 @@ nvkm_vmm_node_split(struct nvkm_vmm *vmm,
> > >  	if (vma->size != size) {
> > >  		struct nvkm_vma *tmp;
> > >  		if (!(tmp = nvkm_vma_tail(vma, vma->size - size))) {
> > > -			nvkm_vmm_node_merge(vmm, prev, vma, NULL, vma->size);
> > > -			return NULL;
> > > +			tmp = nvkm_vmm_node_merge(vmm, prev, vma, NULL, vma->size);
> > > +			return tmp;
> > >  		}
> > >  		tmp->part = true;
> > >  		nvkm_vmm_node_insert(vmm, tmp);
> > > -- 
> > > 2.25.1
> > > 
> 

