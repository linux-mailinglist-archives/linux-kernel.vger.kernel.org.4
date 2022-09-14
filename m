Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC755B8B28
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiINPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:00:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF45AA11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:00:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so14571697pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jioQxrQAqfCk9wKUDOON2Ly0Stj60gSfNnzyxWwUinI=;
        b=m6Cvtm62KPKdP6K/ZNHnwvTlu6st8DlGbLCm5ohMi159b84EKI1+H8D7pOmedGG+OZ
         4oNmJOgfYRgXkN4K+xb2n+IdATTpk7DC3uZzPV7hu1hRzpOIPg50waceiSIVdAv6Gxsa
         Iu3yOJunVAQ/d3H1GFoh4d7CsHiHRnwEsljU35bso8LJe9tnhLwoLelIGykxiiOpvXZw
         n3SEvFlB/w0hjxZAxVFspYSjjiBwRVzvIX+V7Sl/gWjJEuzAGIycAS1HvmSDMwe/e/Bj
         WIaSun4KcGQwzaF16CamE+oUsCeyej3i3Ty/SvmLScXvUiaVHspcPX5uADTsoZGHBSLr
         rK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jioQxrQAqfCk9wKUDOON2Ly0Stj60gSfNnzyxWwUinI=;
        b=UksLHTSlQvaX0zq1ybugeZJ5aBdFEHa3gOZFzn91lstO5IWxln6X6/qa+UqJMWIoeG
         PthwS/DwxOKx1iQmm/R0Qlo96KKnxwUYeeTB+C9DiWF6jJoMCaPB8PC5ScAWO12o3a+q
         SrGLwI/NhW3CGOBviU41hZufYxfW46jx82SV4oNIZ0jvW7dCWT/gRRl7kVzygE1jpyCu
         iBX55fFqLFv28xbhAWDPRG0dTuxdwjb+RncPPj0OCywTIofw72eiJ0fSRw1DIOYOuVrl
         zIq6dK3TCwCuT9tmHukk2LMQkEpDHrZGXFGw+GCVA+3f6rkyxY6e5gntyPWPfPQLQII/
         rnUw==
X-Gm-Message-State: ACgBeo26nca+k9MISwrnUR0/BPvY2nMUtUSaucYHEiCyG6JLLY1nKu4a
        rhfXP6d6tWxGLsmtdPLnvrNeFQ==
X-Google-Smtp-Source: AA6agR48PI0M/HuS695G3gkJ7j0u/mGOE3A3ZZQiaZK3EMrhipX/WO+5WK1aEN/u/0shlmtIczX/ig==
X-Received: by 2002:a63:4a53:0:b0:439:3c80:e053 with SMTP id j19-20020a634a53000000b004393c80e053mr8021643pgl.3.1663167645012;
        Wed, 14 Sep 2022 08:00:45 -0700 (PDT)
Received: from leoy-yangtze.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id i6-20020a655b86000000b0043934d85847sm4469603pgr.36.2022.09.14.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:00:44 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:00:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] coresight: etm4x: Fix crash observed on Qcom ETM
 parts with 'Low power override'
Message-ID: <YyHsXodPYtyX3i0+@leoy-yangtze.lan>
References: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
 <YyBg8JhNUnsaeKip@leoy-yangtze.lan>
 <b6c2b3eb-a900-f94e-c472-39719faf65af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c2b3eb-a900-f94e-c472-39719faf65af@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:43:53PM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> > > +	/*
> > > +	 * Some Qualcomm implementations require skipping powering up the trace unit,
> > > +	 * as the ETMs are in the same power domain as their CPU cores.
> > > +	 *
> > > +	 * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
> > > +	 * initialize it before the function is called.
> > > +	 */
> > > +	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> > > +		drvdata->skip_power_up = true;
> > > +
> > 
> > I personally think this sentence should be placed in the function
> > etm4_probe(), you need to move it just before smp call
> > etm4_init_arch_data(), this can allow DT property "qcom,skip-power-up"
> > to be respected.
> 
> Or we could move this to init_iomem_access() and explicitly set the flag
> to true in init_sysreg_access().

Agreed, this is more clear.

[...]

> > A side topic, in the mainline kernel I found the value
> > "desc.access.io_mem" is always zero (see the initialized value in
> > etm4_probe() and etm4_init_sysreg_access()).  Should we initialize
> > desc.access.io_mem to true in etm4_probe()?
> 
> Thats not true. It is initialised at :
> 
> etm4_init_iomem_access():
> 
> 	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
> 
> Where
> 
> #define CSDEV_ACCESS_IOMEM(_addr)               \
>         ((struct csdev_access)  {               \
>                 .io_mem         = true,         \
>                 .base           = (_addr),      \
>         })

Thanks a lot for explaination, sorry for noise.

Leo
