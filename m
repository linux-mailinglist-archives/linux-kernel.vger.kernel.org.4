Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC936619254
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKDIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:01:44 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D91825E90
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667548891; bh=ZXbEFO3vszBBy6fk5O/FA9iq9h+aX2yhtD8lxQvGyyY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=GW/j562SKvbtefjP1da8C0bPUhXMdhSu+WiSuZqa0eGV0Rxv9CgfM/sSN45a+dsWr
         ghPCXresOipC1pAgzV+xRAUfOaevRNjMDNEXAe5cSdojbvpcVCMpUfJQFQvZEFU4/i
         1cX8raOMQ3wTTj9WvW7RKoxEtvsvW887NKQcERRQ=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri,  4 Nov 2022 09:01:31 +0100 (CET)
X-EA-Auth: TUR8vkepu6ByoPiTb+uNlOvt9qpGRr7QafjQ7F7kzVZlMHyVldXK0bfWPOhHlnqBQIWdY5EGAPyjjPVaNYhh/eEZ9L3B/oI5
Date:   Fri, 4 Nov 2022 13:31:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8192e: Use min_t/max_t macros for variable
 comparison
Message-ID: <Y2TG0ain2dzfq76V@qemulion>
References: <Y2LxC2kziM1TznhO@qemulion>
 <d8fa86bf71694f23b8f175245722e86f@AcuMS.aculab.com>
 <Y2OBmWIwhRMOk6V/@kadam>
 <Y2OHVoXD82CIHL8R@qemulion>
 <Y2OTUAo1OliSFCJh@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2OTUAo1OliSFCJh@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:09:20PM +0300, Dan Carpenter wrote:
> On Thu, Nov 03, 2022 at 02:48:35PM +0530, Deepak R Varma wrote:
> > On Thu, Nov 03, 2022 at 11:53:45AM +0300, Dan Carpenter wrote:
> > > On Thu, Nov 03, 2022 at 08:24:15AM +0000, David Laight wrote:
> > > > > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > > > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > > > @@ -587,17 +587,12 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
> > > > >  			else
> > > > >  				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
> > > > >  		} else {
> > > > > -			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
> > > > > -				pHTInfo->CurrentAMPDUFactor =
> > > > > -						 pPeerHTCap->MaxRxAMPDUFactor;
> > > > > -			else
> > > > > -				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
> > > > > +			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
> > > > > +							    HT_AGG_SIZE_32K);
> > > >
> > > > For min() to fail there must be a signed v unsigned mismatch.
> > > > Maybe that ought to be fixed.
> > > >
> > >
> > > u32 is the right choice here.
> > >
> > > I'm having a hard time understanding your email.  You might be saying
> > > we could declare HT_AGG_SIZE_32K as a u32 so then we could use min()
> > > instead of min_t()?  HT_AGG_SIZE_32K is an enum.
> > >
> > > pPeerHTCap->MaxRxAMPDUFactor is a bitfield.
> > >
> > > 	u8 MaxRxAMPDUFactor:2;
> > >
> > > We will never be able to use min().
> >
> > I think we could do min((u32)a, (u32)b), but it is just unwrapped min_t
> > if I understand David's comment.
> >
>
> No.  Do not do that.  I think it's a checkpatch warning.  What you have
> is fine.
>
> > >
> > > > >  		}
> > > > >  	}
> > > > > -	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
> > > > > -		pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
> > > > > -	else
> > > > > -		pHTInfo->current_mpdu_density = pPeerHTCap->MPDUDensity;
> > > > > +	pHTInfo->current_mpdu_density = max_t(u8, pHTInfo->MPDU_Density,
> > > > > +					      pPeerHTCap->MPDUDensity);
> > > >
> > > > Using u8 with max_t() really doesn't make any sense.
> > >
> > > Using u8 looks wrong because you would worry that one of the types is
> > > larger than U8_MAX.  But it's actually fine.  The types are u8 vs another
> > > bitfield.  I would probably have gone with u32 here as well.
> > I will take your advise and upgrade the type to u32 as a revision.
>
> Sounds good.  It's not something I would have asked you to redo the
> patch over, but it would have been my personal preference.

That is no problem. I am waiting on David to elaborate on his feedback and
accordingly plan a consolidated revision.

>
> regards,
> dan carpenter
>
>


