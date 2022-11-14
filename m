Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56027627B17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiKNKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:54:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8E625F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F897B80DDC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13331C433C1;
        Mon, 14 Nov 2022 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668423251;
        bh=Zs54L57HNQAqjHJqcG1yKGpCVtpc0lQUSRqcjjjDaR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSyf6lfcFekXsbIywSrQF95HrlONzpZPZli7/rdUDZQcMLXNGMWX1drI2L1c9w6cT
         FhaCuYsy80LUxk6eGlnEkoJ5xn2A5u+lnurVPS0XhsNCT21yE7N5pIS/udWMeiE15d
         EXMbx0GkKEi10rWa3xyt1ZFvIt/rchk5gyY8GHQc=
Date:   Mon, 14 Nov 2022 11:54:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh@kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        John Stultz <jstultz@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Disable driver deferred probe timeout by
 default
Message-ID: <Y3IeUADalX6WDnuO@kroah.com>
References: <20221114104333.3695531-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114104333.3695531-1-javierm@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 11:43:33AM +0100, Javier Martinez Canillas wrote:
> The driver_deferred_probe_timeout value has a long story. It was first set
> to -1 when it was introduced by commit 25b4e70dcce9 ("driver core: allow
> stopping deferred probe after init"), meaning that the driver core would
> defer the probe forever unless a subsystem would opt-in by checking if the
> initcalls where done using the driver_deferred_probe_check_state() helper,
> or if a timeout was explicitly set with a "deferred_probe_timeout" param.
> 
> Only the power domain, IOMMU and MDIO subsystems currently opt-in to check
> if the initcalls have completed with driver_deferred_probe_check_state().
> 
> Commit c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
> logic") then changed the driver_deferred_probe_check_state() helper logic,
> to take into account whether modules have been enabled or not and also to
> return -EPROBE_DEFER if the probe deferred timeout was still running.
> 
> Then in commit e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
> longer default if CONFIG_MODULES is set"), the timeout was increased to 30
> seconds if modules are enabled. Because seems that some of the subsystems
> that were opt-in to not return -EPROBE_DEFER after the initcall where done
> could still have dependencies whose drivers were built as a module.
> 
> This commit did a fundamental change to how probe deferral worked though,
> since now the default was not to attempt probing for drivers indefinitely
> but instead it would timeout after 30 seconds unless a different timeout
> was set using the "deferred_probe_timeout" parameter.
> 
> The behavior was changed even mere with commit ce68929f07de ("driver core:
> Revert default driver_deferred_probe_timeout value to 0"), since the value
> was set to 0 by default. Meaning that the probe deferral would be disabled
> after the initcalls where done. Unless a timeout was set in the cmdline.
> 
> Notice that the commit said that it was reverting the default value to 0,
> but this was never 0. The default was -1 at the beginning and then changed
> to 30 in a later commit.
> 
> This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
> "driver core: Set default deferred_probe_timeout back to 0."") and set to
> 10 seconds instead. Which was still less than the 30 seconds that was set
> at some point to allow systems with drivers built as modules and loaded by
> user-land to probe drivers that were previously deferred.
> 
> The 10 seconds timeout isn't enough for the mentioned systems, for example
> general purpose distributions attempt to build all the possible drivers as
> a module to keep the Linux kernel image small. But that means that in very
> likely that the probe deferral mechanism will timeout and drivers won't be
> probed correctly.

What specific "mentioned systems" have deferred probe drivers that are
failing on the current value?  What drivers are causing the long delay
here?  No one should be having to wait 10 seconds for a deferred delay
on a real system as that feels really wrong.

Why not fix the drivers that are causing this delay and maybe move them
to be async so as to not slow down the whole boot process?

thanks,

greg k-h
