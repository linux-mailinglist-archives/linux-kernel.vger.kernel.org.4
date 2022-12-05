Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C664243E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiLEINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiLEINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:13:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E315A32;
        Mon,  5 Dec 2022 00:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670228024; x=1701764024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KBYBt9muVBeTe/8PxUs+35MJ6giaVa/uKEoyV3CXYKM=;
  b=ASrE/PTQPI5zGOMeekdZrs7MKlyu9gjdpcUkKqrS7sDdmSxQNyy1BM0J
   WJSAQPQeuquD0PKKhDn5uvs9xWep83Zp91VXi7JwjH691uurL8Mtx8EW6
   K1c1F3/NcyYtJdxOn0YTi73zYIT12UjAEHJMQmnsOAcOtzq19hl59VrZk
   L1MQkyf4lNhgkYpdySTUloTcC2/4CD2vyFZmudb+9fhS4+RjmqaMJ03Rj
   b0RI7Fwz/8KyLlAiHs0BbpUuWmwDAkxLxxPOVIa8zEH0RGjMv1/LzpDoX
   qIeoedPHBSa5ENFckhMNIdUWAeN+CxkmZHINSQxGMdidUyQ9m2j3RhXmS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="380584487"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="380584487"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:13:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="787980854"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="787980854"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:13:38 -0800
Message-ID: <e679e199-3850-80e7-e31c-b3e0eb93aa0c@intel.com>
Date:   Mon, 5 Dec 2022 10:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v1 2/2] PM: runtime: Relocate rpm_callback() right after
 __rpm_callback()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <5627469.DvuYhMxLoT@kreacher> <2264402.ElGaqSPkdT@kreacher>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2264402.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 16:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because rpm_callback() is a wrapper around __rpm_callback(), and the
> only caller of it after the change eliminating an invocation of it
> from rpm_idle(), move the former next to the latter to make the code
> a bit easier to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/base/power/runtime.c |   64 +++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -422,6 +422,38 @@ fail:
>  }
>  
>  /**
> + * rpm_callback - Run a given runtime PM callback for a given device.
> + * @cb: Runtime PM callback to run.
> + * @dev: Device to run the callback for.
> + */
> +static int rpm_callback(int (*cb)(struct device *), struct device *dev)
> +{
> +	int retval;
> +
> +	if (dev->power.memalloc_noio) {
> +		unsigned int noio_flag;
> +
> +		/*
> +		 * Deadlock might be caused if memory allocation with
> +		 * GFP_KERNEL happens inside runtime_suspend and
> +		 * runtime_resume callbacks of one block device's
> +		 * ancestor or the block device itself. Network
> +		 * device might be thought as part of iSCSI block
> +		 * device, so network device and its ancestor should
> +		 * be marked as memalloc_noio too.
> +		 */
> +		noio_flag = memalloc_noio_save();
> +		retval = __rpm_callback(cb, dev);
> +		memalloc_noio_restore(noio_flag);
> +	} else {
> +		retval = __rpm_callback(cb, dev);
> +	}
> +
> +	dev->power.runtime_error = retval;
> +	return retval != -EACCES ? retval : -EIO;
> +}
> +
> +/**
>   * rpm_idle - Notify device bus type if the device can be suspended.
>   * @dev: Device to notify the bus type about.
>   * @rpmflags: Flag bits.
> @@ -505,38 +537,6 @@ static int rpm_idle(struct device *dev,
>  }
>  
>  /**
> - * rpm_callback - Run a given runtime PM callback for a given device.
> - * @cb: Runtime PM callback to run.
> - * @dev: Device to run the callback for.
> - */
> -static int rpm_callback(int (*cb)(struct device *), struct device *dev)
> -{
> -	int retval;
> -
> -	if (dev->power.memalloc_noio) {
> -		unsigned int noio_flag;
> -
> -		/*
> -		 * Deadlock might be caused if memory allocation with
> -		 * GFP_KERNEL happens inside runtime_suspend and
> -		 * runtime_resume callbacks of one block device's
> -		 * ancestor or the block device itself. Network
> -		 * device might be thought as part of iSCSI block
> -		 * device, so network device and its ancestor should
> -		 * be marked as memalloc_noio too.
> -		 */
> -		noio_flag = memalloc_noio_save();
> -		retval = __rpm_callback(cb, dev);
> -		memalloc_noio_restore(noio_flag);
> -	} else {
> -		retval = __rpm_callback(cb, dev);
> -	}
> -
> -	dev->power.runtime_error = retval;
> -	return retval != -EACCES ? retval : -EIO;
> -}
> -
> -/**
>   * rpm_suspend - Carry out runtime suspend of given device.
>   * @dev: Device to suspend.
>   * @rpmflags: Flag bits.
> 
> 
> 

