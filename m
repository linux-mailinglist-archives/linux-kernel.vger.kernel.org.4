Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C174EF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGKMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGKMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:45:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97610A;
        Tue, 11 Jul 2023 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689079539; x=1720615539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X5b73jKPqveoAydI+sEyVgy13u2RunmFko8n93zESTQ=;
  b=bYNxZkmiuBvEyR4NfmD0Y7J2dN+hn0YDNqttCP9Z4J3z5JVg2L35VbPY
   uBJ9MXBcBiYYA/2gCXIZHLooB9/KB3xoHE2GtRuearg0LPNvQ5u45WsSW
   zI2EmSAdMzPZsxBH6g1LrCykK0Foef4hr6WBPlIpDpCcFZ1ecRM592Dnw
   oKi0gzdKBaehlNpWU7Edb/fnBZ878hDDeSxaGmwXpayoEj3r2Zo/lVjdl
   dyIBUwrutZ69hrtWsRecZETsthw8C8WS64eKSUoajRno96g0jC6/1m5gi
   W02oJfe6hGvd67jHnNfzqodPKcTIg0oFJQbcILNm+ypz7zk2IEJazZqZR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="349416626"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="349416626"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="845246106"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="845246106"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2023 05:45:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJCkI-001qi6-29;
        Tue, 11 Jul 2023 15:45:34 +0300
Date:   Tue, 11 Jul 2023 15:45:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <ZK1O7lBF1vH7/7UM@smile.fi.intel.com>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
 <20230711063348.GB41919@unreal>
 <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
 <ZK002l0AojjdJptC@smile.fi.intel.com>
 <20230711122012.GR41919@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711122012.GR41919@unreal>
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

On Tue, Jul 11, 2023 at 03:20:12PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 11, 2023 at 01:54:18PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 12:21:12PM +0200, Paolo Abeni wrote:
> > > On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> > > > On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:

...

> > > > So what is the outcome of "int - bool + bool" in the line above?
> > 
> > The same as with int - int [0 .. 1] + int [0 .. 1].
> 
> No, it is not. bool is defined as _Bool C99 type, so strictly speaking
> you are mixing types int - _Bool + _Bool.

1. The original code already does that. You still haven't reacted on that.
2. Is what you are telling a problem?

-- 
With Best Regards,
Andy Shevchenko


