Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE5673685
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjASLRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:17:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2AB64DA1;
        Thu, 19 Jan 2023 03:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674127065; x=1705663065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+V4r9ZArU3A1gYY8X12Cens1VVxsFLF0cBxVdWqJJIA=;
  b=XTa4iFB42WeA0TPUEx2dLOF2xZOdSwvPDCTZ8JoExEe6MHizUK28X+Su
   d93tpL8OEvGG5nKWlIcMJicxOFgUxLXRR0uOEwXWq6W6+QR/E0foEc9SY
   ja0C7m47qruKJzN75IG3J0vJI2OfhXFfgjblDWeYUiXj6qNVQTx6lygUO
   46afn+VXbmikFmj3Sa/7x6rjZY+O4yzCvNCpCA1L0ve4UT2FQWr67vySj
   Wt88DWLzyRYiHXpXBxMWQqrNbPp4QGk9+SqjbiBiWXeLVFGmbgmSBL5JG
   bc8Rz+c0Y+hZacf6rG5yGz8JHi5RTbDTRgS/ER0pmI+bEvpyLJBXw2Uke
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313132942"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="313132942"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:17:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="662080952"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="662080952"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 03:17:43 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 96D67203C4;
        Thu, 19 Jan 2023 13:17:41 +0200 (EET)
Date:   Thu, 19 Jan 2023 11:17:41 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Make
 fwnode_graph_for_each_endpoint() consistent
Message-ID: <Y8km1Zwl1IUXh4s2@paasikivi.fi.intel.com>
References: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:21:20PM +0200, Andy Shevchenko wrote:
> Make fwnode_graph_for_each_endpoint() consistent with the rest of
> for_each_*() definitions in the file, i.e. use the form of
> 
> 	for (iter = func(NULL); iter; \
> 	     iter = func(iter))
> 
> as it's done in all the rest of the similar macro definitions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
