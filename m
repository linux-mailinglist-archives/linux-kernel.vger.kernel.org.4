Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE2716BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjE3R4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjE3R4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A92BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685469330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSKPWaXFdOGi0gSIhT9fJ0n4SI2mbHxCHrbzwzolEv4=;
        b=hUgIqd3b+1meSSmfdKzFDAz6YjycXWIAkAzqKRTvtf0IGABjKf53sFyJr3jWCt94IAGBS7
        4wSpm5Z6LJeWtGeT+4LHrlPvlbrVMqptpq/j81IH8tm3UCYNQXnncAAYtRglZb/TNeB6KJ
        WlmoS2OBDK37wA1cFtW9Lj5f+AVrtlk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-7UptTIn6N8aSZ4cTqPplkA-1; Tue, 30 May 2023 13:55:26 -0400
X-MC-Unique: 7UptTIn6N8aSZ4cTqPplkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1855D3C14AA8;
        Tue, 30 May 2023 17:55:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.218])
        by smtp.corp.redhat.com (Postfix) with SMTP id 33D6C112132C;
        Tue, 30 May 2023 17:55:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 May 2023 19:55:07 +0200 (CEST)
Date:   Tue, 30 May 2023 19:55:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Christie <michael.christie@oracle.com>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230530175503.GA21270@redhat.com>
References: <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <20230530-autor-faxnummer-01e0a31c0fb8@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530-autor-faxnummer-01e0a31c0fb8@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30, Christian Brauner wrote:
>
> On Mon, May 29, 2023 at 01:19:39PM +0200, Oleg Nesterov wrote:
> >
> > If we want CLONE_THREAD, I think vhost_worker() should exit after get_signal()
> > returns SIGKILL. Perhaps it should "disable" vhost_work_queue() somehow and
>
> Yes, and that's what I proposed at the beginning of this tread.

Yes. And you know, I misunderstood you even if I had the same feeling from the
very beginning too (except I wasn't and still not sure CLONE_THREAD is a good
idea). Because... OK, I think it doesn't matter now ;)

Mike, Eric, et al.

I'll try to (at least) read your emails tomorrow. Another day spent on redhat
bugzillas.

Oleg.

