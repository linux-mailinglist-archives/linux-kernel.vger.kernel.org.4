Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156BE69512E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBMT6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBMT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:58:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4A2726
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:58:11 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1pRexi-0004E8-HY; Mon, 13 Feb 2023 20:58:06 +0100
Date:   Mon, 13 Feb 2023 20:58:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "staging: r8188eu: simplify rtw_get_ff_hwaddr"
Message-ID: <20230213195806.usp23da6dfqfz7zl@viti.kaiser.cx>
References: <20230211183205.426820-1-martin@kaiser.cx>
 <Y+nKSc6fPf4E1Y2S@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+nKSc6fPf4E1Y2S@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (error27@gmail.com):

> On Sat, Feb 11, 2023 at 07:32:05PM +0100, Martin Kaiser wrote:
> > This reverts commit fd48124e09825797bdc8ff0120f2401030c618ee.

> > The cleanup in this commit removes the qsel to addr mappings in
> > rtw_get_ff_hwaddr. The underlying assumption is that rtw_write_port
> > uses its addr parameter only for the high_queue check.

> > This is obviously incorrect as rtw_write_port calls
> > ffaddr2pipehdl(pdvobj, addr);
> > where addr is mapped to a usb bulk endpoint.

> > Unfortunately, testing did not show any problems. The Edimax V2 on which I
> > tested has two bulk out endpoints. I guess that with the incorrect patch,
> > addr could only be 0 (no high queue) or 6 (high queue), both of which were
> > mapped to the first bulk out endpoint. Data transfers did still work...

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---

> > Hello Greg,

> > sorry for introducing a regression in commit fd48124e0982 ("staging:
> > r8188eu: simplify rtw_get_ff_hwaddr").

> > Could you take this revert before the 6.3 pull request?

> > Thanks,
> > Martin


> I feel like the ancient `git revert` script is not at all in line with
> current standards and sets people up for failure.  This one at least
> has a commit message.  But
> 1) The subject doesn't have a correct patch prefix.
> 2) "commit fd48124e09825797bdc8ff0120f2401030c618ee" is not human
>    readable or how we describe commits these days with a 12 char hash.
> 3) There is no fixes tag.

Thanks, I fixed these points in v2.

Best regards,
Martin
