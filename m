Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1C6A9EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjCCSdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjCCSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:33:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6024A83FE;
        Fri,  3 Mar 2023 10:33:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43E1F143D;
        Fri,  3 Mar 2023 10:33:54 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52FBC3F93E;
        Fri,  3 Mar 2023 10:33:08 -0800 (PST)
Message-ID: <f0841866-315b-4727-0a6c-ec60d22ca29c@arm.com>
Date:   Fri, 3 Mar 2023 18:32:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/7] x86/resctrl: Add a new "snc_ways" file to the
 monitoring info directory.
Content-Language: en-GB
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-6-tony.luck@intel.com>
 <a95d0200-da28-4fbe-2bfe-ff948b4c2801@arm.com>
 <SJ1PR11MB60837DC9C2E04AD3CBF3CA67FCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <SJ1PR11MB60837DC9C2E04AD3CBF3CA67FCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 28/02/2023 17:44, Luck, Tony wrote:
>>> Make it easy for the user to tell if Sub-NUMA Cluster is enabled by
>>> providing an info/ file.
>>
>> I think what this is conveying to user-space is 'domain_id_is_numa_node'.
> 
> That seems more architecturally neutral. I like it.
> 
>> Does user-space need to know the number of ways?
> 
> I don't know. Maybe some might. Perhaps there is some better name that
> is architecturally neutral, but still has a numerical rather than boolean value?

If we don't know what user-space needs this for, I'd prefer we don't expose it. It'll be a
problem in the future if there is no single number we can put there.

I don't see what the difference between 2 and 4 would be used for when setting up resctrl,
unless you are choosing which numa-nodes to spread tasks over ... but the numa distance
would be a much better number to base that decision on.

User-space is able to perform the same calculation to find the snc_ways using the
cache/index stuff and node entries in sysfs.


>> Will this always be a single number, or will it ever be possible to have an SNC=2 and
>> SNC=1 package in the same system?
> 
> I sincerely hope that it is the same value across the system. Currently the
> BIOS setup option to enable SNC doesn't have per-socket choices, it is
> just an all-or-nothing choice. "2" isn't the only choice for number of SNC
> nodes on a socket. "4" is (or will be) a choice.

Yeah, in the arm world, partners get to make the decision on what is sane. Big-little
means someone could do something that looks like SNC in on cluster, but not another.

If we don't know what user-space needs it for, I'd prefer we don't expose it, just to
avoid giving out rope to shoot ourselves in the foot with.


Thanks,

James
