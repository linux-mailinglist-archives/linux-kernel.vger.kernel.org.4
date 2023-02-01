Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A4685C81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBABAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBABAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:00:41 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7554588C;
        Tue, 31 Jan 2023 17:00:39 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e15so20434425ybn.10;
        Tue, 31 Jan 2023 17:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nPQ4RnUP6Ol9oNSST5l+QUc+nK4Yk250B9dxEqq6J4=;
        b=Kkj397Rg+PPciClFB+yXJgESfsvk2ZCELMtSsZyxkBVN9Yw7AiM9zLLZWiuCu7IgFU
         glo01lZbGvI3G5KaKOxHitOvRTHNiPOkY3oRzhvc7r3jDvxkPX3224p7MjL1T8Pu6GqA
         LN7CFpGFVL0LYDoOqk6YjOaEOfox9zo/zMtTQ7Vj5FHm5tAEoDapRa/U9+Tvn3QnxLgu
         9m7X3JzZ+83f46gwu9u/PFnx1DOHFypx6+znTRY9S6WgTwAkO5+ZD+de29oEPcP43rHD
         Q+IZALUfcQbliHTZUt+p4S+8p5/lPjW24bqOlbK9h7qM6liDV/eyKKdi+9YHVPmMv2xj
         AVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nPQ4RnUP6Ol9oNSST5l+QUc+nK4Yk250B9dxEqq6J4=;
        b=oLB1CQzCoX0w9hFsQbuH8kSX3c1Qq+yDdRg4iYhHny22LKUgHh9S2OuWFKq29G+0EN
         DthTZ8R7EKy305Lqa5Xqj3LYfDVtAQoPzZd9jU9tx3AWAIdUQaiXvZldmePEXXjvmgUJ
         M4nICwvQ1JHzWovReqBrsSyBZETCQV/Q0sTk0fBnIehgo06NcIyxPwXcBdew/uJmwHDh
         MI8bpkT1XsTvizE5l58PTHEnkjBwyxd68HHSwhHp1c2OckkK/9TVimlPkMr8elTppgKv
         vXn6YDuImwtS6Xn5mCVt689QcEay7RSuw3pfn+K3SWzTGBb60v05grK9rwTQst84PIbl
         68sQ==
X-Gm-Message-State: AO0yUKWLHdBl862DHZ8i0B+Xzatap3F+bzjX5lW7MUVqNtBonWASzBES
        8NRLhqCKnvDj2QuK2RKd3ayZ8lJiLXOzc//rAQo=
X-Google-Smtp-Source: AK7set/gj6cQu52jHh1NyWNo+H/vfuONDQLUQWkE88/1LbLRc80+x/3TqqeIVOYN84vbSseQiBcfNAHR4prAGncNVts=
X-Received: by 2002:a25:ec04:0:b0:7e1:ed59:4e43 with SMTP id
 j4-20020a25ec04000000b007e1ed594e43mr137320ybh.323.1675213239147; Tue, 31 Jan
 2023 17:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20230130064404.744600-1-wedsonaf@gmail.com>
In-Reply-To: <20230130064404.744600-1-wedsonaf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 1 Feb 2023 02:00:27 +0100
Message-ID: <CANiq72mFUMeovG=wJs_kAWn+j2v7WobgGP5aRBmoZc2ooQqpBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: types: introduce `ScopeGuard`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
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

On Mon, Jan 30, 2023 at 7:44 AM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> This allows us to run some code when the guard is dropped (e.g.,
> implicitly when it goes out of scope). We can also prevent the
> guard from running by calling its `dismiss()` method.

Series applied to `rust-next`, thanks a lot!

Cheers,
Miguel
