Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1CD742E18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjF2UEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjF2UEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16D3AB1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688068949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4dDgyzZLkY2/8iXhAmRttHNZmuwZzxKf8DyRqRDsvIs=;
        b=ivTVNjWOT/tvrh/3moBGlBGUdlhz52YgOcxSvQubT9SKtiEfG81OEgW6i3iXydlfBqamuG
        lbVw2eOk072EGiJR5oX3XAcb7Y5OoeG155VybXuoKx9KyH4bldEcQdYcM2/lUsuzymVaJF
        ZSC9Vs6Myz6dTp/EFlzzsPnr6j4eHgo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-kTu_riKmMzW_abOJcKEdiA-1; Thu, 29 Jun 2023 16:02:25 -0400
X-MC-Unique: kTu_riKmMzW_abOJcKEdiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93CA31C06ED8;
        Thu, 29 Jun 2023 20:02:24 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 590D7F5CE5;
        Thu, 29 Jun 2023 20:02:24 +0000 (UTC)
Date:   Thu, 29 Jun 2023 15:02:23 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [GIT PULL] dlm updates for 6.5
Message-ID: <20230629200223.GC14388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.5

The dlm posix lock handling (for gfs2) has three notable changes:

- Local pids returned from GETLK are no longer negated.  A previous
  patch negating remote pids mistakenly changed local pids also.

- SETLKW operations can now be interrupted only when the process is
  killed, and not from other signals.  General interruption was
  resulting in previously acquired locks being cleared, not just
  the in-progress lock.  Handling this correctly will require
  extending a cancel capability to user space (a future feature.)

- If multiple threads are requesting posix locks (with SETLKW),
  fix incorrect matching of results to the requests.

The dlm networking has several minor cleanups, and one notable change:

- Avoid delaying ack messages for too long (used for message reliability),
  resulting in a backlog of un-acked messages.  These could previously
  be delayed as a result of either too many or too few other messages
  being sent.  Now an upper and lower threshold is used to determine
  when an ack should be sent.

Thanks,
Dave


Alexander Aring (18):
      fs: dlm: return positive pid value for F_GETLK
      fs: dlm: fix cleanup pending ops when interrupted
      fs: dlm: interrupt posix locks only when process is killed
      fs: dlm: make F_SETLK use unkillable wait_event
      fs: dlm: fix mismatch of plock results from userspace
      fs: dlm: revert check required context while close
      fs: dlm: clear pending bit when queue was empty
      fs: dlm: fix missing pending to false
      fs: dlm: unregister memory at the very last
      fs: dlm: don't check othercon twice
      fs: dlm: cleanup STOP_IO bitflag set when stop io
      fs: dlm: move dlm_purge_lkb_callbacks to user module
      fs: dlm: warn about messages from left nodes
      fs: dlm: filter ourself midcomms calls
      fs: dlm: handle lkb wait count as atomic_t
      fs: dlm: handle sequence numbers as atomic
      fs: dlm: add send ack threshold and append acks to msgs
      fs: dlm: remove filter local comms on close

Azeem Shaikh (1):
      dlm: Replace all non-returning strlcpy with strscpy


 fs/dlm/ast.c          |  25 ++--------
 fs/dlm/ast.h          |   1 -
 fs/dlm/config.c       |   4 +-
 fs/dlm/dlm_internal.h |   2 +-
 fs/dlm/lock.c         |  36 +++++++--------
 fs/dlm/lockspace.c    |  12 -----
 fs/dlm/lockspace.h    |   1 -
 fs/dlm/lowcomms.c     |  49 +++-----------------
 fs/dlm/main.c         |   2 +-
 fs/dlm/member.c       |  37 ++++++++++++---
 fs/dlm/midcomms.c     | 126 ++++++++++++++++++++++----------------------------
 fs/dlm/plock.c        | 115 +++++++++++++++++++++++++++------------------
 fs/dlm/user.c         |  18 ++++++++
 fs/dlm/user.h         |   1 +
 14 files changed, 205 insertions(+), 224 deletions(-)

