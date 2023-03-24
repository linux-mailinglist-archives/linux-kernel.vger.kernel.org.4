Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F856C752E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCXBn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A8558A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679622192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qRY2eQHWA6TVqowK/iddv6jgQSvWFOjHndRvcplPbY=;
        b=IhVog3JV8v6MLZ4GLzcguHAfxCOMvlqFC6S7v3evRYacr1O3f3wy29Q6iTroSjunIctqwC
        cIlEuly4pGAzGOfsddrlRLXmmW0UljjtUnLz8/VK1hp8cBYMmQVPCQi8asV6sjeg9ITPtb
        IOQ/XKaGng4YCvU3zODITL+RLVzMPgI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-qjM_UH_6M3iDMjZq8HWwFA-1; Thu, 23 Mar 2023 21:43:06 -0400
X-MC-Unique: qjM_UH_6M3iDMjZq8HWwFA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 087FA85A588;
        Fri, 24 Mar 2023 01:43:06 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AFD492B0A;
        Fri, 24 Mar 2023 01:43:04 +0000 (UTC)
Date:   Fri, 24 Mar 2023 09:43:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-ID: <ZB0AJFCdHcFRI7PE@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
 <ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
 <20230323150755.06f8977fa2b860b8e02c37c3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323150755.06f8977fa2b860b8e02c37c3@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/23 at 03:07pm, Andrew Morton wrote:
> On Thu, 23 Mar 2023 15:49:20 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Hi,
> > 
> > On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > > remove it and just use the generic version.
> > > 
> > > v1 is at:
> > > https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> > > 
> > > This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> > > slightly.
> > 
> > This is an obvious and good cleanup patchset, who should I ping to ask
> > for accepting?  It's touching kexec generic code, while the hook
> > only exists on x86 ARCH.
> 
> I grabbed them

Thanks a lot, Andrew.

