Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1C72D6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbjFMBfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFMBfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:35:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C633171A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:35:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d55ac17bso902409066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686620105; x=1689212105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYiTdDH+VW2jwUSsmDMc3DKz+ntmwZ8u/+J88WoZGfI=;
        b=LZIc3f3SaPkO69Ni+BwEuzALApcWVFl0vZfRxm9l/1Tcq84J18DLFo6uutvyLDl8I3
         AgRlQYvoSyVAoDB+ZcOxMMaw+8IhdOSd+XAfgSS3P1rbY58//03hXFcBpqd0lzUUU26T
         0YaYMZMUD0hf1DjlMW1DjqgcbujaNPln4rBZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686620105; x=1689212105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYiTdDH+VW2jwUSsmDMc3DKz+ntmwZ8u/+J88WoZGfI=;
        b=SEd3A2W0dBXavDOIjr03mJt7Y8AB8OUlD0iX5lxxl2CzRCtiQHRsLvdTXCfoqgCrFt
         MMp/mpVzJWtA7/QJ7ky7AuJxNkFDA9pE7AZdomWsLduUE+d1UvLf5L4uI/cR/BLH3V4T
         Byi1oWqisyvccz5cBmlc76ETuWnZup7ERUykgYaLhknN4L9l8IW0F0076sLN0ro/Aw/D
         muM7CKmLDgwpqjUpcgo/qSWMTJZ851FQw9fhAanM5ryOBqs6XswI9lVryhV0ZKhPtDd5
         GtjmAAkYlQ/sXdV9Nybpw84D8T1P+hOMi9Rhr6gScrqnm15pCNgYhqjB+MbfF8E9WVot
         RcaQ==
X-Gm-Message-State: AC+VfDx2lr2dhZNMHG2SnrRAEIKnmX9XXfAacnwDTxmHgL/ZLeDbCRUH
        1lQuw0M/h6kuV69h95lXVdXliLthtKjctMqhHOY5VXgT
X-Google-Smtp-Source: ACHHUZ6yoAzKdQItJFSa/4IDxLWOroKkSeFG+yNj0oCK/mr8O6758ELfSDkXBGg/Q4pGgiaqwrZkJA==
X-Received: by 2002:a17:906:d54b:b0:978:94b1:25ac with SMTP id cr11-20020a170906d54b00b0097894b125acmr13826543ejc.40.1686620104816;
        Mon, 12 Jun 2023 18:35:04 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm5919341ejb.98.2023.06.12.18.35.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 18:35:02 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso8680205a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:35:02 -0700 (PDT)
X-Received: by 2002:a05:6402:31f3:b0:514:9e61:e7b8 with SMTP id
 dy19-20020a05640231f300b005149e61e7b8mr5620947edb.40.1686620102024; Mon, 12
 Jun 2023 18:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 18:34:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
Message-ID: <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> This series implements Shadow Stacks for userspace using x86's Control-fl=
ow
> Enforcement Technology (CET).

Do you have this in a git tree somewhere? For series with this many
patches, I find it easier to just do a "git fetch" and "gitk
..FETCH_HEAD" these days, and then reply by email on anything I find.

That's partly because it makes it really easy to zoom in on some
particular area (eg "let's look at just mm/ and the generic include
files")

                  Linus
