Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7A74227B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjF2Ine (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjF2ImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8099F1B1;
        Thu, 29 Jun 2023 01:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15904614F4;
        Thu, 29 Jun 2023 08:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274BCC433C8;
        Thu, 29 Jun 2023 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688028074;
        bh=vlYpLQJZtSXpTdxzzf+x19uXJCjU4SjJ4HABmL6bQ1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0OaURq2kmc5FgaPb1sSe+BgEZbOtTXQ5/3kv73tKzw9fyAoe2Ba0UjeKqU4d0cKA
         +mIurc+uOOwsEjJpqZHOFSu+DDKSv9sNUvFmcGI/rWqDVsEPtasTGzwp1MAuttg3Q8
         gAUbcpKPhXGP9aMN1rXSCZqqH0rlYIPghF8qt9qk=
Date:   Thu, 29 Jun 2023 10:41:11 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Leo Li <leoyang.li@nxp.com>, Ma Ke <make_ruc2021@163.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: fsl_qe_udc: validate endpoint index for ch9
 udc
Message-ID: <2023062958-graffiti-skyrocket-cfee@gregkh>
References: <20230628081511.186850-1-make_ruc2021@163.com>
 <AM0PR04MB62893E77D085030A6E2C37B28F24A@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <f321287d-8156-b805-26fd-58acfa26e324@csgroup.eu>
 <AM0PR04MB628929736762F5DF46C55D708F24A@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <7975b5bf-c8e0-237e-d6f4-98e641d39959@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7975b5bf-c8e0-237e-d6f4-98e641d39959@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:56:30AM +0000, Christophe Leroy wrote:
> 
> 
> Le 28/06/2023 à 23:10, Leo Li a écrit :
> > 
> > 
> >> -----Original Message-----
> >> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> Sent: Wednesday, June 28, 2023 2:40 PM
> >> To: Leo Li <leoyang.li@nxp.com>; Ma Ke <make_ruc2021@163.com>
> >> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linuxppc-
> >> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] usb: gadget: fsl_qe_udc: validate endpoint index for
> >> ch9 udc
> >>
> >>
> >>
> >> Le 28/06/2023 à 19:04, Leo Li a écrit :
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Ma Ke <make_ruc2021@163.com>
> >>>> Sent: Wednesday, June 28, 2023 3:15 AM
> >>>> To: Leo Li <leoyang.li@nxp.com>
> >>>> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linuxppc-
> >>>> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Ma Ke
> >>>> <make_ruc2021@163.com>
> >>>> Subject: [PATCH] usb: gadget: fsl_qe_udc: validate endpoint index for
> >>>> ch9 udc
> >>>>
> >>>> We should verify the bound of the array to assure that host may not
> >>>> manipulate the index to point past endpoint array.
> >>>>
> >>>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> >>>> ---
> >>>>    drivers/usb/gadget/udc/fsl_qe_udc.c | 2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c
> >>>> b/drivers/usb/gadget/udc/fsl_qe_udc.c
> >>>> index 3b1cc8fa30c8..f4e5cbd193b7 100644
> >>>> --- a/drivers/usb/gadget/udc/fsl_qe_udc.c
> >>>> +++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
> >>>> @@ -1959,6 +1959,8 @@ static void ch9getstatus(struct qe_udc *udc, u8
> >>>> request_type, u16 value,
> >>>>    	} else if ((request_type & USB_RECIP_MASK) ==
> >>>> USB_RECIP_ENDPOINT) {
> >>>>    		/* Get endpoint status */
> >>>>    		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
> >>>> +		if (pipe >= USB_MAX_ENDPOINTS)
> >>>> +			goto stall;
> >>>
> >>> Thanks.  This seems to be the right thing to do.  But normally we don't mix
> >> declarations with code within a code block.  Could we re-arrange the code a
> >> little bit so declarations stay on top?
> >>
> >> But we are at the start of a code block aren't we ?
> > 
> > But they were at the beginning of a { } block which is compliant with the C89 standard.  I know gcc is more relaxed from this.  But it is probably still good to stick to the standard?
> 
> Sorry I misread the patch and failed to see that the declaration block 
> was continuing after the change.
> 
> So yes don't interleave code with declarations. Leave declaration at the 
> top of a block with a blank line between declarations and code.

This is fine as-is, no need to change anything.

greg k-h
