Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFF661C06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 02:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAIBjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 20:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAIBjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 20:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E5BE3A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673228342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RbPb+qIwZD/rIeCEnssQ21f/8PvH6fuTvr/C+at4VEc=;
        b=GBklWILG2zj2sCDwmP7lddHvQQl20gi6Pnc3biZIZUCA7wPs/sQiRXoG4uTjpyCLCokuXq
        Z0Ye8A+XzmnzqBawhfImzrd4NUspSeKNHZkeNcRsnfDe7BVQVXj3tqqLAXPg/aTttIkB8/
        8DMJ48i3bPXTxQ6Jb6494J4MNcmjXFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-JZe4po0bMd-JNDuHmhStsA-1; Sun, 08 Jan 2023 20:38:58 -0500
X-MC-Unique: JZe4po0bMd-JNDuHmhStsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 465F4802D1A;
        Mon,  9 Jan 2023 01:38:57 +0000 (UTC)
Received: from localhost (ovpn-13-135.pek2.redhat.com [10.72.13.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01CEE39DCA;
        Mon,  9 Jan 2023 01:38:55 +0000 (UTC)
Date:   Mon, 9 Jan 2023 09:38:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y7twK57xddLROyW5@fedora>
References: <20221215182339.129803-1-helgaas@kernel.org>
 <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
 <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
 <e587eebc-5f28-0a63-9200-b67ba20ea347@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e587eebc-5f28-0a63-9200-b67ba20ea347@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/23 at 10:37am, Dave Hansen wrote:
> On 1/3/23 19:21, Baoquan He wrote:
> >> Since it cleans up the last arch specific version of
> >> arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
> >> branch?
> > Could you consider picking this patchset into x86 branch? This is a
> > clean up on kexec, while the last ARCH using it is x86.
> 
> I'll stick it in my queue to take a closer look.

Thanks.

