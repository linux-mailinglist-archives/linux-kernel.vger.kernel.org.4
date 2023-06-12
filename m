Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDB72D135
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbjFLU6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbjFLU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:57:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B501FD8;
        Mon, 12 Jun 2023 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686603218; x=1718139218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yZDu6jpDfsPrib6sgBtYsE6AHXoQX3x+qF2vtZtYuu8=;
  b=f5bSwK5jYaxbiTFpAv2N6YmjgQxmtVXb61WZLIgT7zT/My0FLCfEsNMK
   sI39WT+sxOXeIk5mcfS5cqPq1Rq13jqwCarmUjH+TNcafPr/8I6sq++Fn
   qfIGgwyFC0NoOcSaR5DNDUmlSIghbYqvgzdG/rV+HsnWkMuZ8/JFoJamw
   GW/WZDXha4JBDsQm4sCoy/0Sslryz+z/itq3i5o+r8MMLMnnl+8JtYePo
   jwLyraAJ48lZvIIBgnq8UgDqBBoaxHIlDYnHZP5yYclqe9O0EYNNrMcxo
   xwzUVLcFU864JqCNZHO6f6vJjmDQEsx4N24hV/NTlaXKuyXbeCgv464JX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386547617"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="386547617"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="711361022"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="711361022"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2023 13:52:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1q8oWc-003Ipk-17;
        Mon, 12 Jun 2023 23:52:30 +0300
Date:   Mon, 12 Jun 2023 23:52:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, fengguang.wu@intel.com,
        dvhart@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86/dell/dell-rbtn: Fix resources leaking on
 error path
Message-ID: <ZIeFjkAAiS+TMa8g@smile.fi.intel.com>
References: <20230612090250.1417940-1-michal.wilczynski@intel.com>
 <20230612175205.eom2guabgfmnzrce@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612175205.eom2guabgfmnzrce@pali>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:52:05PM +0200, Pali Rohár wrote:
> On Monday 12 June 2023 12:02:50 Michal Wilczynski wrote:
> > Currently rbtn_add() in case of failure is leaking resources. Fix this
> > by adding a proper rollback. While at it, remove unnecessary assignment
> > of NULL to device->driver_data and unnecessary whitespace, plus add a
> > break for the default case in a switch.

...

> Hello! I'm looking at rbtn_add() function and there is also code:
> 
> 	rbtn_data = devm_kzalloc(&device->dev, sizeof(*rbtn_data), GFP_KERNEL);
> 	if (!rbtn_data)
> 		return -ENOMEM;
> 
> which is called after rbtn_acquire(). So it looks like when kzalloc
> fails then there is another leak...

Side note: In that case we would need a devm wrapper on acquire call.

-- 
With Best Regards,
Andy Shevchenko


