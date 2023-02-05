Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202D68B14C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBETJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBETJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:09:34 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E740A11179
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:09:32 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D344E880E95;
        Sun,  5 Feb 2023 19:01:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 47386880DB1;
        Sun,  5 Feb 2023 19:01:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675623709; a=rsa-sha256;
        cv=none;
        b=xFE+a+cSpiqadBttNhFcAXafvwEOfeD5SAjBLpGy+t7ifNsB4VbDOX47grYLJxAQII0FTm
        yqboB8JocT16P5rWTEXiPiqZrqE+ukc5SjWSkWW/mqQ5Kw7HBEPKPno+wqWFbFJJz5JCib
        kU/fOKV5xQ93Rf/Na66f/gewIPCn33XbylmWOdnVN074g1JzKlhEgD9+j482oNcDFHdWp7
        dT3GILyLSibT/8RA8TfAHvdULv57P1rekgnWcUVW1dEdxzhqw/ZlOcaveK3WovGo2EeiPv
        MQUmKIDQF/e3rT6Y5/hfm1h7glP7bQ4G4VIZuKMYGJK8BHi7IiyZ5Sm5HgOnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675623709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=fOWa55a8RqXbEI+vUv5QZmR1uE0lJQWdOr8I37TZN+g=;
        b=aNhlYTL+CsSHA88jXtXZX2cOq+UyxGtSLBsixhXNFDDI7okYHoz9WdY2Px6Ah+fnCDg96A
        U6lWcz9zEjAfBFDK+KOcNz3rIFA//IgJBSweJ3cGP9DdZaEJKyaoNAj1e7NqZ9FsHxW+Io
        5KYxNZo04Y6GUYo/xwTj3LPo1ZgSqbjh+E4SqQ4LUWc9J+gtQHIymqTQ209VRbHqf98whN
        p9A9horJBXIc5023gEMTX6gkXsIGodcrFCsjXIEjqOHgmCDK63kf4Owv1OcR2wfvcLIltS
        t28mJMvfHc39EdRuH7guPVCdy1VFzGUjk81GbYhTCIok1vMJZRPIDYeue2VEpQ==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-7cmhb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Daffy: 6918221b0c03e2e1_1675623709596_3659634626
X-MC-Loop-Signature: 1675623709596:2929326835
X-MC-Ingress-Time: 1675623709596
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.227.134 (trex/6.7.1);
        Sun, 05 Feb 2023 19:01:49 +0000
Received: from offworld (unknown [104.36.25.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4P8zJr1g2pz8p;
        Sun,  5 Feb 2023 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675623709;
        bh=fOWa55a8RqXbEI+vUv5QZmR1uE0lJQWdOr8I37TZN+g=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=UEMrhrPf3/zNVic0Dk0GahdJNneHdOyAhWAZAqBEt7iXIOKfEAtPXuRb2efYKC7Bf
         C9y6YngZwUJSadV4vJztWlSJhjL0np3jo3ggAxACU2JJcbwnXaXs9Bzs8ohTfOnCtG
         YYK2k7aPxpj1wOX3w8GjQLvcCVqYu1w+IXueCT3f4EYTjVELK8tS5FxNkdy7mzkUf4
         juka35a70gO97QPgxhhU/tvdhdHoYhPYC7kJYIB+BCnX33z3JUb8HTTOUy9bbZU5vh
         6z3zgq+tXHKzXFaUt3S0Hg+E+ZW/ZDo0ePvBgkdePZZU8WAB0v0Go9ddna4im+dcNn
         QzHlbCl30pg+g==
Date:   Sun, 5 Feb 2023 10:34:24 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
Message-ID: <20230205183424.xwt54mlyixxgkhl6@offworld>
References: <20230203200138.3872873-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230203200138.3872873-1-jstultz@google.com>
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

On Fri, 03 Feb 2023, John Stultz wrote:

>In order ot extend locktorture to support lock nesting, add
	  ^ to

>nested_lock() and nested_unlock() hooks to the torture ops.
>
>These take a 32bit lockset mask which is generated at random,
>so some number of locks will be taken before the main lock is
>taken and released afterwards.
>
>Additionally, add nlocks module parameter to allow specifying
>the number of nested locks to be used.
>
>This has been helpful to uncover issues in the proxy-exec
>series development.
>
>This was inspired by locktorture extensions originally implemented
>by Connor O'Brien, for stress testing the proxy-execution series:
>  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
>
>Comments or feedback would be greatly appreciated!

Both of the above statements should be in a cover letter patch.

>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Josh Triplett <josh@joshtriplett.org>
>Cc: Joel Fernandes <joel@joelfernandes.org>
>Cc: Juri Lelli <juri.lelli@redhat.com>
>Cc: Valentin Schneider <vschneid@redhat.com>
>Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>Signed-off-by: John Stultz <jstultz@google.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

With some small nits below.

>---
> kernel/locking/locktorture.c | 23 +++++++++++++++++++----
> 1 file changed, 19 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>index 9c2fb613a55d..f4fbd3194654 100644
>--- a/kernel/locking/locktorture.c
>+++ b/kernel/locking/locktorture.c
>@@ -48,6 +48,9 @@ torture_param(int, stat_interval, 60,
> torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> torture_param(int, verbose, 1,
>	     "Enable verbose debugging printk()s");
>+torture_param(int, nlocks, 0, "Number of nested locks");

Maybe rename the parameter to 'nested_locks'? It would also be good to
inform the 8 limit. "Number of nested locks (max = 8)".
