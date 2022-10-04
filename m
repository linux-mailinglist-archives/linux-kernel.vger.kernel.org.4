Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7841B5F3E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJDIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJDIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3091F1B9F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664872215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kChJ5YXyR55NqzsspcQL6vhugqTTUyXdwpS+PG+Hins=;
        b=Kw3r1QGtzzhZ35c/9Zi8Rv0Ekgzwp9oFMTLNmk/ghIaiSYWROlgguAh0VClghWCuyBkUkt
        EDXih7xDwahOFuPpIBzvMZ/fj5pLiisy/HKwfW5upYQfCfaRTppFdI8o/F3/MZ+YiZqN+B
        ORwpCMd5FL8tDUTt31RsF6zG8Cqqc3Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-dHpftQ3tO1CejMOQxSKHdw-1; Tue, 04 Oct 2022 04:30:13 -0400
X-MC-Unique: dHpftQ3tO1CejMOQxSKHdw-1
Received: by mail-ed1-f70.google.com with SMTP id m10-20020a056402430a00b0045968bb0874so415759edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kChJ5YXyR55NqzsspcQL6vhugqTTUyXdwpS+PG+Hins=;
        b=yoqt78ZNRwm9lhVGSA5A5ItSBlF1KSDYSM+ut8i49NsJgultiCsDSGlGoYEHHGlzKo
         EBAElej+EKuDn8OLq7Q+WGXzi1daRa2ri7ZcvJ+qPqRTh7rI1wPjXGiD2Brv07Me+KoW
         z8A0r4kTJxYKijNiamOxYSPNDN0wq3lSf9Y0Ll0yXTfcy2BxqxFRm/Pi0vmqyqhZJrUG
         glOisOtBqzfqzijK6TLUF48RGKn/taLWVmgoeAx5QHjU0vDdIP2tgrQPlbWHIPcc5Xfg
         DKGw7hWGka+QKJWvr5LXNY1jJXC4mzxYmrQ7jhUECCC8SoS3rAORwtGf4d6Z6GcAfzDY
         I5ZQ==
X-Gm-Message-State: ACrzQf1Rokk5jrde17a2K7/GB03pqk/cNScOIOV/xu7DRWwxR8eR5kIz
        pqqwtPg5uRWqQGbiYdDfyCDajC6AQETJchd90O6TxTk7aUD5BsUlEcFH5vPDWsmCYbT5DKgyp1V
        MOgVCtTldS5sPyyo7W7BPMdFb
X-Received: by 2002:a17:907:1626:b0:782:e490:4f4 with SMTP id hb38-20020a170907162600b00782e49004f4mr18347588ejc.464.1664872212801;
        Tue, 04 Oct 2022 01:30:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4V1XegvfHQqtOdwuF9hkqqgOAv0Ct2ylqgG/E0UdTe0kkF9v3n5AapSW1/X/ZGX1Jj9DACkw==
X-Received: by 2002:a17:907:1626:b0:782:e490:4f4 with SMTP id hb38-20020a170907162600b00782e49004f4mr18347564ejc.464.1664872212563;
        Tue, 04 Oct 2022 01:30:12 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id by30-20020a0564021b1e00b004590d4e35cdsm1198745edb.54.2022.10.04.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:30:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nadav Amit <namit@vmware.com>, Alexander Graf <graf@amazon.com>,
        Ajay Kaher <akaher@vmware.com>
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
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jailhouse-dev@googlegroups.com" <jailhouse-dev@googlegroups.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "acrn-dev@lists.projectacrn.org" <acrn-dev@lists.projectacrn.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/PCI: Prefer MMIO over PIO on all hypervisor
In-Reply-To: <04F550C5-786A-4B8E-9A88-EBFBD8872F16@vmware.com>
References: <9FEC6622-780D-41E6-B7CA-8D39EDB2C093@vmware.com>
 <87zgf3pfd1.fsf@redhat.com>
 <B64FD502-E794-4E94-A267-D690476C57EE@vmware.com>
 <87tu4l9cfm.fsf@redhat.com>
 <04F550C5-786A-4B8E-9A88-EBFBD8872F16@vmware.com>
Date:   Tue, 04 Oct 2022 10:30:10 +0200
Message-ID: <87lepw9ejx.fsf@redhat.com>
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

Nadav Amit <namit@vmware.com> writes:

> On Oct 3, 2022, at 8:03 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
>> Not my but rather PCI maintainer's call but IMHO dropping 'const' is
>> better, introducing a new global var is our 'last resort' and should be
>> avoided whenever possible. Alternatively, you can add a
>> raw_pci_ext_ops_preferred() function checking somethin within 'struct
>> hypervisor_x86' but I'm unsure if it's better.
>>=20
>> Also, please check Alex' question/suggestion.
>
> Here is my take (and Ajay knows probably more than me):
>
> Looking briefly on MCFG, I do not see a clean way of using the ACPI table.
> The two options are either to use a reserved field (which who knows, might
> be used one day) or some OEM ID. I am also not familiar with
> PCI_COMMAND.MEMORY=3D0, so Ajay can hopefully give some answer about that.
>
> Anyhow, I understand (although not relate) to the objection for a new glo=
bal
> variable. How about explicitly calling this hardware bug a =E2=80=9Cbug=
=E2=80=9D and using
> the proper infrastructure? Calling it explicitly a bug may even push whoe=
ver
> can to resolve it.
>
> IOW, how about doing something along the lines of (not tested):
>

Works for me. Going forward, the intention shoud be to also clear the
bug on other x86 hypervisors, e.g. we test modern Hyper-V versions and
if MMIO works well we clear it, we test modern QEMU/KVM setups and if
MMIO works introduce a feature bit somewhere and also clear the bug in
the guest when the bit is set.

--=20
Vitaly

