Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB886736A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjASLT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjASLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:19:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EB74953;
        Thu, 19 Jan 2023 03:19:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 280E5CE217F;
        Thu, 19 Jan 2023 11:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD3FC433EF;
        Thu, 19 Jan 2023 11:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674127137;
        bh=k7CU2HB3Zq3GwkrhL4hgCIf1xnt5P/L87WE1cx9PEs8=;
        h=From:To:Cc:Subject:Date:From;
        b=CU7YjvjkWxr6ecU4lAy5Yq1cn3rkdKDVSFTCIvosoGGjyQ7DiU8D131pK2ix9Lhb1
         hi8UMmizkcDpgTW6w2AwBrTrvSMnBVNhGAE7IdbIRGxqdUh6UrdQiBkpszoYkRDRU8
         4lj6ysdHWHjtf2sBXrUJFiUlZtDTtaLvBq0P/E89cG/sDDlEqXyEmME09qQM/v9Luy
         8lDTc6fngsl2XvOiUllY+M4hLZxQd/sstZUqmIIa4YZ5WtfKGWk/0IhPvh7sbDZDN9
         lg1RL+BenEKZpGUFU9P4aKIaIrcIbEhjtOxE8QVmZRdiR1C7EkFX5/JVDaFgnBjTwb
         KDlok7GstZ6jg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <sprasad@microsoft.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Tom Talpey <tom@talpey.com>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: fix debug format string in cifs_debug_data_proc_show
Date:   Thu, 19 Jan 2023 12:18:43 +0100
Message-Id: <20230119111853.596560-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Printing a size_t as %lu causes a warning on some architectures:

fs/cifs/cifs_debug.c: In function 'cifs_debug_data_proc_show':
fs/cifs/cifs_debug.c:478:75: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
  478 |                                 seq_printf(m, "\t\tWeight (cur,total): (%lu,%lu)"

Use the correct %zu format string instead.

Fixes: 962a0fd04791 ("cifs: distribute channels across interfaces based on speed")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/cifs/cifs_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index f5f07019fc7e..2e644d926e62 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -475,7 +475,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				cifs_dump_iface(m, iface);
 
 				iface_weight = iface->speed / iface_min_speed;
-				seq_printf(m, "\t\tWeight (cur,total): (%lu,%lu)"
+				seq_printf(m, "\t\tWeight (cur,total): (%zu,%zu)"
 					   "\n\t\tAllocated channels: %u\n",
 					   iface->weight_fulfilled,
 					   iface_weight,
-- 
2.39.0

