Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE655F3246
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJCPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJCPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D032EE9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664809427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlSyGCvWo5iRyh04tGy8TsPBqO2ZA147cE0Y4mnczLc=;
        b=USJFCXccCj2Be6seOZf8XImNPHJHxQQX3BPyrK6DdglOrKnjM0YBOweQkMzZ88aenDyJnE
        YJhL6h6EZ1S89ovU50h0vW56D7XDsA85OAAmleTCm8QqPxuk2TcOJ6358ZwNmSbT0WGCHU
        d3criHww3bnTFOm0c9iUyNS8ysMen0E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-nDrqRaY7OAuvnGd3jALs6w-1; Mon, 03 Oct 2022 11:03:44 -0400
X-MC-Unique: nDrqRaY7OAuvnGd3jALs6w-1
Received: by mail-wm1-f71.google.com with SMTP id g8-20020a05600c4ec800b003b4bcbdb63cso6411216wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zlSyGCvWo5iRyh04tGy8TsPBqO2ZA147cE0Y4mnczLc=;
        b=Zrs14fxwp4/JJe02+gM8vaesWPjvRc44FuzS9VR4ZeCh5d5oVaverAP9+xWM5enX4u
         s44NYijxHqSJLAHsNe1LTltGjcvPTTzjAXKuulyZD3J73G7jv3QtDqIF7PA6B46VQh4U
         wlJW6IZpcHg3cDnMDdJAK7rTnso0WoPGypa1yP1E1sKeugudujPyFcp0gd21oAtNopKH
         TzSr6lA21eftBKVBfJwOgVzU8WacaOOPJOrCJHXXOV1ANnJmAVcL5n3uhrMZgp26GF/D
         YfPC1qKS/7l1QaWe4FOKzwH69F5gczvlDAZVw2mRCGIb5NHnm6ftHmFtySY40uTntwsn
         FG0Q==
X-Gm-Message-State: ACrzQf2tjOeKDdXHxjo/4qJ4ehgyR+x9aMT2OSw01Up2T/Bs21u8T2SB
        +XWX7Qwd/XzXLNu8U0oR6zhtGkQHLfyyEvNqWV9e9go5E4GP5n8doxmQ5CyHRBHacHnnYA4A20g
        eZXETOzihB5Vp7I7j5x6BOuWc
X-Received: by 2002:a05:600c:4e8b:b0:3b4:c8ce:be87 with SMTP id f11-20020a05600c4e8b00b003b4c8cebe87mr7593512wmq.157.1664809423570;
        Mon, 03 Oct 2022 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sxlC5XJOgl9QDu564seFf1Ssz0/+BFurAjD66iPYPfhV1hEDgomWrdFD2cOYxCQVBT8cYyA==
X-Received: by 2002:a05:600c:4e8b:b0:3b4:c8ce:be87 with SMTP id f11-20020a05600c4e8b00b003b4c8cebe87mr7593479wmq.157.1664809423275;
        Mon, 03 Oct 2022 08:03:43 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a84375d0d1sm17657403wmq.44.2022.10.03.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:03:42 -0700 (PDT)
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
In-Reply-To: <B64FD502-E794-4E94-A267-D690476C57EE@vmware.com>
References: <9FEC6622-780D-41E6-B7CA-8D39EDB2C093@vmware.com>
 <87zgf3pfd1.fsf@redhat.com>
 <B64FD502-E794-4E94-A267-D690476C57EE@vmware.com>
Date:   Mon, 03 Oct 2022 17:03:41 +0200
Message-ID: <87tu4l9cfm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ajay Kaher <akaher@vmware.com> writes:

>> =EF=BB=BFOn 13/09/22, 7:05 PM, "Vitaly Kuznetsov" <vkuznets@redhat.com> =
wrote:
>>>
>>> Thanks Vitaly for your response.
>>>
>>> 1. we have multiple objects of struct pci_raw_ops, 2. adding 'priority'=
 field to struct pci_raw_ops
