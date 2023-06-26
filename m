Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74373EB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjFZUNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFZUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A7E3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D21160EF2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED2AC433C8;
        Mon, 26 Jun 2023 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687810425;
        bh=UbRl1KTErIhEYg+YOa7ZBftAN9h4c9fJjPE40+2/qb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YkULExNGJwymo7jQ0cbBjIMOGbzql1Kp2sETo0R9TYugc9g6RHD7qkKj8uBYkCOYM
         dG91J3h8bJ5/HkPZpRJWub9hFjTYiLAWGdvuHcuKfTx3n9KJpl+AnoEbbHo58l6y0j
         TK2BiakYDnEuo0PlxPSepaV0R3Kb00LZGuE22+tWb9/jvNZNo+bfuB+neicpgUrxQk
         hmyMaUIjPk7MTXrNt5MESHPFSWkxm4Q4hKN2wlHCq1H5/bM8GyBlInc2F7E42Iimd1
         FWuNnN38cbkz+YDc8NaULjIKN9m6zsVRWixJTmVrJmAV1qb1i/+q1k7tAXe/f7m1ib
         /3CH7U9XM8lOA==
Date:   Mon, 26 Jun 2023 13:13:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jinjian.song@fibocom.com
Subject: Re: [PATCH] net: wwan: t7xx: Add AP CLDMA
Message-ID: <20230626131344.2364f834@kernel.org>
In-Reply-To: <20230626082040.15671-1-jtornosm@redhat.com>
References: <20230626082040.15671-1-jtornosm@redhat.com>
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

On Mon, 26 Jun 2023 10:20:37 +0200 Jose Ignacio Tornos Martinez wrote:
> At this moment with the current status, t7xx is not functional due to
> problems like this after connection, if there is no activity:
> [   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
> [   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
>     (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
> because after this, the traffic no longer works.
> 
> The complete series 'net: wwan: t7xx: fw flashing & coredump support'
> was reverted because of issues with the pci implementation.
> In order to have at least the modem working, it would be enough if just
> the first commit of the series is re-applied:
> d20ef656f994 net: wwan: t7xx: Add AP CLDMA).
> With that, the Application Processor would be controlled, correctly
> suspended and the commented problems would be fixed (I am testing here
> like this with no related issue).
> 
> This commit is independent of the others in the series and not related to 
> the commented pci implementation for the new features: fw flashing and
> coredump collection.
> 
> Original text from the commit that would be re-applied:
> 
>     d20ef656f994 net: wwan: t7xx: Add AP CLDMA
>     Author: Haijun Liu <haijun.liu@mediatek.com>
>     Date:   Tue Aug 16 09:53:28 2022 +0530
> 
>     The t7xx device contains two Cross Layer DMA (CLDMA) interfaces to
>     communicate with AP and Modem processors respectively. So far only
>     MD-CLDMA was being used, this patch enables AP-CLDMA.
> 
>     Rename small Application Processor (sAP) to AP.

A bit of a bad timing, the merge window for 6.5 has just opened 
and we're busy settling the bugs in linux-next right now. So you
will need to repost this change in 2 weeks...


## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

