Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E586D91E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjDFInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjDFInG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE6E79
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680770539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldHV+XIGjqnKLgrogu4ymW/uHw5sLtMqia4m5Dy9/lk=;
        b=LO/0i+5uVFcQ4IIVErcGPYuQuJlle+QwN1rX0L/t6JutnffjNJ5s2GZcG2Hp1n3PeQy3K+
        ySa+ADMGmak7Qqoo8m3oU9nyNfFtRWDClKURzNoSRygYgCauaf7CEMAbr0oQQm2sqJHSrb
        soUUAiJnlBOmRuJ6DNcVbQqqzLC1zdk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-rAu1fEFPMjmSg_7hXXE1Bw-1; Thu, 06 Apr 2023 04:42:17 -0400
X-MC-Unique: rAu1fEFPMjmSg_7hXXE1Bw-1
Received: by mail-qk1-f197.google.com with SMTP id 66-20020a370345000000b00746886b1593so17368716qkd.14
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770537;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldHV+XIGjqnKLgrogu4ymW/uHw5sLtMqia4m5Dy9/lk=;
        b=xRW2Qb5ImI9EHUtQOwZAEkeIvxdKke1ju2I59Dhxke+b4uu0LskUjNSX4DY/sLQJSE
         Qx4XLI+CynW8evIEDDu7+bRCQ8/P9mY9E4C6a9CbBbyHnoVfi2DKiLYH3p1Y8YAk18sL
         /nLLpHebF1Ld4WIJ4194TmVuC2s1DT9iAykcWLpxWb9uZNutMPTP2IyNj6nUBWFrcJ/e
         no7irxj479M5sGpggGF18k+15B0Rgp1dSkjmlxRnlEkuTxTQj2ikpDPkX+C5dhDKTfwN
         4TWTNjlP9Q41nbJqPQ3Vs3+XbEZpNSrjMzVrbOwhec4kbxnI/rBbv3xtcj1uxwyAOtmA
         aPgw==
X-Gm-Message-State: AAQBX9cXTYJLkJv9aB+4ivshpqWDXAVslCeNAeL4s6wL9GcFoLk6fHcI
        e9EGTLAoxNdds2JhjgbKjfET4Hj5KtP9vuveKcRRw67feeYXLQC+l0YJLIxkhUtWSlzCC9LrtWF
        OugltNLMt/Z2owwfgW99Ueaj3
X-Received: by 2002:a05:6214:4111:b0:571:f87:a665 with SMTP id kc17-20020a056214411100b005710f87a665mr3248315qvb.35.1680770536951;
        Thu, 06 Apr 2023 01:42:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350aLUmUZ/m5d7fNwMka9R8oM9oBZuuaGHKpjQzidpRVrnIQl2yfS9DGazmn9qXNJnGVWsuG2Og==
X-Received: by 2002:a05:6214:4111:b0:571:f87:a665 with SMTP id kc17-20020a056214411100b005710f87a665mr3248293qvb.35.1680770536691;
        Thu, 06 Apr 2023 01:42:16 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:2599:3b52:5a:179c:6ae7? ([2804:1b3:a802:2599:3b52:5a:179c:6ae7])
        by smtp.gmail.com with ESMTPSA id dj3-20020a056214090300b005e0d14cf0f6sm347503qvb.124.2023.04.06.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:42:16 -0700 (PDT)
Message-ID: <cf8d18d80222c561da1865514734d92e0e2fb3d5.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Date:   Thu, 06 Apr 2023 05:42:13 -0300
In-Reply-To: <20230406081501.pS4ZnWaK@linutronix.de>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406081501.pS4ZnWaK@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-06 at 10:15 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-04-06 04:57:18 [-0300], Leonardo Bras wrote:
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
> Check
> 	https://lore.kernel.org/20230307143558.294354-1-vschneid@redhat.com
>=20
> Sebastian
>=20

Hello Sebastian, thanks for the heads up!

IIUC Valentin is adding/improving tracepoints that are collected in the
requesting CPU, at the moment of scheduling the IPI, which are also useful.

But on my scenario, would be nice to actually have the information on the t=
ime
window in which the requested function is running in the requested CPU.=C2=
=A0

This would allow us to check how many and which IPIs took too much time to
complete, and caused the RT deadline to miss.=20

(I noticed there is an include/trace/events/ipi.h that could be used instea=
d of
creating a new include/trace/events/smp.h, what is your opinion on this ? )

Please let me know if I am missing something.

Thank you!
Leo

=20

