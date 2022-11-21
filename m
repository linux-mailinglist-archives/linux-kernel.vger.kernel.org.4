Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2A631D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiKUKBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiKUKB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:01:27 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B178CBBC;
        Mon, 21 Nov 2022 02:01:17 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3205D74C;
        Mon, 21 Nov 2022 11:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669024875;
        bh=p20aRkH5QQq23LNlV1KjWAHVEBFx1a4/5sQGbTBKEdU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ifhul2fxlyQpHl9xifoFPhYOK/C5zP4wFGXNn3kRbTI8YTBhMCxKOuTugOf7mtfPx
         8/blsBQYvY3iuWZ8QAn1zpl53V3bUdzYUDTEyAqsFODEfDPmN1akkVVzHTkKNMrOsb
         R39bIL6pgjrJQt31et2EY+y6XGRIH2NAv0s47Q6E=
Message-ID: <d830ff8b-8bf2-f70c-35c2-ee10417051b3@ideasonboard.com>
Date:   Mon, 21 Nov 2022 10:01:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, sorry for the delay

On 18/11/2022 18:56, Andy Shevchenko wrote:
> Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> which is a better coding practice.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> index df6c94da2f6a..18974a72e94a 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -263,7 +263,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>   				      struct cio2_bridge *bridge,
>   				      struct pci_dev *cio2)
>   {
> -	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *fwnode, *primary;
>   	struct cio2_sensor *sensor;
>   	struct acpi_device *adev;
>   	acpi_status status;
> @@ -322,7 +322,9 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>   		}
>   
>   		sensor->adev = acpi_dev_get(adev);
> -		adev->fwnode.secondary = fwnode;
> +
> +		primary = acpi_fwnode_handle(adev);
> +		primary->secondary = fwnode;
>   
>   		cio2_bridge_instantiate_vcm_i2c_client(sensor);
>   


LGTM: Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

