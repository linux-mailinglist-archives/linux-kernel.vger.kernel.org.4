Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F3675970
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjATQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjATQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:02:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDAB770;
        Fri, 20 Jan 2023 08:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B21B82866;
        Fri, 20 Jan 2023 16:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC80AC433D2;
        Fri, 20 Jan 2023 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674230557;
        bh=2fhXKggMk2LoOy0VnH1LRyNZJuHzcLxH3fbGUuM7wOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NswgWOVXp0vAeIuou5b4vIt+knrUmGSdtcS0AQWHfMt91CsyyHEW33geLP9Rtm7J5
         4LMeqO5PN0r+lyl+bkJLo4YEuUCvJueBQlj3mREW4xXHajbLmnR7muFDUi/vNTMZbO
         CC74qqVLyAoF/8xOI/mbGbVpmYy25KFAPxHvNxFD3PloEoNeUpNKsWL2XZWPTAhu3u
         B56fgL3HdWm/BEIY7LKDY9M+BZ/SEP0JILMZPw8wD0rf0G/t6w76JgLKOicJxfnGhU
         90ky31iiRfQ7B2yXDE2S3nWPGdeCK0JfO9S8QKvmQqOMSsJu5Byje9+vX1nbuUf85q
         /ueWeb+fSEXsg==
Date:   Fri, 20 Jan 2023 16:02:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Pavel Machek <pavel@ucw.cz>, krzysztof.kozlowski@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: lp55xx: configure internal charge pump
Message-ID: <Y8q7F0cDNGFeOv99@google.com>
References: <20230110092342.24132-1-maarten.zanders@mind.be>
 <20230110092342.24132-3-maarten.zanders@mind.be>
 <Y8qdX7QIQntPWuuA@google.com>
 <98a87f2d-f6c3-1dd6-36b1-095e47a87aaa@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98a87f2d-f6c3-1dd6-36b1-095e47a87aaa@mind.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023, Maarten Zanders wrote:

> 
> > > +	pdata->charge_pump_mode = LP55XX_CP_AUTO;
> > > +	ret = of_property_read_string(np, "ti,charge-pump-mode", &pm);
> > > +	if (!ret) {
> > > +		for (cp_mode = LP55XX_CP_OFF;
> > > +		     cp_mode < ARRAY_SIZE(charge_pump_modes);
> > > +		     cp_mode++) {
> > > +			if (!strcasecmp(pm, charge_pump_modes[cp_mode])) {
> > > +				pdata->charge_pump_mode = cp_mode;
> > > +				break;
> > > +			}
> > > +		}
> > > +	}
> > A little over-engineered, no?
> > 
> > Why not make the property a numerical value, then simply:
> > 
> >    ret = of_property_read_u32(np, "ti,charge-pump-mode", &pdata->charge_pump_mode);
> >    if (ret)
> >            data->charge_pump_mode = LP55XX_CP_AUTO;
> > 
> > Elevates the requirement for the crumby indexed array of strings above.
> > 
> > Remainder looks sane enough.
> 
> Thanks for your feedback.
> 
> I won't argue that your implementation isn't far more simple. The idea was
> to have an elaborate and clear and obvious devicetree, but that can also be
> achieved by moving constants into /includes/dt-bindings/leds/leds-lp55xx.h.
> Would that be more acceptable?

Yes please.

-- 
Lee Jones [李琼斯]
