Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341475B6E71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiIMNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIMNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4F140BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663076095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vptXUYceNtwYVyKwfHyA3dKZqDg4HJHh7ydKyqgQ4H0=;
        b=JhtAJGZD/PsBYFyq2DPbEYIemosrKMoujKr6rsqtIT9jzUPQA6ZofzmlCa/z9K3xJmvoxu
        iriX5bc3IHg/6R/SsyaXMZ0AzQpuJtLhGsBIyyiGPI+g1UCGaLwqbgVRenqWV85z+med7R
        3dJtDI3QYXAuxBGRAQ/lEPRe2fIpI7w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-avRU6tKgP7m1jPFk0p9MbA-1; Tue, 13 Sep 2022 09:34:54 -0400
X-MC-Unique: avRU6tKgP7m1jPFk0p9MbA-1
Received: by mail-ed1-f72.google.com with SMTP id p4-20020a056402500400b00447e8b6f62bso8485987eda.17
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vptXUYceNtwYVyKwfHyA3dKZqDg4HJHh7ydKyqgQ4H0=;
        b=HpGSQP+DT3O5HA1ljfTVsb+y43yRk788LhBl97NuS58lqOtk2HGSpRO0ABzuyH4Erw
         nV7ay5uastYj1AFq4egKSqVPstHmE8rK5wtRFsiR8Rh+b09eBiLCNv09CJKGbt2/Jl4E
         HAy5pRRdspKAExeUZUpde1J3987351AJ19+gNZEwo1a0MVmI+IM2PjFVqJp/1z+b5SGt
         HA3jksPy5ELJG3ssV8SU+5oOdyX/u0yPep7zJc7cHMNOfp6gHYkGTQsACg1rvzD02W33
         0cNWb61m1JJ8qziCnb30yfyz8urXruSFJ56nQcl4W4qqcHaQES+/COzD5HyOm0Zm9SXc
         VDjw==
X-Gm-Message-State: ACgBeo1IibwB/LvuOZpU+CmDgUrX7R0zML9QZOy0HegE9/tq87y2Z4a1
        UBJkQ8qTK/gSHKHoOeCYsL5y2DlS/P/GrQRWZ3SjGLYeKem6bBBAEMEFiiFXC5v+5wrY1JQ0FI0
        7lDC/8jqYYQWd8YoR32/Mv8jC
X-Received: by 2002:a17:907:7f91:b0:77f:c4c7:9155 with SMTP id qk17-20020a1709077f9100b0077fc4c79155mr3137419ejc.476.1663076093151;
        Tue, 13 Sep 2022 06:34:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6avRwtqutArvSmcEzg7QncTSscL/a0gwHDnK2tQKDnZWQ3sHpo7gh8eU4Pf6A1+IXk9R/ikw==
X-Received: by 2002:a17:907:7f91:b0:77f:c4c7:9155 with SMTP id qk17-20020a1709077f9100b0077fc4c79155mr3137408ejc.476.1663076092870;
        Tue, 13 Sep 2022 06:34:52 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b00730b61d8a5esm6099500eju.61.2022.09.13.06.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 06:34:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jailhouse-dev@googlegroups.com" <jailhouse-dev@googlegroups.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "acrn-dev@lists.projectacrn.org" <acrn-dev@lists.projectacrn.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH v2] x86/PCI: Prefer MMIO over PIO on all hypervisor
In-Reply-To: <9FEC6622-780D-41E6-B7CA-8D39EDB2C093@vmware.com>
References: <9FEC6622-780D-41E6-B7CA-8D39EDB2C093@vmware.com>
Date:   Tue, 13 Sep 2022 15:34:50 +0200
Message-ID: <87zgf3pfd1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ajay Kaher <akaher@vmware.com> writes:

