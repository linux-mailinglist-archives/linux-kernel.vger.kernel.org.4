Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85B727A41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjFHInY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjFHInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:43:20 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB64199D;
        Thu,  8 Jun 2023 01:43:18 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30e57e0a0c7so226740f8f.2;
        Thu, 08 Jun 2023 01:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686213797; x=1688805797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM0M/xxWO+GYo8qM7bZgfmTBJclcCiBWNAU2zxTbSYA=;
        b=DvA2KJpHG/ncFnt7ooyrJNEl5iZapAGxEOiN6SS0HeNl7Md+YrDGeVlluvaoNda4xt
         4cBnxjTi507WebBugDnkxpoZejUOSiw/FoIr1xci2cwmvduz6gfJV3oFGN8YbNOK2Irl
         ssZC7Sygoqceyl/acZXL2bEhkrVKKYhhLH6xFOuAPPvMTRfr4L/h+IBCUKodTSGVisw3
         cTSzyqfjGjM3df/HKroaucHbmclg4xwIRkG5vVVJFvhUMV6Tn2fZiO0lsIJInxZ2gRFt
         vAGQGIG3L9QbOuGVCHpsFdxoApNiBAYNWMhwRjV71enPM2bYjilCZ1aL/NBYvF5HChrM
         Ci3g==
X-Gm-Message-State: AC+VfDyTCQbcE7nJYpYnKBF/dJ/axI9QDAF59ZnFGGNwHTYq0Pioj07K
        OfgHqJm/RS1POhHS/zwLfrc=
X-Google-Smtp-Source: ACHHUZ51O9QJBqlbVgnSOBcHI1l+qZO/4fAJGNrHQbwyXuH/AvAbPuvTbGzVjc+BPzSnPO2MvupMbg==
X-Received: by 2002:adf:fccf:0:b0:309:5068:9ebe with SMTP id f15-20020adffccf000000b0030950689ebemr5748626wrs.50.1686213796423;
        Thu, 08 Jun 2023 01:43:16 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm882156wro.95.2023.06.08.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:43:15 -0700 (PDT)
Date:   Thu, 8 Jun 2023 01:43:13 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     alex.aring@gmail.com, andrea.righi@canonical.com,
        asml.silence@gmail.com, ast@kernel.org, axboe@kernel.dk,
        courmisch@gmail.com, davem@davemloft.net, dccp@vger.kernel.org,
        dsahern@kernel.org, edumazet@google.com, gnault@redhat.com,
        hbh25y@gmail.com, joannelkoong@gmail.com, kernelxing@tencent.com,
        kuba@kernel.org, leit@fb.com, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org,
        lucien.xin@gmail.com, marcelo.leitner@gmail.com,
        martin.lau@kernel.org, martineau@kernel.org,
        matthieu.baerts@tessares.net, miquel.raynal@bootlin.com,
        mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
        stefan@datenfreihafen.org, willemdebruijn.kernel@gmail.com,
        wojciech.drewek@intel.com
Subject: Re: [PATCH net-next v6] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Message-ID: <ZIGUofpP4k24qfQs@gmail.com>
References: <20230606180045.827659-1-leitao@debian.org>
 <20230607173142.86395-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607173142.86395-1-kuniyu@amazon.com>
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

Hello Kuniyuki,
On Wed, Jun 07, 2023 at 10:31:42AM -0700, Kuniyuki Iwashima wrote:
> > +/* This is the most common ioctl prep function, where the result (4 bytes) is
> > + * copied back to userspace if the ioctl() returns successfully. No input is
> > + * copied from userspace as input argument.
> > + */
> > +static int sock_ioctl_out(struct sock *sk, unsigned int cmd, void __user *arg)
> > +{
> > +	int ret, karg = 0;
> > +
> > +	ret = sk->sk_prot->ioctl(sk, cmd, &karg);
> 
> We need READ_ONCE(sk->sk_prot) as IPv4 conversion or ULP chnage could
> occur at the same time.

Thanks for the heads-up. I would like to pick you brain and understand
a bit more about READ_ONCE() and what is the situation that READ_ONCE()
will solve.

Is the situation related to when sock_ioctl_out() start to execute, and
"sk->sk_prot" changes in a different thread? If that is the case, the
arguments (cmd and arg) will be from the "previous" instance.

Also, grepping for "sk->sk_prot->", I see more than a bunch of calls
that do not use READ_ONCE() barrier. Why is this case different?

Thank you
