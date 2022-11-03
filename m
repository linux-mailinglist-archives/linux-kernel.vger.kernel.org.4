Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071BA617FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiKCOmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiKCOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:42:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C8225E5;
        Thu,  3 Nov 2022 07:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC269B828A3;
        Thu,  3 Nov 2022 14:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5557BC433C1;
        Thu,  3 Nov 2022 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667486531;
        bh=Fr6sZ3qWHRn7BERHIwMyNvr7N6OXXLadvSljoW3ZvFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBhatZl1Akp9WnlwZwFdLXaKLvLhTjktdWs2nRbsXmaCWF4OKvp2aks0zPJKYplPa
         NJFghZykiajjprv1pkIr7Tk8Z+xDkay/hFNIdzH8pDuDqzezC0E5BtkSYT34Ntv55q
         dkBQh5PTgNNOk8Kx0OmdeX3nBox1tkpyjCClZiFmvmXzrt545NARSdaw3uz05Zq/Zv
         FhW/cdRSBS6zvj24X8O/odpOPUZDzXoTN1NL4zGcOyyr3z+sdv/oE1xzshVOdhjcK4
         W0mKvO0NhB7M4hDWWf0/vAdWTbBInJQ8F8JQ49MBq6KE4i/ewmLp1xWMyowiHWu3ZR
         eKCKs05zgKdSA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqbPl-0003bY-VD; Thu, 03 Nov 2022 15:41:54 +0100
Date:   Thu, 3 Nov 2022 15:41:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/2] usb: dwc3: exynos: force PHY control from XHCI HCD
Message-ID: <Y2PTMWhg+xEx5Dy5@hovoldconsulting.com>
References: <CGME20221103141239eucas1p29dac7ffb7202852c18e48c48c068a90f@eucas1p2.samsung.com>
 <20221103141233.20179-1-m.szyprowski@samsung.com>
 <Y2PTAj0gAyWcx+HI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2PTAj0gAyWcx+HI@kroah.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:41:06PM +0900, Greg Kroah-Hartman wrote:
> On Thu, Nov 03, 2022 at 03:12:32PM +0100, Marek Szyprowski wrote:
> > Force controlling of the generic USB PHYs also from XHCI HCD to let XHCI
> > driver call calibrate() method during the HCD reset. DWC3 also controls
> > USB PHYs, but it is not able to call the calibrate() method at the right
> > moment.
> > 
> > Fixes: 6000b8d900cd ("usb: dwc3: disable USB core PHY management")
> > Reported-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > This fixes the issue reported here:
> > https://lore.kernel.org/all/808bdba846bb60456adf10a3016911ee@agner.ch/
> > 
> > Alternative for this change is a complete revert of the 6000b8d900cd
> > ("usb: dwc3: disable USB core PHY management") commit.
> 
> We can revert that commit if something is broken so it can be fixed
> properly instead of this.

Yeah, I'll send the revert I've prepared.

Johan
