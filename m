Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147A36C3551
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCUPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCUPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:16:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9293754C;
        Tue, 21 Mar 2023 08:15:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h25so7901544lfv.6;
        Tue, 21 Mar 2023 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679411756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/3HeM3Qr6HuiISn1jIjaXM3iCDubZuOw4IHlnRgsOk=;
        b=AmbyNu5qDW7wndKY0CU6lVIavZs1fo6nquhzQeV4ABsGsMfcnkFbezm6blvzxC7RUY
         LkPUBFdAacX948tRYBMnRqItENF6Zza3hHL6Ng8iIx1pmTx3JxlI2am8lpswOclVriu9
         Q5VWK09cqnJh19vl6GcvRU+srxPPBGc4oVlhlAK9/0FUmYFx0mneBXOj1zSf3UwI1GDF
         AUKUtznXG19OPqPtg+v7xu51FWSTXWjPWolmfCwwuCgcoJfKFK9E9lNEJFcWYrqH96pS
         XyD5t/lriUZqIbN8qSuO563zuKJnzP6WMQ026oFxmraNTf/ZN1G2lbaVqxtqZIzoxcdm
         tQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/3HeM3Qr6HuiISn1jIjaXM3iCDubZuOw4IHlnRgsOk=;
        b=nyZJg95zBkyoPjuB9iVXHKOdCZhqD8NgF1q/G3UKPUkj6GWt3u5hkaBUvz18pV39pZ
         DFgWpaT7M2ziR0uHBPpZZfpezlf4d8wsmsCToxfSnFh+zYciXHTIVuMc27EONtwW7sJ1
         NXoYAsOnIXajEDoqrKFJoFbhe/RdNlZeW67DrmwY9xLZnixisehtCKkFPwT62jlxNKaq
         TwxF1XlCBKve7psQmrYYD8aVD8Ba3cfNQm5UYPsHZq4h/cGFEaRvqzmXnCieI2WKpshw
         a78Azyb7ap/9iQfbmZBrGM0iRWbe52gwuruF8x1XVoEtdJnKDp04eyM9eP/9VW7n1WsX
         up1w==
X-Gm-Message-State: AO0yUKWpI2P/h0tPrpik49SDaK+FbkEWMhNUWy+pW5IZbK5zsLwLHHqj
        W4JF8NF0gPIVTEUIhk6Vk3o=
X-Google-Smtp-Source: AK7set/jCNr/V24J8H1bn3oN3wmDN17t9qO5xudbABdcM0N7oiAxWTT7OPRiWtyIOlqEO5f8Fz63aA==
X-Received: by 2002:ac2:4ad9:0:b0:4dd:9a38:fcc with SMTP id m25-20020ac24ad9000000b004dd9a380fccmr853665lfp.63.1679411756223;
        Tue, 21 Mar 2023 08:15:56 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id a27-20020ac2521b000000b004e96afb1e9asm2108232lfl.253.2023.03.21.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:15:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Mar 2023 16:15:53 +0100
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <ZBnKKZsSpI8aAk9W@pc636>
References: <20230321102748.127923-1-urezki@gmail.com>
 <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:03:19PM +0000, Zhuo, Qiuxu wrote:
> > From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Sent: Tuesday, March 21, 2023 6:28 PM
> > [...]
> > Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > 
> > A call to a synchronize_rcu() can be expensive from time point of view.
> > Different workloads can be affected by this especially the ones which use this
> > API in its time critical sections.
> > 
> 
> This is interesting and meaningful research. ;-)
> 
> > For example in case of NOCB scenario the wakeme_after_rcu() callback
> > invocation depends on where in a nocb-list it is located. Below is an example
> > when it was the last out of ~3600 callbacks:
> > 
> > <snip>
> >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt
> > CBs=3613 bl=28
> > ...
> >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt
> > rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt
> > rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt
> > rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt
> > rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt
> > rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt
> > rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-
> > invoked=3612 idle=....
> > <snip>
> >
> 
> Did the results above tell us that CBs-invoked=3612 during the time 21950.145313 ~ 21950.152625?
> 
Yes.

>
> If possible, may I know the steps, commands, and related parameters to produce the results above?
> Thank you!
> 
Build the kernel with CONFIG_RCU_TRACE configuration. Update your "set_event"
file with appropriate traces:

<snip>
XQ-DQ54:/sys/kernel/tracing # echo rcu:rcu_batch_start rcu:rcu_batch_end rcu:rcu_invoke_callback > set_event

XQ-DQ54:/sys/kernel/tracing # cat set_event
rcu:rcu_batch_start
rcu:rcu_invoke_callback
rcu:rcu_batch_end
XQ-DQ54:/sys/kernel/tracing #
<snip>

Collect traces as much as you want: XQ-DQ54:/sys/kernel/tracing # echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
Next problem is how to parse it. Of course you will not be able to parse
megabytes of traces. For that purpose i use a special C trace parser.
If you need an example please let me know i can show here.

--
Uladzislau Rezki
