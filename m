Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B6F750D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGLP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGLP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:57:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646FB7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177440; x=1720713440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vsBYbPUN9ErRA1Ky88LQVLKPuksMQ8x0QHfMWropSko=;
  b=MPrr9d6Wh6Kv5+47epATrzpR2abpdpbt02vxQ7S/YOrdsJjMsz/5HGuq
   Cfxc9JH4jiIYrQZg7f0GCWf51IrxgBjSNeAgAzhq/2V7EBhhSMcHYzI4B
   TIZwJYwK8uJMztIluAoLJ0mMSSrhsKgG1q2jno9WEkqKvXLb6ldZqNO5l
   7hIEW20zCN9VfObUbJs5AGQ+YgrCLkdINgG6Dxe82eeGQHSHlE1FCShtj
   zGkIKa1OyrZI/oH1uyiuDaMza4DUVONR9AyzMwTIJ3H2yA51CF5DYX8gL
   jP2LBIykqMt8c/l8erqOwcrbY4GEu2HjDRuupB+HY/aXwCWXD822xPKNo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362392877"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="362392877"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="751212844"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="751212844"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2023 08:57:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJcDC-002Acp-2v;
        Wed, 12 Jul 2023 18:57:06 +0300
Date:   Wed, 12 Jul 2023 18:57:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: resource: =?utf-8?Q?Re?=
 =?utf-8?B?bW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?= values from err
Message-ID: <ZK7NUpb942858aiI@smile.fi.intel.com>
References: <20230713235339.3090-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713235339.3090-1-kunyu@nfschina.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 07:53:39AM +0800, Li kunyu wrote:
> err is assigned first, so it does not need to initialize the assignment.

While this is fine, I would go further to make it more explicit, i.e.

> -	int err=0;
> +	int err;
>  	struct resource new = *old;
>  	struct resource *conflict;

-	if ((err = __find_resource(root, old, &new, newsize, constraint)))
+	err = __find_resource(root, old, &new, newsize, constraint);
+	if (err)

-- 
With Best Regards,
Andy Shevchenko


