Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEBF6096F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJWWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 18:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJWWP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:15:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4C481EA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:15:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h24so4781639qta.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y24AOJSf6aWoSnenwrB4rB+v3E66RFlXKYZodyfNpmI=;
        b=bYPvGCsIR4tXMVTQIDgsK6ovOEDTsnWnZFWagZ69yVWsOXt3quZB41d2pj+DwvzEgl
         4v/a818ksm996aOQdG7sbDti2ShqA0oH5Zag95O6OrGmWkHFXcWE0eFFs2kMgb6ftKzg
         UxtGjkNOPKmKt7VQ2ubIAOuanhlaZ59MN3WVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y24AOJSf6aWoSnenwrB4rB+v3E66RFlXKYZodyfNpmI=;
        b=AMDmdN8QBa5QZ3xXxqz0mKupYDGhg3DaNSHaKrmcXLbOYWe82aGYWLbWRBWPv/8xOh
         vl0hbksbGOXXtB5Nvb2fGSbDKtGP0b+vpv/IvLLCIfVkieFR1Rtzwgj7qdOprHvM9taL
         wPWfWwGy4JCVuaeOuSPqptwAt440mXk6Lsc0liOk8vSh22g06k49kGKLE0QvOJZfM6ul
         aTU4rZc6aYlPI5oUGAwbenmnqGsRG8fxHcfbYGMlvBfXd66V2RYRYDk6J3TUewRsna6v
         nAyO94fw/OVlGjLjvM6XDRGllh657Mxkoox6FdGOOTrZdrNGVka9pVyGSpwZ0GG76qoA
         +e+w==
X-Gm-Message-State: ACrzQf1lhz/e/Kob9udZpaz8CQ7ACT+fixHTFhM2I7ILBZ5h+tG3wfbb
        HHXXsSbicdWJyiM+ElotkAubztfW1AP7vg==
X-Google-Smtp-Source: AMsMyM5lqHkqrgnjYr8U9nQK9WWs4i8VPGYQmBoHgNXSdf2dSwjPCOA/3xg3cK/vljlxOxuJnnXNyg==
X-Received: by 2002:ac8:5988:0:b0:39a:dee7:ba40 with SMTP id e8-20020ac85988000000b0039adee7ba40mr24993093qte.635.1666563325789;
        Sun, 23 Oct 2022 15:15:25 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87951000000b0039cb9ef50b5sm11727398qtt.26.2022.10.23.15.15.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 15:15:24 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id e62so9236163yba.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:15:24 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr25687050ybb.184.1666563324398; Sun, 23
 Oct 2022 15:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221023174307.1868939-1-pbonzini@redhat.com>
In-Reply-To: <20221023174307.1868939-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 15:15:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgL7sh-+6mPk7FGCFtjuh36fhOLNRTT0_4g3yd380P0+w@mail.gmail.com>
Message-ID: <CAHk-=wgL7sh-+6mPk7FGCFtjuh36fhOLNRTT0_4g3yd380P0+w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM patches for Linux 6.1-rc2
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Graf <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 10:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> x86:
>
> - add compat implementation for KVM_X86_SET_MSR_FILTER ioctl

Side note: this should probably have used

        compat_uptr_t bitmap;
        ...
        .bitmap = compat_ptr(cr->bitmap),

instead of doing that

        __u32 bitmap;
        ...
       .bitmap = (__u8 *)(ulong)cr->bitmap,

because not only are those casts really ugly, using that
'compat_uptr_t" and "compat_ptr()" helper also really explains what is
going on.

compat_ptr() also happens to get the address space right (ie it
returns a "void __user *" pointer). But since the non-compat 'struct
kvm_msr_filter_range' bitmap member doesn't get that right either
(because it uses the same type for kernel pointers as for user
pointers - ugly uglt), that isn't such a big deal. The kvm code
clearly doesn't do proper user pointer typing, and just uses random
casts instead.

                         Linus
