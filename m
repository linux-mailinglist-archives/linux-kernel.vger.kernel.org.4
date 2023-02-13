Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A269465C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBMMxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjBMMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:52:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2034E449B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:52:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676292771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kt2OK2YUgy+eskKKqGKLmdkLvjzs+zgQaWcCfhotpwU=;
        b=zNus41ARORGE+j8gBIE7+HCsLeoYY24/UX8ZgfuousAFn2ZfI00dzrRknT+bPn/9BHgx40
        0L6yleX8ptxdrzJUDisilt93HRA/MHZJ1M8DEt3VT/SbASd7yhdvhy/6vvPaydCUbRW3Jo
        tUMe4hEM9nzqDh+NvSrEk64TUT2y75VhsNJoTb8ITlxylKLTpGT8r5c75st12amJRRyygR
        q8b5IJ5M+LLx9I8uUqnT6LA5nOGzDNSMaerXbvrmVmUvFGWJdzogrnq9TLkbp0nMIrZBx0
        6WpvYPXcMpBqipnyCNonv8yAE73HpT5hTESf/Kl9ef/LrF5C1LAiwdAap9z+zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676292771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kt2OK2YUgy+eskKKqGKLmdkLvjzs+zgQaWcCfhotpwU=;
        b=SX8v1GdsioisJ0hWeYrj3TpgQwWdojaqpeRg8G+z0RejSrdLoDQjdPGC4yrqQCl7YwPp25
        6iD0WeSTmPOcV0CA==
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
Date:   Mon, 13 Feb 2023 13:52:50 +0100
Message-ID: <87ttzpzpzx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13 2023 at 10:10, Sourabh Jain wrote:
> The sysconf document says _SC_NPROCESSORS_CONF is processors configured, 
> isn't that equivalent to possible CPUs?

glibc tries to evaluate that in the following order:

  1) /sys/devices/system/cpu/cpu*

     That's present CPUs not possible CPUs

  2) /proc/stat

     That's online CPUs

  3) sched_getaffinity()

     That's online CPUs at best. In the worst case it's an affinity mask
     which is set on a process group

Thanks,

        tglx
