Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA416F71E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEDSYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEDSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:24:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90265B9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:24:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9619095f479so137337466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683224640; x=1685816640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9GA0G1IPcVKnzgI14OkrTJHr4tfrz0/cgfUFj+73cE=;
        b=gWt0EVbd4XU+hPdLgO+f1RafGffktMDps7/0kwYWQy0ZmL7nVAAl7GWWzzDL1CqCKR
         ihL0avRz5jHTMYUJKe2gRhRK8OpEfSZXroq4YGKkmdRx7m/9fUnjKXSjxJOrFxSD1Tbc
         IQ/9gg/pEvVM6finP5ApAMMak6MLpw7q3dGD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224640; x=1685816640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9GA0G1IPcVKnzgI14OkrTJHr4tfrz0/cgfUFj+73cE=;
        b=dZR5/t924vNKXnPXfrwvJg72Sqc9S0WTgGhKY1wfSJJeKF/cpZLFGPTVPk+TytjTKV
         SCm/9B60i/EP/IbSI7sfh5ekkc3c0DyLLncOXpXufPTQt6r1TNcgP94pkzZAWoUo1NuA
         tAQoNw5vF5TdmFUlSEvRc4EetHZqTd15a2283yD8kfo8BK3h8bvA9R9RhMT6WwEYqNXH
         5UgFm42Dcm9A7ewbWrhi7gF0eDiAnLCMsSNIgQCEFA5bPNjpTv2s+Kqj5gma1W0Glf39
         LwnJVDj27dMrbbl9RVSkOicmtNyhJn8OX8ZPGMQfwXFTEm4AXfpsmLYnkPprITU5HFXA
         nGJA==
X-Gm-Message-State: AC+VfDx8c9qet6M/TnF5EKRZCnDEKEUmSUTBMaUizODRUwPHQWjtg1Zk
        Ne5pwX2ez56bhLn7L7vy5PxkPDdIxAApVvvgTFYRMb03
X-Google-Smtp-Source: ACHHUZ5/CnBvVxVi7SQ7KfushO7AnDU0rWLx1nFiSlnfCPFwHbcR00tA73s5vwIOazNxqigwf9A3gg==
X-Received: by 2002:a17:907:788:b0:921:da99:f39c with SMTP id xd8-20020a170907078800b00921da99f39cmr8317678ejb.12.1683224639923;
        Thu, 04 May 2023 11:23:59 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id he12-20020a1709073d8c00b00953951ec91fsm18859877ejc.137.2023.05.04.11.23.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:23:59 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-96598a7c5e0so136535266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:23:59 -0700 (PDT)
X-Received: by 2002:a17:907:3205:b0:953:37d9:2861 with SMTP id
 xg5-20020a170907320500b0095337d92861mr7743910ejb.74.1683224638735; Thu, 04
 May 2023 11:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <Y/NmzouehvMWTPVZ@gmail.com> <ZErTyKxjGQvF6EqP@gmail.com>
 <CAHk-=wiDTLgf8LhigR4XKnjgkuhsoS-pXZckXU79J-EXiOj7Vw@mail.gmail.com>
 <ZEy9kUpwx/N3JEA/@gmail.com> <73dbeef4-cc39-4f09-5050-724c5b8dbd8c@intel.com>
In-Reply-To: <73dbeef4-cc39-4f09-5050-724c5b8dbd8c@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 11:23:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqdgepR+o844ePrRnvPh7-L9MYdOhbwmDfiTHSE8Oo9w@mail.gmail.com>
Message-ID: <CAHk-=whqdgepR+o844ePrRnvPh7-L9MYdOhbwmDfiTHSE8Oo9w@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v6.4
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Thu, May 4, 2023 at 10:30=E2=80=AFAM Andrzej Hajda <andrzej.hajda@intel.=
com> wrote:
>
> Later I have also showed/suggested Rust's approach [3][4]:
> - 'replace' for __xchg,
> - 'take' for fetch_and_zero

I don't think either of those are acceptable, and both are to me
*much* worse than the existing "fetch_and_zero()" that i915 uses.

That name just makes sense and explains what it does. There is no ambiguity=
.

I will not be taking a pull that makes a good name worse.

Naming matters, and "use a generic function" is not an excuse for
having bad names.

              Linus
