Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67B70899F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjERUge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjERUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56510D8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A408065209
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A18C433D2;
        Thu, 18 May 2023 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684442189;
        bh=gywY8PWGZ7qWr4FaAteCVzU5t3a/2TpXuUzZ7c29shY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Br1Udi1ECQB0WIbtiCJSMtyrZ0ZMFtG5MnIzFiC83U6jaNH+WQmSY8dQfH8tL7j8Q
         +0jP+65qMGvOW7lyq3wUg7Ji2WecBWrOGFcQSUJZ1GEfYww5ZVUZwDLnUTrwMc6fP2
         gzGp6ZPJpizh1bBzEmvKKr6i6zHmy1H6059ZwMLX/IBnjc5Po3kGx41TypwI5GbomU
         BqSj57ihQq/jIN4FWXdaEKo6fxDk5jRQpfJ0J72FUWhTRv//5QOEh1F9SdnsTgTxOf
         znbu4msMs3yeBVq2ASblyBUHLNTQ209fzRG4urAWuyupdzax7Gzhm5OWwsdeoeGymA
         c2csTSZrjFl/w==
Date:   Thu, 18 May 2023 13:36:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 07/11] net: page_pool: add
 DMA-sync-for-CPU inline helpers
Message-ID: <20230518133627.72747418@kernel.org>
In-Reply-To: <0dfa36f1-a847-739e-4557-fc43e2e8c6a7@intel.com>
References: <20230516161841.37138-1-aleksander.lobakin@intel.com>
        <20230516161841.37138-8-aleksander.lobakin@intel.com>
        <20230517211211.1d1bbd0b@kernel.org>
        <9feef136-7ff3-91a4-4198-237b07a91c0c@intel.com>
        <20230518075643.3a242837@kernel.org>
        <0dfa36f1-a847-739e-4557-fc43e2e8c6a7@intel.com>
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

On Thu, 18 May 2023 17:41:52 +0200 Alexander Lobakin wrote:
> > Or maybe we can do both? I think that separating types, defines and
> > simple wrappers from helpers should be considered good code hygiene.  
> 
> I'll definitely take a look, I also like the idea of minimalistic and
> lightweight headers.
> page_pool.h and page_pool_drv.h? :D

What I've been doing lately is split like this:

include/net/something.h           (simply includes all other headers)
include/net/something/types.h     (structs, defines, enums)
include/net/something/functions.h (inlines and function declarations)

If that's reasonable -- we should put the helpers under

include/net/page_pool/functions.h ?
