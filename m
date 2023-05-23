Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD070DDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjEWNuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbjEWNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:50:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D491E9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:50:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-969f90d71d4so1117408666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684849798; x=1687441798;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=QKx8n//1tKFimftiMxA1MUqaSGZNSHWdUYwS7d1fEr8=;
        b=ohL+xM5uW5h/Kc38R+R3Q+NWedDCe1F74+5M0k6VNn5qAFRaGimRlA5C3rQVITiDXI
         4RbpmnHalgZc3TFGQU4mWfVn7JY4u1vrQCgHdgqY1hyFl2nPDZyIxyV+dQDTwK2w82z9
         ucMZQjQQpXuC4TB6+M/UYs5k8iq5ds+Drr9PotqurYTdvgvBD6lAsfjVFMTOEghlXuTP
         DF+iMuai1YlCNS/LU0qNKxbyGjj61PxCjTFpidHGEB1S/1irs5mEqFASaDS6xuRxpA2G
         FSzkI3hz5BKIWWhRggtb+bQKVeA7jyKiUiFnayMKTCAO+g4l885rbauGfvxJC5br+LpS
         DqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684849798; x=1687441798;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKx8n//1tKFimftiMxA1MUqaSGZNSHWdUYwS7d1fEr8=;
        b=dAHB5KZCd94AcELpioLipRplKNPwG6ZA5SPUHuBs1dc3wLKVB/7GzfOIkMpbtMRQtJ
         zBy3B45MWSoHU7UU8r9jDqGCuMxZ04bNvPuCeLLWqODWVXHN4bKw0QeRJ9tWx2svie3z
         OR4Hf9ZSw6seettIoZJOYJlyXrtuU018ukR1BiSgkBWPqD2+bmLWA7FXeWFGr+KZweJv
         Smsq3iMmW9Xy6KQMpRHVBXscGeUOxrjIs02b1Si2X47qg9be25iQ+BoOAlyxM0WSzz1f
         EPC3w+APKtRSDKIIyi/Mz36VAJ7V9bVNFsaKi9ij2XitHIPH9hgCFK6vtss83CDOICLY
         l2Ug==
X-Gm-Message-State: AC+VfDxgQ54WwagbL5tKuRA12JnQjzuoHEtLipJgKhsLQU7Asnk/DHbr
        ieH/7QwmLA9iRBnqPdiSvZH5/A==
X-Google-Smtp-Source: ACHHUZ4iTNVTiX44mpW3K9dwzTRFp9mKM7RDFCxUm+4ZyyNdGA2kxXD/jMrQDq4vaqPQJGc1k9lHhQ==
X-Received: by 2002:a17:907:7212:b0:96f:de0b:847a with SMTP id dr18-20020a170907721200b0096fde0b847amr6927791ejc.37.1684849797878;
        Tue, 23 May 2023 06:49:57 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id z27-20020a17090674db00b0096efa536229sm4587344ejl.149.2023.05.23.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 06:49:57 -0700 (PDT)
References: <20230517095905.3548100-1-aliceryhl@google.com>
 <20230517095905.3548100-2-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v1 2/2] rust: task: add `Send` marker to `Task`
Date:   Tue, 23 May 2023 15:27:14 +0200
In-reply-to: <20230517095905.3548100-2-aliceryhl@google.com>
Message-ID: <87r0r7dunu.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> When a type also implements `Sync`, the meaning of `Send` is just "this
> type may be accessed mutably from threads other than the one it is
> created on". That's ok for this type.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/task.rs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 526d29a0ae27..4f1fe9aa9f6e 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -64,6 +64,11 @@ macro_rules! current {
>  #[repr(transparent)]
>  pub struct Task(pub(crate) Opaque<bindings::task_struct>);
>  
> +// SAFETY: The only situation in which this can be accessed mutably is when the refcount drops to
> +// zero and the destructor runs. It is safe for that to happen on any thread, so it is ok for this
> +// type to be `Send`.
> +unsafe impl Send for Task {}

To enhance clarity, could you elaborate _why_ `Task` can never be
accessed mutably by Rust? Perhaps "By design, `Task` can only be
accessed thorough `&Task` and `Task` can never be owned by the Rust
side. Therefore the only situation ...".

> +
>  // SAFETY: It's OK to access `Task` through references from other threads because we're either
>  // accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
>  // synchronised by C code (e.g., `signal_pending`).

