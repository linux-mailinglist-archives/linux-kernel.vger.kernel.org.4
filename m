Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D146672E467
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbjFMNmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbjFMNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401991
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686663670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5JB3B1I0lsPxgyN0O7YZCulwf8AC87SW0xW2zMXB4/U=;
        b=gz7IB7vDdKlFadm/fuSDouEAjauv8qzBbboKSAsMGQp9qmJuKipygkHnfwrotIp/v3cNvD
        lhIYfR3CBRFWMZ4OrRjArVNgq4UR+tY3lm5qIKxaa7uzDgUQq7bJgPW+XTwcAPLHZxOrwr
        jX0PghdpcThJrN1oe2yyzt75c8KtOJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-XrbKhtSQMHGeDOMBuDHorA-1; Tue, 13 Jun 2023 09:41:07 -0400
X-MC-Unique: XrbKhtSQMHGeDOMBuDHorA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBF86811E8E;
        Tue, 13 Jun 2023 13:41:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A10ED492CA6;
        Tue, 13 Jun 2023 13:41:06 +0000 (UTC)
Date:   Tue, 13 Jun 2023 14:41:05 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Aaron Thompson <dev@aaront.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: printk.time causes rare kernel boot hangs
Message-ID: <20230613134105.GA10301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Being tracked in this bug which contains much more detail:
https://gitlab.com/qemu-project/qemu/-/issues/1696 ]

Recent kernels hang rarely when booted on qemu.  Usually you need to
boot 100s or 1,000s of times to see the hang, compared to 292,612 [sic]
successful boots which I was able to do before the problematic commit.

A reproducer (you'll probably need to use Fedora) is:

  $ while guestfish -a /dev/null -v run >& /tmp/log; do echo -n . ; done

You will need to leave it running for probably several hours, and
examine the /tmp/log file at the end.

I tracked this down to the following commit:

  commit f31dcb152a3d0816e2f1deab4e64572336da197d
  Author: Aaron Thompson <dev@aaront.org>
  Date:   Thu Apr 13 17:50:12 2023 +0000

    sched/clock: Fix local_clock() before sched_clock_init()
    
    Have local_clock() return sched_clock() if sched_clock_init() has not
    yet run. sched_clock_cpu() has this check but it was not included in the
    new noinstr implementation of local_clock().

  (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f31dcb152a3d0816e2f1deab4e64572336da197d)

Reverting this commit fixes the problem.

I don't know _why_ this commit is wrong, but can we revert it as it
causes serious problems with libguestfs hanging randomly.

Or if there's anything you want me to try out then let me know,
because I can reproduce the problem locally quite easily.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

