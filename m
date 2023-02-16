Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1796999AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBPQRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:17:13 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A69E5264;
        Thu, 16 Feb 2023 08:17:12 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h10so2397439vsu.11;
        Thu, 16 Feb 2023 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676564231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/nRuukX08ooHaD9kcBdoVIqsSqGmd8gj/NaEMnVWHCM=;
        b=SSrBKFK7rrcMzE2pEHvb6IRq25yF8ha+gqrQL65qEBNAt1aqKpT74vnv7jBHiMbSxe
         PNsOMYoXiD9sXeVVjP5MnLs9yXlf9eA92Mhtk12KWYNfFY9F/zUTI2Zoy1cC3K6IC1CD
         Z6qhcxtcYjOQbgz7P6Qz5XAzemR6WbM9rw0cWkGBhyQOQ1gvh+89Vaby8DIPIjTKQLXf
         +QeyYLMwmWp8/5wU71pKZdTCMdwTgEqMXZal2AfpoRhmoM2JH6flzS9tI+AoYUuEA/1r
         tSctQcYxiW3x+5iXs+Doim6i7cat48DkMgtLyZHIEjUcToWa6UFJBr5g0BNNJcciCDSH
         Wp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676564231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nRuukX08ooHaD9kcBdoVIqsSqGmd8gj/NaEMnVWHCM=;
        b=vh0ALGjX64X1N2cQ23NbOMdb2OIL445Px1rJEFAjsk9fXDNZXm+CRRKKFsg4vQieqJ
         zPm8OIExFufwp/ywLQo9Mj0oUm79fUsjxBjCQVw4+cdmhbS3Vuhkdf81ewUWh6tdAKOd
         XtZI0/Y+8+vlh6ZhUzkqyMIwxPlqAhjBDQ/FkCf1mTTLGisnNE/wp67rFKwjyZFTqDK8
         Ln0lVzjwEbFbCjNS0W4wS7/xmZ7jJ/pjBSgQYzspESqL0KUypeAClNq1G9/zwjEjaLz7
         0U49dFLhgt3L/ZcJn0oaPqezlNX4rskXojrb4LzK9hgMOXvBrxJycnS4Cz9VRe1zj57R
         bkPw==
X-Gm-Message-State: AO0yUKX8hECw1lCUpSAQ+jHyy+VSIUdxbSMQ/hRtGWvyAeV0FQekUVyv
        /qIeJF9zqcssU8TvKDqhbz0dHBRuyWpcjwMd83UVdIfooyprQg==
X-Google-Smtp-Source: AK7set/m6HIKDMsoZQboYSYh6iIzJfNBNNYf7yax7DQLG844+UjpeTPZkYsGZQp1TGdgt69QEDyrUrJJM8EdRZ1qS8U=
X-Received: by 2002:a67:b845:0:b0:404:8967:82d0 with SMTP id
 o5-20020a67b845000000b00404896782d0mr1020790vsh.61.1676564231081; Thu, 16 Feb
 2023 08:17:11 -0800 (PST)
MIME-Version: 1.0
References: <CANX2M5bVbzRi6zH3PTcNE_31TzerstOXUa9Bay4E6y6dX23_pg@mail.gmail.com>
In-Reply-To: <CANX2M5bVbzRi6zH3PTcNE_31TzerstOXUa9Bay4E6y6dX23_pg@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 17 Feb 2023 01:16:54 +0900
Message-ID: <CAKFNMon+3JGp9MZ6gugkkDFUqbWgXKEO9JecjEhuUMoeXYQnqw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in nilfs_add_checksums_on_logs
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     linux-nilfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:43 AM Dipanjan Das wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
>
> ======================================================
> description: KMSAN: uninit-value in nilfs_add_checksums_on_logs
> affected file: fs/nilfs2/segbuf.c
> kernel version: 6.2.0-rc5
> kernel commit: 41c66f47061608dc1fd493eebce198f0e74cc2d7
> git tree: kmsan
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=a9a22da1efde3af6
> crash reproducer: attached
> ======================================================
> Crash log:
> ======================================================
> NILFS (loop4): segctord starting. Construction interval = 5 seconds,
> CP frequency < 30 seconds
> =====================================================
> BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:112 [inline]
> BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
> BUG: KMSAN: uninit-value in crc32_le_base+0x3b7/0xc30 lib/crc32.c:197
>  crc32_body lib/crc32.c:112 [inline]
>  crc32_le_generic lib/crc32.c:179 [inline]
>  crc32_le_base+0x3b7/0xc30 lib/crc32.c:197
>  nilfs_segbuf_fill_in_data_crc fs/nilfs2/segbuf.c:208 [inline]
>  nilfs_add_checksums_on_logs+0x6ec/0xea0 fs/nilfs2/segbuf.c:321
>  nilfs_segctor_do_construct+0xa636/0xe870 fs/nilfs2/segment.c:2076
>  nilfs_segctor_construct+0x222/0xe10 fs/nilfs2/segment.c:2379
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
>  nilfs_segctor_thread+0xc19/0x11c0 fs/nilfs2/segment.c:2570
>  kthread+0x30b/0x420 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> Uninit was created at:
>  __alloc_pages+0x767/0xee0 mm/page_alloc.c:5572
>  alloc_pages+0xa9a/0xd90 mm/mempolicy.c:2286
>  folio_alloc+0x41/0x100 mm/mempolicy.c:2296
>  filemap_alloc_folio+0xa5/0x450 mm/filemap.c:972
>  __filemap_get_folio+0xe7c/0x1960 mm/filemap.c:1966
>  pagecache_get_page+0x46/0x270 mm/folio-compat.c:98
>  find_or_create_page include/linux/pagemap.h:612 [inline]
>  grow_dev_page fs/buffer.c:946 [inline]
>  grow_buffers fs/buffer.c:1011 [inline]
>  __getblk_slow fs/buffer.c:1038 [inline]
>  __getblk_gfp+0x365/0x1750 fs/buffer.c:1333
>  sb_getblk include/linux/buffer_head.h:356 [inline]
>  nilfs_segbuf_extend_segsum fs/nilfs2/segbuf.c:99 [inline]
>  nilfs_segbuf_reset+0xfd/0x520 fs/nilfs2/segbuf.c:129
>  nilfs_segctor_reset_segment_buffer fs/nilfs2/segment.c:421 [inline]
>  nilfs_segctor_collect fs/nilfs2/segment.c:1499 [inline]
>  nilfs_segctor_do_construct+0x20c6/0xe870 fs/nilfs2/segment.c:2045
>  nilfs_segctor_construct+0x222/0xe10 fs/nilfs2/segment.c:2379
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
>  nilfs_segctor_thread+0xc19/0x11c0 fs/nilfs2/segment.c:2570
>  kthread+0x30b/0x420 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> CPU: 1 PID: 11600 Comm: segctord Not tainted 6.2.0-rc5-00010-g41c66f470616 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> =====================================================
>
> --
> Thanks and Regards,
>
> Dipanjan

Thank you for reporting.

I haven't been able to reproduce this yet, but was able to get the reproducer.
According to the log, it looks like the memory for the segment header
buffer passed to crc32_le() is not initialized.
I'll take a closer look using the reproducer.

Thanks,
Ryusuke Konishi
