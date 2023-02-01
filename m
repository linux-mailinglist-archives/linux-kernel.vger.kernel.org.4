Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ECB686F01
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBATfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBATfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:35:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A17C736;
        Wed,  1 Feb 2023 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675280150; x=1706816150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Obl8rqfTGH6trUZEs37Lq7tRxm2qrcEOy/7J7nsiCE=;
  b=Zu2In3ZoEL4VyT8aqMTSXGE4kthLT8jWKWExC5FXFwQAlAjeygGbALgi
   ZZPvSXbonUPa8ysl+GQ4JLNCMzX8obrAYqghRNMgmYXtzu2VXybdkBlcc
   r7gmmqx/LiqDHa+daJUa315MmI59Gt8I/HimW67EOJz+COvP/bxZ863IZ
   jV5raNiiaxPSZFtPfeCrm/SAPbIzCqDlmYGTS1bJSXNMUjxz+SZo1enHU
   Tw8XJaIVrFmkWMJTiJJGhumhXQm8WXf/LKo+0kD+9zWjcDkxIDRycYFCw
   UHg6OQj2RKSsLefbLzRGJb75mSsPfzqKWlGP8OHRh43NI8nSvjnVVJxzD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390643899"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="390643899"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:35:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="838892059"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="838892059"
Received: from sgkhacha-mobl1.amr.corp.intel.com (HELO [10.212.227.86]) ([10.212.227.86])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:35:48 -0800
Message-ID: <aedc760b-ca4d-031d-6797-4f0a1ab2d5d7@intel.com>
Date:   Wed, 1 Feb 2023 11:35:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230131234302.3997223-5-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 15:43, Jithu Joseph wrote:
> +union ifs_array {
> +	u64	data;
> +	struct {
> +		u32	array_bitmask		:32;
> +		u32	array_bank		:16;
> +		u32	rsvd			:15;
> +		u32	ctrl_result		:1;
> +	};
> +};

Why bother with a bitfield?  Just do:

union ifs_array {
	u64	data;
	struct {
		u32	array_bitmask;
		u16	array_bank;
		u16	flags;
	};
};

Then you only need to mask 'ctrl_result' out of flags.  You don't need
any crazy macros.
