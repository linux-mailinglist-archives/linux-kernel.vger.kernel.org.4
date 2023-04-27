Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D126F0C43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbjD0TFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjD0TFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D642AC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682622263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIMe4HgR4j+uLyNFZnx6VTdZb99E5zuis1nlCbyNQZ8=;
        b=ZoGN0D1skXNPJAOFeiuXMXUY4IL0vWlydxfk1UxcHf+CfXBj2+ZNQThI9PS5LkFZwF9hIS
        ZvSBrOLsUVz2Gtxm5ts8UZvMQgqEcXaswGQOU3fU+Z/BxpWFKkucAzMJq4B4SVrDUPFZVs
        ImT5TKp2Xn/wfyeWbhfZKo0Cx2EDK/o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-xQB3GiZGN0KY7HNWjV1XQg-1; Thu, 27 Apr 2023 15:04:22 -0400
X-MC-Unique: xQB3GiZGN0KY7HNWjV1XQg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5f1697ce25bso52656476d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682622261; x=1685214261;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIMe4HgR4j+uLyNFZnx6VTdZb99E5zuis1nlCbyNQZ8=;
        b=JS71e1pI4fwimq4r7Gt2Xy/7xQvj8Q1n1rrv4bL4PG83PyRpH3DsHSTOMkZIOTnJSn
         S0dcDCdBO7h/j8scwF2qdRV8rGjFApEDp3v3vhWO8f3hNBvk9wE2hNQOn42qwEHBHOBt
         8GS8IvIw+ZtzfCBOyWcn3mlkNE+QpvEs9T86wB5LyZmlYfKfPIx8pD8yTGzePrcWdMlZ
         BJ/JFPODuUeOgraOtya1l+oV+SdxZmHTr9TOQCtSZr4ZWQG35+0n9VZubiX+cpMWE1a7
         gfFC6HEWExBbhtnTqay7EDsaA9R72HzZ1JltGJLtnsdAp1h1aUPLAtdzqupVW9b+tOYR
         wUbQ==
X-Gm-Message-State: AC+VfDxQe9k4KFLxiW5fsyxCnN3jamswqW/QH9I4OB9KVqTDdSio499m
        yl5vUh9yfx5E9hg7b5eWqdRJN6Zm4smkyLmBgkjF59A/9ZT1+UjOLUzpyH6UQ7ZqQ8dCHe4GFQD
        LpOcg9nMKDY3VyAURFFNVhByb
X-Received: by 2002:ad4:4ee9:0:b0:5f1:5cf1:b4c8 with SMTP id dv9-20020ad44ee9000000b005f15cf1b4c8mr3813286qvb.35.1682622261416;
        Thu, 27 Apr 2023 12:04:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SB3ZpF6dpDmJ9SOMuCZdR4eEW/J9n7aNhD3J51znEIy6E5R4o2TS1XiwTUz6GHVehnHeGPA==
X-Received: by 2002:ad4:4ee9:0:b0:5f1:5cf1:b4c8 with SMTP id dv9-20020ad44ee9000000b005f15cf1b4c8mr3813243qvb.35.1682622260984;
        Thu, 27 Apr 2023 12:04:20 -0700 (PDT)
Received: from ?IPV6:2601:883:c200:210:6ae9:ce2:24c9:b87b? ([2601:883:c200:210:6ae9:ce2:24c9:b87b])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cf4c8000000b005ef5fc3a136sm5808498qvm.110.2023.04.27.12.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 12:04:20 -0700 (PDT)
Message-ID: <224ae998-d264-c984-263d-a9a7cf6c7a00@redhat.com>
Date:   Thu, 27 Apr 2023 15:04:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: We found a general protection fault in evict
Content-Language: en-US
To:     yang lan <lanyang0908@gmail.com>, agruenba@redhat.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
References: <CAAehj2ntp=h1ob2MVWv7_3NuT=wtA6Gpdk9ZWWYU=pDy8PvmBw@mail.gmail.com>
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <CAAehj2ntp=h1ob2MVWv7_3NuT=wtA6Gpdk9ZWWYU=pDy8PvmBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        NICE_REPLY_A,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 11:15 AM, yang lan wrote:
> Hi,
> 
> We use our modified Syzkaller to fuzz the latest Linux kernel and find a 
> bug in the gfs2 file system.
> 
> We have used the utility syz-execprog to reproduce this bug with 
> ./syz-execprog -executor=./syz-executor -repeat=100 -procs=6 -cover=1 poc.
> Now, this bug can be triggered with the following prog provided:
> 
> HEAD commit: f1b32fda06d2 tag: v5.10.179
> console log: https://pastebin.com/raw/3XhteWrX 
> <https://pastebin.com/raw/3XhteWrX>
> kernel config: https://pastebin.com/raw/BiggLxRg 
> <https://pastebin.com/raw/BiggLxRg>
> Syz reproducer: https://pastebin.com/raw/PwbMR8ag 
> <https://pastebin.com/raw/PwbMR8ag>
> C reproducer: 
> https://drive.google.com/file/d/1j4g8EUrFb1GGdaaRBNHE4ATXiqeg6-zI/view?usp=sharing <https://drive.google.com/file/d/1j4g8EUrFb1GGdaaRBNHE4ATXiqeg6-zI/view?usp=sharing>
> 
> gfs2: fsid=syz:syz.0: no resource groups found in the file system.

