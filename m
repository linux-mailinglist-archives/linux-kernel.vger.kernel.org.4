Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3040372CD3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjFLRwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjFLRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3954134;
        Mon, 12 Jun 2023 10:52:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F62B617C7;
        Mon, 12 Jun 2023 17:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A317CC433D2;
        Mon, 12 Jun 2023 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686592328;
        bh=/ToCL3aGaEH80Ud7UwLUCZyJVDohdUdWHNYivUAhkis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njqHybfcjZH/1+OX9IiOeAbahZfe3B3pT9mink6GUa6FeVzycmvWdso6AYv4Kuqcr
         Y1Iqv8Dgq7md6yLGMffpc0iU4BI1KA33hiYshH3Yl4ELN+un+eauTK2c1D6quQAFjl
         muFuHwcq3NXsbFhDx0urjXmQ4x12EEpr0fm18nX7yXhZfsOA7CpP2wlPOKJZ9cah4e
         UncRSmKXfTd0czu/TmuSmpMc75CZxS07/Y2lrJmqRjQhCNiiBGoylzmEusJ/nu7wFT
         oWp9/IntmnxlSlQvJWwgp/h/uQGbiPoi4M5Dlr4hhzko9XdKdP8NaWswPFYxFBDM7t
         OvJ34GUVqt9kA==
Received: by pali.im (Postfix)
        id 0DF697EB; Mon, 12 Jun 2023 19:52:05 +0200 (CEST)
Date:   Mon, 12 Jun 2023 19:52:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Message-ID: <20230612175205.eom2guabgfmnzrce@pali>
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612090250.1417940-1-michal.wilczynski@intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2023 12:02:50 Michal Wilczynski wrote:
> Currently rbtn_add() in case of failure is leaking resources. Fix this
> by adding a proper rollback. While at it, remove unnecessary assignment
> of NULL to device->driver_data and unnecessary whitespace, plus add a
> break for the default case in a switch.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/dell/dell-rbtn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index aa0e6c907494..e9b3f9c3ab7d 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -420,10 +420,12 @@ static int rbtn_add(struct acpi_device *device)
>  		break;
>  	default:
>  		ret = -EINVAL;
> +		break;
>  	}
> +	if (ret)
> +		rbtn_acquire(device, false);
>  
>  	return ret;
> -
>  }

Hello! I'm looking at rbtn_add() function and there is also code:

	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
	if (!rbtn_data)
		return -ENOMEM;

which is called after rbtn_acquire(). So it looks like when kzalloc
fails then there is another leak...

>  
>  static void rbtn_remove(struct acpi_device *device)
> @@ -442,7 +444,6 @@ static void rbtn_remove(struct acpi_device *device)
>  	}
>  
>  	rbtn_acquire(device, false);
> -	device->driver_data = NULL;
>  }
>  
>  static void rbtn_notify(struct acpi_device *device, u32 event)
> -- 
> 2.40.1
> 
