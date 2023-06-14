Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6972FC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbjFNLXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFNLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E084173E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686741784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4cj2TgNSsDzKOjvOL/QoyRK+vVK3iiS9KxBbXrqyWS4=;
        b=NwNXtXIryBYk7FxXtiusshUkgq0oLHX2xljLfGauL5PFrrExkwz2QiONFlHRs8dgWwTnaQ
        OON6KlTwwUTcMkCsS58kU+j0c3j6Lnqx7k45fQ1gPY7cnkCtQ4MHpmgy+zyVufD/l4g+ok
        4S7oSjVqGYsCvxRpTx21DzJZCDN7cd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-lUlGY9VnMhKXrTcl8YGa7g-1; Wed, 14 Jun 2023 07:23:00 -0400
X-MC-Unique: lUlGY9VnMhKXrTcl8YGa7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA04830EFD;
        Wed, 14 Jun 2023 11:23:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4181910CE7;
        Wed, 14 Jun 2023 11:23:00 +0000 (UTC)
Date:   Wed, 14 Jun 2023 12:22:59 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614112259.GC7636@redhat.com>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
 <20230614111644.GH1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614111644.GH1639749@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:16:44PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 14, 2023 at 10:45:22AM +0100, Richard W.M. Jones wrote:
> > Debian should work too actually, just run the following command until
> > it hangs:
> > 
> > > >   $ while guestfish -a /dev/null -v run >& /tmp/log; do echo -n . ; done
> 
> What kernel with guestfish use?

I think it's easier to test using the qemu command I suggested in a
later email.  (The command line is very long but should be simple to
understand.)  That way you can just use a local vmlinux or vmlinuz
file:

https://lkml.org/lkml/2023/6/14/491

Note for gdb you will need to add '-s' to the qemu command line as well.

Unfortunately since the hang is so rare it's not really possible to
attach gdb at the beginning, since you'd have to do hundreds of runs
before seeing the problem.  The stack trace seems like it isn't very
interesting (since the kernel still appears to be running while "hung").

If you have any other suggestions for things I can try please let me
know - this is a pretty important issue for us as it breaks CI tests,
so I can try whatever you like.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

