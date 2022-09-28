Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1A5ED943
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiI1JiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI1Jhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:37:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A38ED5FD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:36:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C851063;
        Wed, 28 Sep 2022 02:35:54 -0700 (PDT)
Received: from [10.57.33.30] (unknown [10.57.33.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DC9C3F792;
        Wed, 28 Sep 2022 02:35:46 -0700 (PDT)
Message-ID: <c3dfa394-6feb-c62f-6591-98b2c06d7029@arm.com>
Date:   Wed, 28 Sep 2022 10:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/7] kernel/cpu: Convert snprintf() to scnprintf()
Content-Language: en-GB
To:     Jules Irenge <jbi.octave@gmail.com>, tglx@linutronix.de
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        ak@linux.intel.com, Jason@zx2c4.com
References: <YzH01+6fErqu2Roo@fedora>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <YzH01+6fErqu2Roo@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 19:52, Jules Irenge wrote:
> Coccinnelle reports a warning
> Warning: Use scnprintf or sprintf
> Adding to that, there has been a slow migration from snprintf to scnprintf.
> This LWN article explains the rationale for this change
> https: //lwn.net/Articles/69419/
> Ie. snprintf() returns what *would* be the resulting length,
> while scnprintf() returns the actual length.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Using sysfs_emit() would be even better in this case, although it's
slightly different because it outputs a maximum of PAGE_SIZE rather than
PAGE_SIZE - 2 bytes. But I can't see any reason for that "- 2" - it
appears to have been added when the sysfs entry was added by Thomas
Gleixner in commit 05736e4ac13c ("cpu/hotplug: Provide knobs to control
SMT") but I don't see any justification for it.

Steve

> ---
>  kernel/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bbad5e375d3b..f358d89c9580 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2512,7 +2512,7 @@ static ssize_t control_show(struct device *dev,
>  {
>  	const char *state = smt_states[cpu_smt_control];
>  
> -	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
> +	return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
>  }
>  
>  static ssize_t control_store(struct device *dev, struct device_attribute *attr,
> @@ -2525,7 +2525,7 @@ static DEVICE_ATTR_RW(control);
>  static ssize_t active_show(struct device *dev,
>  			   struct device_attribute *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
> +	return scnprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
>  }
>  static DEVICE_ATTR_RO(active);
>  

