Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787C72FB05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjFNKdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjFNKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3D10D8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686738615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zi9IvM4FPjHv6y+/DI0fBJ80iOPAHzkaGK3eRt2hZko=;
        b=S+fStN+xdSaYvF9xpCPGdmsRh5iPw/hioFbt2ZOCPofhiiu89aiwkk71lqt+g4UG7cl9Ic
        dESGk0RuOkMpxmveR6LAll5eZEs3YDl6uCAlTyGtUNgXmL81wN/1QY8kMUBkM0EeClIXog
        u67+k8Xvt8LIK9SIe2SHitNTDslYlQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592--17XzwBeMQuvliQMuupviw-1; Wed, 14 Jun 2023 06:30:12 -0400
X-MC-Unique: -17XzwBeMQuvliQMuupviw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A3F7101A58F;
        Wed, 14 Jun 2023 10:30:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF1191121314;
        Wed, 14 Jun 2023 10:30:11 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:30:11 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614103011.GL7912@redhat.com>
References: <20230613134105.GA10301@redhat.com>
 <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
 <20230614094522.GA7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614094522.GA7636@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

OK I have a simpler test:

$ while true; do qemu-system-x86_64 -no-user-config -nodefaults -display none -machine accel=kvm:tcg,graphics=off -cpu max,la57=off -m 1280 -no-reboot -rtc driftfix=slew -no-hpet -global kvm-pit.lost_tick_policy=discard -kernel vmlinux -serial stdio -append "panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.event-timeout=6000 no_timer_check printk.time=1 cgroup_disable=memory usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 root=UUID=7cd9caf4-6491-41a5-b387-38af6fa2d638 selinux=0 guestfs_verbose=1 TERM=xterm-256color" >& /tmp/log ; echo -n . ; done

where "vmlinux" is a locally compiled kernel with CONFIG_PRINTK_TIME=y
set.  I'm using the current git head.

This will print dots about once a second.  When it stops printing dots
(after potentially many thousands of iterations), take a look at
/tmp/log to see if it has hung at:

  [    0.071830] Freeing SMP alternatives memory: 48K

I tried connecting gdb to qemu but so far I've not successfully
managed to collect a usable stack trace.  I can't seem to get it to
print symbols, even though I believe I have disabled kASLR, but still
trying.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

