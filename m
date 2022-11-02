Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A083615D44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKBIC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:02:52 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A208013F46
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667376155; bh=VKIIIg5Ow9y7BYrYGszDe/O+as8FGmI810ThX44IikU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Y0xyzs5pGSR1Iu1TqYpMZd2aE6Yk6L8Ehh0dO8hF/1rFvyz7Ok7ZUmmL35tzeFY3S
         PdOMxMsYc4jNSnk5dbak8agMnrWb60Ox2AKmm90Wsa5DT4uTGYAjs4z+lEU+vmD+V/
         E+E3hSNAH9TJNaoNZTmIHpDrA5y/XqKK+gGsJQQ8=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Wed,  2 Nov 2022 09:02:35 +0100 (CET)
X-EA-Auth: Xiede22fg5z65ZXwe/phWqFYfA6aaPeKR4bYp/aKyNsXF48FnuXBwt3VccAy9XBmO8VfenHNaxZxb8Y5YaXJxC0Gl2Kz7BAM
Date:   Wed, 2 Nov 2022 13:32:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: remove unwanted variable
 implementation
Message-ID: <Y2IkFqxujKnZ/9MQ@ubunlion>
References: <Y2F/CtEnjWlHgw9f@ubunlion>
 <Y2IccKxNDyd/MEqY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IccKxNDyd/MEqY@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 08:29:52AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 02, 2022 at 01:48:18AM +0530, Deepak R Varma wrote:
> > Local variables intended as the function return value are
> > initialized but their value does not change during function
> > execution. The initial value assigned to the variable is simply
> > returned to the caller. This makes the variable declaration
> > unnecessary and the initial value can be directly returned.
> >
> > Following table lists the initial commits when the variables were first
> > introduced but have not been used since inception:
> >
> > Variable  Function	File			     Inception Commit
> > ret	  rtw_sta_flush	r8188eu/core/rtw_ap.c	     [1]
> > ret	  amsdu_to_msdu r8188eu/core/rtw_recv.c	     [2]
> > ret	  rtw_p2p_set	r8188eu/os_dep/ioctl_linux.c [3]
> >
> > [1] 'commit 9a7fe54ddc3a ("staging: r8188eu: Add source files for new driver - part 1")'
> > [2] 'commit 1cc18a22b96b ("staging: r8188eu: Add files for new driver - part 5")'
> > [3] 'commit a2c60d42d97c ("staging: r8188eu: Add files for new driver - part 16")'
> >
> > However, local variable pull of the function update_txdesc from file
> > r8188eu/hal/rtl8188eu_xmit.c was in use prior to introduction of
> > commit ID [4] 7bdedfef085bb65. The clean-up associated with this
> > commit left the variable pull redundant.
> >
> > [4] 'commit 7bdedfef085b ("staging: r8188eu: Remove mp, a.k.a. manufacturing process, code")'
> >
> > The patch is produced using the following coccicheck options:
> >    COCCI=./scripts/coccinelle/misc/returnvar.cocci
> >    M=driver/staging/r8188eu/
> >    MODE=patch
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >
> > Changes in v2:
> >    1. Include reason for why the variable declarations are not useful. Suggested
> >       by Julia Lawall <julia.lawall@inria.fr>
>
> Does not apply to my tree at all :(
>
> Please rebase and resubmit.

Hello Greg,
Looks like there was another patch effort in parallel to correct this coccicheck
complaint. I am checking if all the observations from my patch are resolved. If
not, I will rebase and send in revised patch.

Thank you.
./drv

>
> thanks,
>
> greg k-h
>
>


