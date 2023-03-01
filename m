Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274A86A7474
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCATr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCATrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:47:55 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6933C3C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:47:53 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id d20so20202287vsf.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebMKxxaqXXk2gW5DwKNbMXgKtZ+FCaplkD9FJ/pi31c=;
        b=iZqiTbyNv3bSgdnujJeiluAsFH1u3mPVvmMI5K50s7pjwkMvxMxoXTh1Sov4+zEefp
         T28IgIwt7BChwFGJmTMdAFLMcDiVqaQHvnBWu3j1+J2mMG2OzbmEwryNzclyHibUOUHk
         6mzHXeScWaSLXVZ2np9cAafY+pDCRgdkuhz1YzHzknryb82fDcpjTdG5BuLQf6UrVBPu
         /m/9Xz9xR3B3oUPNyxBYMOOKSJSpVP50oHBOvSYe9tGTlu82NrOGbzt9soospfAgi4bP
         nz8tMRw0nW4WIi5xFiJLmB7Gw1yGrQ95S5JdEdMGeN1VVVUvxtC/QFTO0xTg4u4EZaM9
         5ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebMKxxaqXXk2gW5DwKNbMXgKtZ+FCaplkD9FJ/pi31c=;
        b=NThjZBJzGrZViY3+9Mn3N/DSRVgr4LOuvvV2DSgbD3M4J/FxDsuL7EJKStBjgwqNTg
         Lt9tjG41Ot7NNC+TGnZ0JvrhwBwGk8WvDNaEyCO9QrTjcW5RrAH2qth43A56uwnam1Tb
         j+Z7cQvvEXVOw2ZxoTOXuMikKvlBA2v8fzO5WEvbuDXVyvWuzMcaZcaK9U8iBse3ZF5c
         IgvZ6U8TK0ZEN1dkDstUulzEp4EWVCEb6FsJZR5CNx7pGWyOtqhiKkNp6eUHjPt7LL7w
         UEqs7xu1fsOu1dybq9Lox608aWDzntRjXsUbz84rHqWDIrw9OOQCOkMezj3IjR8FXaBU
         ZBMw==
X-Gm-Message-State: AO0yUKXTVvrP2nO3sSl0fonyYyQZ4Xt69acCdN3XA1eqe0S5Obck6MAi
        PzELuwrDIDDQTxVM+yNHOdW7JeRYvgf7DPTn6fVj8Q==
X-Google-Smtp-Source: AK7set84HxO0v1OTq5xnTW68GTAsEyUbRxg6Nicjbx63AAvqmwS/6ybj1rndri7HjjV4Rc+9fiE6PaFtycYPal4FVsU=
X-Received: by 2002:a67:f7d6:0:b0:411:c07e:f666 with SMTP id
 a22-20020a67f7d6000000b00411c07ef666mr5141934vsp.0.1677700072355; Wed, 01 Mar
 2023 11:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20230301133841.18007-1-wei.w.wang@intel.com>
In-Reply-To: <20230301133841.18007-1-wei.w.wang@intel.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 1 Mar 2023 11:47:25 -0800
Message-ID: <CALzav=eRYpnfg7bVQpVawAMraFdHu3OzqWr55Pg1SJC_Uh8t=Q@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: allow KVM_BUG/KVM_BUG_ON to handle 64-bit cond
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:38=E2=80=AFAM Wei Wang <wei.w.wang@intel.com> wrot=
e:
>
> Current KVM_BUG and KVM_BUG_ON assumes that 'cond' passed from callers is
> 32-bit as it casts 'cond' to the type of int. This will be wrong if 'cond=
'
> provided by a caller is 64-bit, e.g. an error code of 0xc0000d0300000000
> will be converted to 0, which is not expected. Improves the implementatio=
n
> by using !!(cond) in KVM_BUG and KVM_BUG_ON. Compared to changing 'int' t=
o
> 'int64_t', this has less LOCs.

Less LOC is nice to have, but please preserve the behavior that "cond"
is evaluated only once by KVM_BUG() and KVM_BUG_ON(). i.e.
KVM_BUG_ON(do_something(), kvm) should only result in a single call to
do_something().

>
> Fixes: 0b8f11737cff ("KVM: Add infrastructure and macro to mark VM as bug=
ged")
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  include/linux/kvm_host.h | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f06635b24bd0..d77ddf82c5c8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -881,20 +881,16 @@ static inline void kvm_vm_bugged(struct kvm *kvm)
>
>  #define KVM_BUG(cond, kvm, fmt...)                             \
>  ({                                                             \
> -       int __ret =3D (cond);                                     \
> -                                                               \
> -       if (WARN_ONCE(__ret && !(kvm)->vm_bugged, fmt))         \
> +       if (WARN_ONCE(!!cond && !(kvm)->vm_bugged, fmt))        \
>                 kvm_vm_bugged(kvm);                             \
> -       unlikely(__ret);                                        \
> +       unlikely(!!cond);                                       \
>  })
>
>  #define KVM_BUG_ON(cond, kvm)                                  \
>  ({                                                             \
> -       int __ret =3D (cond);                                     \
> -                                                               \
> -       if (WARN_ON_ONCE(__ret && !(kvm)->vm_bugged))           \
> +       if (WARN_ON_ONCE(!!(cond) && !(kvm)->vm_bugged))        \
>                 kvm_vm_bugged(kvm);                             \
> -       unlikely(__ret);                                        \
> +       unlikely(!!(cond));                                     \
>  })
