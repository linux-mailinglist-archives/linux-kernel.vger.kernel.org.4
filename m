Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B868D40C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjBGK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjBGK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:26:25 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE421E5D0;
        Tue,  7 Feb 2023 02:26:18 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4a263c4ddbaso190835107b3.0;
        Tue, 07 Feb 2023 02:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxjIeJLinZUwH77OUYcRmkIbKePj5GVo28r5pHoJ2OQ=;
        b=NU5Mp6pvYcNZu6SxD0j52CI37qvOSApOdAkgg+viUPvveKcNwmvEv9gJIVpeaO9rjk
         drRzB9TmlwoqwXjtjCyPQM2O16TUnmEQvU1iqo/YOtCafuVcE6D2YhOLyzGPofEM+p0u
         BqMaxDY+Ntw9VI+zOsVR91UX5ZfX309AhN6t9opeukH5OCLYDWnWcSa45gEVhm1UQDbA
         YnjLIInN4glTLUWEd8fkNdcMGCFA5oTpzpSIDl1SX6ZNU2dGGn/D+LXAVrYL8pP2S2sc
         U28e09g5dU2gYRCmL8YyDAkAng1pxuC40azhnn5vvRLmM8EDKrlM21zcd91u1RGGIo6A
         7A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxjIeJLinZUwH77OUYcRmkIbKePj5GVo28r5pHoJ2OQ=;
        b=mbKHLjVxBYi69nIomfHsczU6YwTy3q/8xNCLDj6jLLcVFSCZaRsf4DNuCcrL9u7f6Z
         RqJJvuqPHYgnG6Qdiy3FfEY7gFZxaGDVKHI8DRr4uY8R0rhasx508mC88OwBROxgslgK
         zyvQ+IYiJ+oKFlzx4iOyz0DpH68s07COSjTFbYrfDnDtsZhQJWhpFP/HDBF/vzvqBSws
         y5NPjPfEXmiIeTPk8D3ZU4/ySy7BUEbd+XWCcoL00UCeYKJBnAFvDJ5g2dabuXL239YZ
         frPILmNf8sYDmz1Y631vC4eDAAEG+C5BUa9C4i3R+hfszlCH1DoARAYH19ML0QQ3Gaer
         BFCw==
X-Gm-Message-State: AO0yUKXVfxc3L/XsQHcE1Fp291VEmJ6UlVDTX/3MwmNZhY694qL6agD1
        pnvek6sl+kAVX3C3pj+2J2Z7cQDI7mYd7We6C5U=
X-Google-Smtp-Source: AK7set+Kb2SStc+Ha0e7J9tV59eJCn9T1YJ45BnJL+9s9dP4HAGLhIE6gGEvYP82CspE0BLJ/l3VSoQ87fIIWlswVS8=
X-Received: by 2002:a81:9e53:0:b0:52a:9f24:de51 with SMTP id
 n19-20020a819e53000000b0052a9f24de51mr184805ywj.462.1675765577782; Tue, 07
 Feb 2023 02:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20230130064404.744600-1-wedsonaf@gmail.com> <20230130064404.744600-5-wedsonaf@gmail.com>
 <87h6w5isfq.fsf@metaspace.dk> <CANiq72nGh9ypPY2QvJF5oak_1qBBG6z6LhHz8hxgp875HCx48Q@mail.gmail.com>
 <87357hsttf.fsf@metaspace.dk>
In-Reply-To: <87357hsttf.fsf@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Feb 2023 11:26:06 +0100
Message-ID: <CANiq72kKSpzhMsASBXy4jzZ4LPg=aHAjc_-_r4Ox4VrKY0Nmcw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: types: implement `ForeignOwnable` for `Arc<T>`
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
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

On Tue, Feb 7, 2023 at 10:34 AM Andreas Hindborg <nmi@metaspace.dk> wrote:
>
> Sure, if it's no trouble, add my the tag :)

Done!

Cheers,
Miguel
