Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0A6C6716
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCWLvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCWLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:51:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BBF3403F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 644A3B820D2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29EAC433D2;
        Thu, 23 Mar 2023 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679572255;
        bh=7fUaxUEtoZb7RGWN4Xxy396TqbiwVriSWMf0qBM3DIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8w5cceN4z7AltqPtTePiktXGKe1e3D3ZoewqUT/bcYQHg8CuFUlpgVRLW8Om/qi/
         +g0KE+5jYj0TDajvnG2wsRaJNhmUbtdINHZrLxgRXfIODu/9UCKChLrz9nfPLZi9wj
         Zw8JLnQycwOSTcaTEv7INhqe5dNEmM6wYh/Z+Raf7RHjh4i3Z0B+uzC7epsKdeok6q
         baC72ExGIZGEq3tq0BNYywjfRaqu0HguCiAI8WlJAjcmp0jGZqkz+rfnXEjW2Z/8ji
         enasJAzTuYMQW4R+miS/tLNpz5+De7S4DQ+9fATtY1ZhPs0a2h8BJxEZM2wOWHY28T
         EexPrdq3yTuFg==
Date:   Thu, 23 Mar 2023 12:50:49 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323115049.vsrnufcaqstpxik3@wittgenstein>
References: <20230322185605.1307-1-michael.christie@oracle.com>
 <20230323033557-mutt-send-email-mst@kernel.org>
 <20230323104445.qidusxeruimeawy6@wittgenstein>
 <20230323073918-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323073918-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:43:04AM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 23, 2023 at 11:44:45AM +0100, Christian Brauner wrote:
> > On Thu, Mar 23, 2023 at 03:37:19AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> > > > vhost_task_create is supposed to return the vhost_task or NULL on
> > > > failure. This fixes it to return the correct value when the allocation
> > > > of the struct fails.
> > > > 
> > > > Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> > > > Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> > > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > > 
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > The affected patch is not upstream yet, right?
> > > I don't know if the tree in question allows rebases - linux-next
> > > does. So ideally it would be squashed to avoid issues during bisect.
> > > Still it's error path so I guess not a tragedy even without squashing.
> > 
> > I tend to not rebase once stuff has been in linux-next but I make
> > exceptions as long as it's before -rc4. For now I've put the patch on
> > top (see the other mail I sent) but if it's really important I can
> > squash it after the weekend (I'll be mostly afk until then.).
> 
> Hard to say how important, but I'd prefer that, yes.

Ok, fold the fixup into

e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process

the series is now at:

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
branch: kernel.user_worker

1a5f8090c6de vhost: move worker thread fields to new struct
e297cd54b3f8 vhost_task: Allow vhost layer to use copy_process
89c8e98d8cfb fork: allow kernel code to call copy_process
094717586bf7 fork: Add kernel_clone_args flag to ignore signals
11f3f500ec8a fork: add kernel_clone_args flag to not dup/clone files
54e6842d0775 fork/vm: Move common PF_IO_WORKER behavior to new flag
c81cc5819faf kernel: Make io_thread and kthread bit fields
73e0c116594d kthread: Pass in the thread's name during creation
cf587db2ee02 kernel: Allow a kernel thread's name to be set in copy_process
e0a98139c162 csky: Remove kernel_thread declaration
