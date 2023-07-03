Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFD74631B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGCS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGCS5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889DE72
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC3A60D3A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308E3C433C9;
        Mon,  3 Jul 2023 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688410655;
        bh=OIv2RRVC1eYXq8oVsIMyY5E/H7XjsncG4Xa4yBw7bo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Th//EDX6dp8QwTTAJkx2vAuz0Xmsu+TVAdd6j4CzRQipNQnecWL6XLU9cmwCw7O6L
         JTdyL4GnWX17SlnGuWLUSLR5RMJPxTGlHyRqlGu2Q41DRcM1q7MCBoTkT5UH1Kni/f
         J3seofPNdlRpNFpWkXPhpG/Ef23K4qslMe7muTLE+g9ME28m970zhOvbGKB3hxa7HO
         FUJier1Z1JChEvNPo3CeHKhT1lxJvMkW/gvLn69mHyHC+PJ6kSPWLhI6bfIEegu2Pw
         gjNFz66P1CaIA7kZxAhAiD3FmeeUjtgVqLn68YSBVd8rGaCn7TULTSicVaet8B/0Up
         xob8zuyaCbjKg==
Date:   Mon, 3 Jul 2023 11:57:34 -0700
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
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 0/4] net: page_pool: a couple assorted
 optimizations
Message-ID: <20230703115734.6ee8f658@kernel.org>
In-Reply-To: <72658bca-c2b2-b3cb-64a0-35540b247a11@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
        <20230701170155.6f72e4b8@kernel.org>
        <72658bca-c2b2-b3cb-64a0-35540b247a11@intel.com>
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

On Mon, 3 Jul 2023 15:50:55 +0200 Alexander Lobakin wrote:
> > The reason I did not do that is that I wasn't sure if there is no
> > weird (netcons?) case where skb gets freed from an IRQ :(  
> 
> Shouldn't they use dev_kfree_skb_any() or _irq()? Usage of plain
> kfree_skb() is not allowed in the TH :s

I haven't looked at the code so I could be lying but I thought that 
the only thing that can't run in hard IRQ context is the destructor,
so if the caller knows there's no destructor they can free the skb.

I'd ask you the inverse question. If the main use case is skb xdp
(which eh, uh, okay..) then why not make it use napi_consume_skb()?
I don't think skb XDP can run in hard IRQ context, can it?

> Anyway, if the flag really makes no sense, I can replace it with
> in_softirq(), it's my hobby to break weird drivers :D
