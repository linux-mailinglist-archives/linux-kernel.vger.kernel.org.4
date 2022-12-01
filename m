Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033B63F88C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiLATpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiLATpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:45:06 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E492034D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:45:05 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y83so3384504yby.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1YvGZw1XnIVBqeRZP1o59X2Ld3UUgbPgT4xbhXdQQ1M=;
        b=DEpl9Lk88Vk5PGnfUByEBPRs+ntbZwlf6iNc1UE4zkgvs59P5dr294Q138LZspv54q
         nqeJt5jwLXq5mBEro8eH5CRBg9uQUhXBp7h9ZKJd9ZWwDlvqNSdDsRKstwtvWt0d1tLm
         0OgspjyKifMWeDEf1NPp7NlyCQvk8G/ejgaXOcE2x5HxMonrl202/p/t4vcf0NTi09QF
         p09NRSJunft82epXXvZODTZNeehe6M1k1DGLbUdKv7wAnyQybG3fo0l6I8Zfk5B5tpNj
         +pDcW8+eSEa5+iVrA0EJOGmBWEQrL/4YK7PFOaZRW8Q0GAmztcWX71U4Mk7xMbufQBCS
         bhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YvGZw1XnIVBqeRZP1o59X2Ld3UUgbPgT4xbhXdQQ1M=;
        b=R+mKAFxJhCtcP61q1On+yT74O1A1+/0ZiRnonF0QxmTix0nAHG37OzG5d4Kzu5ZHH7
         ihP6YxGBz77+AKn+VVWbFrHEeYcx0ZUHwg6BcY5w3TQBvJTIarellsp1YL+X547824bt
         Mw8pqfOjYnwF0EETquXyAyzUKsjUq3MYQsnkDXcos2YUEzBVhGYrHki0gLiUPdfPGLnU
         4lsk8mwZOJtvAvvh84lGiKvZYu7ZIBZGXsNEaCQDkDPSeeHOKqsBN9v8if6G4WvmMut4
         49m0Tka8DvC0LBYWQ38gZbFCnqFxCFs7lcBQRCc0FlN76lJjM0BZQ1/Kqe3pb+DPC+mk
         ioAg==
X-Gm-Message-State: ANoB5plNPQ8qHjb/CHerbBTS6AVnr+j3yWMUdBXc72wYLrcQ2+7C8Rpm
        Eg9wVccXptwECJ/Ckv77su9bWFHMXc1vygmwq1f0YA==
X-Google-Smtp-Source: AA0mqf7kRmZHxTJokTF0Zkz4PAZco3C0R5Y01eHdbb/f97t3dmdWuwVpr1K4Ci3W6MDP53lU60ScvbqaqM9APrsHDyI=
X-Received: by 2002:a25:24d:0:b0:6fd:2917:cf60 with SMTP id
 74-20020a25024d000000b006fd2917cf60mr248705ybc.427.1669923904377; Thu, 01 Dec
 2022 11:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20221123173859.473629-1-dima@arista.com> <20221123173859.473629-6-dima@arista.com>
In-Reply-To: <20221123173859.473629-6-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 1 Dec 2022 20:44:49 +0100
Message-ID: <CANn89iJg0=2N2Mxpd3VMe=eCnVHuLqcmo9yg46F7v01hMnDYyA@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] net/tcp: Separate initialization of twsk
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 6:39 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Convert BUG_ON() to WARN_ON_ONCE() and warn as well for unlikely
> static key int overflow error-path.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
