Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD38678D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjAXBEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAXBEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:04:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BA37571;
        Mon, 23 Jan 2023 17:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674522279; x=1706058279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aMviCDSGaCW3l39VquuZe87DPlMX3jx/HG+Zzl5cpWc=;
  b=jRsDxnISHjBbbTxRckAfot4zaOXBHOWMrsEV5RFz48kGBSd3s4wrQ78Y
   z7JboYNWL3VRBUksDUj8jRPJ5DIZrZTVCdT9YpDQw6d3R9HmtuOnyfcWf
   EftFOLR148SeTp9ZFykmqxUXR8m7knOm/DrFz0PyfMWbWWLcpGUr5MiqM
   juDzsy2O3PhgM2g7E1kMSAG42MxtidPkBU7yxERMKM1nAMhXp1wWpeZmU
   m6jtuRgdYgFnFtI+ok/WUvPDdK15zTWZRwG7oU9WfdwodUjK78z19Oovq
   ZRqKuBEgqPHBQRevuCSeG6BbdsAW5XqZnSTgaZtWaVfy2kzTLsQiI6ELO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314103901"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="314103901"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:04:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="990690966"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="990690966"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.255.230.108]) ([10.255.230.108])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:04:37 -0800
Message-ID: <67facb87-f835-abcd-3d1b-527531b26e52@linux.intel.com>
Date:   Mon, 23 Jan 2023 17:04:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host
 PMUs)
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20230120004051.2043777-1-seanjc@google.com>
 <1dec071d-c010-cd89-9e58-d643e71e775c@linux.intel.com>
 <Y8rQJf3ki8a1aRjW@google.com>
 <50e840ea-ce9c-9290-2187-d3ff0d9a6709@linux.intel.com>
 <Y8r604tRexxWlF8F@google.com>
 <e161b7c0-f0be-23c8-9a25-002260c2a085@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <e161b7c0-f0be-23c8-9a25-002260c2a085@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If I understand correct, the workaround in KVM is to add a white/black
> list to filter the events. I think we can do the same thing for the
> hybrid machine for now.
> https://lore.kernel.org/lkml/CAOyeoRUUK+T_71J=+zcToyL93LkpARpsuWSfZS7jbJq=wd1rQg@mail.gmail.com/


This will make everyone who actually wants to use the PMU sad.

It's reasonable if the vCPUs are not bound, but if they are bound it 
would be better to expose it with a suitable CPUID for the types.


-Andi



