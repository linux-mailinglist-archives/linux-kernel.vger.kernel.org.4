Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C522073D1D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFYPmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EC9113
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A080A60BAD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 15:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48DC433C8;
        Sun, 25 Jun 2023 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687707738;
        bh=/QGNL3qG4F01jcNN3SWkEgHwmNs4EyLiiFhuXOmlnHM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WMY5Z7DFNpkGLtGvTzybVkRQThRGFWu/68bQ+BXd4SV+gUkuH7iD5lY9fTxh4cMUS
         qobe0WzeYuh5UW83SEQ+oJAw/Y5oBCVrJjfqQ/+v5Ks5u13EhXqGpg+CquuKVqKIKO
         gfkQFS4c6FtPcwo3lFFIsioACm9u3NRmh9rSU47pGV9Xe0zD0jeJ0juU4M6UKt6/gJ
         bixQ166EqqW2VJoWp43gXTnHCx/BJmBTyeiA96tNCJjYVI6ks8wge1x/kes90I8mH+
         +QGnDHZpsLdU33YahzNfiEo082OHZ8OL4VMWxsqYAYcTkYCA5N3XUu5c//HYR1R/j1
         yw8n//c7DN4Sw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 995B7CE39D8; Sun, 25 Jun 2023 08:42:17 -0700 (PDT)
Date:   Sun, 25 Jun 2023 08:42:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com
Subject: Re: [PATCH csd-lock] Decrease console output from CSD-lock timeouts
Message-ID: <b0b2e3fe-2872-48c1-978f-9c2cd0ae7cd8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3ee27fe5-cbea-46b6-adb0-48c4dde92b4f@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee27fe5-cbea-46b6-adb0-48c4dde92b4f@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:49:40PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains a couple of patches that reduce the console output
> produced by CSD-lock timeouts.
> 
> 1.	Reduce logging due to dump_stack of CSD waiters, courtesy of
> 	Imran Khan.
> 
> 2.	Reduce NMI traffic from CSD waiters to CSD destination, courtesy
> 	of Imran Khan.

Hearing no objections, I plan to send Linus a pull request for these at
this end of this coming week.

						Thanx, Paul

> ------------------------------------------------------------------------
> 
>  b/kernel/smp.c |    3 ++-
>  kernel/smp.c   |   10 +++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
