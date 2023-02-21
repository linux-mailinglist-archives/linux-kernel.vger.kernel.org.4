Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C088169E554
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjBUQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjBUQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:58:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D21EBF2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998734; x=1708534734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iNxcRpw3Aa3BSYJT+x7q59TeKiNbc5wL89PaUfpKUrE=;
  b=UqsNoMqc/+DxomCk1lx+eU1hA4B00fbCKGIkZRp6owEnSk01+DWER4zw
   hbQr9+Al1ctN9OaKvhTC5cgnUoLHEsscuOp7SQ0kSGyOOzLnxzjo3W4Dc
   4/WTBMFU8shEN9Tm97hLPVYEzvYd0ZsOLlDM2eM5FQ+NKk8FUNKuTky5j
   GwPo/5Q3smBvEQ81U683NJcka0OZ1mm4LDy5Xtc+T87PXFa+Uqdcao1Cq
   T0H14OoQvaemRyfKRtF4WZ0JrfioVroZP9kkV+Pgcvv0G+jCDEXtsQRaS
   cqPVYA0FjmRm0kcrW/6P07CBfNK7SLbjkheeUknjDUrYtpz5UJ915oCbV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884671"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884671"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569107"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569107"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:37 -0800
Message-ID: <bc6aa297-0276-9e84-c775-7fe735ddaafa@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:05:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V3 5/8] soundwire: amd: add SoundWire manager interrupt
 handling
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
 <20230220100418.76754-6-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230220100418.76754-6-Vijendar.Mukunda@amd.com>
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


> +static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
> +{
> +	u64 response;
> +
> +	mutex_lock(&amd_manager->bus.msg_lock);
> +	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
> +	mutex_unlock(&amd_manager->bus.msg_lock);
> +	amd_sdw_process_ping_status(response, amd_manager);

do you have a case where a new command could be sent after the
mutex_unlock(), which could change the response fields?

In other words, should the last amd_sdw_process_ping_status() function
be protected as well?

> +}
