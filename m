Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098ED67A6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjAXXRF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Jan 2023 18:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjAXXRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:17:03 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A694F341
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:17:01 -0800 (PST)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 7C346AB323;
        Tue, 24 Jan 2023 23:17:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 197112000D;
        Tue, 24 Jan 2023 23:16:56 +0000 (UTC)
Message-ID: <36069dac5d07509dab1c7f1238f8cbb08db80ac6.camel@perches.com>
Subject: [PATCH] checkpatch: Improve EMBEDDED_FILENAME test
From:   Joe Perches <joe@perches.com>
To:     Heinz Mauelshagen <heinzm@redhat.com>,
        "apw@canonical.com" <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 24 Jan 2023 15:16:55 -0800
In-Reply-To: <CAM23VxrnywdK2BW9MurPqa9bAmzeM42oUtH=LFdabgvjrP-hrw@mail.gmail.com>
References: <CAM23VxrnywdK2BW9MurPqa9bAmzeM42oUtH=LFdabgvjrP-hrw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 197112000D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 4i5n3hg93edqeco6xjbitqofqjzdgpmf
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ElIneKqzk8BOiFcZlPbCWae08MyF3kNs=
X-HE-Tag: 1674602216-665982
X-HE-Meta: U2FsdGVkX1+h9CH2AcKFseB6jVNxUVyOQh/SZL70vg9OIdXIq29f/2LBbTHQRBbO+zLFyAbwXNNyXQgVOkMFuw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Privately, Heinz Mauelshagen showed that the embedded filename test
is not specific enough.

> WARNING: It's generally not useful to have the filename in the file
> #113: FILE: errors.c:113:
> +            block < registered_errors.blocks + registered_errors.count;

Extend the test to use the appropriate word boundary tests.

Reported-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Joe Perches <joe@perches.com>
---

Heinz, next time please make sure to CC linux-kernel@vger.kernel.org

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a6d6d7e1d0cf1..40102bc0ce535 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3727,7 +3727,7 @@ sub process {
 		}
 
 # check for embedded filenames
-		if ($rawline =~ /^\+.*\Q$realfile\E/) {
+		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
 			WARN("EMBEDDED_FILENAME",
 			     "It's generally not useful to have the filename in the file\n" . $herecurr);
 		}