> Note: Corrected the Subject.
>
>> =EF=BB=BFOn 07/09/22, 8:50 PM, "Vitaly Kuznetsov" <vkuznets@redhat.com> =
wrote:
>>
>>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>>> index ddb7986..1e5a8f7 100644
>>> --- a/arch/x86/pci/common.c
>>> +++ b/arch/x86/pci/common.c
>>> @@ -20,6 +20,7 @@
>>>  #include <asm/pci_x86.h>
>>>  #include <asm/setup.h>
>>>  #include <asm/irqdomain.h>
>>> +#include <asm/hypervisor.h>
>>>
>>>  unsigned int pci_probe =3D PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROB=
E_CONF2 |
>>>                               PCI_PROBE_MMCONF;
>>> @@ -57,14 +58,58 @@ int raw_pci_write(unsigned int domain, unsigned int=
 bus, unsigned int devfn,
>>>       return -EINVAL;
>>>  }
>>>
>>> +#ifdef CONFIG_HYPERVISOR_GUEST
>>> +static int vm_raw_pci_read(unsigned int domain, unsigned int bus, unsi=
gned int devfn,
>>> +                                             int reg, int len, u32 *va=
l)
>>> +{
>>> +     if (raw_pci_ext_ops)
>>> +             return raw_pci_ext_ops->read(domain, bus, devfn, reg, len=
, val);
>>> +     if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
>>> +             return raw_pci_ops->read(domain, bus, devfn, reg, len, va=
l);
>>> +     return -EINVAL;
>>> +}
>>> +
>>> +static int vm_raw_pci_write(unsigned int domain, unsigned int bus, uns=
igned int devfn,
>>> +                                             int reg, int len, u32 val)
>>> +{
>>> +     if (raw_pci_ext_ops)
>>> +             return raw_pci_ext_ops->write(domain, bus, devfn, reg, le=
n, val);
>>> +     if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
>>> +             return raw_pci_ops->write(domain, bus, devfn, reg, len, v=
al);
>>> +     return -EINVAL;
>>> +}
>>
>> These look exactly like raw_pci_read()/raw_pci_write() but with inverted
>> priority. We could've added a parameter but to be more flexible, I'd
>> suggest we add a 'priority' field to 'struct pci_raw_ops' and make
>> raw_pci_read()/raw_pci_write() check it before deciding what to use
>> first. To be on the safe side, you can leave raw_pci_ops's priority
>> higher than raw_pci_ext_ops's by default and only tweak it in
>> arch/x86/kernel/cpu/vmware.c
>
> Thanks Vitaly for your response.
>
> 1. we have multiple objects of struct pci_raw_ops, 2. adding 'priority' f=
ield to struct pci_raw_ops
> doesn't seems to be appropriate as need to take decision which object of =
struct pci_raw_ops has
> to be used, not something with-in struct pci_raw_ops.

I'm not sure I follow, you have two instances of 'struct pci_raw_ops'
which are called 'raw_pci_ops' and 'raw_pci_ext_ops'. What if you do
something like (completely untested):

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 70533fdcbf02..fb8270fa6c78 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -116,6 +116,7 @@ extern void (*pcibios_disable_irq)(struct pci_dev *dev);
 extern bool mp_should_keep_irq(struct device *dev);
=20
 struct pci_raw_ops {
+       int rating;
        int (*read)(unsigned int domain, unsigned int bus, unsigned int dev=
fn,
                                                int reg, int len, u32 *val);
        int (*write)(unsigned int domain, unsigned int bus, unsigned int de=
vfn,
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index ddb798603201..e9965fd11576 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -40,7 +40,8 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
                                                int reg, int len, u32 *val)
 {
-       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
+       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops &&
+           (!raw_pci_ext_ops || raw_pci_ext_ops->rating <=3D raw_pci_ops->=
rating))
                return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
        if (raw_pci_ext_ops)
                return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, =
val);
@@ -50,7 +51,8 @@ int raw_pci_read(unsigned int domain, unsigned int bus, u=
nsigned int devfn,
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devf=
n,
                                                int reg, int len, u32 val)
 {
-       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
+       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops &&
+           (!raw_pci_ext_ops || raw_pci_ext_ops->rating <=3D raw_pci_ops->=
rating))
                return raw_pci_ops->write(domain, bus, devfn, reg, len, val=
);
        if (raw_pci_ext_ops)
                return raw_pci_ext_ops->write(domain, bus, devfn, reg, len,=
 val);

and then somewhere in Vmware hypervisor initialization code
(arch/x86/kernel/cpu/vmware.c) you do

 raw_pci_ext_ops->rating =3D 100;

why wouldn't it work?=20

(diclaimer: completely untested, raw_pci_ops/raw_pci_ext_ops
initialization has to be checked so 'rating' is not garbage).

>
> It's a generic solution for all hypervisor (sorry for earlier wrong
> Subject), not specific to VMware. Further looking for feedback if it's
> impacting to any hypervisor.

That's the tricky part. We can check modern hypervisor versions, but
what about all other versions in existence? How can we know that there's
no QEMU/Hyper-V/... version out there where MMIO path is broken? I'd
suggest we limit the change to Vmware hypervisor, other hypervisors may
use the same mechanism (like the one above) later (but the person
suggesting the patch is always responsible for the research why it is
safe to do so).

--=20
Vitaly

