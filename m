Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A771FD91
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjFBJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjFBJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0554819A5;
        Fri,  2 Jun 2023 02:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8240E60FAB;
        Fri,  2 Jun 2023 09:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40E6C433EF;
        Fri,  2 Jun 2023 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685697573;
        bh=2yXgxWBuoTO7Y7tqzIoMb5klm4nGL1UuQKVbtA7O9yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itNgSAm/man0gynUuA11av2gmxLEYOHc+/BNt6fj7beONHV9k8H7L2R14POhkcr4q
         PL7VHlZJ3SE+XeG4nX7rc1htJsXNuRElLdNDLatLnIIVlss+LaTXANClsbz76O7xqN
         +xNBy6OwFMW74o5E7+2gKxmnTnGMqnTcyqqwwJNrwfR1vZJNwLVeh4QwO0NE5096xI
         dofFpt1QzCD7ZBjzk3fL0ZRNQYuUECVoIbgSZ0WrT1VpvRjODwnzvFmiWXFYp/oMYO
         0W45CYL22EjaKCOiCxyEw0uYU4gQPeJTupYk2T0NVqFWOQFcUGT8VJBAGrVFiC2MWW
         dg6CJBtClaC5w==
Date:   Fri, 2 Jun 2023 10:19:28 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2] leds: qcom-lpg: Fix PWM period limits
Message-ID: <20230602091928.GR449117@google.com>
References: <20230515162604.649203-1-quic_bjorande@quicinc.com>
 <ZG4gBE1rqkMIllV3@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZG4gBE1rqkMIllV3@hovoldconsulting.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Johan Hovold wrote:

> On Mon, May 15, 2023 at 09:26:04AM -0700, Bjorn Andersson wrote:
> > The introduction of high resolution PWM support changed the order of the
> > operations in the calculation of min and max period. The result in both
> > divisions is in most cases a truncation to 0, which limits the period to
> > the range of [0, 0].
> > 
> > Both numerators (and denominators) are within 64 bits, so the whole
> > expression can be put directly into the div64_u64, instead of doing it
> > partially.
> > 
> > Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > Tested-by: Steev Klimaszewski <steev@kali.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Pavel or Lee, could you pick this one up for 6.4 as it fixes a
> regression (e.g. broken backlight on a number of laptops like the X13s)?

I don't presently have any plans for a -fixes submission.

If anyone else would like to submit it, please be my guest:

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
