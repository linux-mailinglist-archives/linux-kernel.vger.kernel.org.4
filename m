Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF6655321
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiLWROa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiLWRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445815A10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671815624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eb0BAdSoWLL6YDH6AUHQiZmOkpjD6NnUImZGH+0Mc0=;
        b=Yn8NWxvNm5Kt811Q3dHhQDtGxitTXPwUfzqC/p7BE/u39wNfJEb9jwXTktn6IxU/q3nY9p
        Uamr0Hk55bSIrpQt2LW7ROYBT7AMrNchAGLHQRGkbMRIWjY9ARvBrOklUB4GEkNxTs2rR1
        3lCEMQP3T9/KiIUD6pY3XvJK9qW0ZYg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-T2_jo6AdNnauZIOL4osOcw-1; Fri, 23 Dec 2022 12:13:42 -0500
X-MC-Unique: T2_jo6AdNnauZIOL4osOcw-1
Received: by mail-ej1-f70.google.com with SMTP id qk40-20020a1709077fa800b007eeb94ecdb5so3767068ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eb0BAdSoWLL6YDH6AUHQiZmOkpjD6NnUImZGH+0Mc0=;
        b=JFIQHFyQynnZ0n001btplpvIXBqPlxy3Qs1aWXAX1c17h9rbUpvJBwkyCQSpJbuza+
         UAVHHiCKwdTNDajFjmEz7Re8qySQE8n04eJMhSowIc5ib2Ku2jQqVsmlCInWIkxcvfBd
         3cXc0j/vYT10GecxPM7QcXIPiQ/v4wo1VUVvhUOS2aABBAXEtIiIgJU/FMpcODUVRR4R
         fv4tOzHWoCCYFpTmZsnWMEXH1sqYkVNxOLkTZtT3BpK/2GmgdpSMRaVUOXrj5B1Zmxdo
         QGK/AMfiCfJy8R3QyeEem5QOApc4sm4o67K+eeHtz3WXpmxTTd3w4/001ZaQubhoWRte
         sfTA==
X-Gm-Message-State: AFqh2kp9jce1l0xc6a//UsR5PCPnrU+Q1qWbOQReNkPYzULDVgymON0+
        199hYncSQG1S3SmYsA0clfBS5TWCBr9uu13d9bcK1vUNVyZ47rG0zSoWKkQT5D6XTXlslkdL5xF
        2sxvdCxevizx8CLZPDgbSqsUV
X-Received: by 2002:a17:907:1ca5:b0:7c0:edc9:9a6b with SMTP id nb37-20020a1709071ca500b007c0edc99a6bmr11224823ejc.41.1671815621488;
        Fri, 23 Dec 2022 09:13:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs+cBOj2fOxow0vidv8f02JoIAEXM9YYD4MTbbmun2h5rqqt+qnvT5yYzyk7B7rZeDSSIiZyA==
X-Received: by 2002:a17:907:1ca5:b0:7c0:edc9:9a6b with SMTP id nb37-20020a1709071ca500b007c0edc99a6bmr11224808ejc.41.1671815621242;
        Fri, 23 Dec 2022 09:13:41 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906292900b0073dd8e5a39fsm1549860ejd.156.2022.12.23.09.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 09:13:40 -0800 (PST)
Message-ID: <84acd990-3040-c3ee-c56f-6647900ca30f@redhat.com>
Date:   Fri, 23 Dec 2022 18:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] KVM: Destroy target device if coalesced MMIO
 unregistration fails
Content-Language: en-US
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
References: <20221219171924.67989-1-seanjc@google.com>
 <DS0PR11MB637301E9103F92EE5617D5B2DCEA9@DS0PR11MB6373.namprd11.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <DS0PR11MB637301E9103F92EE5617D5B2DCEA9@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 04:04, Wang, Wei W wrote:
> Another option is to let kvm_io_bus_unregister_dev handle this, and no need for callers
> to make the extra kvm_iodevice_destructor() call. This simplifies the usage for callers
> (e.g. reducing LOCs and no leakages like this):

Can you send this as a patch?  Thanks!

Paolo

> diff --git a/include/kvm/iodev.h b/include/kvm/iodev.h
> index d75fc4365746..56619e33251e 100644
> --- a/include/kvm/iodev.h
> +++ b/include/kvm/iodev.h
> @@ -55,10 +55,4 @@ static inline int kvm_iodevice_write(struct kvm_vcpu *vcpu,
>                                   : -EOPNOTSUPP;
>   }
> 
> -static inline void kvm_iodevice_destructor(struct kvm_io_device *dev)
> -{
> -       if (dev->ops->destructor)
> -               dev->ops->destructor(dev);
> -}
> -
>   #endif /* __KVM_IODEV_H__ */
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 0be80c213f7f..d7135a5e76f8 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -195,7 +195,6 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
>                           */
>                          if (r)
>                                  break;
> -                       kvm_iodevice_destructor(&dev->dev);
>                  }
>          }
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 2a3ed401ce46..1b277afb545b 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -898,7 +898,6 @@ kvm_deassign_ioeventfd_idx(struct kvm *kvm, enum kvm_bus bus_idx,
>                  bus = kvm_get_bus(kvm, bus_idx);
>                  if (bus)
>                          bus->ioeventfd_count--;
> -               ioeventfd_release(p);
>                  ret = 0;
>                  break;
>          }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 13e88297f999..582757ebdce6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5200,6 +5200,12 @@ static struct notifier_block kvm_reboot_notifier = {
>          .priority = 0,
>   };
> 
> +static void kvm_iodevice_destructor(struct kvm_io_device *dev)
> +{
> +       if (dev->ops->destructor)
> +               dev->ops->destructor(dev);
> +}
> +
>   static void kvm_io_bus_destroy(struct kvm_io_bus *bus)
>   {
>          int i;
> @@ -5423,7 +5429,7 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>   int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>                                struct kvm_io_device *dev)
>   {
> -       int i, j;
> +       int i;
>          struct kvm_io_bus *new_bus, *bus;
> 
>          lockdep_assert_held(&kvm->slots_lock);
> @@ -5453,18 +5459,18 @@ int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>          rcu_assign_pointer(kvm->buses[bus_idx], new_bus);
>          synchronize_srcu_expedited(&kvm->srcu);
> 
> -       /* Destroy the old bus _after_ installing the (null) bus. */
> +       /*
> +        * If (null) bus is installed, destroy the old bus, including all the
> +        * attached devices. Otherwise, destroy the caller's device only.
> +        */
>          if (!new_bus) {
>                  pr_err("kvm: failed to shrink bus, removing it completely\n");
> -               for (j = 0; j < bus->dev_count; j++) {
> -                       if (j == i)
> -                               continue;
> -                       kvm_iodevice_destructor(bus->range[j].dev);
> -               }
> +               kvm_io_bus_destroy(bus);
> +               return -ENOMEM;
>          }
> 
> -       kfree(bus);
> -       return new_bus ? 0 : -ENOMEM;
> +       kvm_iodevice_destructor(dev);
> +       return 0;
>   }
> 
>   struct kvm_io_device *kvm_io_bus_get_dev(struct kvm *kvm, enum kvm_bus bus_idx,

