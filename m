Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10E6BA079
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCNUMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCNUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38321EFD7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678824709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wQYTp3YB8E8Qol6aRWb0q0ebKdxfSZQ88xnQL/Q0do=;
        b=E56unI+1cbX4ZmMXasSE/pWApmlgcMNuvDzarLWSvHTp21SklUPzfpCjbptpE4B5jVITYn
        OC05C2FRoLGVn7L3rIrnutZlr8K9vOBVVPgMha3gVAa4O/UW/OUHfoQTWkYSfgrCSHECk4
        M0CGc93AKvminC3q5KutwCn9//Xu+jI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-qEom4j0JNf6jV8mpa4ZE-g-1; Tue, 14 Mar 2023 16:11:48 -0400
X-MC-Unique: qEom4j0JNf6jV8mpa4ZE-g-1
Received: by mail-il1-f200.google.com with SMTP id b9-20020a926709000000b00322ffd64968so4515208ilc.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wQYTp3YB8E8Qol6aRWb0q0ebKdxfSZQ88xnQL/Q0do=;
        b=h0zhkOFYexn5EvCqQtvf1SQkYlkekZSJhSfWicaxnFulaK3KtAyk9RSkbKT7gdAPQX
         3+EOhbCzoa2566cZtNryH4QfcEhdNSrG+FnyQcEK2Ec5dhEwHcH3CsXomNq2jZD922/X
         OzhjF2meSKYce5sO44qrbxwlaWK8cgdoGML3gxIEFcrnSlZHo4ZL4fxFk+/A5UCZPTjb
         7uV22Gb4wjIfTrbYqyGgRaOPIPDq/B8GZd9jcmBuuO5kruNFxcReXx6cthgfDyLtUQPI
         FO7RFQ//qlFBTYzYiXV/vLIAweJU6WiQlt+QdmXYyx8yLXzLe2nqxMlckKbov1W9Uyju
         XsqQ==
X-Gm-Message-State: AO0yUKVc0Sik8xaKx5yamgqlYVnjcHKxW/tuwZElVbbpNB8mvrUVUcyf
        MCp7yTP06Z1n/6D8IGIJZukNkfng2YxnKItmqBrM6dO7E3oLOB9q2uzSkXWM2zmEyg2bP8kqX0G
        FfuZhX0LNneDWSvGwxcSQpPBH
X-Received: by 2002:a05:6e02:1aa6:b0:317:83ad:a2a2 with SMTP id l6-20020a056e021aa600b0031783ada2a2mr2902944ilv.10.1678824707651;
        Tue, 14 Mar 2023 13:11:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set+WFDrvIixXmlqMGu/bCY3ZmjaTxWtCpgpTEGZODyspTTPhzeQHSA5z9/Or1gn7wARcWXseMA==
X-Received: by 2002:a05:6e02:1aa6:b0:317:83ad:a2a2 with SMTP id l6-20020a056e021aa600b0031783ada2a2mr2902903ilv.10.1678824707351;
        Tue, 14 Mar 2023 13:11:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q1-20020a056e02096100b00314201bcbdfsm1079964ilt.3.2023.03.14.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:11:46 -0700 (PDT)
Date:   Tue, 14 Mar 2023 14:11:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
        dimitri.sivanich@hpe.com
Subject: Re: [PATCH v4 0/7] introduce vm_flags modifier functions
Message-ID: <20230314141144.6a0892e6.alex.williamson@redhat.com>
In-Reply-To: <20230126193752.297968-1-surenb@google.com>
References: <20230126193752.297968-1-surenb@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 11:37:45 -0800
Suren Baghdasaryan <surenb@google.com> wrote:

> This patchset was originally published as a part of per-VMA locking [1] and
> was split after suggestion that it's viable on its own and to facilitate
> the review process. It is now a preprequisite for the next version of per-VMA
> lock patchset, which reuses vm_flags modifier functions to lock the VMA when
> vm_flags are being updated.
> 
> VMA vm_flags modifications are usually done under exclusive mmap_lock
> protection because this attrubute affects other decisions like VMA merging
> or splitting and races should be prevented. Introduce vm_flags modifier
> functions to enforce correct locking.
> 
> The patchset applies cleanly over mm-unstable branch of mm tree.

With this series, vfio-pci developed a bunch of warnings around not
holding the mmap_lock write semaphore while calling
io_remap_pfn_range() from our fault handler, vfio_pci_mmap_fault().

I suspect vdpa has the same issue for their use of remap_pfn_range()
from their fault handler, JasonW, MST, FYI.

It also looks like gru_fault() would have the same issue, Dimitri.

In all cases, we're preemptively setting vm_flags to what
remap_pfn_range_notrack() uses, so I thought we were safe here as I
specifically remember trying to avoid changing vm_flags from the
fault handler.  But apparently that doesn't take into account
track_pfn_remap() where VM_PAT comes into play.

The reason for using remap_pfn_range() on fault in vfio-pci is that
we're mapping device MMIO to userspace, where that MMIO can be disabled
and we'd rather zap the mapping when that occurs so that we can sigbus
the user rather than allow the user to trigger potentially fatal bus
errors on the host.

Peter Xu has suggested offline that a non-lazy approach to reinsert the
mappings might be more inline with mm expectations relative to touching
vm_flags during fault.  What's the right solution here?  Can the fault
handling be salvaged, is proactive remapping the right approach, or is
there something better?  Thanks,

Alex

