Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1685BD57F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiISUCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:02:30 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6D474CB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:02:29 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oaMyC-0000KT-Ca; Mon, 19 Sep 2022 22:02:20 +0200
Date:   Mon, 19 Sep 2022 22:02:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: r8188eu: remove duplicate bSurpriseRemoved
 check
Message-ID: <20220919200220.c2cslbua6defxmwb@viti.kaiser.cx>
References: <20220918175700.215170-1-martin@kaiser.cx>
 <20220918175700.215170-6-martin@kaiser.cx>
 <8b17ac60-b2ec-26eb-d82c-9770e9733cdf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b17ac60-b2ec-26eb-d82c-9770e9733cdf@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thus wrote Michael Straube (straube.linux@gmail.com):

> On 9/18/22 19:56, Martin Kaiser wrote:
> > We don't have to check bSurpriseRemoved in the SwLedOn function.

> > SwLedOn calls rtw_read8 which in turn calls usb_read. This function checks
> > bSurpriseRemoved for us.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >   drivers/staging/r8188eu/core/rtw_led.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> > index 744247af5956..989808a2b171 100644
> > --- a/drivers/staging/r8188eu/core/rtw_led.c
> > +++ b/drivers/staging/r8188eu/core/rtw_led.c
> > @@ -35,7 +35,7 @@ static void SwLedOn(struct adapter *padapter, struct led_priv *pLed)
> >   	u8	LedCfg;
> >   	int res;
> > -	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
> > +	if (padapter->bDriverStopped)
> >   		return;
> >   	res = rtw_read8(padapter, REG_LEDCFG2, &LedCfg);

> Hi Martin,

> same could be done in SwLedOff.

you're right. I wanted to kick off the bSurpriseRemoved cleanup with a
simple patch and wait for people's comments. I'll do SwLedOff when this
one's accepted.

Thanks,
Martin
