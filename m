Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DAA6C34D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCUOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCUOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D31ABED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679410474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDOd2zDlUp3XynZRBEciyJxiXKaJOZb5vSM1x4tXnxc=;
        b=PJNojmOlIPsvKzeAZfR4zRDqC+YQQGxJ9hh4umHZyNVody2lp/UEMfW1AF4vmHtrw0G5Ju
        S/jbiFB0geyMRvAEIqFA7R+bXxoQbh5QqsXVCsl8n1lVo/XDNxE94tZ4CImjQ7cFbaQP+w
        P8Pv0H3GJ07aQiWcPvAbb+FTYV0P6Qw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-OrJK9JjHPRS9GWxfG0Ujnw-1; Tue, 21 Mar 2023 10:54:33 -0400
X-MC-Unique: OrJK9JjHPRS9GWxfG0Ujnw-1
Received: by mail-ed1-f70.google.com with SMTP id s30-20020a508d1e000000b005005cf48a93so11157730eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410472;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDOd2zDlUp3XynZRBEciyJxiXKaJOZb5vSM1x4tXnxc=;
        b=CdGZSqCeYNjs7f7Gy8OVk1iCvV5Vs7WKnkLEdFyuEoYA1JgdcbA4fSpST7axDx3UL+
         d7EgQWgfqrK1HchBsLoIdDkWDdvYqkG/nLlfbc8ehIiG3E/ud/hsV6cGO0hSA/A0bpzD
         KH+ZmQJhcV9lVT8aa06Zi0PPjYEA/JGxZ0fFt2a+63P1tENbmMZW75nb7Muf1MZ9X0zL
         1eY6GiQlnBf6IJ4y3TOr5JA01cp1TjLZHSqu7EwcjoRbmbmBfRtKF75e1S8Ez5W7gpE/
         T2pDW+OTsWFwIetGf3RWgI+oOPK/+CtbyXTvcl/dxLUZE1p+dXCEHEcCNN9KSkCbVyU/
         v8ag==
X-Gm-Message-State: AO0yUKVE3AKNE/8DdXu5LKYRY61Nw/D7EgvnSdNghemFe6ttXYwDy0PK
        gkvs3JNDD0JFRjQ0c6BHw4Nx+q+GovwOQIlGaXIHQALevZCQLGgBUxGH3rFLowwONulXzWhBHEo
        EsZb6uga3TFH9Zj4kvhbToTB94OdFudgm
X-Received: by 2002:a05:6402:488:b0:4fb:de7d:b05a with SMTP id k8-20020a056402048800b004fbde7db05amr2921267edv.40.1679410471909;
        Tue, 21 Mar 2023 07:54:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set9SCosURDLVeQrzecFcayr4BLzaAe8HKC09/+MUZOIZlQX7DY76j2ex8vA3Wm4t4NAPplYLQA==
X-Received: by 2002:a05:6402:488:b0:4fb:de7d:b05a with SMTP id k8-20020a056402048800b004fbde7db05amr2921258edv.40.1679410471631;
        Tue, 21 Mar 2023 07:54:31 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id u5-20020a50d505000000b004c09f0ba24dsm6409600edi.48.2023.03.21.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:54:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
In-Reply-To: <DS7PR21MB3127E3FBE1ABB368C6CBC097A0B99@DS7PR21MB3127.namprd21.prod.outlook.com>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-3-git-send-email-ssengar@linux.microsoft.com>
 <87a60gww0h.fsf@redhat.com>
 <20230313170210.GA4354@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DS7PR21MB3127E3FBE1ABB368C6CBC097A0B99@DS7PR21MB3127.namprd21.prod.outlook.com>
Date:   Tue, 21 Mar 2023 15:54:29 +0100
Message-ID: <87bkkmupcq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KY Srinivasan <kys@microsoft.com> writes:

>> -----Original Message-----
>> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
>> Sent: Monday, March 13, 2023 10:02 AM
>> To: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
>> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; KY Srinivasan
>> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
>> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; arnd@arndb.de;
>> Tianyu Lan <Tianyu.Lan@microsoft.com>; Michael Kelley (LINUX)
>> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
>> hyperv@vger.kernel.org; linux-arch@vger.kernel.org
>> Subject: Re: [PATCH v2 2/2] x86/hyperv: VTL support for Hyper-V
>> 
>> On Mon, Mar 13, 2023 at 03:45:02PM +0100, Vitaly Kuznetsov wrote:
>> > Saurabh Sengar <ssengar@linux.microsoft.com> writes:
>> >

...

>> > > +config HYPERV_VTL
>> > > +	bool "Enable VTL"
>> > > +	depends on X86_64 && HYPERV
>> > > +	default n
>> > > +	help
>> > > +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
>> > > +	  enlightenments offered to host and guest partitions which enables
>> > > +	  the creation and management of new security boundaries within
>> > > +	  operating system software.
>> > > +
>> > > +	  VSM achieves and maintains isolation through Virtual Trust Levels
>> > > +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
>> > > +	  being more privileged than lower levels. VTL0 is the least privileged
>> > > +	  level, and currently only other level supported is VTL2.
>> > > +
>> > > +	  Select this option to build a Linux kernel to run at a VTL other than
>> > > +	  the normal VTL 0, which currently is only VTL 2.  This option
>> > > +	  initializes the x86 platform for VTL 2, and adds the ability to boot
>> > > +	  secondary CPUs directly into 64-bit context as required for VTLs other
>> > > +	  than 0.  A kernel built with this option must run at VTL 2, and will
>> > > +	  not run as a normal guest.
>> >
>> > This is quite unfortunate, is there a way to detect which VTL the
>> > guest is running at and change the behavior dynamically?
>> 
>> Only way to detect VTL is via hypercall. However hypercalls are not available
>> this early in boot sequence.
>
> Vitaly, we looked at all the options and we felt this detection did not have to be dynamic and could
> well be a compile time option. Think of this kernel as a Linux based Trusted Execution Environment that
> only runs in the Virtual Trust Level surfaced by Hyper-V with limited hardware exposed to this environment.

I understand kernels placed in other VTLs serve very specific purposes
so likely there is no need to run standard kernels shipped with various
Linux distributions there in production. It may still come handy to have
such option if only for debugging/testing purposes. The way it is
designed now, CONFIG_HYPERV_VTL will always end up disabled in anything
but your custom builds for VTLs (as such builds won't boot anywhere
else).

Doing a hypercall in early boot may not be trivial now but should be
possible. It would be even better if current VTL would be exposed
somewhere in CPUID by the hypervisor.

Just a suggestion.

-- 
Vitaly

