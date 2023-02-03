Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798266890B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjBCHWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjBCHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:22:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34AA8A45;
        Thu,  2 Feb 2023 23:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ADF661DA4;
        Fri,  3 Feb 2023 07:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E371C433EF;
        Fri,  3 Feb 2023 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675408949;
        bh=icTa3capbXXz6Tr5vVLT7o8x/2rzWpy+HrEApn3fCe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuXiPY9UdzDQjrqndWYCKpH9LMj0wHpXawtCOAUgprKRkGh6hjr8qP5lBBlMIzv5g
         DTCvPOcrpRomQFnFTFINj3xI8pLhezHzLpLtnxKN6Vc0aZnlp041YEski9iqPcOL2G
         ItkWuYMCuHva5mK+68a4iDRW1DOqGSvW6w0hQYxucXfzSJT8niaYym+wRh2EJW870O
         OHH1jdyPeFMmzRCOsn5K28eD3W19GpINXxCpmKauMtpSNH3c5ONeFM9xna2Dv/kjfH
         Ghj8gD6JFNtM8AWUmuily+7KB8YmcvvwchJxxV+IaQ93QWO6Tn3Obf4y1bN07yu/D6
         ogeFhMrqpu8Cg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNqPP-0008K5-Nc; Fri, 03 Feb 2023 08:22:55 +0100
Date:   Fri, 3 Feb 2023 08:22:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/22] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y9y2T+mrzDk5IVq9@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-18-johan+linaro@kernel.org>
 <8a3eb2d3-5cdf-8bdb-63f5-ab89798d38e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3eb2d3-5cdf-8bdb-63f5-ab89798d38e6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:31:54AM +0100, Konrad Dybcio wrote:
> 
> 
> On 2.02.2023 16:54, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> > needs be stored in some machine-specific non-volatile memory, which the
> > driver can take into account.
> > 
> > Add support for storing a 32-bit offset from the Epoch in an nvmem cell
> > so that the RTC time can be set on such platforms.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> That's gonna be a stupid question, but just to make sure..
> 
> SDAM is rewritable, right? So that when somebody sets the time to
> year 2077 by mistake, they won't have to put up with it for the next
> 50 years? :D

Heh, yes, it is re-writeable. Otherwise, using SDAM wouldn't really have
been an alternative to using the UEFI offset. :)

These registers are reset if you lose battery power so you'd be back at
1970 as expected if that ever happens too.

Johan
