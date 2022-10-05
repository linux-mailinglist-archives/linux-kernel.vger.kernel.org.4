Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA75F53EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJELrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJELqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:46:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491403E758;
        Wed,  5 Oct 2022 04:44:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o7so17891778lfk.7;
        Wed, 05 Oct 2022 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcmJvpgMdOPQrJYzs06/mULd1kHurX+O44fuIfE69Uk=;
        b=WDkA9/99H8aXVX4zcWG75ww69djUQaaes7J/iQB+mPyCNJCS3uMR4evPhuHtDCtOJp
         jYIRWm2rmqrQ6K7SSptQo+vdnw8ON5Xrgk84jSrYMmmnBLatIWW3wppuvjAkleuwXafI
         ASGY1VpdfUIsTwQICv6aIESiGsePK2U60YAm+GtF2NcTd13Tn5eqpV4Uy+R6+0U+jTZK
         g+FYRYPW2IZePhYqr/ZsERyweW1mqq1PK51g3jgbPVMbS7MRtTYCF5cX6tH0/6LbDcNt
         rqYSex1iDi6+pf53c68euFUbz/93lyYExPEed9nYZiyvUnGRFZeaMrO50xilVYRp0D4r
         ZvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcmJvpgMdOPQrJYzs06/mULd1kHurX+O44fuIfE69Uk=;
        b=2aDAIl9e+bAsXd2yqcxePyCC6FM5WTtsXQ8zVYTJDA9b4SwGtROgeitX4Upp8Kvju6
         IFsKSE/j2oAJ+D9+MS7Df3Oo/qaCs6wJwVcRvplwoCNGN6OtyzbRJB8wmY14isoUwZD+
         YhqkiJr6jk8yG5EOCvCi210in+qmmadf0HhNPkwj9b47dkrETdlukVSUQd9wMgla6pEs
         mcRdjJnNr0qplFZIBhoo/S3Nd0JJW/hSjAas5smuvwMkiRdB5+uwb5iaXguSzMJEWher
         vNwFr2g70vtcWMeKafIq4NmN9nu/6d3Iy6MIpIGlH8WnfVvK2tz7r8pCYuhN53c4hMTr
         ErdQ==
X-Gm-Message-State: ACrzQf1B17AhwXHf04mryfHReKDNvF+I2ndSA+UF6Q1Yoq0Qv0xRb8XF
        4urWX3UcJEYLet3arosb4+i9NjCsKRI=
X-Google-Smtp-Source: AMsMyM49ZUq+ShtvGll3nxj0oEcVI9Vje7RAbVr2BrmGKHAXUhYuOHlWzfnKBSIra4mkiLcyWx4jLg==
X-Received: by 2002:a05:6512:2621:b0:47f:d228:bdeb with SMTP id bt33-20020a056512262100b0047fd228bdebmr9991555lfb.121.1664970244470;
        Wed, 05 Oct 2022 04:44:04 -0700 (PDT)
Received: from pc636 (host-90-235-26-170.mobileonline.telia.com. [90.235.26.170])
        by smtp.gmail.com with ESMTPSA id g4-20020a2eb5c4000000b0026de0f96ffasm301832ljn.124.2022.10.05.04.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:44:03 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Oct 2022 13:44:01 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
Message-ID: <Yz1uAVitJFLEcp/p@pc636>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:48AM +0000, Joel Fernandes (Google) wrote:
> Implement timer-based RCU callback batching (also known as lazy
> callbacks). With this we save about 5-10% of power consumed due
> to RCU requests that happen when system is lightly loaded or idle.
> 
> By default, all async callbacks (queued via call_rcu) are marked
> lazy. An alternate API call_rcu_flush() is provided for the few users,
> for example synchronize_rcu(), that need the old behavior.
> 
> The batch is flushed whenever a certain amount of time has passed, or
> the batch on a particular CPU grows too big. Also memory pressure will
> flush it in a future patch.
> 
> To handle several corner cases automagically (such as rcu_barrier() and
> hotplug), we re-use bypass lists which were originally introduced to
> address lock contention, to handle lazy CBs as well. The bypass list
> length has the lazy CB length included in it. A separate lazy CB length
> counter is also introduced to keep track of the number of lazy CBs.
> 
> Suggested-by: Paul McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/rcupdate.h |   7 ++
>  kernel/rcu/Kconfig       |   8 ++
>  kernel/rcu/rcu.h         |   8 ++
>  kernel/rcu/tiny.c        |   2 +-
>  kernel/rcu/tree.c        | 129 +++++++++++++++++++-----------
>  kernel/rcu/tree.h        |  12 ++-
>  kernel/rcu/tree_exp.h    |   2 +-
>  kernel/rcu/tree_nocb.h   | 164 +++++++++++++++++++++++++++++++--------
>  8 files changed, 246 insertions(+), 86 deletions(-)
> 
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

for whole v7 series.

--
Uladzislau Rezki
