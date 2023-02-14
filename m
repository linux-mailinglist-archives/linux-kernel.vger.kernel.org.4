Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C36962E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjBNL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjBNL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:56:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099E25E33;
        Tue, 14 Feb 2023 03:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676375785; x=1707911785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NnoMqJ3mzErGTLdKzrq/8ekrEyt2dHs+nTMsB9dzFOs=;
  b=YsWPpR0JBNACRGS6i+P3TIBmoTySkq1x/DJ+j4KPAmOOtIEd8VsGnFix
   tAHehlsu+ooNLmErFao2IBWX3jqJuZkxHfuP7hlRUcOCqhsNCg+v/qdv5
   uZF4JnLBg27eoASmSaCXkA48fpsvKDyGGej0ruNw9gGktuia+lLSkdzJs
   wdUg9xmnvDbjw6l18TZKIm1R5Q1u+xrFp06rgayC5imishdUP8pWRLFlp
   B29f7SuObr+q5zDALG2Shx6q7HKMUok2mBUXq8ga4uBvEquSY8y9wYXLj
   sB9RolmNCfqXKu8Id90zLBC3gJMGKnhZU8MwFzrUF6wu3IIJ3UgjK6LD/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333279524"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="333279524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 03:56:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="811996408"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="811996408"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Feb 2023 03:56:05 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Feb 2023 13:56:04 +0200
Date:   Tue, 14 Feb 2023 13:56:04 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] usb: typec: ucsi: add PMIC Glink UCSI driver
Message-ID: <Y+t21P3dSe5PLOro@kuha.fi.intel.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-1-71fea256474f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-1-71fea256474f@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm waiting for that other series that this depends on, but in the
meantime, there is one thing that has been bugging me...

On Fri, Feb 10, 2023 at 04:02:04PM +0100, Neil Armstrong wrote:
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> new file mode 100644
> index 000000000000..9123f8a571e7
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023, Linaro Ltd
> + */

Is that correct? Shouldn't it just be:

        Copyright (c) 2023, Linaro Ltd

and that's it? Otherwise this look OK to me.

thanks,

-- 
heikki
