Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731D63AE49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiK1RBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiK1RBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5678C2673
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669654814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NME0TFQassPLZ6q9eoRbrinyHRx5W6+wC31wvAX9gRQ=;
        b=Y6kN/52txccHjNZRzeLBnyhZRR9YmzB5pE/j9/tvYhUiLJqGOLm+yp+XjJocdH1NnTVMcY
        ZJNO/y8ThHmZ2mJZ9IXO1COlV0EKWGLPlwM8Ea5eIhhBpHkOmcyi34T3tHOgx/PQJCaacw
        giH6b4DWp4GJVz4nh2DsTJA/n9ATsoE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-iyQyau1CPS6ZeD0vzcZlrg-1; Mon, 28 Nov 2022 12:00:10 -0500
X-MC-Unique: iyQyau1CPS6ZeD0vzcZlrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B73629ABA1A;
        Mon, 28 Nov 2022 17:00:10 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.195.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E33652166B2E;
        Mon, 28 Nov 2022 17:00:07 +0000 (UTC)
Date:   Mon, 28 Nov 2022 18:00:03 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
Message-ID: <20221128180003.49747650@rotkaeppchen>
In-Reply-To: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu, 24 Nov 2022 23:23:36 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

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
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I don't think this patch will work as intended. For one you omit
setting the image->type to KEXEC_TYPE_CRASH. But when you grep for that
type you will find that there is a lot of special handling done for it.
I don't believe that this can simply be skipped without causing
problems.

Furthermore I think you have missed one important detail. The memory
reserved for the crash kernel is not just a buffer for the image but
the memory it runs in! For that it has to be a continuous piece of
physical memory with usually some additional arch specific limitations.
When allocated dynamically all those limitations need to be considered.
But a standard kexec doesn't care about those limitations as it doesn't
care about the os running before itself. It can simply overwrite the
memory when booting. But if the crash kernel does the same it will
corrupt the dump it is supposed to generate.

Thanks
Philipp

> ---
> kexec: Enable runtime allocation of crash_image
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

