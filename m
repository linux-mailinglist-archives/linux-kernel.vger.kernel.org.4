Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C446C1DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjCTRWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjCTRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:21:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FDC16A45;
        Mon, 20 Mar 2023 10:17:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC28DAD7;
        Mon, 20 Mar 2023 10:11:31 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB363F67D;
        Mon, 20 Mar 2023 10:10:42 -0700 (PDT)
Message-ID: <f4808265-f136-631e-0220-9019e64ee9d3@arm.com>
Date:   Mon, 20 Mar 2023 17:10:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-GB
To:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 02/03/2023 20:24, Babu Moger wrote:
> When a user creates a control or monitor group, the CLOSID or RMID
> are not visible to the user. These are architecturally defined entities.

On x86. Any other architecture is going to have a hard time supporting this.


> There is no harm in displaying these in resctrl groups. Sometimes it
> can help to debug the issues.

By comparing it with what? Unless user-space can see into the hardware, resctrl is the
only gateway to this stuff. What difference does the allocated value here make?

Could you elaborate on what issues this can help debug?


> Add CLOSID and RMID to the control/monitor groups display in resctrl
> interface.
> 
> $cat /sys/fs/resctrl/clos1/closid
> 1
> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
> 3

Er. Please don't expose this to user-space!
MPAM has no equivalent value to RMID, so whatever this is for, can't work on MPAM.


Where I have needed this value for MPAM is to pass the closid/rmid to another kernel
interface. Because the user-space interface needs to be architecture agnostic, I proposed
it as a u64 called 'id' that each architecture can encode/decode as appropriate. [0]

To prevent user-space trying to base anything on the raw closid/rmid values, I went as far
as obfuscating them with a random value picked at boot, to ensure scripts always read the
current value when passing the control/monitor group.


I'm curious what the raw value is useful for.


Thanks,

James

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.2&id=d568cf2ba58b7c4970ce41a8d4d6224e285a177e




