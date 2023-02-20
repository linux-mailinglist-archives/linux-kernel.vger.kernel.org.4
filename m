Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03669D2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjBTShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBTSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77401B308
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676918175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+BQMVtEdSqE57prMMKR11VCTUBB3gnlcS/QDAiHyCC0=;
        b=Fx78a5M2pw49+1KvnA0pTeUieRdb8KSP5IXJR63fVO3+S/ILVww/TQdAy2y0rfKp7g22lL
        JFBdlZtL6AbFFmMvzP0T87RX5rImnrJ6uJAv9jDncJfRezX3hHCIb5fnfhVXEne4AFd2++
        EDXzdBorpxrVvILxbRaiIozR0NGLfa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-eSXRd3SpOjKEy2jBZo6Jtg-1; Mon, 20 Feb 2023 13:36:13 -0500
X-MC-Unique: eSXRd3SpOjKEy2jBZo6Jtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76A41185A794;
        Mon, 20 Feb 2023 18:36:13 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F79240B40E4;
        Mon, 20 Feb 2023 18:36:13 +0000 (UTC)
Date:   Mon, 20 Feb 2023 12:36:11 -0600
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [GIT PULL] dlm updates for 6.3
Message-ID: <20230220183611.GA11414@redhat.com>
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

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.3

This patch set fixes some races in the lowcomms startup and shutdown code
that were found by targetted stress testing that quickly and repeatedly
joins and leaves lockspaces.

Thanks,
Dave

Alexander Aring (15):
      fs: dlm: start midcomms before scand
      fs: dlm: fix use after free in midcomms commit
      fs: dlm: be sure to call dlm_send_queue_flush()
      fs: dlm: fix race setting stop tx flag
      fs: dlm: don't set stop rx flag after node reset
      fs: dlm: move sending fin message into state change handling
      fs: dlm: send FIN ack back in right cases
      fs: dlm: bring back previous shutdown handling
      fs: dlm: ignore unexpected non dlm opts msgs
      fs: dlm: wait until all midcomms nodes detect version
      fs: dlm: make dlm sequence id more robust
      fs: dlm: reduce the shutdown timeout to 5 secs
      fs: dlm: remove newline in log_print
      fs: dlm: move state change into else branch
      fs: dlm: remove unnecessary waker_up() calls

Paul E. McKenney (1):
      fs/dlm: Remove "select SRCU"

Yang Yingliang (1):
      fs: dlm: fix return value check in dlm_memory_init()


 fs/dlm/Kconfig     |   1 -
 fs/dlm/lockspace.c |  21 +++++----
 fs/dlm/lowcomms.c  |  77 ++++++++++++++++++++++---------
 fs/dlm/memory.c    |   2 +-
 fs/dlm/midcomms.c  | 131 +++++++++++++++++++++++++++--------------------------
 fs/dlm/midcomms.h  |   1 +
 6 files changed, 136 insertions(+), 97 deletions(-)

