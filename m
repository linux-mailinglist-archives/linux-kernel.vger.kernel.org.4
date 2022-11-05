Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8E61DAF2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKEO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKEO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:28:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235786451
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:28:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so10510060wrs.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PB/Mt5Tmc3kHHxMgRkRCJicdnQJp5BQg9tZBqs78/fw=;
        b=vUDCNQ47SnOGtVNhzGjgDTHG8qPBb5que/aZA4QH3l0CAUnvihmmTTKiF23sNjeLDe
         L8sB/78iX2VufQyfpKMJ0LUt/PWpmkWXtVKZdTjsyyKVKz4YwG2F5uJhi+T1+rgtghWO
         0lIM7C8URLIl9t/APgjif8vrFiiktoLnCeUpbwVxp7L/1U+Z6TF8aibqt/Exc87IutJl
         ScECC8GhkYhOkholmIwBPBJuAK9PxSBrN4XnWMkKuGI+CAc3AhbxquJwqP7/rZC0Uy4k
         2T2tUsTPKcAb8fyENGQON37VO/W0B/HQmQK3T1IxTRdHO85lFLe5MebGzhuKbdEwM9LG
         gemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB/Mt5Tmc3kHHxMgRkRCJicdnQJp5BQg9tZBqs78/fw=;
        b=SmwpaYSf4eQKKzWeoZHl5H4NKYAr8MbBacRAUdMjXtYnvI8R5Pjg4usTWFlUXj0A/L
         NK7jGNIlV+ZSNP/MSZ1IeSPkLYrsac+DGn5wfXKwZLklkdEPLJbYqu3+LL0aN8AboSSc
         nQQxQsdo2hddUViwB367iMvDWysuXiaQbGWW5uR8xmEmrV340DHIai6dNn+V4zCPtKHj
         b2fLRHDwlf2h4JQdloPoiZ42o5mBsdlPd28WHxYCVTT+5/pCPHJYfIQ/x8RofEWmSibj
         F2GHZYZ3vyn2N+ML4vxB9bBX2n/3GnAoR/DWoGwcG8jlkmYDnpoL+DXuUCyD4lzS94l4
         JYXA==
X-Gm-Message-State: ACrzQf0MXpox0A56kvjBowu09VjCcbL09kggTK+AE2UlV4XRA3dBiaYJ
        T8KN9yGI7/mlo3AdW2NU62vq0Q==
X-Google-Smtp-Source: AMsMyM6B1n/M7iC8YiIVr9ex0BBBcsyrp5ABaDeOswIUqfnqZL63E/NIcq53QIDupJ8Y58Xh78Ty6w==
X-Received: by 2002:adf:f5d0:0:b0:236:5866:eefe with SMTP id k16-20020adff5d0000000b002365866eefemr26906897wrp.339.1667658525642;
        Sat, 05 Nov 2022 07:28:45 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003b4fe03c881sm6407029wmq.48.2022.11.05.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:28:45 -0700 (PDT)
Date:   Sat, 5 Nov 2022 14:28:43 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Message-ID: <20221105142843.xz663q7fcvzsntw3@airbuntu>
References: <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
 <B7E91F49-3053-44E7-A515-8647A4C93D2D@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B7E91F49-3053-44E7-A515-8647A4C93D2D@joelfernandes.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 09:13, Joel Fernandes wrote:

> > If I have a task that has p->latency_nice = 20 but it belongs to a cgroup
> > that has tg->cpu.latency.nice = -19
> 
> Just for the task placement signal, One way is to go through the se hierarchy
> till the root and get the minimum. Then make that the effective value. So In
> your example that would make it -19 so prefer idle = 1.  We should need
> a Boolean signal. Not pretty but not the end of the world imho.

It is not hard to hack something. My worry is about consistency; and
maintainers in the future saying that doesn't fit the current design.

I'd love for this to be usable everywhere as-is. That requires the expectations
for both users and consumers are being made clear from the beginning.

What I was asking for is for the documentation to reflect this, and the
implementation of this effective function being made available from the start.


Cheers

--
Qais Yousef
