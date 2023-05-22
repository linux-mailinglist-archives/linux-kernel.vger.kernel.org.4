Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EDB70C2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjEVPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjEVPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:46:13 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59586D2;
        Mon, 22 May 2023 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1684770373; x=1716306373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e//5RLUVPU9F5Ilco4gWUMUa+N+uxNtJHX2X6l2Uq94=;
  b=cAnbUh4nUCYeqtIyvkDEqtn/kK19sYJ3QymwjV7RFOklzoHlqjgvKEfi
   69yPmj3Ekmw4hpBgZwXp86zUugky/NmoCk3M/rKwSrOKSLxZ8IHIGHXPM
   1yJXNqqqvrQTmkA1DAQwwPXSr0oCEvttXNGYc1LdIf+WE7BILy/Iu/22V
   Q=;
X-IronPort-AV: E=Sophos;i="6.00,184,1681171200"; 
   d="scan'208";a="340595341"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:46:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 18F3960D02;
        Mon, 22 May 2023 15:46:07 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 May 2023 15:46:06 +0000
Received: from 88665a182662.ant.amazon.com (10.119.123.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Mon, 22 May 2023 15:46:03 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <ptyadav@amazon.de>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <nmanthey@amazon.de>,
        <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH net] net: fix skb leak in __skb_tstamp_tx()
Date:   Mon, 22 May 2023 08:45:54 -0700
Message-ID: <20230522154554.44836-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522153020.32422-1-ptyadav@amazon.de>
References: <20230522153020.32422-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.123.82]
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <ptyadav@amazon.de>
Date: Mon, 22 May 2023 17:30:20 +0200
> Commit 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with
> TX timestamp.") added a call to skb_orphan_frags_rx() to fix leaks with
> zerocopy skbs. But it ended up adding a leak of its own. When
> skb_orphan_frags_rx() fails, the function just returns, leaking the skb
> it just cloned. Free it before returning.
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> Fixes: 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.")
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Good catch, thanks!


> ---
> 
> I do not know this code very well, this was caught by our static
> analysis tool. I did not try specifically reproducing the leak but I did
> do a boot test by adding this patch on 6.4-rc3 and the kernel boots
> fine.
> 
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 515ec5cdc79c..cea28d30abb5 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5224,8 +5224,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>  	} else {
>  		skb = skb_clone(orig_skb, GFP_ATOMIC);
> 
> -		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
> +		if (skb_orphan_frags_rx(skb, GFP_ATOMIC)) {
> +			kfree_skb(skb);
>  			return;
> +		}
>  	}
>  	if (!skb)
>  		return;
> --
> 2.39.2
