Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8A74F227
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjGKOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjGKOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:24:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D92685
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689085436; x=1720621436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MlVxLB7cT+66uLix8uO9oPPtmypFkWagncIiqBtwJ2c=;
  b=VcbM9J3gygVlLcp89zPyefAQEdmgSmOhVrCcL+zzQtMAMMKMBX2pAWE7
   +SIpbk9689Yqd95E1L5VO5S/tD43p9Plm1GobjqR+KuvKn6GCMpRA1v+V
   T2be/So8oVqM2+bCNTjVzyG2dojinr0r6ixyRg7OhjV7Uw632HmDrvV8b
   VsQixokfyBnGeyfIQoQTAiTpkAwVeHsHqZ4EJ7ZULvzn+AckCpbDOCitb
   i+pWR6Miqhuic74/KjLzbWbaoys7MtPCExwSRJJTc0HF5r0S2hggmRy5z
   I5McDalySfp2MV+oUv35ilRov2vVLjjYKiqUC0uJihNVLSKwLNv6mSVRu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430719964"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="430719964"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="967821269"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="967821269"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.94.41]) ([10.209.94.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:22:43 -0700
Message-ID: <6b32971b-cb3e-fb01-07b1-5bcedbb35eea@linux.intel.com>
Date:   Tue, 11 Jul 2023 07:22:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
To:     Bruno Goncalves <bgoncalv@redhat.com>, rafael.j.wysocki@intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
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

On 7/11/2023 2:11 AM, Bruno Goncalves wrote:
> Hello Arjan and Rafael,
> 
> I'm not sure if you are the right person to contact about this, but
> we've noticed the following call trace when booting on KVM machines
> using kernel 6.5.0-rc1:
> 
ok I'll take a look
