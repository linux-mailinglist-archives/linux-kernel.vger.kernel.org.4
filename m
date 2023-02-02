Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B366881A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBBPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBBPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:21:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3101F9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675351316; x=1706887316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1kEcAzPLOKaxZWVbf7kW5ahp0Gw7z2mqgYwUrD3H4nc=;
  b=O9EIBsNqVrKJCHp8sxVCNRjcOiR6ZKpP0XKMenl1/XEy/2o4i0Hukb2R
   8dW7GuReaDhpdGNlDR6upF1claHwyS7K3gzIfNVnDHJCjvssgHQSc/pZW
   bfufokvX1iQ1cRvef0BmrmGd9B6f2vdn4FKcUFO74EeMJgZtdEjajWhpZ
   ktCpmr5xqqy20paJIXJ4loB9jqKc07JT2H1QjbD+LPBJF4mtiQHSWvfKo
   o+jBfUlnl7SWxeT/HRxoV2jhE9vXXFIWL1fd8hMZ6U6JQ1PwqabM+9k5G
   P7xrq8S7j7Cw8MUCDb8c5cKIMx2+/RqN3YvtMhm2pXTFGFeSQcODpoEVL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308810036"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308810036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 07:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658765879"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="658765879"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 02 Feb 2023 07:21:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNbPM-001EOG-2F;
        Thu, 02 Feb 2023 17:21:52 +0200
Date:   Thu, 2 Feb 2023 17:21:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mei: Move uuid_le_cmp() to its only user
Message-ID: <Y9vVENZEjg1e43LT@smile.fi.intel.com>
References: <20230202145412.87569-1-andriy.shevchenko@linux.intel.com>
 <20230202151759.GA28861@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202151759.GA28861@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:17:59PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 02, 2023 at 04:54:12PM +0200, Andy Shevchenko wrote:
> > There is only a single user of uuid_le_cmp() API, let's make it private
> > to that user.
> 
> Any reason this code can't just use guid_t and guid_equal?

It's part of ABI, while guid_* are for the internal use.

Eventually they may switch to the internal types, but it's up to MEI.

-- 
With Best Regards,
Andy Shevchenko


