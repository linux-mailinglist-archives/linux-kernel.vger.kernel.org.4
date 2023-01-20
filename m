Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF56675971
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjATQDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjATQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:03:12 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E513757C;
        Fri, 20 Jan 2023 08:03:11 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 525C5921F1E;
        Fri, 20 Jan 2023 16:03:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B90CD921C5A;
        Fri, 20 Jan 2023 16:03:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674230588; a=rsa-sha256;
        cv=none;
        b=q2/rf39yNFXhsT+BBAG+bmgYIoACFBGCOr5bljkMWx/C3vtHVhJI8mQWMGge4pR+AgG9hh
        3kWoXVL/8HL0VGFhJ+f5OaakD97MMTLVIwkVMIVUOWuxxEcggWTLozz8f9W5+Kb1ndkdcp
        Zzwigj+SG9y1ZszjApK1gMvRPai2+VnRJMXMu8aViZrSx8Fp5YFg7XSB99CaLN541A8qVD
        BCYadfsHrPTUxyFalFxVKcHm++hgKleoRJbDyVOUcVCFfJ5o2I9/puB11cc0l+Vv4kIN9y
        opxVh/YJPCpQ9PtNNemvbNJAIjF9ZPyHDDMo5lruPk8/nHeNbZC62kfz4dg8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674230588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=YjsmVTbUWOCRC7AkGQ9Kv1tBzMlRgafFXKVOC+akWHc=;
        b=hSXSETVHH+AHqmcnnrH7uufObeXTrYOx+1pXCE5dgDvUUhez1CqGMXmkYoJRgVYXjNW+Nw
        yN88DazvFvE7eFL+S2MZdbI8hM25TMtLNJL3bEPQkqOLLbfO+mcuqiR/2QcGKkqHr/AdY+
        43bvJ1KISlyV4wVoNJ7D59PVUPLIwBTIMrAzc3pfm3j4j6IAM6kqbqHmGiDQ5acm7t35MK
        441EYmbLGzoWUxPt5rLTZCmOxYZFtHt6XvHec43JNJWMIRFcTtJlQpdvEHDdBbnXY5cHim
        cDMpriFesdHdJ4RZaNwvQ9gv9aWK1nhTpDrENmsosZTnKcgjgTwwV+Da7aTTSA==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-tfh7x;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Language: 1db9b7194e4a6579_1674230589149_3639751266
X-MC-Loop-Signature: 1674230589149:1274289475
X-MC-Ingress-Time: 1674230589149
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.119 (trex/6.7.1);
        Fri, 20 Jan 2023 16:03:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4Nz4635f8Jz35;
        Fri, 20 Jan 2023 08:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674230588;
        bh=YjsmVTbUWOCRC7AkGQ9Kv1tBzMlRgafFXKVOC+akWHc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qKMSyeDboRPvnjfOjqW975gvrM4osnzRg9fnq0VzLKSh7MIXraHCnLPcm1/9MFtVc
         c+dH1upHny5++UUK2UVRa/xNbrRAfOlpJligopayV/bydMz/5UuhxKG2uiq/z9iML1
         JVAGwT/3Td+f+UDxYDFHO2KhdoseWJjuOOa7dXDrX3LzeR81xgKxCkjTGxx4DFYCtF
         v5TF3P9LU+3Zap2lBOopLr/vn9UnV4cdp2CJ2dIKrs1q48GNEhU+C1JnkVxYl1m9GV
         Z+8Imjgyz2hOySK4MKstirzBjk+B8eKtHnANvFlJgQzEuTz5/kSv7mbzTiMdqxn+FB
         1ILKvvxHRZwVQ==
Date:   Fri, 20 Jan 2023 07:36:41 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230120153641.ttgwdfvobygwuc4i@offworld>
References: <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
 <Y8pP3CD1PQ4KWhXF@linutronix.de>
 <20230120132441.4jjke47rnpikiuf5@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230120132441.4jjke47rnpikiuf5@techsingularity.net>
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

On Fri, 20 Jan 2023, Mel Gorman wrote:

>locking/rwbase: Prevent indefinite writer starvation
>
>rw_semaphore and rwlock are explicitly unfair to writers in the presense
>of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
>("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
>
>        The implementation is writer unfair, as it is not feasible to do
>        priority inheritance on multiple readers, but experience has shown
>        that real-time workloads are not the typical workloads which are
>        sensitive to writer starvation.
>
>While atypical, it's also trivial to block writers with PREEMPT_RT
>indefinitely without ever making forward progress. Since LTP-20220121,
>the dio_truncate test case went from having 1 reader to having 16 readers
>and the number of readers is sufficient to prevent the down_write ever
>succeeding while readers exist. Eventually the test is killed after 30
>minutes as a failure.
>
>dio_truncate is not a realtime application but indefinite writer starvation
>is undesirable. The test case has one writer appending and truncating files
>A and B while multiple readers read file A. The readers and writer are
>contending for one file's inode lock which never succeeds as the readers
>keep reading until the writer is done which never happens.
>
>This patch records a timestamp when the first writer is blocked. DL /
>RT tasks can continue to take the lock for read as long as readers exist
>indefinitely. Other readers can acquire the read lock unless a writer
>has been blocked for a minimum of 4ms. This is sufficient to allow the
>dio_truncate test case to complete within the 30 minutes timeout.
>
>Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

LGTM (albeit Sebastian's last comment).

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
