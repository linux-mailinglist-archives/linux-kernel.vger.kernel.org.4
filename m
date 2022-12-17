Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2D64F887
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 10:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiLQJtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 04:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 04:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D52E9D9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671270539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8+cb7SeX23uGI90U7WymgIHpdK7PIOEux9WNUqXxSTM=;
        b=hCfYCubFb0NR4y9P2uYgIlGycjLtTDBy/HIpbMQ7lkd47y5XQ8MYtAurZjOIEJOeHSAr5d
        L5VbRlq9jfI2h0MMPvazf9siCfvPMKv/TzmKBe9/mI+kXkGLvg6H3lmczEUlttMkZMPFnk
        QAk59Ibx0vXKtNgyupQLCX2EqVE8ahc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-slC8Q35xPLK9tZqcDtKq2g-1; Sat, 17 Dec 2022 04:48:56 -0500
X-MC-Unique: slC8Q35xPLK9tZqcDtKq2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D589F29AA383;
        Sat, 17 Dec 2022 09:48:55 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EB6C40ED76B;
        Sat, 17 Dec 2022 09:48:54 +0000 (UTC)
Date:   Sat, 17 Dec 2022 17:48:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.

I ever posted below patch to do the same thing, Andrew only picked the
memory leak fixing patch.

[PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
https://lore.kernel.org/all/20220223113225.63106-3-bhe@redhat.com/T/#u

> 
> Bjorn Helgaas (2):
>   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
>   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> 
>  arch/x86/include/asm/kexec.h       |  3 ---
>  arch/x86/kernel/machine_kexec_64.c | 11 -----------
>  include/linux/kexec.h              |  8 --------
>  kernel/kexec_file.c                |  6 +++---
>  4 files changed, 3 insertions(+), 25 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

