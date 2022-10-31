Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DC614002
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJaVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJaVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:37:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FB5F1A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667252265; x=1698788265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bT1ZHzPAmCY1VbJpQlzoC0A90+/Ze4kRcju77Jn9EGg=;
  b=X6898FvRODSs0WbMmMuZrU8is9NMLeWHv4Ix4xw8PvUO8ajp/QwBQulY
   i/s5s9d1Ac4X1VIRRZNVNH7yAVUTrsC0229mv/T7TFBc3+KPOUqhY0HOJ
   K9EXQfWeugRzr9z/2sYgcF+L3us16vAnQvkP+bExDU1pXiIkkLpCNukYz
   FprbzGHwFQKtzwAnoFoDutXb36rYJ8Un/DoQoOqmtLQphCUlzOjOnCxn8
   5Teak6wgh3ttfKcED0flmT1l16JPHjQ50kxSPs92JMZUyJdB8Rbw5jEjO
   3YI/j6lxs1KFnf4uTJg4YdjdJyFGYku+FPItyU5id6J3TkiHe3grcPQlZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310707483"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310707483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:37:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="611635248"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="611635248"
Received: from jfbondi-mobl1.amr.corp.intel.com (HELO [10.212.163.129]) ([10.212.163.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 14:37:44 -0700
Message-ID: <429982ba-e06f-e76b-061c-39db67558aa5@intel.com>
Date:   Mon, 31 Oct 2022 14:37:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] selftests/x86: add "ffff8" -- kernel memory scanner
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <Y1wunXB2iv0QHr22@p183>
 <84E9CFF2-760D-4A5D-9B19-11CA804E1FE8@zytor.com> <Y11h+mbtSEEwHKRZ@p183>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y11h+mbtSEEwHKRZ@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 10:25, Alexey Dobriyan wrote:
> 
> 	$ ./ffff8_64 -h
> 	usage: ./ffff8_64 [-f] [-r] [-n N] [-s S]
> 	        -f: sequential scan
> 	        -r: random scan (default)
> 	        -n: use N threads (default: $(nproc))
> 	        -s: lowest address shift (default: 47)
> 	        -t: time to run (default: 256 seconds)

Does this mean that if someone is just running all kernel selftests,
they need to wait for 256 seconds for this to finish?
