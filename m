Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD06DF905
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDLOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:52:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC85B99
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:52:38 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17E263F429
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681311156;
        bh=hvqL5OvNUsZFZ+sHFmNlvVzy0tXAUd/iqPbCE7rbU6Q=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=A/TfUhI3f/UPL84W3whA4eG0Wdx/lBn4TNfGEN0LKZDcUK/oGINKgfOLh1eAMNuba
         uuYLntYchwDKW7L7XNSdHHfVwG2CoKnRiH2PbZklQqTbzu3o2qRkoofzgaWfNrwGLa
         3GcRW+KmnPXrznnwrJuZw50iAiHA6GK7iWPpmuH+MpgdkaLK/Pz5Ii9GyQCcstwEAy
         CNO4u8yG2plPke5k6k3KUxiFUF5WIyZPvpkWSbYp2gXX65Nt6TBFX4Rz6yZHusS6+R
         8zmD+tUN46vcFshXz2DzkByO42nEbyWU4jT4OBLXIDsZ6VltT916GfHPuQsYKsf487
         V3IAVkTBbxtbQ==
Received: by mail-yb1-f200.google.com with SMTP id j203-20020a2523d4000000b00b8f21897f2fso6102414ybj.22
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311155; x=1683903155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvqL5OvNUsZFZ+sHFmNlvVzy0tXAUd/iqPbCE7rbU6Q=;
        b=T7xYIq9R9/PAf4h5yyHQIhh8u3EHvM21rdn8v9EMU+goudbZPK0KuZvYzrTz8fdJg7
         GoM6ELzakbcVC7WtgJ2Y1SUZCoDY2EUqBb4Q7KuKkH1+QhbjOegGZ5uALYMheUBsRO1S
         POcEvsGnxYnlamYLVievSNAQ2s4Jqg2jfBG2M0e3PaEeoocWf2VC2WKkwqkn82ho/iV+
         s7Dlshwk0ZGaOjxUQVc7AKzqUgzMUgYnxuokyoVfWe+VhBLIq8KjSgw6pY4VUFoJr7zK
         MGCyh0+eaWP7jyE8Cab5+L8tTtOkLZhjPw2Y979O+tsCbDH5ZBp4rCRclKgZOObqnai6
         NYzw==
X-Gm-Message-State: AAQBX9dAXHGmgkjYsPd1/Ax9JPoUlLuq5FwH8eibfDSrp4MujhWsNagL
        8qkJyo8xp+l9vUxSqQWCysl+HdA79jmGYym/pz8X23p3iBiN2nOdTWXMYBlzta9zcTdhEVitkyU
        sJ/uF+82VZx3jQOGP7tmp0i1CGt3Is6b5/v+HUNoCXJpabbpHd7k0BDkZ5w==
X-Received: by 2002:a25:d884:0:b0:b8e:f1ef:a144 with SMTP id p126-20020a25d884000000b00b8ef1efa144mr2178691ybg.0.1681311155118;
        Wed, 12 Apr 2023 07:52:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350YCHx1IlZRvzchQUAJk2tjUBg0HPj0JYKDBVhf6geq3Hy3rc7/eGhsBMiMfc3b+M7sGcaUGyylOozZ3OjdEFZ8=
X-Received: by 2002:a25:d884:0:b0:b8e:f1ef:a144 with SMTP id
 p126-20020a25d884000000b00b8ef1efa144mr2178685ybg.0.1681311154914; Wed, 12
 Apr 2023 07:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230404122652.275005-1-aleksandr.mikhalitsyn@canonical.com>
 <20230404122652.275005-2-aleksandr.mikhalitsyn@canonical.com> <20230411224737.00001d67.zhi.wang.linux@gmail.com>
In-Reply-To: <20230411224737.00001d67.zhi.wang.linux@gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 12 Apr 2023 16:52:23 +0200
Message-ID: <CAEivzxfxm9Kg-ap9QeceGgTeCd0du7FrH7Kmi2dRZH6gah-8HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: SVM: free sev_*asid_bitmap init if SEV init fails
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     pbonzini@redhat.com, Sean Christopherson <seanjc@google.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 9:47=E2=80=AFPM Zhi Wang <zhi.wang.linux@gmail.com>=
 wrote:
>
> On Tue,  4 Apr 2023 14:26:51 +0200
> Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> wrote:
>
> > If misc_cg_set_capacity() fails for some reason then we have
> > a memleak for sev_reclaim_asid_bitmap/sev_asid_bitmap. It's
> > not a case right now, because misc_cg_set_capacity() just can't
> > fail and check inside it is always successful.
> >
> > But let's fix that for code consistency.
> >
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: St=C3=A9phane Graber <stgraber@ubuntu.com>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  arch/x86/kvm/svm/sev.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index c25aeb550cd9..a42536a0681a 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2213,8 +2213,13 @@ void __init sev_hardware_setup(void)
> >       }
> >
> >       sev_asid_count =3D max_sev_asid - min_sev_asid + 1;
> > -     if (misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count))
> > +     if (misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count)) {
> > +             bitmap_free(sev_reclaim_asid_bitmap);
> > +             sev_reclaim_asid_bitmap =3D NULL;
> > +             bitmap_free(sev_asid_bitmap);
> > +             sev_asid_bitmap =3D NULL;
> >               goto out;
> > +     }
> >
> >       pr_info("SEV supported: %u ASIDs\n", sev_asid_count);
> >       sev_supported =3D true;
>
> It would be nice that another case can also be fixed:
>
>         sev_es_asid_count =3D min_sev_asid - 1;
>         if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
>                 goto out; /* <----HERE */

Nope.

There is no leak. Because when we are at this point then sev_supported
=3D true and everything is fine.

>
> Maybe it would be a good idea to factor out an common error handling path=
.
