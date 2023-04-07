Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1CB6DB217
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDGRwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDGRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7E11D;
        Fri,  7 Apr 2023 10:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DB464F8D;
        Fri,  7 Apr 2023 17:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BAC433EF;
        Fri,  7 Apr 2023 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889951;
        bh=MhhhjQ4pSBGhisBxx2pTmj4G3V0rJ5AYrElhbkgEyTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIWEXxa5qaYy98D7lMCS2Nguhnjc1UBLgmdsAkbLOs0dNwa/zlTnzMi6HCxONFS+T
         iDR1UK4RO4azx9yp7GgD5tQPDGJkfkYRx0aBQy8W46gAXHH7pZ1R/TDh7oCq2OSGKg
         DcPODIeofjHMkf0+6e22VZEwhuWvYNSXACBuHpT5uNYBDIUsxekig4oW+FSiLVm8Fx
         gX+NdQ2ZNgHxO9IlX3y28S1LCJyeGTyxaiFBvqSEOxt2cAXv1kg9Lxl2Mz7/uJC7D2
         B7SRouokA2wlLGVlbinDj8sAfSY866TJ6qSgn1Y0kAvnmLYnZy7tvs4M73S1R2TOlA
         3m2KAoyQjCYxQ==
Date:   Fri, 7 Apr 2023 10:55:20 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] Control Quad SPI pinctrl better on Qualcomm
 Chromebooks
Message-ID: <20230407175520.75f5z4hhzeq6qnnr@ripper>
References: <20230323173019.3706069-1-dianders@chromium.org>
 <CACRpkdaGpaiOVjEN6Ftq5=-yuAyD0xb7OcvtEsoqbTzias-xxw@mail.gmail.com>
 <CAD=FV=W6QKfQxGcSrQdgp4VHYxfk7aYZOkYx4ve7QSpoZ-LM=A@mail.gmail.com>
 <CACRpkdaUZbyEfkcHsNuQ=KhyuiKpunZJgvrnq90kQK8Z2V4jtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaUZbyEfkcHsNuQ=KhyuiKpunZJgvrnq90kQK8Z2V4jtg@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:50:34AM +0200, Linus Walleij wrote:
> On Mon, Mar 27, 2023 at 11:51 PM Doug Anderson <dianders@chromium.org> wrote:
> 
> > 1. Mark could land the SPI patch at any time, assuming he's OK with
> > it. It can land totally independently.
> 
> OK this happened.
> 
> > Option A:
> >
> > 3. You land the pinctrl and binding patches in an immutable branch and
> > merge into pinctrl.
> >
> > 4. Bjorn merges the immutable branch into the Qulacomm tree and places
> > the last 3 dts patches atop.
> 
> Looks most appetizing.
> 
> I have applied patches 6,7,8 to this immutable branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-qcom-quad-spi
> 
> and I merged that into my "devel" branch for v6.4.
> 
> Bjorn can grab the branch if he wants it.
> 

Thank you,
Bjorn

> Yours,
> Linus Walleij
