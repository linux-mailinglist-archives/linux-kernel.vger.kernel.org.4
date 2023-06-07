Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003117269E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFGTg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjFGTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:36:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A71FE9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686166615; x=1717702615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x+skSBPrzW35DB4zAJxA+se5YgpqYrdSbeYBbYzMRfQ=;
  b=alaaKD7Kr4A8GkxuEQILPOekPb8xX1goMd0amH+A6cn3ZJCiTVGgd1G7
   7nWbW47cBqW2ad1umcrk7oExLc/kp0RuHRdibq26N18szYzBw01m2BbLv
   GFrPc5oKv/5JhhQYRqL9OrWDBp+VGExVelbvQM7N6rJeqCf3sG5MprAI5
   24Xxoj95GycKMwzjaMXu5ItG2NcMlbb11tJIPVnDOwH6W8BYc5EnLc7su
   lja5ndYWsW1G++Q9UzJv+qA/gZG7+kbx0XsG3rIMddqMM3vhHQlhXib9a
   GfJ1TT3Vr1m7Rpp1c82fhm+oEJywg6KE2jX7DV0qtKRnFq1u1M7TRhT79
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="420649262"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="420649262"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854035279"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="854035279"
Received: from vsmyers-mobl2.amr.corp.intel.com (HELO [10.212.146.233]) ([10.212.146.233])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 12:36:53 -0700
Message-ID: <d3be3b2b-7c58-36eb-cd25-acea494e608d@intel.com>
Date:   Wed, 7 Jun 2023 12:36:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@kernel.org
References: <20230605141332.25948-1-bp@alien8.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230605141332.25948-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 07:13, Borislav Petkov wrote:
> Do the same as early loading - load on both threads.

Hey Boris,

What's the benefit of doing the loading on both threads?  I would have
naively thought it was just wasted work.

I think I even have a back-burnered Intel patch around somewhere that
ensures that we *never* load on both threads.
