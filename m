Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99797087BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjERSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C686189
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684434204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJi9ZlLdcLDeLRUcrDXyTC7zgfOSpkMfpLKIfWFhcvU=;
        b=NepfBqdVRNCffsLGEEH394sX4uGfAi8+RIOvm8cThpNWyXbdQDHpL8mQybTklU9xsKbyPz
        mV+cA9O4NB/etcLfPhKeTvZvYCDTD/MphL1zAR0sL6lGril/EhBoYcGu+nV54LZtXMQIe5
        7RcB28LDQ3yp8MdAb5ImY1spWyASiN8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-xNxDOZS-O3yjF8lhA3tZ7g-1; Thu, 18 May 2023 14:23:20 -0400
X-MC-Unique: xNxDOZS-O3yjF8lhA3tZ7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 294E029AB448;
        Thu, 18 May 2023 18:23:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2CF7EC15BA0;
        Thu, 18 May 2023 18:23:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 May 2023 20:23:05 +0200 (CEST)
Date:   Thu, 18 May 2023 20:23:02 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230518182301.GB5817@redhat.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <20230518-kontakt-geduckt-25bab595f503@brauner>
 <7412912a-a470-bd3d-fb1c-54c094cc01ee@oracle.com>
 <20230518-ratgeber-erbeben-843e68b0d6ac@brauner>
 <20230518180809.GA5817@redhat.com>
 <20230518-fettgehalt-erdbeben-25587a432815@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518-fettgehalt-erdbeben-25587a432815@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Christian Brauner wrote:
>
> On Thu, May 18, 2023 at 08:08:10PM +0200, Oleg Nesterov wrote:
> > On 05/18, Christian Brauner wrote:
> > >
> > > Yeah, but these are issues that exist with PF_IO_WORKER then too
> >
> > This was my thought too but I am starting to think I was wrong.
> >
> > Of course I don't understand the code in io_uring/ but it seems
> > that it always breaks the IO loops if get_signal() returns SIGKILL.
>
> Yeah, it does and I think Mike has a point that vhost could be running
> into an issue here that io_uring currently does avoid. But I don't think
> we should rely on that.

So what do you propose?

Unless (quite possibly) I am confused again, unlike io_uring vhost can't
tolerate signal_pending() == T in the cleanup-after-SIGKILL paths?

Oleg.

