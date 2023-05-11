Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276AE6FEDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEKIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjEKIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:20:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E2259FC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:19:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965a68abfd4so1556443166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683793196; x=1686385196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dXUc0AM5YyJGVARdeNJtcPWclgUFkU4IgJaimBLLBy0=;
        b=gZ6cc/8yzMN93tOp2DvshBUAQ1cusjOnRS0AMGJDoyqX1+rHBNovJHbGTKd9M1J1za
         BPmNrT53wE3AuTnyLtgYk3LU8rcrzQgO2qDTl9lo7+Eb/uQvrpNEcSbmDFADNIOC6oJq
         e0sJcLQsPcLkN8CcuOKyhxYpPwdneyEOdSw5yzwUmLhiUvmuAhRLL079cO8Q8Uznfwpq
         IJt3JfbAwSPQ/Ud/8Am9V+CXk/oX4aMwi+jQ0QUOCRTN0ZCSw5nZGJ09IJHMrnQ4FWbZ
         Y4wQjNz+VGicdrg0JWmX9zrwxIIVONnp32DxMDeo4RJiVeawV5pW5lGDEXCob/y45Tql
         Qr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683793196; x=1686385196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXUc0AM5YyJGVARdeNJtcPWclgUFkU4IgJaimBLLBy0=;
        b=Kmzz2FIr45+qIjOCuSD6Fk5zoRe+DIXJhfrB0IRIHSldA+o7n+WFzAR+LlFSct0c+H
         pZAjlHj7jVREDYloh/7eDUmsV730jCMflJC4EoY5ikbLFFAza1T8ywyH2W9MTaNFwOiG
         +Y5OqZYT2CxqY2j4LfOXokuX57BsY/ui+7e/Ow8MseZGCNExCVbyLWVG3xsCCXvMwUYg
         1nyRS3pQPLILjnRxbzx6Gqu6wnJkF0FNvmm6LKpXIow4GQXe9hqVFUiYTN9tX5X/aVsl
         LMcCe4oI+uWAwyZECJHmiPgdcg0kqOfzCAKhRb81LBIvY4Y57l506hmgP5ft1bRbzZZk
         mDRA==
X-Gm-Message-State: AC+VfDz7l/Qcd32yvwZrJgoJplLzQIz8sAkCG4euTlk0gXeGfq383eAh
        hQ/UlS3e89IBD/jW3VVay2w/+aXbEUpR3vItQ/IkyA==
X-Google-Smtp-Source: ACHHUZ6hLwUil/od1v0wksCZxQwWFOm0Sib5lsOFqEc6+f5QuQwsg831STGVh9ufZC/JFJMamzmcRJiRtn/+iYdRgeg=
X-Received: by 2002:a17:907:9694:b0:96a:1ec1:2c9f with SMTP id
 hd20-20020a170907969400b0096a1ec12c9fmr5715805ejc.12.1683793196058; Thu, 11
 May 2023 01:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
 <20230505173012.881083-3-etienne.carriere@linaro.org> <CAFA6WYN4yjjedmsS4nAgR5L7OOTRAcKs7STW0YjCC7XsdfYzkA@mail.gmail.com>
 <CAN5uoS8eSfeu-BaV5dhbB15q_iGjcd9BKDpp_hEBaBdb4_qbAg@mail.gmail.com>
 <CAN5uoS99hfjE404_UCm+F4bdVgSfB6Eg_3d1JvHCc2GgSzdUog@mail.gmail.com> <CAFA6WYPUWjK97H5DL-eOT2bjsa79Zrvk4wet2AW0Qb0NOVqt7Q@mail.gmail.com>
