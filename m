Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9A6C68CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCWMsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCWMsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E7929E03
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679575642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYfZJMpNrkEZ/F3L7O50xwvFHvcSjWlpO9iZFIzUt6g=;
        b=f21S+GO/LztEpV3i9Oh/5IB0aC+no4FymxHp44w3PH42KggKcH4Y4dEtaNegNcuKuGl85w
        fcYlU+3ClWPYDyEKZRDOWH6HK9cpQqTf11JoMKCb/iCx2HPWab1Epe9J2OcymrMk4WpRzt
        TwnpXLuaUeXBt5Xre97goGUIpCpZfdk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Pdo1rK1VNoargkiqpuysaA-1; Thu, 23 Mar 2023 08:47:21 -0400
X-MC-Unique: Pdo1rK1VNoargkiqpuysaA-1
Received: by mail-ed1-f69.google.com with SMTP id a27-20020a50c31b000000b0050047ecf4bfso26016295edb.19
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYfZJMpNrkEZ/F3L7O50xwvFHvcSjWlpO9iZFIzUt6g=;
        b=2kptCarDI4pDZxf6gi1ndOloEJyWPFJjfD5Rt5CUOq7x695Z4RYH3LU5XMIHLILYwt
         ZhZrCU3WxaaBzU6l8aZLfKaXTbEcHi6r2YDaOICxd3loAYHiehf4On8f5weGIBYgp+nM
         SD1gFpGNGW7ks7Amf7Ka8f+V46nAUXDGI2/ck4138upMEYxZgnA7co5+gQRXB3bdtwEz
         2Qv4ib0TzOD1MHufL5i1/LHc9tZdWzI5wyUle5EQ/Spr2mkbgvDe37E3luhMy7Sr//N9
         CmYBTrqPpx5jG37gam2Q11rU7Fm2wDIVY5aksG2C++p9XkZksXKhmUfNMfpaNTQvXivt
         bV4A==
X-Gm-Message-State: AO0yUKWx8ICkEWtUEFhvR4n1fAdDpAqXSQOBix8wE3UZk4Y4UT1s+Yzi
        F4Lw3G3aFdm87LE2FLiq79WTU98b2XZIQG0JKZIGfPdjEiR2OnaS8dTtSDakpeXGN1SIzxa/22O
        DDhMIAyvJFQO0g5Fln5XO+H0KzFHx2FPV
X-Received: by 2002:a17:906:7054:b0:932:4eea:17ce with SMTP id r20-20020a170906705400b009324eea17cemr10717161ejj.39.1679575639791;
        Thu, 23 Mar 2023 05:47:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9kvskXuqIZ2Tc8VsZs8rA7P/L1Gd2H98L9UlrBHRAQQ4Ckzzp/Alb9KRWggi3nNHeoqR7iKA==
X-Received: by 2002:a17:906:7054:b0:932:4eea:17ce with SMTP id r20-20020a170906705400b009324eea17cemr10717145ejj.39.1679575639540;
        Thu, 23 Mar 2023 05:47:19 -0700 (PDT)
Received: from redhat.com ([2.52.143.71])
        by smtp.gmail.com with ESMTPSA id hy16-20020a1709068a7000b00931d3509af1sm8521409ejc.222.2023.03.23.05.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:47:19 -0700 (PDT)
Date:   Thu, 23 Mar 2023 08:47:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323084648-mutt-send-email-mst@kernel.org>
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
 <20230323073918-mutt-send-email-mst@kernel.org>
 <20230323115049.vsrnufcaqstpxik3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323115049.vsrnufcaqstpxik3@wittgenstein>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:50:49PM +0100, Christian Brauner wrote:
> On Thu, Mar 23, 2023 at 07:43:04AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
> > > On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> > > > > vhost_task_create is supposed to return the vhost_task or NULL on
> > > > > failure. This fixes it to return the correct value when the allocation
> > > > > of the struct fails.
> > > > > 
> > > > > Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> > > > > Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> > > > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > > > 
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > The affected patch is not upstream yet, right?
> > > > I don't know if the tree in question allows rebases - linux-next
> > > > does. So ideally it would be squashed to avoid issues during bisect.
> > > > Still it's error path so I guess not a tragedy even without squashing.
> > > 
> > > I tend to not rebase once stuff has been in linux-next but I make
> > > exceptions as long as it's before -rc4. For now I've put the patch on
> > > top (see the other mail I sent) but if it's really important I can
> > > squash it after the weekend (I'll be mostly afk until then.).
> > 
> > Hard to say how important, but I'd prefer that, yes.
> 
> Ok, fold the fixup into
> 
> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
> 
> the series is now at:
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> branch: kernel.user_worker
> 
> 1a5f8090c6de vhost: move worker thread fields to new struct
> e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
> 89c8e98d8cfb fork: allow kernel code to call copy_process
> 094717586bf7 fork: Add kernel_clone_args flag to ignore signals
> 11f3f500ec8a fork: add kernel_clone_args flag to not dup/clone files
> 54e6842d0775 fork/vm: Move common PF_IO_WORKER behavior to new flag
> c81cc5819faf kernel: Make io_thread and kthread bit fields
> 73e0c116594d kthread: Pass in the thread's name during creation
> cf587db2ee02 kernel: Allow a kernel thread's name to be set in copy_process
> e0a98139c162 csky: Remove kernel_thread declaration

Thanks a lot! Mike could you give it a spin to make sure all is well?

-- 
MST

