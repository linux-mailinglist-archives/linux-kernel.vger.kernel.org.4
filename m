Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49B6BBE86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjCOVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjCOVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:07:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F266A1FFD;
        Wed, 15 Mar 2023 14:07:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so80594490edb.10;
        Wed, 15 Mar 2023 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678914445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvqDpJQII0tjuTCE/L1nrUqFi/4o57mJXXPUuuf5pig=;
        b=irzpxa9zw/+hC0m1wLsOCiPmJr1uESLcY7buc1fxHRe8ikp3hqYV0KFr/+KpCLRJQr
         A6LBKRz/JullVNHBuZR3bkFtXr9HEWdsKutpHp2D1a+/ZSBY0n4ATGBQ1CDUmLarhxs0
         LIaccdMT/71JO8NbUTwd8HYv+3db+m+3ZEuItuH8QOyCc1kpa56LnTo6T8bbcpoYPRy4
         8p81ztd/x10SZ9tO+GLsDBkUykyOayacmK666Bdx/B6IBmSlDoTC8m3e7lo7f/+UPvGf
         NudHzcMehZ90DosiDTwt6GiDC2qigbBMFNzy6UGBWTGGq4XXR+LqDj/P1RE/lFp+Zt62
         wJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvqDpJQII0tjuTCE/L1nrUqFi/4o57mJXXPUuuf5pig=;
        b=M5iGDvtVl5/oS+Ckty8heVZEkt7zJPo7657E98p8kIqV0JNVl/vej48sEvg6LtVnYH
         TM7YSVibYdujfJsTUqMCycnApRyqOFxL3rsT1ELht4a973PGgEjPkZx7ncx8JUkBelF4
         mwVt9ecgFNF75j4cGYd5Xx8wG7vkofLr117JQH2DmulAWL/sg6xvezmar4A+Y5vc5Qhc
         wVg9gA9x/B48jzOe1/OvS5dwXkUX6W6g9HgfmqFBQCdv4EYzITMuA7jsjEenYS+rALjq
         S5/8UmAKhXideuzfmhjXRYUVZxh2DLAWOAzYqlHDrOP9OUvYJgG4EfNjDM5cQyvBQO0D
         M57g==
X-Gm-Message-State: AO0yUKUDZDCic99JN0twiUkZ0UbhJU5iIpc1q1shJiQ53E7ptM/jFaqN
        PrLLAeUkw5dlOMmgL6LAhhg=
X-Google-Smtp-Source: AK7set9dk4uiXjVHbvyjFJS/4XuLINbjhs4sxkdQYeUdhCt+6qRLrJwAYNxyw5pKXq7jAbxb43+fVg==
X-Received: by 2002:a17:907:2d21:b0:8af:2a97:91d4 with SMTP id gs33-20020a1709072d2100b008af2a9791d4mr10647665ejc.14.1678914445189;
        Wed, 15 Mar 2023 14:07:25 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id pw13-20020a17090720ad00b008e40853a712sm2967532ejb.97.2023.03.15.14.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:07:24 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Mar 2023 22:07:22 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <ZBIzihsxOZwuSoYZ@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
 <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home>
 <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315162840.106a5b4f@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:28:40PM -0400, Steven Rostedt wrote:
> On Wed, 15 Mar 2023 15:57:02 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > I was going to suggest "kvfree_rcu_might_synchronize()" but that's just
> > > getting ridiculous.  
> > 
> > No, synchronize() is incorrect. The code really can sleep for other
> > reasons like memory allocation. It is not that simple of an
> > implementation as one may imagine. mightsleep is really the correct
> > wording IMHO.
> > 
> > > Still, I will replace that code back to a kfree() and rcu_synchonize() than
> > > to let that other name get in.  
> > 
> > I think it is too late for that for now, we already have conversions
> > going into the other subsystems, that means we'll have to redo all
> > that over again (even if it sounded like a good idea, which it is
> > not).
> > 
> > I would rather you just did: "#define kvfree_rcu_tracing
> > #kvfree_rcu_mightsleep", or something like that, if it is really a
> > problem. ;-)
> > 
> > Also you are really the first person I know of who has a problem with that name.
> 
> I guess you didn't read Jens's reply.
> 
> The main issue I have with this, is that "might_sleep" is just an
> implementation issue. It has *nothing* to do with what the call is about.
> It is only about freeing something with RCU. It has nothing to do with
> sleeping. I don't use it because it might sleep. I use it to free something.
> 
> If you don't like kvfree_rcu_synchronization() then call it
> kvfree_rcu_headless() and note that currently it can sleep. Because in
> the future, if we come up with an implementation where we it doesn't sleep,
> then we don't need to go and rename all the users in the future.
> 
> See where I have the problem with the name "might_sleep"?
> 
In that sense there is no need in renaming it. The current name of
single argument is kvfree_rcu(ptr). It is documented that it can sleep.

According to its name it is clear that it is headless since there
is no a second argument.

--
Uladzislau Rezki
