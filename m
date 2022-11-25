Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11A06386E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKYJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKYJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:59:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C8BB5;
        Fri, 25 Nov 2022 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669370361; x=1700906361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aCQh/6+V3QT49febPe5j5JfKoJMAkFYpQopUmrNuS5k=;
  b=TsvbwrZOEW51PWd0OKlQhbUGrGiQR1EGs4R01Zz0C2r33ZiLxQUB7iN3
   eEFN1Qps3qxsM+yw8/PBkOKeZva5sxNJs2VIANSP+xqyXd8uIzuww0u/Y
   am9cKUMSRjlFcSl2pb+vVValmcqfDiBjW9ezH581I9rNHVOStVD/n/IZC
   KOFCOWZtHstMsOdic4aPzvJL1mTpT109WiZ3gNZ4aU5pAMJkRc55u8Hv7
   BLXjCl/4ZnD/GngxKzB5y/MoIx7n8xaSb6xzR4XHFsRjE9X/ROnbEDKLr
   si434ELMpadRwnG/kP8Kj5RgxBgOcWxRyw2sokEwclHYa+bjTLzlSaUHS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="400742217"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="400742217"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 01:59:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="642656275"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="642656275"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 01:59:18 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B4ECB203B0;
        Fri, 25 Nov 2022 11:59:15 +0200 (EET)
Date:   Fri, 25 Nov 2022 09:59:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, djrscally@gmail.com,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y4CR8/CXMhlMt+WS@paasikivi.fi.intel.com>
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123022542.2999510-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Thank you for the patch.

On Wed, Nov 23, 2022 at 10:25:42AM +0800, Yang Yingliang wrote:
> The 'parent' returned by fwnode_graph_get_port_parent()
> with refcount incremented when 'prev' is not NULL, it
> needs be put when finish using it.
> 
> Because the parent is const, introduce a new variable to
> store the returned fwnode, then put it before returning
> from fwnode_graph_get_next_endpoint().
> 
> Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
