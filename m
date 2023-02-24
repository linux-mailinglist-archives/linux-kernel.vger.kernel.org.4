Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6366A2097
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBXRoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:44:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D61351E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:44:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so2755277wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABAymivtzLVXmfabanq8IH08mxiGWPYpwC0ephBRLG0=;
        b=gYU+7Unrce8q6rrCpIL/B0cnvipjfJwjoXnHA9enfaMCXALHoxu4g4kz0BM5G2JS7J
         fLIUujLpCOSHfGfG1Bp+Izyc3f+noF01kkC5p0fn67OvuBkRCQTQFXqRb8/r0luGyMlD
         Kc1hsFRIp31Ub0PKsVVt9JaCEg5zGMmNzOj6qxgQv6gsyL7jdfak5GS5g2fdXpZFAawC
         POeLstnKr7hp3IT6ri1DJX5xz4c3sdRgm1MlzlW7Sz37lG88eE2Oz2ecqQi8YXJcTJae
         rq6zDjiQM7h5jd9LlprSBTr834/ey4zelWSss+JKqM40BAXa5NugKuVbEHBpPIJ7DeJT
         ZevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABAymivtzLVXmfabanq8IH08mxiGWPYpwC0ephBRLG0=;
        b=XSKMg1sP/GT8Mdb1hQFZi9KKZMNs5ISY4uMG3WUfhvemN31TgVzM2ozqW+EdbgLDfU
         E/WMYYm1/X2XWML/FnIuP/z9Sq46lpS0pnpq8OfcCk+amcXmH+wov4qfMehCqwWN4xrQ
         ME56jQIEW6w/Dm50DzioA0K40HNtiuV8qGf3GTuS1ZFRd7+sy3gy7yDGAHVEgJhPQVax
         QXs4LKYNTtG1ySkN1AfI0oGOmBw5NQh33XxIM1kA8cy2fdAJkVaZzurLCjW8C6tk9GgL
         4CtHUUl7MaMNhH7PRcknyHo1ERjbkTVXmuF/rhAChZV9wKlmg8lzZWpHD9RY0oAoGVNn
         KzQQ==
X-Gm-Message-State: AO0yUKURh7TiiIS/2Sy4f1xzWMW+BuaKbgSWwY2/a2nWNhAQwY5hSLUY
        B5eNyDL7wepuwsd9x0xE52jRwQ==
X-Google-Smtp-Source: AK7set+UVe9jwKR4MXwkj0n/p9aOAlU1m0yXD7Hn0JW6PRPP8wNnTUvpeXbNeJeOiHs/Emw541fz2g==
X-Received: by 2002:a05:600c:3b1b:b0:3df:eda1:439c with SMTP id m27-20020a05600c3b1b00b003dfeda1439cmr401643wms.11.1677260672271;
        Fri, 24 Feb 2023 09:44:32 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003dc4baaedd3sm3267078wmc.37.2023.02.24.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 09:44:31 -0800 (PST)
Date:   Fri, 24 Feb 2023 17:44:32 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <Y/j3gO1GsqS6svhO@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
 <Y+tW3kxFeOMcELww@myrica>
 <20230215133651.776a1553@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215133651.776a1553@jacob-builder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:36:51PM -0800, Jacob Pan wrote:
> > > -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > > -	if (!pasid_valid(pasid))
> > > -		ret = -ENOMEM;
> > > -	else
> > > -		mm_pasid_set(mm, pasid);
> > > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > > GFP_KERNEL);
> > > +	if (ret < min)  
> > 
> > Just check ret < 0
> yes, but i thought < min is safe too. 

It is, but 'ret < 0' is the standard used everywhere else. So someone
reading this code will stop and spend time trying to figure out why this
isn't 'ret < 0', wonder what's special here, inspect the ida_alloc_range()
doc, etc. No big deal, but I think it's unnecessary.

Thanks,
Jean
