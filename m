Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5B6C3CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCUVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38A1E28C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679434590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/+8rQXESx0y7iJ/lWjYGgkO51bDoW36uXQ0ZIfOfDY=;
        b=dOsGije4eIQJgfyacKCQt1ZNBgQeuOoRmC82lZah70v0VgDOCHLBB3a7YKUl/OjtZdFOMy
        c/PjKZls8/ch4hXYB9Xhdi/ujnuvSh2OfhTb+GrqAVdbPtx4s5KJ11HTap+mlDyfxfEfZK
        +a+yWxv3S2/Ykp7VZAMSTHuSme+5Kl4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-cOllpRMePd6ec7KE7Pm7qQ-1; Tue, 21 Mar 2023 17:36:28 -0400
X-MC-Unique: cOllpRMePd6ec7KE7Pm7qQ-1
Received: by mail-wm1-f69.google.com with SMTP id t1-20020a7bc3c1000000b003dfe223de49so10578833wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/+8rQXESx0y7iJ/lWjYGgkO51bDoW36uXQ0ZIfOfDY=;
        b=upWspUpenvHbkRQPVL8UX6iE1hDN8SrSQTDt+G1vEgn4VeMnxx/55yj4zQTBJeD8df
         NBNKL0pMM6sO91vUKOkG9fyzktIXldhjNWF5fJwoLAQocC781pICexmv1l+lTjHAbgBx
         npAOQcu2Ux5+aU4PSXDAyYrr1CPXsJBMXtPZUMkKGR+3LCdsgh4Psw1M/Mogfe5vkrRB
         5Nf0DH56PwRk5EEsT1qny30yXw99LwTETArqKCD/qDuY/USN2P/HkJjf3S+dQ56YRiKc
         SugZQIxe7yfMxkxykdPXclcG5CdE857paIyaeeyicObngbAW/EaONaN7+8wiZlbh+wBa
         +usw==
X-Gm-Message-State: AO0yUKVg6plVP8S8xDV0ha29ajKeymu69JpwNbtyO4HH3b3x+IV8fJ/p
        5OC08E1FN8ihbzaRxHWZTAPYs1+HPxIdjYgSjIYjGvgZKgFNIxWWWiwE5KODyH55E38LkvsdixY
        ql5b/B+3x8B4V4Wd8RBXGrRcw
X-Received: by 2002:a5d:684a:0:b0:2c7:bb13:e23f with SMTP id o10-20020a5d684a000000b002c7bb13e23fmr3211666wrw.24.1679434587571;
        Tue, 21 Mar 2023 14:36:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set84zvIxrLLTxMQYBkIMEBIwYe7FjxFCYBJQbGyp4XPILZvKxcuzUUAQAoPz/sC15CbsIQ9FYw==
X-Received: by 2002:a5d:684a:0:b0:2c7:bb13:e23f with SMTP id o10-20020a5d684a000000b002c7bb13e23fmr3211658wrw.24.1679434587237;
        Tue, 21 Mar 2023 14:36:27 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6d50000000b002cff0e213ddsm12180342wri.14.2023.03.21.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 14:36:26 -0700 (PDT)
Date:   Tue, 21 Mar 2023 17:36:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     syzbot <syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com>,
        brauner@kernel.org, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [syzbot] [kernel?] general protection fault in vhost_task_start
Message-ID: <20230321173602-mutt-send-email-mst@kernel.org>
References: <0000000000005a60a305f76c07dc@google.com>
 <2d976892-9914-5de0-62e0-c75f1c148259@oracle.com>
 <20230321135427-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321135427-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 01:55:00PM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 21, 2023 at 12:46:04PM -0500, Mike Christie wrote:
> > On 3/21/23 12:03 PM, syzbot wrote:
> > > RIP: 0010:vhost_task_start+0x22/0x40 kernel/vhost_task.c:115
> > > Code: 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 53 48 89 fb e8 c3 67 2c 00 48 8d 7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 0a 48 8b 7b 70 5b e9 fe bd 02 00 e8 79 ec 7e 00 eb
> > > RSP: 0018:ffffc90003a9fc38 EFLAGS: 00010207
> > > RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 0000000000000000
> > > RDX: 000000000000000c RSI: ffffffff81564c8d RDI: 0000000000000064
> > > RBP: ffff88802b21dd40 R08: 0000000000000100 R09: ffffffff8c917cf3
> > > R10: 00000000fffffff4 R11: 0000000000000000 R12: fffffffffffffff4
> > > R13: ffff888075d000b0 R14: ffff888075d00000 R15: ffff888075d00008
> > > FS:  0000555556247300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007ffe3d8e5ff8 CR3: 00000000215d4000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  vhost_worker_create drivers/vhost/vhost.c:580 [inline]
> > 
> > The return value from vhost_task_create is incorrect if the kzalloc fails.
> > 
> > Christian, here is a fix for what's in your tree. Do you want me to submit
> > a follow up patch like this or a replacement patch for:
> > 
> > commit 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process")
> > 
> > with the fix rolled into it?
> > 
> 
> 
> 
> > 
> > >From 0677ad6d77722f301ca35e8e0f8fd0cbd5ed8484 Mon Sep 17 00:00:00 2001
> > From: Mike Christie <michael.christie@oracle.com>
> > Date: Tue, 21 Mar 2023 12:39:39 -0500
> > Subject: [PATCH] vhost_task: Fix vhost_task_create return value
> > 
> > vhost_task_create is supposed to return the vhost_task or NULL on
> > failure. This fixes it to return the correct value when the allocation
> > of the struct fails.
> > ---
> >  kernel/vhost_task.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index 4b8aff160640..b7cbd66f889e 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
> >  
> >  	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
> >  	if (!vtsk)
> > -		return ERR_PTR(-ENOMEM);
> > +		return NULL;
> >  	init_completion(&vtsk->exited);
> >  	vtsk->data = arg;
> >  	vtsk->fn = fn;
> > 

Sorry I had nothing to add here. Sent by mistake.

