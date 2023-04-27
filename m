Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0716F01E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbjD0HiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbjD0HiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:38:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41404E4C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:38:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87AF6210EB;
        Thu, 27 Apr 2023 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682581089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Nr7EqN4AM70YmyuoNpfe+PXcas5rhy8+HTE3yW76PeE=;
        b=tcZ3SDL3frCSTs9kfNRn1gulCF03JIxBOSfdNvNV9pmuqasP8RcnwLNU4Ie+SqChQjpt7/
        1Z+9CNH5MFYuoHvtQlPqBtJX+0qA5UWFIZra1y5H4dRnltRWbQI1r6acOVSrfMlYWFg5Oc
        4Cs97+s6ZUGnpWyGL058ZE+gnbn8Atc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F75C13910;
        Thu, 27 Apr 2023 07:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ChnZFWEmSmS1LgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 27 Apr 2023 07:38:09 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.4-rc1
Date:   Thu, 27 Apr 2023 09:38:08 +0200
Message-Id: <20230427073808.12580-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.4-rc1-tag

xen: branch for v6.4-rc1

It contains the following changes:

- a 4 patch series doing some cleanups in the Xen blkback driver
- 3 patches fixing potential sleeps under lock in various Xen drivers 

Thanks.

Juergen

 drivers/block/xen-blkback/blkback.c | 126 ++++++++++++++++++++++++++++++++----
 drivers/block/xen-blkback/common.h  | 103 +----------------------------
 drivers/xen/pvcalls-front.c         |  46 +++++++------
 drivers/xen/xen-pciback/pci_stub.c  |   6 +-
 drivers/xen/xen-scsiback.c          |  27 ++++----
 5 files changed, 160 insertions(+), 148 deletions(-)

Juergen Gross (8):
      xen/pciback: don't call pcistub_device_put() under lock
      xen/scsiback: don't call scsiback_free_translation_entry() under lock
      xen/pvcalls: don't call bind_evtchn_to_irqhandler() under lock
      xen/blkback: fix white space code style issues
      xen/blkback: remove stale prototype
      xen/blkback: simplify free_persistent_gnts() interface
      xen/blkback: move blkif_get_x86_*_req() into blkback.c
