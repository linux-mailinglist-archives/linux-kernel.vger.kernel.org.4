Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1677E72248A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjFEL2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjFEL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:28:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C45B8;
        Mon,  5 Jun 2023 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964497; x=1717500497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MXpuxIdlezOpRNLUw2sZPpBNzgzkQEchFs7aHBxowmQ=;
  b=PJ2/ODKesV5gfy8MFduRG9CRlbshDIK+yiCgyL2xV62uvKON6RawXJxG
   XH5d74hAqMMQ2uV+QqbqYnqaO1E9bSL/z9PHxiI7cBzf0LBAD8NFhcl9d
   hoA/8sy9hZkmfDxWwAdWGhjOqRjjzCDUkiA7QAFXrYC1awTduQO69zAV5
   psyNs0xdCznr49iUSPH953NUao5N9NsmOGb4/IDtKry/d4Ttvwfa7VAG7
   KQwdzPd98xFOI4Q/H5lXuAFAiJhspk0zG2y64Jjt4KnE1PAz+ZXExxQ+y
   tklfw1hNSoCv4faPLIUUrxc2cF29khlqY681BOjYfZ5wxvG8fbjTjwS7H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335961974"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335961974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="821158038"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="821158038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2023 04:28:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1q68Nb-001MH3-1B;
        Mon, 05 Jun 2023 14:28:07 +0300
Date:   Mon, 5 Jun 2023 14:28:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZH3Gxwb7/VYzIW3r@smile.fi.intel.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
 <20230603063533.GS14287@atomide.com>
 <20230605061511.GW14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605061511.GW14287@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:15:11AM +0300, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [230603 06:35]:

...

>  	/* wait until UART in idle status */
>  	while
> -		(serial_in(up, MTK_UART_DEBUG0));
> +		(mtk8250_read(data, MTK_UART_DEBUG0));

In case you go with this, make it a single line.

-- 
With Best Regards,
Andy Shevchenko


