Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF07282D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjFHOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjFHOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:35:57 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1872D58;
        Thu,  8 Jun 2023 07:35:52 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso6156945e9.2;
        Thu, 08 Jun 2023 07:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234951; x=1688826951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40BlcYIOiCiG2tmKHXdb8ewCMjsbNxSjJq3O+2btqpQ=;
        b=LVrKO6oUKvcg8/2nyEi5q5+WzyFpfXLtC9snIpVkUhAF/im6GPJ9K1UHCkpj3grB7i
         Tga1U0dBib2zApXx2OAuv4qnBbIRYP+Zp+pQz7juSH74Bqv2ggKKvImI9gi1dyKxO+a0
         WZ8K8GJyV2pElh6tPS0H7FvPJNgRTmk36qRWGy07BY6JbkvMtBhsjLiRHNortriPPEiK
         tVV4VYD3ELDTAvCL8LgkQsqudKFsOlczE1r9jY07Pu2PwvTyX2pMxNKpDV/72LDtsVJD
         9DUmRM0itaOUoPRDPLce+z26UaJx5r7RtLoiwHt1ZspbI/fw7SIZ3zSHB0f+CLjMDF+y
         Hmqg==
X-Gm-Message-State: AC+VfDzFYv4Os6ikUPuim7meOkSrFWoM2rHKy33n8MVaIGSVIiDuocVf
        SZ2E+4ruHgz0f6tcVjzENdY=
X-Google-Smtp-Source: ACHHUZ7lcmNByqTAh5kYMjYbTAGup97yib7alUhZBsoWDIpWRK0lV++ETpqXpbGcOWVV1+uiD32naw==
X-Received: by 2002:a05:600c:21cf:b0:3f6:143:7c4b with SMTP id x15-20020a05600c21cf00b003f601437c4bmr1728617wmj.6.1686234951071;
        Thu, 08 Jun 2023 07:35:51 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003f7e60622f0sm2212389wmj.6.2023.06.08.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:35:50 -0700 (PDT)
Date:   Thu, 8 Jun 2023 07:35:48 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>, alex.aring@gmail.com,
        andrea.righi@canonical.com, asml.silence@gmail.com, ast@kernel.org,
        axboe@kernel.dk, courmisch@gmail.com, davem@davemloft.net,
        dccp@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
        gnault@redhat.com, hbh25y@gmail.com, joannelkoong@gmail.com,
        kernelxing@tencent.com, kuba@kernel.org, leit@fb.com,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-wpan@vger.kernel.org, lucien.xin@gmail.com,
        marcelo.leitner@gmail.com, martin.lau@kernel.org,
        martineau@kernel.org, matthieu.baerts@tessares.net,
        miquel.raynal@bootlin.com, mptcp@lists.linux.dev,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        willemdebruijn.kernel@gmail.com, wojciech.drewek@intel.com
Subject: Re: [PATCH net-next v6] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Message-ID: <ZIHnRFu0ceUxOOvg@gmail.com>
References: <20230606180045.827659-1-leitao@debian.org>
 <20230607173142.86395-1-kuniyu@amazon.com>
 <ZIGUofpP4k24qfQs@gmail.com>
 <5bd6ced877e97ac674d1308eab0b8d2107b7ab85.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd6ced877e97ac674d1308eab0b8d2107b7ab85.camel@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:57:48PM +0200, Paolo Abeni wrote:
> On Thu, 2023-06-08 at 01:43 -0700, Breno Leitao wrote:
> > Hello Kuniyuki,
> > On Wed, Jun 07, 2023 at 10:31:42AM -0700, Kuniyuki Iwashima wrote:
> > > > +/* This is the most common ioctl prep function, where the result (4 bytes) is
> > > > + * copied back to userspace if the ioctl() returns successfully. No input is
> > > > + * copied from userspace as input argument.
> > > > + */
> > > > +static int sock_ioctl_out(struct sock *sk, unsigned int cmd, void __user *arg)
> > > > +{
> > > > +	int ret, karg = 0;
> > > > +
> > > > +	ret = sk->sk_prot->ioctl(sk, cmd, &karg);
> > > 
> > > We need READ_ONCE(sk->sk_prot) as IPv4 conversion or ULP chnage could
> > > occur at the same time.
> > 
> > Thanks for the heads-up. I would like to pick you brain and understand
> > a bit more about READ_ONCE() and what is the situation that READ_ONCE()
> > will solve.
> 
> AFAICS, in this specific case READ_ONCE() should not address any "real"
> bug causing visible issue.
> 
> Still the lack of it will likely cause syzkaller report for (harmless,
> AFAICS) 'data races' around sk->sk_prot. We want to avoid such reports,
> even if harmless, because they can end-up hiding more relevant bugs.
> 
> > Is the situation related to when sock_ioctl_out() start to execute, and
> > "sk->sk_prot" changes in a different thread? If that is the case, the
> > arguments (cmd and arg) will be from the "previous" instance.
> > 
> > Also, grepping for "sk->sk_prot->", I see more than a bunch of calls
> > that do not use READ_ONCE() barrier. Why is this case different?
> 
> Races on sk->sk_prot can happen only on inet6_stream_ops (due to ulp
> and/or ADDRFORM) inet6_dgram_ops (due to ADDRFORM). AFAICS here
> READ_ONCE() is  needed as we can reach here via inet6_stream_ops-
> >inet6_ioctl

Thanks for the clarification, I will send a v6 with the READ_ONCE().

Breno
