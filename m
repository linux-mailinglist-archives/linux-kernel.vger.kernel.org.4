Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539E70DFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbjEWOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbjEWOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:54:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BA126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:54:48 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1q1TPE-0008TL-9A; Tue, 23 May 2023 16:54:32 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1q1TPC-0000ix-7X; Tue, 23 May 2023 16:54:30 +0200
Date:   Tue, 23 May 2023 16:54:30 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, hverkuil-cisco@xs4all.nl,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Message-ID: <20230523145430.GB9943@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Diederik de Haas <didi.debian@cknow.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, hverkuil-cisco@xs4all.nl,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
 <4995215.LvFx2qVVIh@bagend>
 <7c1bf9c4-f14b-30cd-2610-871f5f512d06@collabora.com>
 <12724349.O9o76ZdvQC@bagend>
 <5d871928-dcd5-3f27-e975-d1639525dad0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d871928-dcd5-3f27-e975-d1639525dad0@leemhuis.info>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 12:50:42 +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> CCing the Regression list and a bunch of other people that were CCed in
> threads that look related:

Thanks!

> 
> On 23.05.23 00:38, Diederik de Haas wrote:
> > On Monday, 22 May 2023 18:17:39 CEST Benjamin Gaignard wrote:
> >> Le 20/05/2023 à 00:34, Diederik de Haas a écrit :
> >>> On Thursday, 13 April 2023 21:52:50 CEST Nicolas Dufresne wrote:
> > [...]
> >>> When I booted into my 6.4-rc1 (but also rc2) kernel on my
> >>> Pine64 Quartz64 Model A, I noticed a crash which seems the same as
> >>> above, but I didn't have such a crash with my 6.3 kernel.
> >>> Searching for 'hantro' led me to this commit as the most likely culprit
> >>> but when I build a new 6.4-rcX kernel with this commit reverted,
> >>> I still had this crash.
> >>> Do you have suggestions which commit would then be the likely culprit?
> >>
> >> This patch fix the crash at boot time, revert it doesn't seem to be the
> >> solution. Maybe this proposal from Marek can help you ?
> >>
> >> https://patchwork.kernel.org/project/linux-media/patch/20230421104759.2236463-1-m.szyprowski@samsung.com/
> > 
> > That helped :) After applying that patch I no longer have the crash.
> > Thanks!
> 
> That regression fix is now a month old, but not yet merged afaics --
> guess due to Nicolas comment that wasn't addressed yet and likely
> requires a updated patch.

I agree with Nicolas comment on that patch and it needs to be updated.

> 
> Michael afaics a week ago posted a patch that to my *very limited
> understanding of things* (I hope I don't confuse matters here!) seems to
> address the same problem, but slightly differently:
> https://lore.kernel.org/all/20230516091209.3098262-1-m.tretter@pengutronix.de/

Correct, my patch addresses the same problem.

> 
> No reply yet.
> 
> That's all a bit unfortunate, as it's not how regression fixes should be
> dealt with -- and caused multiple people headaches that could have been
> avoided. :-/
> 
> But well, things happen. But it leads to the question:
> 
> How can we finally address the issue quickly now to ensure is doesn't
> cause headaches for even more people?
> 
> Marek, Michael, could you work on a patch together that we then get
> somewhat fast-tracked to Linus to avoid him getting even more unhappy
> about the state of things[1]?

Marek, if you have an updated patch, I will happily test and review it.
Otherwise, please take a look at my patch.

Michael
