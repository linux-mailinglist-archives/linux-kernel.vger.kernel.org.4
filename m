Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A35E803B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiIWQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:58:56 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 09:58:52 PDT
Received: from omta33.uswest2.a.cloudfilter.net (omta33.uswest2.a.cloudfilter.net [35.89.44.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7DA148A0E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:58:52 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id ba3TouGAasYJKblzOoXilM; Fri, 23 Sep 2022 16:57:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id blzModnmlJzQ5blzMoIcOQ; Fri, 23 Sep 2022 16:57:21 +0000
X-Authority-Analysis: v=2.4 cv=MaV/Brzf c=1 sm=1 tr=0 ts=632de571
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=FqOIB2A0pCpItkPd+H5VLg==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10
 a=wYkD_t78qR0A:10 a=1Vq8JeZ7YxIarabX38cA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FLY2ZY7ymRr6++gvseBT22t1fbdbp4dMhqB4jOqPPM8=; b=JfrxsHO/L0pRqzR5yIPhwxR8tC
        PSS37c4n08S2ZiudUSufuraw+SgKPf8+MkA1dUQmo8Gm8OtQ7K2B+HM0EdWMSNFDu+Pm9L+Rn2bFb
        OS9JoS29kihy6g/Z4Y/kABajSDd+o92IszuhMmcytgmETEy70wrbu6VcILf6k+IXagWtZSJHieFi/
        bKzd3XbNaOo3LrqAHGwbttQChLl/dAgrHWEsaeC+bMcQaCsIATwgJMx6vZnLSTZk9mv2IWLWMmYxd
        fItcyeKzD1loGySu8CLY+EmFzvxWJTx+NYrEMSNUg+Nmm3nD7/q0+5+5dFzEQpFXRjZycD3K+81rV
        eD6acjLA==;
Received: from 187.184.158.46.cable.dyn.cableonline.com.mx ([187.184.158.46]:65034 helo=[192.168.0.24])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1oblzL-0014A3-2i;
        Fri, 23 Sep 2022 11:57:19 -0500
Message-ID: <80657fb9-97cf-0677-bc2d-0dbbac2b610a@embeddedor.com>
Date:   Fri, 23 Sep 2022 11:57:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] powerpc: Fix fall-through warning for Clang
Content-Language: en-US
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Wood <oss@buserror.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hardening@vger.kernel.org
References: <Yxe8XTY5C9qJLd0Z@work>
 <166393161454.498456.8335142306216879652.b4-ty@ellerman.id.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <166393161454.498456.8335142306216879652.b4-ty@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.158.46
X-Source-L: No
X-Exim-ID: 1oblzL-0014A3-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.158.46.cable.dyn.cableonline.com.mx ([192.168.0.24]) [187.184.158.46]:65034
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMTcb++bZ/Fx5eIm4TsSDXd9R9AqoZd9ermxdIaPrDh/tSwhAgq6gASJ6sCecV4vHa3K1XmM+l3bCtlQ1HRD4gaLjdiLAVDtxltXIp3Z01T90VjImiWj
 EcXOkCl1ada1mkx2tiVGd1ahKg7RcarFviNmD1N1qb7RSdUaH1nWQUyI+FwitR+zzxRzRnm2XqRD2Zw8zJiujBPKMNJHxX0DmKMK7YSAYz7bXUs4Tg7u2vXI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Applied to powerpc/next.

Great. :)

Thanks, Michael.
--
Gustavo
