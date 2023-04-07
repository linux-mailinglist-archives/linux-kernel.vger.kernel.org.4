Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A556DB20B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDGRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:50:20 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57171E55;
        Fri,  7 Apr 2023 10:50:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A452D642819;
        Fri,  7 Apr 2023 17:50:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D0719642887;
        Fri,  7 Apr 2023 17:50:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680889817; a=rsa-sha256;
        cv=none;
        b=TIbVxD5clnbRC5sek/1Y6JVMCwvjldE7zJ5JXvkErmkxZ5spzniOBeaq15Clq/mrQiiyYN
        n2lqo/kQkSyln3sagMFmv7H1egerBwIll4T7vGyUYZrFy1e6HOoxSwyA7IoAX1oon4aaLb
        H4lBe8RWXfrLL9/8BvYV+N85B94zycBYg0UnQGaHzOAAMzVhqDimvReWj0eq6wE0ay638z
        Zcz7OhjkkKTADKq/aT/zBhKy5pRTstItXb4gXEXIWW97lwU+niFyKjXOX9n2Ez0BTzdpg8
        tET7CkWpgNLz3zFNUzHzvhJ+ZgxqYPezbDg65K5sQhdOBiTVj7f/+2bhCHD+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680889817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Mu9kZlt0sY3Iz7fipBM4PsZC6jpgc1lK7rIImuJwcmA=;
        b=mhIdX9AUWfSxKwf98Zsl6nqV1ckKdof33MJI+HCXdMyP5auJGvrULmvYMq5Cj5OO+iLbKh
        C9MBKMyS4fU18KQ5zchecX13pttwfNJDk0BV8gTrl41LOHkjne76/qW5PD6EYDdiPRB9qX
        a8u6TIzDUTGBBQRSYn8HA6DIaoYPUTH1jCfHiGta/RXm9vnXFT2Wte63JAapz+09QyqXKn
        JeAryPUbNfGe7D3ZUgmtO9EjA7/+S8DakHEbfR3k2WuOmtCFl7BvmNR5dH9WoRU8PhJQ+v
        gPwKt3RsJYuaHRYqO+7/0TyY/3HSIvsqQNii0+iG2n4HYuUlGMld5gEOYKvqLQ==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-r5vrk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Cooing: 45257a4105340661_1680889817417_2184140518
X-MC-Loop-Signature: 1680889817417:4182388007
X-MC-Ingress-Time: 1680889817416
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.243.16 (trex/6.7.2);
        Fri, 07 Apr 2023 17:50:17 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4PtQr70tB3zFJ;
        Fri,  7 Apr 2023 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1680889816;
        bh=Mu9kZlt0sY3Iz7fipBM4PsZC6jpgc1lK7rIImuJwcmA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bBcBOgYjS+tWkkrzlBRKxYSONYL0z2wuJaudfaWFf21tnZlCXeIll5w+XrnpG+c50
         Rt1lU5LGEjvogjGcr3ikPfCub4vJ2/NFH4LoOGzkRcrR9AxAq7a3REsIpmY+YNq/Zi
         y6j9b+CFHCAtZhUqlaCyrqWkkcJam2kj+E7cHcIu3hPsXCKBDrtqYMHQLbzrFDd+Ns
         agIRq7fTvZo80pX1fA6NsESIwkpOZbxj5qBXYtVj7q+SbuWI0Rc8ig2lhBfBBbh/rw
         hBZBl9TpfN0ppuOaEUHfNNwn13IaJjeZ+lJ1ECLNcJHYpYtsQVa9L03DXUU6J+nnvL
         fNEDL9kWNGqYw==
Date:   Fri, 7 Apr 2023 10:19:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 2/2] modules/kmod: replace implementation with a
 sempahore
Message-ID: <20230407171929.xlxi7ewxxtrqo6z5@offworld>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230405203505.1343562-3-mcgrof@kernel.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the title: s/sempahore/semaphore

On Wed, 05 Apr 2023, Luis Chamberlain wrote:

>Simplfy the concurrency delimiter we user for kmod with the semaphore.
>I had used the kmod strategy to try to implement a similar concurrency
>delimiter for the kernel_read*() calls from the finit_module() path
>so to reduce vmalloc() memory pressure. That effort didn't provid yet
>conclusive results, but one thing that did became clear is we can use
>the suggested alternative solution with semaphores which Linus hinted
>at instead of using the atomic / wait strategy.
>
>I've stress tested this with kmod test 0008:
>
>time /data/linux-next/tools/testing/selftests/kmod/kmod.sh -t 0008
>
>And I get only a *slight* delay. That delay however is small, a few
>seconds for a full test loop run that runs 150 times, for about ~30-40
>seconds. The small delay is worth the simplfication IMHO.

Yes, code looks a lot nicer.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>---
> kernel/module/kmod.c | 26 +++++++-------------------
> 1 file changed, 7 insertions(+), 19 deletions(-)
>
>diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
>index b717134ebe17..925eb85b8346 100644
>--- a/kernel/module/kmod.c
>+++ b/kernel/module/kmod.c
>@@ -40,8 +40,7 @@
>  * effect. Systems like these are very unlikely if modules are enabled.
>  */
> #define MAX_KMOD_CONCURRENT 50
>-static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
>-static DECLARE_WAIT_QUEUE_HEAD(kmod_wq);
>+static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
>
> /*
>  * This is a restriction on having *all* MAX_KMOD_CONCURRENT threads
>@@ -148,29 +147,18 @@ int __request_module(bool wait, const char *fmt, ...)
>	if (ret)
>		return ret;
>
>-	if (atomic_dec_if_positive(&kmod_concurrent_max) < 0) {
>-		pr_warn_ratelimited("request_module: kmod_concurrent_max (%u) close to 0 (max_modprobes: %u), for module %s, throttling...",
>-				    atomic_read(&kmod_concurrent_max),
>-				    MAX_KMOD_CONCURRENT, module_name);
>-		ret = wait_event_killable_timeout(kmod_wq,
>-						  atomic_dec_if_positive(&kmod_concurrent_max) >= 0,
>-						  MAX_KMOD_ALL_BUSY_TIMEOUT * HZ);
>-		if (!ret) {
>-			pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
>-					    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
>-			return -ETIME;
>-		} else if (ret == -ERESTARTSYS) {
>-			pr_warn_ratelimited("request_module: sigkill sent for modprobe %s, giving up", module_name);
>-			return ret;
>-		}
>+	ret = down_timeout(&kmod_concurrent_max, MAX_KMOD_ALL_BUSY_TIMEOUT);
>+	if (ret) {
>+		pr_warn_ratelimited("request_module: modprobe %s cannot be processed, kmod busy with %d threads for more than %d seconds now",
>+				    module_name, MAX_KMOD_CONCURRENT, MAX_KMOD_ALL_BUSY_TIMEOUT);
>+		return ret;
>	}
>
>	trace_module_request(module_name, wait, _RET_IP_);
>
>	ret = call_modprobe(module_name, wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC);
>
>-	atomic_inc(&kmod_concurrent_max);
>-	wake_up(&kmod_wq);
>+	up(&kmod_concurrent_max);
>
>	return ret;
> }
>--
>2.39.2
>
