Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7D974691B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGDFny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:43:53 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C8AB;
        Mon,  3 Jul 2023 22:43:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id B884320764;
        Tue,  4 Jul 2023 07:43:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vXqqGLlnvmHh; Tue,  4 Jul 2023 07:43:48 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id C32DB20520;
        Tue,  4 Jul 2023 07:43:48 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout2.secunet.com (Postfix) with ESMTP id BA62280004A;
        Tue,  4 Jul 2023 07:43:48 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 07:43:48 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 07:43:48 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id CD3163182AE1; Tue,  4 Jul 2023 07:43:47 +0200 (CEST)
Date:   Tue, 4 Jul 2023 07:43:47 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Lin Ma <linma@zju.edu.cn>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <simon.horman@corigine.com>, <adobriyan@gmail.com>
Subject: Re: [PATCH v3] net: xfrm: Fix xfrm_address_filter OOB read
Message-ID: <ZKOxk0Ff5r9MRBHW@gauss3.secunet.de>
References: <20230627033138.1177437-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627033138.1177437-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:31:38AM +0800, Lin Ma wrote:
> We found below OOB crash:
> 
> [   44.211730] ==================================================================
> [   44.212045] BUG: KASAN: slab-out-of-bounds in memcmp+0x8b/0xb0
> [   44.212045] Read of size 8 at addr ffff88800870f320 by task poc.xfrm/97
> [   44.212045]
> [   44.212045] CPU: 0 PID: 97 Comm: poc.xfrm Not tainted 6.4.0-rc7-00072-gdad9774deaf1-dirty #4
> [   44.212045] Call Trace:
> [   44.212045]  <TASK>
> [   44.212045]  dump_stack_lvl+0x37/0x50
> [   44.212045]  print_report+0xcc/0x620
> [   44.212045]  ? __virt_addr_valid+0xf3/0x170
> [   44.212045]  ? memcmp+0x8b/0xb0
> [   44.212045]  kasan_report+0xb2/0xe0
> [   44.212045]  ? memcmp+0x8b/0xb0
> [   44.212045]  kasan_check_range+0x39/0x1c0
> [   44.212045]  memcmp+0x8b/0xb0
> [   44.212045]  xfrm_state_walk+0x21c/0x420

...

> 
> By investigating the code, we find the root cause of this OOB is the lack
> of checks in xfrm_dump_sa(). The buggy code allows a malicious user to pass
> arbitrary value of filter->splen/dplen. Hence, with crafted xfrm states,
> the attacker can achieve 8 bytes heap OOB read, which causes info leak.
> 
>   if (attrs[XFRMA_ADDRESS_FILTER]) {
>     filter = kmemdup(nla_data(attrs[XFRMA_ADDRESS_FILTER]),
>         sizeof(*filter), GFP_KERNEL);
>     if (filter == NULL)
>       return -ENOMEM;
>     // NO MORE CHECKS HERE !!!
>   }
> 
> This patch fixes the OOB by adding necessary boundary checks, just like
> the code in pfkey_dump() function.
> 
> Fixes: d3623099d350 ("ipsec: add support of limited SA dump")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Applied, thanks a lot!
