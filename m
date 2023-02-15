Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AC698149
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBOQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBOQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:50:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636FC32E6D;
        Wed, 15 Feb 2023 08:50:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19250B82315;
        Wed, 15 Feb 2023 16:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C867BC433EF;
        Wed, 15 Feb 2023 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479823;
        bh=uLarJKzg3GuQJ0dY2bl5m5RJLzCC31PglWJs+3lcu4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hr5FzDtcqvXY60ppMmVSJoNwwexR29uuUJCiZGW74prZxlpjp9kb6Dd2fI2w7ROqY
         TfltEnCuc/m8bayGoV0hzBXoIgfJxEKbTvrbmFpQ3YH+WNmsZkYX8kzgJu5FOxausV
         /2N6GmnUwqmFQhTn3ptmgyIkzgl3Oqbgy0Nbhbtb8uYmWdgm82PFZ5sSgRRgqHnu0E
         adLMIDPKbWUW2CrgQIhvmslvx41Fkd7ooszYK4MEInBb2xTn1AbDM5Eld7PXHW9iuH
         7JUiD1/VR6UST5X/aCqBsfDBp2q4jGplemtO/wG5/vMu7j7G3VlhpardK9NBXRXKOF
         K/ylOtQ3ITRvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSL04-0000Py-TM; Wed, 15 Feb 2023 17:51:20 +0100
Date:   Wed, 15 Feb 2023 17:51:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y+0NiJsp4JjeyrqH@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
 <Y+bJqIpgZ0fbzL2b@mail.local>
 <Y+dQXlABqc/uzIXc@hovoldconsulting.com>
 <Y+fF94EOkUuMq9Fc@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+fF94EOkUuMq9Fc@mail.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 05:44:39PM +0100, Alexandre Belloni wrote:
> On 11/02/2023 09:22:54+0100, Johan Hovold wrote:
> > On Fri, Feb 10, 2023 at 11:48:08PM +0100, Alexandre Belloni wrote:
> > > On 02/02/2023 16:54:42+0100, Johan Hovold wrote:
> > > > On many Qualcomm platforms the PMIC RTC control and time registers are
> > > > read-only so that the RTC time can not be updated. Instead an offset
> > > > needs be stored in some machine-specific non-volatile memory, which a
> > > > driver can take into account.
> > > > 
> > > > Add an 'offset' nvmem cell which can be used to store a 32-bit offset
> > > > from the Unix epoch so that the RTC time can be updated on such
> > > > platforms.
> > > > 
> > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> > > The patch doesn't apply because this part of the context is not
> > > upstream. Can you rebase?
> > 
> > Ah, sorry about that. That's because of commit 51b3802e7960
> > ("dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property") which
> > is now in Linus's tree (and your rtc-fixes branch).
> > 
> > Do you still want me to rebase or do you prefer to handle the conflict
> > some other way?
> 
> Ah yes, my bad, I'll merge rtc-fixes in rtc-next before applying

Sorry about reminding so soon, but with the merge window approaching
fast, will you be able to get this merged for 6.3?

Johan
