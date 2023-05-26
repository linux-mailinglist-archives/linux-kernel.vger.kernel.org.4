Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E4712CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjEZSq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEZSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F418812A;
        Fri, 26 May 2023 11:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88DAB65225;
        Fri, 26 May 2023 18:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F4EC433EF;
        Fri, 26 May 2023 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685126782;
        bh=si4OShtcWeA3aOvlmCYsrLe467iTEe537wCRlb0nLYg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fNh/uyPGts30UHTSr4s48u/5dNZ4mpJE/f0pVC1mBDKgsGxPQi2nBEYGnb4MPQ3gK
         74nY5JPA6kqq4DfqnySkYdbUPlVliRHGXFywUGCMR0NwdUiaBMVbmE6M7Nh10272vB
         us+M17n1BB6cjTqQIdyLR6B4fr6XcEAYZNqMXZRRkz6aH3iPG8ImXHFyZ5DbUtRsls
         FzKEvRXnoL6IhLa5l2RYGF+iK3DaDGgTY3HQd6/W16vlFc+ONRoIMzofcEEtor2ipM
         874nEYl/KkrhkoikTE/jdObQpXQii8F/HcjQ+KHDZBbfhr/9/m6tOMLIiASy6R28xa
         iFkBL3IfT1zVQ==
Date:   Fri, 26 May 2023 20:46:18 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 0/2] HID: ensure timely release of driver resources
In-Reply-To: <20230523-hid-devres-v2-0-5220211a428c@gmail.com>
Message-ID: <nycvar.YFH.7.76.2305262046000.29760@cbobk.fhfr.pm>
References: <20230523-hid-devres-v2-0-5220211a428c@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Dmitry Torokhov wrote:

> These 2 patches address an issue in HID subsystem where cleanup code in
> the bus code runs before releasing devres-managed resources by the
> driver core.
> 
> This is a V2 of the patch, which was split in 2 parts - generic cleanup
> and the actualy change addressing the issue.
> 
> Link: https://lore.kernel.org/r/20230505232417.1377393-1-swboyd@chromium.org
> Link: https://lore.kernel.org/r/ZFWarGkRAfPOmI6E@google.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Dmitry Torokhov (2):
>       HID: split apart hid_device_probe to make logic more apparent
>       HID: ensure timely release of driver-allocated resources
> 
>  drivers/hid/hid-core.c | 118 +++++++++++++++++++++++++++++--------------------
>  include/linux/hid.h    |   1 +
>  2 files changed, 72 insertions(+), 47 deletions(-)

Now queued in hid.git#for-6.5/core.

Thanks,

-- 
Jiri Kosina
SUSE Labs

