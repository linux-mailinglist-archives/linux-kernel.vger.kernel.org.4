Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC92D6FBD94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEIDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEIDQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:16:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BAE1BE6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:16:02 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba1cde4ee59so3753195276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 20:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683602161; x=1686194161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXNsr9uadjS4cZ+26g1ME+73jV9r9EpjKEVXLrbVdzo=;
        b=l0LhGsYO6t4Vs7thwDFBv9VBl74EvYf/hTE3pBS8iMXWQQYxn7EjeNwurLuVgg1ua/
         dsKmAcHnxN1z1wggwR0jqM9IP1btyvJ1WEKoQEZhMwhMmMHtxDlAzMvR1U8lmysOd4cg
         LR3/ZZ8+hKmBZEFAWt218UDF7EPNFABkyQwQgkqWV3M3yC731EaPV6M3/DIbECTykSku
         QUROenDuG8KHBh13fa6PZUH47xVdMmWT/ciYhC7VXZEnxKhW1hYF7JbSZB6mQKsxfsj4
         q9vsiejwVQ4brNJJ9IqgHGXuZNTtOWw8gSUbfUNiSd3qv3dvUk7H3AWGHoqBlRUZS1FD
         7YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683602161; x=1686194161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXNsr9uadjS4cZ+26g1ME+73jV9r9EpjKEVXLrbVdzo=;
        b=KiAh628JtH4kpNIsI7Nd8pW6A1LchuO4ah+xJKXnhP/2TBpE6kmsl84HWmb3MusQxm
         jtN6ciOlVf3kE5Sa/s3HqJYCS58Uvhv26Vzp/axZFK6ORTHEzN9Aqrs+kJ8IfhazgX+J
         KjOgcEN5/4hYnX/5wCWptVOTQw6LM/b7Y5Ht7DgW8g68kYZpdB0XhlOa7Dr8kwwfnDKa
         tqGtR1HboINj7lM07un/9k5dO3kDJJivhKI5+f6NKz3EXlpZOrvRTxFn0EPNPa5Y2URr
         k/bDHPfJK7TmU+tk9/5z6jlUfngv852eG+TiXhY1v6cMa3DApbF7uZ9wjmwgzrJVNxZA
         QJ7A==
X-Gm-Message-State: AC+VfDwgfa/T+QxGM0Zq+xzIXpVWgQcSC4E614kwZPZUGav4n9L3Hp2Y
        ymPW7RrIZhXHSDqlfLMckGtVe+GhGBXXK+yq9qXj0Q==
X-Google-Smtp-Source: ACHHUZ6ugPrhTxFHJpj8ElxlEmgr3O/v3U0wJozNBHIZMefYiuF3geRwO60GXZzeQV8gTNRYgz7oBQ5B186+e9du1Fs=
X-Received: by 2002:a25:d1c6:0:b0:b9d:da87:cbc with SMTP id
 i189-20020a25d1c6000000b00b9dda870cbcmr12635015ybg.32.1683602161181; Mon, 08
 May 2023 20:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230504181827.130532-1-mizhang@google.com> <c9090d80-46da-ed88-bad9-5a2e6d33d77b@intel.com>
 <CALMp9eS7KuGkMiZ-RQoYqTQ7TyzLct3OVUCuJUorkg3WBVJ3zQ@mail.gmail.com>
In-Reply-To: <CALMp9eS7KuGkMiZ-RQoYqTQ7TyzLct3OVUCuJUorkg3WBVJ3zQ@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 8 May 2023 20:15:24 -0700
Message-ID: <CAL715WKeY5=uJdt=TBXs5NCLOfeL9NJp8_yygQmpjaocFazQng@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
To:     Jim Mattson <jmattson@google.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 10:28=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Sun, May 7, 2023 at 6:54=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> =
wrote:
> >
> > On 5/5/2023 2:18 AM, Mingwei Zhang wrote:
> > > Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspac=
e to
> > > save/restore the register value during migration. Missing this may ca=
use
> > > userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to po=
rt the
> > > value to the target VM.
> > >
> > > In addition, there is no need to add MSR_IA32_TSX_CTRL when
> > > ARCH_CAP_TSX_CTRL_MSR is not supported in guest. So add the checking =
in
> > > kvm_probe_msr_to_save().
> > >
> > > Fixes: b07a5c53d42a ("KVM: vmx: use MSR_IA32_TSX_CTRL to hard-disable=
 TSX on guest that lack it")
> >
> > I wonder it's the fix for this commit.
> >
> > Apart from this,
> >
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>
> I concur.
>
> How about:
>
> Fixes: ea732b38b341 ("KVM: vmx: implement MSR_IA32_TSX_CTRL disable
> RTM functionality")
>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Will send a v3 with the update of the "Fixes"
