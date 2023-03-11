Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A06B6017
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCKTQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCKTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632863E610
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678562118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8Qyu+0I7e5+wByj0r24z51cw7ysaFBsNZQFvfJyvK8=;
        b=XCTDw51e++YG+VawkzEZJMC33cOPo4VhdaLWV4xbFlOZELkE7wtRqUzQmq8FoiidB21Ma5
        ddBZS03RE4CB0N4q7A/OMx9sZAFK5iSY4q/U1Jb7IbWJLyZ8sHfvLWuhce6nIgs2w+7SFu
        o69Sl6TQUYd5Qu6nKmQQOWpKDm6/KwM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-sbGr2e2gOom5ubDwnf-u2Q-1; Sat, 11 Mar 2023 14:15:17 -0500
X-MC-Unique: sbGr2e2gOom5ubDwnf-u2Q-1
Received: by mail-wm1-f69.google.com with SMTP id 4-20020a05600c024400b003eb2e295c05so2835016wmj.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 11:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678562116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Qyu+0I7e5+wByj0r24z51cw7ysaFBsNZQFvfJyvK8=;
        b=agrLJ4zQpGMdxImLUt3DFOnJgqECTxf+WJmMA840CikqoBi3asgtCTui61WUeP2nd+
         fkhvZKeSyB/4GctroUtwdLK03MnVpjNBnm+uUgeruuzi0Ok9NektGCJDNLZV91aFENqj
         Co78nwsdZ8fzjmNZ5LxBN6MTHnd905Mz7BHBvoBzqQ5rruA+xtRPiclJwU2hLAANRyNv
         7xKa430dMc+OuI0W7F3bMRycVVl+ta6w56aRPft+KgasebxdXWVQ8uy+weIkZLdai8lQ
         CasrQ2F1BtPnzkZpeQQ8WF2/cp5VN3J4ds/JkxqXFivcjk56MrmYw1HoaKPhY0mxilYz
         pguQ==
X-Gm-Message-State: AO0yUKWmjpcRTK5UoxEE8wP0zrE2FoRe6oWtm9v3tDiLcKN2i4vOknxo
        jQt+wTdpmMcIM2tqOh0v3nsJSqf353aKF95UuCLz1+2lJ9R3Duuq4ngcAVBDNkzx7b8V2PsqssM
        4wrrwDOCegoMJq53EW5utcyw0
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id o7-20020a05600c510700b003dfe1e9201dmr6207028wms.40.1678562115909;
        Sat, 11 Mar 2023 11:15:15 -0800 (PST)
X-Google-Smtp-Source: AK7set96M5dPOa2xYmlmAGYkZvOKRptdsLbtTB1fIalkMaZYMMMU2r6s84fcwBbGUwoLesMEVUOzsQ==
X-Received: by 2002:a05:600c:5107:b0:3df:e1e9:201d with SMTP id o7-20020a05600c510700b003dfe1e9201dmr6207018wms.40.1678562115654;
        Sat, 11 Mar 2023 11:15:15 -0800 (PST)
Received: from redhat.com ([2.52.29.35])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b003ed1fa34bd3sm487743wmd.13.2023.03.11.11.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 11:15:15 -0800 (PST)
Date:   Sat, 11 Mar 2023 14:15:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Christie <michael.christie@oracle.com>, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
Message-ID: <20230311141346-mutt-send-email-mst@kernel.org>
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 09:21:14AM -0800, Linus Torvalds wrote:
> On Fri, Mar 10, 2023 at 2:04 PM Mike Christie
> <michael.christie@oracle.com> wrote:
> >
> > The following patches were made over Linus's tree and apply over next. They
> > allow the vhost layer to use copy_process instead of using
> > workqueue_structs to create worker threads for VM's devices.
> 
> Ok, all these patches looked fine to me from a quick scan - nothing
> that I reacted to as objectionable, and several of them looked like
> nice cleanups.
> 
> The only one I went "Why do you do it that way" for was in 10/11
> (entirely internal to vhost, so I don't feel too strongly about this)
> how you made "struct vhost_worker" be a pointer in "struct vhost_dev".
> 
> It _looks_ to me like it could just have been an embedded structure
> rather than a separate allocation.
> 
> IOW, why do
> 
>    vhost_dev->worker
> 
> instead of doing
> 
>   vhost_dev.worker
> 
> and just having it all in the same allocation?
> 
> Not a big deal. Maybe you wanted the 'test if worker pointer is NULL'
> code to stay around, and basically use that pointer as a flag too. Or
> maybe there is some other reason you want to keep that separate..
> 
>                Linus

I agree with Linus here, slightly better embedded, but no huge deal.
Which tree is this going on?
If not mine here's my ack:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST

