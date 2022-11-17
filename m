Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3462DC83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiKQNVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiKQNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:21:16 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25491558D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668691261; bh=N9pDZUTKVWmcCMLDo7BDwGJ71H9koLDvz0Lw4Lwo6pQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Y/pQXmvAbDfPJC2BXP/MP7acs7sOO8XEv4QnGYFRLasTAsRNAVyOBPvWGFJboPdv1
         bsdK/WJDPci3NIBO7bOMHQcuPGMO4G2btrPw0UAjmyCoE4XRmAvLb2nsmZX8Up38bq
         Cm9CZG8+rP84Ly+46oaOkiuzS1UilPVpLtBcPys4=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu, 17 Nov 2022 14:21:00 +0100 (CET)
X-EA-Auth: UijATNLUhksPhklMt0RnzdQPPKNk33NwzW2kr3ZK5xnRR3INQDOR1bX/0JRfebmWS/jsblxg8mESktDJkPEfVbXPwqGPnOpG
Date:   Thu, 17 Nov 2022 18:50:55 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y3Y1N6AwWEXLpSrx@qemulion>
References: <Y3YKhee8L+kAfHM4@qemulion>
 <Y3YvGdkyGm7azGg4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3YvGdkyGm7azGg4@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 01:54:49PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 17, 2022 at 03:48:45PM +0530, Deepak R Varma wrote:
> > The code currently uses C90 standard extension based zero length arrays.
> > The zero length array member also happens to be the only member of the
> > structs. Such zero length array declarations are deprecated and the
> > new C99 standard extension of flexible array declarations are to be
> > used instead.
> >
> > The DECLARE_FLEX_ARRAY() helper allows for a flexible array member as
> > the only member in a structure. Refer to these links [1], [2] for
> > details.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://lkml.kernel.org/r/YxKY6O2hmdwNh8r8@work
> >
> > Issue identified using Coccinelle.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >
> > Notes:
> >    1. Proposed change is compile tested only.
> >    2. Solution feedback from gustavoars@kernel.org
> >
> >
> >  drivers/staging/wlan-ng/hfa384x.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> > index 0611e37df6ac..3a1edcb43e07 100644
> > --- a/drivers/staging/wlan-ng/hfa384x.h
> > +++ b/drivers/staging/wlan-ng/hfa384x.h
> > @@ -960,15 +960,15 @@ struct hfa384x_pdr_nicid {
> >  } __packed;
> >
> >  struct hfa384x_pdr_refdac_measurements {
> > -	u16 value[0];
> > +	DECLARE_FLEX_ARRAY(u16, value);
> >  } __packed;
>
> Why?  This structure is never used anywhere, right?  So why is this
> needed to be changed and not just removed entirely?  Same for the other
> structures in this patch.

Hello Greg,
I am unable to confirm that these structures are truly not needed in the absence
if a real device based testing. I could only validate that using the compile
build and driver loading.

This change that I am proposing in the interim would enable the compiler to
protect the structure from addition of a new member below the zero length array.

If there is a way to confirm that the structures are indeed not needed, I can
revise the patch and send the cleanup accordingly. Please suggest.

Thank you,
./drv


>
> thanks,
>
> greg k-h


