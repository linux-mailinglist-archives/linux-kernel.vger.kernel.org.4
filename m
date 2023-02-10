Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE93691B03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBJJNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjBJJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:13:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CC4FAFA;
        Fri, 10 Feb 2023 01:13:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C60B8241B;
        Fri, 10 Feb 2023 09:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0850C4339B;
        Fri, 10 Feb 2023 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676020399;
        bh=esIXHBmmS3pqpGwLNhUQ6Ii7sMfPCBvQdFEsp8xZSkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGOU9n7k9lug7NB3lUdbgn/Ber926yIUIewdE7uXU0cW6sjQ2Q3/3oJn3ZWqUDq7v
         AIp5zytcdOCZHcLyTyVxKY44yz0W5hQgfBL0vR8lvqyyPUqKdW0u4QyGBaDyBEIES8
         Iua2Eam2OlJVmNXA/FQWvXCrbVS/xt9ABjELeWAXcjJ8IweLM0Pnkh9r8O5kKbFkZm
         Tx3VFT8e8aBUEfJ9KZwDCujIXtVALwaBMauOJwzhppDpfSLJembPWC7KMM8/sSYYt2
         sJ8q37glY2kw08fottaBfzlkxu+O53VTWp544QAwt2WSbip28GBqPD2OEtUIPxo46s
         wTm5bR1x2emgw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pQPTl-00059j-13; Fri, 10 Feb 2023 10:14:01 +0100
Date:   Fri, 10 Feb 2023 10:14:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/22] rtc: pm8xxx: add support for setting
 time using nvmem
Message-ID: <Y+YK2VPAA3dT5HVT@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <167598144775.1655758.2122287458672785227.b4-ty@bootlin.com>
 <Y+X4EBACJ/AYvtOw@hovoldconsulting.com>
 <Y+YIg9Yp3Sy7n4Pb@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+YIg9Yp3Sy7n4Pb@mail.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:04:03AM +0100, Alexandre Belloni wrote:
> On 10/02/2023 08:53:52+0100, Johan Hovold wrote:
> > On Thu, Feb 09, 2023 at 11:25:34PM +0100, Alexandre Belloni wrote:
> > > 
> > > On Thu, 02 Feb 2023 16:54:26 +0100, Johan Hovold wrote:
> > > > This series adds support for setting the RTC time on Qualcomm platforms
> > > > where the PMIC RTC time registers are read-only by instead storing an
> > > > offset in some other non-volatile memory. This is used to enable the RTC
> > > > in the SC8280XP Compute Reference Design (CRD) and Lenovo Thinkpad X13s
> > > > laptop.
> > > > 
> > > > The RTCs in many Qualcomm devices are effectively broken due to the time
> > > > registers being read-only. Instead some other non-volatile memory can be
> > > > used to store and offset which a driver can take into account. On
> > > > machines like the X13s, the UEFI firmware (and Windows) use a UEFI
> > > > variable for storing such an offset, but not all Qualcomm systems use
> > > > UEFI.
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [01/22] rtc: pm8xxx: fix set-alarm race
> > >         commit: c88db0eff9722fc2b6c4d172a50471d20e08ecc6
> > 
> > ...
> > 
> > > [15/22] rtc: pm8xxx: drop error messages
> > >         commit: c94fb939e65155bc889e62396f83ef4317d643ac
> > 
> > I noticed that you did not apply patches 16 and 17 that add support for
> > the nvmem offset. Was that on purpose or a mistake?
> 
> This was on purpose, I'll handle them tonight.

Ok, thanks.

Johan
