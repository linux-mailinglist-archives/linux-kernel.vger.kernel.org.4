Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5646160C057
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJYBDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJYBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56D27D4F1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:59:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a5so7123281qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AeR+MXazI4N+TtoyZRzWLxo61z6TXqKZcp0XwTDiTL8=;
        b=gngoJgwAa39wjx0fiJfO/cPbzFFn8Pc5Rpc65Xpes0patgjIRayQb17NdQ6IuPBGsz
         EjCLjn/ykQmX5YqXozqkSbtdkp/nH/G45ZWdJi/g0QegccMCwG/mfmdhE4eoQElG/94i
         ird4TXmkJCiwhJB6bEeKvLhT4Zt2TrdjIJYVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeR+MXazI4N+TtoyZRzWLxo61z6TXqKZcp0XwTDiTL8=;
        b=N2ShQ0VMpvWuhWakGVK3lq292Ldgh9klHqC4221BEnevBuQkeud6L72bzoqs/tdCo2
         r6QG0ItA9kQrPODHOHWZOBQ0chpoG0kY82pkvNEN8PJApiuKuRqeNTJHj+FE6/ODsipD
         1833w1BJOj5uhDI7HehABrqelWHWqXVudD50X8UXgcoahYXhmosSN75clcxwzcctVQoK
         J4SJA4s008+7RRBU9GI8j7reMB2deJBRmsQRbjlOsodo9gczJXRBG6w4/ZAv4+NY0WZB
         tu8WcoHl7A8symJmFaqrp5mG6sP+EiJUrZFKV8NxPxVthv51d25mJam2qJytTe9XMseA
         h82g==
X-Gm-Message-State: ACrzQf0jJ8qH5svQT+rEQ/xcJgdf0YqVwM2Jc845iIrTVHeAm53wcHvy
        OmIpKCnmIiXB012cOMutd+JfLTjXCZx0Cw==
X-Google-Smtp-Source: AMsMyM5fV4pvHvgNxYyE1aNrnOZFlwHxH+IN4QcdPbVqjpIuMlliAblC/8CDU9zJX6L/HS71b/uB3g==
X-Received: by 2002:a05:620a:2487:b0:6ee:74a7:934b with SMTP id i7-20020a05620a248700b006ee74a7934bmr25503355qkn.625.1666655957744;
        Mon, 24 Oct 2022 16:59:17 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a0c4700b006ce813bb306sm924418qki.125.2022.10.24.16.59.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 16:59:15 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id t186so12721266yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:59:15 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr30628068ybb.184.1666655954864; Mon, 24
 Oct 2022 16:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221024182545.78d638a9@gandalf.local.home>
In-Reply-To: <20221024182545.78d638a9@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 16:58:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-j6Lntr84Qssq1gcsUKtNU8Y=RP+0+fnLT4y38zrsPw@mail.gmail.com>
Message-ID: <CAHk-=wj-j6Lntr84Qssq1gcsUKtNU8Y=RP+0+fnLT4y38zrsPw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/mm: Do not verify W^X at boot up on ftrace trampolines
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Adding on the kernel command line "ftrace=function" triggered:

This one I *really* detest.

If we have to have a special case, make it just be the simple
"system_state == SYSTEM_BOOTING", don't make it even nastier.

Special cases are bad. Making them these kinds of "this is
super-magical and special" is even worse.

               Linus
