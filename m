Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37DA69E552
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjBUQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjBUQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:58:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44073193CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998719; x=1708534719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dNDiJFMnzKrNtVN4zEBNc0Z72+aV30wuuQw/PpbtgVU=;
  b=jN/0MVYwmeLhUalrhZXkzumJAKpENkId88yLvMGhuRlo864CSmj8RpeW
   NnhvEhj5dcQyfLmsUg2NgoTe2eden7wMpXkBMO1rzhpxTmlGk3MnaYvmo
   li5rpsk/Z5lYpb5krqYq+nxhs0JhAv6Hmw0cr7li734uIPuUurgkrqERy
   5TGN80N2N8ZK08i6bAU29RHfhBb8OazQrNwNwqi7uZQ++NIFtQH/pm6hA
   L0qiZ+tOp26DYRgshMrW+udsmp08k8x+KWIYlRJ383SucPgcSXDESZpn0
   0U/QCQ2N/AaDPDtc+pAfxGkRTwwo3QW+Ox+1KANzWTUBCYb8tX5CrQVuv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884643"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569093"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569093"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:33 -0800
Message-ID: <b6f06e29-22cb-a996-5dfb-91544059051f@linux.intel.com>
Date:   Tue, 21 Feb 2023 10:59:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V3 3/8] soundwire: amd: register SoundWire manager dai ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-4-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230220100418.76754-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
> +	.hw_params = amd_sdw_hw_params,

don't you need a .prepare to deal with suspend-resume?

> +	.hw_free = amd_sdw_hw_free,
> +	.set_stream = amd_pcm_set_sdw_stream,
> +	.get_stream = amd_get_sdw_stream,
> +};
