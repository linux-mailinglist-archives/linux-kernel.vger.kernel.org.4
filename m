Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC2C6384B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKYHtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKYHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB51BEBB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669362500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRPsBSBQyhfeTTaChHcuZm+Fmx8hS4Qa4uHyK8Jl77Y=;
        b=ELkayWi2evqwTowyYogmal+K8OT9r7hLGGznKw2gADG8gChPrCLBB7VlrxZ1i2XxW7DEtV
        j/MQn+s9/4L82wUBYhiqIyjEu48QPH0G/zfrigh23RDh5xkEstDpscDrnByYu+gJYeYm9V
        e7uOjCrs+8z/O20BPZBjz84F/PHZ+ZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-Ynv4YcXcNXW3Tw_BrTn40w-1; Fri, 25 Nov 2022 02:48:17 -0500
X-MC-Unique: Ynv4YcXcNXW3Tw_BrTn40w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A429D180A38D;
        Fri, 25 Nov 2022 07:48:16 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E44D240C2064;
        Fri, 25 Nov 2022 07:48:15 +0000 (UTC)
Date:   Fri, 25 Nov 2022 15:48:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
Message-ID: <Y4BzPDRsiPiReFLt@MiWiFi-R3L-srv>
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv>
 <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BubEVKt78k8xaC@MiWiFi-R3L-srv>
 <CANiDSCuy-uZ4r2x6xujiPGTowzN8JuOvTXh3r0Rc7J+YmpqZiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCuy-uZ4r2x6xujiPGTowzN8JuOvTXh3r0Rc7J+YmpqZiw@mail.gmail.com>
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

On 11/25/22 at 08:31am, Ricardo Ribalda wrote:
> Hi
> 
> On Fri, 25 Nov 2022 at 08:27, Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > > Hi Baoquan
> > >
> > > Thanks for your review!
> > >
> > > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > > or DT.
> > > > >
> > > > > But if the crash kernel is not used, or is smaller than then
> > > > > area pre-allocated that memory is wasted.
> > > > >
> > > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > > use the crash kernel.
> > > > >
> > > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > > defined statically. Following the same memory allocation/validation path
> > > > > that for the reboot kexec kernel.
> > > >
> > > > We don't check if the crashkernel memory region is valid in kernel, but
> > > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > > got problem with lack of the checking in kernel.
> > >
> > > Not sure if I follow you.
> > >
> > > We currently check if the crash kernel is in the right place at
> > > sanity_check_segment_list()
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
> >
> > And it's not checking if crashkernel memory is valid in
> > sanity_check_segment_list(), right? It's checking if the segments
> > are placed correctly.
> 
> If it is not valid, then this condition is not met.

Yeah. BUT, even though it's valid, below condition could not be met
either. They are not the same thing. 

> 
> /* Ensure we are within the crash kernel limits */
> if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
>     (mend > phys_to_boot_phys(crashk_res.end)))
>           return -EADDRNOTAVAIL;
> 
> 
> >
> 
> 
> -- 
> Ricardo Ribalda
> 

