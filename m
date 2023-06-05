Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20367228D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjFEOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjFEOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683229E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F124D614CC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82E4C433EF;
        Mon,  5 Jun 2023 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685975538;
        bh=hluwjFtl0wl3g8EBBrdweWbwxnEv+Q1uFg9CuTe/xMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z85vgZVkU0XCdbovA4Vn34FHZwpJe1TotUhGF0mUx+4LTxd42cAmOuToO4XwbdUGH
         6Z/k8cXZx7999InevWuqEZud7wZQsezjlpGZaKlb9C+smI9TffslAc6DKrFy0ofqFD
         DHlBQQdAbgvJ6ZVcpLkAe3EqqvO7Mdumx/livEUJcGvLZqUWcA5SXNZARaMiFbXO8U
         q7Crp/peP21yCPHmyzGAAGuFp2e/9HsSfshIwo/rNJowjTZB6/3jqj+VGFy12R8hxp
         cfrdnRV/dpEZya5y7vzJzLKKNjCGNzTPeW/GVneCnGsLhflRAZHE21RJNnmGj7Dliv
         5pPk5fAs4g34A==
Date:   Mon, 5 Jun 2023 16:32:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 00/20] posix-timers: Fixes and cleanups
Message-ID: <ZH3x7WMRI07b1PDS@2a01cb0980759691cfef005a85b365eb.ipv6.abo.wanadoo.fr>
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425181827.219128101@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Apr 25, 2023 at 08:48:55PM +0200, Thomas Gleixner a écrit :
> Hi!
> 
> A recent syzcaller/KCSAN report about a data race and an actually broken
> loop termination due to that race made me look deeper into the posix timer
> code.
> 
> Aside of the loop termination issue this unearthed another issue in the
> exit() path where timer deletion might livelock on RT enabled kernels.
> 
> While going through the code with a fine comb, I stumbled over another
> place which needs READ/WRITE_ONCE() annotations, tons of outdated and/or
> uncomprehensible comments and a bunch of silly code.
> 
> The series has therefore a larger set of cleanups on top of the two fixes.
> 
> It is based on
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> 
> and also availble from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posix
> 
> Thanks,
> 
> 	tglx

Thanks for this extremely useful series!
