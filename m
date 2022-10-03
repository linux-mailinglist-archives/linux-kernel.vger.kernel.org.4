Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177D5F289A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJCGj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiJCGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853386460;
        Sun,  2 Oct 2022 23:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205D560F5B;
        Mon,  3 Oct 2022 06:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D81C433D6;
        Mon,  3 Oct 2022 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664779161;
        bh=qabvN0z6GgbotKOKr/SpCJp2JvDb4dG+SOgVYMhWWzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcsyqg/BfM7r9ZEOvDoIP/MzjK4Fsx4XSquO5J2jDgbTXnBwUJDc3VXXbopqsnAH4
         rrNVZVt0btu++ZB6q1Cp0/eyt4mlfqYLlI4jP5JPkY5Ew4coYI9FAbpLInCLZ651po
         Ycp18LhJXYgLN9GIUPtYPAoNgmbbHV5X1uD4UtxAFj4fSilBM28osFsofgalzTPh/E
         0MAM4PD4xSmTjYYFZgELvoTxm5sJF/8Cojrf3MTNP+qmkx04bQOFllH/LLaRYXouug
         oCLWWndQw2PO/pYJo556kQ7kvMGdCEUi/+8I+SjMjQchUa/Oj3YsqSPYLZbQFagGzc
         6R6zNULMnqIvg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ofF6o-0006gk-7m; Mon, 03 Oct 2022 08:39:22 +0200
Date:   Mon, 3 Oct 2022 08:39:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Juergen Stuber <starblue@users.sourceforge.net>
Subject: Re: [PATCH] USB: make devnode() callback in usb_class_driver take a
 const *
Message-ID: <YzqDmvohy9shngxy@hovoldconsulting.com>
References: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001165128.2688526-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 06:51:28PM +0200, Greg Kroah-Hartman wrote:
> With the changes to the driver core to make more pointers const, the USB
> subsystem also needs to be modified to take a const * for the devnode
> callback so that the driver core's constant pointer will also be
> properly propagated.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Pete Zaitcev <zaitcev@redhat.com>
> Cc: Juergen Stuber <starblue@users.sourceforge.net>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/hid/usbhid/hiddev.c     | 2 +-
>  drivers/usb/class/usblp.c       | 2 +-
>  drivers/usb/misc/iowarrior.c    | 2 +-
>  drivers/usb/misc/legousbtower.c | 2 +-
>  include/linux/usb.h             | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Looks correct and complete.

Reviewed-by: Johan Hovold <johan@kernel.org>
