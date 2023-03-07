Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C26AECD8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCGR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCGR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:57:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46807ACE20
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:52:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B0361507
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A427C4339C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:52:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o7gAowpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1678211543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2dpmT/ojXxiEeqa4iyotuL0U6Ky5fG3bCAhuvP7SOs=;
        b=o7gAowpu+WwEcc12XzCoeq7TFYt2x8xTPHUlM5Eok6prB0c7FhG44GM0BXK9rdSl8BrsFL
        1x0SroyMobwLy0LGqa5ssQwlswgp2qqrnYETibZjZ+trjne8uo9aCDi3G8tqp0hFjxkKOk
        c9CMkWKNtp0it05x5g7HwjXp2GIRXoQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c5f9cad3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 7 Mar 2023 17:52:23 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-536c02eea4dso258898487b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:52:23 -0800 (PST)
X-Gm-Message-State: AO0yUKXOP1FJq7B4hDe6CK1xFnDGGC39643q/ssDtmflfPPa7Z7/Brfn
        OuwwNhcBvyxZkqtdX+6Rdes61509/GijEB8WPs0=
X-Google-Smtp-Source: AK7set+fq0Koq84/LVB8GJiN9PVIlu7H9xrrfWg5nppb5OafYmSXCIIC4oCuGpubOj1qw5eHppovx2vew/Q5jTfDzIA=
X-Received: by 2002:a81:ac27:0:b0:52e:b488:744b with SMTP id
 k39-20020a81ac27000000b0052eb488744bmr10008487ywh.8.1678211542963; Tue, 07
 Mar 2023 09:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20230306160651.2016767-1-vernon2gm@gmail.com> <20230306160651.2016767-6-vernon2gm@gmail.com>
 <CAHk-=whVnaTBt2Xm-A+8SMc5-q5CuZBDU6rUZ8yC8GoAnbTBvw@mail.gmail.com>
 <CAHk-=witXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNdaPwngMVEg@mail.gmail.com>
 <CAHmME9qN1EcfzE2ONA-B+F=8xaqZhqkEY=_npYHgtBpUFCj4Lw@mail.gmail.com>
 <CAHk-=wjR6SGJhhHT6NzHcZHBJ3p5Y_JPvpQPjkeNQE+emivS6Q@mail.gmail.com> <CAHk-=whsQuc-S4vuYpvi013-81UNvNc8CoTMC5AKOMT-uq_7Og@mail.gmail.com>
In-Reply-To: <CAHk-=whsQuc-S4vuYpvi013-81UNvNc8CoTMC5AKOMT-uq_7Og@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Mar 2023 18:52:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9remVPMHaHN-aSRe6ra=QcOPK+KGMgBLKCtfa8Zodt_pw@mail.gmail.com>
Message-ID: <CAHmME9remVPMHaHN-aSRe6ra=QcOPK+KGMgBLKCtfa8Zodt_pw@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpumask: fix comment of cpumask_xxx
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Mar 6, 2023 at 10:28=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm looking at wg_cpumask_next_online(), and this:
>
>         while (unlikely(!cpumask_test_cpu(cpu, cpu_online_mask)))
>                 cpu =3D cpumask_next(cpu, cpu_online_mask) % nr_cpumask_b=
its;
>
> seems very dodgy indeed. I'm not convinced it might not cause an endless =
loop.

Indeed this code is crap and wrong in multiple ways. I can probably
simplify to something like

static inline int wg_cpumask_next_online(int *last_cpu)
{
        int cpu =3D cpumask_next(*last_cpu, cpu_online_mask);
        if (cpu >=3D nr_cpu_ids)
                cpumask_first(cpu_online_mask);

as you suggested, which is indeed a lot more straightforward.

I'll get this all cleaned up.

Jason
