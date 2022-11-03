Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E756F617D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKCNGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKCNFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:05:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB614D3B;
        Thu,  3 Nov 2022 06:05:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n12so4962013eja.11;
        Thu, 03 Nov 2022 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBTVx2yYg4uG/7BMBUSu1/Ui13eYHVUWqefVD6Wjd50=;
        b=BDJTsfeBbbvFJmbFb1tMf63UPYdmvz/AgFBYJlfY5y7XiqTgqRAAPnQFgRmvA8ddTM
         nrRohq4vJXnBueCFFW8hMOjnt2D2qzpgEHun9ctmJpAOhmo4PMYrHz8MYrhd1n05gW1k
         5kgGYzzqMoyLahT4dA39QksYHFQJSViVQ214BRB4QCzqVbQB0bEo1HjN23Um2zNV286u
         43SxY3ks6RCAqqW56g30O7HojW05GTQZzWxvCT5/VolTsR3Ubi5gCZnBpre6AJh/9j1F
         lBKRZGQmtDhnoV77pSLvs5YPmspyQw9hGnUlny6IBDdLeb5ZulDxVQ8bs9ccaFz+2N2m
         hBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBTVx2yYg4uG/7BMBUSu1/Ui13eYHVUWqefVD6Wjd50=;
        b=f0LWMcMCj2R9uNl0pA/wxRUZo1Sdgkgu5mk+7QMIV8FFSypRd2GFZbycPk+l64/bda
         LL62AwO56TOxBx5OVoeNw116l4osYX8u5mWkQKo69IFaCRmbrhyR1yX+bVgN3zQuLeqS
         k4gMRAC1QCvs5JSy/WldrnAYgkqvwj3ATT54BAtys/kFdOg5jDMIbmLfngWNh1ijF2jW
         ZcklZizTazdjOyW7ENlcr3HAalhU/bWsb8PI06FOvgm5xf5KAw8LebdKR3k2MxR5ThG3
         JK5T4C1L+/9yzNMm9+9nQHvGuW4SUEfrw5/Sh4oK/UrSaobHfSi8L4LC30i7dzdpGNV5
         xrWA==
X-Gm-Message-State: ACrzQf3V0kDvQWRYIJgqI3GL2ZAhPCWVEXm+LjSHDOTwZxYguc2xtyeN
        vG5lchuFRg19QuAWajG9ItHQjLp4ecQ=
X-Google-Smtp-Source: AMsMyM4E2PCWOMmyu4QI3E+6iJXT3/HT5iqu2cXhm6Mt3a+tcVlCn+T/jHruE+xTQ4YThFTqGpSWmA==
X-Received: by 2002:a17:907:7632:b0:7a1:d4f0:e7c5 with SMTP id jy18-20020a170907763200b007a1d4f0e7c5mr29212148ejc.160.1667480725574;
        Thu, 03 Nov 2022 06:05:25 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id cs1-20020a0564020c4100b00451319a43dasm521661edb.2.2022.11.03.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:05:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 3 Nov 2022 14:05:23 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2O8k2U+ACr1N6Fe@pc638.lan>
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
 <20221102223516.GT5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2O3w3d3qmTg6VAP@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2O3w3d3qmTg6VAP@pc638.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:44:51PM +0100, Uladzislau Rezki wrote:
> > 
> > > Though I am thinking, workqueue context is normally used to invoke
> > > code that can block, and would the issue you mentioned affect those as
> > > well, or affect RCU when those non-RCU work items block. So for
> > > example, when other things in the system that can queue things on the
> > > system_wq and block.  (I might be throwing darts in the dark).
> > > 
> > > To be safe, we can implement your suggestion which is basically a form
> > > of my initial patch.
> > > 
> > > Should we add Tejun to the thread?
> > 
> > Let's get organized first, but that would be a good thing.  Or I could
> > reach out to Tejun internally.
> > 
> > For but one thing to get organized about, maybe kfree_rcu() should be
> > using a workqueue with the WQ_MEM_RECLAIM flag set.
> > 
> It can be as an option to consider. Because such workqueue has some
> special priority for better handling of memory releasing. I can have
> a look at it closer to see how kvfree_rcu() works if it goes with WQ_MEM_RECLAIM.
> 
An extra note. It would work well with posted patch because we can
directly queue the reclaim work to the WQ_MEM_RECLAIM queue.

As for now RCU-core kthreads like: rcugp, rcuop use "regular"
queue. I think system_wq one.

--
Uladzislau Rezki
