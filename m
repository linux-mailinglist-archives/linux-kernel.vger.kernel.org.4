Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96514679F95
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjAXRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjAXREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:04:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C479136;
        Tue, 24 Jan 2023 09:04:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC989612D6;
        Tue, 24 Jan 2023 17:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECA5C433EF;
        Tue, 24 Jan 2023 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674579859;
        bh=0J2cfmGfNW3mNChq2vBr6v4VgWVucb97qK0+QdNVmOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I36VbeRP1nnnIhTw5hw3CQ9aCT7fXz56OY6ke9XwqQD2853eyM5+ShG5hWIX2uJBT
         sWgHrZOQnXBjUG/N0ky34rNfwBqq6XH+q9ZcwF13/u5H7hGlgu9oVWTtBU2wvSwXQ/
         78vTCLlrLaRyXK0fvYBQpD2Ye78kSbvi6cTOK+B8=
Date:   Tue, 24 Jan 2023 18:04:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] thermal: Fail object registration if thermal class is
 not registered
Message-ID: <Y9APkJ8TfGu36iug@kroah.com>
References: <5660360.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5660360.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:44:03PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If thermal_class is not registered with the driver core, there is no way
> to expose the interfaces used by the thermal control framework, so
> prevent thermal zones and cooling devices from being registered in
> that case by returning an error from object registration functions.
> 
> For this purpose, use a thermal_class pointer that will be NULL if the
> class is not registered.  To avoid wasting memory in that case, allocate
> the thermal class object dynamically and if it fails to register, free
> it and clear the thermal_class pointer to NULL.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: This replaces the series at
>        https://lore.kernel.org/linux-pm/5905717.lOV4Wx5bFT@kreacher/

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
