Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE566BD300
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjCPPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCPPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:12:14 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699B7CA1D7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:11:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5419d4c340aso37475887b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678979517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVmUWXZCS9PKKU1y+efPewzjI1jriQW9gK3C7QPHQmI=;
        b=yo5VHWyyVCg1xHF1UmIReBMU4rFVu8JCPw81j89XpJjNdpx5OhJjPVZG8CxzSHGIer
         GfzkT+46D8v3ghU1HkuyKR5kGho+VcIpndPr3IAiejahgvr28wUamSPDSUuM2GZu5eZz
         bb5Vnv2QV0L+4S3lBXnSrHgBwaBJhejg/ExN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVmUWXZCS9PKKU1y+efPewzjI1jriQW9gK3C7QPHQmI=;
        b=K34OnBer7yxMk1Ep2AabwWGCYq5dz0l1/5GRzLIb5sq3EKK717ZblKq81OIw0SOxq/
         1Pr1a8WGO7USk9kmUa4iAk1rjfTIkmXIkFpNyCV5V43oJDTKd4a9UHk1nbeMEKfBGh4X
         dzoCavOwWu0yMAr1/95O/ULAHFBOCFbM0VJiSrnN3Vl0JsOungk6DoLDcL9KqR9KIu/3
         WBgBnyUGxqSZHZzMOwxXIufWqjMXq1yRahp8LLm6lRoTtF9N8sZ9Z43qyQao4wuYp5et
         2aqkJAbT6MOihcthhf/oPvsiP13xB5sLDB26LmsJ301CZdvf/eReldJvXl2+41B6mWis
         +k1w==
X-Gm-Message-State: AO0yUKXuWfak6yue7mYCvu0E0zu7nXOHZ9aL4n6xA91KoUeulSAsEGvG
        2XRTSNcsICrNVD2z7pYjaZO7+O78NymiW+d+1qUoLg==
X-Google-Smtp-Source: AK7set+BIYWQPa6/+ckcgOXHWt3f+OeuHPskA70Kjgm5ensrebYAAfbuajhP5TZ0Z4HaEx5ZPgh8eX2WvHY9HwHba3M=
X-Received: by 2002:a81:ae5f:0:b0:532:e887:2c23 with SMTP id
 g31-20020a81ae5f000000b00532e8872c23mr2572412ywk.9.1678979517584; Thu, 16 Mar
 2023 08:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-3-joel@joelfernandes.org> <4620911e-6fd5-542e-15d8-7849cc60780b@kernel.org>
In-Reply-To: <4620911e-6fd5-542e-15d8-7849cc60780b@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 11:11:46 -0400
Message-ID: <CAEXW_YSwsMs00vhf5usBVZ9YD8z2U6tjtwK+CNGNYK7oGJ9kGA@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 3:38=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> On 3/15/23 19:18, Joel Fernandes (Google) wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> > switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> > avoid accidental use of the single-argument forms, which can introduce
> > functionality bugs in atomic contexts and latency bugs in non-atomic
> > contexts.
> >
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/trace/trace_osnoise.c | 2 +-
> >  kernel/trace/trace_probe.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.=
c
> > index 04f0fdae19a1..f68ca1e6460f 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -159,7 +159,7 @@ static void osnoise_unregister_instance(struct trac=
e_array *tr)
> >       if (!found)
> >               return;
> >
> > -     kvfree_rcu(inst);
> > +     kvfree_rcu_mightsleep(inst);
> >  }
> >
> >  /*
>
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!

 - Joel
