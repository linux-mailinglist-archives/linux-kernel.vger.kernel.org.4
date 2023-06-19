Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48F735828
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjFSNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjFSNNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:13:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7810F0;
        Mon, 19 Jun 2023 06:12:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53C40218EA;
        Mon, 19 Jun 2023 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687180370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQmFVaQuAwWgIZ+l8dIjyNcxs23FYGNdPQCulAHqOAo=;
        b=PVLE2oqZFPuxokg5tgu/VBGR7MN9qR5XuBvP30AAyZqCTaRhBtwGAdA4DEsfO9MEcJF0uz
        LH9cF3R7RbTcDI/fRH9uKl/+bqt0crZU9UaQXA3AUBRGh+19Lk8Coc1S0opdVIMcN6g0wU
        LgYfJ8I+SyyIVB1Jcce96DitLU+1fU4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F334139C2;
        Mon, 19 Jun 2023 13:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qQHiB1JUkGRdBQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 19 Jun 2023 13:12:50 +0000
Date:   Mon, 19 Jun 2023 15:12:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, roman.gushchin@linux.dev, shakeelb@google.com
Subject: Re: [PATCH v2] mm/memcontrol: do not tweak node in mem_cgroup_init()
Message-ID: <ZJBUUZf9lJ44/eky@dhcp22.suse.cz>
References: <ZIwghl18d45vPNpd@dhcp22.suse.cz>
 <20230619130442.2487-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619130442.2487-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-06-23 13:04:42, Haifeng Xu wrote:
> mem_cgroup_init() request for allocations from each possible node, and
> it's used to be a problem because NODE_DATA is not allocated for offline
> node. Things have already changed since commit 09f49dca570a9 ("mm: handle
> uninitialized numa nodes gracefully"), so it's unnecessary to check for
> !node_online nodes here.
> 
> How to test?
> 
> qemu-system-x86_64 \
>   -kernel vmlinux \
>   -initrd full.rootfs.cpio.gz \
>   -append "console=ttyS0,115200 root=/dev/ram0 nokaslr earlyprintk=serial oops=panic panic_on_warn" \
>   -drive format=qcow2,file=vm_disk.qcow2,media=disk,if=ide \
>   -enable-kvm \
>   -cpu host \
>   -m 8G,slots=2,maxmem=16G \
>   -smp cores=4,threads=1,sockets=2  \
>   -object memory-backend-ram,id=mem0,size=4G \
>   -object memory-backend-ram,id=mem1,size=4G \
>   -numa node,memdev=mem0,cpus=0-3,nodeid=0 \
>   -numa node,memdev=mem1,cpus=4-7,nodeid=1 \
>   -numa node,nodeid=2 \
>   -net nic,model=virtio,macaddr=52:54:00:12:34:58 \
>   -net user \
>   -nographic \
>   -rtc base=localtime \
>   -gdb tcp::6000
> 
> Guest state when booting:
> 
> [    0.048881] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
> [    0.050489] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x13fffffff] -> [mem 0x00000000-0x13fffffff]
> [    0.052173] NODE_DATA(0) allocated [mem 0x13fffc000-0x13fffffff]
> [    0.053164] NODE_DATA(1) allocated [mem 0x23fffa000-0x23fffdfff]
> [    0.054187] Zone ranges:
> [    0.054587]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.055551]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.056515]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
> [    0.057484] Movable zone start for each node
> [    0.058149] Early memory node ranges
> [    0.058705]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.059679]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
> [    0.060659]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
> [    0.061649]   node   1: [mem 0x0000000140000000-0x000000023fffffff]
> [    0.062638] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
> [    0.063745] Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
> [    0.064855]   DMA zone: 158 reserved pages exceeds freesize 0
> [    0.065746] Initializing node 2 as memoryless
> [    0.066437] Initmem setup node 2 as memoryless
> [    0.067132]   DMA zone: 158 reserved pages exceeds freesize 0
> [    0.068037] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.068265] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.124755] On node 0, zone Normal: 32 pages in unavailable ranges
> 
> cat /sys/devices/system/node/online
> 0-1
> cat /sys/devices/system/node/possible
> 0-2
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lo!

> ---
> v2:
> - extend changelog by test steps
> ---
>  mm/memcontrol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e245a055..c73c5fb33f65 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7421,8 +7421,7 @@ static int __init mem_cgroup_init(void)
>  	for_each_node(node) {
>  		struct mem_cgroup_tree_per_node *rtpn;
>  
> -		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
> -				    node_online(node) ? node : NUMA_NO_NODE);
> +		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
>  
>  		rtpn->rb_root = RB_ROOT;
>  		rtpn->rb_rightmost = NULL;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
