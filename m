Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2950F6D94AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjDFLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDFLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6DE0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680779193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSpYEks1T5f1HgeKXvgnDWGtTBs8ltEecfJ6Ag+UgLU=;
        b=WuYmFnb4aaDlLnQAwIrUUhLTR6eEwE4vokKPWLColy+//AUamCCUyxIH4oNx/Uci+7rE3q
        RFuHUBvBYF6SOAXDphESKnKq+tqq7Sg3GBbYbF8T5WJmdP8mqARIVtnbvXONTnePJBCnjr
        ttdxdw44GCTm61OIUGbsKCzfUKuZARM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-jJolPkiZMh25d-WtlECE3g-1; Thu, 06 Apr 2023 07:06:27 -0400
X-MC-Unique: jJolPkiZMh25d-WtlECE3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12FAF3C0ED6C;
        Thu,  6 Apr 2023 11:06:26 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D3171121314;
        Thu,  6 Apr 2023 11:06:23 +0000 (UTC)
Date:   Thu, 6 Apr 2023 19:06:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <ZC6nq13EDIrK1XFe@MiWiFi-R3L-srv>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/23 at 02:03pm, Eric DeVolder wrote:
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.
> 
> The elfcorehdr describes to kdump the CPUs and memory in the system,
> and any inaccuracies can result in a vmcore with missing CPU context
> or memory regions.
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
> elfcorehdr) by the userspace kexec utility. In the original post I
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash handler that registers with
> the CPU and memory notifiers. Upon CPU or memory changes, from either
> hot un/plug or off/onlining, this generic handler is invoked and
> performs important housekeeping, for example obtaining the appropriate
> lock, and then invokes an architecture specific handler to do the
> appropriate elfcorehdr update.
> 
> Note the description in patch 'crash: change crash_prepare_elf64_headers()
> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
> enables further optimizations related to CPU plug/unplug/online/offline
> performance of elfcorehdr updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory; thus no involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>  - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>    Add the following as the first lines to the RHEL udev rule file
>    /usr/lib/udev/rules.d/98-kexec.rules:
> 
>    # The kernel updates the crash elfcorehdr for CPU and memory changes
>    SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>    SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
>    With this changeset applied, the two rules evaluate to false for
>    CPU and memory change events and thus skip the userspace
>    unload-then-reload of kdump.
> 
>  - Change to the kexec_file_load for loading the kdump kernel:
>    Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>     standard_kexec_args="-p -d -s"
>    which adds the -s to select kexec_file_load() syscall.
> 
> This kernel patchset also supports kexec_load() with a modified kexec
> userspace utility. A working changeset to the kexec userspace utility
> is posted to the kexec-tools mailing list here:
> 
>  http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
> 
> To use the kexec-tools patch, apply, build and install kexec-tools,
> then change the kdumpctl's standard_kexec_args to replace the -s with
> --hotplug. The removal of -s reverts to the kexec_load syscall and
> the addition of --hotplug invokes the changes put forth in the
> kexec-tools patch.

Other than the nitpick in patch 2, this series looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

