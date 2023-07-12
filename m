Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B612750380
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGLJpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjGLJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:45:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA581736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:45:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so7587904f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689155123; x=1691747123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeHjmBMqae1zfZ9d1o7CDW2GBVL1eDyXHOBTuOaNFYg=;
        b=AH7cKSqAEvP2fqllKNUyTI6gGKtCoyOQcYze+d458Wne9rqOzCSA2nbNX0VOORk2ey
         jm7uZ2EG4i5+/RqwbtiPmiCHkqW7dNCfzEO2d0C6p++7CSaBagms4S+DBb0SWWvWfR52
         1fJNHgSiLTnlE+FwxtySO/TCT3WcfE1ztbhyFusZQiljr8ILDyysnD94riJoZrQv7RUw
         WoVPS4vXtlpt8mLHgAaDbGh21i1VHozDdmS3E9wTRYRM3Z2s5mjMequ4pgQV272XdcYj
         WYtXphFKBsU+NLbyj8H5Dysp2/YaIY/8mteiWJN7toASik1RaH7KY1LdrxZTXkZWKg29
         wXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155123; x=1691747123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeHjmBMqae1zfZ9d1o7CDW2GBVL1eDyXHOBTuOaNFYg=;
        b=DHrNZzEYLnKmceBCHWbqo5nRpr07WDKVc88/F54i8PTd9xZOq2duXT3OGNhB9kwPc7
         VH3SN0bR02Y4MS7El38pb6K0DygM8ockEMtxC9JP9QKtak4FlSiMQ18jlxcroP1YECz+
         KJ4CiACcVHeEAlj5pbl0QB0AQJdPc5uto6KFzQ/GISL5Zd3xOByva04CscZAY3/nDmdm
         N8ZJLMf8rGgMrGcf+7F+ICixoJG902ZFEQS8nlHFpt+Hc/mzV9+/VT7/vUwUnzE1ZSO7
         6vGoXKkBvGBMbK9GfeKEHMAWRY0zRc2gF2GYq96NUiPM9Oy9W87UsLn1TrBP0kn3/FKG
         A2yw==
X-Gm-Message-State: ABy/qLaK1M8tpj7HbtZFsURE81+W6buYsqZX11g5Sa6DOnrGVRjDLlAU
        XMbvf+6S/jaohvdJpJz+GSbdfQ==
X-Google-Smtp-Source: APBJJlHrEeMT+kJGs1oHD4HOzLI6iswJjrdlJA8OCycHTa0XqhhKKvXc0gGBPcdwUB5hP77AXSiBZQ==
X-Received: by 2002:a5d:56cd:0:b0:314:3983:1465 with SMTP id m13-20020a5d56cd000000b0031439831465mr18892557wrw.31.1689155123166;
        Wed, 12 Jul 2023 02:45:23 -0700 (PDT)
Received: from myrica ([2.219.138.198])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b00314329f7d8asm4577438wrw.29.2023.07.12.02.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:45:22 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:45:22 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] iommu: Add common code to handle IO page faults
Message-ID: <20230712094522.GB507884@myrica>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
 <20230711010642.19707-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52761F71BA509501C1766E9A8C31A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbbe1175-40f3-805e-02c2-f887b3289f04@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbbe1175-40f3-805e-02c2-f887b3289f04@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:32:13AM +0800, Baolu Lu wrote:
> > btw is there value of moving the group handling logic from
> > iommu_queue_iopf() to this common function?
> > 
> > I wonder whether there is any correctness issue if not forwarding
> > partial request to iommufd. If not this can also help reduce
> > notifications to the user until the group is ready.
> 
> I don't think there's any correctness issue. But it should be better if
> we can inject the page faults to vm guests as soon as possible. There's
> no requirement to put page requests to vIOMMU's hardware page request
> queue at the granularity of a fault group. Thoughts?

Not sure I understand you correctly, but we can't inject partial fault
groups: if the HW PRI queue overflows, the last fault in a group may be
lost, so the non-last faults in that group already injected won't be
completed (until PRGI reuse), leaking PRI request credits and guest
resources.

Thanks,
Jean
