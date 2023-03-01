Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2876A7374
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCASas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCASar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:30:47 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC743B3F2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:30:45 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e194so1298116ybf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677695444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe0TDTOEyjpuN3jHlFdoEvUUJOEIpcY134vh/JzXvfQ=;
        b=DdVrf2CSU0q5+K6cepu6rjhec9Xn5PSoSzePzX3bng5UxWleQ4InAwRU0unk25nNzV
         57WJkTkw/0ecsAO2Aryw+KzuEw8N1VKaFqa0vFFsCrO6liKlCi9An1Z9M3y3B9yrQQw+
         6/UGvsvp5Xkp/kZ0Cq6LwjENZZ/D4YGjf4UMliMX8LVXTU1rxGcenCTGj7HLLF1ED6Up
         ZLvea3mEilsjDOa/GgPUW5fKkbwXG63nz/HXVQCPTyUKJQn9UoiNnKk8VZmXOWeYORSV
         rigGGZymr9SD5fgJmmm8XEXqTAlgakUjzYvk/TyTQkkMdzCIkcNpvVvj7RY9k/qU9FJo
         BHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe0TDTOEyjpuN3jHlFdoEvUUJOEIpcY134vh/JzXvfQ=;
        b=vXZsAfJL0buIKOJXmlSl86qTxHDFnKBMzTqhGjlgG+bR/45Yjfkn8TNXybv215PXmg
         7pPR/+26hX8YA5nXpG52T4VZOkSTZymlJAKzeVvLEoiX2FUjWNhXGrFbAIHOEMNa98Ll
         NS7wHXmjzCbq/U3l3HytFo/wFvmmYFaWt+0Du/8GigqH24f6HgLGP6sQjZ71pW+21c9m
         DirwTouHQYy+8JNxm9+WY14gc3+TMuNfUhd7Lw1BFzh8IgJD0438aiZj1rqNKImv0eD8
         w/CU29spvRH44b6EHVgbKAhmLw1vF/7AiXtPiyexCN+d3bg0xLBkNZjKwWeV/l6iPhNo
         MkkA==
X-Gm-Message-State: AO0yUKWm0L79O2Bz7oyZ+PdiTvkB6+O6m8ulIfIhxmKSNZ7y8N19q5Ag
        Xfd/di9zBBebaUP0KpbOeJXkqQ5pMfiXwMnGgKjkoA==
X-Google-Smtp-Source: AK7set/Hm/1zPX5ZOzU4bIggLnlQZkHQ1jdCbP68CLZ2Y/CzRV99gdDdLnXmN/Bf2Xt85xTVJ+Yls1jhkkhFklFF5SU=
X-Received: by 2002:a25:9983:0:b0:9f2:a18c:90ed with SMTP id
 p3-20020a259983000000b009f2a18c90edmr3217971ybo.10.1677695444491; Wed, 01 Mar
 2023 10:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20230301133841.18007-1-wei.w.wang@intel.com>
In-Reply-To: <20230301133841.18007-1-wei.w.wang@intel.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Wed, 1 Mar 2023 10:30:08 -0800
Message-ID: <CAL715WJHoumA9e2pOHLveC79i5Tz5FOuJM+F_XfyV7-FoDxMuA@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: allow KVM_BUG/KVM_BUG_ON to handle 64-bit cond
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:39=E2=80=AFAM Wei Wang <wei.w.wang@intel.com> wrot=
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

Do you want to use brackets for these two places as well, i.e.: !!(cond).

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
>
>  static inline void kvm_vcpu_srcu_read_lock(struct kvm_vcpu *vcpu)
> --
> 2.27.0
>

Thanks for catching this one.
-Mingwei
