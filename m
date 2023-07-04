Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA117472A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGDNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjGDNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B8172D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688476888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXymluBB6sVoGxHppR9Pfth3NNwupwTCV9ZW/BFZ1HA=;
        b=ZA3pvSD7QmHwY8Oq3yZNGkQGLq/f2my6J5Y97flxzB1+UVYLPVKGOdMtt3wwGODhU/TuzP
        S19vRhfCDVZdMNCmGCKWGxbLrP+Oy4Uxvi6TTdssKUlSByxjTEhAllMJM9DSp53z+Fhh2E
        1OyPyRjX0QtjYuwMX3dyHJbLZ0ahGN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-Cq62ADWqPf6vcSgh4haXHg-1; Tue, 04 Jul 2023 09:21:26 -0400
X-MC-Unique: Cq62ADWqPf6vcSgh4haXHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28872104458C;
        Tue,  4 Jul 2023 13:21:26 +0000 (UTC)
Received: from localhost (unknown [10.42.28.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E45EB1121314;
        Tue,  4 Jul 2023 13:21:25 +0000 (UTC)
Date:   Tue, 4 Jul 2023 14:21:25 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <20230704132125.GB17440@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704074620.GA17440@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:46:20AM +0100, Richard W.M. Jones wrote:
> We have been having the same sort of problem
> (https://bugzilla.redhat.com/show_bug.cgi?id=2216496).  It's another
> of those bugs that requires hundreds or thousands of boot iterations
> before you can see it.  There is a test in comment 27 but it requires
> guestfish and some hacking to work.  I'll try to come up with a
> cleaner test later.

FWIW here's a better test.  It only uses qemu-system-x86_64 & a
vmlinuz file of your choice, and is very fast.  It usually hits the
bug in seconds.

  https://github.com/rwmjones/bootbootboot/tree/bz2216496

NB: You will need to change the definition of VMLINUX in
config-bz2216496-qemu.h (and generally read the code before running,
but hopefully it should just work apart from choosing a kernel image).

> I'd love to have a better way to debug this or collect more
> diagnostics if you have any suggestions.

Still open to any suggestions about better ways to debug this, or
anything you'd like me to try out.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

