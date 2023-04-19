Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248FA6E78F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjDSLt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDSLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:49:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27AA1444E;
        Wed, 19 Apr 2023 04:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681904960; x=1713440960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OPP1C8YuxtnIbCY/sROjfAtEavPCY5tUqK299duqJqE=;
  b=SQuir+vFW9qkrKIv7fkKH7aB7MXoQvhAJCA1lOJJlcb6Z2rv87NI1Sl8
   mqLM4oHYD+dBbtmExQljT2pAwTUbxqhfsMEnz4LczKW1fMrToUV/3s0WV
   suXyMINBQMX6ZNlQhAIA/IgGxkUzicIZ21drys23gLg21H5+V3wFL8n3q
   H6DDulmOksYkFlOnXStPb+55jjtzRufXm2ugz4UI7w+Z58sWgRqC+UaSS
   Uk1y9lHaMyLpaJpD/pyrzqk25VNYebr8xEkom1zDsow1hXZ2DtTGwb78P
   M7Y+oUrKZla1QVfdt0s2CnoL5A2Uk9cleZs7CYSNldicCOrtkK3XErFpQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325039172"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325039172"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 04:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="802901361"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="802901361"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2023 04:49:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pp6JH-002DML-16;
        Wed, 19 Apr 2023 14:49:15 +0300
Date:   Wed, 19 Apr 2023 14:49:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
Message-ID: <ZD/VO1cuBYGCP4O2@smile.fi.intel.com>
References: <20230418052902.1336866-1-joychakr@google.com>
 <20230418052902.1336866-5-joychakr@google.com>
 <ZD5JC7BdN1usn6Kd@smile.fi.intel.com>
 <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:18:25AM +0530, Joy Chakraborty wrote:
> On Tue, Apr 18, 2023 at 1:08 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:

...

> > > +     /*
> > > +      * Assuming both channels belong to the same DMA controller hence the
> > > +      * address width capabilities most likely would be the same.
> > > +      */
> >
> > I had a small comment on this In v6 thread.
> 
> Sure,
> 
> Your comment in V6 thread:
> "
> I would add something to explain the side of these address width, like
> 
>          * Assuming both channels belong to the same DMA controller hence
>          * the peripheral side address width capabilities most likely would
>          * be the same.
> "
> 
> I do not think the address width capabilities are dependent on the
> side of generation like memory or peripheral.

Yes, they are independent. Memory could do with 4 bytes, while peripheral with
1 byte and so on.

> From what I understand,
> address width capabilities are solely dependent on the transaction
> generation capability of the DMA controller towards the system bus.

What do you mean by a SB in the above? Memory? Peripheral?

> What we intend to highlight here is the assumption that both tx and rx
> channel would belong to the same DMA controller hence the transaction
> generation capabilities would be the same both for read and write
> (e.g. if the DMA controller is able to generate 32 bit sized reads
> then it should also be able to generate 32 bit sized writes).
> With this assumption we are doing a bitwise and of both tx and rx capabilities.
> 
> Please let me know if you think otherwise.

-- 
With Best Regards,
Andy Shevchenko


