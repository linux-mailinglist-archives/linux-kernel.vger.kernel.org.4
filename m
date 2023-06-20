Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C773742E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFTSa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFTSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772BC10DA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9A061236
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2825CC433C0;
        Tue, 20 Jun 2023 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687285822;
        bh=YzvlpBIJ1S4sFH9+hFPo656i1oKTPdpC6wWZXmsHRWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PHSUD+Pasa8bpAfIKjED6alVB4e3Fk+TexGxStJYHad3fXhv+ZQgliUhTmGpE51TG
         ZUtm4loVwwbhRi7Hgb6xBQomyKemzogSJiGe22RQXiv5dq8n3Dg8StBa2bbqijZ4F7
         MYlGWUp88djXdvtWi9GYcZyL+bY9DfJk3hq87jmOmB/x1VidNpaJ6ReeUNNNDvgSv2
         4iTUEv05ZOy98hqaFOSjXfhg5Hex3xl/MKo3DDzmadUr0RFhPELaf6Ce9iDmq0a9EN
         bGFtU/rUio5mk8/Yvi/JWIR3SCFKXsUrU3gzIhQBOMX8BrHSJtzcbEFWJfWSNkL3Fs
         N/hBgi5bPnXJg==
Date:   Tue, 20 Jun 2023 11:30:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v3] net: micrel: Change to receive timestamp in
 the frame for lan8841
Message-ID: <20230620113021.01d90f90@kernel.org>
In-Reply-To: <20230615094740.627051-1-horatiu.vultur@microchip.com>
References: <20230615094740.627051-1-horatiu.vultur@microchip.com>
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

On Thu, 15 Jun 2023 11:47:40 +0200 Horatiu Vultur wrote:
> Currently for each timestamp frame, the SW needs to go and read the
> received timestamp over the MDIO bus. But the HW has the capability
> to store the received nanoseconds part and the least significant two
> bits of the seconds in the reserved field of the PTP header. In this
> way we could save few MDIO transactions (actually a little more
> transactions because the access to the PTP registers are indirect)
> for each received frame.
> 
> Instead of reading the rest of seconds part of the timestamp of the
> frame using MDIO transactions schedule PTP worker thread to read the
> seconds part every 500ms and then for each of the received frames use
> this information. Because if for example running with 512 frames per
> second, there is no point to read 512 times the second part.
> 
> Doing all these changes will give a great CPU usage performance.
> Running ptp4l with logSyncInterval of -9 will give a ~60% CPU
> improvement.

Richard, looks good?

I'm not sure if the settime handling is sufficient, some packets may
still sneak thru both getting stamped with new value of time and use
old upper bits and get stamped with old bits and use new upper.
Can we disable timestamping, drain the queue, then change the time
and enable stamping again?
