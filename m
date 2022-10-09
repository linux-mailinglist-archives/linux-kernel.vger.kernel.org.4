Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B05F8D30
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJISfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJISfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98FE18
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665340519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViviYhcQjwhb4JS/uZekyKndNy1/nquIn4ZvXjeihJo=;
        b=iicJjjDOedBRfVK0OFsjfoA/IWCdWv0qMIOyr1Ysd+MmG6gwM1mJzpQdQNcrtpojAjGXYU
        Ub8FEeFEq5G5vgKMqhkb52Mvfq9LAxbLaWRSwGlKIaAVpmNwBON908N/+Uge4aA6BFi6MN
        solmlpGfksNjTpkQgPqmw34XsqO9kl8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-cxfANNzWOr2Qk2RUB056eQ-1; Sun, 09 Oct 2022 14:35:17 -0400
X-MC-Unique: cxfANNzWOr2Qk2RUB056eQ-1
Received: by mail-pg1-f198.google.com with SMTP id b11-20020a630c0b000000b0044c0bb18323so5459894pgl.17
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ViviYhcQjwhb4JS/uZekyKndNy1/nquIn4ZvXjeihJo=;
        b=PZNfu8uICDf0GYa8ZmFRTI1go8CYXKTdHx32A0BQdJUqD1Vu8eReWdEF7bzWX7Q2qa
         AJtbygbGZcgdrB7F4mU5oJcw6ycZDEELshsQbGkK39qfy3cht7ESndK1jmUD0gwhflUD
         PNDZvK7k6MZ7Y/lBH9mOM17d7POj/H55TYkgbODTSW36jWkeiKAhv6GymUp0Kij4m82E
         mHjIOwUNeUwiRMPHHakEwaVtaiYJP5pel6IvxzDo01+cYT5hyYXHkuXOsvKpo95EAUr9
         TBM4E5gAfaws6wNsq/z2l4q1L5na/wk1n57nrFoXWWMJlwTsZ/R4fq/HZ+v1NMqQyFxk
         IeBw==
X-Gm-Message-State: ACrzQf2nNOH5Q09ZqITyzHkxsvr1ELj/qhdVQrk9yxZxIzcY7vFbeyRy
        9CjAjL4iKP8aROH5w2Kk8uMUoQHgBn6uM8qxmo0BoNyUZgjtIaTc6g+EvHr5e4Wi6dCseDsq755
        LwLpzCX70MzrY9hAqeVP6bOVs
X-Received: by 2002:a05:6a00:1a93:b0:563:120c:f612 with SMTP id e19-20020a056a001a9300b00563120cf612mr6862512pfv.10.1665340516817;
        Sun, 09 Oct 2022 11:35:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7TtyRrwRTopk0WYTuBlA7eeTKQVEtipoGg5mh1x6mN6EkXrprxw7cZUMsHQhP7R8PH0c1I9g==
X-Received: by 2002:a05:6a00:1a93:b0:563:120c:f612 with SMTP id e19-20020a056a001a9300b00563120cf612mr6862499pfv.10.1665340516571;
        Sun, 09 Oct 2022 11:35:16 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0017f80305239sm5047547plh.136.2022.10.09.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:35:16 -0700 (PDT)
Date:   Mon, 10 Oct 2022 03:35:03 +0900 (JST)
Message-Id: <20221010.033503.2099269269123366991.syoshida@redhat.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        syoshida@redhat.com,
        syzbot+c512687fff9d22327436@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/gem: Avoid use-after-free on drm_gem_mmap_obj()
 failure
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20220920072408.387105-1-syoshida@redhat.com>
References: <20220920072408.387105-1-syoshida@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Tue, 20 Sep 2022 16:24:08 +0900, Shigeru Yoshida wrote:
> syzbot reported use-after-free for drm_gem_object [1].  This causes
> the call trace like below:
> 
> [   75.327400][ T5723] Call Trace:
> [   75.327611][ T5723]  <TASK>
> [   75.327803][ T5723]  drm_gem_object_handle_put_unlocked+0x11e/0x1a0
> [   75.328209][ T5723]  drm_gem_object_release_handle+0x5d/0x70
> [   75.328568][ T5723]  ? drm_gem_object_handle_put_unlocked+0x1a0/0x1a0
> [   75.328965][ T5723]  idr_for_each+0x99/0x160
> [   75.329253][ T5723]  drm_gem_release+0x20/0x30
> [   75.329544][ T5723]  drm_file_free.part.0+0x269/0x310
> [   75.329867][ T5723]  drm_close_helper.isra.0+0x88/0xa0
> [   75.330305][ T5723]  drm_release+0x8e/0x1a0
> [   75.330674][ T5723]  ? drm_release_noglobal+0xc0/0xc0
> [   75.331138][ T5723]  __fput+0x10e/0x440
> [   75.331503][ T5723]  task_work_run+0x73/0xd0
> [   75.331895][ T5723]  do_exit+0x535/0x1200
> [   75.332280][ T5723]  ? ktime_get_coarse_real_ts64+0x13b/0x170
> [   75.332810][ T5723]  do_group_exit+0x51/0x100
> [   75.333215][ T5723]  __x64_sys_exit_group+0x18/0x20
> [   75.333654][ T5723]  do_syscall_64+0x37/0x90
> [   75.334058][ T5723]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> If drm_gem_mmap_obj() failed, it drops the reference count by calling
> drm_gem_object_put().  However, drm_gem_mmap() drops the reference
> count after calling drm_gem_mmap_obj() even if it failed, so it breaks
> the balance of the reference count.
> 
> This patch fixes this issue by calling drm_gem_object_put() only if
> drm_gem_mmap_obj() succeeds, and returns immediately if
> drm_gem_mmap_obj() failed without calling drm_gem_object_put().
> 
> Link: https://syzkaller.appspot.com/bug?id=c42a72b0b3bcedd95e5f132a4ccd7cd550334160 [1]
> Reported-by: syzbot+c512687fff9d22327436@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ad068865ba20..f345d38df50a 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1115,10 +1115,12 @@ int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>  
>  	ret = drm_gem_mmap_obj(obj, drm_vma_node_size(node) << PAGE_SHIFT,
>  			       vma);
> +	if (ret)
> +		return ret;
>  
>  	drm_gem_object_put(obj);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(drm_gem_mmap);
>  
> -- 
> 2.37.3
> 

