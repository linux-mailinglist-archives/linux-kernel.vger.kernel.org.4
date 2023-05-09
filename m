Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4CB6FC47F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjEILEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjEILE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792B421F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1B462D35
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1290C433D2;
        Tue,  9 May 2023 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683630266;
        bh=tCwZ6+qIZG1gjhd8Pl4yTC3xJMpCK82VwNlmmRtXi7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvYJ3YGeRdbRnB8fqOYN0OvcrU2XThCr43HctvqjmFBStID0zuGkzcNUaBvlPNDUZ
         yuOpTLQw6NsBExpB/CvxfBzyj1rX3MUxf2TYJRug9YfNHarsB4lEu0im6fnxSzjRbq
         AMmzojvgdhAp6XZFp1qXCG8baXL0LqIA63A3JD1dLrRGPkHmcSyNTunT5Ip5z5MG0C
         C6/KCf4JGcgE46lEnXyr28l4wb3FegEcpK4GGwO+x6bGKrsyMHpucpb08hmAjzFZxC
         aa1Y1L+kgDCtP8lFlw3/31MsuLxN8nf1efTw5N1IEmX8gK6Qvsl1/uCI/igstxvTmy
         A1FuFh91k0zNw==
Date:   Tue, 9 May 2023 13:04:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 06/20] posix-timers: Annotate concurrent access to
 k_itimer::it_signal
Message-ID: <ZFootxdd/1o8P9Zd@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.143596887@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.143596887@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:05PM +0200, Thomas Gleixner wrote:
> k_itimer::it_signal is read lockless in the RCU protected hash lookup, but
> it can be written concurrently in the timer_create() and timer_delete()
> path. Annotate these places with READ_ONCE() and WRITE_ONCE()
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
