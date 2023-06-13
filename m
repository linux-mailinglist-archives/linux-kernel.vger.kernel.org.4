Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE772E8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjFMQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjFMQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F13198B;
        Tue, 13 Jun 2023 09:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 565E763792;
        Tue, 13 Jun 2023 16:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEA8C433D9;
        Tue, 13 Jun 2023 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686674404;
        bh=OkeHnH/TAQmovfwxd3UYG175EWl8VQgpXW7nfWPlfQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZ8A6xw3FtPAEpEP/h7HaFK8Mz0b77IlSmbpMrh7O46mIvicDAufHsTKMr0q/Z1Ei
         8ABG7o0GoWpe10KxyVfSShuQhYaZnzMOClJQZr2f+S4SV7ovZhA9FrA6KbjWzot4uz
         44yb2L/gaEZyRvCRV816lysX0XAEIZrMTw+rdyvEMVIVLzTfFVZLFaz95rVSxeP6Yw
         Ys5hEtlFCZOvU91wD7c+/YljzqLo2WydeN3vGLzHO2kzQLjOZhSqfCXR42tT3z98ZP
         xfSQppuf5YTIdIS23LOi78msw6EIpD/qeiELcAPsM8eNwVhtStRL7ViVoHMpQQV+B2
         ILAVXHHaQ3RAQ==
Received: by pali.im (Postfix)
        id 92D847FD; Tue, 13 Jun 2023 18:40:01 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:40:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Message-ID: <20230613164001.5vdk4pajbrwgdam4@pali>
References: <20230613084310.2775896-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613084310.2775896-1-michal.wilczynski@intel.com>
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

On Tuesday 13 June 2023 11:43:10 Michal Wilczynski wrote:
> Currently rbtn_add() in case of failure is leaking resources. Fix this
> by adding a proper rollback. Move devm_kzalloc() before rbtn_acquire(),
> so it doesn't require rollback in case of failure. While at it, remove
> unnecessary assignment of NULL to device->driver_data and unnecessary
> whitespace, plus add a break for the default case in a switch.
> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Fixes: 817a5cdb40c8 ("dell-rbtn: Dell Airplane Mode Switch driver")
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Looks good,

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> v2:
>  - move devm_kzalloc before rbtn_acquire as suggested
> 
>  drivers/platform/x86/dell/dell-rbtn.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
> index aa0e6c907494..c8fcb537fd65 100644
> --- a/drivers/platform/x86/dell/dell-rbtn.c
> +++ b/drivers/platform/x86/dell/dell-rbtn.c
> @@ -395,16 +395,16 @@ static int rbtn_add(struct acpi_device *device)
>  		return -EINVAL;
>  	}
>  
> +	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> +	if (!rbtn_data)
> +		return -ENOMEM;
> +
>  	ret = rbtn_acquire(device, true);
>  	if (ret < 0) {
>  		dev_err(&device->dev, "Cannot enable device\n");
>  		return ret;
>  	}
>  
> -	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> -	if (!rbtn_data)
> -		return -ENOMEM;
> -
>  	rbtn_data->type = type;
>  	device->driver_data = rbtn_data;
>  
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
> 2.41.0
> 
