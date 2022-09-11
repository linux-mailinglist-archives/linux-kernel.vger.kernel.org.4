Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53EA5B4EA0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIKL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIKL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F411000
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1846C60FF6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D3C433D6;
        Sun, 11 Sep 2022 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662897574;
        bh=4Jbss07D3ML9Z0J0BQzLGO84p1atHK3C7/kFc+KRRW0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=fPUKjbOcgd59h8FTkJN0YYt+0DMo5NW0idEd+QpmoXjpFgWxzWS2NMrC68g7aoa1R
         Zn6D8Tkoy/BH7VZEl5GnFdaBDSRwvN0LEpc/xqwrT9mTcYFRx3nhNcywxyGykgXrEH
         /Q8gHd+WtiLcGU217FjsjjBSz2sT6zUdncJ34Ayw=
Date:   Sun, 11 Sep 2022 13:59:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        xkernel.wang@foxmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: add kfree() on an error path of
 rtw_xmit_resource_alloc()
Message-ID: <Yx3NrRHMGbDLipWJ@kroah.com>
References: <tencent_DD1047278567B897D2CF7F13483573596E06@qq.com>
 <75e8636b-71f4-1334-47c6-0e60f26a2d0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e8636b-71f4-1334-47c6-0e60f26a2d0a@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 08:29:03AM +0200, Philipp Hortmann wrote:
> On 9/10/22 02:29, xkernel.wang@foxmail.com wrote:
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> > 
> > In rtw_xmit_resource_alloc(), if usb_alloc_urb() fails, then the memory
> > `pxmitbuf->pallocated_buf` which is allocated by kzalloc() is not properly
> > released before returning.
> > 
> > So this patch adds kfree() on the above error path to release it. As there
> > is no proper device to test with, no runtime testing was performed.
> > 
> > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_xmit.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> > index 67f9c05..9c39d08 100644
> > --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> > +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> > @@ -44,8 +44,10 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
> >   	pxmitbuf->dma_transfer_addr = 0;
> >   	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
> > -	if (!pxmitbuf->pxmit_urb)
> > +	if (!pxmitbuf->pxmit_urb) {
> > +		kfree(pxmitbuf->pallocated_buf);
> >   		return _FAIL;
> > +	}
> >   	return _SUCCESS;
> >   }
> 
> Hi Xiaoke,
> 
> I applied your patch and tested it. That is OK.
> 
> But you excluded the change history. Usually this is not accepted by Greg.
> Reason is that what identifies the patch is the change itself. The change
> itself is the same as: "[PATCH v4] staging: r8188eu: fix potential memory
> leak in rtw_os_xmit_resource_alloc()" Even if you change the Subject,
> Description and the branch it remains the same patch for Greg.

Agreed, please fix up.

thanks,

greg k-h
