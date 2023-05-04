Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4D6F70AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjEDRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:17:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8E449C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:16:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-95f4c5cb755so134094466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683220614; x=1685812614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cXwPFrpZkWdKeLA6HDo5uvIR69BqdB0irBe6sSQ2ms=;
        b=ZAtCFD2+rko9JGeIqQ0VIfIaY5h43k7bBBCNXFDqZOlQSYkuA8pl0IUrHRdBpy+5/s
         b+695KryNA1Y0B3gAD63Fwb1HzoTa2D6m0KlSWvNtQe2m3yA8zisSQ0CPm8q2QnDtYwP
         RZtn2ZYQ8lJVnIAcbxwdPBLUKbykj76JP/mdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220614; x=1685812614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cXwPFrpZkWdKeLA6HDo5uvIR69BqdB0irBe6sSQ2ms=;
        b=PsNi+rlCgOefJfcgTpXTq1cuOgFqx/wvKxxprK7PJKAOzYdnHZh/ZVgRtGiOtFJF8s
         DZRLwpMKROX8gh7rYg/RFS5Dns8xUzzNbnxtjcqhe18Xp24IU8cG4DYjLaDQ/40Y71jB
         u8AUy285i/m4+sQXX0LbOrhktqCFXVAVIJKYfvGpxDFGtoGg1pnjtcb2FqyyEHes6/C+
         ycibF8J83hzBP40Pq9fPDL9U3ro45OuCtrGK98lV91iWsAlNXQEbfofL8bR+ync+ARWf
         FgIUBx52ezRWj7E6JkMPwzGZfSD+ift1LT13H6ZdPoCCjAK+pXI1ovVJd9vSgRGPz8/o
         yGdA==
X-Gm-Message-State: AC+VfDy+DXHkESh/agSp7sm8N7aUFE52oyAhn0DZ7dTWjzElCfHUWYBO
        MYZhuOUvetI2tT+kgXUAwquxjy3ttbt3FxXUa1fD8yqN
X-Google-Smtp-Source: ACHHUZ4r4Hl6JRNvsKHlEZcRiWIs6gSzH33FHkPnYGfy7nQ0b+rWZduTy2wMtB999p8ADPsqrelJSA==
X-Received: by 2002:a17:906:7313:b0:94e:988d:acc5 with SMTP id di19-20020a170906731300b0094e988dacc5mr6742369ejc.46.1683220614000;
        Thu, 04 May 2023 10:16:54 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id ig11-20020a1709072e0b00b00965af4c7f07sm972799ejc.20.2023.05.04.10.16.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:16:53 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-95f4c5cb755so134091366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:16:53 -0700 (PDT)
X-Received: by 2002:a17:907:9725:b0:933:1134:be1e with SMTP id
 jg37-20020a170907972500b009331134be1emr7581466ejc.53.1683220613083; Thu, 04
 May 2023 10:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
 <20230504012914.1797355-4-mathieu.desnoyers@efficios.com> <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com>
In-Reply-To: <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 10:16:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
Message-ID: <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
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

On Thu, May 4, 2023 at 7:54=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> +#define list_prepare_entry(pos, head, member) \
> +       ((pos) ? : list_entry(head, typeof(*pos), member))
>
> So even though the fact that "pos" is used as an lvalue specifically in
> llist_for_each_entry_safe() makes it so that the parentheses are not
> strictly required around "pos" in typeof(*pos), I argue that we should
> still add those for consistency.

Ack. It may not matter in reality because of how 'pos' is supposed to
be just a local variable name, but I agree that for consistency our
macros should still follow the usual pattern.

Of course, *because* of how 'pos' is not some random expression, and
is supposed to be that local variable, and because of how it is used,
it must always violate the whole "only use once" usual pattern,.

Exactly the same way the member name is also typically used multiple
times because of how it's not an expression, but really a "part of the
syntax".

So an alternative might be that we should use a different syntax for
those things and make it clear that they are not normal expressions.
Some people use upper-case names for special things like that to make
them stand out as "not normal" (kind of the same way upper-case macros
themselves were a warning that they weren't normal and might evaluate
arguments multiple times).

                   Linus
