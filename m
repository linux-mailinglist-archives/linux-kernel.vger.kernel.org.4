Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5763F881
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLATmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLATme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:42:34 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA7D5A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:42:32 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id j196so3424373ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yplj9OLHQy4Fa2CQM/nOqHM1WaB6p1zFWZx1JaQhTQo=;
        b=SA6c7+IIWqr5LsKyPZpe9GGKg4sD+nU2eRDx6kwQIJUWrfWo5oW0OEz7ycNQlMke2b
         TX7URQr8zXzDfdIJKVcRfb85gWAZQ3GlKmdH4kQJIgMQYbGmprgTpRqxB+CLpwuutD1+
         Sk1IvlsEqIrsv80FzLMvMZBr7kDoPoex4Gtlk+Jhfe8u9tGT8lFO+Mnd1GE5A/ydUBo5
         UK2GLpAW/ldwh6fbju7vQGb5Lzp+lKdJL2egoHTatKX/ebiPdcU6JzyorxgeukxKjO2B
         SNunrrlEY+fAdYdRHSxIKxzyRH7hp1lWH0OeVoOCWSbC6hquPSuGMEw/WuVvxguQypw1
         1E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yplj9OLHQy4Fa2CQM/nOqHM1WaB6p1zFWZx1JaQhTQo=;
        b=yCMutKEP+m9vkU13/G4qXT8eAQ2Xm3OHVPXEh3T0/JqhJQHgVzAZCCUwO5/UJRlZr7
         lKDuUdSk4NWD7mkDv5405hVpZZJkH1gEnzwNa8+VPbQUQNZNseKezoUdUr4D7X2PCvX8
         /lHsnk4bFyDUL9KLuiPgCnmrSOMOAOctvsROhTsuTfIN0hYYzVCYY9kXEbd7X6gFMRbW
         DZWHBe+y+JlDnC3xo0UcQvMhfcUsD4/83HoUJR1dq+lS2iNdkz1XTjDrsGodnwtpr6jJ
         qUpTcSonj8dSz3HoGtai2+MePzQMAk3bsdo2K/es2cm9VPHTg4doL10OgasxtPKKCESz
         UM1w==
X-Gm-Message-State: ANoB5pk6k3xV5Gs/34vbJ0+bxKM0uVOA5f0Wfxfu6fUHQktflSatpqk7
        ZNQxs+KgiPz/pYWNI4wupnSGETKp4dCxIKhZn2TTiRxOqIA=
X-Google-Smtp-Source: AA0mqf4oqDz0yD4QmilED4SYANZdrhwqb1ofUwjwIJdlCo4OGUEcvd6n7jWNDTE9LsFpfLocco5g41uGtb5wCjpZs6E=
X-Received: by 2002:a25:d88:0:b0:6f0:9db5:63e7 with SMTP id
 130-20020a250d88000000b006f09db563e7mr36519727ybn.387.1669923751805; Thu, 01
 Dec 2022 11:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20221123173859.473629-1-dima@arista.com> <20221123173859.473629-5-dima@arista.com>
In-Reply-To: <20221123173859.473629-5-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 1 Dec 2022 20:42:19 +0100
Message-ID: <CANn89iJv3JP0roZdcHuTr4HS=O_wv8s91PYM3TeCsOZVzqK8KA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] net/tcp: Do cleanup on tcp_md5_key_copy() failure
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 6:39 PM Dmitry Safonov <dima@arista.com> wrote:
>
> If the kernel was short on (atomic) memory and failed to allocate it -
> don't proceed to creation of request socket. Otherwise the socket would
> be unsigned and userspace likely doesn't expect that the TCP is not
> MD5-signed anymore.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
