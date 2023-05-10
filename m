Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD06FD4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEJEMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJEMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A3184
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683691915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EhMhj5d/G7n1EDqnhcO4ODQXL3YvB1dKGcoGs91Uegg=;
        b=PVstt70vpgZWOf2wFoCSoxUVs7bPSv49sndew8G8pBcUdCjbUeONZxfLZbkilvxfT+6Ywm
        NUx41Pky9LCmQowOUtOf9E/fk9Hse2tBfjtd4xEkBVCYSnJfCWPewAYxrtLG/mripCSLia
        TQp/DosWckVH94Le37E/8N6U0r37/n4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-b1P_QNRuOCqoEZ1_-JsbBw-1; Wed, 10 May 2023 00:11:52 -0400
X-MC-Unique: b1P_QNRuOCqoEZ1_-JsbBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB3F529DD990;
        Wed, 10 May 2023 04:11:51 +0000 (UTC)
Received: from localhost (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B37A61121314;
        Wed, 10 May 2023 04:11:50 +0000 (UTC)
Date:   Wed, 10 May 2023 12:11:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: kexec: include reboot.h
Message-ID: <ZFsZg0fvPA2/eysa@MiWiFi-R3L-srv>
References: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
 <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
 <ZFo0Gd/Eucw/0gtC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFo0Gd/Eucw/0gtC@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/23 at 01:52pm, Simon Horman wrote:
> On Tue, May 09, 2023 at 05:01:42PM +0800, Baoquan He wrote:
> > On 05/09/23 at 09:01am, Simon Horman wrote:
> > > Include reboot.h in machine_kexec.c for declaration of
> > > machine_crash_shutdown and machine_shutdown.
> > > 
> > > gcc-12 with W=1 reports:
> > > 
> > >  arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
> > >     57 | void machine_crash_shutdown(struct pt_regs *regs)
> > >        |      ^~~~~~~~~~~~~~~~~~~~~~
> > >  arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
> > >     61 | void machine_shutdown(void)
> > >        |      ^~~~~~~~~~~~~~~~
> > > 
> > > No functional changes intended.
> > > Compile tested only.
> > > 
> > > Signed-off-by: Simon Horman <horms@kernel.org>
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> > We may need to find out the places in all architectures and fix all of
> > them.
> 
> I did check. It seemed to be needed for riscv, m68k and parisc.
> I've sent out patches for all three. But I may have missed something.

That's great, thanks. I didn't notice the other two.

