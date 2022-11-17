Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0D62D7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKQKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKQKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:13:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C6CC2;
        Thu, 17 Nov 2022 02:13:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1983862175;
        Thu, 17 Nov 2022 10:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB68CC433C1;
        Thu, 17 Nov 2022 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668680012;
        bh=N64egnpv3pSSY/f9Cno+cuLqIYWNjIOZOxvtiofnLmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7Uz1Nzp8jJCqX4MNBxoEnIuyS6FVDPnqjc+hwNtVZO23eqv6FByIGjA2iqDxcLuk
         SrLvkyF31KwIc18BztU3LyHmz2cvSBn6t6J3prKKpE/IcgSzxHXPMg54H7yStRBy8K
         rTmHw07DjlT5VBDFETzXJxKdlyHopNsSJqhliPkf23bHr5QzcCgnEq1yZM5TJjq4d9
         PKl6V42XPxdVNCvX5+Q1E+vUn38JBXvSE3G6PQuY8Ay3AIicT0wwZAJQvTmziT8de/
         njHvmnS/iBPtHScDSEUsyQTvntI/t3khwnAtHYC88GpPl8beWnvjDxr0W/0FgV48BB
         S/m7nd6SM1xmw==
Date:   Thu, 17 Nov 2022 10:13:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] Input: max8997 - Convert to modern way to get a
 reference to a PWM
Message-ID: <Y3YJR4hIRdDacrkh@google.com>
References: <20221117073543.3790449-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117073543.3790449-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Uwe Kleine-König wrote:

> pwm_request() isn't recommended to be used any more because it relies on
> global IDs for the PWM which comes with different difficulties.
> 
> The new way to do things is to find the right PWM using a reference from
> the platform device. (This can be created either using a device-tree
> or a platform lookup table, see e.g. commit 5a4412d4a82f ("ARM: pxa:
> tavorevb: Use PWM lookup table") how to do this.)
> 
> There are no in-tree users, so there are no other code locations that need
> adaption.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/input/misc/max8997_haptic.c | 7 +++----
>  include/linux/mfd/max8997.h         | 3 ---

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 3 insertions(+), 7 deletions(-)

-- 
Lee Jones [李琼斯]
