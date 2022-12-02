Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC563FFD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 06:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiLBFeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 00:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLBFe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 00:34:28 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38DBD159F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:34:27 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3bfd998fa53so38707877b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 21:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGWt4CfUwAU9seMXwyyFcV9jbw0N3UPxY4xRafk6DjA=;
        b=aTd36vs4Utb9q3nP81XFoiHEuNpDzKX8fZMhvIxRuDivxebm6qNkaMXY9Qebmi4Db6
         LvGUwKogxDopEguMBk/pJM2EVKlGt6QdPyfvBRranHqATqHUyXhvltiIlh6VSAqL9PF0
         /kAj8dCDseZUILrsIHBLL1uxLIRiGA9c4SKETt98PN9GFsg9tegsvLNEuQmyzpeFXKvq
         jZtVBlu9mkpwC3WdFDC40ZO/jcCRpS2MsCtJTlZrTmKAtsYS9DEwATnzvPJ8i3jb5Nsz
         jld6dsXz610+aqDcq01Ks5WOp1tv9mJeqvXR6nQ9OYLk6UQrjhzfPhf/UutxUlfnf3Vp
         V6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGWt4CfUwAU9seMXwyyFcV9jbw0N3UPxY4xRafk6DjA=;
        b=15ShfZYPuMq3+flYVHEFfL+5t1LLqOg7Wg3OmxcfzeH4wy/Fro4rcXEJ/hVxBlSdtC
         RarHFBM/JUVtPI2VtlO39EZOh56RRX6PCm7nE5Swztvk+w8rTWPwsQdUrn6IdZSC14YG
         p6UdZB+5i5hX2z5q3UmIymQX7QNSCtYtz7gpVG2cwx6ov/3NJKSC2WnJ7ECaAciLTO94
         nr+cYGv9xS3YqJFMg+yBOtBX3LtZJNmYADkSOeGZAqU3JQxR9I+OSsE9SB2K1hhuaMOA
         FEsdgVu0Y8D3V9AnyULoZjdYUhpOYU/IPamxqEVk5FsyEDbCqCLCmDB/4McXctqdtjL4
         quug==
X-Gm-Message-State: ANoB5pm8tRQ5+w4Lhfcwrv9OMF91LVcLkxQG1l+i10Gf3DTXh3NWsiaE
        ZvX/FDFNDVNOjFbkue/zORvQabUD5YXLFAhTtuniFw==
X-Google-Smtp-Source: AA0mqf6lbtp4pfw4gb606wdmfhmoZjhXTB3DgAkqmSfrGI4Hud7BpEae5+YfRZRxX8StoMirKfg2CzmwBkzqrEF0T1k=
X-Received: by 2002:a81:5f04:0:b0:393:ab0b:5a31 with SMTP id
 t4-20020a815f04000000b00393ab0b5a31mr65374467ywb.55.1669959266617; Thu, 01
 Dec 2022 21:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20221123173859.473629-1-dima@arista.com> <20221123173859.473629-4-dima@arista.com>
 <CANn89iJEYhTFsF8vqe6enE7d107HfXZvgxN=iLGQj21sx9gwcQ@mail.gmail.com> <CANn89i+6dKFvBRHNyfSbZ6e+Azjz-x48D1um0qrKVRw0xoUquA@mail.gmail.com>
In-Reply-To: <CANn89i+6dKFvBRHNyfSbZ6e+Azjz-x48D1um0qrKVRw0xoUquA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 2 Dec 2022 06:34:14 +0100
Message-ID: <CANn89iLBOaEFezGidVsyLb6uw=9eKUnvH10WvNW7RYfkTiESkg@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] net/tcp: Disable TCP-MD5 static key on
 tcp_md5sig_info destruction
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

On Fri, Dec 2, 2022 at 6:05 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Hmm, I missed two kfree_rcu(key) calls, I will send the following fix:
>

https://patchwork.kernel.org/project/netdevbpf/patch/20221202052847.2623997-1-edumazet@google.com/
