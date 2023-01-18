Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B94671874
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjARKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjARKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:02:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259535B469;
        Wed, 18 Jan 2023 01:09:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC92616DE;
        Wed, 18 Jan 2023 09:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2C5C433EF;
        Wed, 18 Jan 2023 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032959;
        bh=2YsIPr9TzKAbHzqmNdXjPHcRIAzjcVh7LDNrzNv5d20=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hVgEwAnOb/j0Uf26JXO8+A+yB7G9hVFMBfzQQyE7V4jl0LsmUQegR016DyFBPT1Ii
         EnTDBjebiD4OonG2qNNDWktwow6MV1+X6LyID8DtNJuV2hmxWNVkhPv4BNEBWMipUo
         6Jb9I3Ei7IYcMBX25w6HMTtwDBMaKHP9mPOOaDYyvV00iJuXNSCLb79W5Xqp7OouIs
         FSW4bS9MuRNYB3yHH+ZvBi4tBIs5jJIE+5pGw155Xb0b49XIpAoUcuKSWvICUcb2TP
         4uaGzyMqMl2SFl/cLS4rqBI4JgN61phc6BF8UkKz3YjziQ3QYuxyE+xomTj+TjwADP
         E40RlFQzIhJ0Q==
Date:   Wed, 18 Jan 2023 10:09:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Allen Ballway <ballway@chromium.org>
cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        dtor@chromium.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org
Subject: Re: [PATCH v6 RESEND] HID: multitouch: Add quirks for flipped axes
In-Reply-To: <20230110202550.651091-1-ballway@chromium.org>
Message-ID: <nycvar.YFH.7.76.2301181009100.1734@cbobk.fhfr.pm>
References: <20221215172644.688044-1-ballway@chromium.org> <20230110202550.651091-1-ballway@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023, Allen Ballway wrote:

> Certain touchscreen devices, such as the ELAN9034, are oriented
> incorrectly and report touches on opposite points on the X and Y axes.
> For example, a 100x200 screen touched at (10,20) would report (90, 180)
> and vice versa.
> 
> This is fixed by adding device quirks to transform the touch points
> into the correct spaces, from X -> MAX(X) - X, and Y -> MAX(Y) - Y.
> 
> Signed-off-by: Allen Ballway <ballway@chromium.org>
> ---
> V5 -> V6: Add another IS_ENABLED check for CONFIG_I2C_DMI_CORE because
> the module may not be there at all.
> 
> V4 -> V5: Add IS_ENABLED check for CONFIG_DMI to prevent linker error.
> 
> V3 -> V4: Move quirk logic to i2c_hid_get_dmi_quirks and remove
> duplicate quirks from hid-multitouch.
> 
> V2 -> V3: Use existing HID_QUIRK_*_INVERT and match the quirk in
> hid-quirk, passing down to hid-multitouch through the hid device.
> 
> V1 -> V2: Address review comments, change to use DMI match. Confirmed
> MT_TOOL_X/Y require transformation and update orientation based on
> flipped axes.

Appplied, thank you.

-- 
Jiri Kosina
SUSE Labs

