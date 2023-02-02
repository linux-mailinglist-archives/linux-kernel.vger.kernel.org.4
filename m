Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33F6877E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBBIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBBIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A41588F1A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675327808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1QlRKAukJgDjMO08bU68h0Vi7CwNCYlj1Nlf3B4zLA=;
        b=NDeiVRbR/b/tGJnGzbqfsqyzsHomQWBh0uoiF4k9HnrDRfbNTRGax68OJEvQjyAboTs/GE
        vml1sOPCW+VEEsNwnPbetGB/xZc3Bedj9TU9egMdWgId7ZJC9KFzfnrI32BlTmYQRVVmoa
        MmsHefKfKlYLIR/f/Ne0rdDr1LcA9sM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-Q90M3oNbNKegs7nS29kSyg-1; Thu, 02 Feb 2023 03:50:04 -0500
X-MC-Unique: Q90M3oNbNKegs7nS29kSyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9AA1C05AFB;
        Thu,  2 Feb 2023 08:50:04 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBD14404BEC0;
        Thu,  2 Feb 2023 08:49:59 +0000 (UTC)
Date:   Thu, 2 Feb 2023 16:49:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9t5MtE2Xg53u07O@T590>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
 <Y9gZAJGgdjFtsm9I@itl-email>
 <Y9jW73uAtE3HdCou@infradead.org>
 <Y9lBlKD3U/jMug9j@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9lBlKD3U/jMug9j@itl-email>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:27:59AM -0500, Demi Marie Obenour wrote:
> On Tue, Jan 31, 2023 at 12:53:03AM -0800, Christoph Hellwig wrote:
> > On Mon, Jan 30, 2023 at 02:22:39PM -0500, Demi Marie Obenour wrote:
> > > What do you recommend instead?  This solves a real problem for
> > > device-mapper users and I am not aware of a better solution.
> > 
> > You could start with explaining the problem and what other methods
> > you tried that failed.  In the end it's not my job to fix your problem.
> 
> I’m working on a “block not-script” (Xen block device hotplug script
> written in C) for Qubes OS.  The current hotplug script is a shell
> script that takes a global lock, which serializes all invocations and
> significantly slows down VM creation and destruction.  My C program
> avoids this problem.
> 
> One of the goals of the not-script is to never leak resources, even if
> it dies with SIGKILL or is never called with the “remove” argument to

If it dies, you still can restart one new instance for handling the device
leak by running one simple daemon to monitor if not-script is live.

> destroy the devices it created.  Therefore, whenever possible, it relies
> on automatic destruction of devices that are no longer used.  I have

This automatic destruction of devices is supposed to be done in
userspace, cause only userspace knows when device is needed, when
it is needed.

So not sure this kind of work should be involved in kernel.


Thanks, 
Ming

