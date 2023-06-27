Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87D740400
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjF0T3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0T3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:29:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566B19A9;
        Tue, 27 Jun 2023 12:29:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bfee679b7efso4813715276.0;
        Tue, 27 Jun 2023 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687894189; x=1690486189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWTyrHWo3DH4WeJQJV3ZkbmX57NNeA9KlEEZWcqodA4=;
        b=kmfeeAkPPfIIrgdhOd0Wz4grrEpQXcJmqHZ9HzQ7fuysvUZaCgExi22n1Bd0FYEXa2
         TjrE9q5kPQe+asD1MQsO/KQw9jNjLqwHALeKqPUWj3pQmhn7/nSkIGlqf3z/X61xjh/R
         myalWcsWU5YNZyIHwdJgQSDQVhJoGUC/LQINYA3cW8I1OueqF48HhicinqWQyRKHq2Yc
         9Wj0GmeNw10ae8KihoCV4p3gfxAoiPGK94CwRt0+F9xfmGWLsi9wv/evVGUy8lhHyUv0
         1yQA4cZ+v37F/eLCdaqLgyGyLvqzjd6JdzNw9iBMXhQcf8D62KtWLIQNh1mswSGQ/KSZ
         Znkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894189; x=1690486189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWTyrHWo3DH4WeJQJV3ZkbmX57NNeA9KlEEZWcqodA4=;
        b=IC3vXvbKX7UOZ0b4IuopssrknTuRAvhw/25VEJcPm6nWr0kTFX6l27tIfxKEzJ1RVL
         GAhX03Aj119tWbxhxzHeoz5KS/hMUBye/HKEtAxhNxm8NRViyDj6Hl86op0pP04bdTcP
         YnjE9d12xWnvBFbBHqnejSGtKUmLKCN2pbXfpp9QxHHMve2ojaVCXSr+pGrnUYnIrUAC
         OYq1TGkQL8CCiqxpASoC1jw8V5MtYC482fHkzW8cZpqzABwksK0EVnmcy8gPteEWWFc4
         J5JR4IysbKVRXujPZ+y0kVURfkikI84SotcoyvTighszajdsw9bmto7h2LOWzJx2JlI6
         MhJA==
X-Gm-Message-State: AC+VfDwHvCZMV++cTT6oGAZJmiYQ6WrLw5uD8TEDl7ELIgJOLQ9doNQh
        SjaH4b429mXbTU6ukeDZoEjfLyf/FnU0qlBBnFc=
X-Google-Smtp-Source: ACHHUZ56nLE7/aI1LmL+DMoeX705IRHIayduaPNCBJtfc5MDE2Q8Y9FjW+iOMmg2yR7Tp6iZIqy4yeFOLbNspBtvAXk=
X-Received: by 2002:a25:6fc6:0:b0:c24:dea:a5e1 with SMTP id
 k189-20020a256fc6000000b00c240deaa5e1mr6059171ybc.3.1687894188822; Tue, 27
 Jun 2023 12:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230624002708.1907962-1-maskray@google.com> <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
In-Reply-To: <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 27 Jun 2023 12:29:37 -0700
Message-ID: <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace deprecated -target with --target= for Clang
To:     Yonghong Song <yhs@meta.com>
Cc:     Fangrui Song <maskray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
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

Hi Fangui and Yonghong,

On Sun, Jun 25, 2023 at 11:25=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/23/23 5:27 PM, Fangrui Song wrote:
> > -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> > --target=3Dbpf form instead. This matches how we use --target=3D in
> > scripts/Makefile.clang.
> >
> > Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a=
68135afc7f95def6277
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

After 10 years of deprecation, time to change. :)

Applied to perf-tools-next, thanks!
