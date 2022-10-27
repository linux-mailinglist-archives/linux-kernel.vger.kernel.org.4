Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672C960FC05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiJ0PcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiJ0PcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:32:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DEF18813A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:32:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3691e040abaso18433007b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zmCbwj0R8P1BM9pTkc8XULAhA6pwb4mDXyRYHfP8/R4=;
        b=b9D8M2v7w8F6vEXA3e7Ub/GcZBoAvCf9VFyPZnA/LGaCTwJSIvWvleM8gOU7NgryFy
         vjEVgaWk3nT5vHiX8j4MUXIADXcQq3DsfmuIWnJ4tohqWJRS1swh14V07iUg7BRjaz9X
         8R53NY7nL6UugBYZNsAjrJuCEWqFxqE2Fbv8wrpHTyGNdJrBHHvy2P1mQsFrCFSIBdGg
         JwGUwcMMnAWhxQ0ApZCODhX/VbBFpX7cDcdky9IY+tA1rrofy5z0DoJGBgT+5Ttal6rm
         s/Oc+AeA6q9y3BVWvUN/q0slQN/5HKirb5tqO0O6iuQ3rxM/D/uEHayAshSMBU1/H97d
         IZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmCbwj0R8P1BM9pTkc8XULAhA6pwb4mDXyRYHfP8/R4=;
        b=ZH932bLn6BUXgeMpEt79CHP7rP47HYQtvFkey5ELxmSY13INGvmQJ4QL8J/ABIVhWd
         ptr78uZ1umjEMVU2IMcUBDJPfqrGA1Zsj9WmDm0K3ghVEU4zfkyE+n/Kq6D0iBZ5flBf
         gRo0Z4SGMnPEOpcDDbsLxTPZFUHjmviSAHSXWAmbMLiQ3iRa2L+1Up6WQlxNqKbzpVEv
         uNhCWDb9NQWzhQEZA3P59F6+bBlzWkOSiYcIjGGJiOesLqVA4gzGx28wN70QpN4JfaR6
         pTWELX2ACX3RMVaTlANCsTeHz6YU24Xm7L+0aXspZoEDjDnp5jIrygY02GQ3a/ENWEpH
         Vm9A==
X-Gm-Message-State: ACrzQf0SJNyQCtZBH8ZjZcwUQ58atjnQ0rHBsgnoXs7ddvxBTUAdP7pd
        fw+pM62xb3Zls89HBRJPTytkO5eiEdSF+EiNJwtMnw==
X-Google-Smtp-Source: AMsMyM7WdlaoOZpPcFhg4nG3c0clrQkqJZXxt2vunkZm2XGdB6+2pMhv+a5YsPY7HOoS1+H15LEtayVs7UnAQQHuK3s=
X-Received: by 2002:a81:9a4f:0:b0:367:fbf9:b9f1 with SMTP id
 r76-20020a819a4f000000b00367fbf9b9f1mr38586851ywg.55.1666884733083; Thu, 27
 Oct 2022 08:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220902141715.1038615-1-imagedong@tencent.com>
 <CANn89iK7Mm4aPpr1-VM5OgicuHrHjo9nm9P9bYgOKKH9yczFzg@mail.gmail.com> <20220905103808.434f6909@gandalf.local.home>
In-Reply-To: <20220905103808.434f6909@gandalf.local.home>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Oct 2022 08:32:02 -0700
Message-ID: <CANn89i+qp=gmhx_1b+=hEiHA7yNGkfh46YPKhUc9GFbtNYBZrA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: skb: export skb drop reaons to user by TRACE_DEFINE_ENUM
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Hao Peng <flyingpeng@tencent.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, robh@kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
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

On Mon, Sep 5, 2022 at 7:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 2 Sep 2022 08:43:07 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>
> > > ---
> > > v2:
> > > - undef FN/FNe after use it (Jakub Kicinski)
> >
> > I would love some feedback from Steven :)
>
> The undef should be fine. I usually do not, but that's more of a preference
> than a rule.
>
> As long as the undef is done after the C portion of where the macro is used:
>
> +#undef FN
> +#define FN(reason)     TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
> +DEFINE_DROP_REASON(FN, FN) <<<--- C portion
>
> +#undef FN
> +#undef FNe
> +#define FN(reason)     { SKB_DROP_REASON_##reason, #reason },
> +#define FNe(reason)    { SKB_DROP_REASON_##reason, #reason }
> +
>  /*
>   * Tracepoint for free an sk_buff:
>   */
> @@ -35,9 +44,13 @@ TRACE_EVENT(kfree_skb,
>
>         TP_printk("skbaddr=%p protocol=%u location=%p reason: %s",
>                   __entry->skbaddr, __entry->protocol, __entry->location,
> -                 drop_reasons[__entry->reason])
> +                 __print_symbolic(__entry->reason,
> +                                  DEFINE_DROP_REASON(FN, FNe)))  <<<--- C portion
>  );
>
> +#undef FN
> +#undef FNe
>
> So for this part: Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve

This seems broken again (tried on latest net-next tree)

perf script
            sshd 12192 [006]   200.090602: skb:kfree_skb:
skbaddr=0x2fa000400000 protocol=7844 location=0x2fa000001ea4 reason:
         swapper     0 [030]   200.497468: skb:kfree_skb:
skbaddr=0xba00400001 protocol=65535 location=0x9080c62800000000
reason:
 kworker/30:1-ev   308 [030]   200.497476: skb:kfree_skb:
skbaddr=0xba00400001 protocol=65535 location=0x9080c62800000000
reason:
         swapper     0 [009]   200.957881: skb:kfree_skb:
skbaddr=0x2fa400400000 protocol=12195 location=0x2fa400002fa3 reason:
         swapper     0 [026]   201.515769: skb:kfree_skb:
skbaddr=0xb600400001 protocol=65535 location=0x9080c62800000000
reason:
 kworker/26:1-mm   276 [026]   201.515797: skb:kfree_skb:
skbaddr=0xb600400001 protocol=65535 location=0x9080c62800000000
reason:
 kworker/26:1-mm   276 [026]   201.515802: skb:kfree_skb:
skbaddr=0x2f9f00400000 protocol=12189 location=0x2f9f00002f9d reason:
         swapper     0 [030]   201.521484: skb:kfree_skb:
skbaddr=0xba00400001 protocol=65535 location=0x9080c62800000000
reason:
 kworker/30:1-ev   308 [030]   201.521491: skb:kfree_skb:
skbaddr=0x2fa100400000 protocol=12192 location=0x2fa100002fa0 reason:
