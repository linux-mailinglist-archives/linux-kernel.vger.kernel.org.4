Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B401972074D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjFBQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjFBQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:19:14 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA61AB;
        Fri,  2 Jun 2023 09:19:10 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3078cc99232so2053910f8f.3;
        Fri, 02 Jun 2023 09:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722749; x=1688314749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df45G13freHV7qKaooKW3cbNcYiTjIevZWnDBJV0Ngs=;
        b=hUEnD0Ofsj+rzl64sA0vaThqsrkqYoUsUTISenW0qLKAQ6C2Tj+Ai/OLheoQunlaZm
         PgY00AZi/c/BBWf2gvi5+EOJIAiLgEVFv8EFysrxkP6vDXpGXCWf/eDyY4KTXetUalQi
         C9PLWxGVedEaoH7U13Lfthaak9DuD+EOg64RDjVtHrBQ8lh24+j4hec3Xg5brqQTY+5A
         /QpBQKwpwY8phDgnTuKsxSv31Xotp/weBsvGpSDUMiOsIAHJgtNoNk8toAXNrV/LNtNo
         d3EGoUkTfSHZarrhxesSlnafEdD/F8g7cWQfaqUVNtJe+0VdjORtShHTm1LKlJrkeJqc
         UCCw==
X-Gm-Message-State: AC+VfDw6i4lLwfE81t/W2aMQPrNK/X90TvuHKIyBpfavNNIXD9tzio1l
        Yxvi1yh3A2QGxJGeonJ225o=
X-Google-Smtp-Source: ACHHUZ7V6s1LqVdQdevjsk3RKa1VPwpouEu01j6+gnTKwWbWp9RyusXrlmogJW9nb4M2BtQB8hHwHg==
X-Received: by 2002:a5d:65c2:0:b0:30a:dfb4:e300 with SMTP id e2-20020a5d65c2000000b0030adfb4e300mr389381wrw.28.1685722749158;
        Fri, 02 Jun 2023 09:19:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d4282000000b003047ea78b42sm2075225wrq.43.2023.06.02.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:19:08 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:19:06 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dsahern@kernel.org, Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, leit@fb.com, axboe@kernel.dk,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Message-ID: <ZHoWeiDVoLV1VMpT@gmail.com>
References: <20230530175403.2434218-1-leitao@debian.org>
 <6476f0e4b0182_3c8862294b2@willemb.c.googlers.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6476f0e4b0182_3c8862294b2@willemb.c.googlers.com.notmuch>
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

On Wed, May 31, 2023 at 03:01:56AM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > +int ip6mr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
> > +static inline int sk_is_ip6mr(struct sock *sk)
> > +{
> > +	return sk->sk_family == AF_INET6 &&
> > +		inet_sk(sk)->inet_num == IPPROTO_ICMPV6;
> > +}
 
> Technically, this is just sk_is_icmpv6, which is broader than IPv6
> multicast routing.

Right, let me rename it to reflect this properly.

> No other concerns from me.

Thanks for the detailed review.

> Two small asides, that are fine to ignore.
> 
> The $PROTO_sk_ioctl functions could conceivably call directly into
> the $PROTO_ioctl functions without the indirect function pointer.
> But that would require open coding the sock_sk_ioctl_inout helpers.
> 
> The demux now first checks relatively unlikely multicast routing
> and phonet before falling through to the more common protocols. But
> ioctl is not a hot path operation.

I am more than happy to open code sock_sk_ioctl_inout into protocol
functions, but, I would prefer to do it in a follow up patch, since this
one is close (I hope) to address the original problem. I hope it works
for you.

Thanks!
