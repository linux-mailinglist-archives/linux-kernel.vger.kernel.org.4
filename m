Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A4638292
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKYC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:59:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C42A24C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669345109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwkXFvX6Oq+p/GJ7rMt4fJa7bunrObsJ+mAsNtbUvZk=;
        b=EYo0Hj3y4L5yeXp9gHph7pZviO7SM1qpBLACGKKBBmfW94E0Mye8wDgqkGysPAX1WoNxEK
        MZw4aW4niT73e4rCdQZCrWoCwn9Cl/ELAx29gMRVIXWRn8te9jUhnxrzdlZtmi6gdONv6X
        odxP114MGXDvaWOMQAGYdxHpNn7Qh6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-JYg6uBliM3aRFmkwWO1Y-w-1; Thu, 24 Nov 2022 21:58:26 -0500
X-MC-Unique: JYg6uBliM3aRFmkwWO1Y-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D094101A528;
        Fri, 25 Nov 2022 02:58:25 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CDDAFD48;
        Fri, 25 Nov 2022 02:58:24 +0000 (UTC)
Date:   Fri, 25 Nov 2022 10:58:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
Message-ID: <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv>
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> Usually crash_image is defined statically via the crashkernel parameter
> or DT.
> 
> But if the crash kernel is not used, or is smaller than then
> area pre-allocated that memory is wasted.
> 
> Also, if the crash kernel was not defined at bootime, there is no way to
> use the crash kernel.
> 
> Enable runtime allocation of the crash_image if the crash_image is not
> defined statically. Following the same memory allocation/validation path
> that for the reboot kexec kernel.

We don't check if the crashkernel memory region is valid in kernel, but
we do have done the check in kexec-tools utility. Since both kexec_load and
kexec_file_load need go through path of kexec-tools loading, we haven't
got problem with lack of the checking in kernel.

However, even though we want to do the check, doing like below is much
easier and more reasonable.

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..4d1339bd2ccf 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -344,6 +344,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
        dest_image = &kexec_image;
        if (flags & KEXEC_FILE_ON_CRASH) {
+               if (!crash_memory_valid())
+                       return -EINVAL;
                dest_image = &kexec_crash_image;
                if (kexec_crash_image)
                        arch_kexec_unprotect_crashkres();

So, I am wondering if there is an issue encountered if we don't do the
check in kernel.

Thanks
Baoquan

> 
> ---
> 
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kexec.h | 1 +
>  kernel/kexec.c        | 9 +++++----
>  kernel/kexec_core.c   | 5 +++++
>  kernel/kexec_file.c   | 7 ++++---
>  4 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 41a686996aaa..98ca9a32bc8e 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -427,6 +427,7 @@ extern int kexec_load_disabled;
>  extern bool kexec_in_progress;
>  
>  int crash_shrink_memory(unsigned long new_size);
> +bool __crash_memory_valid(void);
>  ssize_t crash_get_memory_size(void);
>  
>  #ifndef arch_kexec_protect_crashkres
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index cb8e6e6f983c..b5c17db25e88 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -28,7 +28,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>  	struct kimage *image;
>  	bool kexec_on_panic = flags & KEXEC_ON_CRASH;
>  
> -	if (kexec_on_panic) {
> +	if (kexec_on_panic && __crash_memory_valid()) {
>  		/* Verify we have a valid entry point */
>  		if ((entry < phys_to_boot_phys(crashk_res.start)) ||
>  		    (entry > phys_to_boot_phys(crashk_res.end)))
> @@ -44,7 +44,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>  	image->nr_segments = nr_segments;
>  	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
>  
> -	if (kexec_on_panic) {
> +	if (kexec_on_panic && __crash_memory_valid()) {
>  		/* Enable special crash kernel control page alloc policy. */
>  		image->control_page = crashk_res.start;
>  		image->type = KEXEC_TYPE_CRASH;
> @@ -101,7 +101,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  
>  	if (flags & KEXEC_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
> -		if (kexec_crash_image)
> +		if (kexec_crash_image && __crash_memory_valid())
>  			arch_kexec_unprotect_crashkres();
>  	} else {
>  		dest_image = &kexec_image;
> @@ -157,7 +157,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  	image = xchg(dest_image, image);
>  
>  out:
> -	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
> +	if ((flags & KEXEC_ON_CRASH) && kexec_crash_image &&
> +	    __crash_memory_valid())
>  		arch_kexec_protect_crashkres();
>  
>  	kimage_free(image);
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index ca2743f9c634..77083c9760fb 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1004,6 +1004,11 @@ void crash_kexec(struct pt_regs *regs)
>  	}
>  }
>  
> +bool __crash_memory_valid(void)
> +{
> +	return crashk_res.end != crashk_res.start;
> +}
> +
>  ssize_t crash_get_memory_size(void)
>  {
>  	ssize_t size = 0;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 45637511e0de..0671f4f370ff 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -280,7 +280,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>  
>  	image->file_mode = 1;
>  
> -	if (kexec_on_panic) {
> +	if (kexec_on_panic && __crash_memory_valid()) {
>  		/* Enable special crash kernel control page alloc policy. */
>  		image->control_page = crashk_res.start;
>  		image->type = KEXEC_TYPE_CRASH;
> @@ -345,7 +345,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	dest_image = &kexec_image;
>  	if (flags & KEXEC_FILE_ON_CRASH) {
>  		dest_image = &kexec_crash_image;
> -		if (kexec_crash_image)
> +		if (kexec_crash_image && __crash_memory_valid())
>  			arch_kexec_unprotect_crashkres();
>  	}
>  
> @@ -408,7 +408,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  exchange:
>  	image = xchg(dest_image, image);
>  out:
> -	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
> +	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image &&
> +	    __crash_memory_valid())
>  		arch_kexec_protect_crashkres();
>  
>  	kexec_unlock();
> 
> ---
> base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> change-id: 20221124-kexec-noalloc-3cab3cbe000f
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
> 

