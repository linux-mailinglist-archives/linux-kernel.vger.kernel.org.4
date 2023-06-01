Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A391719068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjFACQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjFACQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4B121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685585735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=07+CNsneIoVDruoAxJKFo1HiC0RGLoxI/2tCL7nWfWk=;
        b=DPN8oA9bAO+JHMcfwTeNWMXD8E7sHSzOQeQKqq43gmf9Nmb2FWrc5mZgq+tYj6Ptc3EBx6
        TwSMs0dRpf/Uzc6XHes13+6jEfYb2uAsZOWTHtq6fWTJxsADo4/F6JfxMEz1wQnjHxDnGr
        zKZ4WD//sKKWdrxLH0Rt+Zf4a7swyvk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-0E5pcOXtMcCkmyYhinzlRw-1; Wed, 31 May 2023 22:15:29 -0400
X-MC-Unique: 0E5pcOXtMcCkmyYhinzlRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B24BD380450F;
        Thu,  1 Jun 2023 02:15:27 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7829D40C6EC4;
        Thu,  1 Jun 2023 02:15:26 +0000 (UTC)
Date:   Thu, 1 Jun 2023 10:15:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: Re: [RFC v3 00/21] Preserved-over-Kexec RAM
Message-ID: <ZHf/Os9v2cx97Maw@MiWiFi-R3L-srv>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/23 at 05:08pm, Anthony Yznaga wrote:
> Sending out this RFC in part to guage community interest.
> This patchset implements preserved-over-kexec memory storage or PKRAM as a
> method for saving memory pages of the currently executing kernel so that
> they may be restored after kexec into a new kernel. The patches are adapted
> from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
> introduce the PKRAM kernel API.
> 
> One use case for PKRAM is preserving guest memory and/or auxillary
> supporting data (e.g. iommu data) across kexec to support reboot of the
> host with minimal disruption to the guest. PKRAM provides a flexible way
> for doing this without requiring that the amount of memory used by a fixed
> size created a priori.  Another use case is for databases to preserve their
> block caches in shared memory across reboot.

If so, I have confusions, who can help clarify:
1) Why kexec reboot was introduced, what do we expect kexec reboot to
   do?

2) If we need keep these data and those data, can we not reboot? They
   are definitely located there w/o any concern.

3) What if systems of AI, edge computing, HPC etc also want to carry
   kinds of data from userspace or kernel, system status, registers
   etc when kexec reboot is needed, while enligntened by this patch?

Thanks
Baoquan

