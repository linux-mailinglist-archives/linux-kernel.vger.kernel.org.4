Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740B70BCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjEVMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjEVL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468A6100;
        Mon, 22 May 2023 04:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 222DB6135D;
        Mon, 22 May 2023 11:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D25C433EF;
        Mon, 22 May 2023 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756776;
        bh=noLNVGz2jJ7O7o4ac5on++xmXX/K/ni7BD/UCTe0wmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+zjQstKzirDiOEWd50KK6ocVionxHN0tfFF9k6+xTfxZxsNBCmbTglBCdUhrNdyY
         +n83SPrjEYrFQW5NJXpZ0U4+TCf1nnEjsLTRO9ag4IIOCl59tFi2kDTdRc/vp9rSoI
         OwX8FePZJpGZB9/OZEGOVw5uyp+yHidwL25L6RDEF/GzHtlQsPdg/F+HvO6Lkom7al
         D2c/LkXnEfD5yPtY83mgeF8CwwyYvuKaL5RY8FABjPJoUYshGHVY8aVr+CTs0/2h1o
         vzLzZ4n6j4W3op1CUIcl5mNMyCDp/9jiqp+njaZBgWLfBy235wH8PtPhznPRwk5tOt
         0bjelTZX/FE5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q14CO-0001dA-JB; Mon, 22 May 2023 13:59:37 +0200
Date:   Mon, 22 May 2023 13:59:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Craig Shelley <craig@microtron.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: Break doesn't work on a CP2105
Message-ID: <ZGtZKCvo71woGf9T@hovoldconsulting.com>
References: <ZEmDs0ASdnEAnpsL@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmDs0ASdnEAnpsL@minyard.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

and sorry about the late reply on this.

On Wed, Apr 26, 2023 at 03:04:03PM -0500, Corey Minyard wrote:
> I have a development board with a CP2105 on it, and I was trying to send
> a break to it to do a sysrq.  And it wasn't working.
> 
> I have verified that the target driver works by setting a really slow
> baud rate and sending something with a lot of zero bits.  It got breaks
> just fine.
> 
> If I use TCSBRK, it seems to just send a short time with zeros, not
> even a full character's worth.  It receives a valid character with the
> top few bits set.  If I use TCSBRKP with a longer time, like 2.5
> seconds, it waits the whole time, then at the very end it gets the
> character as with the shorter break.
> 
> I can't find a programming manual for the chip, and I'm not sure what's
> going on.

I just verified that break works on the first port of my cp2105 but not
on the second one (I seem to receive the last characters sent instead).

Apparently this is expected as the datasheet (AN571) says the following
about the SET_BREAK command:

	This command is not supported on the second CP2105 interface.

Which port are you seeing this behaviour with?

Johan
