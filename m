Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D75735662
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFSMEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:04:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D211D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:04:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77e364a9a87so82189839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687176276; x=1689768276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOMu/GoOKUNylJ87WTGXaTB/TIyKGKcRgnbuyigXjqA=;
        b=XMEITXhL8B3NpDSyIT7ZdBmeZRa1+gRv75L81ek3oTq1YoaaWUxtUVJpseJLRwEJeV
         bYeoeozkOepKTQ6IfhnvxwE/QdC20nva3r007BbU++2QhHw3b1Ha2zcZbAcOjt0GuKPA
         9tNXWMHflxiBdKMsoc2whlEdo+uvj1Td7+7eBJbANrMMO4YKQk7NlQpB33UYWPfALILO
         w/sV3p41FgIXVI2alcSTqa2eXqorjhbRae/CcSF1LyarYnaDY9y5KpnZX6WwDfhGSjBA
         K6DmQiAjcJ3ixuhueejSmv5rlGrcaQ7icweIvtKGrdfBgwaP+43560KkeNM9wN+JYdBM
         2dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687176276; x=1689768276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOMu/GoOKUNylJ87WTGXaTB/TIyKGKcRgnbuyigXjqA=;
        b=jzju9JQkd42BQ0XvT0XlqB5ASbfuTZEAbhGNif+f+x/toCxcdFrzAgZNW2lKQP4oFP
         xF0XN1UozyDj0WAMtQ+/yqv1eGp8ohIKhtGQfrOPPBhBO6k3uxvUg7JZLuECssco6Bcl
         lP9ipW9hKUBp3h62GQOxgJ7/xbuJjVw6MjMX3ciWIP9uzbaTRBoYctIzWfY7WtooWJov
         H551mFL7IUiqh4yn6sWV3A6/t/dDWFgXu2itpzRcun6NG1LJucE7BXSwM7qcmyPMvOFR
         dGTkL2Hai0BfdiwZg9wTP5aPZ2NZD2tJYwLCJWlH9ui/BCUVjpOBgQkymbpUL5iIT3g/
         7s3A==
X-Gm-Message-State: AC+VfDwHyrY33q2ue8T1lPR+808+zawJUq4rkIs/I1boTzfe8QkGSJnI
        J2pMbLPLgbHJySeoUqXecR2qpQZ0fpBOo8HYBE3BYEwVEoZO6fo5w3h+5g==
X-Google-Smtp-Source: ACHHUZ5zcpqD4yX63sImePGrSCY9sAhYXSfZpxOs7Gd33c+DI3rH0RjRchBdc2IkHiLKpjA66oJRVHOppTdSBHosQ+4=
X-Received: by 2002:a05:6602:2995:b0:777:a581:e0b4 with SMTP id
 o21-20020a056602299500b00777a581e0b4mr9621245ior.14.1687176276467; Mon, 19
 Jun 2023 05:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <20230616084715.2140984-1-glider@google.com> <CAHk-=wg3qG_FzSwAnj8X22_aF6_Jm7wpjA4kXrCe8-C0vsUsLA@mail.gmail.com>
In-Reply-To: <CAHk-=wg3qG_FzSwAnj8X22_aF6_Jm7wpjA4kXrCe8-C0vsUsLA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 19 Jun 2023 14:03:59 +0200
Message-ID: <CAG_fn=Un4XhebL8YRnPDjETEYGQCBnwh6vvePPxCLmLeJRTmRg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 6:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 16 Jun 2023 at 01:47, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > Shouldn't ex_handler_copy() be fixed in the same way?
>
> I don't think ex_handler_copy() is actually reachable any more.
>
> The only thing ex_handler_copy() did was to set %ax to the fault type.
>
> It was used by the strange copy_user_generic_unrolled() that had
> special machine check case for "don't do the tail if we get
> X86_TRAP_MC".

Oh, I see, thanks!
I am using a downstream kernel (way before 034ff37d3407) that still
has _ASM_EXTABLE_CPY.
Looks like I just need to adjust ex_handler_copy() in my code.
