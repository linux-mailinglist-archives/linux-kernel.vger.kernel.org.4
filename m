Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC4A652CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiLUGDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiLUGDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4025921240
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671602545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFARvs3vX7F5UIgsIk8mEBbeBoqPfv+G3BzvbbBHE5g=;
        b=AxeJLbeC2q2KjRkpfVxrcacdHhLBz7P2AsCcEbfCXdrOMpugnn1z3IWZb75w/3QPqJwkt/
        ydCbgEX34sAno8Obc3o2q3we963H7G6QJENs9RDZY+tX/loXAxC+xHUgmlniiXwINUvO1w
        XedjzOL49BH8VGHt219vTaeb1Iaiwy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-H8M4KejGNnGeLNOea66BPA-1; Wed, 21 Dec 2022 01:02:22 -0500
X-MC-Unique: H8M4KejGNnGeLNOea66BPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B042858F09;
        Wed, 21 Dec 2022 06:02:21 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB5040C2064;
        Wed, 21 Dec 2022 06:02:20 +0000 (UTC)
Date:   Wed, 21 Dec 2022 14:02:17 +0800
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
Message-ID: <Y6KhaSHMsQoT3kfR@MiWiFi-R3L-srv>
References: <Y52Qg8OvU1UsGZGC@MiWiFi-R3L-srv>
 <20221217155842.GA389338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217155842.GA389338@bhelgaas>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

When tried to rebase my old patch to the latest kernel, I realized this
patchset is what I can end up with. I would like to ack this patchset
to make it merged. Thanks a lot for the effort.

