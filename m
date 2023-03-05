Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93BF6AAF2C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCEKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCEKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:49:50 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EFF93D7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 02:49:48 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z6so7744681qtv.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678013388;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4MTJzsZa3uG483i35oT8izfur7qwLIzHaERwAfP6u0=;
        b=ejdbobOAWTA4FtzSnRUsWF2aiTuK6I10L1fX1Xth2T56/vDyAKd6+pLybnilzZe+Hm
         vX5/kTcS7lUL8SgjNi49ozGoXwAz5fA7FP3zmB7O00a9XOd4pWFkrSv3ztT61dPlVN0q
         SBzbuCL0VxZveJ/rpPuS1x5dNvfvkxDmyKxTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678013388;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4MTJzsZa3uG483i35oT8izfur7qwLIzHaERwAfP6u0=;
        b=LKRS0EdCK941/nF/NKrb7SrZacoJXiyN2qf2R3GSumNIXDQLaTfwyoqZV6ccijlglj
         58xnccRYTBGJ/ez19+Ams5j9fI6MThCPCJb1eI0+Vimo0svE3mCMIt5XfDy2njAoj9+l
         1iRnLGUr0MBeirfHDrr5d9WM9C0yVIYVrAtXlnhm3rtESj+3HCGcgQ1PrAvXWkdZHXrm
         RYXdcLzCf6XpQMLVsVs8YtfcJ9j7232Wn52ZekqxU7iIk8pamE5wiZoxTxGZCQ1y5sIr
         TWoEvnLJfc1glqi3DfxiUaKxPA6lyMpiIfBlnfB873eG4EkvLGh+WRq1jlA6y/wcvQlv
         cu8A==
X-Gm-Message-State: AO0yUKXSH0AbsJFCy9rU9r0a2VpKsCD/aaZ/I0MDFxpFct7H0baccdaG
        uxzsQ/5f0/H/xXfOIHWI91zFTw==
X-Google-Smtp-Source: AK7set9+6sThLr05pCpmFdza6ysVq3tV6Y+XlpNijvkiGDcdpuwa4lCs5A7fcFfnp9txXK+eYSeUUg==
X-Received: by 2002:ac8:5dd0:0:b0:3b6:3a12:2bf9 with SMTP id e16-20020ac85dd0000000b003b63a122bf9mr11992714qtx.2.1678013387789;
        Sun, 05 Mar 2023 02:49:47 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b86e:a2b7:6c59:a244:64b9:60c5])
        by smtp.gmail.com with ESMTPSA id x13-20020ac8120d000000b003bffe7fdc38sm5402841qti.9.2023.03.05.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 02:49:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
Date:   Sun, 5 Mar 2023 05:49:35 -0500
Message-Id: <A3933CE1-1C8A-4E9B-9E10-828CB2CE34AA@joelfernandes.org>
References: <CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
In-Reply-To: <CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wrote:=

>=20
> =EF=BB=BFHi, All,
>=20
>> On Wed, Feb 1, 2023 at 10:11=E2=80=AFAM Uladzislau Rezki (Sony)
>> <urezki@gmail.com> wrote:
>>=20
>> For a single argument invocations a new kfree_rcu_mightsleep()
>> and kvfree_rcu_mightsleep() macroses are used. This is done in
>> order to prevent users from calling a single argument from
>> atomic contexts as "_mightsleep" prefix signals that it can
>> schedule().
>>=20
>=20
> Since this commit in -dev branch [1] suggests more users still need
> conversion, let us drop this single patch for 6.4 and move the rest of
> the series forward? Let me know if you disagree.
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/comm=
it/?h=3Ddev&id=3D9bf5e3a2626ed474d080f695007541b6ecd6e60b
>=20
> All -- please supply Ack/Review tags for patches 1-12.

Or put another way, what is the transition plan for these remaining users?

I am getting on a plane right now but I can research which users are remaini=
ng later.

 - Joel


>=20
> thanks,
>=20
> - Joel
>=20
>=20
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> ---
>> include/linux/rcupdate.h | 29 ++++++++---------------------
>> 1 file changed, 8 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> index 094321c17e48..7571dbfecb18 100644
>> --- a/include/linux/rcupdate.h
>> +++ b/include/linux/rcupdate.h
>> @@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notr=
ace(void)
>>=20
>> /**
>>  * kfree_rcu() - kfree an object after a grace period.
>> - * @ptr: pointer to kfree for both single- and double-argument invocatio=
ns.
>> - * @rhf: the name of the struct rcu_head within the type of @ptr,
>> - *       but only for double-argument invocations.
>> + * @ptr: pointer to kfree for double-argument invocations.
>> + * @rhf: the name of the struct rcu_head within the type of @ptr.
>>  *
>>  * Many rcu callbacks functions just call kfree() on the base structure.
>>  * These functions are trivial, but their size adds up, and furthermore
>> @@ -982,26 +981,18 @@ static inline notrace void rcu_read_unlock_sched_no=
trace(void)
>>  * The BUILD_BUG_ON check must not involve any function calls, hence the
>>  * checks are done in macros here.
>>  */
>> -#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
>> +#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>> +#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>>=20
>> /**
>> - * kvfree_rcu() - kvfree an object after a grace period.
>> - *
>> - * This macro consists of one or two arguments and it is
>> - * based on whether an object is head-less or not. If it
>> - * has a head then a semantic stays the same as it used
>> - * to be before:
>> - *
>> - *     kvfree_rcu(ptr, rhf);
>> - *
>> - * where @ptr is a pointer to kvfree(), @rhf is the name
>> - * of the rcu_head structure within the type of @ptr.
>> + * kfree_rcu_mightsleep() - kfree an object after a grace period.
>> + * @ptr: pointer to kfree for single-argument invocations.
>>  *
>>  * When it comes to head-less variant, only one argument
>>  * is passed and that is just a pointer which has to be
>>  * freed after a grace period. Therefore the semantic is
>>  *
>> - *     kvfree_rcu(ptr);
>> + *     kfree_rcu_mightsleep(ptr);
>>  *
>>  * where @ptr is the pointer to be freed by kvfree().
>>  *
>> @@ -1010,13 +1001,9 @@ static inline notrace void rcu_read_unlock_sched_n=
otrace(void)
>>  * annotation. Otherwise, please switch and embed the
>>  * rcu_head structure within the type of @ptr.
>>  */
>> -#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,          \
>> -       kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
>> -
>> +#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>> #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>> -#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
>>=20
>> -#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
>> #define kvfree_rcu_arg_2(ptr, rhf)                                     \
>> do {                                                                   \
>>        typeof (ptr) ___p =3D (ptr);                                      \=

>> --
>> 2.30.2
>>=20
