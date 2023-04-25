Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211D6EE4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjDYPlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjDYPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422F14F60
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682437193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KkWeKhTEaXp9JdQmO6LKpuT+4ZnqVRHShCUqBP7ryfw=;
        b=NX8lWo2NBwZQqayGdNNYAzJGqauuMh7EegeIK7gUwm6HXjAfy1xjjzbAOX+ZClHKXLu+dy
        AISZ3mutY1cdVhMNDNXHXuJEhrNdT382r3ll+dajMNGpv6zXNTzfup3UNiwtg6C5knnWz9
        mDI4lsit0bHXFr4s4U3v0vA3rp2cYZw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Ju-IZLc9OzmhCxSzWQE--w-1; Tue, 25 Apr 2023 11:39:52 -0400
X-MC-Unique: Ju-IZLc9OzmhCxSzWQE--w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A81FD1C041B5;
        Tue, 25 Apr 2023 15:39:51 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 701A9492B0F;
        Tue, 25 Apr 2023 15:39:51 +0000 (UTC)
Date:   Tue, 25 Apr 2023 10:39:51 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [GIT PULL] dlm updates for 6.4
Message-ID: <20230425153951.GB28392@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.4

Change summary:

Remove some unused features (related to lock timeouts) that have been
previously scheduled for removal.

Fix a bug where the pending callback flag would be incorrectly cleared,
which could potentially result in missing a completion callback.

Use an unbound workqueue for dlm socket handling so that socket
operations can be processed with less delay.

Fix possible lockspace join connection errors with large clusters (e.g.
over 16 nodes) caused by a small socket backlog setting.

Use atomic bit ops for internal flags to help avoid mistakes copying
flag values from messages.

Fix recently introduced bug where memory for lvb data could be
unnecessarily allocated for a lock.

Thanks,
Dave


Alexander Aring (11):
      fs: dlm: fix DLM_IFL_CB_PENDING gets overwritten
      fs: dlm: add unbound flag to dlm_io workqueue
      fs: dlm: remove deprecated code parts
      fs: dlm: rename stub to local message flag
      fs: dlm: remove DLM_IFL_LOCAL_MS flag
      fs: dlm: store lkb distributed flags into own value
      fs: dlm: change dflags to use atomic bits
      fs: dlm: move internal flags to atomic ops
      fs: dlm: rsb hash table flag value to atomic ops
      fs: dlm: switch lkb_sbflags to atomic ops
      fs: dlm: stop unnecessarily filling zero ms_extra bytes

Edwin Török (1):
      DLM: increase socket backlog to avoid hangs with 16 nodes


 fs/dlm/Kconfig                    |   9 -
 fs/dlm/Makefile                   |   1 -
 fs/dlm/ast.c                      |  11 +-
 fs/dlm/config.c                   |  21 --
 fs/dlm/config.h                   |   3 -
 fs/dlm/debug_fs.c                 |   8 +-
 fs/dlm/dlm_internal.h             | 154 +++++++----
 fs/dlm/lock.c                     | 533 ++++++++++++--------------------------
 fs/dlm/lock.h                     |  17 --
 fs/dlm/lockspace.c                |  29 +--
 fs/dlm/lowcomms.c                 |   6 +-
 fs/dlm/main.c                     |   9 +-
 fs/dlm/memory.c                   |   2 +-
 fs/dlm/netlink.c                  | 139 ----------
 fs/dlm/rcom.c                     |   2 +-
 fs/dlm/recover.c                  |   2 +-
 fs/dlm/recoverd.c                 |   2 -
 fs/dlm/user.c                     |  34 +--
 include/linux/dlm.h               |   3 -
 include/trace/events/dlm.h        |  12 +-
 include/uapi/linux/dlm.h          |   1 +
 include/uapi/linux/dlm_netlink.h  |  60 -----
 include/uapi/linux/dlmconstants.h |   5 +-
 23 files changed, 299 insertions(+), 764 deletions(-)
 delete mode 100644 fs/dlm/netlink.c
 delete mode 100644 include/uapi/linux/dlm_netlink.h

