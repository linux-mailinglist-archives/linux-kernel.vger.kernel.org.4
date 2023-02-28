Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679376A60AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjB1Uta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjB1UtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:49:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DA235261
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:49:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ck15so45658283edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677617356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtXAIoXvfiyUjZh/JqW45RZBaGUEv0yeFwHGzzsBvFc=;
        b=BqPLg4e0P5XceC6DuLMXjbNjtwfFBQZUvrIzJKKJ2YILg/egsIgykSSGRRHoMXgd93
         s4z6+PCjGm1hOpODiIf4nM12zkW8nFvL6ib8hT2DiU21goJ3EgqqP86tS9h8M5yGgr4V
         B5l3f8JhoRMXC+EwxCFI0HM3NNC6HC+BT/SfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtXAIoXvfiyUjZh/JqW45RZBaGUEv0yeFwHGzzsBvFc=;
        b=Gsqic4Maq2LnAlGBDVJ0XLsLMxf3Ihb3BixuuA6Wr28L76oy7/UPtV59CJtaTP6YgI
         lleOijMu3x3i8F0+0ttyLwmDHWWQsHL8DlF2vaKYLD6xVmtOpRx1YOVcfIhcnkLeSESp
         jIhxfFtsFeEJFeN8SX4zAAJw5jxVtkMg0xUXPyX9oYTzu0cd4+nFMQULqoGYO/5tUdMS
         pjZ1C+cxmO5zZpNuhQnjNP+LZ5b7AIls/+0oSeK/2gZ69bf8Cf8M6tesWM8m0hiBgv2r
         8wLwimmiQ1aGEqzaJ0PoPQY7tpDoV9EIXsUGjPM8AUQXe2YZkIbbhbGR4MaEr5w4c97T
         /X+g==
X-Gm-Message-State: AO0yUKXdGd4OjwFe7Zjf38+YiF4rC46pGuO8G5i9nBn9Hj6W2NsrELjE
        5YPUf3XXBVqp5jdF0Ip+H3FKZs8kceD07UdrSfg=
X-Google-Smtp-Source: AK7set+K7tcDhXN1S2MfHpxVWHB+78PERTNoTjMjpHiLMII49CVMa3+v4r0UtFJtYtZnc/BuqNsTVg==
X-Received: by 2002:a17:906:3753:b0:8af:1a8c:f13f with SMTP id e19-20020a170906375300b008af1a8cf13fmr4602805ejc.71.1677617356000;
        Tue, 28 Feb 2023 12:49:16 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id qc17-20020a170906d8b100b008ca37f3eae9sm4899519ejb.131.2023.02.28.12.49.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 12:49:15 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id ec43so45378898edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:49:15 -0800 (PST)
X-Received: by 2002:a05:6402:500b:b0:4af:70a5:5609 with SMTP id
 p11-20020a056402500b00b004af70a55609mr3449762eda.1.1677617354960; Tue, 28 Feb
 2023 12:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
In-Reply-To: <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 12:48:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
Message-ID: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This actually looks sane enough that I might even boot it. Call me crazy.

LOL.

I had to go through the patch with a find comb, because everything
worked except for some reason network name resolution failed:
systemd-resolved got a permission error on

    Failed to listen on UDP socket 127.0.0.53:53: Permission denied

Spot the insufficient fixup in my cut-and-paste capget() patch:

  kdata[0].effective   =3D pE.val;
        kdata[1].effective   =3D pE.val >> 32;
  kdata[0].permitted   =3D pP.val;
        kdata[1].permitted   =3D pP.val >> 32;
  kdata[0].inheritable =3D pI.val;
        kdata[0].inheritable =3D pI.val >> 32;

Oops.

But with that fixed, that patch actually does seem to work.

             Linus
