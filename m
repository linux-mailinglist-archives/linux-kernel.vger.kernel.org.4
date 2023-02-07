Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC57F68CE6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBGE6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBGE6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:58:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E601EBF9;
        Mon,  6 Feb 2023 20:58:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so20730761lfb.13;
        Mon, 06 Feb 2023 20:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wlVffh9zWH/jnQx6JAaeCk2U5f26d/6ml8I+6W9cAIc=;
        b=fApls+puYUkzYOIxJ52h6u7z1ujy422RrPt7SFItuPwG9IuaELkM6V/4tu407lWMXL
         aS20zAgQer77Isam8vFvIUWSXLDXY5NzBEC9CAIvi24rTvPrF4GZgFAKMssPYBOekWyF
         HqgK1tSSLNRiX6ey468GX1DqKvDue8im0rTfxeklfLK1/7eHfXnQZSxJYSTyND7RSx4h
         2VFchNdEjwe3wVCU61iU7nAvQka2t8G3y7/NKjjWPyQ+YDMeavEUFWv1sOR4mFxVR7xu
         ib8dXu5dDpc34emBtZgm++az5+gbzI9SF5Ud1b012c2vcX2FVFNl/LXmAfYV62ky0Jfg
         lDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlVffh9zWH/jnQx6JAaeCk2U5f26d/6ml8I+6W9cAIc=;
        b=oWw/zU2GaQsq6rnHyO+OREtiiul4jJK911TCBFa7ShXfDZyXKB0R1Cu1pXDh6bd31t
         mT1r/SZeleMKmGufRIVGdCCJ5WGSXxhb5CMPed08Oku4prWpVF49ao3NUgw1AHfsZV4r
         cbht0o3fbviKlgMYItMgilZk745uo+2QzQJUtFbJObXlaOFXYeojlNIqkTAHsDADYh0R
         6dtm4eUvJaF6qAmxLgk9tGW11bQtsbgjvOkkn3n5ckc2kgxp+s1QCOPuL6inBg8INupQ
         fIepUKXy/b3IZLKdbn+pzgNOpgsETRc/TjqoU5AbokkPK+hOZxCiBrTUlarj0ixSrepj
         /3pA==
X-Gm-Message-State: AO0yUKWTS+ZNKcz6Zc+av/aAUqtJlp+gPqJ+5FjDk8GTcAIRnEkaynGg
        VC7YqCXXffIULNySCk+5xahbZHeY5CA1CjRSqrKuiGIQ
X-Google-Smtp-Source: AK7set9QPTnAr7hyeF6Z+fteoge93bBac/jt7FF6XjKRXdw3FJv2lSM/RCPX/ZVd0PXE16+ZJsO5/hykYRO5WqvdZo0=
X-Received: by 2002:ac2:5ec8:0:b0:4cb:20b3:e7f4 with SMTP id
 d8-20020ac25ec8000000b004cb20b3e7f4mr270251lfq.194.1675745921873; Mon, 06 Feb
 2023 20:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20230206011009.1126177-1-wangzhaolong1@huawei.com>
In-Reply-To: <20230206011009.1126177-1-wangzhaolong1@huawei.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 6 Feb 2023 22:58:30 -0600
Message-ID: <CAH2r5mscPCgnxroD5sSuE8PvHvwLdN+2X=wm9Oy4+XNCsEAh6w@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix use-after-free in rdata->read_into_pages()
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
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

added Cc:stable and acked-by Paulo

merged into cifs-2.6.git for-next pending testing

