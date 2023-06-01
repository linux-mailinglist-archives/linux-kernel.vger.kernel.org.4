Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714B71EFF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFAQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjFAQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:59:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243371A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638763; x=1717174763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQr060zH9KUjmdwUDYfSZFTdHmf4ecv0Iqn3RGTCXWg=;
  b=VZOdg6G21va8CnPEd5jW7m/5legCr0sWi20UOSTib1SIOBoqYC35mqnO
   13bxOjhrTaFbBLfgBxGH/e7Z2yd8bylcLDKt637UCjqAU/ROQWRoFotca
   0eo3blqAc2bErafEDWyNl8HPzQ5rX7ZqVi0/7KPo3ZdqdtWywwoxafrT4
   EySFXbRD/eRDrgFtbiNcvfQ57LKuZ3gVXK5oRNgb3kp/NsVlt+IMrDDC0
   D6Lq1FRItK4La2w4xU4a4fqFVpk9XzG+KpFRF88ZxvmJN0GL5JRYLlwnu
   1oVOlopjJpKzxXUpy2C6dsQP6onyVuWpfj2x0SJvu5o3Hhje4PfvPncgv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340238074"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="340238074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737182158"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="737182158"
Received: from jdboswor-mobl.amr.corp.intel.com (HELO [10.212.227.45]) ([10.212.227.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:58:36 -0700
Message-ID: <b8b118ef-d250-f331-fd8f-9853bf72d102@intel.com>
Date:   Thu, 1 Jun 2023 09:58:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/csum: Move csum_tail result parameter to a local
 variable.
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        ndesaulniers@google.com, goldstein.w.n@gmail.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230530135953.3341174-1-trix@redhat.com>
 <20230530152016.GA3503416@dev-arch.thelio-3990X>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230530152016.GA3503416@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 08:20, Nathan Chancellor wrote:
> Dave picked it up yesterday, I guess -tip's auto-latest was not
> refreshed for today's -next:
> 
> https://git.kernel.org/tip/2fe1e67e6987b6f05329740da79c8150a2205b0d

BTW, thank you _both_ for the patches!
