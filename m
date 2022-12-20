Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6E652354
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiLTPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiLTPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583F10A8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671548362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loRMWcnY9Zc3gsu659uSvWGLXQHgBLYyUdhTzCHdJL4=;
        b=XOLvc/kiSpcjdQy0iDMSP3CbSfXHhqzwiIaP2R3QYfd94Y2ibDvtA/jnEXpDCtICPGaP3r
        UFrr4dcmcDKO4s5ZTihW2R4GWDyem7b/oQYBZpoTNwCUpHGTL5M0I7x9UpoV12YkOFSc/W
        AdVTvd5JyMEnnEUqS/PFYrLROigt6x0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-sZcogwOOMhuBl77V1Aum1w-1; Tue, 20 Dec 2022 09:59:21 -0500
X-MC-Unique: sZcogwOOMhuBl77V1Aum1w-1
Received: by mail-qk1-f199.google.com with SMTP id bs13-20020a05620a470d00b007024c37f800so4579766qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loRMWcnY9Zc3gsu659uSvWGLXQHgBLYyUdhTzCHdJL4=;
        b=aqGxWiTxdRqHbOgP09P9blBntFQ9rlN5VeBLVjHbMdvtntd8x6hImEnpbFmP/8bJvy
         Gl/TTc4ex/Z8ShAyObEvo7vzVaXn9P1Ay1txKfaLRLKMdV72qWgbmaLGzfdEgEcCfCnO
         zNADy4gmJTfstFurr5NgC+ECUKO3mG7N/QYfX41IBBtYKDJwlz5iTcdtpqVruvfeyXho
         J/qqi5nHaodg/F03E1XHO4RyaqUv4qQ7+v61SgZ2mbjIAqlHSPajAaSK6X0nXp4+zNt0
         e1QbTmwPpkq6fhR6bgtlu93TYwqClt+zqS/CPtAcrOYmRio1vj1z3YP23WZVL+a3oicG
         AFiA==
X-Gm-Message-State: ANoB5pmlh3HRBOY1Qkjynv1g9zJ/xhGeT6NulHZNry5NfI39Tjx8Pr/q
        /2WRLf4aZJX1JMx11ebyF38ImzMAm6xF/4tUD+tn6LPpoCxJm7jIlRZeF2n4HU5ZaDwQdrRBggl
        qwBv81QJ9P2g9aqQ6yJSdq5TQ
X-Received: by 2002:ac8:5c03:0:b0:3a6:6181:f4ef with SMTP id i3-20020ac85c03000000b003a66181f4efmr82323446qti.60.1671548360855;
        Tue, 20 Dec 2022 06:59:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50BUcQSQHcEJygADcQA4vzlJrzyssyNaJu8beb5GdIxP7FEGhAjq5wBqu7xFkLkoDZIUDEVw==
X-Received: by 2002:ac8:5c03:0:b0:3a6:6181:f4ef with SMTP id i3-20020ac85c03000000b003a66181f4efmr82323421qti.60.1671548360597;
        Tue, 20 Dec 2022 06:59:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id bn1-20020a05620a2ac100b006fafc111b12sm8962497qkb.83.2022.12.20.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:59:19 -0800 (PST)
Message-ID: <367438a5296d6b43d92287289f44f0e1dfe01d1a.camel@redhat.com>
Subject: Re: [PATCH] net: bridge: mcast: read ngrec once in igmp3/mld2 report
From:   Paolo Abeni <pabeni@redhat.com>
To:     Nikolay Aleksandrov <razor@blackwall.org>,
        Joy Gu <jgu@purestorage.com>, bridge@lists.linux-foundation.org
Cc:     roopa@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, joern@purestorage.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 15:59:15 +0100
In-Reply-To: <05d630bf-7fa8-4495-6345-207f133ef746@blackwall.org>
References: <20221220024807.36502-1-jgu@purestorage.com>
         <05d630bf-7fa8-4495-6345-207f133ef746@blackwall.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-20 at 12:13 +0200, Nikolay Aleksandrov wrote:
> On 20/12/2022 04:48, Joy Gu wrote:
> > In br_ip4_multicast_igmp3_report() and br_ip6_multicast_mld2_report(),
> > "ih" or "mld2r" is a pointer into the skb header. It's dereferenced to
> > get "num", which is used in the for-loop condition that follows.
> > 
> > Compilers are free to not spend a register on "num" and dereference that
> > pointer every time "num" would be used, i.e. every loop iteration. Which
> > would be a bug if pskb_may_pull() (called by ip_mc_may_pull() or
> > ipv6_mc_may_pull() in the loop body) were to change pointers pointing
> > into the skb header, e.g. by freeing "skb->head".
> > 
> > We can avoid this by using READ_ONCE().
> > 
> > Suggested-by: Joern Engel <joern@purestorage.com>
> > Signed-off-by: Joy Gu <jgu@purestorage.com>
> > ---
> >  net/bridge/br_multicast.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> I doubt any compiler would do that (partly due to the ntohs()). 

I would say that any compiler behaving as described above is buggy, as
'skb' is modified inside the loop, and the header pointer is fetched
from the skb, it can't be considered invariant.

> If you have hit a bug or
> seen this with some compiler please provide more details, disassembly of the resulting
> code would be best.

Exactly. A more detailed description of the issue you see is necessary.
And very likely the proposed solution is not the correct one.

Cheers,

Paolo

