Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EE5B743E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiIMPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiIMPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BC34D808;
        Tue, 13 Sep 2022 07:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10AA1614D3;
        Tue, 13 Sep 2022 14:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD1AC433D7;
        Tue, 13 Sep 2022 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663079689;
        bh=2d3LptxMXzkoXlaSrt8wY8ciXTV2Oe42v3GLdwXwVcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZaqTmJaZMYrzJfEi29ZmYp5VDETIcvvBqZ9RjH1YLAAOQMHf5ZKGZRTZTu686eKcM
         cZtYuRBnpXSH+GdBt5+1WA/QNOiM3M9VWjZRnF2RZXZJPJonS4qWVKqgMdTXxsV/kO
         1TVKdRWUFT7DaGBSnZpFHPyBxYrdt0S+qp7WOlHCT6s23QyC8AEoJCzVeT7PSyijbs
         xlraAbJRvJEO7ztier6w12vRxQf+Pv92Hw8SoMDdwe+ZR2PhWundTwwR/9nKKaZISe
         US7cj5Jzsekz008xBpbHPgzlZQ0qn/3KUxFrBnLEVYHatT2h0ETJDBwq5suG2rs/1e
         +pNvPFYj7dsWg==
Date:   Tue, 13 Sep 2022 20:04:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        bhsieh@nvidia.com, linux-phy@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] phy: tegra: xusb: add utmi pad power on/down ops
Message-ID: <YyCVBVRQo+qPo5vH@matsya>
References: <20220816082353.13390-1-jilin@nvidia.com>
 <20220816082353.13390-2-jilin@nvidia.com>
 <YxS6FBeyS1Cs7xhI@matsya>
 <8d33abb0-51ab-67c4-50b3-ae95a5d9fb55@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d33abb0-51ab-67c4-50b3-ae95a5d9fb55@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-09-22, 10:43, JC Kuo wrote:
> Hi Vinod,

Please _do_ _not_ _top_ _post_

> Before the device or host is being attached, we can keep most of the
> transceivers powered down (PD=1/PD_DR=1) to minimize power consumption. At this
> stage, in .phy_power_on(), we enable only the single-ended receiver (PD_ZI=0)
> for detecting connection. Upon detecting device's or host's connection, host or
> controller driver will invoke tegra_phy_xusb_utmi_pad_power_on() to power on all
> of the transceivers (PD=0/PD_DR=0) to equip full link functionality.

Thanks for this explanation... It helps!

Just a suggestion, can this be moved into phy_init() you have detected
connection in phy_power_on(), the transceiver can be enabled in
phy_int... Would that work?

-- 
~Vinod
