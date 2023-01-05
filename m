Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13365F684
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjAEWKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjAEWKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:10:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2A6950D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672956577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHRon4iazglsqJx0za5dkKZ1ECmTBS5D3uCSiao/wBQ=;
        b=UfaX5UpseIUGtu5RP8qjR0f7Bbm2PeiP0jBhECU5KHdaWTu3IX71womENc+lE+Nyw1Xxls
        c1K8PY9VSMYC6Xv1tVD9b024nokR5ZGhT/AOJlfDQrVw4XfWfsZOo7yZ9V2xzlu44PTz7j
        QFzugBAq4FWJIuLJ5R8HBNNzNZjJUzM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-foaa4ylmMIuwR0Mp-0GZKA-1; Thu, 05 Jan 2023 17:09:33 -0500
X-MC-Unique: foaa4ylmMIuwR0Mp-0GZKA-1
Received: by mail-io1-f72.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so11486436iow.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHRon4iazglsqJx0za5dkKZ1ECmTBS5D3uCSiao/wBQ=;
        b=wd9/QoQIc2Mr0w6NjWW1qCpuuC5sq4h04HTcMxp2KtCdfJM651wheJWeQDGLW8vFbv
         6GM4EGftYeM8Miq5mE6rA+chRn488E7XUPCOVI7qArObv/wzrsxLz0zKTLYNU6NbW3S+
         bECshICqNKtGfy+J9DXe7alUKk64zNZkMkibVW+KpDUO1wu6m7ptdz5fKlPTOOZGESMn
         5yGamlOAEhsq0JFOtXn+4i9glj9TGvIju1yI213atDgmGt0/jvfwGA/+U9k2Or7sCAlx
         8mG9/a5YRHqbY324rAMXvvgS1GsiMTxoG9HvSIsOvOc2mQbC+fgNAcbcKOp7OGyaKHCM
         H8FQ==
X-Gm-Message-State: AFqh2koyUq5aFwXjOglZZDPJArabyKJ1McbK9P252udVTblELYiZvytU
        O+I1GKPtSsw7YT3MHMgalsxkAYx8vt/9BWP/FbeLISi5JFVcd4I84GlDIZDAYynYtN+L30RiAZr
        +q++fwuiHFgyl85m4DQca1XsG
X-Received: by 2002:a5e:a609:0:b0:6e4:2893:2b33 with SMTP id q9-20020a5ea609000000b006e428932b33mr32962716ioi.14.1672956573186;
        Thu, 05 Jan 2023 14:09:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs5yKX/wdLm9HEyg87onxVqgfS0N/eR1/PgmgN9uAH7OlTthfhrG0MhtGAnQyZQ6XYAeeVAMA==
X-Received: by 2002:a5e:a609:0:b0:6e4:2893:2b33 with SMTP id q9-20020a5ea609000000b006e428932b33mr32962706ioi.14.1672956572929;
        Thu, 05 Jan 2023 14:09:32 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w12-20020a5e970c000000b006e3170eeee4sm13692498ioj.6.2023.01.05.14.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:09:32 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:09:30 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     jgg@nvidia.com, cohuck@redhat.com, borntraeger@linux.ibm.com,
        jjherne@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, hch@infradead.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/1] vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
Message-ID: <20230105150930.6ee65182.alex.williamson@redhat.com>
In-Reply-To: <20220519183311.582380-2-mjrosato@linux.ibm.com>
References: <20220519183311.582380-1-mjrosato@linux.ibm.com>
        <20220519183311.582380-2-mjrosato@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 14:33:11 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Rather than relying on a notifier for associating the KVM with
> the group, let's assume that the association has already been
> made prior to device_open.  The first time a device is opened
> associate the group KVM with the device.
> 
> This fixes a user-triggerable oops in GVT.

It seems this has traded an oops for a deadlock, which still exists
today in both GVT-g and vfio-ap.  These are the only vfio drivers that
care about kvm, so they make use of kvm_{get,put}_kvm(), where the
latter is called by their .close_device() callbacks.

.close_device() is called holding the group->group_lock, or at the time
of this commit group->group_rwsem.  The remaining call chain looks like
this:

kvm_put_kvm
 -> kvm_destroy_vm
  -> kvm_destroy_devices
   -> kvm_vfio_destroy
    -> kvm_vfio_file_set_kvm
     -> vfio_file_set_kvm
      -> group->group_lock/group_rwsem

Any suggestions for a fix?  Thanks,

Alex