Hi,

The upstream kernel doesn't seem to GPF here. I get a non-fatal file 
system withdraw (which seems reasonable given what the resulting fs 
looks like):

[root@bob-upstream9 /home/bob/xfstests-dev]# /home/bob/tools/c/poc_evict
[root@bob-upstream9 /home/bob/xfstests-dev]# echo $?
0

[ 2530.707005] gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", 
"syz:syz"
[ 2530.707576] gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
[ 2530.708349] gfs2: fsid=syz:syz.0: fatal: filesystem consistency error
[ 2530.708349]   inode = 3 2076
[ 2530.708349]   function = gfs2_dinode_in, file = fs/gfs2/glops.c, line 
= 472
[ 2530.709534] gfs2: fsid=syz:syz.0: G:  s:SH n:2/81c f:qobnN t:SH 
d:EX/0 a:0 v:0 r:3 m:200 p:1
[ 2530.710165] gfs2: fsid=syz:syz.0:  H: s:SH f:H e:0 p:1825 [mount] 
gfs2_fill_super+0x8f0/0xef0 [gfs2]
[ 2530.710846] gfs2: fsid=syz:syz.0:  I: n:3/2076 t:4 f:0x00 
d:0x00000000 s:0 p:0
[ 2530.711387] gfs2: fsid=syz:syz.0: about to withdraw this file system
[ 2530.711857] gfs2: fsid=syz:syz.0: File system withdrawn
[ 2530.712256] CPU: 6 PID: 1825 Comm: mount Kdump: loaded Not tainted 
6.3.0-rc3+ #26
[ 2530.712803] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.1-1.el9 
04/01/2014
[ 2530.713324] Call Trace:
[ 2530.713513]  <TASK>
[ 2530.713678]  dump_stack_lvl+0x48/0x60
[ 2530.713959]  gfs2_withdraw+0x479/0x5c0 [gfs2]
[ 2530.714299]  gfs2_inode_refresh+0x267/0x2d0 [gfs2]
[ 2530.714667]  gfs2_instantiate+0x87/0xc0 [gfs2]
[ 2530.715013]  gfs2_glock_wait+0x8b/0xb0 [gfs2]
[ 2530.715356]  init_journal+0x302/0xaf0 [gfs2]
[ 2530.715693]  ? vsnprintf+0x2ba/0x560
[ 2530.715966]  ? gfs2_fill_super+0x8f0/0xef0 [gfs2]
[ 2530.716326]  ? snprintf+0x3d/0x50
[ 2530.716576]  gfs2_fill_super+0x8f0/0xef0 [gfs2]
[ 2530.716927]  ? gfs2_fill_super+0x7aa/0xef0 [gfs2]
[ 2530.717287]  ? mutex_lock+0x12/0x40
[ 2530.717552]  ? __pfx_gfs2_fill_super+0x10/0x10 [gfs2]
[ 2530.717938]  ? snprintf+0x3d/0x50
[ 2530.718190]  ? sget_fc+0x208/0x300
[ 2530.718453]  ? __pfx_gfs2_fill_super+0x10/0x10 [gfs2]
[ 2530.718837]  get_tree_bdev+0x171/0x270
[ 2530.719126]  gfs2_get_tree+0x22/0x90 [gfs2]
[ 2530.719446]  vfs_get_tree+0x26/0xd0
[ 2530.719711]  path_mount+0x464/0xa80
[ 2530.719981]  __x64_sys_mount+0xeb/0x120
[ 2530.720271]  do_syscall_64+0x5d/0x90
[ 2530.720544]  ? syscall_exit_to_user_mode+0x1b/0x40
[ 2530.720902]  ? do_syscall_64+0x6d/0x90
[ 2530.721185]  ? do_syscall_64+0x6d/0x90
[ 2530.721467]  ? syscall_exit_to_user_mode+0x1b/0x40
[ 2530.721823]  ? do_syscall_64+0x6d/0x90
[ 2530.722106]  ? do_syscall_64+0x6d/0x90
[ 2530.722386]  ? do_syscall_64+0x6d/0x90
[ 2530.722668]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 2530.723046] RIP: 0033:0x7f7dcd83f7be
[ 2530.723316] Code: 48 8b 0d 65 a6 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 a6 1b 00 f7 d8 64 89 01 48
[ 2530.724659] RSP: 002b:00007fffe0f3d248 EFLAGS: 00000246 ORIG_RAX: 
00000000000000a5
[ 2530.725211] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
00007f7dcd83f7be
[ 2530.725733] RDX: 000055b230c02e20 RSI: 000055b230c02e60 RDI: 
000055b230c02e40
[ 2530.726256] RBP: 000055b230c02bf0 R08: 0000000000000000 R09: 
00007fffe0f3bf70
[ 2530.726776] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[ 2530.727298] R13: 000055b230c02e20 R14: 000055b230c02e40 R15: 
000055b230c02bf0
[ 2530.727819]  </TASK>
[ 2530.728005] gfs2: fsid=syz:syz.0: can't read journal index: -5

I'm guessing it's a problem we've already fixed in newer versions, but I 
don't have easy access to that kernel. Perhaps you can bisect it?
I could try older kernels but I've already spent a lot of time on this 
today, so I need to move on to other things.

Regards,

Bob Peterson

