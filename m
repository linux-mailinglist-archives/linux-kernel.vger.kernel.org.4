Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF8467D238
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjAZQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAZQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:56:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D04689;
        Thu, 26 Jan 2023 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jcBESO6Kh80MkB8QvNeXhsmM1QYKDdAxBfViCRR9uCU=; b=a3MTeMfaarBv00gkN3NLp/3wse
        Ali2CXgf55ELu/7UvtEuwAwkgaUIYq5h7MfJ0sE6ybXa54f/PYFDqPxWpVy9sYrGR2FCY6ymZG7W2
        850DIE8g15PDzPaa0JKxgQodEK1kVKEbhzBHbfUhvmhBjuFv9QNAFI3FMF94gUrXQgYGSGvpbLAAh
        W/pOp3CGFCTP//IDTRnrjS7+2VX3bprdRXzad64KPlLGWWFxaJum6YlGwXpcL7kJHXFJu7CNhg7gI
        3xG2SOygpRWDjqJsaJ90jcHFgafRH+BENHeGDyvmFMOWVuSvLH/XwT7k2lCnVxea0t2mQY+EQ60rG
        UaEMLsQg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL5XH-00Bu2H-M4; Thu, 26 Jan 2023 16:55:39 +0000
Message-ID: <97a939cd-3898-3d54-e496-a8f33a62856a@infradead.org>
Date:   Thu, 26 Jan 2023 08:55:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 7/7] cdx: add device attributes
Content-Language: en-US
To:     Nipun Gupta <nipun.gupta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
References: <20230126104630.15493-1-nipun.gupta@amd.com>
 <20230126104630.15493-8-nipun.gupta@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230126104630.15493-8-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/26/23 02:46, Nipun Gupta wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 8c2425fdb6d9..69bdbc891743 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -10,3 +10,47 @@ Description:
>                  For example::
>  
>  		  # echo 1 > /sys/bus/cdx/rescan
> +
> +What:		/sys/bus/cdx/devices/.../vendor
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Vendor ID for this CDX device. Vendor ID is 16 bit
> +		identifier which is specific to the device manufacturer.
> +		Combination of Vendor ID and Device ID identifies a device.
> +
> +What:		/sys/bus/cdx/devices/.../device
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Device ID for this CDX device. Device ID is a 16 bit
> +		identifier to identify a device type within the range
> +		of a device manufacturer.
> +		Combination of Vendor ID and Device ID identifies a device.
> +
> +What:		/sys/bus/cdx/devices/.../reset
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:

Reads better without "would":

> +		Writing a non-zero value to this file would reset the CDX> +		device. On resetting the device, the corresponding driver
> +		would be notified twice, once before the device is being
> +		reset, and again after the reset has been complete.


		Writing a non-zero value to this file resets the CDX
		device. On resetting the device, the corresponding driver
		is notified twice, once before the device is being
		reset, and again after the reset has been complete.

> +
> +                For example::
> +
> +		  # echo 1 > /sys/bus/cdx/.../reset
> +
> +What:		/sys/bus/cdx/devices/.../remove
> +Date:		January 2023
> +Contact:	tarak.reddy@amd.com
> +Description:
> +		Writing a non-zero value to this file would remove the
> +		corrosponding device from the CDX bus. If the device is
> +		to be reconfigured in the Hardware, the device can be
> +		removed, so that the device driver does not access the
> +		device while it is being reconfigured.

and: (also fix typo of corresponding)

		Writing a non-zero value to this file removes the
		corresponding device from the CDX bus. If the device is
		to be reconfigured in the Hardware, the device can be
		removed, so that the device driver does not access the
		device while it is being reconfigured.

> +
> +		For example::
> +
> +		  # echo 1 > /sys/bus/cdx/devices/.../remove

-- 
~Randy
