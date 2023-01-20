Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5F675C55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjATR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjATR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7794C8A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmRfpj48RyjRyZDGGPZo2d8kT+rAwJ1anTjm2/PHafk=;
        b=TyBKQjbEcKKajw7PDEF0Ig/cbAnPhKR9IUYDxsNGj3EyQ+LQpnrRj9k/rfIttKamnJVBFf
        /DjEbia6lWmCsEc7dXkHrD/p3Zdpa6GTTGHAvL9fUDNE72QUbXiRIjD+Kfe2IvbrzQRCce
        0znWtQjgFOuQ7Ao4w4dEBl+yjWMdWdg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-PRh6t_I8PK-D1Tr0jlm9aQ-1; Fri, 20 Jan 2023 12:58:41 -0500
X-MC-Unique: PRh6t_I8PK-D1Tr0jlm9aQ-1
Received: by mail-il1-f200.google.com with SMTP id j11-20020a056e02218b00b0030f3e7a27a8so3815437ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmRfpj48RyjRyZDGGPZo2d8kT+rAwJ1anTjm2/PHafk=;
        b=e2hMeRTWSyaMMXIdeP9ZfUGb3g8zsMFmHkH7s9dN926Kank4uZymJx16Y5LaR+1Bph
         pEJDBUy+jgWvnKgnsQ0EeCK4wKMuCQERnEIFLW+/sH/dNLPKxf7XxCbppyCm/0DEvWEO
         OI5TorJspjYp6mljucwINyR2Hr6oXpOmhfO+ns4NXXhjgA5ZFDv4ti4/LdVmHBvzaytG
         2YM1q53FZa3inijhpLOwlc+2ZxtJ0GfAByR7Fuq04v399ksljRNfE1vP3oDp1z/B0O6D
         dP/pm+y/Kc8PEXJBMwIxq1V61zk7cETYo6wGZ/Iilw+WakIFccR29vU2b4+f9Uc0L4p3
         25Pw==
X-Gm-Message-State: AFqh2kp1bTi6jo3m1TVK8THjqNQmheNAmFQ/zQtXNBeZlGFciDABOORX
        L2jhl3Yt8vutqTNPjkWCSAKaigVWOUkGfnHa1+upkOJcGv06cIQScdpx+Utu1qoBaPcd+2nYWds
        AW2MCybO8CxkS5rRX9+LM+GE3
X-Received: by 2002:a5d:91ce:0:b0:704:ce06:81fd with SMTP id k14-20020a5d91ce000000b00704ce0681fdmr10190697ior.12.1674237520796;
        Fri, 20 Jan 2023 09:58:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWHZw0KBjfw/OOejn5eFckg+3ECBCwnEWHdhh2gOLwwb1mg/roN1/n+BWFUPswaGH+Cbf2rg==
X-Received: by 2002:a5d:91ce:0:b0:704:ce06:81fd with SMTP id k14-20020a5d91ce000000b00704ce0681fdmr10190681ior.12.1674237520535;
        Fri, 20 Jan 2023 09:58:40 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id j2-20020a026302000000b0038a48cfededsm12514918jac.15.2023.01.20.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:58:40 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:58:37 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     pbonzini@redhat.com, mjrosato@linux.ibm.com, jgg@nvidia.com,
        kevin.tian@intel.com, cohuck@redhat.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com,
        akrowiak@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, seanjc@google.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm/vfio: Fix potential deadlock on vfio group_lock
Message-ID: <20230120105837.254a0b0a.alex.williamson@redhat.com>
In-Reply-To: <20230120150528.471752-1-yi.l.liu@intel.com>
References: <20230120150528.471752-1-yi.l.liu@intel.com>
Organization: Red Hat
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

On Fri, 20 Jan 2023 07:05:28 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> Currently it is possible that the final put of a KVM reference comes from
> vfio during its device close operation.  This occurs while the vfio group
> lock is held; however, if the vfio device is still in the kvm device list,
> then the following call chain could result in a deadlock:
> 
> VFIO holds group->group_lock/group_rwsem
>   -> kvm_put_kvm
>    -> kvm_destroy_vm
>     -> kvm_destroy_devices
>      -> kvm_vfio_destroy
>       -> kvm_vfio_file_set_kvm
>        -> vfio_file_set_kvm
>         -> try to hold group->group_lock/group_rwsem  
> 
> The key function is the kvm_destroy_devices() which triggers destroy cb
> of kvm_device_ops. It calls back to vfio and try to hold group_lock. So
> if this path doesn't call back to vfio, this dead lock would be fixed.
> Actually, there is a way for it. KVM provides another point to free the
> kvm-vfio device which is the point when the device file descriptor is
> closed. This can be achieved by providing the release cb instead of the
> destroy cb. Also rename kvm_vfio_destroy() to be kvm_vfio_release().
> 
> 	/*
> 	 * Destroy is responsible for freeing dev.
> 	 *
> 	 * Destroy may be called before or after destructors are called
> 	 * on emulated I/O regions, depending on whether a reference is
> 	 * held by a vcpu or other kvm component that gets destroyed
> 	 * after the emulated I/O.
> 	 */
> 	void (*destroy)(struct kvm_device *dev);
> 
> 	/*
> 	 * Release is an alternative method to free the device. It is
> 	 * called when the device file descriptor is closed. Once
> 	 * release is called, the destroy method will not be called
> 	 * anymore as the device is removed from the device list of
> 	 * the VM. kvm->lock is held.
> 	 */
> 	void (*release)(struct kvm_device *dev);
> 
> Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  virt/kvm/vfio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 495ceabffe88..e94f3ea718e5 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -336,7 +336,7 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
>  	return -ENXIO;
>  }
>  
> -static void kvm_vfio_destroy(struct kvm_device *dev)
> +static void kvm_vfio_release(struct kvm_device *dev)
>  {
>  	struct kvm_vfio *kv = dev->private;
>  	struct kvm_vfio_group *kvg, *tmp;
> @@ -363,7 +363,7 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type);
>  static struct kvm_device_ops kvm_vfio_ops = {
>  	.name = "kvm-vfio",
>  	.create = kvm_vfio_create,
> -	.destroy = kvm_vfio_destroy,
> +	.release = kvm_vfio_release,
>  	.set_attr = kvm_vfio_set_attr,
>  	.has_attr = kvm_vfio_has_attr,
>  };

Applied to vfio for-linus branch for v6.2, along with Matthew's R-b,
the comment update, and the extra reference link.  Once we get a
linux-next build I'll send a pull request, along with Matthew's
reserved region fix.  Thanks,

Alex

