Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE068DCC1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjBGPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:19:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA799;
        Tue,  7 Feb 2023 07:19:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4256CB819CC;
        Tue,  7 Feb 2023 15:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33AFC433D2;
        Tue,  7 Feb 2023 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675783182;
        bh=ZovNKXyQOFiNT9yRWvzB0RMfVbc4+6BHstBVjMe0iWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOZE2wiVRQLAu747NcmmOmsckNR5xiQ1ufyiguvyXvb6VfV+ic+D+8BcfzBRORTuP
         P3Ezv0CD33h+Gew0P+rcJoGJtPTtu1s8sV+h1xgUWeC3Th86Gg8NtnKQPq9cpKHiTB
         i9i2MlNRyZ8/YKdTsofsBU1cs6LRD7ZVmLmBjMQU2Q+BeXtQdiGnEvIuU5gARl56Fo
         HoB5f5rfKVoa3soiv1CPTP1ITX8Y49yacYalrFiaSGoCG9kTU9rFCPAAXR6/MAARwa
         uHlZDM7j6VaN00m/emnwn4fwYVjtN7qpkHe1B/55dFhe9vn8IuYTOau9ytsZKKJyOv
         P8ME+RPBg/SKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPPlY-00028u-Gb; Tue, 07 Feb 2023 16:20:16 +0100
Date:   Tue, 7 Feb 2023 16:20:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/22] rtc: pm8xxx: refactor read_time()
Message-ID: <Y+JsML07a6v7GOml@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-14-johan+linaro@kernel.org>
 <1adf58e8-3afa-856a-2e91-1a4b269edc8f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1adf58e8-3afa-856a-2e91-1a4b269edc8f@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:16:09PM -0800, David Collins wrote:
> On 2/2/23 07:54, Johan Hovold wrote:
> > In preparation for adding support for setting the time by means of an
> > externally stored offset, refactor read_time() by adding a new helper
> > that can be used to retrieve the raw time as stored in the RTC.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/rtc/rtc-pm8xxx.c | 54 ++++++++++++++++++++++++----------------
> >  1 file changed, 33 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> > index b1ce246c501a..2f96a178595c 100644
> > --- a/drivers/rtc/rtc-pm8xxx.c
> > +++ b/drivers/rtc/rtc-pm8xxx.c
> > @@ -59,6 +59,37 @@ struct pm8xxx_rtc {
> >  	struct device *dev;
> >  };
> >  
> > +static int pm8xxx_rtc_read_raw(struct pm8xxx_rtc *rtc_dd, u32 *secs)
> 
> I think that pm8xxx_rtc_read_time_raw() might be a better name for this
> function to avoid any possible confusion if it is being used to read the
> RTC time or the alarm time.

Thanks, that's a good suggestion. I don't think there's any real risk
for confusion here, but if I'm sending a v3 I can rename this one.

> The patch looks good to me otherwise.

Johan
