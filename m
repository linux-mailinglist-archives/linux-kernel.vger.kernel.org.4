Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804B639749
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKZQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKZQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:43:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735012AF5;
        Sat, 26 Nov 2022 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669481011; x=1701017011;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YJvamjhttIvKOCQiN0tJaqZz9N+He857dOwRgQzhxUE=;
  b=n7i0gdvtfvKsJDHwamIB9nbBHQTisXgWmt9iPRstX17sLO3gO/HdI3O+
   /BteSQ8Io0GH8zIkQJ/6mzRd52xfCiEwQQQGqilcjKSBjIWeHNaRkfsTc
   +KacAtr9Fwakz0ElC8uLjnDRl3OGXxh7biP3amUA5P7myX85rWSHDZPR+
   KOeRACmuVmsyTea88C/n+MoXm8scSsL/jiysVxiapq4+OZ3U1s0EsYgy5
   M5MnquR4eIZo40l/km/YLG0kbvs62RlliPaweeoX8WpkKqaS03mcsPce+
   d7IlBGeKQapwgObpn4pOle/OZLBuny6faZkcB7DEtIqljM5Xg7DNIRXt3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="313304519"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="313304519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 08:43:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="817388176"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="817388176"
Received: from liyi4-mobl1.ccr.corp.intel.com ([10.254.214.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 08:43:27 -0800
Message-ID: <f2b2b8da209a9cf22e80b089a698f78dd5c2f5fb.camel@intel.com>
Subject: Re: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>,
        'Kajetan Puchalski' <kajetan.puchalski@arm.com>,
        rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Nov 2022 00:43:24 +0800
In-Reply-To: <044424e924967a1c93649812b6e1670c8c37fce4.camel@intel.com>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
         <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
         <00a801d8ffba$6cd72a70$46857f50$@telus.net>
         <044424e924967a1c93649812b6e1670c8c37fce4.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Workflow: sleeping ebizzy 128 threads.
> > Variable: interval (uSecs).
> > Performance Results:
> > http://smythies.com/~doug/linux/idle/teo-util/graphs/ebizzy-128-perf.png
> > Performance power and idle data:
> > http://smythies.com/~doug/linux/idle/teo-util/ebizzy/perf/
> 
> for the "Idle state 0/1/2/3 was too deep" graphs, may I know how you
> assert that an idle state is too deep/shallow?
> 
is this got from the cpu_idle_miss trace event?

thanks,
rui

