Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8CE744BDF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGBACG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 20:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGBACB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 20:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC9199B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 17:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D825F60B47
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 00:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0168C433C8;
        Sun,  2 Jul 2023 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688256117;
        bh=NqLNDmFMcizqeVHlDcBPeBF36DGYb2uyWd6Mia+2mzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pFyUf4ETYCnFFxaPskSP/0ChlKq8IMxk9nF6US1rs9vig43letAIEOneUM68wE/cz
         Gw16ewiaYsPQdAZTTBJnkLRGjFf6K6ZIp3dmOm4A6Dkq/QDTbv0k+U7NoysA7hKyR+
         tBLQbcX13nX9hmfOFGtyah1QyCGASEdsKyBxuXa+ZOODM1p4dRuyO9nltIQMlqhDbw
         SRQYx9THVFVpkIIlQk3ODzGdOITOmLUA8Np1PE6AEfiRaVBE4oyGXDPuBsiv/sw2Cs
         PKL4CVwLuHGh6zM5y/LKv3ezidpF/lgFRTCEfcCDnRpHotbln+TJo23VqiVaBZW0fU
         EGH5j/1FOirjA==
Date:   Sat, 1 Jul 2023 17:01:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: page_pool: a couple assorted
 optimizations
Message-ID: <20230701170155.6f72e4b8@kernel.org>
In-Reply-To: <20230629152305.905962-1-aleksander.lobakin@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 17:23:01 +0200 Alexander Lobakin wrote:
>  #3: new, prereq to #4. Add NAPI state flag, which would indicate
>      napi->poll() is running right now, so that napi->list_owner would
>      point to the CPU where it's being run, not just scheduled;
>  #4: new. In addition to recycling skb PP pages directly when @napi_safe
>      is set, check for the flag from #3, which will mean the same if
>      ->list_owner is pointing to us. This allows to use direct recycling  
>      anytime we're inside a NAPI polling loop or GRO stuff going right
>      after it, covering way more cases than is right now.

You know NAPI pretty well so I'm worried I'm missing something.
I don't think the new flag adds any value. NAPI does not have to 
be running, you can drop patch 3 and use in_softirq() instead of 
the new flag, AFAIU.

The reason I did not do that is that I wasn't sure if there is no
weird (netcons?) case where skb gets freed from an IRQ :(
