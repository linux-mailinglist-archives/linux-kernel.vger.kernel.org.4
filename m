Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BF67F403
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjA1CfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjA1CfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:35:00 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295D12841
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:34:53 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B283A3F116;
        Sat, 28 Jan 2023 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674873291;
        bh=p0MVPSCR+Nwm3g+JfA+sZRpCUs4LHkTwQYrFz1Oisew=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=O5gjYNCeUUh/fplooQkbIInGcImYFOUXlNYzU3fFNYuzN0rQ0ef4BM0cQWOxry6Tu
         rRDKf3xuse/O2tlCz4d9A7gkHrNfY+5NXUAfHcL/q7zaIwWRs2UVFojh17Odn+MNnT
         3S72hY7apUwjF0qSF2yPKvh/TdXIZh0fBdrM6/Zt696U26i7TIkQ/uvUJGOKV5+EM5
         K7aBJ+0VOW2F1XI6DuLieOmCMuuAPGOYeCA2X0I5fEZx5hbklDXul7dFaFsbvFUmhA
         V/NWZZIpYjt3T/4PPnFvNYzJRhFK3jStmV2z/wuwHFRS+ZfH1ec33QKaEYdZKXoObY
         UrKcU+AZbioQQ==
Message-ID: <4fa85b15-1c55-9050-9cd0-fe66c3b957eb@canonical.com>
Date:   Fri, 27 Jan 2023 18:34:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [linus:master] [apparmor] 1ad22fcc4d: stress-ng.kill.ops_per_sec
 -42.5% regression
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com
References: <202212311546.755a3ed7-oliver.sang@intel.com>
 <42194ba4-cc3b-c8b3-06e6-e2938df3a87c@intel.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <42194ba4-cc3b-c8b3-06e6-e2938df3a87c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 17:37, Yin, Fengwei wrote:
> Hi John,
> 
> On 12/31/2022 3:18 PM, kernel test robot wrote:
>>
>> Greeting,
>>
>> FYI, we noticed a -42.5% regression of stress-ng.kill.ops_per_sec due to commit:
>>
>>
>> commit: 1ad22fcc4d0d2fb2e0f35aed555a86d016d5e590 ("apparmor: rework profile->rules to be a list")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: stress-ng
>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
>> with following parameters:
>>
>> 	nr_threads: 10%
>> 	disk: 1HDD
>> 	testtime: 60s
>> 	fs: ext4
>> 	class: os
>> 	test: kill
>> 	cpufreq_governor: performance
> Do you think any other information need be collected for this regression
> report? Thanks.
> 

no, I know what is causing it, I just haven't had time to fix it yet.

