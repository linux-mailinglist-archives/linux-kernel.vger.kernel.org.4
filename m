Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6806596B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiL3JXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:23:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9371A39E;
        Fri, 30 Dec 2022 01:23:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C42661AC2;
        Fri, 30 Dec 2022 09:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603C7C433D2;
        Fri, 30 Dec 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672392199;
        bh=wCEpgrR2Zn8QZRYZE3sT1DPQBW2YKRPQLy0ZSJSb8zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpTb71uSiyGhJNvJ4LDHVbIN0MHC/uEPSCeTHk3Zzm88sC2wDJMr0HHbWky7wachi
         VoGktx4uzoP/xByMaJ0FWLNh/GORCi7GqOaYgJHzuW+JfFBCWyID24yi91jZeLGF7g
         lO92MPKxUXScFqYlcu7cyeXblOcMIWYT6rpZmgddqFqP1p0L2Hf41egicOQjvMZ2Ex
         W8ryRzGG+9XHhkRNWk4Agg9ae4BH+ToJGZ6C1Yzrghh6FB18dRSLkc8yCGmhWPuWPQ
         TOdx2IV3oDURSbIeOc4N6F2Za+PtueRomYjH5E1csEccPGe+FUyniF3lSdjL86LLXA
         ZHl+G9GaLYP5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pBBbq-0002ti-Jz; Fri, 30 Dec 2022 10:23:27 +0100
Date:   Fri, 30 Dec 2022 10:23:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Add RTC support
Message-ID: <Y66uDhAnKlcYM2tX@hovoldconsulting.com>
References: <20221230085010.717423-1-abel.vesa@linaro.org>
 <Y66qkR+WWkopNzQ4@hovoldconsulting.com>
 <Y66tSyDKOkH3T1BT@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y66tSyDKOkH3T1BT@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 11:20:11AM +0200, Abel Vesa wrote:
> On 22-12-30 10:08:33, Johan Hovold wrote:
> > Hi Abel,
> > 
> > On Fri, Dec 30, 2022 at 10:50:10AM +0200, Abel Vesa wrote:
> > > The PMK8350 PMIC has an available RTC block. Describe it in
> > > sc8280xp-pmics dtsi and enable it in Lenovo Thinkpad X13s specific dts.
> > > Mark it as wakeup-source to allow waking the system from sleep.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > 
> > I'm currently working on proper RTC support which implies reading and
> > storing the time offset from EFI.
> > 
> > This patch in itself is pretty much useless as the returned time is just
> > some random time from the epoch (e.g. in the 1970's).
> > 
> > So I suggest waiting another week or so until I'm done.
> 
> Sure thing. Consider this dropped then.
> 
> Please CC me when you have something so I can try it out.

Sure, I will. Since it depends on UEFI support it may take a while to
get everything merged in mainline, but we should have working
out-of-tree support shortly.

Johan
