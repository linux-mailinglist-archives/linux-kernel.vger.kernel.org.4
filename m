Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2636FD369
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEJBBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEJBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54044AB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:00:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BD0B60919
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D20C433EF;
        Wed, 10 May 2023 01:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683680458;
        bh=UrItQrnIMs0ms+sPI5j1Hu3+52mp5ohTLkaAWkiKzsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=czAzhJz1NBrHhvesrdhXOCzsPF9NJZpM9KBiimBJlbeaxSioAxPsw+6MiK98vLaIs
         XdTCRCA86ZY++2JbcBUu3ufVxu+Lzbed6dWiINr+54ORspK4L3MyKg+ihC19tebi/W
         Uq+0Ld0ShNXVeEJgzjwH3LV/5VzXqQT23pbAd2XMK/whPMnaNH/2ZNuj3wACoRaQOh
         zuSp+a0x/1uQwTnjOhXQPdz1YC7sHLmFfEo45Io6eJvYKEzKnKWCgtp/CvllHKBJuJ
         n1BsugIZieX0ezP4aa8h9AN7u773S8wvcu9vikdnCjKjY02f8O1bgteL/WPRNK13dW
         GMx0ojJFX9J6g==
Date:   Tue, 9 May 2023 18:00:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1 0/2] introduce skb_frag_fill_page_desc()
Message-ID: <20230509180057.1fc252c7@kernel.org>
In-Reply-To: <20230509114337.21005-1-linyunsheng@huawei.com>
References: <20230509114337.21005-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 19:43:35 +0800 Yunsheng Lin wrote:
> Most users use __skb_frag_set_page()/skb_frag_off_set()/
> skb_frag_size_set() to fill the page desc for a skb frag.
> It does not make much sense to calling __skb_frag_set_page()
> without calling skb_frag_off_set(), as the offset may depend
> on whether the page is head page or tail page, so add
> skb_frag_fill_page_desc() to fill the page desc for a skb
> frag.
> 
> In the future, we can make sure the page in the frag is
> head page of compound page or a base page, if not, we
> may warn about that and convert the tail page to head
> page and update the offset accordingly, if we see a warning
> about that, we also fix the caller to fill the head page
> in the frag. when the fixing is done, we may remove the
> warning and converting.
> 
> In this way, we can remove the compound_head() or use
> page_ref_*() like the below case:
> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L881
> https://elixir.bootlin.com/linux/latest/source/include/linux/skbuff.h#L3383
> 
> It may also convert net stack to use the folio easier.
> 
> RFC: remove a local variable as pointed out by Simon.

Looks like you posted this 3 times and different people replied with
their acks to different versions :(

Wait awhile, read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
and repost with all the ack/review tags included.
