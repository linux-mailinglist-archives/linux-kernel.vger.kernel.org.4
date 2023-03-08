Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB596AFC8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCHByV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHByR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:54:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD75F531;
        Tue,  7 Mar 2023 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678240456; x=1709776456;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6/zv7m3IA6CkY+ozpRASdY5fBVx8Ky1TfJQ7tvgNfng=;
  b=ieYTNiYa4jqePsO3JoXTACiErSX7pKPNZUMnIqlYlWBuoT+NWyyaFjVc
   1myg5JdOaIWvVAdHB5QgvW8qZ3IeYyisAkqdVWH4++gu4iLPj3w64BBgN
   a7i7PUaKzy7otQTgBGhd+ABOIFjlTXp48O3sD0xY2936oMK/xRkm6s4e+
   g6t2WdOXXSCxh++C2RlbyJbuv6MTXOkEoHrxwfIWX2Ce91rgnb52EB+wG
   LNvMZj4gXLlhOuzB3xLzu28Q7lDun+OCjlwsIEE9iwTl+nK0aQSjw/uYh
   WABzGP2f5O+J+d8Qn0QTmiXkuHcyBI2sJ2XGU8Kz7bkPhcwxykQf27hb/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333501355"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="333501355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 17:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="676794837"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="676794837"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 07 Mar 2023 17:54:07 -0800
Message-ID: <63a49364-21c4-e82d-6449-18f163efff61@linux.intel.com>
Date:   Wed, 8 Mar 2023 09:53:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, okaya@kernel.org, harpreet.anand@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        pieter.jansen-van-vuuren@amd.com, pablo.cascon@amd.com, git@amd.com
Subject: Re: [PATCH v9 2/7] iommu: Support ops registration for CDX bus
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
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230307131917.30605-1-nipun.gupta@amd.com>
 <20230307131917.30605-3-nipun.gupta@amd.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230307131917.30605-3-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 9:19 PM, Nipun Gupta wrote:
> With new CDX bus supported for AMD FPGA devices on ARM
> platform, the bus requires registration for the SMMU v3
> driver.
> 
> Signed-off-by: Nipun Gupta<nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren<pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal<nikhil.agarwal@amd.com>

Nit:

The bus iommu ops is about to retire. So probably the commit title could
be "iommu: Add iommu probe for CDX bus"?

Anyway,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
