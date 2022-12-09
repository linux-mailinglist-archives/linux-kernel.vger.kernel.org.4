Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3BF64871E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLIQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLIQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:59:00 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A179C12;
        Fri,  9 Dec 2022 08:58:58 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2DD1F7E143D;
        Fri,  9 Dec 2022 16:58:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A144E7E135B;
        Fri,  9 Dec 2022 16:58:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670605137; a=rsa-sha256;
        cv=none;
        b=0Hj948fYPBmJ3+3+Wf/zQ7JAEtogvRdcE0024tYcdYpB0r4ieM6zXtE3qfXKAOPsi5eA/r
        iTpVdSJsE+8CRYzQ5mJ7Bw2T2GsWz5c96Jwx5IiYpRDxU+CYo7AWdJy4HtDpvQ6p/TmeWg
        c/CgULSRvO96/5HnY1uY6eylcHapbOZMfeB+kuuQC7Hf/vBPb6yvOFwUA7/G03sbCmgVYh
        8OpJAkCYUqyaYZ2MMA62EaGpxsu3xShIF62ZeKPDSm6Tm8s/rbMSdYQqA3QBPOF2Y0/ipG
        AtcV9COnOG0VJ8Izg76qvBPq5lSgTx3zqFJqfdM63XrItODncEZqPHmsHZAD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670605137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=MZY6NOU0lvpQpyxk+tdAEGA/AAvLiHytAaEf4JnqE9g=;
        b=CWQDdLdLjpnag97H7ELNOxf7LYAjyoxag5FlQqWHG6hDSZSzAFbiJOdzIEJPP7iqRQNWg5
        zkl5Amguch1Q/hj2Aw+PWrYQ5JEKvRqH3LjqaQYYWnGMQ+dqJIkNpfSs6fz/kJDSvjvqyi
        G4Md0AyRshRGEkqAAIUCFTrgdGi9p1l0Dzucr3aOgQf1gqCeVdeDskDkARXKN1+wjvgBm/
        YNzuWvj5ZQ0s8J8kHlpBYmWOMpQSETZsle+RU1lBh5bJ5Wq3L5t68l3m9IMr+3YHfkpwNR
        zsn3xc7OXuj8gi1ADXW7fJzMne2lcXlv/6Qiv/27xXXt8sd9Nd4f88UTP26IMQ==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-jbg4j;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Occur: 0030d9225ce0b029_1670605137976_3394957792
X-MC-Loop-Signature: 1670605137976:182205774
X-MC-Ingress-Time: 1670605137976
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.32 (trex/6.7.1);
        Fri, 09 Dec 2022 16:58:57 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4NTHKr6kNGz2k;
        Fri,  9 Dec 2022 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670605137;
        bh=MZY6NOU0lvpQpyxk+tdAEGA/AAvLiHytAaEf4JnqE9g=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=BmTeapT42WTjahHpVBjYyl2jG/HubmTuDCkJxxVDuE57ZQpd+nNUgENrERyDEaOhh
         EARjQT6XEUWynNnAVoAkxNQKqqTwTk2UOuMTpwM9rBD/SGolgLAoY/GDfXOuMrOc4T
         cyrjCxydzFb2bdTGBu5gwVCUzPzFD2qVFRMlmMLpY2pdzBC50TrEpt6nfQLhcipWih
         u3gVuTRkycu1ERDRfsYJn6S6xQY4T2vsGT79swoOmVzfgm5Wcx8flBcA3XjadAglQs
         6ebotU3RQXjGTdx1xESDDd71MVGSCZmzCj/kBURt3MgyeRCyeP9b5ImkgYGKWqwgzA
         t7UaaTdrENUOQ==
Date:   Fri, 9 Dec 2022 08:34:45 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be
 boosted
Message-ID: <20221209163445.jl4wdnbha47si7h7@offworld>
References: <20221209022305.321149-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221209022305.321149-1-joel@joelfernandes.org>
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

>Currently RT boosting is only done for rtmutex_lock, however with proxy
>execution, we also have the mutex_lock participating in priorities. To
>exercise the testing better, add RT boosting to other lock testing types
>as well, using a new knob (rt_boost).
>
>Tested with boot parameters:
>locktorture.torture_type=mutex_lock
>locktorture.onoff_interval=1
>locktorture.nwriters_stress=8
>locktorture.stutter=0
>locktorture.rt_boost=1
>locktorture.rt_boost_factor=1
>locktorture.nlocks=3
>
>For the rtmutex test, rt_boost is always enabled even if disabling is
>requested.
>
>Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>---
> kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
> 1 file changed, 56 insertions(+), 43 deletions(-)
>
>diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>index bc3557677eed..8968fd65a90d 100644
>--- a/kernel/locking/locktorture.c
>+++ b/kernel/locking/locktorture.c
>@@ -46,6 +46,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
> torture_param(int, stat_interval, 60,
>	     "Number of seconds between stats printk()s");
> torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
>+torture_param(int, rt_boost, 2,
>+		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");

Sorry if this was already discussed, but what would be the intent of option 2 without PE?

Thanks,
Davidlohr
