Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58B969125E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBIVEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBIVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626468AEB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675976634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hzi6znNyM3FxWtE65ukWP+Wt97TeNT+3DRNv4OIzVA=;
        b=bcKjwms9gIA1xSiyXvdU5/jv5K2JMEPV5/v15WOzPVY5cF+GztB+oy3Lk4LpddpKJ5oz9n
        J6iWMlKHumT1XpET9pDFRzaLHwLlmeYud0Eb5OQiFWWHeOf4jwLdySnB5Mc43mFIECXi47
        /nRqXE2SYRyW8cSUPtDDMYUGAIHMY3o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-e-G50aSCPT6XdiuKDAvg-Q-1; Thu, 09 Feb 2023 16:03:53 -0500
X-MC-Unique: e-G50aSCPT6XdiuKDAvg-Q-1
Received: by mail-io1-f71.google.com with SMTP id i8-20020a6b7908000000b007132e024fb5so2075526iop.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 13:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hzi6znNyM3FxWtE65ukWP+Wt97TeNT+3DRNv4OIzVA=;
        b=wwmJ4/Ymu4kReO5lLTFJxPvrbdHlno/GiAxiLVIjh/HOv2N1Jl+IGN76lAjb6RVee0
         f+PdFFp68Fz/CFYdxdTokhnBbTgcLoh0tq6EYduHyGjYAcktp7d/8OfiIr5gjlv+/XoD
         ks4d67WpEgmDgMWgEJm5+McQLPejOJgQCKZfEuekv269aiNFpDR7jA0NuzZaCFSpy9Pz
         aNlSElyPdIZxELY7ERHC/+/NSvYx6e2CCGPzXP5pditX2KIc4qd8znHkxclnysGgb+4q
         u4Z/EHgGoVf614/r/Cd/hDd7iJQNiEwXFEj+7+UtsXPL8ak+dLaQgZWWEoEum2AVffFl
         laOw==
X-Gm-Message-State: AO0yUKXXmM+uH3ZFGLSvoijYCGx5g2T+BurE5OsJd3JrN7WnLJe/5hnC
        MeBvwS9T6mp3hyZDGnREcve5bBSx0W8wC/E0z1G2gdtUCT1yJGrlsemR/366MTxLereh8psSABE
        U0ZBKyTksKahMbZJ+3jUIHiXu
X-Received: by 2002:a05:6602:2d13:b0:704:7be5:9537 with SMTP id c19-20020a0566022d1300b007047be59537mr14244252iow.20.1675976632537;
        Thu, 09 Feb 2023 13:03:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9rs8OA65lw6671PZ1PpYK2stGa0HAY3gcdYk+JO8kpoT0yBNh478fTTwihnUoCWW3Y7vCO2A==
X-Received: by 2002:a05:6602:2d13:b0:704:7be5:9537 with SMTP id c19-20020a0566022d1300b007047be59537mr14244210iow.20.1675976632268;
        Thu, 09 Feb 2023 13:03:52 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c5-20020a5ea905000000b0071cbf191687sm698346iod.55.2023.02.09.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:03:51 -0800 (PST)
Date:   Thu, 9 Feb 2023 14:03:26 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     pbonzini@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, akrowiak@linux.ibm.com,
        jjherne@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, seanjc@google.com,
        kevin.tian@intel.com, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] vfio: fix deadlock between group lock and kvm
 lock
Message-ID: <20230209140326.6957dca0.alex.williamson@redhat.com>
In-Reply-To: <20230203215027.151988-1-mjrosato@linux.ibm.com>
References: <20230203215027.151988-1-mjrosato@linux.ibm.com>
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

On Fri,  3 Feb 2023 16:50:25 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Hi Alex,
> 
> Here is the latest group_lock vs kvm lock deadlock fix + a non-fix
> follow-on to remove the kvm argument from vfio_device_open and
> vfio_device_first_open.
> 
> Changes from v3:
> * Remove device->group->kvm reference in vfio_main by passing the
>   kvm in (Kevin)
> * Slight re-organization to make it easier for cdev to build upon
>   this later and keep symmetry between get/put (Alex)
> * Add follow-on patch that removes unused kvm argument (Yi)
> 
> Changes from v2:
> * Relocate the new functions back to vfio_main and externalize to call
>   from group (Kevin) since cdev will need this too
> * s/vfio_kvm_*_kvm/vfio_device_*_kvm/ and only pass device as input.
>   Handle new kvm_ref_lock directly inside vfio_device_get_kvm (Alex)
> * Add assert_lockdep_held for dev_set lock (Alex)
> * Internalize error paths for vfio_device_get_kvm_safe and now return
>   void - either device->kvm is set with a ref taken or is NULL (Alex)
> * Other flow suggestions to make the call path cleaner - Thanks! (Alex)
> * Can't pass group->kvm to vfio_device_open, as it references the value
>   outside of new lock.  Pass device->kvm to minimize changes in this
>   fix (Alex, Yi)
> 
> Changes from v1:
> * use spin_lock instead of spin_lock_irqsave (Jason)
> * clear device->kvm_put as part of vfio_kvm_put_kvm (Yi)
> * Re-arrange code to avoid referencing the group contents from within
>   vfio_main (Kevin) which meant moving most of the code in this patch 
>   to group.c along with getting/dropping of the dev_set lock
> 
> Matthew Rosato (2):
>   vfio: fix deadlock between group lock and kvm lock
>   vfio: no need to pass kvm pointer during device open
> 
>  drivers/vfio/group.c     | 44 +++++++++++++++++++++----
>  drivers/vfio/vfio.h      | 18 +++++++++--
>  drivers/vfio/vfio_main.c | 70 +++++++++++++++++++++++++++++++++-------
>  include/linux/vfio.h     |  2 +-
>  4 files changed, 113 insertions(+), 21 deletions(-)
> 

Applied to vfio next branch for v6.3.  Thanks,

Alex

