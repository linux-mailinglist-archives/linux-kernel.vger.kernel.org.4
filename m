Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5E6FC9F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjEIPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjEIPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:13:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF72744AC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:13:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f415a90215so40444675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683645189; x=1686237189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dS/MzCVT7+cSf3X4fztCpdcpjrF5B5vWgwHO3Up/uk=;
        b=AyJkHmXX2AIa3rzlDbfXxmTy5HegQZlfATEypEgeL1TtpPBWb42ddzFI1Xld5Eub7o
         aXfDYDoKGTRVjpFGvu1ACxkFYOouJ2wOJBi4JXeeam7ZJLEEsWB5dttedGHH4SrnfIKf
         Wd20aMHa/iRVSjdTb1Rh6Jq1n2pGn7fk3LptepCl7SZmMBGfzjYawN1emu+0WPWs4RPe
         7LzA9B6A29WP2OS0wbdvjgEmkkS2TwdukhXnggYVIOH9qf+Sh3U5ZRLoe27P57LfAe/3
         lMNkaBNP9/OXtg/3agd+GT0u+uZdZSkU+5lmHp4btyQqIxUoSothj48vFhwKuJ4d39ex
         rA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645189; x=1686237189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dS/MzCVT7+cSf3X4fztCpdcpjrF5B5vWgwHO3Up/uk=;
        b=ghoADH6KPCMmNo6pnlwuvm82u/5sVv5Hl6h35FXtqCNN/kmFoVN3ouuYVig8B66Rc4
         jJjVwFcYDORbUYdI7NeZDMMquNe7NmjcuNu5sBAymkv9tg1AGgYJdR8nyqB0JKkpo51N
         qro77KhZLmIjyQmu7uN6qL6LJNpe1VhG5yCJmg4uIdNbnlv/KnaBd2aTbLW5p8IRcvCc
         Gt9Zi0B8y4jEDJLuCvWsYrr5nvHzqJyRxVG64/G9letqBCFMA7YHa0D/C5orjxqZzIxF
         YhQJ7YPK3M4rAcvCYcC7X5pWJfQoOyn0sCPUqasF/mFouRU8v87iw/ibY3xt6U0oBvZo
         UfMg==
X-Gm-Message-State: AC+VfDz+NoXq8/vnCKSlspPjQptyvBgUjjB3p5r1U8eKx5X86wsGw3XJ
        r8KPXOVWf3PHZ+xdbX1YOUGKRg==
X-Google-Smtp-Source: ACHHUZ7a6L/aqQZtg0//RvH1NYUh6s5mVovCZFo8Mvx1BlegXvEsamYiSroWQfG9x7SrLxLca9c8Ig==
X-Received: by 2002:a1c:4c08:0:b0:3f4:2737:a016 with SMTP id z8-20020a1c4c08000000b003f42737a016mr3801996wmf.29.1683645189377;
        Tue, 09 May 2023 08:13:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b003ee20b4b2dasm19991620wmf.46.2023.05.09.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:13:06 -0700 (PDT)
Date:   Tue, 9 May 2023 18:13:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: kernel/rcu/srcutree.c:1644 srcu_advance_state() warn:
 inconsistent returns '&ssp->srcu_sup->srcu_gp_mutex'.
Message-ID: <782b3fa6-576d-4c26-888e-5dc151feaaa8@kili.mountain>
References: <c0937326-1cf1-429a-9883-30d9d79b01d0@kili.mountain>
 <c33b0348-7f86-47ce-913c-f1ebc6431f93@paulmck-laptop>
 <30f2e760-e2f3-4941-be9b-b9c5624fd861@kili.mountain>
 <4bdbbcd3-6620-4320-ada5-02b71a54106c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bdbbcd3-6620-4320-ada5-02b71a54106c@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 07:08:05AM -0700, Paul E. McKenney wrote:
> On Tue, May 09, 2023 at 08:40:33AM +0300, Dan Carpenter wrote:
> > On Sat, May 06, 2023 at 11:45:35AM -0700, Paul E. McKenney wrote:
> > > On Sat, May 06, 2023 at 10:22:04AM +0300, Dan Carpenter wrote:
> > > > aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1632  	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
> > > > 
> > > > We don't mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex) if this if
> > > > statement is false.
> > > 
> > > Hmmm...
> > > 
> > > I could make the above line read something like the following:
> > > 
> > > 	if (!WARN_ON_ONCE(rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) != SRCU_STATE_SCAN2)) {
> > 
> > Smatch ignores WARN_ON().  WARNings are triggered all the time, so it's
> > not like a BUG() which stops the code flow.
> > 
> > > 
> > > The theory is that there are only three legal values for ->srcu_gp_seq.
> > > Because we hold ->srcu_gp_mutex, no one else can change it.   The first
> > > "if" statement either returns or sets that state to SRCU_STATE_SCAN1.
> > > The second "if" statement also either returns or sets that state to
> > > SRCU_STATE_SCAN2.  So that statement should not be false.
> > 
> > Smatch can't figure out that the statement is true.  The issue there is
> > that ssp->srcu_sup->srcu_gp_seq stores a value in the low bits and a
> > different value in the high bits.  This seems like something that might
> > be worth handling correctly at some point, but that point is in the
> > distant future...
> > 
> > Just ignore this one.
> 
> Fair enough!  Yeah, I could imagine that this would be non-trivial.
> 
> Is there a not-reached annotation that Smatch pays attention to?

Hm...  Yeah.  If you wanted you could do this.  I'm not sure it improves
the readability.  Also for some reason my private Smatch build doesn't
print a warning...  I need to investigate why that is...

regards,
dan carpenter

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20d7a238d675..58e13d3c5a6a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1669,6 +1669,8 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		}
 		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
 		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
+	} else {
+		unreachable();
 	}
 }
 
