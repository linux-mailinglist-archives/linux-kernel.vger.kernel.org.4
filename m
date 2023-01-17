Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B577766E30D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjAQQFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjAQQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:04:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E83D09A;
        Tue, 17 Jan 2023 08:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673971492; x=1705507492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qTIGZhHsogZqwWzBVybtzsRWKk2JT4HpplYRRMgYYPc=;
  b=Q7b7CCL+un56TN9CS7/oUhmCYa6WzgdEtBpTJLoR6+fjnFp1GkCB01sl
   mqF9jh8uSyeW9Dj4lUjK2ZXjkMAJFwsA6Ocyyf3+WC6WKUD7YxMQRwaHA
   IJq5ab1KRCOl+uQ+ZlAUobUbk1hiYyxydGIqz3Yesh7ExJ9yvD2prV4C8
   p+jRQLNZ/NjKN6hHJWfXDuT7mpT8Zg/jZ2fM5vWVw5lbDjo52V5WwHZyD
   S0GRwiCidHaKKhlp7+LX/kHLE58AX6UrjHwrFgyYt8/8ym6SZ/h79cUC9
   j81FEDCb0HuZXx2KRUa/Xc/1ktKItvcqdMvgU7B0HyHmFVhR9w+dWtVdz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351978262"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="351978262"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722716800"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722716800"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 08:03:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHoRB-00AeIe-14;
        Tue, 17 Jan 2023 18:03:49 +0200
Date:   Tue, 17 Jan 2023 18:03:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v1 1/1] thermal: qcom-spmi-adc-tm5: Use asm intead of
 asm-generic
Message-ID: <Y8bG5N6uf5XLoiuH@smile.fi.intel.com>
References: <20230103145339.40501-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103145339.40501-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:53:39PM +0200, Andy Shevchenko wrote:
> There is no point to specify asm-generic for the unaligned.h.
> Drop the 'generic' suffix.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


