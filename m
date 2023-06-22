Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2473A93C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFVT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFVT4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:56:39 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 12:56:37 PDT
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13161BDA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:56:37 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-ABNjBXxtP72N4mZmt67qWQ-1; Thu, 22 Jun 2023 15:55:00 -0400
X-MC-Unique: ABNjBXxtP72N4mZmt67qWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8D64856506;
        Thu, 22 Jun 2023 19:54:55 +0000 (UTC)
Received: from hog (unknown [10.39.195.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FBCE2166B25;
        Thu, 22 Jun 2023 19:54:54 +0000 (UTC)
Date:   Thu, 22 Jun 2023 21:54:53 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Message-ID: <ZJSnDZL-0hLxbDje@hog>
References: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
 <20230621173429.18348fc8@kernel.org>
 <AM9PR08MB67880BD6AC346558D62C92C8DB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
 <AM9PR08MB67887483EDDF2AB7B11BF14FDB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM9PR08MB67887483EDDF2AB7B11BF14FDB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

2023-06-22, 11:49:44 +0000, Carlos Fernandez wrote:
> Hi Jakub,
> 
> Also, about the double look up:
> I know it's there, but I tried to only change the function that returns the correct SCI in every case. Also, it should be a 1 and only item list. I do not think this should be dangerous or slow.

Why is it a 1 item list? Even if that was guaranteed to be true in
normal conditions, we could have a situation where lots of MACsec
SecYs and RXSCs are set up, and packets start hitting this loop.


And could you quote the correct section of 802.1AE? I can't find the
reference for the behavior you're implementing in this patch. All I
can find is (from section 9.5):

    The ES bit is clear if the Source Address is not used to determine the SCI.

    The SC bit shall be clear if an SCI is not present in the SecTAG.

which doesn't say anything about how to interpret both bits being
clear.


(and please don't top-post)


Thanks,

-- 
Sabrina

