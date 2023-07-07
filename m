Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0837974B338
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGGOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGGOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:43:51 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFDF1FE5;
        Fri,  7 Jul 2023 07:43:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E6C134C0C80;
        Fri,  7 Jul 2023 14:43:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 436E24C1898;
        Fri,  7 Jul 2023 14:43:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1688741023; a=rsa-sha256;
        cv=none;
        b=RvDdGwYqqjRQULUfpCMgFL2Jv6TkkvFBPPuQsmsbMoDCXzFb4hHkQOMP85vMXDbwg4m9O1
        wJoStFGkf79qxjqKJEy+3OCzDixcKXw71LQNtqAQCDPHgaZFfRlu6XNaj9Y7Z7Z+GgE1C3
        cJvnSmN+w3AaY7v6J4zehXTN3C4sFZhTVgztyqZ9/mvXDjzprj7WI4Nr3tV3NJF06oCQ+X
        BNFTCOj3NzikKQIRnf8IphSElSqoRSFLIa8zYM5l5709LzAb+um1/tgKB+eiT8yeJSIHlS
        EUE1u2wf5fxSYEOOrwNABLqGzX1iRGMPgppdMMak/HI/0VwTpu51ik5gC6ar1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1688741023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=7bkqh2JJg8izQz3FcF4aa1t9Cj215Zpu2IgSPJgzyhI=;
        b=FAxlwmBWt+tiSol65AsXej9Vl9pOrOnK1GDZke7x4hUhavTqHYtJ7TDef0QQYyKZY1pMR+
        oo4w6Urxm8USsfRU650bhLtI8rlcn7+yF9w8L+Y3qLtnmCHDgRoa0vdZhM21yY0TxW6Vvw
        y/A/3cYgvqEtTb8SFqOQful/4qAluHMscG8sCk1cTvwzUOZsEnQJGEh6xt/aOBHZqan/T+
        fPkC1jvOHE/6uLzv4NlfYKuUgc9m9Zxmtl4/EKCOhRimnCAlyjnwyD/tI2mTG/X1lRYdlv
        bV5oQ6Vjx6sBquqd676lveA4g4gnryYIrwy8gtHFXXo35dwo3xwv0r7oAkFH1A==
ARC-Authentication-Results: i=1;
        rspamd-7ccd4b867f-p4srp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Print: 44f84d824b4c6e6e_1688741023726_2019953256
X-MC-Loop-Signature: 1688741023726:2316620585
X-MC-Ingress-Time: 1688741023726
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.187.85 (trex/6.9.1);
        Fri, 07 Jul 2023 14:43:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QyGNr2yhQz15G;
        Fri,  7 Jul 2023 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1688741023;
        bh=7bkqh2JJg8izQz3FcF4aa1t9Cj215Zpu2IgSPJgzyhI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ZlSSYbOUEYnGHHfBP9N1RpNkrZVX2znPZ3ZMkK/JiXS+e4897e4EowTGgcNmBVAdJ
         S7gJPoSEsV3ERXDWX2BDyaeVBvZhHBYgQL/wsdjTIRbrEIacWOzcWAU6DADd6bDEs1
         xNaHd0jxLrafS5CCZ1qr+z9AcjUQpQwKaJ42PrtUnE/bQ2/Yv3SqQXteSWsx5DihSb
         qokwNPPoJTTvRdr1Za7Ipyf/41+ZzYU0+7jmN6LL7JTSlddZah+oFUr/dtBWcO4AH7
         Q5LgItsm6nuw23T17skLsbBdP/vR3h3hC0S3YyNsn52Ztpl+Bcgcr2BGnt2OsjdHcJ
         LNTGJkXpfmOuw==
Date:   Fri, 7 Jul 2023 07:07:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Message-ID: <y5g37s3yhsqtmdoqziwnsd4kxtudlpqwv2iunt372abpmdzrry@43e54c374j4s>
References: <20230707000117.2371697-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230707000117.2371697-1-longman@redhat.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023, Waiman Long wrote:

>It was found that running the refscale test might sometimes crash the
>kernel with the following error:
>
>[ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
>[ 8569.952900] #PF: supervisor read access in kernel mode
>[ 8569.952902] #PF: error_code(0x0000) - not-present page
>[ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
>[ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
>[ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
>[ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
>  :
>[ 8569.952940] Call Trace:
>[ 8569.952941]  <TASK>
>[ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
>[ 8569.952959]  kthread+0x10e/0x130
>[ 8569.952966]  ret_from_fork+0x1f/0x30
>[ 8569.952973]  </TASK>
>
>This is likely caused by the fact that init_waitqueue_head() is called
>after the ref_scale_reader kthread is created. So the kthread may try
>to use the waitqueue head before it is properly initialized. Fix this
>by initializing the waitqueue head first before kthread creation.
>
>Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
>Signed-off-by: Waiman Long <longman@redhat.com>

Strange this wasn't reported sooner.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
