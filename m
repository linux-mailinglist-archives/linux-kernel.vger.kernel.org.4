Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB360CB87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJYMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJYMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:11:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999B10043F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A671B81C4E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ED3C433C1;
        Tue, 25 Oct 2022 12:10:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dDRZaYoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666699854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJD2D6blGTMHiZM2q3gLESOKFIffvbwoaPVYCZFEep4=;
        b=dDRZaYoLNxj6zBh368fRie4kJanP5lvRqPTeJz0aM/cyCjsWQrva/wLd5dOcuFE0+7sWoC
        YqIhF2GaCsUAhnGIarb47q3zqYQbsIc5g9r9521q/0IZGFMawK4kh/zBd8vbUFRvkJr3aH
        QCJE4gLo5781JJskR5CPoTKmOaL6ilU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d47b2917 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 12:10:53 +0000 (UTC)
Date:   Tue, 25 Oct 2022 14:10:50 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] misc: sgi-gru: use explicitly signed char
Message-ID: <Y1fSSt17uXy/YP1D@zx2c4.com>
References: <202210251026.dfeqb1M2-lkp@intel.com>
 <20221025025223.573543-1-Jason@zx2c4.com>
 <Y1eShe+T8YTiokN5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1eShe+T8YTiokN5@kroah.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:38:45AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 25, 2022 at 04:52:23AM +0200, Jason A. Donenfeld wrote:
> > With char becoming unsigned by default, and with `char` alone being
> > ambiguous and based on architecture, signed chars need to be marked
> > explicitly as such. This fixes warnings like:
> > 
> > drivers/misc/sgi-gru/grumain.c:711 gru_check_chiplet_assignment() warn: 'gts->ts_user_chiplet_id' is unsigned
> > 
> > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/misc/sgi-gru/grumain.c   |  6 +++---
> >  drivers/misc/sgi-gru/grutables.h | 14 +++++++-------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/SubmittingPatches for what needs to be done
>   here to properly describe this.

I fixed the kbuild errors that v2 was a reply to. Specifically, I fixed
up the function prototypes in grutables.h.

Jason
