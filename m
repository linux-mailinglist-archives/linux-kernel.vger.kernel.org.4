Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E6747387
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGDODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGDODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:03:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B011D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:03:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so67988235e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688479385; x=1691071385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7EhOSJt2DKose19cgkkEa+phWPe/FOTqdbgT2ux33Q=;
        b=3McXv32dthR6tk13Qcg+VMJ/5ZO5DoprRbWVn1QolCYp0bw0ba3NdDAOQFT2us2q1R
         Az3M1TOMSXtHNlXiYUCsjNYnM64enWNxc/nHHkolultE4tS7xwI0NmXIwT46Gr9FKT1o
         idcQrPHTm/6UdCk4HvWIiBbYlPZCUtL50JV07Bon647gls3mYaW6TP+79LyT1FhEx1O3
         BHXAbHu+8hoOZZAhqC5qxI4ucj3JRdvC8BzQFxMa9a6JCkeQ9E3nHsJiMHKx8y43LIEd
         PYYhrT79Tf09bFwtpT/LDDKktIth392rm4ZLKfCRxeQlqDSMO91wv/E/Y9d0lRM+tAIF
         FuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479385; x=1691071385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7EhOSJt2DKose19cgkkEa+phWPe/FOTqdbgT2ux33Q=;
        b=k4pr+T93swohpevdbhIYnj/pdW6jmOlUqHuLaU/AhFuYaRiz5dt7BA7DGaM9PFLxe+
         WqxaQdWbZT4aqaPvsow3ElmIziPuk/3upf+mvpepEav42K9NV81DUzNiI4KR7U1DEmMN
         v7AdQ7NaTGDCdWt5BeSxH/b3dwm/pSCg2GTSrp9ckI26WtpXhvVtog9xru2cNgx2Nqts
         1XD/Nf7jcNfd8ugthuKGyG5pBRfR8PRrTsgXVfJXxXDwBhF31smxC7L8vz1+JgtTFEFh
         cbRRnDBqIuZtFNIJ+oVc0Rgh3Op4WOOTQ5lQkER9vmUMogZi2+WoytaocX93WEGLTzrH
         o32Q==
X-Gm-Message-State: ABy/qLYNE8N0iLL1Wo0UaC1U6Z4J70Lxm7SHAdwnAlDsl7Zfcy6Xjws1
        D6tlZbo9uApZyoDrGj2QjTVGk5rMCUJdeTZyT18=
X-Google-Smtp-Source: APBJJlGLxkjEACwFRdjd26xTjgu/yJhljm/LzrfDmC/LPv+4of4vKhPbrt4Vd7rpKxywAVWCs78pGg==
X-Received: by 2002:a05:600c:2102:b0:3fb:e054:903f with SMTP id u2-20020a05600c210200b003fbe054903fmr2134386wml.36.1688479384966;
        Tue, 04 Jul 2023 07:03:04 -0700 (PDT)
Received: from airbuntu ([104.132.45.103])
        by smtp.gmail.com with ESMTPSA id c17-20020a7bc851000000b003fbc89af035sm12290381wml.17.2023.07.04.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:03:04 -0700 (PDT)
Date:   Tue, 4 Jul 2023 15:02:59 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Message-ID: <20230704140259.cb3g4us3u46iyegf@airbuntu>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-2-lukasz.luba@arm.com>
 <20230531182629.nztie5rwhjl53v3d@airbuntu>
 <20230621122513.2aa3bc0d29321197e3d38441@kernel.org>
 <20230630114950.zoocytnpvdrxgnss@airbuntu>
 <c4bcff44-c306-73f5-7864-ef9551d5f5bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4bcff44-c306-73f5-7864-ef9551d5f5bf@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/23 08:49, Lukasz Luba wrote:
> Hi Masami, Qais,
> 
> On 6/30/23 12:49, Qais Yousef wrote:
> > On 06/21/23 12:25, Masami Hiramatsu wrote:
> > > On Wed, 31 May 2023 19:26:29 +0100
> > > Qais Yousef <qyousef@layalina.io> wrote:
> > > 
> > > > On 05/22/23 15:57, Lukasz Luba wrote:
> > > > > The user-space can set uclamp value for a given task. It impacts task
> > > > > placement decisions made by the scheduler. This is very useful information
> > > > > and helps to understand the system behavior or track improvements in
> > > > > middleware and applications which start using uclamp mechanisms and report
> > > > > better performance in tests.
> > > > 
> > > > Do you mind adding a generic one instead please? And explain why we can't just
> > > > attach to the syscall via kprobes? I think you want to bypass the permission
> > > > checks, so maybe a generic tracepoint after that might be justifiable?
> > > 
> > > Could you tell me more about this point? I would like to know what kind of
> > > permission checks can be bypassed with tracepoints.
> > 
> > Sorry bad usage of English from my end.
> > 
> > The syscall can fail if the caller doesn't have permission to change the
> > attribute (some of them are protected with CAP_NICE) or if the boundary check
> > fails. The desire here is to emit a tracepoint() when the user successfully
> > changes an attribute of a task.
> > 
> > Lukasz would like to have this tracepoint to help debug and analyse workloads.
> > We are not really bypassing anything. So to rephrase, emit the tracepointn if
> > the syscall is successfully changing an attribute.
> 
> Sorry, but no. As I said, I don't want to add more dependencies in our
> tooling and kernel configuration.

Fair enough. But as I said before a dedicate uclamp only tracepoint doesn't
make sense to me. If maintainers are convinced, then be it. My point of view is
that We want generic tracepoints that scale to other use cases and it makes
sense to go this way to accommodate all potential future users, not just you.


Cheers

--
Qais Yousef
