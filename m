Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4733617FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiKCOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiKCOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9092725E5;
        Thu,  3 Nov 2022 07:40:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2869461EAC;
        Thu,  3 Nov 2022 14:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B88C433D7;
        Thu,  3 Nov 2022 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667486426;
        bh=FX8DaYkGJUIjMtkFF0QjXEwRsUNfg54NBu8u9llBGqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkvUIinksYUEpKv9Rf5tFYWZBtC+MyeXjDK1Z80b5sfn0wMxS7vhB1ElhQoGUwvSB
         ylTR7OhNlQj7ZnLU8xzBXWfD3AGgCi9/utTnEpCzu6+FkZb8utSBbl7VhajKMgNtYV
         99k8H8zlerrMUH0KzxAGZJdgoOGk1gClv1fEHqHo=
Date:   Thu, 3 Nov 2022 23:41:06 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/2] usb: dwc3: exynos: force PHY control from XHCI HCD
Message-ID: <Y2PTAj0gAyWcx+HI@kroah.com>
References: <CGME20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f@eucas1p2.samsung.com>
 <20221103141233.20179-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103141233.20179-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:12:32PM +0100, Marek Szyprowski wrote:
> Force controlling of the generic USB PHYs also from XHCI HCD to let XHCI
> driver call calibrate() method during the HCD reset. DWC3 also controls
> USB PHYs, but it is not able to call the calibrate() method at the right
> moment.
> 
> Fixes: 6000b8d900cd ("usb: dwc3: disable USB core PHY management")
> Reported-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This fixes the issue reported here:
> https://lore.kernel.org/all/808bdba846bb60456adf10a3016911ee@agner.ch/
> 
> Alternative for this change is a complete revert of the 6000b8d900cd
> ("usb: dwc3: disable USB core PHY management") commit.

We can revert that commit if something is broken so it can be fixed
properly instead of this.

thanks,

greg k-h
