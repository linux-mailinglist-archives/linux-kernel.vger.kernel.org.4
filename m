Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA36805A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjA3FgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjA3FgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:36:02 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B306023C6E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:36:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y19so11516999ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNmp6hBxSYlTkhsmzXLxGAqaVCQ3e6vjSozcYohM8Tc=;
        b=wKatVutRHoLHfIT0j8NZZ/thluctINlIrmddQaBJJfmYd2NWwiW26ojfWX0+Ol15RB
         h3VNPlY8Zzia3VkqsBDp0JhwXwQ9mXirWb4c6GlMMF3kyMmXiHaYr0UByMvor9LaXrGC
         Xw0KYnChNH0ujdWEJ89QGS6iHdmGG+jh0866FOk6vVODcjEWRVl07Rt85ZTGdxuED9Yx
         hIXKKysNRmWn9KwuygLvKR/wiEaHFgUmU9MBjSjI82knLpZgXZZnc5J8s1P7E72v5NRk
         NNj8sA+s3a37/Qndux5Sy4EhGXRzQFmPEwYiL6tRG/X4DOAreq8HAA9L43CIqtSkNxOH
         ETVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNmp6hBxSYlTkhsmzXLxGAqaVCQ3e6vjSozcYohM8Tc=;
        b=3zz2hF0FAYWtFUyqgue9Bw53fJLetXnhpTq+I1Y38Rmm5eC7aq3ey5o/qvt11SC3zv
         XRhscQN2prT44HhGaIBFp9C5X0Fw8S1kUiFyqBiUeGPckMIopAF0zL3QmAk5FjycnI22
         T0BQ3KCFL/P3yr8QOpGXDMGFtXSh7M52/n4JVNgXrP5Ufup2/wsXBa0Zlyuq6EEszwDq
         YIb2+VV2PCUutv1nSRl+SVAm/P3vfYmNWugavtl3yVnB5/oH+A/09CTpJnF6W+L+GbbZ
         9YJh6s07/wSv2yCByzGxR7o9P1pS/YRzs+hHqPLhSvJvaYZ8a3n9cTJWqAeg3ZRvrLrd
         Ywbg==
X-Gm-Message-State: AO0yUKWMXFl+P7YTTo2AQ2IWwdobXJgWrV68jvZS1VWtL3O6v/hLul+8
        h6+3dy+x8PwTCO7m6/DEe+0DYmjc8I5at4GnMqeh
X-Google-Smtp-Source: AK7set+HJwoxmCcTyt4BFt1cti5G4e11paT49mcW7S9oeXR5WL6C8HKD/U6xgF+HUE/8U3orKnnx0FFXTUggjICusxU=
X-Received: by 2002:a2e:b817:0:b0:290:5102:a7f8 with SMTP id
 u23-20020a2eb817000000b002905102a7f8mr798131ljo.63.1675056960020; Sun, 29 Jan
 2023 21:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20230119174036.64046-1-wedsonaf@gmail.com> <20230119174036.64046-5-wedsonaf@gmail.com>
In-Reply-To: <20230119174036.64046-5-wedsonaf@gmail.com>
From:   Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date:   Mon, 30 Jan 2023 14:35:14 +0900
Message-ID: <CANgtXuM2A80=et=2GQRajy5ntri65QvRH3zg7xr5KPasQ16BUg@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: types: implement `ForeignOwnable` for `Arc<T>`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 2:41 AM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> This allows us to hand ownership of Rust ref-counted objects to
> the C side of the kernel.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Reviewed-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================
