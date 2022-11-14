Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F198C627644
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiKNHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiKNHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:12:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6D813E13;
        Sun, 13 Nov 2022 23:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 601D960ED9;
        Mon, 14 Nov 2022 07:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E06C433C1;
        Mon, 14 Nov 2022 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668409965;
        bh=lilXaazAdhkbfVH4r45BrIKBuaIhsxredlrTJPuVlTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yr+eNoZv9eHLu0GnwKHzlOKCqE3b/3nTkMds8zWUkpGiYjbtixX+j+uXGpuNJ7ljA
         Khrw+5LK2ACsPAktwOoe6yIzXApPQu2ZnL3m8YEPTkvh8A+DOuDqGy7rtEV0yF0N3t
         Y6pYa6CkU7GLDhHVdIXknG6noEPnFLH1GNVjDekk=
Date:   Mon, 14 Nov 2022 08:12:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Message-ID: <Y3HqauaLfF6iJTGJ@kroah.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110064723.8882-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:47:21AM -0600, Mario Limonciello wrote:
> +static ssize_t last_hw_state_residency_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%llu\n", suspend_stats.last_hw_state_residency);

sysfs_emit() please for sysfs files, not a "raw" sprintf().
checkpatch.pl should have caught that for you, but sometimes it doesn't.

thanks,

greg k-h
