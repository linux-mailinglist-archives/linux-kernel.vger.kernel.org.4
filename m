Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180FB65A58C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiLaPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:30:50 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516D5F68;
        Sat, 31 Dec 2022 07:30:48 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j206so26287467ybj.1;
        Sat, 31 Dec 2022 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JG8JkGizHk6OOlCN3XUOXJ3kZY3cgZs7QsL4MTDQgDE=;
        b=n8oLluZQpcfXatNmm1scwWitiRMGtbMUnTQ2IG347RR+LDQYiiouavkARCkcHF7U9+
         Hmck4dAVIe5VR3TCXCicDeXgSkVi1lYR8/8t9gB4RmKFbKNE0a0s8xlhbnzPwRbh4XQ9
         AN9Zkb5bYIx277isgokdBGNfz8jayyX+/+9dS7n2xn4kCBwq8rM5G19T24fPjNE2azcy
         Co3dBDIpAcR/jKvsHguL+Q1BVJPM+SLjkhjOKTtaiJwD84BifgMXJ6VS/EpdCfIc9Bdc
         R18yG36V6ANIO8L76cuiOSGIIBvvlCltQLvdyFe8oOaNzji+FHfNPyCfnMt5O0oMnXFI
         XqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG8JkGizHk6OOlCN3XUOXJ3kZY3cgZs7QsL4MTDQgDE=;
        b=xUgHbtxiA+rI192QAYKPzYvMmN3YdvTehrbBVfRC9PkMMGi7Y4zEUVSEZz4onHXG4H
         jtEC0y6rZ6WtvAy2T98OJMDGNdzeioSwKAy83e0Vv+E5zNdPwJ9qdhKNfz+muz+6Bv6A
         SolKpE7J3T7J526Qf8c+nLQc1tFJ9bGP0iemZHl2iQNp7wvVePPcuyw1+uAmk7RKXlsq
         P1ZM7Mih/XcteWB4kaggLxCK1ndJvu9MC0snsgIXwqL3q/DaJAoXt0akYY/laGavxOD+
         E5xxKyR3kSR9h/T5wV5xdH67Eq+ib9JDmCRjv6Dp6mej5lssYVDe6oqb6bRz1/6qApTe
         4y7Q==
X-Gm-Message-State: AFqh2kobZX/10FRQhXNQMD45xOGKWv0OVdauz2k0FFREn53NRzP2JA51
        DahL/UVoxRakdt4S7q4D5X08TI3Z7VRJg46nAS4=
X-Google-Smtp-Source: AMrXdXvVNXKjofXjG2tD1fK9j47fIGvuVoh+trQG1yqh1vM6hpHKOkh82Yz3mKC0GUdOL1Gd1da5HgfXej1RE6ZZWm8=
X-Received: by 2002:a25:7653:0:b0:6f9:13cc:de91 with SMTP id
 r80-20020a257653000000b006f913ccde91mr4131006ybc.328.1672500648107; Sat, 31
 Dec 2022 07:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org>
 <20221231064203.1623793-3-masahiroy@kernel.org> <CANiq72mbazF7b3sbH=9F=cHbTB_np=os+YzUPCzh=4HgEHsEKg@mail.gmail.com>
In-Reply-To: <CANiq72mbazF7b3sbH=9F=cHbTB_np=os+YzUPCzh=4HgEHsEKg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Dec 2022 16:30:37 +0100
Message-ID: <CANiq72n7hjdSJGB0qSXJtXOgR+58zZ657UrCnZRRFWyArUOOOg@mail.gmail.com>
Subject: Re: [PATCH 2/6] fixdep: parse Makefile more correctly to handle
 comments etc.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 4:25 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hmm... I couldn't apply this one, it turns out `#include <stdarg.h>`
> is gone. Adding it and adjusting the patch fixes it.

Ah, I think you created them on top of kbuild/fixes.

Cheers,
Miguel
