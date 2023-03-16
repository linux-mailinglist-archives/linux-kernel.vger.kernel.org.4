Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE26BC52D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 05:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCPEQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 00:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPEQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 00:16:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707288DBF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 21:16:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id cj14so434705ybb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 21:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678940210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHbcdUicUjbi8KR/m+/4TmqyAHSqQeOMUiRGySIU9BQ=;
        b=l2bm8SADDpl8FwWiWI1+QSr47QYr/QoZMySI7WR+fxIMtdzno508VGTM0zxqRRNya0
         bD+6kcaTOGH+Ya1syAzCrmE9TT76mZ30nOR/iTsJX33hykbJxX4jev8j5gOLGmRpNvrE
         sjx4zxWsZYYvAysW8vyyn3YMWbRMmym6F8b9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678940210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHbcdUicUjbi8KR/m+/4TmqyAHSqQeOMUiRGySIU9BQ=;
        b=k2u7IK8NzRpRaDTYFqP6WcMC43wYqTMdaEed/A1KBtoPuty1ppSBDTSpSHlwc6khuD
         tkHzvGm2TvL8nfFbmEW+m+uikoAthRPXV/VHQTPt8yWp4Q8Xs+Sef4mvChIieVr70uw8
         Ox+TympPBB52nSmmUS+mxYoT3a+hYnfjYfSDAH+Dn/QGq4UNftBbsC+Si485jyfvLQnK
         svTen7n9Wb88HSsj+VCP3YmEV4FhZObvPhSAxk12145NqOKBLVPIRt6odxFnz1uKkOPP
         7KAjtUN84CmCEo5j6cLySxOV4FLKj8BKy8NZk/RD1jyAxjPrJlm0iSr+U8hNbxIfv0mm
         OT+Q==
X-Gm-Message-State: AO0yUKUGDlS50El0FP/lNXNssIU1JR2X8lUMa3k6AN5NDSpk7AtmhFVi
        h/f4h15tQt+tnm3P/Uvsjdp+Y+SXRpHfSCz2PSdUIg==
X-Google-Smtp-Source: AK7set+695oeOtFXArCWwu0RyLTOg+QDTyLxpsLt6vmfW6C2axZADbShGl29nN1/4n9CuPjTlBJ+kyXMCScZ0U8GcOk=
X-Received: by 2002:a25:9292:0:b0:b3a:e877:3290 with SMTP id
 y18-20020a259292000000b00b3ae8773290mr8840567ybl.2.1678940210630; Wed, 15 Mar
 2023 21:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636> <20230315183648.5164af0f@gandalf.local.home>
 <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk> <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
 <20230315222323.7afe82e7@gandalf.local.home> <29b54f07-b4ce-4eab-bbc2-281672bca5a5@paulmck-laptop>
In-Reply-To: <29b54f07-b4ce-4eab-bbc2-281672bca5a5@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 00:16:39 -0400
Message-ID: <CAEXW_YRr_fpkNAF8dFHLt0vGjYeksS+ObUPGgEUJimGpsASKcQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
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

On Wed, Mar 15, 2023 at 11:44=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Mar 15, 2023 at 10:23:23PM -0400, Steven Rostedt wrote:
> > On Wed, 15 Mar 2023 17:37:30 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > >
> > > That does work, and I am guessing that the size increase is not a big
> > > problem for you there.
> >
> > Well, I was fine with it as long as it stayed in the headers, where
> > ugliness is warmly welcomed. Just ask all the #ifdefs.
> >
> > >
> > > > That's a cop out, just removing the one case you care about. Fact i=
s
> > > > the naming is awful, and the 1/2 argument thing is making it worse.
> > > > If a big change is warranted, why not do it right and ACTUALLY
> > > > get it right?
> > >
> > > You both do realize that the kvfree_rcu_mightsleep() definition is
> > > already in mainline, right?
> > >
> > > Anyway, to sum up, kvfree_rcu_mightsleep()--or whatever the entire
> > > community eventually decides to name it--can do any of the following:
> > >
> > > 1.  Put the pointer into an already allocated array of pointers.
> > >
> > > 2.  Allocate a new array of pointers, have the allocation succeed
> > >     without sleeping, then put the pointer into an already allocated
> > >     array of pointers.
> > >
> > > 3.  Allocate a new array of pointers, have the allocation succeed
> > >     after sleeping, then put the pointer into an already allocated
> > >     array of pointers.
> > >
> > > 4.  Attempt to allocate a new array of pointers, have the allocation
> > >     fail (presumably after sleeping), then invoke synchronize_rcu()
> > >     directly.
> > >
> > > Too much fun!  ;-)
> > >
> >
> >   kvfree_rcu_kitchen_sink() ?
> >
> >   kvfree_rcu_goldie_locks()?
> >
> > I honestly like the name "headless" as that perfectly describes the
> > difference between kvfree_rcu(arg1, arg2) and kvfree_rcu(arg1).
> >
> > Whereas mightsleep() is confusing to me because it doesn't tell me why
> > kvfree_rcu() has two args and kvfree_rcu_mightsleep() has only one.
> > Usually, code that has two sleep variants is about limiting the
> > functionality of the atomic friendly one.
>
>         kvfree_rcu_alloc_head()?
>         kvfree_rcu_dynhead()?
>         kvfree_rcu_gearhead()?
>         kvfree_rcu_radiohead()?
>         kvfree_rcu_getahead()?
>
> I don't know about you guys, but to me, kvfree_rcu_mightsleep() is
> sounding better and better by comparison...

Indeed, and one could argue that "headless" sounds like something out
of a horror movie ;-). Which of course does match the situation when
the API is applied incorrectly.

 - Joel
