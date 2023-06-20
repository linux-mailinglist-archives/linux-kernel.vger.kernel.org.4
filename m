Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F4736BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjFTM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjFTM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:26:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ACC1B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:26:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b54f5aac48so16259145ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687263984; x=1689855984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YImuaKwJli8w5Jc0qucc/OXXgqXxVo9Fj37hraT/kE8=;
        b=aGYV++j4K4g1HLxiYOqB2PxK3oaMFwMs5PXWRsIriPKjhKCWKqvzwFbjqgLT3ex4uI
         5hUVaPKZDmZdXqlPSP+G6OjnR/k/U7p2f7vcUUfaOtUmVheHczvsorDd6iNxF0eUylUk
         HLhuken06rXTO91ZZI1nOHNUxvTlhrf1QF0wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263984; x=1689855984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YImuaKwJli8w5Jc0qucc/OXXgqXxVo9Fj37hraT/kE8=;
        b=AFQ0MnlF9inlsw6XCdjqF0bw9H5S3k2omi6czeG89enBGBfRpLq+En2V1bh5G8w08p
         fHGBx1COINavDKFw2zUr8G22E6CmWSVZXRdw8zn/ehyJYEn1F6nVnF8yrRowSbEjSsnL
         u9YnkVK8XUU1abD1JDzmIyaY7ie8eoS8RkiCM7C/XN513QyRYQnQYjeRUpAXIcvIPnLT
         ci6rKmHQ547sGkcDMjSPofHxx2G7DTfCLEmlluRMevubfAGICc68KC9NKrFMfHL9NDN+
         cY+swUe95pjzcC+41cwUO6MywpCb5Skef+cNrlCEFXV/d8jfw4Lo19dcoKLn3VHYcxeG
         q0Mw==
X-Gm-Message-State: AC+VfDxLwBBBX7yFv8U7hHSo62yKGKmlfu7Lq/qLkRMoXoF2V/7r92zK
        5E7HhaCwtk8Fs38DmtMbQWImAQ==
X-Google-Smtp-Source: ACHHUZ7lOqspC2zZWLV5QrHY1urntQC6A6009Xn32WE7AxTMD2fVpZBZ+51jzrVil7mixgl2V2fpEQ==
X-Received: by 2002:a17:902:7409:b0:1b5:e38:7bbe with SMTP id g9-20020a170902740900b001b50e387bbemr8955766pll.1.1687263984114;
        Tue, 20 Jun 2023 05:26:24 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00198d7b52eefsm1506809plh.257.2023.06.20.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:26:23 -0700 (PDT)
Date:   Tue, 20 Jun 2023 21:26:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v2 04/16] mm: Change do_vmi_align_munmap() side tree index
Message-ID: <20230620122619.GA2934656@google.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-5-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612203953.2093911-5-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Liam,

On (23/06/12 16:39), Liam R. Howlett wrote:
[..]
> @@ -2450,17 +2452,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	/* Make sure no VMAs are about to be lost. */
>  	{
> -		MA_STATE(test, &mt_detach, start, end - 1);
> +		MA_STATE(test, &mt_detach, 0, 0);
>  		struct vm_area_struct *vma_mas, *vma_test;
>  		int test_count = 0;
>  
>  		vma_iter_set(vmi, start);
>  		rcu_read_lock();
> -		vma_test = mas_find(&test, end - 1);
> +		vma_test = mas_find(&test, count - 1);
>  		for_each_vma_range(*vmi, vma_mas, end) {
>  			BUG_ON(vma_mas != vma_test);
>  			test_count++;
> -			vma_test = mas_next(&test, end - 1);
> +			vma_test = mas_next(&test, count - 1);
>  		}
>  		rcu_read_unlock();
>  		BUG_ON(count != test_count);

Something isn't quite working, I'm hitting BUG_ON(vma_mas != vma_test)

[    8.156437] ------------[ cut here ]------------
[    8.160473] kernel BUG at mm/mmap.c:2439!
[    8.163894] invalid opcode: 0000 [#1] PREEMPT SMP PTI

RIP: 0010:do_vmi_align_munmap+0x489/0x8a0

[    8.207867] Call Trace:
[    8.208463]  <TASK>
[    8.209018]  ? die+0x32/0x80
[    8.209709]  ? do_trap+0xd2/0x100
[    8.210520]  ? do_vmi_align_munmap+0x489/0x8a0
[    8.211576]  ? do_vmi_align_munmap+0x489/0x8a0
[    8.212639]  ? do_error_trap+0x94/0x110
[    8.213549]  ? do_vmi_align_munmap+0x489/0x8a0
[    8.214581]  ? exc_invalid_op+0x49/0x60
[    8.215494]  ? do_vmi_align_munmap+0x489/0x8a0
[    8.216576]  ? asm_exc_invalid_op+0x16/0x20
[    8.217562]  ? do_vmi_align_munmap+0x489/0x8a0
[    8.218626]  do_vmi_munmap+0xc7/0x120
[    8.219494]  __vm_munmap+0xaa/0x1c0
[    8.220370]  __x64_sys_munmap+0x17/0x20
[    8.221275]  do_syscall_64+0x34/0x80
[    8.222165]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    8.223359] RIP: 0033:0x7fdb0e2fca97
[    8.224224] Code: ff ff ff ff c3 66 0f 1f 44 00 00 f7 d8 89 05 20 28 01 00 48 c7 c0 ff ff ff ff c3 0f 1f 84 00 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d f9 27 01 00 f7 d8 89 01 48 83
[    8.228432] RSP: 002b:00007ffd15458348 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
[    8.230175] RAX: ffffffffffffffda RBX: 0000562081a347b0 RCX: 00007fdb0e2fca97
[    8.231833] RDX: 0000000000000002 RSI: 0000000000004010 RDI: 00007fdb0e2d5000
[    8.233513] RBP: 00007ffd154584d0 R08: 0000000000000000 R09: 0000562081a3fd30
[    8.235178] R10: 0000562081a3fd18 R11: 0000000000000202 R12: 00007ffd15458388
[    8.236861] R13: 00007ffd15458438 R14: 00007ffd15458370 R15: 0000562081a347b0
