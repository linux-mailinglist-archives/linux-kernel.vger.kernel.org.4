Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C66E109B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDMPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjDMPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D71EA5DD;
        Thu, 13 Apr 2023 08:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15B7163F74;
        Thu, 13 Apr 2023 15:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B55C433D2;
        Thu, 13 Apr 2023 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681398424;
        bh=r8BLpDALAAoKFN5NitGFlcbTATfE6nIZcBcaUZE9GKQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=f78hTUfOG1Z/S4K79rhzeeCOJAm/938HwYqcG0ca0yasc238F3lMlqdpe71Z6uvVq
         o02kORb+QeTb2eS1i2U/43Sh6gT9WeSkN6SXRWCovrM/iXFWyMaBavkQ+St7v8G01W
         jZrC7AZ6n2pYHaOOREZPhtFjAzQ/HqKQyj9FRtBpFiteJOiLy6J+ci18Q5gwf7b6O3
         vAvTngPCw+0LX+1CNnS5V7mVSEwTAXtJqA/Q9zrwunkBk5kBnYTdweiII9pwaAbhrs
         8B/NhUFmy4a/S2yKX6aGTWIfcFUDGttJlGM+AdrbkFHqP5NXlHftzJdOB1x95I6IR7
         T0wNWObAtt2Yw==
Date:   Thu, 13 Apr 2023 17:07:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: shield: Initial driver implementation with
 Thunderstrike support
In-Reply-To: <20230410170840.16119-2-rrameshbabu@nvidia.com>
Message-ID: <nycvar.YFH.7.76.2304131705350.29760@cbobk.fhfr.pm>
References: <20230410170840.16119-1-rrameshbabu@nvidia.com> <20230410170840.16119-2-rrameshbabu@nvidia.com>
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

On Mon, 10 Apr 2023, Rahul Rameshbabu wrote:

> Supports the Thunderstrike (SHIELD 2017) controller. Implements support for
> the Thunderstrike HOSTCMD firmware interface. Adds sysfs attributes about a
> SHIELD device and introduces haptics support for controllers.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Thanks a lot for submitting the driver. I have one minor question:

[ ... snip ... ]
> +thunderstrike_update_haptics(struct thunderstrike *ts,
> +			     struct thunderstrike_hostcmd_haptics *motors)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ts->haptics_update_lock, flags);
> +	ts->haptics_val = *motors;
> +	spin_unlock_irqrestore(&ts->haptics_update_lock, flags);

Do we really have to disable interrupts when taking haptics_update_lock? 
Is it ever being taken from interrupt context?

Thanks,

-- 
Jiri Kosina
SUSE Labs

