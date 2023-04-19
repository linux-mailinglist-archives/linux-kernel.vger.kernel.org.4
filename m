Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE45E6E71CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjDSDqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDSDqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB71619C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681875916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YuuAJn1OCoUYnZzUOuo4+29qTgUEGG9kBKj+L9J4Ys=;
        b=N/38go9zuXn/9q/LRUd+mbpEaXk1FVSh9b9XtXuQF+oDuBxZwPeZ5IAXB4MjAiKFEJIiqo
        Inll+9ANPPcI0554T6q6akvkVhfmRV1nLVQcUA0tONXkMCj3Ec2EfxrRv6t2uw8I3PCyjW
        +IonzEX/HxxGstrfR/7gUPyJ8rBMa/k=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-SHAW4dhNMLS6fPlXcjwO5Q-1; Tue, 18 Apr 2023 23:45:14 -0400
X-MC-Unique: SHAW4dhNMLS6fPlXcjwO5Q-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-18aec3062c3so169244fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681875914; x=1684467914;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YuuAJn1OCoUYnZzUOuo4+29qTgUEGG9kBKj+L9J4Ys=;
        b=huyAEpWVgxV23DTSQ0ga7/w6Mit5DmRiTT5NlOO7UBB3D+XTjRDsy/mjeY5dLmPNCJ
         ki+ctpp/Hn10taqxJL5SEnoWjRcZsnlUEhHxMv2RISNfG5FNBdzbJUbQI9Z9pXIxQi4O
         lwGc/ukcFJiVSufdmv7qTb1UqtDT/A+W+HDAt4YgUoXX1m6bTZqbrZmIUrqYrLeEH6cE
         dzvjl1m0u0v/VAWDAxYsAPzf3eHhf7jxsAEQx1hlEvzxVwuvuDSkUw/qhwkJDUwrD218
         8mSMSGvZwDwIQIlXmVt/auzCuBkTF1TFAFN1ZTt2RJq44yo09W7u1g3Q2xOwOZtr3taH
         DYFg==
X-Gm-Message-State: AAQBX9e8jTCblUsf/Rg25cE1GR1lus80+gCIFoSP/3FE078/MnSgRsFe
        XXuRSVE818mXbJQaoXTfW+v/bIhzjmfLvk6dMc8Sbm3xsnJU4T390a3B0ZS96BdfNumyvr/Ebld
        niSnypZuLg2ayGpFfyElF1ESgNQ7HSF/I
X-Received: by 2002:a05:6870:a10e:b0:180:13a4:4256 with SMTP id m14-20020a056870a10e00b0018013a44256mr3219167oae.36.1681875913982;
        Tue, 18 Apr 2023 20:45:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zc/n0XS5LBqwVMuTKQ0TMzDYd+d6AXCJnHrNrZG1OgEaTKc8AHKb0V0BCzMHgpOmku1E/Azg==
X-Received: by 2002:a05:6870:a10e:b0:180:13a4:4256 with SMTP id m14-20020a056870a10e00b0018013a44256mr3219155oae.36.1681875913749;
        Tue, 18 Apr 2023 20:45:13 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c? ([2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c])
        by smtp.gmail.com with ESMTPSA id 26-20020aca101a000000b0038e34b0a0ecsm1249499oiq.8.2023.04.18.20.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 20:45:13 -0700 (PDT)
Message-ID: <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Date:   Wed, 19 Apr 2023 00:45:08 -0300
In-Reply-To: <20230406095519.GG386572@hirez.programming.kicks-ass.net>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406095519.GG386572@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-06 at 11:55 +0200, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
> > When running RT workloads in isolated CPUs, many cases of deadline miss=
es
> > are caused by remote CPU requests such as smp_call_function*().
> >=20
> > For those cases, having the names of those functions running around the
> > deadline miss moment could help finding a target for the next improveme=
nts.
> >=20
> > Add tracepoints for acquiring the funtion name & argument before entry =
and
> > after exitting the called function.
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>=20
> How are the patches queued there not sufficient?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dsmp/=
core
>=20

IIUC the last commits add tracepoints that are collected in the
requesting CPU, at the moment of scheduling the IPI, which are also useful =
in
some scenarios.

On my scenario, it could help a little,=C2=A0since it makes possible to fil=
ter what
all other cpus are scheduling on the requested cpu. OTOH it could be also b=
e
misleading, as the requested cpu could be running something that was schedu=
led
way before.

The change I propose does exactly what my scenario need: track exactly whic=
h
function was running at given time in the requested CPU. With this info, we=
 can
check which (if any) remotely requested function was running on given time
window.

(An unrelated thing I just thought: We could even use the commits you point=
ed
together with my proposed change in order to measure how long does it take =
for a
requested function to run / complete in the requested cpu)

Thanks for reviewing!

Leo

