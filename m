Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B128566478A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjAJRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjAJRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:39:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E54FCF0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF6FB818D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A62C433D2;
        Tue, 10 Jan 2023 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673372349;
        bh=fVbWj6YLRSkJNZj3HTC/oMvrf740tLn14oRvUXjPA/c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p72UFyuadObhqTyjEw3gfUDruMRKKvzNAqe4wVKUj7NXgkHnbe2gtZPtTa8qRiPsg
         5YtbCWOmLpT2f+3kJkCpmtJgN49eS2uQS3q5T3a2t0SW+uHAVkuDJlH2smRysmKCVR
         hOG0wsf24OhQLrBmJzVE1JrBnfheFS6HcM/jyc3JY1KfaN7fLJlbmE7L/xUt+gK/Hv
         biAZxEGY9hWoW1dFI0DNKnUHia9yk/aqNm4kogiwyi55x+bZ1p6iKFNjDPA3qsk5fM
         XrBR0YyEPlWdESqi7F7FqRUt1wlugH9Zo82Mrh3yS5G7/OFzDT+swZWkNh3zePiDzE
         PWA6lVR0V4iZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1294F5C0687; Tue, 10 Jan 2023 09:39:09 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:39:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] tools: rcu: Added check for argument and usage
 function
Message-ID: <20230110173909.GQ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230110111634.26371-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110111634.26371-1-unixbhaskar@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 04:46:34PM +0530, Bhaskar Chowdhury wrote:
> Thought it would be good to have some formatted way of letting user know
> about, how to use this script properly and added some checking too for missing
> argument.
> 
> 
> cc: paulmck@kernel.org
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Good point on making a usage() function that stands in for the header
comment, thank you!  I tweaked this a bit as shown below, so please
check to see if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit f4e5cfbdfe900a41375d68b6c83e438ecc519b7b
Author: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date:   Tue Jan 10 16:46:34 2023 +0530

    tools: rcu: Add usage function and check for argument
    
    This commit converts extract-stall.sh script's header comment to a
    usage() function, and adds an argument check.  While in the area, make
    this script be executable.
    
    [ paulmck: Strength argument check, remove extraneous comment. ]
    
    Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/rcu/extract-stall.sh b/tools/rcu/extract-stall.sh
old mode 100644
new mode 100755
index e565697c9f90e..08a39ad44320d
--- a/tools/rcu/extract-stall.sh
+++ b/tools/rcu/extract-stall.sh
@@ -1,11 +1,25 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
-#
-# Extract any RCU CPU stall warnings present in specified file.
-# Filter out clocksource lines.  Note that preceding-lines excludes the
-# initial line of the stall warning but trailing-lines includes it.
-#
-# Usage: extract-stall.sh dmesg-file [ preceding-lines [ trailing-lines ] ]
+
+usage() {
+	echo Extract any RCU CPU stall warnings present in specified file.
+	echo Filter out clocksource lines.  Note that preceding-lines excludes the
+	echo initial line of the stall warning but trailing-lines includes it.
+	echo
+	echo Usage: $(basename $0) dmesg-file [ preceding-lines [ trailing-lines ] ]
+	echo
+	echo Error: $1
+}
+
+# Terminate the script, if the argument is missing
+
+if test -f "$1" && test -r "$1"
+then
+	:
+else
+	usage "Console log file \"$1\" missing or unreadable."
+	exit 1
+fi
 
 echo $1
 preceding_lines="${2-3}"
