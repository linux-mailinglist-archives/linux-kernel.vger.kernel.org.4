Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9B6287F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiKNSLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiKNSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:11:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E75240A6;
        Mon, 14 Nov 2022 10:11:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E0CA6133B;
        Mon, 14 Nov 2022 18:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3062AC433C1;
        Mon, 14 Nov 2022 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668449485;
        bh=1O3d3xi2O06KTDEL1vSpCTxtSRQrEwJVWfeHpaw65G4=;
        h=From:To:Cc:Subject:Date:From;
        b=tNYkD3bEge7K6tj0u/fZO9pe+rGrKt4mYoy00W49CswaA8MfYhwkmrlIEa+I9WU3e
         njE4awseOvm3/o7ME1+KNvBXo4xwWNQqYhMk1z+BZhn0RLSOZKYVrfZkP4btxDq56B
         xx7wL32CIEQsKGwMFehuHbTX6edV7Yemdvtj7gLG+pQxW03DzUgwZd4gekNc0NEfWP
         m0SPhH6hJr9OlZJ+0u4qzf9bWqYO48zCqfazFNTPPYsMmj4obTxvkYSP61LEuevfjy
         Fk2AL8+Tn+IEG1I4tre+A2vWGpNu3mfAnxyJahXDT137LNThfMq4kWo7wq80/Bv8pc
         HoXijyjdgFnyQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/jobserver-exec: parse the last --jobserver-auth= option
Date:   Tue, 15 Nov 2022 03:10:55 +0900
Message-Id: <20221114181055.214948-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

In the GNU Make manual, the section "Sharing Job Slots with GNU make"
says:

    Be aware that the MAKEFLAGS variable may contain multiple instances
    of the --jobserver-auth= option. Only the last instance is relevant.

Take the last element of the array, not the first.

Link: https://www.gnu.org/software/make/manual/html_node/Job-Slots.html
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/jobserver-exec | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index 8762887a970c..4192855f5b8b 100755
--- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -23,7 +23,9 @@ try:
 	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
 
 	# Parse out R,W file descriptor numbers and set them nonblocking.
-	fds = opts[0].split("=", 1)[1]
+	# If the MAKEFLAGS variable contains multiple instances of the
+	# --jobserver-auth= option, the last one is relevant.
+	fds = opts[-1].split("=", 1)[1]
 	reader, writer = [int(x) for x in fds.split(",", 1)]
 	# Open a private copy of reader to avoid setting nonblocking
 	# on an unexpecting process with the same reader fd.
-- 
2.34.1

