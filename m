Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE773BBDC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFWPky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFWPkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:40:51 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A7211E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:40:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-ZtD1Nw-gMPGXOzq52WaBHQ-1; Fri, 23 Jun 2023 11:40:32 -0400
X-MC-Unique: ZtD1Nw-gMPGXOzq52WaBHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 026E028040A3;
        Fri, 23 Jun 2023 15:40:32 +0000 (UTC)
Received: from hog (unknown [10.39.195.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0741715230A2;
        Fri, 23 Jun 2023 15:40:30 +0000 (UTC)
Date:   Fri, 23 Jun 2023 17:40:29 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     carlos.fernandez@technica-engineering.de
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Message-ID: <ZJW87b0ijjBytbqB@hog>
References: <ZJSnDZL-0hLxbDje@hog>
 <20230623101355.26790-1-carlos.fernandez@technica-engineering.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623101355.26790-1-carlos.fernandez@technica-engineering.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-23, 12:13:55 +0200, carlos.fernandez@technica-engineering.de wrote:
> Regarding ES, it is only set if the first 6 octets of the SCI are equal to the MAC, 
> in which case SC=0 as well (IEEE802.1AE 9.5 TAG Control information). 
> However, if ES=0, it is incorrect to use source MAC as SCI (current implementation)

But the spec doesn't really say what else we should be using.

Also, if it's incorrect to use the source MAC to build the SCI, we
shouldn't have the fallback that you added in v2/v3 in response to
Simon's comments (we'll probably end up dropping the packet when we
look for the rxsc/secy anyway).

> Regarding SC, as said in IEEE 802.1AE 9.9:
> 
> 
> "An explicitly encoded SCI field in the SecTAG is not required on point-to-point links, 
> which are identified by (...), if the transmitting SecY uses only one transmit SC. 
> In that case, the secure association created by the SecY for the peer SecYs, together with
> the direction of transmission of the secured MPDU, can be used to identify the transmitting SecY."

Thanks for the reference. This should be quoted in the commit message
to explain the reason for the change, as well as this sentence from 9.5:

    The ES bit is clear if the Source Address is not used to determine
    the SCI.

> Therefore the case SC=0 is reserved for cases where both conditions apply: point-to-point links, 
> and only one transmit SC. This requirement makes the size of the reception lookup 1.

That's the intention of the spec. We can't know that we'll only
receive such packets in situations where we have a single RXSC for the
entire real device.

I'm not too worried about the loop being slow (because it's a bit
unlikely that we'll go through lots of iterations on either loop
before we hit an active RXSC), but I'm not convinced that we should be
dumping those packets in the first RXSC we can find.

So I wonder if we should instead (only for ES=0 SC=0):
 - if we have exactly one RXSC for the lower device (ie across the 2
   loops), use it
 - otherwise (0 or > 1), drop the packet and increment InPktsNoSCI

and we can use MACSEC_UNDEF_SCI as return value to indicate a bogus
packet that needs to be dropped.

Would that take care of your use case?

-- 
Sabrina

