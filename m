Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4865F321
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjAERtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjAERt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:49:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B550051;
        Thu,  5 Jan 2023 09:49:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06A761AC9;
        Thu,  5 Jan 2023 17:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51771C433D2;
        Thu,  5 Jan 2023 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672940965;
        bh=5TSkYg+2VQLbcORpvH9lpgB7lm5DQeZfI2Us2iHw7U0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KKHkVHlPfkdfeDtxEPgHKmZaAhRHO5pyEBeWnCwqwjnGfSdD/VyOBQfT9HKNRQFod
         NSEOKGbdBdIkb7DDZvYr85k7NQfSi/FiKu8iCqhGsAuGD3dT/9Vx3Jig38OxEHjzQX
         YEz+53lE1s2+ijrmOnH5zRjV9D101DTPuauA2Ytn+nUAY+ahy1KtgUzfMebLhOP5l4
         PCCZpiIt92olf/cxg1lRY2SMZOLocdgcwG3ub3Y02aUR0MNSWCKESkhhzur0kPZsjR
         PdQbgCbE3kpDIF+yrNoJwWkDV3jyYwymfF588hkRiDi7Dv3xMCtdo0SlZyMBvFxyPy
         e6FkF8wqUr4kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA8B45C0544; Thu,  5 Jan 2023 09:49:24 -0800 (PST)
Date:   Thu, 5 Jan 2023 09:49:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] rcu/trace: use strscpy() to instead of
 strncpy()
Message-ID: <20230105174924.GD4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202301052017571305723@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301052017571305723@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 08:17:57PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Queued for testing and additional review, thank you!

Please see below for the traditional wordsmithing and please let me
know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 4034fe140e75d6e51b72d1fd16805e053b9b633c
Author: Xu Panda <xu.panda@zte.com.cn>
Date:   Thu Jan 5 20:17:57 2023 +0800

    rcu/trace: use strscpy() to instead of strncpy()
    
    This commit saves a line of code by switching from strncpy() to strscpy()
    by permitting the later NUL assignment to be removed.  While in the area,
    save another line by taking advantage of 100 characters.
    
    Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
    Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 90b2fb0292cb1..c19ac1fa8a607 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -776,9 +776,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->rcutorturename, rcutorturename,
-			RCUTORTURENAME_LEN);
-		__entry->rcutorturename[RCUTORTURENAME_LEN - 1] = 0;
+		strscpy(__entry->rcutorturename, rcutorturename, RCUTORTURENAME_LEN);
 		__entry->rhp = rhp;
 		__entry->secs = secs;
 		__entry->c_old = c_old;
