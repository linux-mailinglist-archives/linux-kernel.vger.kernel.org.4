Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7673836A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjFUMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFUMNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:13:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E501713
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:13:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b472915d1bso2987818a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687349595; x=1689941595;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqVDCbkEpxilUdix2+kmj0eFs9thdqo8/rdk3F0KWIw=;
        b=mPvVFvkEBsa9B3DmV2rhm7xEDwq9dqAk6EgNuO/oX8AUpay26wkpw4MNpFtEp14jzH
         qJsZ1Mc3gnOZL7LVIpzbaF07PJd4oL6n0vh7YmxJcVaRzrhDxQQjtU9XuOfu7zof9L2T
         p1GHX9CKla0ZBxWOX4VTpvxWVm32sQDkobVQ+mpcdjEiiJ7mnMwN8ipWtOZ1vPC1DATN
         0h1TXf5lBYOFtqBa4XFmg8FVJ/oCOTyFlzaxNVUmUXx7voUX8ma5cxf4Id0nht/eaUDb
         pSYn5cpOgjFRysGiGHHFjcWNPkLByZhBmHz4kN9nfApCVrEDksQ3B5Vj1zvh2wPo2UR/
         Yw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349595; x=1689941595;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqVDCbkEpxilUdix2+kmj0eFs9thdqo8/rdk3F0KWIw=;
        b=gKiPvkmAgtsZfiVNR/zbniDmvSIeG6N4j9zi48OrC6GjQSPcIlVf5ONxhYHNs/Nr24
         a/KSU38D4IjxjP+3lBlrq2I4WP1r8TSPYdFtTRlS+Iq6h/GfAGQ13vmUJtVv1rGGaVME
         jTd/lVOxNznrsDQTpL8hx2LBzVMLqXDjUBKkQ+hlboHxV8JT08I25U5Y/euwv58eVO4v
         C9xAawUOlcCdsA4zPI88mPGA6Dia+nlaBKT84JJ4ZksKf/uwjhMCPK9QeoNrS6c+sOvh
         CVvEHzz+aExIACO0LbA1ultMTZxEfKZoJMvRH6+ZhNB15wzf1SB99IA+9GK4/P/bF7xM
         bVAw==
X-Gm-Message-State: AC+VfDzj9chhsILREaHBVzGiRLDC588hOW4DP/0iR+BDUWArJm4DwH5J
        Wt2+jSEb4bYPd5CvWqMRl5I=
X-Google-Smtp-Source: ACHHUZ492tt1ZewNxpjsUEHD/kdj6hmC39lxyMZO1eBhdSfmaVO4yMZ7wBwsDX/ukDbYyHXEofxj2g==
X-Received: by 2002:a05:6830:1d5a:b0:6b5:8762:cf6c with SMTP id p26-20020a0568301d5a00b006b58762cf6cmr6779449oth.34.1687349594672;
        Wed, 21 Jun 2023 05:13:14 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id i8-20020a654848000000b0051b460fd90fsm2783430pgs.8.2023.06.21.05.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:13:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] list: Remove unnecessary WRITE_ONCE()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20230619090336.145738-1-mmpgouride@gmail.com>
Date:   Wed, 21 Jun 2023 20:12:55 +0800
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B653A92-5FD0-4E38-9F86-AEFE5B86AADA@gmail.com>
References: <20230619090336.145738-1-mmpgouride@gmail.com>
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

Hi Paul,

Looks like you missed this one?

Thanks,
Alan

> 2023=E5=B9=B46=E6=9C=8819=E6=97=A5 17:03=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") added
> various WRITE_ONCE() to pair with the READ_ONCE() in
> hlist_unhashed_lockless(), but there is no need to protect
> ->next with WRITE_ONCE(). Therefore, this commit removes those
> unnecessary WRITE_ONCE().
>=20
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
> include/linux/list.h | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/list.h b/include/linux/list.h
> index f10344dbad..ac366958ea 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -940,7 +940,7 @@ static inline void hlist_del_init(struct =
hlist_node *n)
> static inline void hlist_add_head(struct hlist_node *n, struct =
hlist_head *h)
> {
> struct hlist_node *first =3D h->first;
> - WRITE_ONCE(n->next, first);
> + n->next =3D first;
> if (first)
> WRITE_ONCE(first->pprev, &n->next);
> WRITE_ONCE(h->first, n);
> @@ -956,7 +956,7 @@ static inline void hlist_add_before(struct =
hlist_node *n,
>    struct hlist_node *next)
> {
> WRITE_ONCE(n->pprev, next->pprev);
> - WRITE_ONCE(n->next, next);
> + n->next =3D next;
> WRITE_ONCE(next->pprev, &n->next);
> WRITE_ONCE(*(n->pprev), n);
> }
> @@ -969,8 +969,8 @@ static inline void hlist_add_before(struct =
hlist_node *n,
> static inline void hlist_add_behind(struct hlist_node *n,
>    struct hlist_node *prev)
> {
> - WRITE_ONCE(n->next, prev->next);
> - WRITE_ONCE(prev->next, n);
> + n->next =3D prev->next;
> + prev->next =3D n;
> WRITE_ONCE(n->pprev, &prev->next);
>=20
> if (n->next)
> --=20
> 2.34.1
>=20

