Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5671B746008
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGCPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD89C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C045860FAF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506F2C433C7;
        Mon,  3 Jul 2023 15:43:20 +0000 (UTC)
Date:   Mon, 3 Jul 2023 11:43:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ajay Kaher <akaher@vmware.com>
Subject: Buggy rwsem locking code in fs/smb/client/file.c
Message-ID: <20230703114318.1576ea24@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just reviewed a patch that copied a solution from
fs/smb/client/file.c (original was fs/cifs/file.c), which is really
just hiding a bug. And because this code could have possibly caused
this buggy solution to be repeated, I believe it should be fixed,
before others use it as precedent in other areas of the kernel.

Commit d46b0da7a33dd ("cifs: Fix cifsInodeInfo lock_sem deadlock when
reconnect occurs") has in its change log:

    There's a deadlock that is possible and can easily be seen with
    a test where multiple readers open/read/close of the same file
    and a disruption occurs causing reconnect.  The deadlock is due
    a reader thread inside cifs_strict_readv calling down_read and
    obtaining lock_sem, and then after reconnect inside
    cifs_reopen_file calling down_read a second time.  If in
    between the two down_read calls, a down_write comes from
    another process, deadlock occurs.
    
            CPU0                    CPU1
            ----                    ----
    cifs_strict_readv()
     down_read(&cifsi->lock_sem);
                                   _cifsFileInfo_put
                                      OR
                                   cifs_new_fileinfo
                                    down_write(&cifsi->lock_sem);
    cifs_reopen_file()
     down_read(&cifsi->lock_sem);
    
    Fix the above by changing all down_write(lock_sem) calls to
    down_write_trylock(lock_sem)/msleep() loop, which in turn
    makes the second down_read call benign since it will never
    block behind the writer while holding lock_sem.

And hides the bug by wrapping the down_write() with:

+void
+cifs_down_write(struct rw_semaphore *sem)
+{
+       while (!down_write_trylock(sem))
+               msleep(10);
+}
+

The comment above down_read_nested() has:

/*
 * nested locking. NOTE: rwsems are not allowed to recurse
 * (which occurs if the same task tries to acquire the same
 * lock instance multiple times), but multiple locks of the
 * same lock class might be taken, if the order of the locks
 * is always the same. This ordering rule can be expressed
 * to lockdep via the _nested() APIs, but enumerating the
 * subclasses that are used. (If the nesting relationship is
 * static then another method for expressing nested locking is
 * the explicit definition of lock class keys and the use of
 * lockdep_set_class() at lock initialization time.
 * See Documentation/locking/lockdep-design.rst for more details.)
 */

As the NOTE above states, down_read() is not a recursive lock, which
appears to be what cifs is using it for. I wonder if it could be
converted to using RCU instead.

I'm just bringing this to everyone's attention because that code really
needs to be fixed.

-- Steve
