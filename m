Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167DA64A61F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiLLRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLLRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:44:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE966BE0A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670867018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ErucJm5oJdUOSR1gxQc+Q30vftKSRQo7FXxiHKUX1kk=;
        b=Hm5+WTvxe/N0KTrRqbo6LiLF1rhNfOe7ad7DAw2ICsmmkQEG9GDMEaBRlIGVdMiL7X0POA
        zluZY9NCsAE37zEVGyMJaWoaFwFTQEFwkYOck6uHSbQxGrjGK9n/++u2w53BnSxszZ6pLx
        5wQofsUkF41nES8robGbAAD9Ek3Cnaw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-3jRwGyAxN0ySz0P_thjkEA-1; Mon, 12 Dec 2022 12:43:34 -0500
X-MC-Unique: 3jRwGyAxN0ySz0P_thjkEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770BA85A5A6;
        Mon, 12 Dec 2022 17:43:34 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4291940C2004;
        Mon, 12 Dec 2022 17:43:34 +0000 (UTC)
Date:   Mon, 12 Dec 2022 11:43:32 -0600
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [GIT PULL] dlm updates for 6.2
Message-ID: <20221212174332.GA9261@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
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

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.2

These patches include the usual cleanups and minor fixes, removal of code
that is no longer needed due to recent improvements, and improvements to
processing large volumes of messages during heavy locking activity.

- Misc code cleanup.

- Fix a couple socket handling bugs: a double release on an error path
  and a data-ready race in an accept loop.

- Remove code for resending dir-remove messages. This code is no longer
  needed since the midcomms layer now ensures the messages are resent if
  needed.

- Add tracepoints for dlm messages.

- Improve callback queueing by replacing the fixed array with a list.

- Simplify the handling of a remove message followed by a lookup
  message by sending both without releasing a spinlock in between.

- Improve the concurrency of sending and receiving messages by holding
  locks for a shorter time, and changing how workqueues are used.

- Remove old code for shutting down sockets, which is no longer needed
  with the reliable connection handling that was recently added.

Thanks,
Dave

Alexander Aring (36):
      fs: dlm: fix sock release if listen fails
      fs: dlm: retry accept() until -EAGAIN or error returns
      fs: dlm: remove send repeat remove handling
      fs: dlm: use packet in dlm_mhandle
      fd: dlm: trace send/recv of dlm message and rcom
      fs: dlm: let dlm_add_cb queue work after resume only
      fs: dlm: use list_first_entry marco
      fs: dlm: convert ls_cb_mutex mutex to spinlock
      fs: dlm: use spin lock instead of mutex
      fs: dlm: move last cast bast time to function call
      fs: dlm: use a non-static queue for callbacks
      fs: dlm: allow different allocation context per _create_message
      fs: dlm: remove ls_remove_wait waitqueue
      fs: dlm: relax sending to allow receiving
      fs: dlm: catch dlm_add_member() error
      fs: dlm: fix log of lowcomms vs midcomms
      fs: dlm: use WARN_ON_ONCE() instead of WARN_ON()
      fs: dlm: avoid false-positive checker warning
      fs: dlm: drop lkb ref in bug case
      fs: dlm: ast do WARN_ON_ONCE() on hotpath
      fs: dlm: rename DLM_IFL_NEED_SCHED to DLM_IFL_CB_PENDING
      fs: dlm: rename seq to h_seq for msg tracing
      fs: dlm: add dst nodeid for msg tracing
      fs: dlm: add midcomms init/start functions
      fs: dlm: remove twice INIT_WORK
      fs: dlm: use list_first_entry_or_null
      fs: dlm: use listen sock as dlm running indicator
      fs: dlm: remove socket shutdown handling
      fs: dlm: cleanup listen sock handling
      fs: dlm: don't put dlm_local_addrs on heap
      fs: dlm: remove dlm_node_addrs lookup list
      fs: dlm: use sock2con without checking null
      fs: dlm: use saved sk_error_report()
      fs: dlm: don't init error value
      fs: dlm: parallelize lowcomms socket handling
      fs: dlm: fix building without lockdep

Paulo Miguel Almeida (1):
      dlm: replace one-element array with fixed size array


 fs/dlm/ast.c               |  322 ++++------
 fs/dlm/ast.h               |   17 +-
 fs/dlm/config.c            |    4 +-
 fs/dlm/debug_fs.c          |    2 +-
 fs/dlm/dlm_internal.h      |   25 +-
 fs/dlm/lock.c              |  190 ++----
 fs/dlm/lockspace.c         |   14 +-
 fs/dlm/lowcomms.c          | 1538 +++++++++++++++++++++-----------------------
 fs/dlm/lowcomms.h          |    6 +-
 fs/dlm/main.c              |    7 +-
 fs/dlm/member.c            |    5 +-
 fs/dlm/memory.c            |   30 +-
 fs/dlm/memory.h            |    4 +-
 fs/dlm/midcomms.c          |  141 +++-
 fs/dlm/midcomms.h          |    7 +-
 fs/dlm/rcom.c              |    4 +-
 fs/dlm/requestqueue.c      |    3 +-
 fs/dlm/user.c              |   74 ++-
 fs/dlm/user.h              |    2 +-
 include/trace/events/dlm.h |  303 +++++++++
 20 files changed, 1455 insertions(+), 1243 deletions(-)

