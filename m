Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDD5B9683
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiIOIjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIOIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:39:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB821B6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=byClg82A0KaCb5Ew/JsomAusUt5TBcsIZQADQgPYL0Q=; b=PW6ug7e0p9Li8Aoa1U9oMu+tXC
        bAgLZpNd0rIFUSxBW1VpH9diaOymd8heNgfKLLXQ/JIjRVJajMi4j8IOYqqmTTnQj7L157qGFbCzQ
        P3pzrUg8ZeztogVWTaih9LiAxnP9b1nfGp3xU9E3MRlxthWS/AD6CkHq0zBba/NNGvCE2EwMqSpsq
        QygQzlk0+LZkQjlIUN1nwI0v9fGhUO3wWq6iL2diz0KyyqW1Gb5/JmTZG6rdCaTV9Yx0yByECUEkI
        ggUpnqVV0LZ+ghDUC2kZb7GJ0yh8U4p/bpdKUrOPymdzQU/2DUFxV1s14cGWEE8xGoLadaF6SWr60
        K4TYGtsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYkOv-00CYPd-JJ; Thu, 15 Sep 2022 08:39:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F68F30010B;
        Thu, 15 Sep 2022 10:39:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EECF2BA39EB3; Thu, 15 Sep 2022 10:39:12 +0200 (CEST)
Date:   Thu, 15 Sep 2022 10:39:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RCU vs NOHZ
Message-ID: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After watching Joel's talk about RCU and idle ticks I was wondering
about why RCU doesn't have NOHZ hooks -- that is regular NOHZ, not the
NOHZ_FULL stuff.

These deep idle states are only feasible during NOHZ idle, and the NOHZ
path is already relatively expensive (which is offset by then mostly
staying idle for a long while).

Specifically my thinking was that when a CPU goes NOHZ it can splice
it's callback list onto a global list (cmpxchg), and then the
jiffy-updater CPU can look at and consume this global list (xchg).

Before you say... but globals suck (they do), NOHZ already has a fair
amount of global state, and as said before, it's offset by the CPU then
staying idle for a fair while. If there is heavy contention on the NOHZ
data, the idle governor is doing a bad job by selecting deep idle states
whilst we're not actually idle for long.

The above would remove the reason for RCU to inhibit NOHZ.


Additionally; when the very last CPU goes idle (I think we know this
somewhere, but I can't reaily remember where) we can insta-advance the
QS machinery and run the callbacks before going (NOHZ) idle.


Is there a reason this couldn't work? To me this seems like a much
simpler solution than the whole rcu-cb thing.
