Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8C86BA7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCOGg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCOGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:36:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF03BDB1;
        Tue, 14 Mar 2023 23:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C808B81BFD;
        Wed, 15 Mar 2023 06:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629D8C433D2;
        Wed, 15 Mar 2023 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678862182;
        bh=WwlkMPoTr7BtqZZplFY4E95heUdFj/Fz74AR3mmmC24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awdNmW6vLrlHNIdqn6ZpKdZBFl+/GcVjIdYiv8bUK8bqTRrNhNSLS5qwf4knQZKQ0
         5HOj7lCJ+tHjZb6SfCByVxMDK7aS8G6r3X1RXRgMs13b+o1dLxavlUfZQdRerHXYTK
         ZQnOEnJwo8lnV+6gtdEBVcgfHp2wEOvZfYWVTI7M=
Date:   Wed, 15 Mar 2023 07:36:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Seymour, Shane M" <shane.seymour@hpe.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH for-next] scsi: Implement host state statistics
Message-ID: <ZBFnYwtr+2bfjvcY@kroah.com>
References: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1373DCD07EABD28D88129C50FDBF9@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:08:19AM +0000, Seymour, Shane M wrote:
> The following patch implements host state statistics via sysfs. The intent
> is to allow user space to see the state changes and be able to report when
> a host changes state. The files do not separate out the time spent into
> each state but only into three:

Why does userspace care about these things at all?  What tool needs them
and what can userspace do with the information?

> 
> $ ll /sys/class/scsi_host/host0/stats
> total 0
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_first_change_time
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_last_change_time
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_other_count
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_other_ns
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_recovery_count
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_recovery_ns
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_running_count
> -r--r--r--. 1 root root 4096 Mar 13 22:43 state_running_ns
> 
> They are running, recovery and other. The running state is SHOST_CREATED
> and SHOST_RUNNING. The recovery state is SHOST_RECOVERY,
> SHOST_CANCEL_RECOVERY, and SHOST_DEL_RECOVERY. Any other state gets
> accounted for in other.
> 
> The current state is not accounted for in the information read. Because
> of that you must read:
> 
> 1. The last_change_time for that host
> 2. the current state of a host and the uptime
> 3. each of the above *count and *ns files
> 4. Re-read the last_change_time
> 5. Compare the two last_change_time values read and if different try again.
> 6. The total time read from the *ns files is subtracted from the uptime and
>    that time is then allocated to the current state time.
> 
> The first change time is to determine when the host was created so programs
> can determine if it was newly created or not.
> 
> A (GPLv2) program called hostmond will be released in a few months that
> will monitor these interfaces and report (local host only via syslog(3C))
> when hosts change state.

We kind of need to see this before the kernel changes can be accepted
for obvious reasons, what is preventing that from happening now?

> +static ssize_t state_first_change_time_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lld",
> +		ktime_to_ns(shost->stats->state_first_change_time));

Please always use sysfs_emit() instead of the crazy scnprintf() for
sysfs entries.

> +struct scsi_host_stats {
> +	ktime_t state_running_ns;
> +	ktime_t state_recovery_ns;
> +	ktime_t state_other_ns;
> +	ktime_t state_first_change_time;
> +	ktime_t state_last_change_time;
> +	uint32_t state_running_count;
> +	uint32_t state_recovery_count;
> +	uint32_t state_other_count;

u32 is a kernel type, not uint32_t please, but I don't know what the
scsi layer is used to.

thanks,

greg k-h
