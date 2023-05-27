Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4970713116
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbjE0BCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjE0BCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D052135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1A5652C3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C2C433D2;
        Sat, 27 May 2023 01:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149331;
        bh=ZwOFaZCsGo5Z6NIy7+xs42xc8Amx32M/il4XYJjhbD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fc1jYAjBz04h3V8l4htX8rqAQJ7PLOdb2JvNQpK0YOjXOKXp1btTR69FHHfS2RMsH
         TWLelyvSzOoucga78KhbNqg+T9KMUfMvD14ABNMLfviKBWEQn0op8ewHeXzb1OH8cf
         QXEiYWrKiValrxacMzVe+xfy4a0SMfBj6lSrnsGkHPO6BMeQigISxOFjOUjm1xsVU1
         yuK6nr6zEi1I71vC3v/GFVMLMmswCpXZ7H4PIdjGnwItwx8jz/IrFaaUbDMdNWwmQ+
         wYisGm+TES66BOFTwuuFf95hMqee1x+CabpMF3pk8eH//byAghGAMNWJQaSOwdUmSK
         rrmfwWQTNAu8w==
Date:   Fri, 26 May 2023 18:02:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 06/12] mm: Make the page_frag_cache allocator
 use per-cpu
Message-ID: <20230526180208.3e617818@kernel.org>
In-Reply-To: <20230524153311.3625329-7-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
        <20230524153311.3625329-7-dhowells@redhat.com>
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

On Wed, 24 May 2023 16:33:05 +0100 David Howells wrote:
> though if a softirq wants to access it, then softirq disablement will
> need to be added.

Pretty sure GVE uses their allocator from softirq.
So this doesn't work, right?
