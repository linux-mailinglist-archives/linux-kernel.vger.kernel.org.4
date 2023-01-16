Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926366D33B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjAPXfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjAPXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:35:10 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A512864;
        Mon, 16 Jan 2023 15:34:38 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 20so12935365ybl.0;
        Mon, 16 Jan 2023 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YsmbTSj7cnmVtuKj0INKYcsE5xY1gj3A58mVttznzT0=;
        b=BZXqDQhggvwTOV7hswSG4Uf3scC584ZiglEWy0z6MJWmBgSUXnCAOIC95YW16xknXL
         na/pmmxnhNc/GfLS7XOdqEuxZsZR0m0vAeh9U8ZZVm7LdkkgFFvjFbANU7sgRkoKRHzm
         VRfPBcolT6bT9T+e/HVqlByh6tNYi5RI6yPVqsQkhqH54ZXvXRFUgW5CrXKV2jJ+jlac
         T/j8fPYXf+EIg6k7kZ9cwse97PLxlVVUsRfOiUqQZoa48x1tSrhLpPGWziQsLHOiLdU5
         ZVAP92UsLgkk6iJfN/UVrOJKIpnji+7Uz5r3/TNybX4tuC621HX29UHnmBIoVTLF2iXL
         KwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsmbTSj7cnmVtuKj0INKYcsE5xY1gj3A58mVttznzT0=;
        b=sE4w5a/PUOX/N/ZfQcHRl7kRVgbx+cz+v3ZCS3b/QEcOxSg7mKWe3znakoc666PeWM
         n5cKTVPekEkT1NG8pgSeZDxy1f+werdhbPWfMHBkpMgqa4olWITioBSTQDsNJhlfQnO1
         jmMgNW/DCxL941hNGebFlYswYj7OCJYIRceoZy2fTdpe96n9I0UQBMyKSDajtItu6fDm
         lWWA6XFi/tqyfOYW+bLfTrE32WqDfybyGBM8FurcjMNZdkKMWcucckGYSuT837Sq7XKt
         ZZENz6D+hnpIavAqBFilsacOL/cDee2MVvNPjZMHPKqfvDeBWiElBoSQhCX9c+J9kKx6
         WNUg==
X-Gm-Message-State: AFqh2krwgi0rUW4f0hm4kBjRAHerpu2dRnLxO+HE6hnqAs5ROI73Pbqd
        Y05LS2QFNx/QwBHD0i/1ivG1gZ8OV0cDQvvo+oM=
X-Google-Smtp-Source: AMrXdXsj0d9+C7EAaOS1y+SaUkam+WUeVjV7ocyNAhyW8LeHz2VpA6YVtfzkWnCsOBcdEuoxXqucBXAwoDOWxgbsWVQ=
X-Received: by 2002:a25:b7cf:0:b0:712:faac:e6b2 with SMTP id
 u15-20020a25b7cf000000b00712faace6b2mr179021ybj.632.1673912077446; Mon, 16
 Jan 2023 15:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20221228060346.352362-1-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 17 Jan 2023 00:34:26 +0100
Message-ID: <CANiq72mVkS9j0A1TZ7-OvwWhwsrfVw3ztrMcqrNxzh3Haq63wA@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
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

On Wed, Dec 28, 2022 at 7:04 AM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> allows Rust code to idiomatically allocate memory that is ref-counted.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>

Series applied to rust-next, thanks all!

Cheers,
Miguel
