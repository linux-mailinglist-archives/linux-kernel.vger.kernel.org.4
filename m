Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631D76F4F72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjECEY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1092683
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683087820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orSkx/1be5MWUXjh1xr5ECEtOCT6SB/XNpXgwJD5H1Q=;
        b=Rr39JgZOKGuaIukRzAxjhdFZmYGFWhnFwn5qvZwz75gak2e8asmWMJRSavzG0dH6+o0X8I
        F2TR45S+uvTSjdXe7hFtW9ImDwGJ5ZuCfA0+NMMzBya/PRpoXfw/QfyGSAJ7X0wQu4oWyA
        D8pXIJ71qJ+VIjaeoBqMVMwuvM1Bh1w=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MyysBoN5PuCq05FgWaQcig-1; Wed, 03 May 2023 00:23:36 -0400
X-MC-Unique: MyysBoN5PuCq05FgWaQcig-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6a5f1bc4b26so3434272a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 21:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683087816; x=1685679816;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orSkx/1be5MWUXjh1xr5ECEtOCT6SB/XNpXgwJD5H1Q=;
        b=fcBXjLPGjGMh5NtUP1nuXpSdtf0tH/19yc9qF6dMGog2S4dXANhhlzbz5WVMgFM1Ld
         Q9+bCi/NNi9Uma7lEdPIAmsvKyW00azZ537IjyA3Bi6b/Sf4XKRDiOc4M30ACIwddzKs
         o7WbsM8cnuxdAqWdNFNOINF4s4DRpWqx7UBlKDzAkPzbYKhiTTyoKibzQqH3AykQ4dDD
         sr17IvmKjPrz8zUTDOnQa13H5WqLBmfjiuv7yh2Rl7ew7hhE2GCl4NkpH50IYuRFAfRF
         /yvLXZhWxhKhdtTEGnw3NVtTDP6eAMIAV0/qEwCv8UdQrTEH2h+abLvqElG8d1N5MtFt
         J6hQ==
X-Gm-Message-State: AC+VfDztfyclfVqNDTzToNvZ59jwLp4SELpixlSaM+CHidpwgm+0EHWy
        XbO1LDviveieeFWrS5i8X+i78DKZsMU2p5FoWVJ7gZ30inMwTERf3BqGY5qk/1Aza2h83WWjdoW
        3+GhDGwQXBhKElhKifRLrYnKb
X-Received: by 2002:a05:6871:3d6:b0:184:3f99:c982 with SMTP id a22-20020a05687103d600b001843f99c982mr10263745oag.20.1683087816240;
        Tue, 02 May 2023 21:23:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65O8KObLiZbBW/Kc9xGueUDr3zfhLQ7U/ZRakIOyacynsT02MgHQRoHcpfapsfUQYPofS0vw==
X-Received: by 2002:a05:6871:3d6:b0:184:3f99:c982 with SMTP id a22-20020a05687103d600b001843f99c982mr10263739oag.20.1683087815999;
        Tue, 02 May 2023 21:23:35 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:fb9f:720f:65e5:7914:9a9b? ([2804:1b3:a802:fb9f:720f:65e5:7914:9a9b])
        by smtp.gmail.com with ESMTPSA id l1-20020a4a4341000000b005421d52de9csm1792694ooj.45.2023.05.02.21.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 21:23:35 -0700 (PDT)
Message-ID: <aef178472265e86b89f2af2632b95b8cd1d2d321.camel@redhat.com>
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
Date:   Wed, 03 May 2023 01:23:30 -0300
In-Reply-To: <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406095519.GG386572@hirez.programming.kicks-ass.net>
         <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-19 at 00:45 -0300, Leonardo Br=C3=A1s wrote:
> On Thu, 2023-04-06 at 11:55 +0200, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
> > > When running RT workloads in isolated CPUs, many cases of deadline mi=
sses
> > > are caused by remote CPU requests such as smp_call_function*().
> > >=20
> > > For those cases, having the names of those functions running around t=
he
> > > deadline miss moment could help finding a target for the next improve=
ments.
> > >=20
> > > Add tracepoints for acquiring the funtion name & argument before entr=
y and
> > > after exitting the called function.
> > >=20
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> >=20
> > How are the patches queued there not sufficient?
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dsm=
p/core


Hello Peter,=20

The trace I proposed will run in the CPU which received the request, not in=
 the
one which originated it. Meaning the trace will run in "cpu" from
smp_call_function*(cpu,...)

IIUC the trace introduced by the commits in tip/smp/core (which you pointed=
)
will run in the cpu which calls smp_call_function*(), which is different fr=
om
above.

Did I get it right?
Could you please help me understand how the commits in tip/smp/core are
sufficient for my scenario?

Thanks!
Leo



> >=20
>=20
> IIUC the last commits add tracepoints that are collected in the
> requesting CPU, at the moment of scheduling the IPI, which are also usefu=
l in
> some scenarios.
>=20
> On my scenario, it could help a little,=C2=A0since it makes possible to f=
ilter what
> all other cpus are scheduling on the requested cpu. OTOH it could be also=
 be
> misleading, as the requested cpu could be running something that was sche=
duled
> way before.
>=20
> The change I propose does exactly what my scenario need: track exactly wh=
ich
> function was running at given time in the requested CPU. With this info, =
we can
> check which (if any) remotely requested function was running on given tim=
e
> window.
>=20
> (An unrelated thing I just thought: We could even use the commits you poi=
nted
> together with my proposed change in order to measure how long does it tak=
e for a
> requested function to run / complete in the requested cpu)
>=20
> Thanks for reviewing!
>=20
> Leo

