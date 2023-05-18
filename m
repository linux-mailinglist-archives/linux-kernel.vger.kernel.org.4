Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07970848D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjERPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjERPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0573170B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9282664FF6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E875C4339E;
        Thu, 18 May 2023 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684422141;
        bh=xi3asrp56sPf98pO0KbOLnYOqohykz8L/amW+nqIs+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uW8OufCuNHQQ7nfswu1Ueu3ITdB0P2RTXIV9e6yfCUYIDzzIs3AoQlrpKZcZGpqWh
         V+YSitL1FBM+xQuHfKelmMh0UPmtfcC10y1z8KpUA30dzcVtLVa5muOzq/vBv/ZL53
         B0M0aYFzy4IFXn6VZ6dzQxsuaxvY1/citOAINEvMEllDeEz0JwybCwSoT7so4mAQCC
         9/4uKTi4VsIcphyWitNBpkhy3t6vLF4bmPmeqTDLngrUoXPRWGOSJ9GJKAN6iezcc7
         +hj15JkZaXQDQ0fLcg0MOXMXu6mPaLORXIqkWqzEj02mcTH9l/xAVgukySFQCfSd6x
         r1KXwdCLXJQzg==
Date:   Thu, 18 May 2023 08:02:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Christoph Hellwig <hch@lst.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/11] net: page_pool: avoid calling no-op
 externals when possible
Message-ID: <20230518080219.109675cc@kernel.org>
In-Reply-To: <f7a082ae-5ec8-484b-b602-559f6104c9d7@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
        <20230516161841.37138-7-aleksander.lobakin@intel.com>
        <20230517210804.7de610bd@kernel.org>
        <f7a082ae-5ec8-484b-b602-559f6104c9d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 15:34:44 +0200 Alexander Lobakin wrote:
> And seems like I didn't get the sentence regarding "allocate and throw"
> :s This condition just disables the shortcut if any new page suddenly
> requires real DMA syncs (and if it does, then the sync a line below will
> take way more time than 1 more `if`  anyway).

Right, I misread.
