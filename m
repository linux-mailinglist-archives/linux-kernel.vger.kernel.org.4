Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2196C8A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 04:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCYDBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 23:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 23:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6711ADEC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 20:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679713226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDkgtInWoMj0Kl4LkfGevv4ADacM/sg4LTkpZaBnKrc=;
        b=frRzKkP8kbEpFpRePbuY+aeRI6qJsQrbK0NK6BD5IaFSQSgcZAjMuBiIYywp1j7qF+b8Eq
        UIqP5dOEJza70F+THE9Kr2tfZUWASLiZ7ufki8dDXzzP5+sbZCbFAroWo85Uf+efzSdCNF
        TFD6cB0tyeHsfRzTz5DmM+RQse9Gi+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-thQ0X1QGPmmYShG0G3q_5A-1; Fri, 24 Mar 2023 23:00:23 -0400
X-MC-Unique: thQ0X1QGPmmYShG0G3q_5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FC5887B2A1;
        Sat, 25 Mar 2023 03:00:22 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD24140C6E67;
        Sat, 25 Mar 2023 03:00:15 +0000 (UTC)
Date:   Sat, 25 Mar 2023 11:00:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, horms@kernel.org,
        John.p.donnelly@oracle.com, will@kernel.org,
        kexec@lists.infradead.org, ardb@kernel.org, rppt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on
 crashkernel memory region
Message-ID: <ZB5ju+xxCwZ7DDA5@MiWiFi-R3L-srv>
References: <20230324131838.409996-1-bhe@redhat.com>
 <ZB3Zx85Ajnhzq3Pt@arm.com>
 <9ca6f729-989d-654a-83e6-c89d8f65c69d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca6f729-989d-654a-83e6-c89d8f65c69d@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/23 at 10:14am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/3/25 1:11, Catalin Marinas wrote:
> > On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
> >> Baoquan He (3):
> >>   arm64: kdump : take off the protection on crashkernel memory region
> >>   arm64: kdump: do not map crashkernel region specifically
> >>   arm64: kdump: defer the crashkernel reservation for platforms with no
> >>     DMA memory zones
> >>
> >>  arch/arm64/include/asm/kexec.h    |  6 -----
> >>  arch/arm64/include/asm/memory.h   |  5 ----
> >>  arch/arm64/kernel/machine_kexec.c | 20 --------------
> >>  arch/arm64/mm/init.c              |  6 +----
> >>  arch/arm64/mm/mmu.c               | 43 -------------------------------
> >>  5 files changed, 1 insertion(+), 79 deletions(-)
> > 
> > This series works for me and it has a negative diffstat as well (though
> > I'm sure people will try to bring it back ;)).
> 
> After the write protection is removed, it is recommended that crc32 check
> be added. However, it can be added later.

That's a great catch. We have calculated the checusum with sha256 in
user space and kernel, and verify it in purgatory in user space.
However, arm64 seems to not do the verifying in kernel if
kexec_file_load is used. Please see kexec_calculate_store_digests().

If stamping happened, the checksum verification can help us spot it.
Yes, this can be added later. Thanks for raising that.

