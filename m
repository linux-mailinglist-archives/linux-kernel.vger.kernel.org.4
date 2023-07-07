Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB29074AB44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGGGmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGGGmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26E211D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688712053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tnh9RFF6b1o3itOQ0L4ZUDIiVmdGCoiMppfW+a9hZwI=;
        b=I3VnqkIJDLjB0LoxSFdUHPu5yli1BHIIVKG0ZCEHQApyrZPW17iUqcWyFjsje0uh2ogXlV
        d8vYG7eiBciEYDNvbrbg7xguO/sVy1bwSaZv7aQQxH0KFsM85Pp2X/91h50zqFn3EzXVoA
        NZb9tmzs07dt+nuKDT4IEcAbt12Jm+U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-GFrtvDTQOC-mi04DX7FLkQ-1; Fri, 07 Jul 2023 02:40:52 -0400
X-MC-Unique: GFrtvDTQOC-mi04DX7FLkQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765ad67e600so33796085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688712051; x=1691304051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tnh9RFF6b1o3itOQ0L4ZUDIiVmdGCoiMppfW+a9hZwI=;
        b=QFecUYTNNg6SzNoRtPcFMS6JtcgIXD0VyDHXk2a0Au74pIZFODajmW3yLxwptHpyeI
         4ye05HS/zd7Dgn0daU0t7UpNGX6py5EaWvaqIAdLQk3eimOYNgmVZ/bnCEt6J8lWcHrw
         WKtgp+XP/r7vFG8TH/OFJm8gBjF1ffjFD1UFg9iUU5AS16Tf0Fn/dGxZvIWUi/Uywi3W
         8FZ8a0UVwOodEYMOkCcjEiXFStMCmdjEtA5ZyuuSA2jlrMt8XmxFpxE5VUdttEN7WBx7
         7ov4TqxcWHvdEtwC5cetwg5SeEe+wQhilb8UhDIOqhklRsrA7lPcfabvPCgfiztABx4Q
         jG2A==
X-Gm-Message-State: ABy/qLbYp+AUgRKLjZS6Y0Q1VFJWN0AEuLTtGABxzwHHN37OZB0J8AqS
        UbePmBUPLO69sXRLp34b+s/O+x2PjnwILyFpp2RUqgbDC72CiR32gjvytRBMtsrlNslsD8mJCsC
        x8zkS7UBaOOWtZxe8v5t78H1d
X-Received: by 2002:a05:620a:370b:b0:762:63b:e10b with SMTP id de11-20020a05620a370b00b00762063be10bmr4836090qkb.1.1688712051507;
        Thu, 06 Jul 2023 23:40:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhsY+qw78IzCHdRZy776Awx2HJNBOpE/K+NPY9VJEpV2P2Y/g5YxPD3XctniL0AECWf1LleQ==
X-Received: by 2002:a05:620a:370b:b0:762:63b:e10b with SMTP id de11-20020a05620a370b00b00762063be10bmr4836070qkb.1.1688712051243;
        Thu, 06 Jul 2023 23:40:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-43.dyn.eolo.it. [146.241.240.43])
        by smtp.gmail.com with ESMTPSA id x20-20020ae9e914000000b00759554bbe48sm1572894qkf.4.2023.07.06.23.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 23:40:50 -0700 (PDT)
Message-ID: <b65e56d0c9aef1e04455454f560a343573d093e0.camel@redhat.com>
Subject: Re: [PATCH v2] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Peilin Ye <peilin.ye@bytedance.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Petr Machata <petrm@nvidia.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Date:   Fri, 07 Jul 2023 08:40:46 +0200
In-Reply-To: <20230707043923.35578-1-ivan@cloudflare.com>
References: <20230707043923.35578-1-ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-06 at 21:39 -0700, Ivan Babrou wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
>=20
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")

Since I raised a question on V1, I was actually satisfied by the answer
and likely some other net maintainer will pick this patch before
myself:

Acked-by: Paolo Abeni <pabeni@redhat.com>

