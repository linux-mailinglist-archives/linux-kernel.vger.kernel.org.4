Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A85668441
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjALUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjALUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:49:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C282C7FEF0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673554771; x=1705090771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xPz0ZPBEZzdOTN1uk31DLN4iVs/QuDCfz3K5QzwOKkE=;
  b=Gte0HBq0rdVlC4TNkjvqNOQe5NGmQjv/4gbj8RTq5JbBDhFDx8ehqea5
   FCkTezi7/0E8QVKy2++OuSY9JtPJXcE2XbumWojq7MOu20XsmIZVNcwpS
   zoLR965VKr6vcdTL1SJKFFXSwTOT6dhccIvJuyaGQNQABmpKet5ZDi/xa
   c8CZJVY7wNuvTcloXNhg4Fm6ybd5Ym2naOaQCRaqVUTTrXMNYRTuu+2VI
   Z4oNYbWgtQP4VnGyVYTG6SkQst3TIiwtHlwP6D8RjUW+bJzhBFdFilvnY
   0xfzZwTHvmbJ/qNMlDKbl4xkZNCdf133DDAIjZ7kAyws2Rb+cnVKIOEMg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304201857"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="304201857"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:19:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659968451"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659968451"
Received: from jcalle-mobl.amr.corp.intel.com (HELO [10.209.179.77]) ([10.209.179.77])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:19:30 -0800
Message-ID: <4a6ae9b4-2748-c751-aec6-05979de95cfe@linux.intel.com>
Date:   Thu, 12 Jan 2023 14:19:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
 <Y8BOCpXyOyF3igfG@sirena.org.uk>
 <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
 <Y8BkiF8sfqPifYTO@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y8BkiF8sfqPifYTO@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 13:50, Mark Brown wrote:
> On Thu, Jan 12, 2023 at 12:43:46PM -0600, Pierre-Louis Bossart wrote:
>> On 1/12/23 12:14, Mark Brown wrote:
> 
>>> The regmap gather_write() operation allows the bus to take two buffers,
>>> one for the register and one for the value, rather than requiring the
>>> core combine everything into a single buffer (mainly useful for large
>>> transfers like firmware downloads).
> 
>> Right, but that's not supported in SoundWire. sdw_nwrite() will only
>> work with consecutive addresses - and the auto-increment is handled in
>> software, not hardware.
> 
> No, that's exactly what this is for.  It's for the *register address*
> being in a separate buffer, the data is then a sequence of consecutive
> register values.>
>> What's suggested here is to use the first element of reg_buf, which begs
>> the question how different this is from a regular write. If there was a
>> discontinuity in reg_buf then this wouldn't work at all.
> 
> reg_buf contains the address of exactly one register.

So what's the difference with a plain write() of N data?
