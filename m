Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194605E6BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiIVTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiIVTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:32:13 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6BB2F6F6F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:32:11 -0700 (PDT)
Received: (qmail 271474 invoked by uid 1000); 22 Sep 2022 15:32:11 -0400
Date:   Thu, 22 Sep 2022 15:32:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: runtime: Return -EINPROGRESS from rpm_resume() in
 the RPM_NOWAIT case
Message-ID: <Yyy4O/NUMSRtCmhI@rowland.harvard.edu>
References: <12079576.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12079576.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:04:40PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The prospective callers of rpm_resume() passing RPM_NOWAIT to it may
> be confused when it returns 0 without actually resuming the device
> which may happen if the device is suspending at the given time and it
> will only resume when the suspend in progress has completed.  To avoid
> that confusion, return -EINPROGRESS from rpm_resume() in that case.
> 
> Since none of the current callers passing RPM_NOWAIT to rpm_resume()
> check its return value, this change has no functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -792,10 +792,13 @@ static int rpm_resume(struct device *dev
>  		DEFINE_WAIT(wait);
>  
>  		if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {

Hmmm, and what if a caller sets both of these flags?  I guess in that 
case he gets what he deserves.

> -			if (dev->power.runtime_status == RPM_SUSPENDING)
> +			if (dev->power.runtime_status == RPM_SUSPENDING) {
>  				dev->power.deferred_resume = true;
> -			else
> +				if (rpmflags & RPM_NOWAIT)
> +					retval = -EINPROGRESS;
> +			} else {
>  				retval = -EINPROGRESS;
> +			}
>  			goto out;
>  		}

Acked-by: Alan Stern <stern@rowland.harvard.edu>
