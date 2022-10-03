Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BDB5F3597
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJCS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EA27CFF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664821555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SUAwHqNFIaOPUYLVsPm7VMv/dvKWOFoch7fT0q85EK8=;
        b=Zf/ZkpKqXBkUBHdPd4ZM/cfaE4Kry1OJ5Ph+/T1zFqZ+jVYP9sjUWZmGcHCe41oKTtp/XK
        tKL4Pn7K1dLFE4IDmHAqIDM5ti8Z1iOTQXgB2mMSTDS9r7mlOx2zHARriVJD3R8krE2gQ1
        GF3AtB5Bu7HU5JSQRbMvaiK78CYc0Rs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-wIUmzeEfPgG8fir8tv5XKQ-1; Mon, 03 Oct 2022 14:25:54 -0400
X-MC-Unique: wIUmzeEfPgG8fir8tv5XKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C2A7101A528;
        Mon,  3 Oct 2022 18:25:54 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5FCE2166B26;
        Mon,  3 Oct 2022 18:25:53 +0000 (UTC)
Date:   Mon, 3 Oct 2022 13:25:52 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [GIT PULL] dlm updates for 6.1
Message-ID: <20221003182552.GA7517@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.1

This set of commits includes:
. Fix a couple races found with a new torture test.
. Improve errors when api functions are used incorrectly.
. Improve tracing for lock requests from user space.
. Fix use after free in recently added tracing code.
. Small internal code cleanups.

Thanks,
Dave

Alexander Aring (16):
      fs: dlm: fix race in lowcomms
      fs: dlm: fix race between test_bit() and queue_work()
      fs: dlm: handle -EBUSY first in lock arg validation
      fs: dlm: handle -EBUSY first in unlock validation
      fs: dlm: use __func__ for function name
      fs: dlm: handle -EINVAL as log_error()
      fs: dlm: fix invalid derefence of sb_lvbptr
      fs: dlm: allow lockspaces have zero lvblen
      fs: dlm: handle rcom in else if branch
      fs: dlm: remove dlm_del_ast prototype
      fs: dlm: change ls_clear_proc_locks to spinlock
      fs: dlm: trace user space callbacks
      fs: dlm: remove DLM_LSFL_FS from uapi
      fs: dlm: LSFL_CB_DELAY only for kernel lockspaces
      fs: dlm: const void resource name parameter
      fs: dlm: fix possible use after free if tracing

 drivers/md/md-cluster.c    |   4 +-
 fs/dlm/ast.c               |  15 ++--
 fs/dlm/ast.h               |   1 -
 fs/dlm/dlm_internal.h      |   2 +-
 fs/dlm/lock.c              | 167 +++++++++++++++++++++++++++++----------------
 fs/dlm/lock.h              |   2 +-
 fs/dlm/lockspace.c         |  32 +++++++--
 fs/dlm/lockspace.h         |  13 ++++
 fs/dlm/lowcomms.c          |   4 ++
 fs/dlm/user.c              |  17 +++--
 fs/gfs2/lock_dlm.c         |   2 +-
 fs/ocfs2/stack_user.c      |   2 +-
 include/linux/dlm.h        |   5 +-
 include/trace/events/dlm.h |  26 +++----
 include/uapi/linux/dlm.h   |   1 -
 15 files changed, 193 insertions(+), 100 deletions(-)

