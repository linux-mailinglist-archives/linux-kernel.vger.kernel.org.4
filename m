Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576166AAF08
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCEK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCEK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:29:20 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12BD302
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 02:29:18 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z42so6688797ljq.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678012157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzkzPKjLjmcIIk+MXeDNFz8SlV10tGBtTo3+SDfOWQ0=;
        b=Lt+13Q44DHx4wQTpK09D4hVuLpRv9ubsVbqbBVuHOItnLRqBRs+MPYPTdyBVau1Pxs
         jFBd/orrXfd0AYH5C5Fq6orWxbQIxtYbdO5hmM0t9Wsvt0RwQvOE0+w0XdXnaV+3BsWD
         E7Mwi1w8/ao5HWnsXoYqH94ThgzGYHhwkRkL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678012157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzkzPKjLjmcIIk+MXeDNFz8SlV10tGBtTo3+SDfOWQ0=;
        b=tQYo2ZYMnyALACuShO8oWaXLh19lPBiTwS2UME588nf88UP4yeCBb0NL3N5rUOFCrL
         nl0r7zdRu7tW8XvWN1xxLuVBT8RVEKaCW4owz8t1O1NNEQXjl2IMmdo7/RHp6or357V4
         QSXcWOnAV9P3UIbCChj3QqhzgoSfv3THPzheLODlnSrJdb3+FuRaWArfCMO0lT2xK0Ml
         x5v/w1Y5ceEu3/h9GYCWNV9ylemy3PCN+K/46IvbcT1XUENVKqU0n3Vmrtc910UpR9sy
         5qQd2jIzG7dh/+W1YCHHh3v13iRZ9HfNKkMemKdOHlkm9VpYs8Byxk/AHyI/XhwH2STb
         1yuw==
X-Gm-Message-State: AO0yUKWLmrdHprfeG3f/5uVWh+YeaIP1z7+L6oKyIV/iqVwfWbmSekna
        rDPv7TwdWWa0/JYwF13JnN8Yx8Yzs+973h8kYZwMow==
X-Google-Smtp-Source: AK7set9YeJqnuTO6GPbeUeUubABtFPqDdNiBrtFeQv+RspFfojeCZKWsLOwNkmYeASAE4pZ5Cw/UFo4qE/Itjav+e2I=
X-Received: by 2002:a05:651c:b9b:b0:293:4e6d:f4f7 with SMTP id
 bg27-20020a05651c0b9b00b002934e6df4f7mr2157714ljb.3.1678012156960; Sun, 05
 Mar 2023 02:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20230201150954.409693-1-urezki@gmail.com> <20230201150954.409693-4-urezki@gmail.com>
In-Reply-To: <20230201150954.409693-4-urezki@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 5 Mar 2023 05:29:11 -0500
Message-ID: <CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com>
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single
 argument macro
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

On Wed, Feb 1, 2023 at 10:11=E2=80=AFAM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
>
> For a single argument invocations a new kfree_rcu_mightsleep()
> and kvfree_rcu_mightsleep() macroses are used. This is done in
> order to prevent users from calling a single argument from
> atomic contexts as "_mightsleep" prefix signals that it can
> schedule().
>

Since this commit in -dev branch [1] suggests more users still need
conversion, let us drop this single patch for 6.4 and move the rest of
the series forward? Let me know if you disagree.
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commi=
t/?h=3Ddev&id=3D9bf5e3a2626ed474d080f695007541b6ecd6e60b

All -- please supply Ack/Review tags for patches 1-12.

thanks,

 - Joel


> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 094321c17e48..7571dbfecb18 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -957,9 +957,8 @@ static inline notrace void rcu_read_unlock_sched_notr=
ace(void)
>
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
> - * @ptr: pointer to kfree for both single- and double-argument invocatio=
ns.
> - * @rhf: the name of the struct rcu_head within the type of @ptr,
> - *       but only for double-argument invocations.
> + * @ptr: pointer to kfree for double-argument invocations.
> + * @rhf: the name of the struct rcu_head within the type of @ptr.
>   *
>   * Many rcu callbacks functions just call kfree() on the base structure.
>   * These functions are trivial, but their size adds up, and furthermore
> @@ -982,26 +981,18 @@ static inline notrace void rcu_read_unlock_sched_no=
trace(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
> +#define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
> +#define kvfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>
>  /**
> - * kvfree_rcu() - kvfree an object after a grace period.
> - *
> - * This macro consists of one or two arguments and it is
> - * based on whether an object is head-less or not. If it
> - * has a head then a semantic stays the same as it used
> - * to be before:
> - *
> - *     kvfree_rcu(ptr, rhf);
> - *
> - * where @ptr is a pointer to kvfree(), @rhf is the name
> - * of the rcu_head structure within the type of @ptr.
> + * kfree_rcu_mightsleep() - kfree an object after a grace period.
> + * @ptr: pointer to kfree for single-argument invocations.
>   *
>   * When it comes to head-less variant, only one argument
>   * is passed and that is just a pointer which has to be
>   * freed after a grace period. Therefore the semantic is
>   *
> - *     kvfree_rcu(ptr);
> + *     kfree_rcu_mightsleep(ptr);
>   *
>   * where @ptr is the pointer to be freed by kvfree().
>   *
> @@ -1010,13 +1001,9 @@ static inline notrace void rcu_read_unlock_sched_n=
otrace(void)
>   * annotation. Otherwise, please switch and embed the
>   * rcu_head structure within the type of @ptr.
>   */
> -#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,          \
> -       kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
> -
> +#define kfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
>  #define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
> -#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
>
> -#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
>  #define kvfree_rcu_arg_2(ptr, rhf)                                     \
>  do {                                                                   \
>         typeof (ptr) ___p =3D (ptr);                                     =
 \
> --
> 2.30.2
>
