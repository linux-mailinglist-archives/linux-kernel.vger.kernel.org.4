Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2863FD44
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiLBAst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiLBAsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:48:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43D716DD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:48:42 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id mn15so2489525qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=suj3EBVfOzHFVMdCjuSd8XbPP2V3Y/Zx3db9lI5Vd9E=;
        b=WnJgvKAhWNOnkkASoZowBelpAh6L9M1ODc6sVYVEuFrMO1tDsznvf9hbKpSCVrg72b
         1CoJ8hA0iLNk2AEghkwmA/npvVUSfrZh+95R5+NAefowgzo53qEIHaGvb3quRGWFj+UD
         faBwDDaCozx4tQhP6oaTuv1xNuogzd3OcnxSVQOq1Y5fZhaAXxBjkVIoBdUu2Jt1+RLT
         q85QwcrGBtToFDC5TQDLV+NO423Gfavhql51+GW8qtPSFIrSwmLAdrJOn7yXZ8QMRrFZ
         PE/sSEyGjrqbe62gPRGSboJ8khacypTcwPUPV3dMaVpXVpKmYYMM0fn6N0Js372VU9BW
         zgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suj3EBVfOzHFVMdCjuSd8XbPP2V3Y/Zx3db9lI5Vd9E=;
        b=SguiMIj8xS5nmt0gc79BPw2W4HMUsQptShmwnxHiQpnfFwDv6MIgTU8vHE7NEgGGZQ
         jKlsLX27RUVAKnPkiNLZqJXmwjOkSBr3of1W8IdKM6l+buVIRcVUhqBNtQRObkgAwdt3
         UhdQZeOw2OdzMylPtUrfIQ92Zk/tQcyojPx8KJVBimO6wp3+d/3T1FUQfzC9RXDpEIrX
         orMqpAWCaNpKE3UuxjZkvDmpgfsWbdPRf0PFMklwpDNOWzhlFgjO7Md2Y+t8xUQcJ/qD
         VFHfoFfsYmAiF5qFv4rjBKDHpAaO56sET0WTKqcWsMeikyaSom30iAXridWMn+8PCdy7
         nsVw==
X-Gm-Message-State: ANoB5pnsB3tcY3NuK4DVyjc70ecuq7C2vqdWir9Dl1XhAajM9y4Swxqb
        LwB+UZr47K5wg6eTKnMpUMQzBm8Os+MAMA==
X-Google-Smtp-Source: AA0mqf6hKcjtu9Ivlezsl7y+u7CW/vbSr95kricf/ikUQBHtg/WWEWsFPK9lLd3JRtV+MCpleEhvWg==
X-Received: by 2002:a0c:fa01:0:b0:4b4:6402:bc03 with SMTP id q1-20020a0cfa01000000b004b46402bc03mr45707030qvn.81.1669942122099;
        Thu, 01 Dec 2022 16:48:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id bp39-20020a05620a45a700b006cbe3be300esm4527137qkb.12.2022.12.01.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:48:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p0uEK-001yt0-WB;
        Thu, 01 Dec 2022 20:48:41 -0400
Date:   Thu, 1 Dec 2022 20:48:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4lLaN3N0H/jzU8W@ziepe.ca>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> container_of does not preserve the const-ness of a pointer that is
> passed into it, which can cause C code that passes in a const pointer to
> get a pointer back that is not const and then scribble all over the data
> in it.  To prevent this, container_of_const() will preserve the const
> status of the pointer passed into it using the newly available _Generic()
> method.
> 
> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/container_of.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

For the whole series

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
