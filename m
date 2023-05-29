Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A7271490E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjE2MGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjE2MF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:05:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C488F1;
        Mon, 29 May 2023 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685361954; x=1716897954;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=24kaNhoDDh2Sg/pbrar8VavciZH3DS7NRvSWVRs1f7I=;
  b=l0Mkn2rV3d29TzhW4s0rkca0ex+0UkX+Qs049YzoOgDMnlT/41t7+9OQ
   b+YLPoD3LdAd1+NxsH6ghHKqh5NGYgHlBmE6LeU29a8xIAF2PmT6UKHNl
   0y4jYq/1xfxHF4eDXO1gDLjjVzEQ01HqER2edqAU3+laJDXb7meySodf2
   Zr7+w2hrZfpd2zvkMjDyw1Cz/RPHh3uS82Pm9j6ZNuczyrJh3qbYGUZVk
   dc2H2JA/oFv6YDVGkb0yn9x041iX4ZOX/i3EG9XqtKhxGdSLF0dzDQM5h
   0ukcdC+HzfowvX3Rgdndjtm+qes7M/Kb0bw2fJrJLuZ6FFZStE40g7mhE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="420447840"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="420447840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 05:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="850386659"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="850386659"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 05:05:32 -0700
Date:   Mon, 29 May 2023 15:05:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] platform/x86: think-lmi: Don't display unnecessary
 authentication settings
In-Reply-To: <20230526171658.3886-4-mpearson-lenovo@squebb.ca>
Message-ID: <aeb0313-e845-9134-4136-6347d691bd4@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <20230526171658.3886-4-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023, Mark Pearson wrote:

> If Opcode support is available (which is the standard for all platforms
> going forward) then there is no need to have the encoding and kbdlang
> attributes visible
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2 & v3: None. Version bumped in series
> 
>  drivers/platform/x86/think-lmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 1c02958035ad..64cd453d6e7d 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -879,6 +879,12 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
>  		return 0;
>  	}
>  
> +	/* Don't display un-needed settings if opcode available */
> +	if ((attr == &auth_encoding.attr ||
> +	    attr == &auth_kbdlang.attr) &&

Indentation issue here, attr must be at the same column although putting 
the || on a single line might make this easier to read.

> +	    tlmi_priv.opcode_support)
> +		return 0;
> +
>  	return attr->mode;
>  }
>  
> 

-- 
 i.

