Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA0690BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjBIOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjBIOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D63B113DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675953118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=swge4i7KL+pDg4pL1SUEAvukE1flG2TcLVBvEbPpHQk=;
        b=B00D4O0NyLkhchKzm9iEGly011+HTKDImDVN8zZ1XorWMl29OyQwiCgTY0wUnOvdhCg16d
        Ya1LKcpwSaoZK4MDJ7obbEXNoqAaERlLeYeKAOzu0TMD0yY4ePAFrU4cJKMXUHnzqkZjzp
        0zw2eVsjczo37bnwqjTc9BQ7zVvA9dM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-3Usj4CSvNCeDTqLc5JjMEw-1; Thu, 09 Feb 2023 09:31:50 -0500
X-MC-Unique: 3Usj4CSvNCeDTqLc5JjMEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CCDA885622;
        Thu,  9 Feb 2023 14:31:43 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B41BD40C83B6;
        Thu,  9 Feb 2023 14:31:41 +0000 (UTC)
Date:   Thu, 9 Feb 2023 15:31:35 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <20230209143135.a75h6fcbpjzfca4s@mail.corp.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023020901

to receive fixes for HID subsystem.

=====
- fix potential deadloop with a badly crafted HID device (Xin Zhao)
- fix regression from 6.1 in USB logitech devices potentially making
  their mouse wheel not working (Bastien Nocera)
- clean up in AMD sensors, which fixes a long time resume bug (Mario
  Limonciello)
- few device small fixes and quirks
=====

Note, there is nothing really that urgent but I still think those fixes
would be best in 6.2 final.

Thanks.

----------------------------------------------------------------
Bastien Nocera (1):
      HID: logitech: Disable hi-res scrolling on USB

Luka Guzenko (1):
      HID: Ignore battery for ELAN touchscreen 29DF on HP

Mario Limonciello (1):
      HID: amd_sfh: if no sensors are enabled, clean up

Takahiro Fujii (1):
      HID: elecom: add support for TrackBall 056E:011C

Xin Zhao (1):
      HID: core: Fix deadloop in hid_apply_multiplier.

marco.rodolfi@tuta.io (1):
      HID: Ignore battery for Elan touchscreen on Asus TP420IA

 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 13 +++++++++++--
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  1 +
 drivers/hid/hid-core.c                   |  3 +++
 drivers/hid/hid-elecom.c                 | 16 ++++++++++++++--
 drivers/hid/hid-ids.h                    |  5 ++++-
 drivers/hid/hid-input.c                  |  4 ++++
 drivers/hid/hid-logitech-hidpp.c         |  3 ++-
 drivers/hid/hid-quirks.c                 |  3 ++-
 8 files changed, 41 insertions(+), 7 deletions(-)

