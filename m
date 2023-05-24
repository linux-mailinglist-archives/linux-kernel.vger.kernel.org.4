Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851B70F85B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjEXOLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjEXOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBA4E7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684937457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPDHvMEUis0KqFn0g9sdEWNou1uipYbK1YxLUoZQd9c=;
        b=CycOpfWu+sTlV7HaVUqju48wWI0tk/gOlSaQFyNdjJhgZ098cr8pS5d1zYPRDEkhgCGGeU
        mfMcOOYP+ikUHS9UIQtJmEfzdvqPVGSRfxTIGevzHLd8cFqaETzZbCjIcwVARowO7FBWjl
        N+DgOFOSQDud8PLqIIlji1C9kQg7tmo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-wrRr0K_BP-6rHN-OLbSdNw-1; Wed, 24 May 2023 10:10:49 -0400
X-MC-Unique: wrRr0K_BP-6rHN-OLbSdNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A3B80027F;
        Wed, 24 May 2023 14:10:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.231])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E5B7407DEC6;
        Wed, 24 May 2023 14:10:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 May 2023 16:10:27 +0200 (CEST)
Date:   Wed, 24 May 2023 16:10:23 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230524141022.GA19091@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23, Eric W. Biederman wrote:
>
> I want to point out that we need to consider not just SIGKILL, but
> SIGABRT that causes a coredump, as well as the process peforming
> an ordinary exit(2).  All of which will cause get_signal to return
> SIGKILL in this context.

Yes, but probably SIGABRT/exit doesn't really differ from SIGKILL wrt
vhost_worker().

> It is probably not the worst thing in the world, but what this means
> is now if you pass a copy of the vhost file descriptor to another
> process the vhost_worker will persist, and thus the process will persist
> until that copy of the file descriptor is closed.

Hadn't thought about it.

I am fighting with internal bugzillas today, will try to write another
email tomorrow.

But before that, I would like to have an answer to my "main" question in
my previois email. Otherwise I am still not sure I understand what exactly
we need to fix.

Oleg.

