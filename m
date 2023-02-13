Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7798D693E74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBMGoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBMGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:44:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49F6EA6;
        Sun, 12 Feb 2023 22:43:56 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so3717610edd.10;
        Sun, 12 Feb 2023 22:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rupOtt5ylLjo3fhbHlzPJE20iu9FpqDjZ+/K/Redjx8=;
        b=RcloBeKyGiN5jhXwNZnYJooc9NETmlpmcBG0PCwG//qfKJxVGf0biHLkDx5aShb7DL
         /UB3zX5Ab+pa7uY69n/QM/4BccnvWZk7aVRdg8NS5uRWfVQ5zdVhcqH4FGpacZWKLcur
         4oxgQMtFOEEQv2WA4o2f/9vKx2VB7ZKkXhST8lhNCF91mRQ8miAt3ruYLDQ1fi16QmTq
         VTevFJpeL6yrO2nJYmwu39TwBlO0A9/wnAQjjfzH7uUskS3JEje+pbYbXnOsBj3lM9k1
         /iKxtiyK4QCurN3hjyVa4uBXHI9crjgOo0d1Be/nxe2Ay+XsTSVvUvJqKhSziot9tkWB
         sdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rupOtt5ylLjo3fhbHlzPJE20iu9FpqDjZ+/K/Redjx8=;
        b=N67GSDler+tkkimOevmasEF3hd5sLSyWEHB0VVFKX8QKSopDzdeIX/XieyNBxkK5Sj
         lv+olAjvLz40tMGHJ/7bE3zWdblbcVsf3F3eqAFkVvHcdlBbf+KpjZbbWTKXtpeFX1kG
         4TnAFoaL1ssfdcIjQDAwh/1ifYzcPbRjaSi1EOQijOd9UamjVsblhF6hk1zcWxU7bmLd
         O95kZJ4mJOrsgbY94FMhhvhVWbWWV1AjiXUZz0wayYLvAp6lmBetUHU+rOMz9XrTFDu9
         j8pgP0b7k1ocbImUy6YfBJDSAQuW4RqHpvXQJMsdWYnRHK+vESw/GHs7YKHG9P3Guiq3
         TC5g==
X-Gm-Message-State: AO0yUKVzrnXQvYz8PBwnUgg0P5mtdA1tR9eIEioYOKss+KwUytjpzQx6
        ibfWooUImN0Xv4pZrInroxsjRiKsNYk156sM60o=
X-Google-Smtp-Source: AK7set/hbslv9tB2aTA07MPLpW6tzHMxN4NvFICuLuZaCEMs+04VVTiV26HkiYJEQ7IMxrN4pUx4eXnJfGdqT06vU0g=
X-Received: by 2002:a50:f61b:0:b0:4ac:b528:5728 with SMTP id
 c27-20020a50f61b000000b004acb5285728mr2940770edn.2.1676270635423; Sun, 12 Feb
 2023 22:43:55 -0800 (PST)
MIME-Version: 1.0
References: <20230211024156.3530526-1-zhoubinbin@loongson.cn> <87lel3kssq.wl-maz@kernel.org>
In-Reply-To: <87lel3kssq.wl-maz@kernel.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Mon, 13 Feb 2023 14:43:40 +0800
Message-ID: <CAMpQs4KwCgUA24apw=wmN=k7n+ERiip8gG9-8kirCQ+-HDP1Jg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-eiointc: Add DT init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
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

On Sun, Feb 12, 2023 at 7:49 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 11 Feb 2023 02:41:56 +0000,
> Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
> > Add DT support for EIOINTC irqchip, which is needed for the Loongson-2K
> > series, e.g. Loongson-2K500 soc.
>
> Where is the binding? I'm pretty sure other drivers need updating.
> Where are they?

Hi Marc:

I will add the binding file in my next version patchset.

Thanks.
Binbin

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
