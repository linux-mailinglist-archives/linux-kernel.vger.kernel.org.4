Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E5611334
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiJ1NmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJ1Nl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:41:59 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A558E1D79B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666964465; bh=dn3QC759JYSbdACAbjB+1SsJHL5LPhszMOHvnTxlp2w=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=BuiTchFxwmMu50w2A1Gk7O5uorgN0Egt4VIWDmHCUxOezqWSX1TL6MV2fySdDIRR/
         cfS8TdPTYmdcPJzIw4vXy1jimJZu16I3YEbDOXGgH/4CKG8q8Pqm1eootTMe2XdZI3
         yuG2kQgtmBQhGEQfLzsg6o0ydaHzy1Io+eD4j0D0=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Fri, 28 Oct 2022 15:41:05 +0200 (CEST)
X-EA-Auth: zjD3JWTuqW65h7OUlWQt+bac8mNfQPBdWtxbP4lNIW7AbDNyWoG0bkvLonVx/zdZDq6GcPCSy3C56muCCKIQ3DX2aRhZjmRq
Date:   Fri, 28 Oct 2022 19:11:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Use flexible-array for one /
 zero-length arrays
Message-ID: <Y1vb7OoJqVK3C5bc@ubunlion>
References: <Y1vNNSSWK1EkcohT@ubunlion>
 <Y1vaR0olLH9+bJbk@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vaR0olLH9+bJbk@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:33:59PM +0300, Dan Carpenter wrote:
> On Fri, Oct 28, 2022 at 06:08:13PM +0530, Deepak R Varma wrote:
> > Flexible-array member should be used instead of one or zero member to
> > meet the need for having a dynamically sized trailing elements in a
> > structure. Refer to links [1] and [2] for detailed guidance on this
> > suggestion.
> >
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> >
> > Issue identified using coccicheck.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/wlan-ng/p80211mgmt.h  | 8 ++++----
> >  drivers/staging/wlan-ng/p80211types.h | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
> > index 1ef30d3f3159..d6fe52de2c8f 100644
> > --- a/drivers/staging/wlan-ng/p80211mgmt.h
> > +++ b/drivers/staging/wlan-ng/p80211mgmt.h
> > @@ -229,14 +229,14 @@ struct wlan_ie {
> >  struct wlan_ie_ssid {
> >  	u8 eid;
> >  	u8 len;
> > -	u8 ssid[1];		/* may be zero, ptrs may overlap */
> > +	u8 ssid[];		/* may be zero, ptrs may overlap */
>
> How have you ensured that changing this from a 1 byte array to a zero
> byte array does not break anything?  It's not uncommon for a people
> to do math like "size - 1 + length".  The "- 1" would be to take the
> 1 element into consideration.

Hi Dan,
I did a code review to understand how this structure member is used and did not
find any computations you mentioned. I would certainly like to receive your feedback
as well.

>
> I was trying to read through this code to check your work, but then
> you sent a second patch which also does not explain how you are auditing
> your changes.  Can you go a bit slower?

My apologies for rushing patches in. I will hold on for feedback on these
patches before turning in any new patch involving similar change. I hope it is
okay to send a different type of patch though. Please correct if I am wrong.

Thank you for looking into the patches. Appreciate your time and feedback.

./drv


>
> regards,
> dan carpenter
>


