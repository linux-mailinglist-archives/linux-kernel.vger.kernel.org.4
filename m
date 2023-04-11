Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C6C6DDF68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjDKPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjDKPRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:17:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048C6185;
        Tue, 11 Apr 2023 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681226205; x=1712762205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wFgblxP5m2mezLjymbN/Ocfzg4VlMFclmZaOtKHFmM=;
  b=XxYIO2WqPjv4jiSIMrwlmP1KdiekKfJ7GnETn783Zbwb4MQ8E+8kvZ7P
   Hz+mjNZCKEX7Vyk+e7peZNc2GGkv4Zd0LduQkuS9fNry8ZOxi0Sy1oImY
   JBNRhbsL/JVZ+GO8KxCqYIW5DCxzQ2vOGufTn5CsNKJcxziJc2SME32SS
   d8nGk2qxAJwXvIhlMLExTzOIfkSBhvmgr/loUl7FaAXr32+FW4leFdSxO
   yG4DfmYfwXsCEuAkpZeImhR43l8T4BUUcfdQBO9itoLt9C9+5ANxCD07v
   zmcjPFj7Q+nXF3AgXL9tcMyNc+GLCIvMVdeO2SPJRKMO1XGdt6LEXKtJx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="371495248"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="371495248"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753178318"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="753178318"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 08:15:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmFiN-00FLhS-0A;
        Tue, 11 Apr 2023 18:15:23 +0300
Date:   Tue, 11 Apr 2023 18:15:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <ZDV5iqj5vbzO5oPU@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
 <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
 <CAOSNQF2zg5ymTfZWWbFLAgvKdcxRcggAjGt+Zy+qUzrR5=MERw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSNQF2zg5ymTfZWWbFLAgvKdcxRcggAjGt+Zy+qUzrR5=MERw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:37:33PM +0530, Joy Chakraborty wrote:
> Sorry I think the emails crossed.
> 
> So as per the discussion, are these the possible changes:
> 1> Move "dw_spi_dma_convert_width" to avoid forward declaration .
> 2> Update the commit text to include more explanation.
> 3> Divide this into 2 patches?

Seems okay to me.

-- 
With Best Regards,
Andy Shevchenko


