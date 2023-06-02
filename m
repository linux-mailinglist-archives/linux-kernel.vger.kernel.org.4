Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC115720A86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjFBUqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjFBUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:46:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298DB1A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685738778; x=1717274778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ue+ESZp616yu2n5D7DC6oECmULAzI1LX+X9KayeVLhI=;
  b=G0Mmtxgd3Zv8tTkycfWEAeaM/MZ8VoiZvnsHGI4yGLyPtKLTAGGoC1yS
   nHGXVOzEVs23Fb9hfbZXC/lu+GN4z/5hizkgaxTfnA5Ag+54fPDrVLzkb
   sVgjYscPz7yBl6fZ/NozmI7p+GXvjm0sDeLgiw4j9YUs0fHLdIo3bSVt5
   /xOjaUiQXbh1eBysbIlNTJFJ1OCBPvyVC+lDb2GrAPwFYjSk/PX4T6xU/
   Goh9vPjBGNdDnNbocwYrP+bN7wdRzqOflE55PHlGzCgxrQcTGZINlRcZ5
   2WkvDV6K0HetiRheIyZXbUE43PxR94VLn4/kqEjtO3eH0oBBANB9GJGK4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="353458242"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="353458242"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 13:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737659314"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="737659314"
Received: from sbalabha-mobl1.amr.corp.intel.com (HELO [10.212.190.110]) ([10.212.190.110])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 13:46:17 -0700
Message-ID: <8f4a024d-a218-c4ed-925c-b74663b7e280@linux.intel.com>
Date:   Fri, 2 Jun 2023 15:46:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/26] ASoC/soundwire: add support for ACE2.x
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, bard.liao@intel.com
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
 <ZHHdSjXwyHvBezkG@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZHHdSjXwyHvBezkG@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/23 05:36, Vinod Koul wrote:
> On 15-05-23, 15:10, Bard Liao wrote:
>> This series uses the abstraction added in past kernel cycles to provide
>> support for the ACE2.x integration. The existing SHIM and Cadence
>> registers are now split in 3 (SHIM, IP, SHIM vendor-specific), with some
>> parts also moved to the HDaudio Extended Multi link structures. Nothing
>> fundamentally different except for the register map.
>>
>> This series only provides the basic mechanisms to expose SoundWire-based
>> DAIs. The PCI parts and DSP management will be contributed later, and the
>> DAI ops are now empty as well.
>>
>> The change is mainly on SoundWire. It would be better to go through
>> SoundWire tree.
> 
> Applied, thanks

Hi Vinod, is there a way you could provide an immutable tag for Mark
Brown, the patch1 in this set is required for my next set of ASoC
LunarLake patches?

"ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake" adds
the SOF_INTEL_ACE_2_0 definition to select different ops for LunarLake.

Thank you
-Pierre
