Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2E6F9EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjEHFOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHFOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A56E82
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683522825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PqZQK3QfhlPN4uIEbn/A5TFDuRAUXf6WUrZ0TZoXUho=;
        b=ZRz6W+vp72Q89sOzMLfVLeIynKiH9yHa94SWBYLNQRn0n742/TqLih1ywcdAML/Kho4r4U
        QJuq0czHP2DkHpFnM8DMhJ8y+gb8cUnAbpU5pApooFVDuPaS2Vr2hJQh878ifVSaTKLvfZ
        zs15Wopih1FfPva+qXrUfM1hyOWOwt8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-k-7Bb2lfNRmvx1_jf7eV9g-1; Mon, 08 May 2023 01:13:40 -0400
X-MC-Unique: k-7Bb2lfNRmvx1_jf7eV9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 908E73806627;
        Mon,  8 May 2023 05:13:39 +0000 (UTC)
Received: from localhost (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC3140C2063;
        Mon,  8 May 2023 05:13:38 +0000 (UTC)
Date:   Mon, 8 May 2023 13:13:33 +0800
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
Subject: Re: [PATCH v22 6/8] crash: hotplug support for kexec_load()
Message-ID: <ZFiE/TXDtrt/y73w@MiWiFi-R3L-srv>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-7-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503224145.7405-7-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/23 at 06:41pm, Eric DeVolder wrote:
> The hotplug support for kexec_load() requires coordination with
> userspace, and therefore a little extra help from the kernel to
> facilitate the coordination.
> 
> In the absence of the solution contained within this particular
> patch, if a kdump capture kernel is loaded via kexec_load() syscall,
> then the crash hotplug logic would find the segment containing the
> elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While
> generally speaking that is the desired behavior and outcome, a
> problem arises from the fact that if the kdump image includes a
> purgatory that performs a digest checksum, then that check would
> fail (because the elfcorehdr was changed), and the capture kernel
> would fail to boot and no kdump occur.
> 
> Therefore, what is needed is for the userspace kexec-tools to
> indicate to the kernel whether or not the supplied kdump image/
> elfcorehdr can be modified (because the kexec-tools excludes the
> elfcorehdr from the digest, and sizes the elfcorehdr memory buffer
> appropriately).
> 
> To solve these problems, this patch introduces:
>  - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is
>    safe for the kernel to modify the elfcorehdr (because kexec-tools
>    has excluded the elfcorehdr from the digest).
>  - the /sys/kernel/crash_elfcorehdr_size node to communicate to
>    kexec-tools what the preferred size of the elfcorehdr memory buffer
>    should be in order to accommodate hotplug changes.
>  - The sysfs crash_hotplug nodes (ie.
>    /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynamic in
>    that they examine kexec_file_load() vs kexec_load(), and when
>    kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in effect.
>    This is critical so that the udev rule processing of crash_hotplug
>    indicates correctly (ie. the userspace unload-then-load of the
>    kdump of the kdump image can be skipped, or not).
> 
> With this patch in place, I believe the following statements to be true
> (with local testing to verify):
> 
>  - For systems which have these kernel changes in place, but not the
>    corresponding changes to the crash hot plug udev rules and
>    kexec-tools, (ie "older" systems) those systems will continue to
>    unload-then-load the kdump image, as has always been done. The
>    kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.
>  - For systems which have these kernel changes in place and the proposed
>    udev rule changes in place, but not the kexec-tools changes in place:
>     - the use of kexec_load() will not set KEXEC_UPDATE_ELFCOREHDR and
>       so the unload-then-reload of kdump image will occur (the sysfs
>       crash_hotplug nodes will show 0).
>     - the use of kexec_file_load() will permit sysfs crash_hotplug nodes
>       to show 1, and the kernel will modify the elfcorehdr directly. And
>       with the udev changes in place, the unload-then-load will not occur!
>  - For systems which have these kernel changes as well as the udev and
>    kexec-tools changes in place, then the user/admin has full authority
>    over the enablement and support of crash hotplug support, whether via
>    kexec_file_load() or kexec_load().
> 
> Said differently, as kexec_load() was/is widely in use, these changes
> permit it to continue to be used as-is (retaining the current unload-then-
> reload behavior) until such time as the udev and kexec-tools changes can
> be rolled out as well.
> 
> I've intentionally kept the changes related to userspace coordination
> for kexec_load() separate as this need was identified late; the
> rest of this series has been generally reviewed and accepted. Once
> this support has been vetted, I can refactor if needed.
> 
> Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

