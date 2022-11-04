Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11E7619732
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiKDNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKDNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B22AE36;
        Fri,  4 Nov 2022 06:13:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C971E6218E;
        Fri,  4 Nov 2022 13:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92FC433D6;
        Fri,  4 Nov 2022 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667567618;
        bh=2L0t5GV0svc8x8FXSIWytbw3XtM5sDI9NefKpvdamZc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=aiM3gQe3TqyOh4IX07Yhh8Jy7rfZ5qBN5pfAzlk4yhQcob3DvCI/oBI2e2JBgJwdY
         u7xqCWkOKtVUJekKX0xSAtMh1kGS/GCVj375a1FKdMTPz/q5cxD+/L+8ixf5UPVPK9
         Jbrh6mRZoN/QWbyYkOJ7jqm7TI6IiYXjxMF/7JSHSakUbtaS7d/bjDuFVxkwBD9PaW
         hFg8La5WvzM0ZbMLrBRokHG9T8a8fU9OyPkXRQ+v7wckMEtTeZEirpfwybncNXrPB4
         mOWimNV7zxZ4m7GSHj/s8o8cGnDaYcaU8PG7apRxGa3nSqRe3jgrCCPgTqqeNZC9P2
         nTUfW1dgzcqKQ==
Date:   Fri, 4 Nov 2022 14:13:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mia Kanashi <chad@redpilled.dev>
cc:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: input: do not query XP-PEN Deco LW battery
In-Reply-To: <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev>
Message-ID: <nycvar.YFH.7.76.2211041412500.29912@cbobk.fhfr.pm>
References: <20221029161240.15548-1-jose.exposito89@gmail.com> <20221029161240.15548-2-jose.exposito89@gmail.com> <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022, Mia Kanashi wrote:

> >The XP-PEN Deco LW drawing tablet can be connected by USB cable or using
> >a USB Bluetooth dongle. When it is connected using the dongle, there
> >might be a small delay until the tablet is paired with the dongle.
> >
> >Fetching the device battery during this delay results in random battery
> >percentage values.
> >
> >Add a quirk to avoid actively querying the battery percentage and wait
> >for the device to report it on its own.
> >
> >Reported-by: Mia Kanashi <chad@redpilled.dev>
> >Signed-off-by: José Expósito <jose.exposito89@gmail.com>

[ ... snip ... ]

> I've tested this patch and now power supply status is correctly set to 
> Unknown and capacity is set to 0 initially.
> 
> Just a note that that issue occured not only with the dongle, but a 
> cable also. It seems that tablet just doesn't respond to the query.
> 
> Thank you for the work!

Based on this, can I assume that I can turn

	Reported-by: Mia Kanashi <chad@redpilled.dev>

into

	Reported-and-tested-by: Mia Kanashi <chad@redpilled.dev>

for the final version?

Thanks,

-- 
Jiri Kosina
SUSE Labs

