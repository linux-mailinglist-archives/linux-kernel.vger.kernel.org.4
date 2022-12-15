Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC664E2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLOVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiLOVQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:16:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E985445A;
        Thu, 15 Dec 2022 13:16:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id tz12so1596753ejc.9;
        Thu, 15 Dec 2022 13:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zwmh+aG57v+br8w/kxKRXfPqX8nr41fWjT8ZQaqS48=;
        b=cKdRdxDGQJ77rLt92WfVzil8tDTWRTJrkuRiyDY5hys1F2CxO+rMUW4463I05diMOc
         0wXdbPfQeY0ZpGVqULK7Tt+dpwLa57jsjy2Nq+vycUf2kptrwGvXZz/RqOa04/N0Q03w
         zClFVwgPnTTV4Ek1bDHEllWTpTA8syXlCRshjpjunOrQsKrU/sdqHc5zZ9AZwGJLga/e
         HYMM+aLnWEpXrvuI4BPTC06xMGpQODF1QSaQBhR3Z2B3yR4hmtuBB/dsYi39A3f6SyKQ
         1PogVgtp++NRpGDGyUBPeRafrXU9vwxJU9J4AXUV2Hs/fsT60gRxQdU9QNu6mVr/jI/E
         MpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zwmh+aG57v+br8w/kxKRXfPqX8nr41fWjT8ZQaqS48=;
        b=U1uvCm02Yxs63rDjPISpbIqPYMlfm46haod3MkLUyTaXmQ/uGw3JP5nDCBtwHW/veU
         z2d+D6MYq8CUO+UwgcrrPBPwylz4n2TFSYr9LdiAjqX7yjwKw2D8uL/xjigme/QwM426
         T+MlCMPLFWoxZMWZh0LDUwSRNxgJ5VHKfon8O3IzpBqqgTMOuqYXVcH8dGZS1wwUAi7n
         WxK2T4CBZBV2M38+ae/D2gm2Nf9S/1jn5Frag7twFJwxCDJhs/6fx0S0wRAKCq8QyKnG
         OgD4xGnKfQ+rSRDU1gI9ri7C+ekj4qcfxLshQz2zjpX0bCg0paHSGY4n5de0kZXWy2+K
         HCSA==
X-Gm-Message-State: ANoB5pnT2fPRFVzTaRvbIj1fbjHRyOIrr/Tkh4H9cuoOl4fie1irbbyT
        /olLI1ij2UQKSMaZh+3d8LQ=
X-Google-Smtp-Source: AA0mqf5wM4KryrETgNg7eh0XVTSJUpypwOhkaUtHmjr0lOewPWOo+03nzJ333rKQo4hICo+yVHHmEA==
X-Received: by 2002:a17:907:1dc8:b0:7c0:dd4e:b383 with SMTP id og8-20020a1709071dc800b007c0dd4eb383mr28545159ejc.3.1671138978153;
        Thu, 15 Dec 2022 13:16:18 -0800 (PST)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906310a00b007c0d64c1886sm91922ejx.33.2022.12.15.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:16:17 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 15 Dec 2022 22:16:15 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Carefully reset number of objects in krcp
Message-ID: <Y5uOnzBA7D30VUQY@pc636>
References: <20221214120630.379527-1-urezki@gmail.com>
 <20221215204022.GN4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215204022.GN4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 12:40:22PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 14, 2022 at 01:06:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > Problem. A schedule_delayed_monitor_work() relays on the
> > number of pointers queued into krcp. Based on that number
> > and threshold the work is rearmed with different delayed
> > intervals, i.e. sooner or later.
> > 
> > There are three pipes where pointers can be placed. When
> > any pipe is offloaded the krcp->count counter is set to
> > zero - what is wrong. Because another pipes might not be
> > empty.
> > 
> > Fix it by maintaining a counter individually per a pipe.
> > In order to get a number of objects per a krcp introduce
> > a krc_count() helper.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Queued and pushed for further review and testing, and with the usual
> wordsmithing.  Much better use of workqueue handlers, thank you!!!
> 
<snip>
   This commit therefore maintains per-pipe counters, and introduces a a
   krc_count() helper to access the aggregate value of those
   counters.
<snip>

a a ? :)

--
Uladzislau Rezki
