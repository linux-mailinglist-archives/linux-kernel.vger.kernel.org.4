Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595C6C3582
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjCUPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjCUPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F29ED0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679412014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gbEQgLYjRS31cFyFQ/u7cPYuo5vW8jYBwx0JG55t7k=;
        b=dR0JGE6WrB+H9xeIiDrrojzSNV3SfWjs6cc/Q262dWVVp5Um/0xc7nUGe8btwTjvepH7fy
        KzK4aoOifcB/oDkzTDlTMK3n4PpbpfjxtrXDU3HshT8A38Pj4+bRY3Xq+K2X6aLlzC06XP
        xKbOTgjjSVVackrj/wEbOHuYRnC99tM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-vprGBxSVPFi9K2mJDGV9pA-1; Tue, 21 Mar 2023 11:20:09 -0400
X-MC-Unique: vprGBxSVPFi9K2mJDGV9pA-1
Received: by mail-wm1-f72.google.com with SMTP id r35-20020a05600c322300b003edce6ff3b4so3138418wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411999; x=1682003999;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gbEQgLYjRS31cFyFQ/u7cPYuo5vW8jYBwx0JG55t7k=;
        b=3SE8gxLFXHHsisrqmqdlc/Jaz1iV3aZydkPBhFGUNDZbIgUf0ZwONtXaYCMu9dFrFX
         o9T7VjGljx0dgRKx4B4BExm5/YrdqeHSaIhllt4Xt0kvcXxyV6daM/P6dZklpmseYsgS
         F/OQprr/vzMgBe5mm0hJ3lRvBzDxxXIR4L6bfvszo0cvviB1xtH8cG9hH9wCX1JUp5PL
         Yg7K/mOVXVHVC7fF7N0o4+1GdnIGsIkrih1JsN71yat8uWhMLOMnj56VOAH6q+T9F7N3
         NnBLtmMj2HjbK2423iFS3CUFAnBdfcQr9dJoiybgNFUdF+Wscr0pRt7uOGMeAOpbRK41
         uJyg==
X-Gm-Message-State: AO0yUKXeLluY/L7pL5DPfKwOON8yI3amI2CTXnVXQ+INiQR2epXADg7b
        QZJs5A43jcSH+Mvz1GUFxnM4YqmBPOxpX+MVkJOF5Xx62m0HYewMU0jsszwEmW3Nj5ECEf4jh+L
        d0EFKWlUjCVn6lkCmWk4z9l/S
X-Received: by 2002:a05:600c:4fc7:b0:3eb:3135:11f8 with SMTP id o7-20020a05600c4fc700b003eb313511f8mr3137747wmq.4.1679411998900;
        Tue, 21 Mar 2023 08:19:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set9N2ci19eICPOnMdcBTjnB7OXCBxPD7oehEOP3BFy3O2nzb5elsh3iuuKD1njtVYEbAVIulpw==
X-Received: by 2002:a05:600c:4fc7:b0:3eb:3135:11f8 with SMTP id o7-20020a05600c4fc700b003eb313511f8mr3137732wmq.4.1679411998569;
        Tue, 21 Mar 2023 08:19:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-19.dyn.eolo.it. [146.241.244.19])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003ede03e4369sm8158288wmg.33.2023.03.21.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:19:57 -0700 (PDT)
Message-ID: <26269528616bb41dcb2b5a3314f87fb36d45acac.camel@redhat.com>
Subject: Re: syzbot + epoll
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Xiumei Mu <xmu@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>
Date:   Tue, 21 Mar 2023 16:19:56 +0100
In-Reply-To: <CANn89iLy+-rQDSKCg6g=xkNLL5SmgkB7gyMSgxCEPp13-+eLbw@mail.gmail.com>
References: <CANn89iLy+-rQDSKCg6g=xkNLL5SmgkB7gyMSgxCEPp13-+eLbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 14:17 -0700, Eric Dumazet wrote:
> This is about this recent syzbot report (with a C repro)
>=20
> https://lore.kernel.org/lkml/000000000000c6dc0305f75b4d74@google.com/T/#u
>=20
> I think this is caused by:
>=20
> commit fc02a95bb6d8bf58c6efd7e362814558eea2ef28
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Tue Mar 7 19:46:37 2023 +0100
>=20
>     epoll: use refcount to reduce ep_mutex contention
>=20
> Problem is that __ep_remove() might return early, without removing epi
> from the rbtree (ep->rbr)
>=20
> This happens when epi->dying has been set to true here :
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
fs/eventpoll.c?id=3D6f72958a49f68553f2b6ff713e8c8e51a34c1e1e#n954
>=20
> So we loop, while holding the ep->mtx held, meaning that the other
> thread is blocked here
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
fs/eventpoll.c?id=3D6f72958a49f68553f2b6ff713e8c8e51a34c1e1e#n962
>=20
> So this dead locks.
>=20
> Maybe fix this with:
>=20
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 25a59640748a0fd22a84a5aecb90815fbbca9cef..1db56c6175aab5af7bc637a45=
2b68ed8bc11fd7f
> 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -784,7 +784,7 @@ static void ep_remove_safe(struct eventpoll *ep,
> struct epitem *epi)
>=20
>  static void ep_clear_and_put(struct eventpoll *ep)
>  {
> -       struct rb_node *rbp;
> +       struct rb_node *rbp, *next;
>         struct epitem *epi;
>         bool dispose;
>=20
> @@ -810,7 +810,8 @@ static void ep_clear_and_put(struct eventpoll *ep)
>          * Since we still own a reference to the eventpoll struct, the
> loop can't
>          * dispose it.
>          */
> -       while ((rbp =3D rb_first_cached(&ep->rbr)) !=3D NULL) {
> +       for (rbp =3D rb_first_cached(&ep->rbr); rbp; rbp =3D next) {
> +               next =3D rb_next(rbp);
>                 epi =3D rb_entry(rbp, struct epitem, rbn);
>                 ep_remove_safe(ep, epi);
>                 cond_resched();

(adding Hillf, as was looking to this issue, too)

The fix LGTM and syzkaller says it addresses the issue:

https://groups.google.com/g/syzkaller-bugs/c/oiBUmGsqz_Q/m/1IQ4vbROAgAJ

I see Andrew removed the patch from the -mm tree. I guess at this point
a new version of "epoll: use refcount to reduce ep_mutex contention",
including the above is needed?

If the above is correct, would a co-devel tag fit you Eric?

Thanks,

Paolo


