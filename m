Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACF46A0207
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjBWEbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBWEbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:31:01 -0500
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 20:30:58 PST
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D051528D02
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:30:57 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D9FBF5C0E4E;
        Thu, 23 Feb 2023 04:22:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BB3AF5C0F9E;
        Thu, 23 Feb 2023 04:22:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677126141; a=rsa-sha256;
        cv=none;
        b=tWXZ7Jhx/Pm2h1OzNLoLqNjlR2l3EGuFN7gIAbQwwFZdbS2ZfzF7OFNi6f2J5l3SnlH/7f
        0W+b2eJJeiCAYPmMR6Gzx+vicld6PSn7QTuP+njt5s1mPGkRxR8YvzVu+L28rmiTkUxbFs
        lsrVCNatVgVhRSKrcbwzwflhkYfD3eM81hYfyfbzICfhh+UP4pfVKITlSF4lF78kFrfXXA
        88EOJBhk6y18ZAOyNNMzSPUytXZjBbrFjRJtJrqH06pbF2qsmPK20T1qj/8rqdtoEqvwmm
        aVeyWVUqQI2f+vPAxiXQ4UVP/zL/MllkW+yYZgtSC+h03dnW1AUgDAY0ZAbJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677126141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=UpTaBDuDV5fMm4pa5rJUbm/QQCqFUUAOiSDUfr9UcwM=;
        b=tbKpnInQEnUObXyjn+VLeGwUZAF97r93Bl8gJDCFEnZHSHimyUf5iubyuO9BYB3Bd+w9ej
        fbA+s+4wnCmzmiAgKkASHfyFZ3b1RMT7OCPMsWTRIPTDe2q3qjB0VCz+yqHv/mcsZJ30kA
        XibDUlloHcspWLKWETi7kDV1RfLTrZ5aMQAOBPvD6gOckaadKedGEt5LmAq19ktFofuWQY
        B3U9cGp3LMYEpcaFKmt7Ws6Pk717UoTA51JEjFxzvpZbTnz92/Ck6j2PTinuT76Wfi36v7
        klfrT1YKoi4MSDFH2GlbJTnVCyh3QtFFhoWd/u0K6ThF0A5xv2ieP8ZagRAgHA==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-2dqtz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Macabre: 2e40f2f97215ce38_1677126142020_1056929472
X-MC-Loop-Signature: 1677126142020:4185120925
X-MC-Ingress-Time: 1677126142019
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.110 (trex/6.7.1);
        Thu, 23 Feb 2023 04:22:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4PMfxn1sH1z2h;
        Wed, 22 Feb 2023 20:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677126141;
        bh=UpTaBDuDV5fMm4pa5rJUbm/QQCqFUUAOiSDUfr9UcwM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=GscwdyKlZJltGMewOKbHx8Gki2DRLRcdx27jVgF7CZFxK7vLAt5zwanKRMYyj8HkE
         4Tuhilb7oy7jhVa/7WwTPTwDJL2ckYd0UFo/CaOP1Tz5m8SnEzrbD7hNWUADESMT+6
         ClvmSu8zhSciLgK6f7SNJ9dAmNxdXAJQdahLNPUXE8YiM7H0LL+xIFr0F3O1sD2TxK
         A/ghk05oGUysdmFQCQiP+Y54CAKPAwNNPAtn+xyOpmAH+/41siyqUDY/6Lf+0rzJTo
         mdLFSvJRIRFu2rFVKtvhAqaFQ49CDh7oq65TWfs+Ny6y9ynLTf1GDhPEdNpmcCNVgz
         VXZVbwPmrN5RQ==
Date:   Wed, 22 Feb 2023 19:53:59 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230223035359.6jgserikqtc3vnra@offworld>
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
 <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230222225755.GW2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230222225755.GW2948950@paulmck-ThinkPad-P17-Gen-1>
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

On Wed, 22 Feb 2023, Paul E. McKenney wrote:

>commit edc9d419ee8c22821ffd664466a5cf19208c3f02
>Author: Zqiang <qiang1.zhang@intel.com>
>Date:   Wed Feb 15 14:10:35 2023 +0800
>
>    locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels
>
>    In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
>    to sleepable rt_spin_lock().  This means that the interrupt related suffix
>    for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect the CPU's
>    interrupt state. This commit therefore adds raw spin-lock torture tests.
>    This in turn permits pure spin locks to be tested in PREEMPT_RT kernels.
>
>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

This is a nice addition, thanks. Just one comment below.

>diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>index 9425aff089365..ed8e5baafe49f 100644
>--- a/kernel/locking/locktorture.c
>+++ b/kernel/locking/locktorture.c
>@@ -257,6 +257,61 @@ static struct lock_torture_ops spin_lock_irq_ops = {
>	.name		= "spin_lock_irq"
> };
>
>+#ifdef CONFIG_PREEMPT_RT
>+static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);

How about leaving raw spinlocks regardless of preempt-rt, and instead
change the default lock (which is spin_lock) based on CONFIG_PREEMPT_RT
and use the raw one in that case?

Thanks,
Davidlohr