In-Reply-To: <CAFA6WYPUWjK97H5DL-eOT2bjsa79Zrvk4wet2AW0Qb0NOVqt7Q@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 11 May 2023 10:19:45 +0200
Message-ID: <CAN5uoS8HF5ymsjkLthFnoQxBHQ3TOVonycTH3g5K76qKzUniuA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tee: optee: support tracking system threads
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 at 09:27, Sumit Garg <sumit.garg@linaro.org> wrote:
> (snip)
> > > > >
> > > > > +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> > > > > +{
> > > > > +       bool rc = false;
> > > > > +
> > > > > +       mutex_lock(&cq->mutex);
> > > > > +
> > > > > +       /* Leave at least 1 normal (non-system) thread */
> > > >
> > > > IMO, this might be counter productive. As most kernel drivers open a
> > > > session during driver probe which are only released in the driver
> > > > release method.
> > >
> > > It is always the case?
> >
> > This answer of mine is irrelevant. Sorry,
> > Please read only the below comments of mine, especially:
> > | Note that an OP-TEE thread is not bound to a TEE session but rather
> > | bound to a yielded call to OP-TEE.
> >
> > >
> > > > If the kernel driver is built-in then the session is
> > > > never released. Now with system threads we would reserve an OP-TEE
> > > > thread for that kernel driver as well which will never be available to
> > > > regular user-space clients.
> > >
> > > That is not true. No driver currently requests their TEE thread to be
> > > a system thread.
> > > Only SCMI does because it needs to by construction.
> > >
>
> Yes that's true but what prevents future/current kernel TEE drivers
> from requesting a system thread once we have this patch-set landed.

Only clients really needing this system_thread attribute should request it.
If they really need, the OP-TEE firmware in secure world should
provision sufficient thread context.

>
> > >
> > > > So I would rather suggest we only allow a
> > > > single system thread to be reserved as a starting point which is
> > > > relevant to this critical SCMI service. We can also make this upper
> > > > bound for system threads configurable with default value as 1 if
> > > > needed.
> >
> > Note that SCMI server can expose several SCMI channels (at most 1 per
> > SCMI protocol used) and each of them will need to request a
> > system_thread to TEE driver.
> >
> > Etienne
> >
> > >
> > > Reserving one or more system threads depends on the number of thread
> > > context provisioned by the TEE.
> > > Note that the implementation proposed here prevents Linux kernel from
> > > exhausting TEE threads so user space always has at least a TEE thread
> > > context left available.
>
> Yeah but on the other hand user-space clients which are comparatively
> larger in number than kernel clients. So they will be starved for
> OP-TEE thread availability. Consider a user-space client which needs
> to serve a lot of TLS connections just waiting for OP-TEE thread
> availability.

Note that OP-TEE default configuration provisions (number of CPUs + 1)
thread context, so the situation is already present before these
changes on systems that embedded an OP-TEE without a properly tuned
configuration. As I said above, Linux kernel cannot be responsible for
the total number of thread contexts provisioned in OP-TEE. If the
overall system requires a lot of TEE thread contexts, one should embed
a suitable OP-TEE firmware.

>
> > >
> > > Note that an OP-TEE thread is not bound to a TEE session but rather
> > > bound to a yielded call to OP-TEE.
>
> tee_client_open_session()
>   -> optee_open_session()
>
> tee_client_system_session()
>   -> optee_system_session()
>     -> optee_cq_inc_sys_thread_count()       <- At this point you
> reserve a system thread corresponding to a particular kernel client
> session
>
> All tee_client_invoke_func() invocations with a system thread capable
> session will use that reserved thread.
>
> tee_client_close_session()
>   -> optee_close_session()
>     -> optee_close_session_helper()
>       -> optee_cq_dec_sys_thread_count()    <- At this point the
> reserved system thread is released
>
> Haven't this tied the system thread to a particular TEE session? Or am
> I missing something?

These changes do not define an overall single system thread.
If several sessions requests reservation of TEE system thread, has
many will be reserved.
Only the very sessions with its sys_thread attribute set will use a
reserved thread. If such a kernel client issues several concurrent
calls to OP-TEE over that session, it will indeed consume more
reserved system threads than what is actually reserved. Here I think
it is the responsibility of such client to open as many sessions as
requests. This is what scmi/optee driver does (see patch v6 4/4). An
alternative would be to have a ref count of sys_thread in session
contexts rather than a boolean value. I don't think it's worth it.

> > > > > (snip)
> > > > > @@ -281,9 +281,10 @@ static int optee_to_msg_param(struct optee *optee,
> > > > >  static void optee_enable_shm_cache(struct optee *optee)
> > > > >  {
> > > > >         struct optee_call_waiter w;
> > > > > +       bool system_thread = false;
> > > >
> > > > This variable is redundant.
> > >
> > > Using a variable here makes it more clear which argument is passed to
> > > optee_cq_wait_init().
> > > Calling optee_cq_wait_init(&optee->call_queue, &w, false); is less readable.
> > >
>
> The function declaration is always there to read about the arguments.
> IMO, variables with a constant value which are only used once don't
> add any value.

Ok, i'll address that. Actually I see that optee_shm_register() and
optee_shm_unregister() (patch v6 1/4) do use false straight as an
argument.

etienne

>
> -Sumit
>
> > > >
> > > > >
> > > > >         /* We need to retry until secure world isn't busy. */
> > > > > -       optee_cq_wait_init(&optee->call_queue, &w);
> > > > > +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
> > > > >         while (true) {
> > > > >                 struct arm_smccc_res res;
> > > > >
> > > > > (snip)