>>> doesn't seems to be appropriate as need to take decision which object o=
f struct pci_raw_ops has
>>> to be used, not something with-in struct pci_raw_ops.
>>
>> I'm not sure I follow, you have two instances of 'struct pci_raw_ops'
>> which are called 'raw_pci_ops' and 'raw_pci_ext_ops'. What if you do
>> something like (completely untested):
>>
>> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x=
86.h
>> index 70533fdcbf02..fb8270fa6c78 100644
>> --- a/arch/x86/include/asm/pci_x86.h
>> +++ b/arch/x86/include/asm/pci_x86.h
>> @@ -116,6 +116,7 @@ extern void (*pcibios_disable_irq)(struct pci_dev *d=
ev);
>> extern bool mp_should_keep_irq(struct device *dev);
>>
>> struct pci_raw_ops {
>> +       int rating;
>>          int (*read)(unsigned int domain, unsigned int bus, unsigned int=
 devfn,
>>                                                int reg, int len, u32 *va=
l);
>>          int (*write)(unsigned int domain, unsigned int bus, unsigned in=
t devfn,
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index ddb798603201..e9965fd11576 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -40,7 +40,8 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_op=
s;
>>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int de=
vfn,
>>                                                 int reg, int len, u32 *v=
al)
>> {
>> -       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
>> +       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops &&
>> +           (!raw_pci_ext_ops || raw_pci_ext_ops->rating <=3D raw_pci_op=
s->rating))
>>                 return raw_pci_ops->read(domain, bus, devfn, reg, len, v=
al);
>>         if (raw_pci_ext_ops)
>>                 return raw_pci_ext_ops->read(domain, bus, devfn, reg, le=
n, val);
>> @@ -50,7 +51,8 @@ int raw_pci_read(unsigned int domain, unsigned int bus=
, unsigned int devfn,
>>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int d=
evfn,
>>                                                 int reg, int len, u32 va=
l)
>> {
>> -       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
>> +       if (domain =3D=3D 0 && reg < 256 && raw_pci_ops &&
>> +           (!raw_pci_ext_ops || raw_pci_ext_ops->rating <=3D raw_pci_op=
s->rating))
>>                 return raw_pci_ops->write(domain, bus, devfn, reg, len, =
val);
>>          if (raw_pci_ext_ops)
>>                 return raw_pci_ext_ops->write(domain, bus, devfn, reg, l=
en, val);
>>
>> and then somewhere in Vmware hypervisor initialization code
>> (arch/x86/kernel/cpu/vmware.c) you do
>>
>>  raw_pci_ext_ops->rating =3D 100;
>
> Thanks Vitaly, for your review and helping us to improve the code.
>
> I was working to make changes as you suggested, but before sending v3 wou=
ld like to
> discuss on following:
>
> If we add rating with-in struct pci_raw_ops then we can't have pci_mmcfg =
as const,
> and following change is must in arch/x86/pci/mmconfig_64.c:
>
> -const struct pci_raw_ops pci_mmcfg =3D {
> +struct pci_raw_ops pci_mmcfg =3D {
>  	.read =3D		pci_mmcfg_read,
>  	.write =3D	pci_mmcfg_write,
> };
>
> So to avoid this change, is it fine to have global bool prefer_raw_pci_ex=
t_ops?
>
> And raw_pci_read() will have following change:
>
> -	if (domain =3D=3D 0 && reg < 256 && raw_pci_ops)
> +	if (domain =3D=3D 0 && reg < 256 && raw_pci_ops &&
> +	     (!prefer_raw_pci_ext_ops ||  !raw_pci_ext_ops)
>

Not my but rather PCI maintainer's call but IMHO dropping 'const' is
better, introducing a new global var is our 'last resort' and should be
avoided whenever possible. Alternatively, you can add a
raw_pci_ext_ops_preferred() function checking somethin within 'struct
hypervisor_x86' but I'm unsure if it's better.

Also, please check Alex' question/suggestion.

...

--=20
Vitaly

