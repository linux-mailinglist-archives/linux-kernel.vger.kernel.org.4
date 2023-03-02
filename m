Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC26A8426
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCBO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCBO2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7A474EB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677767262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTxrMJqUyW4X5SCAWi1tkS9ixIAshryWM3VoKDkX6js=;
        b=Z7gER4/6Vuf/GHD7MViWLAbXotaDJamILFUBKvmMDqUa48BCRRmyUE+ZlaDiSS6QMyrmRI
        imbaTCOTgNrj0KU2PyYDmQH5rI2TObkMCJv/YmrBJSa6/hxlOovGD3PB54iGBrlo9v7FBR
        GS5pN1elC4isWeE/ONpdTmhw2t67DJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-yw5KjkNUOcaLsL56xsotHw-1; Thu, 02 Mar 2023 09:27:41 -0500
X-MC-Unique: yw5KjkNUOcaLsL56xsotHw-1
Received: by mail-wr1-f70.google.com with SMTP id l14-20020a5d526e000000b002cd851d79b2so2065089wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677767260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTxrMJqUyW4X5SCAWi1tkS9ixIAshryWM3VoKDkX6js=;
        b=GaiodzA2V0dgWpP8kMY45/LBrS1NXe90z1tQkWsIxBiJkYFJhlG6hL4SFhLbCbXtgM
         aBUM4L+rfyl5QMAcDG4JL3tbWjrbp4vOdHVsODegAWzLRwmMgonc0eJrlBv7HXFwICWL
         gl+v0diVvNfQYq8q4BvnmtHpgR47pHpLA8JXSGba5tDjewxC/I/tCxW4z2T+RiqjzRYK
         lwhKTdI8ybEnozoIwvHTgepM4J/9MilCH2niElBssLmyHObVQMZIDZB64Mh8PFG97ca2
         gsMBNSqAexPmwe6aQhYBo5O+0avhG0Jd+wIBN9da+VGs+fBb+MmvhWo5iN+wZwkWB0sm
         ErQQ==
X-Gm-Message-State: AO0yUKXWn47/W+4a6Hx1MQ5TQ+qGpIC+AzJ5ZwW6ipKpXrOX/MKQOOQE
        LPZjyxnUWCoYaABFBe2+OZCOEXCQMy41H5uuQLEtGP0evko4N23keR2+ERS2SHPz96T0GuCDN38
        4cqaIg3DCCjZuB4ny4nDTxN7j
X-Received: by 2002:a05:600c:458d:b0:3eb:3986:9c03 with SMTP id r13-20020a05600c458d00b003eb39869c03mr8498377wmo.4.1677767260316;
        Thu, 02 Mar 2023 06:27:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+XDEBpfqMsm8FydffGycIJMdGzutQxMCWN0tEeXrxStr12oOQQkJvky6L4STooei6BkfnzOQ==
X-Received: by 2002:a05:600c:458d:b0:3eb:3986:9c03 with SMTP id r13-20020a05600c458d00b003eb39869c03mr8498350wmo.4.1677767260037;
        Thu, 02 Mar 2023 06:27:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003dc434b39c7sm8090637wmp.0.2023.03.02.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 06:27:39 -0800 (PST)
Message-ID: <3dc0b4652c04c508b21f2028a20b7f81387c7fd4.camel@redhat.com>
Subject: Re: [PATCH] [net:netfilter]: Keep conntrack reference until IPsecv6
 policy checks are done
From:   Paolo Abeni <pabeni@redhat.com>
To:     Madhu Koriginja <madhu.koriginja@nxp.com>, gerrit@erg.abdn.ac.uk,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        edumazet@google.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vani.namala@nxp.com
Date:   Thu, 02 Mar 2023 15:27:37 +0100
In-Reply-To: <20230302112324.906365-1-madhu.koriginja@nxp.com>
References: <20230302112324.906365-1-madhu.koriginja@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-02 at 16:53 +0530, Madhu Koriginja wrote:
> Keep the conntrack reference until policy checks have been performed for
> IPsec V6 NAT support. The reference needs to be dropped before a packet i=
s
> queued to avoid having the conntrack module unloadable.
>=20
> Signed-off-by: Madhu Koriginja <madhu.koriginja@nxp.com>
> 	V1-V2: added missing () in ip6_input.c in below condition
> 	if (!(ipprot->flags & INET6_PROTO_NOPOLICY))
> ---
>  net/dccp/ipv6.c      |  1 +
>  net/ipv6/ip6_input.c | 14 +++++++-------
>  net/ipv6/raw.c       |  2 +-
>  net/ipv6/tcp_ipv6.c  |  2 ++
>  net/ipv6/udp.c       |  2 ++
>  5 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index 58a401e9cf09..eb503096db6c 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -771,6 +771,7 @@ static int dccp_v6_rcv(struct sk_buff *skb)
> =20
>  	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
>  		goto discard_and_relse;
> +	nf_reset(skb);

nf_reset() is gone since commit 895b5c9f206e ("netfilter: drop bridge
nf reset from nf_reset"), you should use instead nf_reset_ct(): in the
current form the patch does not apply cleanly (nor build after manual
edit).


Cheers,

Paolo

