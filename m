Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0C6743E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjF3PR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjF3PRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:17:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9807644BE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:16:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbca6a9ae4so30115e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688138180; x=1690730180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2hR/KhNASLMJVxFauqxU4XhDOn7bSDTmrq/J7vDv7o=;
        b=TRZxNMjM5RO1JNNZKgZOR5RH0Yv5C4Vn/RneOeTsb/05jK/UeLFCidNiyWhwyUaf5Z
         aupF/jUOf2e3MicdLXmgIL0Ub+YmBEQYQcerycEdzdn2KKJhfmpJqDh7CqFLInXofjtP
         OZXzw+wFgvv6XOU1YSmGEQm+w388OMDhu2eXlR8bp70x8p6OC91xXw3YwfrQggnC9IC9
         WmFbW3TVfFf9vavDHIWsGS928BqHQoqNa/G6UV10Fg8X3Rvaqzy7AQ9kLz3P4VzdQO/k
         0vQSKmKKQJj0qm7Il8kPYMhj/Z7nil2hqR6c2Dhfm315YIX3rNVztxyRHs4/o8MfQDR/
         HHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138180; x=1690730180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2hR/KhNASLMJVxFauqxU4XhDOn7bSDTmrq/J7vDv7o=;
        b=J+O/aD2ecrMif86f0CWkxNJhNyidySfZxOdoxkjphv2rXUeZytheOKo3VsYBTaqGTq
         qhfS2ONlQkGqxrNaGwigBiwa8Ab+jgeG2rf11YinZ2fKxYSEsoGM2f2QLQI1khzdpvnx
         Rr6sXRjvehFJBom/TmGvMDs3k19T4WX/nDtgCtNQyGQNBUOB09FR05ASFMA21Qcio7Ap
         QmSA3j8QkBfXbCgwFN1yome+uUJ7v7c3ltv1/xAFex27fhu/5YMCtxC8okgyR+VtlWB1
         JVJP4su5aitpodUUcvtbymkaifgS0gF5SWLjYFK2MCht5QmtG/lfVsal1BZJLqvN+xPf
         DDaA==
X-Gm-Message-State: AC+VfDyG3shOF+q3m3RKD7xG4tMIfcoO2UxxkaO0Q6eXXs5oqtyJRU3u
        VX+YRY6EXFstiRn6lm4ie07oKIeMp6iFXBx4NnZPMu0qbhY4KoZZ8HQ=
X-Google-Smtp-Source: ACHHUZ57TDCyI6HuFq6itIHyiuswS8qTRk/Uhbs5B8NDAkYH9kZN6vimTj2ZxN5nJTEEDgvzPrpgVVsGwA9BMFbOTJU=
X-Received: by 2002:a05:600c:860c:b0:3f4:fb7:48d4 with SMTP id
 ha12-20020a05600c860c00b003f40fb748d4mr378270wmb.3.1688138180627; Fri, 30 Jun
 2023 08:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230630151003.3622786-1-matteorizzo@google.com> <20230630151003.3622786-2-matteorizzo@google.com>
In-Reply-To: <20230630151003.3622786-2-matteorizzo@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Jun 2023 17:15:44 +0200
Message-ID: <CAG48ez3k2K1_gwxo=ckHQmHxXgV-VfQ897-TXQcJjUcdiyr4Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] io_uring: add a sysctl to disable io_uring system-wide
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        corbet@lwn.net, akpm@linux-foundation.org, keescook@chromium.org,
        ribalda@chromium.org, rostedt@goodmis.org, chenhuacai@kernel.org,
        gpiccoli@igalia.com, ldufour@linux.ibm.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com, jmoyer@redhat.com,
        krisman@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 5:10=E2=80=AFPM Matteo Rizzo <matteorizzo@google.co=
m> wrote:
> Introduce a new sysctl (io_uring_disabled) which can be either 0, 1,
> or 2. When 0 (the default), all processes are allowed to create io_uring
> instances, which is the current behavior. When 1, all calls to
> io_uring_setup fail with -EPERM unless the calling process has
> CAP_SYS_ADMIN. When 2, calls to io_uring_setup fail with -EPERM
> regardless of privilege.
>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

Reviewed-by: Jann Horn <jannh@google.com>
