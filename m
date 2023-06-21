Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972FD7378E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFUCIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFUCIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:08:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A61198B;
        Tue, 20 Jun 2023 19:08:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6686a1051beso3024497b3a.1;
        Tue, 20 Jun 2023 19:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687313328; x=1689905328;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z1FdXPAdBbAS8vpnEBAJMrThm+NfoZMxij9njmv4SA=;
        b=hpCaR0h9USHnRpS0w6eA3vkduGXrVzIBFTcxsfUVeSXZYl1iiJ77bzLnuE9dEkC87f
         /2Sn0x/SQVL9bncTX7ClF/hxK3Pqouf7NMw84gxo37b40J+u6QYlQcX6TtozcC17+KIf
         JO4ymI0eP+fPe12ZwFsBDjLf7LBvDJNexQwZ9UpwXDapGmP/FuCdNw6ZXFV8vcKlFE9T
         1qABiKhElXNZKbeO/AgjrQvHHiXkPCGdA5EjZa4iff/SjniOvGeEJ5YWJ2rSyAMDLlDh
         /fpVjkdOW/JECTNDaBPx1R1nuv32cA42GB8wFr3hRbju0H7dfDpyZcWiYOlE+g4ou+mZ
         FRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687313328; x=1689905328;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z1FdXPAdBbAS8vpnEBAJMrThm+NfoZMxij9njmv4SA=;
        b=fsDfj7J6zhHbAhI2zSUouRKynp/xby8wbpUuFqG/gLKHFdN7wPySzSBgU8Kxhkk+Yo
         RgyhM0xN8dOOCLHIilQo+vNOMG0x+uFKV4Hk4Z0Bzlo52Jk7IgqufP3RT+b4OhMNvr7e
         b7HX9N6a7n6Rk57b9jKgZ9XZcvyxdmh0hG0UWTbX6nAZMwrw6ZELM10CC+XUhnKznX0J
         T204v4c0gPz774XyYlukZ0kAqVl9QIL41UkHRNhj39U5QMT//0FZJo+CsGgvnne1apBP
         ybZCwkmZd1VpUyjMEDhO3jLE2k4QjhLvH+RCbnq48i8lbiMX96NkejJ/akzsT2UOpmJv
         +j2w==
X-Gm-Message-State: AC+VfDwm3taqBICTuBjWsISUMTZ1pRHT3TX0GxlroGD0pORHhWf3cf/v
        nvTW3ipW3km5CTm1UDK60ZrZhvnA+sQ=
X-Google-Smtp-Source: ACHHUZ68DUPWge3DRzDNYfQsKrTkVm9kcJu0O8Ts2E4cUrs3GHypq4gJYKQ+Z0foJ55pIHQmbSezxg==
X-Received: by 2002:a05:6a20:3d02:b0:121:c6cf:f96e with SMTP id y2-20020a056a203d0200b00121c6cff96emr9721684pzi.25.1687313327733;
        Tue, 20 Jun 2023 19:08:47 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id r7-20020a63fc47000000b005533f154df1sm1987931pgk.2.2023.06.20.19.08.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2023 19:08:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v2] rcu: Add necessary WRITE_ONCE()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <50c4aa37-388b-449c-8184-00a9d69471fc@paulmck-laptop>
Date:   Wed, 21 Jun 2023 10:08:28 +0800
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9A94CB4-DB9B-43D2-9D34-ADB4F7EA737D@gmail.com>
References: <20230620171346.207076-1-mmpgouride@gmail.com>
 <50c4aa37-388b-449c-8184-00a9d69471fc@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8821=E6=97=A5 06:26=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jun 20, 2023 at 05:13:46PM +0000, Alan Huang wrote:
>> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") and
>> commit 860c8802ace1("rcu: Use WRITE_ONCE() for assignments to
>> ->pprev for hlist_nulls") added various WRITE_ONCE() to pair with
>> the READ_ONCE() in hlist_unhashed_lockless(), but there are still
>> some places where WRITE_ONCE() was not added, this commit adds that.
>>=20
>> Also add WRITE_ONCE() to pair with the READ_ONCE() in hlist_empty().
>>=20
>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>=20
> On hlist_nulls_add_tail_rcu(), good catch, thank you!
>=20
> On the others, are there really cases where a lockless read races with
> the update?  At first glance, that sounds like a usage bug.  For =
example,
> as I understand it, when you use something like hlist_del(), you are
> supposed to ensure that there are no concurrent readers.  Which is the
> point of the assignment of the special value LIST_POISON2, right?

Do you mean there are cases where a lockless read races with =
hlist_add_head/hlist_add_before
hlist_add_behind/__hlist_del, but there is no real case where a lockless =
read races with the hlist_del_init/hlist_del
hlist_move_list?

There may be no real case where a lockless read races with the =
hlist_del_init/hlist_del
hlist_move_list. But for the sake of completeness, I added those =
WRITE_ONCE, after all, if there is WRITE_ONCE
in __hlist_del, why not add WRITE_ONCE in its caller, like hlist_del()?

Thanks,
Alan

>=20
> Or is there some use case that I am missing?
>=20
> If I am not missing something, then switching the non-RCU APIs to
> WRITE_ONCE() would be a step backwards, because it would make it =
harder
> for tools like KCSAN to find bugs.
>=20
> Thanx, Paul
>=20
>> ---
>> Changelog:
>> V1 -> V2:=20
>>  Add WRITE_ONCE in hlist_del_init to pair with READ_ONCE in
>>  hlist_unhashed_lockless.
>>=20
>> include/linux/list.h          | 9 +++++----
>> include/linux/list_nulls.h    | 2 +-
>> include/linux/rculist_nulls.h | 2 +-
>> 3 files changed, 7 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/include/linux/list.h b/include/linux/list.h
>> index ac366958ea..3a29b95bfe 100644
>> --- a/include/linux/list.h
>> +++ b/include/linux/list.h
>> @@ -912,7 +912,7 @@ static inline void hlist_del(struct hlist_node =
*n)
>> {
>> __hlist_del(n);
>> n->next =3D LIST_POISON1;
>> - n->pprev =3D LIST_POISON2;
>> + WRITE_ONCE(n->pprev, LIST_POISON2);
>> }
>>=20
>> /**
>> @@ -925,7 +925,8 @@ static inline void hlist_del_init(struct =
hlist_node *n)
>> {
>> if (!hlist_unhashed(n)) {
>> __hlist_del(n);
>> - INIT_HLIST_NODE(n);
>> + n->next =3D NULL;
>> + WRITE_ONCE(n->pprev, NULL);
>> }
>> }
>>=20
>> @@ -1026,8 +1027,8 @@ static inline void hlist_move_list(struct =
hlist_head *old,
>> {
>> new->first =3D old->first;
>> if (new->first)
>> - new->first->pprev =3D &new->first;
>> - old->first =3D NULL;
>> + WRITE_ONCE(new->first->pprev, &new->first);
>> + WRITE_ONCE(old->first, NULL);
>> }
>>=20
>> #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
>> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
>> index fa6e8471bd..b63b0589fa 100644
>> --- a/include/linux/list_nulls.h
>> +++ b/include/linux/list_nulls.h
>> @@ -95,7 +95,7 @@ static inline void hlist_nulls_add_head(struct =
hlist_nulls_node *n,
>>=20
>> n->next =3D first;
>> WRITE_ONCE(n->pprev, &h->first);
>> - h->first =3D n;
>> + WRITE_ONCE(h->first, n);
>> if (!is_a_nulls(first))
>> WRITE_ONCE(first->pprev, &n->next);
>> }
>> diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
>> index ba4c00dd80..c65121655b 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -138,7 +138,7 @@ static inline void =
hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>>=20
>> if (last) {
>> n->next =3D last->next;
>> - n->pprev =3D &last->next;
>> + WRITE_ONCE(n->pprev, &last->next);
>> rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>> } else {
>> hlist_nulls_add_head_rcu(n, h);
>> --=20
>> 2.34.1
>>=20

