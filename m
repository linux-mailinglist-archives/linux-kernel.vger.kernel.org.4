Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A274617FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKCOox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiKCOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:44:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69A6306;
        Thu,  3 Nov 2022 07:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54769B8284C;
        Thu,  3 Nov 2022 14:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1AFC433D7;
        Thu,  3 Nov 2022 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667486686;
        bh=zpIoOAp++gfJWBGUr1xLhQLP/Ei+SAt+CRXOkkI0Ed8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLlvXT7eqnDmXV82jCcydWhdwge20oYiju4qgJA8Kox1+0uoy2CqxS6OcWT4GfXdm
         7kaYJceK3jPK0/nfxnvCCM6OfULtd6rZCoerS/DEQ8m18vOMsw026P1vJZPjNqXxtD
         38F9pa943O07I6qaA2qUdRKx02dy4qaYDZbbdpY0=
Date:   Thu, 3 Nov 2022 23:45:26 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Leng <jleng@ambarella.com>
Cc:     pawell@cadence.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: cdnsp: Fix wrong transmission direction of EP0
Message-ID: <Y2PUBvh3z/5QPSy+@kroah.com>
References: <20221101044433.5627-1-3090101217@zju.edu.cn>
 <20221101061730.8991-1-jleng@ambarella.com>
 <Y2DqOefwSAjmExof@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2DqOefwSAjmExof@kroah.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:43:21AM +0100, Greg KH wrote:
> On Tue, Nov 01, 2022 at 02:17:30PM +0800, Jing Leng wrote:
> > EP0 transfer is bi-directional, but in the cdnsp gadget, the
> > transmission direction of EP0 is not changed after it is
> > initialized to IN, so the OUT data from EP0 received by the host
> > is invalid.
> > 
> > The value of ep0_expect_in will change according to the value of
> > bRequestType in the SETUP transaction of control transfer, so we
> > can use it as the transmission direction of EP0.
> > 
> > Signed-off-by: Jing Leng <jleng@ambarella.com>
> > ---
> > ChangeLog v2->v3:
> > - Repair my email address.
> 
> Yes, it works, and it's validated!
> 
> Nice job, thanks.  I'll let the cdns3 maintainer review it first, but
> just wanted to say thanks for fixing this up, it makes my life a lot
> easier when accepting patches.

Oops, I missed that email footer, sorry.  That is NOT compatible with
Linux kernel development, and as per the recommendation from my legal
people, I have to go revert that change as we can't take it as-is
because it might have been sent out incorrectly as it was stated to be
"Proprietary and/or Confidential Information" which is not allowed in
the Linux kernel.

thanks,

greg k-h
