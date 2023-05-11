Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663656FF6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbjEKQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEKQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9AE5E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683821230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MGlLbnpCq0gqjV9LAs8cLD+kUlHrxgJjrFlgPMgwWE=;
        b=Gvapv4jjrCjLY01xTNeYb191rNcIvbDIe45h8AIV46NI+XaHbBjbPc3uFoFLZF6jxHduXf
        Ytmus3WtazqdVw9keIRVx4Xtl83si0XyetHW8/zzRIBKll3STCR2a5lRXVsTpenq0wwOrK
        vBdKhaV/W1uRFCuwwVlLcCLtiB+8Mbg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-YCWg8TpmP--EK6cOcYIZhA-1; Thu, 11 May 2023 12:07:09 -0400
X-MC-Unique: YCWg8TpmP--EK6cOcYIZhA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760718e6878so1293691139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821228; x=1686413228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MGlLbnpCq0gqjV9LAs8cLD+kUlHrxgJjrFlgPMgwWE=;
        b=AfC+RCj/cGgRP+wslogEBsyCWo29N7wSZfLJrTc93DXuDYIqjY29PvHWP1yk4b80tI
         Pq3yD+vyBkG+j5/gIxYnW4+zzpLeHzK1DwjdE++3PzSoqb3CggMoHQzHPYMe9HqvP5D7
         5Ebxo4WX677tLsKQ54feaJALDGigSftIsaHxtCkoDlg11QpHi3rlKcCuu4QkdBhib46i
         E5dAyoxFDnzutuzjQ4baruEgxbHfX/d12X/1ABhOAHS1ZelU6kpdgkBpN+hAe5D7/qrl
         goFpk7Yw8Mog1zBLazNXWwTue7KYCKUijXtq+N7vUU4JE7dSzZQXaFjDIfOtOTCalkma
         I+3A==
X-Gm-Message-State: AC+VfDw1XiYXmBF6R1Vh8Yw86TFohAZwqqt+bMNf4I7LXV+wCRdrRRWY
        R2C3IP950itMQurveHkjhu12gUKVFT6UcOsPbwuMLTMwUYJY4VnCkZZnBR1tkiMWLu6vCmK7wGX
        QVeQv2dmqhLdRedKGP2WFmpgm
X-Received: by 2002:a92:d950:0:b0:328:6412:df0e with SMTP id l16-20020a92d950000000b003286412df0emr16457947ilq.29.1683821228643;
        Thu, 11 May 2023 09:07:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tukUJrVj1wrrpEM6kkFdaC+CQrut3RZr54Ry8cX3nUsKWd1Ny0OxWMK0l+RwvVEhRXnT9IQ==
X-Received: by 2002:a92:d950:0:b0:328:6412:df0e with SMTP id l16-20020a92d950000000b003286412df0emr16457932ilq.29.1683821228395;
        Thu, 11 May 2023 09:07:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id cs11-20020a056638470b00b0040bd3646d0dsm4247854jab.157.2023.05.11.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:07:07 -0700 (PDT)
Date:   Thu, 11 May 2023 10:07:06 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kevin.tian@intel.com,
        yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: take mmap write lock for io_remap_pfn_range
Message-ID: <20230511100706.63d420db.alex.williamson@redhat.com>
In-Reply-To: <ZFwBYtjL1V0r5WW3@nvidia.com>
References: <20230508125842.28193-1-yan.y.zhao@intel.com>
        <ZFkn3q45RUJXMS+P@nvidia.com>
        <20230508145715.630fe3ae.alex.williamson@redhat.com>
        <ZFwBYtjL1V0r5WW3@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 17:41:06 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 08, 2023 at 02:57:15PM -0600, Alex Williamson wrote:
> 
> > We already try to set the flags in advance, but there are some
> > architectural flags like VM_PAT that make that tricky.  Cedric has been
> > looking at inserting individual pages with vmf_insert_pfn(), but that
> > incurs a lot more faults and therefore latency vs remapping the entire
> > vma on fault.  I'm not convinced that we shouldn't just attempt to
> > remove the fault handler entirely, but I haven't tried it yet to know
> > what gotchas are down that path.  Thanks,  
> 
> I thought we did it like this because there were races otherwise with
> PTE insertion and zapping? I don't remember well anymore.

TBH, I don't recall if we tried a synchronous approach previously.  The
benefit of the faulting approach was that we could track the minimum
set of vmas which are actually making use of the mapping and throw that
tracking list away when zapping.  Without that, we need to add vmas
both on mmap and in vm_ops.open, removing only in vm_ops.close, and
acquire all the proper mm locking for each vma to re-insert the
mappings.

> I vaugely remember the address_space conversion might help remove the
> fault handler?

Yes, this did remove the fault handler entirely, it's (obviously)
dropped off my radar, but perhaps in the interim we could switch to
vmf_insert_pfn() and revive the address space series to eventually
remove the fault handling and vma list altogether.

For reference, I think this was the last posting of the address space
series:

https://lore.kernel.org/all/162818167535.1511194.6614962507750594786.stgit@omen/

Thanks,
Alex

