Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179EA72AE51
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFJTKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJTK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:10:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A9B193
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:10:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so20931665e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686424226; x=1689016226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToU70xJNc8dVh1qfpRh71Sp2N0GShUulo6svA7d/wx8=;
        b=raRFdnf/3fDyvValEjk8CGVxVccMzlji8KBBUbGmqADpWQViYNJJqWd2/0ASgV+zvF
         CoXyYfHXV5b6bAIGkWMBmIP9r/eCNMz+dYjjG81AXKWoX3RC1tl4gbu6XTHqip5E4Pv/
         DyXGxdhRnnvdoIBDHdoqljx5j9y1TbueGUGFF665TGGbqazNs7cIJhqc6WqbWshMAr19
         uOmyTIzIh0K+t2dKvBKWh3PXQmVRV7EA6g8BMdO4+UN7pdUF+hf4d5QtzVsD4ckcoBhV
         BKMOhtvxdVmPSQo4jG0F1Nu2/RRIib/bCnDtDLNfpRATlsZhi1LNRDgq7muk4gv6AS5R
         NEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686424226; x=1689016226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToU70xJNc8dVh1qfpRh71Sp2N0GShUulo6svA7d/wx8=;
        b=VaMbyuxwZjzjtCjVuvpi6SxIsGsIJyoEAv/fVGY9ESDsQwcbuo4ZdZ3BMq7KJUSYb/
         gh0FFP4z117KPnnMOlafLjojQGZAby0uBGcvhtmRAbLnNHGdzu0aRc5NLHrD1VgjPgNI
         PgW21k/JpAJ0DcdsVYxHJaNS1cuhi5LSiGI0BwAf0qCnBgiVf1a9DjjMdvNXA3CP/3eF
         xIwMxLFSo1h+GlGdpstaAG7pcuhs6OtS2rYzHLj8FRLWxxjE8W7DPJKeYuwJYlYog0n1
         Ykd+odD9G6cyN8WhGyPR1NC5aPk0y++fWmW0ldroPzNLAXU4EV4T36MI+Am0w7/Yglmt
         B9Ew==
X-Gm-Message-State: AC+VfDzKkRsy4N31vekCEz7/dJiRkdv1mGbZWZW3Fxg1CIjC+Sj30KE/
        XTxXb/+QtkUY8VoMzk9pERehqQ==
X-Google-Smtp-Source: ACHHUZ6F1rsiYXPHygLcGkoXxY8Z/tI5BXowQ9kkcXf1E/lo0eJX0RYnDBfWdFQZpNX4+ck6GH5kbQ==
X-Received: by 2002:a7b:c40b:0:b0:3f4:27ff:7d48 with SMTP id k11-20020a7bc40b000000b003f427ff7d48mr2970962wmi.19.1686424226504;
        Sat, 10 Jun 2023 12:10:26 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003f42a75ac2asm6422099wmc.23.2023.06.10.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:10:25 -0700 (PDT)
Date:   Sat, 10 Jun 2023 20:10:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, jordyzomer@google.com,
        pawan.kumar.gupta@linux.intel.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZITKoBzJq+Y5Hi9Z@equinox>
References: <20230609131355.71130-1-jordyzomer@google.com>
 <20230609131355.71130-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609131355.71130-2-jordyzomer@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 01:13:55PM +0000, Jordy Zomer wrote:
> This patch fixes a spectre-v1 gadget in cdrom.
> The gadget could be triggered by,
>  speculatviely bypassing the cdi->capacity check.
> 
> Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> ---
>  drivers/cdrom/cdrom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb..3c349bc0a269 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -233,6 +233,7 @@
>  
>  -------------------------------------------------------------------------*/
>  
> +#include "asm/barrier.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #define REVISION "Revision: 3.20"
> @@ -2329,6 +2330,8 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  
> +	arg = array_index_mask_nospec(arg, cdi->capacity);
> +
>  	info = kmalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

Hi Jordy,

Thanks for the patch, much appreciated. Sadly, as Pawan has already
pointed out, array_index_mask_nospec actually changes the behaviour of
this function, such that 'arg' would no longer be an array index.

In addition, it seems to have triggered the kernel test robot with an
alpha build error.

Regards,
Phil
