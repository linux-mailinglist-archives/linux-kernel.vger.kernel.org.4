Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE886D2FA2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDAKKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 06:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05A1D2DC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 03:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2B760C27
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 10:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D188BC433D2;
        Sat,  1 Apr 2023 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680343813;
        bh=EB/7TtVadKu5smsVxqKVB6j7j2tQkpgO1huzAziIWDU=;
        h=From:To:Cc:Subject:Date:From;
        b=hNXafzFTWULt/Ty8xC2WGqFMb/0ymfXveC+Q1EOHHo8Ikv8eTA2LxIxM0x7jHcRYR
         8CjDKl0VaDvjqS/PM9pT/8UenqxgYSjPKij5GKvaR0PMdYp1MhcYnJLhBUGhqbE9/h
         PpdCBAc3YC724AfePNLv6XhZb46fDJcB0ra4Ws3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com
Subject: [PATCH] driver core: class : fix slab-use-after-free Read in class_register()
Date:   Sat,  1 Apr 2023 12:09:26 +0200
Message-Id: <2023040126-blandness-duckling-bd55@gregkh>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=EB/7TtVadKu5smsVxqKVB6j7j2tQkpgO1huzAziIWDU=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkaTFcr7n3/XKpXmlUd+9Z058+szEDFM4vsBGQXpHu5V r4NrHncEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABOxCGeYZ3lxaf2WlT0+vLoX Fury3z/ycsrJAoY5PKv7nP9nrXY5HWJw+c2ln4dCwtu/AgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot found that we had forgotten to unregister the lock_class_key when
using it in commit dcfbb67e48a2 ("driver core: class: use lock_class_key
already present in struct subsys_private") so fix that up and correctly
release it when done.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reported-and-tested-by: <syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com>
Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 2991936c80db..ac1808d1a2e8 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -103,6 +103,7 @@ static void class_release(struct kobject *kobj)
 		pr_debug("class '%s' does not have a release() function, "
 			 "be careful\n", class->name);
 
+	lockdep_unregister_key(&cp->lock_key);
 	kfree(cp);
 }
 
-- 
2.40.0

