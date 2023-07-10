Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2A74CD64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjGJGnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGJGnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:43:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE3A6;
        Sun,  9 Jul 2023 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688971412; x=1720507412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4XYMBsnYy1GuZNBmxJF2HlXlwLl0eQJul6n7IcmqelI=;
  b=IIdrkboCoz7KpdXlQDjgQxJeyaw+JFxhcw2GOh4fIgsx7yR6zheAXLBI
   JJCJ0wkqUNAlPzwPfrpYJb6AmRHweXLWJZzpYkqUZ58f0cw4I/+PwIopf
   PkpZpFAy9a6fb23JXFzugvjtvqBUMHvuoVRfAVVKT64Q6+bFzh5OGWWos
   cEsxJMUbNJSl5f0X4Kd3XhaZctDYxOrfJkHTGLFX5ul+F7Hika9YR6sP1
   WiYyoUf5QO8+wmVamSlOVc1vQS5r51DxzHTACr9azj3St7V3xwUC1T83B
   yMyh/kovenKdzme6BCTDX7WzhwuwG2B7lCWU4m+Iw+zB312s9Ilron14x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="354127717"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354127717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844779133"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="844779133"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:43:29 -0700
Message-ID: <bf137a7a-9081-71ac-340f-8da09d9e63be@intel.com>
Date:   Mon, 10 Jul 2023 09:43:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V8 02/23] mmc: core: Prepare to support SD UHS-II cards
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-3-victorshihgli@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230621100151.6329-3-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/23 13:01, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Updates in V7:
>  - Drop sd_uhs2_set_ios function.
>  - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up().
>  - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off().
>  - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
>  - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.

This patch does not compile because it depends on definitions
that are in patch 5.

