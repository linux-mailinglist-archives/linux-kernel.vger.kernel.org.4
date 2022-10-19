Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5360604E72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJSRRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJSRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52AF18024B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666199838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8o5JxEqoCPCnIb2m03iS0ooGJi9njDkBwMULUXIkW8=;
        b=Brk18onKcCkgUIvdRYcYhXJS0pzR15n2cECPJsijCQCWcRqGe1arVslX7YFlH2hyKGTkrN
        kiM4kc5/myg/MkYn8/V6w8qhDHCiYc3ffoEDow+uAUNvPxxte+OXB+Y9pHAt9kphf0Hw5g
        uD0sxYY5a5aefXQ7kOPddWPm6c0Hv9s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-ojWK3bs0MdKvuu5hEt-qKw-1; Wed, 19 Oct 2022 13:17:16 -0400
X-MC-Unique: ojWK3bs0MdKvuu5hEt-qKw-1
Received: by mail-qt1-f198.google.com with SMTP id d1-20020ac80601000000b00388b0fc84beso13211682qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8o5JxEqoCPCnIb2m03iS0ooGJi9njDkBwMULUXIkW8=;
        b=eR1h5dwaTdXeQ5ncjLRwqphJ1ojUXlxqICdqtqfZQTYGDOMBHqCdv3ulbCFJAQYvfY
         hGJ393eiZVcWEvhciMsBtG2lHSheLxqVTIBYva3pNJFIZAR/+C8Fa4QE4VhyAynZhkjf
         dyP/v/gPv4Mf3aNiZdmxEE+DIAYhAXHWu0mslXoRG3Y3l3PbOvCZnShjXgGYVj4AefMe
         nBx8YGqNH+uzKaDtBdyFrl2Hcv67v8ZYRIJoTtVZVLWFrAxttuRKJsrIW52Cudj4f0+W
         XlezaRv3ObN+GlRLwXMXd9ULHUNGlDedGKGfu+/x85XG8azTCIRpzNY9MtSq2+g0lTmJ
         2kFg==
X-Gm-Message-State: ACrzQf2E0NWF0QrhgzkuqH99nndgA33QsVwTgaTJwyXWY5f6GrOqIMAB
        KWqaqjAmjDySpiKFStD2JLl/hTMuqVySTF+45gHSpH2YeygBPiWnX1ZkHw0STsS3HTbc65Hj/Gz
        5rOENeICx6lXSrTzuWeCG1h0p
X-Received: by 2002:a05:622a:242:b0:39c:f8a5:480a with SMTP id c2-20020a05622a024200b0039cf8a5480amr6303382qtx.337.1666199835904;
        Wed, 19 Oct 2022 10:17:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69fO0O8ZaQr9sXqoZlO42C13wiDAagYmFIaCg+Q6LJuidone5FYtVK6oA3+lE1HNcSW+2K/w==
X-Received: by 2002:a05:622a:242:b0:39c:f8a5:480a with SMTP id c2-20020a05622a024200b0039cf8a5480amr6303361qtx.337.1666199835703;
        Wed, 19 Oct 2022 10:17:15 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a414b00b006e99290e83fsm5439526qko.107.2022.10.19.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:17:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [RFC PATCH 05/11] sched: Split scheduler execution context
In-Reply-To: <20221003214501.2050087-6-connoro@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-6-connoro@google.com>
Date:   Wed, 19 Oct 2022 18:17:12 +0100
Message-ID: <xhsmhr0z3wx5z.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/22 21:44, Connor O'Brien wrote:
> @@ -1303,7 +1303,7 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
>   */
>  static void update_curr_dl(struct rq *rq)
>  {
> -	struct task_struct *curr = rq->curr;
> +	struct task_struct *curr = rq->proxy;

I found a note pointing out that Juri has a patch to unify the
update_curr*() functions as part of the deadline servers thing; I think it
could be picked as a standalone to at least unify the curr = rq->proxy
trickery - this will also (hopefully) remove redundancy for whatever we do
to expose sane runtime values to userspace.

Last iteration I could find is:

https://lore.kernel.org/all/20200807095051.385985-2-juri.lelli@redhat.com/

