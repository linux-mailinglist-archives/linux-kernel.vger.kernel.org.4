Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE16B2870
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCIPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjCIPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DDFFC231
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678374457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aSKPQLlT8s4GE5W+OX19xgVfR+OIkeMkbwlF9u85DuE=;
        b=IgQRTaGWCxIP94l5l1T/LkDbtjA3tXwloXOefX38TOONYYuGkXYzcBBoW/40J6Oed8r1h0
        zCLpYBUhBnzaJY9sn1yfg9MuQnO4zoxDAcUg4FVC0G+nTiICKDGaI0PhQKHHhGeBq3FDDq
        hwd7eBsObDz9iEe70+XFs35kQqdlUZc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-0jRa6kuvMNWofKtdGjGHkg-1; Thu, 09 Mar 2023 10:07:35 -0500
X-MC-Unique: 0jRa6kuvMNWofKtdGjGHkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 974D91C294E8;
        Thu,  9 Mar 2023 15:07:35 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.22.34.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F278540CF8ED;
        Thu,  9 Mar 2023 15:07:34 +0000 (UTC)
Date:   Thu, 9 Mar 2023 16:07:32 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <20230309150636.sdg5ifko7waqr6rh@mail.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023030901

to receive fixes for HID subsystem.

=====
- fix potential out of bound write of zeroes in HID core with a
  specially crafted uhid device (Lee Jones)
- fix potential use-after-free in work function in intel-ish-hid
  (Reka Norman)
- selftests config fixes (Benjamin Tissoires)
- few device small fixes and support
=====

Thanks.

----------------------------------------------------------------
Benjamin Tissoires (1):
      selftest: hid: fix hid_bpf not set in config

Danny Kaehn (1):
      HID: cp2112: Fix driver not registering GPIO IRQ chip as threaded

Lee Jones (2):
      HID: core: Provide new max_buffer_size attribute to over-ride the default
      HID: uhid: Over-ride the default maximum data buffer value with our own

Rafał Szalecki (1):
      HID: logitech-hidpp: Add support for Logitech MX Master 3S mouse

Reka Norman (1):
      HID: intel-ish-hid: ipc: Fix potential use-after-free in work function

 drivers/hid/hid-core.c              | 32 +++++++++++++++++++++++++-------
 drivers/hid/hid-cp2112.c            |  1 +
 drivers/hid/hid-logitech-hidpp.c    |  2 ++
 drivers/hid/intel-ish-hid/ipc/ipc.c |  9 ++++++++-
 drivers/hid/uhid.c                  |  1 +
 include/linux/hid.h                 |  3 +++
 tools/testing/selftests/hid/config  |  1 +
 7 files changed, 41 insertions(+), 8 deletions(-)

