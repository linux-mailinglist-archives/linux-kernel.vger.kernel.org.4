Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73560010A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJPQH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJPQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:07:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915E317AA0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:07:25 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1ok6AW-0008HP-ME; Sun, 16 Oct 2022 18:07:16 +0200
Date:   Sun, 16 Oct 2022 18:07:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] staging: r8188eu: summarize tx/rx and scan blinking
Message-ID: <20221016160716.mdofznui73w4ir2c@viti.kaiser.cx>
References: <20221015151115.232095-1-martin@kaiser.cx>
 <20221015151115.232095-11-martin@kaiser.cx>
 <41f4482a-a213-8e71-be43-2e8539b646eb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f4482a-a213-8e71-be43-2e8539b646eb@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thus wrote Philipp Hortmann (philipp.g.hortmann@gmail.com):

> On 10/15/22 17:11, Martin Kaiser wrote:
> > Summarize the code for tx/rx blinking and for scan blinking in blink_work.
> > The only difference is the delay for scheduling the next worker.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >   drivers/staging/r8188eu/core/rtw_led.c | 19 +++----------------
> >   1 file changed, 3 insertions(+), 16 deletions(-)

> > diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> > index f8bd183fba1e..ce8de2eb7845 100644
> > --- a/drivers/staging/r8188eu/core/rtw_led.c
> > +++ b/drivers/staging/r8188eu/core/rtw_led.c
> > @@ -81,21 +81,6 @@ static void blink_work(struct work_struct *work)
> >   		schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
> >   		break;
> >   	case LED_BLINK_SCAN:
> > -		pLed->BlinkTimes--;
> > -		if (pLed->BlinkTimes == 0) {
> > -			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> > -				pLed->CurrLedState = LED_BLINK_NORMAL;
> > -				schedule_delayed_work(&pLed->blink_work, LED_BLINK_LINK_INTVL);
> > -			} else {
> > -				pLed->CurrLedState = LED_BLINK_SLOWLY;
> > -				schedule_delayed_work(&pLed->blink_work, LED_BLINK_NO_LINK_INTVL);
> > -			}
> > -			pLed->bLedBlinkInProgress = false;
> > -			pLed->bLedScanBlinkInProgress = false;
> > -		} else {
> > -			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
> > -		}
> > -		break;
> >   	case LED_BLINK_TXRX:
> >   		pLed->BlinkTimes--;
> >   		if (pLed->BlinkTimes == 0) {
> > @@ -109,7 +94,9 @@ static void blink_work(struct work_struct *work)
> >   			pLed->bLedBlinkInProgress = false;
> >   			pLed->bLedScanBlinkInProgress = false;
> >   		} else {
> > -			schedule_delayed_work(&pLed->blink_work, LED_BLINK_FASTER_INTVL);
> > +			schedule_delayed_work(&pLed->blink_work,
> > +					      pLed->CurrLedState == LED_BLINK_SCAN ?
> > +					      LED_BLINK_SCAN_INTVL : LED_BLINK_FASTER_INTVL);
> >   		}
> >   		break;
> >   	case LED_BLINK_WPS:


> I cannot apply this patch.

> Applying: staging: r8188eu: summarize tx/rx and scan blinking
> error: patch failed: drivers/staging/r8188eu/core/rtw_led.c:81
> error: drivers/staging/r8188eu/core/rtw_led.c: patch does not apply
> Patch failed at 0001 staging: r8188eu: summarize tx/rx and scan blinking

did you apply the patch "staging: r8188eu: remove bLedLinkBlinkInProgress"
(that I sent on Oct 1st) before this series?

I didn't mention this dependency in the cover letter, sorry for that.

Thanks,
Martin
