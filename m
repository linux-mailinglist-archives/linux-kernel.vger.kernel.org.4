Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D864698A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLHHD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLHHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:03:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E05AE0B;
        Wed,  7 Dec 2022 23:03:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34275B8212D;
        Thu,  8 Dec 2022 07:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5900C433C1;
        Thu,  8 Dec 2022 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670483031;
        bh=j8uYR2CxLKLDaBgyjyvKkKQG/J8QEwcRMZN1JW1bwMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qv7qRggntudmz6KExRrOaU5aJ+LXvkAxA6AEFHxUq39MYf4dSG1wktX+Zd93t4O9W
         FAVZBbceP9FyYvPqCQSS7IHO4zFVo9xT7xUTNvcgxrnoWWK1Rkz26JbH0FEM+Nz5jw
         6wWu2Q/xxP7cEiFUufnWVp8i9ODEMjVHVvl33S5A=
Date:   Thu, 8 Dec 2022 08:03:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v5 1/3] usb: typec: tcpm: Add callbacks to mitigate
 wakeups due to contaminant
Message-ID: <Y5GMUzmkfU6qWZgS@kroah.com>
References: <20221208020043.374033-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208020043.374033-1-badhri@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 06:00:41PM -0800, Badhri Jagan Sridharan wrote:
> On some of the TCPC implementations, when the Type-C port is exposed
> to contaminants, such as water, TCPC stops toggling while reporting OPEN
> either by the time TCPM reads CC pin status or during CC debounce
> window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
> to restart toggling, the behavior recurs causing redundant CPU wakeups
> till the USB-C port is free of contaminant.
> 
> [206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> ...
> 
> TCPM invokes is_potential_contaminant callback to allow low level chip
> drivers to monitor TCPM state machine transitions and notify TCPM when
> the Type-C port needs to be checked for potential contaminant presence.
> TCPCs which do have the needed hardware can implement the check_contaminant
> callback which is invoked by TCPM to evaluate for presence of contaminant.
> Lower level TCPC driver can restart toggling through TCPM_PORT_CLEAN event
> when the driver detects that USB-C port is free of contaminant.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Change-Id: I136d788bb46d871d12e64bd73fd50a77b4659dbf
> ---

Always run checkpatch.pl on your patches so you don't get a grumpy
maintainer asking why you didn't run checkpatch.pl on your patches :(
