Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1D66A9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjANHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjANHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:08:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8954ED7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:08:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q23-20020a17090a065700b002290913a521so6838776pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUDKlvhazTfHjv9R6PFrCIvnfDe1GFs4w7cjP0alVEo=;
        b=KSaD1HzPqupZpDRkpUJW4SjosWwyEqoooZDsMowgl2G/KJqLfp7miKwkKVpW4qGnyd
         VY06iljPFMD0l7BlJBkpcuziusS+VYvjMM0tGUOqd9JQKMZCWWyAPsUgxzWXeMuz/MnY
         Adi0j1KpYqEMMdMeOA5Xy9wnoy6+52UzNbe7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUDKlvhazTfHjv9R6PFrCIvnfDe1GFs4w7cjP0alVEo=;
        b=rwX6+ruXlg8+ZSZ4qbxXlcXocopSl2bGpVuHpM4CO2u+TNh3AULFC7Ur41KIH66tW3
         V81BAM8KQSLtyEXFn438HRv32pWdooE+kJYeMSalzYYeuhP8xBJ3KVxFQakvH7EBfgLC
         DorsZlRZTcSoc83oMjKT6JCkQUOsPJYwVbIrb/6lnnuC4H9n6cSdNlPrcAlL6C3PU6iX
         bPoQwjj8f/IjtI8WW9tcQ5E9rcSdTjt2B/mfVPm/LI/3eGADgvJ5KBId8Jj6qbOn3uLe
         1SY+mOn2p0TnOh3uxM3cJoBevd5R9FhKBWWeVgwOIYTRT/RQuLLTjNsUOtqGoIMagwKy
         EuHw==
X-Gm-Message-State: AFqh2kr2Y3uDaJIPUVIiZS4Xz2+/DH8ByIzim8l/skDjSMHJHfX5vf6W
        HAe9satGROR45l1AYIgtkNKTRU9PcuBrrV/v
X-Google-Smtp-Source: AMrXdXuaDDOuOsKcinz4ww2Z0nlFuaJGkyB2Fa2OsJbLyCnS//nee9j4mDUtiXjlH2+gcCVmMjwUTQ==
X-Received: by 2002:a17:90a:bb8b:b0:227:1c1e:7529 with SMTP id v11-20020a17090abb8b00b002271c1e7529mr19891407pjr.15.1673680120121;
        Fri, 13 Jan 2023 23:08:40 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090a70cc00b00229199f5792sm2635795pjm.15.2023.01.13.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:08:38 -0800 (PST)
Date:   Sat, 14 Jan 2023 16:08:34 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8JU8iGlu5uLGdDt@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8G3nJ9+k2lB0kas@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/13 11:57), Mike Kravetz wrote:
> Hi Sergey,
> 
> The following BUG shows up after this series in linux-next.  I can easily
> recreate by doing the following:
> 
> # echo large_value > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> where 'large_value' is a so big that there could never possibly be that
> many 2MB huge pages in the system.

I get migration warnins with the zsmalloc series reverted.
I guess the problem is somewhere else. Can you double check
on you side?


[   87.208255] ------------[ cut here ]------------
[   87.209431] WARNING: CPU: 18 PID: 300 at mm/migrate.c:995 move_to_new_folio+0x1ef/0x260
[   87.211993] Modules linked in: deflate zlib_deflate zstd zstd_compress zram
[   87.214287] CPU: 18 PID: 300 Comm: kcompactd0 Tainted: G                 N 6.2.0-rc3-next-20230113+ #385
[   87.217529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[   87.220131] RIP: 0010:move_to_new_folio+0x1ef/0x260
[   87.221892] Code: 84 c0 74 78 48 8b 43 18 44 89 ea 48 89 de 4c 89 e7 ff 50 06 85 c0 0f 85 a9 fe ff ff 48 8b 03 a9 00 00 04 00 0f 85 7a fe ff ff <0f> 0b e9 73 fe ff ff 48 8b 03 f6 c4 20 74 2a be c0 0c 00 00 48 89
[   87.226514] RSP: 0018:ffffc90000b9fb08 EFLAGS: 00010246
[   87.227879] RAX: 4000000000000021 RBX: ffffea0000890500 RCX: 0000000000000000
[   87.230948] RDX: 0000000000000000 RSI: ffffffff81e6f950 RDI: ffffea0000890500
[   87.233026] RBP: ffffea0000890500 R08: 0000001e82ec3c3e R09: 0000000000000001
[   87.235517] R10: 00000000ffffffff R11: 00000000ffffffff R12: ffffea00015a26c0
[   87.237807] R13: 0000000000000001 R14: ffffea00015a2680 R15: ffffea00008904c0
[   87.239438] FS:  0000000000000000(0000) GS:ffff888624200000(0000) knlGS:0000000000000000
[   87.241303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.242627] CR2: 00007fe537ebbdb8 CR3: 0000000110a0a004 CR4: 0000000000770ee0
[   87.244283] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   87.245913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   87.247559] PKRU: 55555554
[   87.248269] Call Trace:
[   87.248862]  <TASK>
[   87.249370]  ? lock_is_held_type+0xd9/0x130
[   87.250377]  migrate_pages_batch+0x553/0xc80
[   87.251513]  ? move_freelist_tail+0xc0/0xc0
[   87.252545]  ? isolate_freepages+0x290/0x290
[   87.253654]  ? trace_mm_migrate_pages+0xf0/0xf0
[   87.254901]  migrate_pages+0x1ae/0x330
[   87.255877]  ? isolate_freepages+0x290/0x290
[   87.257015]  ? move_freelist_tail+0xc0/0xc0
[   87.258213]  compact_zone+0x528/0x6a0
[   87.260911]  proactive_compact_node+0x87/0xd0
[   87.262090]  kcompactd+0x1ca/0x360
[   87.263018]  ? swake_up_all+0xe0/0xe0
[   87.264101]  ? kcompactd_do_work+0x240/0x240
[   87.265243]  kthread+0xec/0x110
[   87.266031]  ? kthread_complete_and_exit+0x20/0x20
[   87.267268]  ret_from_fork+0x1f/0x30
[   87.268243]  </TASK>
[   87.268984] irq event stamp: 311113
[   87.269930] hardirqs last  enabled at (311125): [<ffffffff810da6c2>] __up_console_sem+0x52/0x60
[   87.272235] hardirqs last disabled at (311134): [<ffffffff810da6a7>] __up_console_sem+0x37/0x60
[   87.275707] softirqs last  enabled at (311088): [<ffffffff819d2b2c>] __do_softirq+0x21c/0x31f
[   87.278450] softirqs last disabled at (311083): [<ffffffff81070b8d>] __irq_exit_rcu+0xad/0x120
[   87.280555] ---[ end trace 0000000000000000 ]---
