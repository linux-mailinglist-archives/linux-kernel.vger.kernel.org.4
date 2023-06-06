Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2872724461
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjFFN1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjFFN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AD610F0;
        Tue,  6 Jun 2023 06:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9115B62B73;
        Tue,  6 Jun 2023 13:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D2DC433D2;
        Tue,  6 Jun 2023 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686058062;
        bh=Y5tGaEDCfykOC2/4URAbvKrhGg4KX5KOyjmQhsNzC8c=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YmljVAsfkKIDZ+t4UlyRN5aekGZdC9+HIxGCMfnrY3T6jWyNbpMQX3ux6EKNaGYvn
         75+djZcOEKYYfZumWK0oEoIpSa2rJeneqEljKnpLxgEEFJdfHWJeYOMHUCYqwrcx/u
         wjDQSfMhgElR1oV2W1QGokmVFvb2ActK1U7EH4Eajoa/pWPQUBwGOOZQiomPgsKpg8
         tv04eUOpm3HGgY3ak6l+MgRPj+kivJe/hSoKXkp5W/nmXojFpz1nT2AVWyo7RQnr7M
         mbfbB2A5tSpFZA8rhDRFL1GNTdYk7qGdAMLDHtxTJmBZ7LfQXRpci4wg+jXZiW+nFL
         dtJNHavJBMyUg==
Date:   Tue, 6 Jun 2023 15:27:37 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
cc:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from
 busy
In-Reply-To: <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
Message-ID: <nycvar.YFH.7.76.2306061527080.29760@cbobk.fhfr.pm>
References: <20230531082428.21763-1-hadess@hadess.net> <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm> <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm> <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023, Linux regression tracking (Thorsten Leemhuis) wrote:

> >>> If an attempt at contacting a receiver or a device fails because the
> >>> receiver or device never responds, don't restart the communication, only
> >>> restart it if the receiver or device answers that it's busy, as originally
> >>> intended.
> >>>
> >>> This was the behaviour on communication timeout before commit 586e8fede795
> >>> ("HID: logitech-hidpp: Retry commands when device is busy").
> >>>
> >>> This fixes some overly long waits in a critical path on boot, when
> >>> checking whether the device is connected by getting its HID++ version.
> >>>
> >>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> >>> Suggested-by: Mark Lord <mlord@pobox.com>
> >>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> >>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
> > [...]  
> >>
> >> I have applied this even before getting confirmation from the reporters in 
> >> bugzilla, as it's the right thing to do anyway.
> > 
> > Unfortunately it doesn't seem to cure the reported issue (while reverting 
> > 586e8fede79 does):
> 
> BTW, remind me again: was fixing this by reverting 586e8fede79 for now a
> option? I guess it's not, but if I'm wrong I wonder if that might at
> this point be the best way forward.

This should now all be fixed by

    https://git.kernel.org/linus/7c28afd5512e371773dbb2bf95a31ed5625651d9

> > https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2
> 
> FWIW, another comment showed up there:
> 
> ```
> > --- Comment #6 from vova7890 ---
> > Same problem. I researched this some time ago. I noticed that if I add a small
> > delay between commands to the dongle - everything goes fine. Repeated
> > request(586e8fede7953b1695b5ccc6112eff9b052e79ac) made the situation more
> > visible
> 

-- 
Jiri Kosina
SUSE Labs

