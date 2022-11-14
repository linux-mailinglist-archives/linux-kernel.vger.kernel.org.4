Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28E26276FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiKNICN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiKNIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:01:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F912192B6;
        Mon, 14 Nov 2022 00:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDEB60EEF;
        Mon, 14 Nov 2022 08:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D94C433C1;
        Mon, 14 Nov 2022 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668412903;
        bh=+kGmZ2sr1MoPvw4pQEbx/x2LSke6RIWI3WFIYXcquC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoxRhZKBInOC5h2N75rNgmfDJiMzUYwas+6qSzBFYdRPbgVF46SahuG/Xk73Gl/2/
         FENZvSKkiCgUCo9mbsQXDgSepuIBH4llVukrwTAoYENc/pMxPYZkjKuXXSXqISjw3Q
         QKolX1/bThNCpaQQLCsO8G2JoOnC7apghRvabEUdmrq6NPwLVCYuyj+ynzFb//xXAe
         mJS+xAX+Lzw5X4XpWoluergq8yzAz9TQSq5rwJcH44H0Zwcx2CvNN/RoV7PvvQM1/D
         kmSk3x4IEkEpfeFjxG17e0BJjGU/nPedp8WVAPBVvk5NdV5neDB+/TSL1L8B+kFJKi
         oKBV8fjLEWqdA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouUP0-0000za-RS; Mon, 14 Nov 2022 09:01:10 +0100
Date:   Mon, 14 Nov 2022 09:01:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] phy: qcom-qmp-combo: fix runtime suspend
Message-ID: <Y3H1xjtl+dMGssDU@hovoldconsulting.com>
References: <20221111084255.8963-1-johan+linaro@kernel.org>
 <20221111084255.8963-6-johan+linaro@kernel.org>
 <c685cfc8-adec-31e6-c45a-f0e63d85cfcf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c685cfc8-adec-31e6-c45a-f0e63d85cfcf@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 09:17:29AM +0300, Dmitry Baryshkov wrote:
> On 11/11/2022 11:42, Johan Hovold wrote:
> > Drop the confused runtime-suspend type check which effectively broke
> > runtime PM if the DP child node happens to be parsed before the USB
> > child node during probe (e.g. due to order of child nodes in the
> > devicetree).
> > 
> > Instead use the new driver data USB PHY pointer to access the USB
> > configuration and resources.
> > 
> > Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM")
> 
> I belive the Fixes tag is incorrect. One can not easily backport this 
> patch on top of the original ac0d239936bd. I'd suggest to point the 
> Fixes tags to the addition of phy-qcom-qmp-combo.c

The Fixes tag should document the commit introducing the bug regardless
of what kind of changes happened in between.

That said, the tag should have been

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")

as this wasn't an issue before adding DP support, which intentionally
relied on these hard-coded indexes ("luckily USB3 is the first phy").

Johan
