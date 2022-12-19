Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202CA6507F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiLSHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiLSHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A602E33
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671433273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lroQEaauydsDS3XBI9G0FXXDhHdZpuGziiitGfhqAV4=;
        b=a1PWm23cQIZA0UEeKGzPU4UJ5cvtTfSY8G+3QYbS/LyCLudPt532V90WHEt5gMVrG8V0l/
        8y99aFtND1Aamt23UxooyXwuz3HB9kKXnNNQa1IPCA7CDCn+yiRNKdSf7XpnfH+FBebV5Y
        WLKDh0t71RZZZ4ZzPkQ8g6fHUlYmxzI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-Mw9N3ZP3Op-oZqbhAUTCxg-1; Mon, 19 Dec 2022 02:01:09 -0500
X-MC-Unique: Mw9N3ZP3Op-oZqbhAUTCxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CDBC811E6E;
        Mon, 19 Dec 2022 07:01:09 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 797AF2166B26;
        Mon, 19 Dec 2022 07:01:07 +0000 (UTC)
Date:   Mon, 19 Dec 2022 15:01:03 +0800
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
Message-ID: <Y6AML4BGQgeiwJ/j@MiWiFi-R3L-srv>
References: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
 <20221217155842.GA389338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217155842.GA389338@bhelgaas>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/22 at 09:58am, Bjorn Helgaas wrote:
> On Sat, Dec 17, 2022 at 05:48:51PM +0800, Baoquan He wrote:
> > On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > > remove it and just use the generic version.
> > 
> > I ever posted below patch to do the same thing, Andrew only picked the
> > memory leak fixing patch.
> > 
> > [PATCH v2 2/2] kexec_file: clean up arch_kexec_kernel_image_load
> > https://lore.kernel.org/all/20220223113225.63106-3-bhe@redhat.com/T/#u
> 
> Indeed!  Sorry, I wasn't aware of your previous work.  If you repost
> it, cc me and I'll be glad to help review it.

Sure, I will repost the patch for reviewing, thanks a lot.

> 
> > > Bjorn Helgaas (2):
> > >   x86/kexec: Remove unnecessary arch_kexec_kernel_image_load()
> > >   kexec: Remove unnecessary arch_kexec_kernel_image_load()
> > > 
> > >  arch/x86/include/asm/kexec.h       |  3 ---
> > >  arch/x86/kernel/machine_kexec_64.c | 11 -----------
> > >  include/linux/kexec.h              |  8 --------
> > >  kernel/kexec_file.c                |  6 +++---
> > >  4 files changed, 3 insertions(+), 25 deletions(-)
> 

