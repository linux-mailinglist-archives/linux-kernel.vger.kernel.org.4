Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272136A479A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjB0RNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjB0RNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:13:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277D5B86
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677517980; x=1709053980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LPgBiQJ8TCTE4vMyNZcNi9azz5E5qNaH/wYiASzPZZA=;
  b=jdS+hejxchPht55EM7dWh5u7zXGwk+5DhDyO+Zg8khxAy5U7Ic6j/b7G
   S6Rlif8LA5LN6CZjXcfOsvxi5tGMMtVw0NxM7WCGB/1uk3gzi6Yha1Vjj
   GSaQq8/0uwJ+7ELpWsSFS8Ovuqc2MGsBE5LoDshdJiDxSXFiAF2v+2A0J
   n1HAKNSkDK/r14crpHQ8JmD9nit+Xixf9rEu685SBsgtmBH9ueYK407BH
   CB/KVl67mDjQavCtjvT9R26rvGg+/Xirhh9RuJ1dzTsr1azOQBsa7rx1o
   57Cn2/P/hcMklVVcPBsTiq3pohsjWmHdJpJR6tf/o/Vf5r5UoD2igMzZw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313583711"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="313583711"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:08:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651302252"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="651302252"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:08:30 -0800
Message-ID: <7cbc9556-c0a3-91d7-effe-785b282eb160@linux.intel.com>
Date:   Mon, 27 Feb 2023 11:38:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V4 5/8] soundwire: amd: add SoundWire manager interrupt
 handling
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230227154801.50319-6-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 10:47, Vijendar Mukunda wrote:
> Add support for handling SoundWire manager interrupts.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
