Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89A702A15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbjEOKIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjEOKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987811FD0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684145236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8znqVw87JzE/GiUPHNFG+C6yuIz096Ng+G8V1HRe2s=;
        b=Zp5laAS+YKm5zfkxIeyXzETcG1CxIMJFF0YMutuRY8Uv1PloJAA+MVorO3oZUB0moPxQGz
        zfEj/fz8soXsbm/fr2QjBrkK3i/9IJuVk3iqkt2ooXDI74RkcjcX6GtzjGqgPSpabXJcsM
        NJZgmW5z9+Kqej6dpHhE7dOFssokgM8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-wcpg3rWqOrmEqBjfNuUdxw-1; Mon, 15 May 2023 06:07:13 -0400
X-MC-Unique: wcpg3rWqOrmEqBjfNuUdxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22CE43C0F22F;
        Mon, 15 May 2023 10:07:13 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B7FF63ABB;
        Mon, 15 May 2023 10:07:12 +0000 (UTC)
Date:   Mon, 15 May 2023 18:07:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZGIETQZWp3scdS/m@MiWiFi-R3L-srv>
References: <20230515060259.830662-1-bhe@redhat.com>
 <20230515060259.830662-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515060259.830662-2-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/23 at 02:02pm, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> low and high memory boundary, then user will see two memory regions in
> low memory, and one memory region in high memory. The two crashkernel
> low memory regions are confusing as shown in above example.
> 
> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses low and high memory
> boundary and the part of crashkernel high reservation below boundary is
> bigger than y, the expected crahskernel low reservation will be skipped.
> But the expected crashkernel high reservation is shrank and could not
> satisfy user space requirement.
> 
> 3) The crossing boundary behaviour of crahskernel high reservation is
> different than x86 arch. On x86_64, the low memory end is 4G fixedly,
> and the memory near 4G is reserved by system, e.g for mapping firmware,
> pci mapping, so the crashkernel reservation crossing boundary never happens.
> From distros point of view, this brings inconsistency and confusion. Users
> need to dig into x86 and arm64 system details to find out why.
> 
> For kernel itself, the impact of issue 3) could be slight. While issue
> 1) and 2) cause actual impact because it brings obscure semantics and
> behaviour to crashkernel=,high reservation.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region only in high memory. If failed, try reserving the suitable
> region only in low memory. Like this, the crashkernel high region will
> only exist in high memory, and crashkernel low region only exists in low
> memory. The reservation behaviour for crashkernel=,high is clearer and
> simpler.
> 
> Note: RPi4 has different zone ranges than normal memory. Its DMA zone is
> 0~1G, and DMA32 zone is 1G~4G if CONFIG_ZONE_DMA|DMA32 are enabled by
> default. The low memory end is 1G in order to validate all devices, high
> memory starts at 1G memory. However, for being consistent with normla
> arm64 system, its low memory end is still 1G, while reserving crashkernel
> high memory from 4G if crashkernel=size,high specified. This will remove
> confusion.
> 
> With above change applied, summary of arm64 crashkernel reservation range:
> 1)
> RPi4(zone DMA:0~1G; DMA32:1G~4G):
>  crashkernel=size
>   0~1G: low memory | 1G~top: high memory
> 
>  crashkernel=size,high
>   0~1G: low memory | 4G~top: high memory
> 
> 2)
> Other normal system:
>  crashkernel=size
>  crashkernel=size,high
>   0~4G: low memory | 4G~top: high memory
> 
> 3)
> Systems w/o zone DMA|DMA32
>  crashkernel=size
>  crashkernel=size,high
>   0~top: low memory
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> arm64: kdump: fix warning reported by static checker
> Signed-off-by: Baoquan He <bhe@redhat.com>

Sorry, forgot cleaning up this relic of local patch merging, have resent
one to remove it, and add Catalin's Reviewed-by tag.

Thanks
Baoquan

