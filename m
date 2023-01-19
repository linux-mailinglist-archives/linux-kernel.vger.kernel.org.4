Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159A86740C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASSVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjASSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:20:53 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45387296
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:20:41 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4B8E8201ADD;
        Thu, 19 Jan 2023 18:14:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C66FF2014CA;
        Thu, 19 Jan 2023 18:14:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674152082; a=rsa-sha256;
        cv=none;
        b=qGmLA36dnQu91vQjun11BmaqCVdePn/CqWvRcondbWvbaKoszxGTuRSts0l1VzLuwhiTcg
        U8+ldMe5QGv5MvfogotPiBcyPslBtsVRe9ul8XNZTlLodeIHP3rIoRcA1wbRKTtXfr5NJF
        KIPqmloNei2Ckewrvi0i91E92cRIjcfixPYtwy7dSHwfMLP8tKSxUT86rNQLBE+PHcKS4d
        VDod54c+8b+BYm2y6sY8VaB697ltJVYBKWkop09C6U+dzbpKeLuv5sQeInYVb9aaR4L1q4
        bSURxS/TE40gyIPVzCr0DR32/usIftX9aRAxv7V4wdXJ2sOSxWqxbDj5LryWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674152082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Ql9tcvLXvhfRbsCJYs9I6JDJcfBUR32u9QTQqwgbOXM=;
        b=9y0FVZJ2DLVHg14XfxA0Bk7RSiMH1PbEExmthLyOaiHaAzP/+hBAZ0vpzVpD1w8plEfld9
        moHnb9KlWA3AyBIpjZcPcGd+1hyCHsBPHnRSoIbyJAVgAxDq0wdQOk92eBYY+JkZ+VrCTM
        YUfYjZ0zJrbsuiVFq6wkDbSuhGIx3M41qXaAuGOOgB+K+qBxHz9AH3y+wLiURy450cyXOs
        0fxpk4dPn2w1I30jiVnRcfTkKfKVvAoByuPEFEaR0Vs0/yX9oJNpjdEyp02tsLQKnO6zgz
        J2whZZ02VzNbQAxjNqIZ9L6Bnfw7kAySJomScc/ghKGqlKcZyo68eOLgFR9uiw==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-rfqtq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Scare: 385b1d0f6e4cdac2_1674152083102_4036563736
X-MC-Loop-Signature: 1674152083102:2009807844
X-MC-Ingress-Time: 1674152083102
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.59 (trex/6.7.1);
        Thu, 19 Jan 2023 18:14:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4NyW4L0LhBz1F;
        Thu, 19 Jan 2023 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674152082;
        bh=Ql9tcvLXvhfRbsCJYs9I6JDJcfBUR32u9QTQqwgbOXM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TqQIwi+VCUrSF702HIi74kBKX488pO8s0RBkNeALQtgMXjdi2Ygp8+36kU8QyIR+p
         ghwVBHdaqojGAEyHiBuvpH3NYMqBx91u8Dln1vqP9S+3c5J6YIOCkxOlYK3PD1bwhB
         91dQVARNTdgM+hUe0Z/GoMYM+WDUO3OPKbsZss76ScNHQNcD7CoLSqZUSoHDhmyT9l
         FKqWM2RRBLLqwOsD/TaJxWsLjhXY/W5vXzti1kKxi1oO54OAAVlhoDHA5K36V1fUbX
         BchFDgCTjdRbvcLQwxPUkx+1aJtJumRI6XBbf2YIuta/Yl3m3jf/Z5UslHzL4v3ETx
         mciyUnBH+whEw==
Date:   Thu, 19 Jan 2023 09:48:18 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230119174818.up7haooxje4nzusu@offworld>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
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

On Thu, 19 Jan 2023, Mel Gorman wrote:

>The race could be closed by moving wait_lock acquisition before the
>atomic_sub in rwbase_write_lock() but it expands the scope of the wait_lock
>and I'm not sure that's necessary for either correctness or preventing
>writer starvation. It's a more straight-forward fix but expanding the
>scope of a lock unnecessarily has been unpopular in the past.

Curiously, this is the documented behavior:

  * down_write/write_lock()
  *  1) Lock rtmutex
  *  2) Remove the reader BIAS to force readers into the slow path
