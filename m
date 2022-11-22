Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC6633CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiKVM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiKVM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:58:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A01ADA8;
        Tue, 22 Nov 2022 04:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669121891; x=1700657891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5P5fIPjOUrWrzFoYPzpJkUe2ziZ2m4Z9Nx7dFIpVxFM=;
  b=jKsov13I3p7p32mHzJ77QT6Hy7b8klh3mgmdCksW+ohnQhJ4j+/0x1TP
   WrFSUy3t+j5Har0oja6Uwr3VADMUDlK1CVB5eW+/6I8PaIeY94skCPKBj
   mL6N0VUVnX5tGG0tU2bnxtppzA6b+nZ4Nnz110bsliSzp+auccrbZzZcx
   YgOm+PS/DotudgMYm/BOIZkoIehrju31P53X0nPby7NXVEsazJr6oxYVJ
   mgGjGVNIpokJrA9IKcRO+rHSuuCLrKU+4315cRFEMxDOe9ynNuoeWuAvu
   eFDAQncvmAVp2yAd2+tEOh4AM/Y95/eXKo6UWRRdBOegy7LbQNI+SYdyE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340676200"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="340676200"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="643711516"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="643711516"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Nov 2022 04:58:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxSql-00Fpu2-2Y;
        Tue, 22 Nov 2022 14:58:07 +0200
Date:   Tue, 22 Nov 2022 14:58:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3zHX9FQm8rhLRpt@smile.fi.intel.com>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
 <Y3zHF8rdguSaavo1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zHF8rdguSaavo1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:56:55PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 02:54:36PM +0200, Andy Shevchenko wrote:

...

> out:

Actually better name is

out_put_parent:

> > > +	fwnode_handle_put(port_parent);
> > > +	return ep;

-- 
With Best Regards,
Andy Shevchenko


