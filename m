Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30482675BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjATRp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjATRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:45:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B18564BA;
        Fri, 20 Jan 2023 09:45:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBD80B829B0;
        Fri, 20 Jan 2023 17:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62276C433D2;
        Fri, 20 Jan 2023 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674236718;
        bh=e6PleI4womWUZ/YrAl55kcVrHbcX4H86kmzJS3pQ0GI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hV1RRoO6H7wPJdSLm7fL6s+B8oQkamq0JC/ItVIdhQFZOZl1C3bPStEqrgDDDyZSM
         aW3mSFqX5Au9v40YCDf+ntMCNOxiw/WK0WPiosPPbe7Rb5vJbjKa72PZpFUxoBYek5
         YUhwi8l6XgJHrhE9ZoG/S49ZBSikof0c1ykC0kholtLO0amUG4/7YN1OlOIk4nGF3s
         lBDiN4ui70j2/7AJHNiXHRVmRuuFayjdxzbQMsWyQY9gk7IFMHnvgmFHVhZtfPodtW
         VVir9i91Wdms3b3ylSdJL1x/wxu7xYctgtljwdzUCaHZnKpTFtZxZM4ellsm77QzBV
         JCUuCufD7F7TQ==
Date:   Fri, 20 Jan 2023 18:45:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Takahiro Fujii <fujii@xaxxi.net>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: elecom: add support for TrackBall 056E:011C
In-Reply-To: <20230119183002.352852-1-fujii@xaxxi.net>
Message-ID: <nycvar.YFH.7.76.2301201844460.1734@cbobk.fhfr.pm>
References: <20230119183002.352852-1-fujii@xaxxi.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023, Takahiro Fujii wrote:

> Make function buttons on ELECOM M-HT1DRBK trackball mouse work. This model
> has two devices with different device IDs (010D and 011C). Both of
> them misreports the number of buttons as 5 in the report descriptor, even
> though they have 8 buttons. hid-elecom overwrites the report to fix them,
> but supports only on 010D and does not work on 011C. This patch fixes
> 011C in the similar way but with specialized position parameters.
> In fact, it is sufficient to rewrite only 17th byte (05 -> 08). However I
> followed the existing way.

Applied, thanks.

> Signed-off-by: Takahiro Fujii <fujii@xaxxi.net>
> ---
>  drivers/hid/hid-elecom.c | 16 ++++++++++++++--
>  drivers/hid/hid-ids.h    |  3 ++-
>  drivers/hid/hid-quirks.c |  3 ++-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
> index e59e9911fc37..4fa45ee77503 100644
> --- a/drivers/hid/hid-elecom.c
> +++ b/drivers/hid/hid-elecom.c
> @@ -12,6 +12,7 @@
>   *  Copyright (c) 2017 Alex Manoussakis <amanou@gnu.org>
>   *  Copyright (c) 2017 Tomasz Kramkowski <tk@the-tk.com>
>   *  Copyright (c) 2020 YOSHIOKA Takuma <lo48576@hard-wi.red>
> + *  Copyright (c) 2022 Takahiro Fujii <fujii@xaxxi.net>

A minor nit: next time please consider not adding copyright notice just 
for device ID additions, we usually don't do that.

-- 
Jiri Kosina
SUSE Labs

