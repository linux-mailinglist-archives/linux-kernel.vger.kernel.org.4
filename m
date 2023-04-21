Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426126EB5C9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjDUXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDUXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:47:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C93198D;
        Fri, 21 Apr 2023 16:47:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b95fb433f59so3971765276.0;
        Fri, 21 Apr 2023 16:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682120832; x=1684712832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJsAK53yCn6OZsdg8FYiry45Ov2h8LJ83w5TZ/7f1tM=;
        b=lnL3DNtR32fZ4k28MgyvsFrMh0oSSbipvwxRkwPN18iK+C7r/847WV74+5itfSsLQO
         Vf2UCHFVHe4N8iXzDrC7iQbVUfZL5oLKa2GnRjVm472s6r7ZIpxGER5vKehUWXKzHCut
         M05CjFTx/h9eEjABT9hSzOZ0GX+lh3NtpOTHARynJgDVA63mONxtR9M7RPx8tZ7flzCN
         Q2DGyP9zSGdZQw0LJ3LMRxtzRKTisfCmV0YjE/jlKw/PrtkhaRITt7RqWgjcIxG6VyR4
         RuTIKr9CfvcOtcQqJaFEYIrB67oMfWYsl7EOtuV5BkYQkTcS4fICrKeAA5llqtGJDXCI
         nIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682120832; x=1684712832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJsAK53yCn6OZsdg8FYiry45Ov2h8LJ83w5TZ/7f1tM=;
        b=fpcw1GpHzlJUa50rhkMJ3Yi5AUr3g2P9XY3j/W3EuxPJX9NJ+avGffFXl6bhfUfXN9
         OeTvqo6zSvAOroUxHEUxcUbifZL4Oqk/YIQEihKMP7y2xzwcMVhNtsJtlSsIA16boRx3
         pfbzIG/ztckX/27bjYm2VaidXGfLwyqG6NlwsBKKS4QbOpd/T6NE1TJJOhC+I7BcQMFE
         JP7nTWkUFiNIxLrsZWWApNI1C2I62PXfPJdxVMKi70h068nIRUbv/B5NAv9Ky32duRXF
         Lu7pTuYJ2RV1cYxX7fxYw8BM+7VEVXD7fAM10/LXXl8ueLPzC5HMHd4UebA9MmeCkEo2
         JODA==
X-Gm-Message-State: AAQBX9cirkp7nwAbIbd/Yhk+x4tCRs9J1FSl5GezF1vVO5sxBCq3+1v6
        2xLH0GfdhgkOYDxF3g6fCm6eYcpswVb/oDSGW/Z7DFozmYMuSg==
X-Google-Smtp-Source: AKy350ZoNTSqD5UB35ajc/8n8uXRjP/m3jBWBogtLuXVqDsxbu+eC8g9u+N3IPS2CF7RJJnxkdGoQD3c+Ckj8ok3plo=
X-Received: by 2002:a25:2154:0:b0:b99:3e95:6892 with SMTP id
 h81-20020a252154000000b00b993e956892mr2241480ybh.44.1682120832442; Fri, 21
 Apr 2023 16:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230412121431.41627-1-wedsonaf@gmail.com>
In-Reply-To: <20230412121431.41627-1-wedsonaf@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Apr 2023 01:47:00 +0200
Message-ID: <CANiq72mELB=pHS2ocK8z51h1BhhySzV3PSTD98F+YTB3EbZ_uw@mail.gmail.com>
Subject: Re: [PATCH v4.1] rust: lock: add `Guard::do_unlocked`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 2:14=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> It releases the lock, executes some function provided by the caller,
> then reacquires the lock. This is preparation for the implementation of
> condvars, which will sleep after between unlocking and relocking.

Applied to `rust-next` within the main series, with the irqsave bits
removed as discussed. Thanks!

Cheers,
Miguel