On Sun, Feb 5, 2023 at 7:11 PM ZhaoLong Wang <wangzhaolong1@huawei.com> wrote:
>
> When the network status is unstable, use-after-free may occur when
> read data from the server.
>
>   BUG: KASAN: use-after-free in readpages_fill_pages+0x14c/0x7e0
>
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x38/0x4c
>    print_report+0x16f/0x4a6
>    kasan_report+0xb7/0x130
>    readpages_fill_pages+0x14c/0x7e0
>    cifs_readv_receive+0x46d/0xa40
>    cifs_demultiplex_thread+0x121c/0x1490
>    kthread+0x16b/0x1a0
>    ret_from_fork+0x2c/0x50
>    </TASK>
>
>   Allocated by task 2535:
>    kasan_save_stack+0x22/0x50
>    kasan_set_track+0x25/0x30
>    __kasan_kmalloc+0x82/0x90
>    cifs_readdata_direct_alloc+0x2c/0x110
>    cifs_readdata_alloc+0x2d/0x60
>    cifs_readahead+0x393/0xfe0
>    read_pages+0x12f/0x470
>    page_cache_ra_unbounded+0x1b1/0x240
>    filemap_get_pages+0x1c8/0x9a0
>    filemap_read+0x1c0/0x540
>    cifs_strict_readv+0x21b/0x240
>    vfs_read+0x395/0x4b0
>    ksys_read+0xb8/0x150
>    do_syscall_64+0x3f/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
>   Freed by task 79:
>    kasan_save_stack+0x22/0x50
>    kasan_set_track+0x25/0x30
>    kasan_save_free_info+0x2e/0x50
>    __kasan_slab_free+0x10e/0x1a0
>    __kmem_cache_free+0x7a/0x1a0
>    cifs_readdata_release+0x49/0x60
>    process_one_work+0x46c/0x760
>    worker_thread+0x2a4/0x6f0
>    kthread+0x16b/0x1a0
>    ret_from_fork+0x2c/0x50
>
>   Last potentially related work creation:
>    kasan_save_stack+0x22/0x50
>    __kasan_record_aux_stack+0x95/0xb0
>    insert_work+0x2b/0x130
>    __queue_work+0x1fe/0x660
>    queue_work_on+0x4b/0x60
>    smb2_readv_callback+0x396/0x800
>    cifs_abort_connection+0x474/0x6a0
>    cifs_reconnect+0x5cb/0xa50
>    cifs_readv_from_socket.cold+0x22/0x6c
>    cifs_read_page_from_socket+0xc1/0x100
>    readpages_fill_pages.cold+0x2f/0x46
>    cifs_readv_receive+0x46d/0xa40
>    cifs_demultiplex_thread+0x121c/0x1490
>    kthread+0x16b/0x1a0
>    ret_from_fork+0x2c/0x50
>
> The following function calls will cause UAF of the rdata pointer.
>
> readpages_fill_pages
>  cifs_read_page_from_socket
>   cifs_readv_from_socket
>    cifs_reconnect
>     __cifs_reconnect
>      cifs_abort_connection
>       mid->callback() --> smb2_readv_callback
>        queue_work(&rdata->work)  # if the worker completes first,
>                                  # the rdata is freed
>           cifs_readv_complete
>             kref_put
>               cifs_readdata_release
>                 kfree(rdata)
>  return rdata->...               # UAF in readpages_fill_pages()
>
> Similarly, this problem also occurs in the uncache_fill_pages().
>
> Fix this by adjusts the order of condition judgment in the return
> statement.
>
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>  fs/cifs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 22dfc1f8b4f1..b8d1cbadb689 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3889,7 +3889,7 @@ uncached_fill_pages(struct TCP_Server_Info *server,
>                 rdata->got_bytes += result;
>         }
>
> -       return rdata->got_bytes > 0 && result != -ECONNABORTED ?
> +       return result != -ECONNABORTED && rdata->got_bytes > 0 ?
>                                                 rdata->got_bytes : result;
>  }
>
> @@ -4665,7 +4665,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
>                 rdata->got_bytes += result;
>         }
>
> -       return rdata->got_bytes > 0 && result != -ECONNABORTED ?
> +       return result != -ECONNABORTED && rdata->got_bytes > 0 ?
>                                                 rdata->got_bytes : result;
>  }
>
> --
> 2.31.1
>


-- 
Thanks,

Steve
