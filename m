Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119774F814
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGKSj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:39:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480A10F0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689100794; x=1720636794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sr+q7kREOsvEHdKMRmSLzudDF5U0JVqTcePFn2xqwHA=;
  b=Y0OL0EQlOztuggXr+LY7bfWGOPS4D1Nhjke2Impev1mJa/nVkv1D3P4X
   VE51NJhz+JyRzuMnOXnb+0Hb3DvcLzm7oPT9jqppmMJiZgLnBED5lOcvv
   /0/lPSM7xrgiO8QtfNAo2PlE6fEUYjbXIyKNGKfR8+C3f7NMuVi7ZjAPL
   MyN1XO153yBsNoPQ0F3HxZ6BbYo9XvEFlxEWq7tv/2VHskgs8U5KDURrq
   uA8t+EKH/J7X8tlFxSgsS5bKE4xmsn11y/USW+1rNTKOv+DjfSeBIFmS6
   rkpWA/ojCVCNbjByUJL5C8GMWiZtqMKWkM69QAsLT0g7pxUBHkkyS7TKb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="345017861"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="345017861"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 11:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715266628"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="715266628"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.94.41]) ([10.209.94.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 11:39:53 -0700
Message-ID: <b672c500-5f2f-d60c-84da-80269b8b420f@linux.intel.com>
Date:   Tue, 11 Jul 2023 11:39:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Content-Language: en-US
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
 <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On
> I think you mean "revert"?
> 
> That can be done, but maybe it can be fixed instead?

this specific issue I will fix shortly (together with the RDMSR thing)

