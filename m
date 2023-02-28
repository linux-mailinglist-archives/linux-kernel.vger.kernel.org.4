Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A16A503A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjB1Ao3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB1Ao1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:44:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88661E9DD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:44:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ck15so33536084edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VmmBrX2p1inGbF8ku+z06Eh1CWxuqZx/wcts3IMRaQ=;
        b=RsHw/7bf2AWfHNjtJ5v/u3oBO4UVqyim+ZjyJHLVumO0yRgL8CyxfZSuOL1XDP6Ldz
         Mk5/x93eWLTNfo4rz2SYFy2S+wQKxVb8wycJD0kYjCMYV0wBFG3sWqRWJua6C8NSggwB
         2aTMW/W28IYwMZGy621QeKOe4FJHunteyMmgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VmmBrX2p1inGbF8ku+z06Eh1CWxuqZx/wcts3IMRaQ=;
        b=Y33FvGU9VL4mTh+MfFVp3a4IezF4ZwG+V5yd/FJ3SlhbcjU7y4KJwGSduv5emsqpDv
         Top283XhRSoQrv4xrEb/GA1ywJUmQFuI6SAsod0oCJM3pK4AtFmpAMGv2sO7hfr0FlyA
         1UtDFYD3ULHwKJGA2g0VG0Q4U9ey5WAjVBwNZUN0ZVYZtuay3wVAo4X+ogrHCqcct8zF
         0Irci5RWwB/oc6Gws7RofOyGJ3G+pqdowQT/aG3DYtXwLFsf2VcPmIR5yl3b5teICyFy
         UTe3IuifUp6ih1TLd4kYzvRTcbCTVe1CLFUSJjh5T5M2O1qPhUwby9Z0T+g1tcij8+Bx
         jAgQ==
X-Gm-Message-State: AO0yUKWJh/xDMHU9ZD1iifOYx54SqfsEBYNn2B4Bmg+lSKwfSHDGQut5
        RlOS2lkE5zPqFEDvHE/Vqd0HBW5IM5M4KJtEXa4=
X-Google-Smtp-Source: AK7set+1buW5d2CN2O9hCjamrP6Vzpaga0Ld2DP8VUcLH6rIc+q7uXtirZt/vmZFppZg0/a7Sk0P2Q==
X-Received: by 2002:a17:906:5d16:b0:8af:3fef:52c9 with SMTP id g22-20020a1709065d1600b008af3fef52c9mr977271ejt.22.1677545064113;
        Mon, 27 Feb 2023 16:44:24 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id md7-20020a170906ae8700b008bbc4f3bceesm3826522ejb.118.2023.02.27.16.44.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:44:23 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id o15so30793175edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:44:23 -0800 (PST)
X-Received: by 2002:a50:bb41:0:b0:4ac:b616:4ba9 with SMTP id
 y59-20020a50bb41000000b004acb6164ba9mr736894ede.5.1677545062838; Mon, 27 Feb
 2023 16:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
In-Reply-To: <20230125155557.37816-2-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 16:44:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
Message-ID: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 7:56=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Turns out for typical consumers the resulting creds would be identical
> and this can be checked upfront, avoiding the hard work.

I've applied this v3 of the two patches.

Normally it would go through Al, but he's clearly been under the
weather and is drowning in email. Besides, I'm comfortable with this
particular set of patches anyway as I was involved in the previous
round of access() overhead avoidance with the whole RCU grace period
thing.

So I think we're all better off having Al look at any iov_iter issues.

Anybody holler if there are issues,

             Linus
