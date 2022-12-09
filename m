Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D06648729
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLIRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLIRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:16 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F911444;
        Fri,  9 Dec 2022 09:02:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id AD349141E6D;
        Fri,  9 Dec 2022 17:02:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 18E8C141267;
        Fri,  9 Dec 2022 17:02:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670605331; a=rsa-sha256;
        cv=none;
        b=tVqE5WrNVjVFV+nhNoS84oRKeFqrSQ6WSO2ypJa3RcAr9oimm/KS2j+vp77WMNl9Fvt2ov
        WsSOIXLcLf2HAd1mIvsk2sy3+65XCpkxiHplq7jA46M0xPtONrSjIjHH4kEHhH/N5/au3i
        P+FgBBlDPpx+GMIbCwDJbOYLRlAdVHs+di27upxX3CK1jAgc695onaSWTb+ggVLaAKYeUE
        fNv9tuH95nGaEUFyZm/Chv7+ZuEwY13DpqoC7E440glneZMZx/21NMsnynqgyT/SSJs8h1
        OHHHZVcXW/YEAD5/BoLbn8+DFn/TlScnJnEfFyZBphudHTpeDnRIwo/dfVrknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670605331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=DG5GAQ8yayHmOkr7bY1BCADokHTCYP5QmcAa4twXErg=;
        b=waQjqjQmQAKEiBxYsM80PcJyB/mt174u7wTzVRb19Yy6ibdzYXUDXLS24QsYrHYfD0BSAw
        Y+W+Bsaf+uOQ1yATeKTdn94n6/n/Sshb7TnZR7g+IBcc9CzWn/q58oSOUSDg/xXWQfT6PT
        FiY3xDNK70vpvhVkf/BD6u66V2ERaQTCEGby2ZPTx3XbrrvY1wbKp5HGAcxLjJHuUx1X+x
        jttY5XGuqsGnmLw/AHvxj76VSfX5Vjrl1+Fr0gQmzP+tdKbnP4ssyqq2bTR1tDib88Tjmr
        WsfcuwJXD8JuNwXUcVQ6FZi8kaJvJTObYXLApf5ABbqPy0HlVtkb1KRMqqYz/w==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-s7kkk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Print: 0507084671630208_1670605331418_3244582274
X-MC-Loop-Signature: 1670605331418:2434797532
X-MC-Ingress-Time: 1670605331418
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.16 (trex/6.7.1);
        Fri, 09 Dec 2022 17:02:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4NTHPZ2rP3z7M;
        Fri,  9 Dec 2022 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670605330;
        bh=DG5GAQ8yayHmOkr7bY1BCADokHTCYP5QmcAa4twXErg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HS/CtV8WrndgCk+xbrtb1WTS2zAZmnvL4z2EVikcT8JsHwDA8Rwstvp5Wm8ItfwVR
         J4vGBLd55QBjSHdEmqet2th24zrHYq44VNW8u9v8aIXL1XFYhCEtz4efd6tdQJx3HF
         spP3df5s2Lns5jRaOsAOa/UEID0s/4SQe26rKtfF+0G72reeh5mqBulK+7uKcvMOWE
         6e2h4vCnDM1q2TGiVqR+vm/mmdd3VKpH3YyKm9xb4f57FKMcIZMrjLwVT9Qlyriy/c
         qrpA1wZQgKbOQMQc9EHvHIijYQDPs4J60e59lvTpqmwAmpsx5MSUp77rPYJ8dJZNai
         PRbUbE8cK6uzw==
Date:   Fri, 9 Dec 2022 08:37:59 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: Re: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
Message-ID: <20221209163759.6s7pqf5wdvy32ywn@offworld>
References: <20221209022305.321149-1-joel@joelfernandes.org>
 <20221209022305.321149-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221209022305.321149-2-joel@joelfernandes.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022, Joel Fernandes (Google) wrote:

>The rt boosting in locktorture has a factor variable s currently large enough
>that boosting only happens once every minute or so. Add a tunable to reduce the
>factor so that boosting happens more often, to test paths and arrive at failure
>modes earlier. With this change, I can set the factor to like 50 and have the
>boosting happens every 10 seconds or so.
>
>Tested with boot parameters:
>locktorture.torture_type=mutex_lock
>locktorture.onoff_interval=1
>locktorture.nwriters_stress=8
>locktorture.stutter=0
>locktorture.rt_boost=1
>locktorture.rt_boost_factor=50
>locktorture.nlocks=3
>
>Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> kernel/locking/locktorture.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>index 8968fd65a90d..b64a528e511c 100644
>--- a/kernel/locking/locktorture.c
>+++ b/kernel/locking/locktorture.c
>@@ -48,6 +48,7 @@ torture_param(int, stat_interval, 60,
> torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> torture_param(int, rt_boost, 2,
> 		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
>+torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
> torture_param(int, verbose, 1,
> 	     "Enable verbose debugging printk()s");
> torture_param(int, nlocks, 1,
>@@ -133,12 +134,12 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
>
> static void __torture_rt_boost(struct torture_random_state *trsp)
> {
>-	const unsigned int factor = 50000; /* yes, quite arbitrary */
>+	const unsigned int factor = rt_boost_factor;
>
> 	if (!rt_task(current)) {
> 		/*
>-		 * Boost priority once every ~50k operations. When the
>-		 * task tries to take the lock, the rtmutex it will account
>+		 * Boost priority once every rt_boost_factor operations. When
>+		 * the task tries to take the lock, the rtmutex it will account

Nit: maybe refer to it as 'rt_boost_factor'?

> 		 * for the new priority, and do any corresponding pi-dance.
> 		 */
> 		if (trsp && !(torture_random(trsp) %
>@@ -148,8 +149,9 @@ static void __torture_rt_boost(struct torture_random_state *trsp)
> 			return;
> 	} else {
> 		/*
>-		 * The task will remain boosted for another ~500k operations,
>-		 * then restored back to its original prio, and so forth.
>+		 * The task will remain boosted for another 10*rt_boost_factor
>+		 * operations, then restored back to its original prio, and so
>+		 * forth.
> 		 *
> 		 * When @trsp is nil, we want to force-reset the task for
> 		 * stopping the kthread.
>-- 
>2.39.0.rc1.256.g54fd8350bd-goog
>
