Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B7705DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjEQDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjEQDVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4749420A;
        Tue, 16 May 2023 20:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6454563B86;
        Wed, 17 May 2023 03:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E22C433EF;
        Wed, 17 May 2023 03:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684293660;
        bh=b8ppDmEIaTnXIk/SW60spPG5VJdPpOY7pKL70uyLalg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GLmOJd/IhPXHU/VrBXs/eQuyxrt7RhgP4ss9zIJnezsMFH2Mpi85XpiydHpdPpcjA
         S2R2yNz8hwvkptdI4EHISBf5RnFSlsjL2/bjOLGeOMjjqWJM2xN8NOKg/xDSEJuPJZ
         RI/qtKWLZhfrjX2gZl2fvnqkBTddlOhuJrV4pm9AO53QwWG94yMf1GN7lNB5UfESZT
         v5Nh1HON40Tfdms7mzJokGItxLPLtTVgKPxf8rinOQt1kvf6dbfI26/dMr8CeS7FQo
         fNmU6J5TQKyISi0adkUfBMzX07LdhBXlg5wBIh6ZdXiN4iQUdGIoRIRIFv8+9Ezx7v
         QCHOszeuT5DJQ==
Date:   Tue, 16 May 2023 20:20:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        wuych <yunchuan@nfschina.com>, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: liquidio: lio_core: Remove unnecessary
 (void*) conversions
Message-ID: <20230516202059.09aab4d0@kernel.org>
In-Reply-To: <ZGKT01kLOQNRqx9I@corigine.com>
References: <20230515084906.61491-1-yunchuan@nfschina.com>
        <61522ef5-7c7a-4bee-bcf6-6905a3290e76@kili.mountain>
        <2c8a5e3f-965e-422a-b347-741bcc7d33ce@kili.mountain>
        <ZGKT01kLOQNRqx9I@corigine.com>
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

On Mon, 15 May 2023 22:19:31 +0200 Simon Horman wrote:
> On Mon, May 15, 2023 at 05:56:21PM +0300, Dan Carpenter wrote:
> > On Mon, May 15, 2023 at 12:28:19PM +0300, Dan Carpenter wrote:  
> > > Networking code needs to be in Reverse Christmas Tree order.  Longest
> > > lines first.  This code wasn't really in Reverse Christmas Tree order
> > > to begine with but now it's more obvious.  
> > 
> > Oh, duh.  This obviously can't be reversed because it depends on the
> > first declaration.  Sorry for the noise.  
> 
> FWIIW, I think the preferred approach for such cases is to
> separate the declaration and initialisation. Something like:
> 
> 	struct octeon_device *oct = droq->oct_dev;
> 	struct octeon_device_priv *oct_priv;
> 
> 	oct_priv = oct->priv;

I don't think these changes are worth bothering with at all, TBH.
