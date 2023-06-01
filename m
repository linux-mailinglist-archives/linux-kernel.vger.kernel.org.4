Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A871EFBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjFAQxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFAQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:52:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEFF193
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638344; x=1717174344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bhdAFTRphoPxW/9JmfSMKhCJWRqyEDl5R+kjnpRDSLg=;
  b=f+dGGenkUqJZzX9acqoYCBWYOdP5jn7LXiNigdJjmuuvdmn6jFTyouxr
   uoeRU6LbIURlEXCQUiUG4JXqxYwdId1gtSsfEi76Yx/otRGw/vMcmLB3P
   FcYTpNz2+yrmUoXkcok7JPMBNmmkA0xNAAJOvpXXai0/75yIDqkFKMeVD
   2mnmHvse68XmhLFHSLUSD1I3tAgFrRukEl+vi6OjR4+UsBZxM+CitCDt3
   r2tokRg44RBw7ngowuCKRUA3X2ujEuhxfBGGh99Q/cuvRm2bSlc04NIEn
   MPC8wrv/2+YJIhvM2y7QniO9KSpuegoJDTw2jCJQNGW6JEgg1CnW3b40o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421426897"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421426897"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777283287"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777283287"
Received: from rcelisco-mobl.amr.corp.intel.com (HELO [10.212.207.82]) ([10.212.207.82])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:57 -0700
Message-ID: <9bcc7daa-744d-a092-91fa-07c0c869b386@linux.intel.com>
Date:   Thu, 1 Jun 2023 11:43:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] soundwire: stream: Add missing clear of
 alloc_slave_rt
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/23 11:16, Charles Keepax wrote:
> The current path that skips allocating the slave runtime does not clear
> the alloc_slave_rt flag, this is clearly incorrect. Add the missing
> clear, so the runtime won't be erroneously cleaned up.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Sounds about right, thanks

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/stream.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index c2191c07442b0..379228f221869 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -2021,8 +2021,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  
>  skip_alloc_master_rt:
>  	s_rt = sdw_slave_rt_find(slave, stream);
> -	if (s_rt)
> +	if (s_rt) {
> +		alloc_slave_rt = false;
>  		goto skip_alloc_slave_rt;
> +	}
>  
>  	s_rt = sdw_slave_rt_alloc(slave, m_rt);
>  	if (!s_rt) {
