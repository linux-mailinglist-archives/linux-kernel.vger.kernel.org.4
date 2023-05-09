Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A76FC349
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjEIJ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEIJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED5819AE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683626125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hwTL2pt1zMgvZpiDp/C711U7xrW46SHJVw2melI5eMU=;
        b=a5ExSlvYW1aoHVQPNO+NtItBbLLXZCakukcBwMOFckWF1ce9z6jy+MEfrDJeNPznb2sgzQ
        mNnxJI4deV1SmcLVKA/99icJjFaMutcKMMU5Vy5LLpBeQSSwyft1B2XJfIBpY0t9ThAgvN
        9f94LsTNhUCPTq93Q+pLbPrqeFUOMLI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-IbEwCYoPO3yTr2r-1hDN6g-1; Tue, 09 May 2023 05:55:24 -0400
X-MC-Unique: IbEwCYoPO3yTr2r-1hDN6g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-95f6f291b9aso697058366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683626123; x=1686218123;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hwTL2pt1zMgvZpiDp/C711U7xrW46SHJVw2melI5eMU=;
        b=QsKly7C4LGY7WCdBhJzwdJAUmZ4gKBMhqv9vlnEoFccFyrrgsZs77w9ByPSQgt7yS/
         t5TzpjbxjgwvYxFHnaelAPdn1BhnpkFnoDzio9VWUlNiX1Db00FjA6Se9cvJetaNBzX3
         wekZeTlUuIRtWpXlXhyKJV+9tg5Mi5Y/yoxsACEPt23uFahEGQe8EbbAgGrT6GJxunab
         /IbudvwW1xWDjWJdELI/fQWejCGGQhY6r9ITcizbhvrggn5q4u3G2UsnQCsKrV6hDJbF
         x1pNHuIyKtKlZoM6TRHkv9XyI17cfTGzdQn9BFA6HswzQ+Hmjs/wKHfkIRtKCP+OLbTT
         507w==
X-Gm-Message-State: AC+VfDzHueGhCVFyxauQ42JJ+051Sd9emGmSq+EnLfz6p5THFbozZrHx
        KPGmRpwTvH8+ykXlzqy9FjpBnDhD4Z/TqMF8XlT1VUTjSX0xVkREx+5xvESlXXs8arpsrQ9cVoY
        QD8Iht3V4Pf4nTc+VPiOqbZ6xvJxdvlkH
X-Received: by 2002:a17:906:c14e:b0:94a:58a5:2300 with SMTP id dp14-20020a170906c14e00b0094a58a52300mr12038008ejc.27.1683626123103;
        Tue, 09 May 2023 02:55:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KVwDdIh+k0IFIADeE84XXMr59CW7Y/gjpBElAhOEldqYXarnqFl7S0CQI/ZY3TrvKeHZ9dQ==
X-Received: by 2002:a17:906:c14e:b0:94a:58a5:2300 with SMTP id dp14-20020a170906c14e00b0094a58a52300mr12037990ejc.27.1683626122677;
        Tue, 09 May 2023 02:55:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id qo28-20020a170907213c00b00965ddf2e221sm1110897ejb.93.2023.05.09.02.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:55:22 -0700 (PDT)
Message-ID: <2f19f26e-20e5-8198-294e-27ea665b706f@redhat.com>
Date:   Tue, 9 May 2023 11:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To:     KVM list <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: [ANNOUNCE] KVM Microconference at LPC 2023
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

We are planning on submitting a CFP to host a KVM Microconference at
Linux Plumbers Conference 2023. To help justify the proposal, we would
like to gather a list of folks that would likely attend, and crowdsource
a list of topics to include in the proposal.

For both this year and future years, the intent is that a KVM
Microconference will complement KVM Forum, *NOT* supplant it. As you
probably noticed, KVM Forum is going through a somewhat radical change in
how it's organized; the conference is now free and (with some help from
Red Hat) organized directly by the KVM and QEMU communities. Despite the
unexpected changes and some teething pains, community response to KVM
Forum continues to be overwhelmingly positive! KVM Forum will remain
the venue of choice for KVM/userspace collaboration, for educational
content covering both KVM and userspace, and to discuss new features in
QEMU and other userspace projects.

At least on the x86 side, however, the success of KVM Forum led us
virtualization folks to operate in relative isolation. KVM depends on
and impacts multiple subsystems (MM, scheduler, perf) in profound ways,
and recently we’ve seen more and more ideas/features that require
non-trivial changes outside KVM and buy-in from stakeholders that
(typically) do not attend KVM Forum. Linux Plumbers Conference is a
natural place to establish such collaboration within the kernel.

Therefore, the aim of the KVM Microconference will be:
* to provide a setting in which to discuss KVM and kernel internals
* to increase collaboration and reduce friction with other subsystems
* to discuss system virtualization issues that require coordination with
other subsystems (such as VFIO, or guest support in arch/)

Below is a rough draft of the planned CFP submission.

Thanks!

Paolo Bonzini (KVM Maintainer)
Sean Christopherson (KVM x86 Co-Maintainer)
Marc Zyngier (KVM ARM Co-Maintainer)


===================
KVM Microconference
===================

KVM (Kernel-based Virtual Machine) enables the use of hardware features
to improve the efficiency, performance, and security of virtual machines
created and managed by userspace.  KVM was originally developed to host
and accelerate "full" virtual machines running a traditional kernel and
operating system, but has long since expanded to cover a wide array of use
cases, e.g. hosting real time workloads, sandboxing untrusted workloads,
deprivileging third party code, reducing the trusted computed base of
security sensitive workloads, etc.  As KVM's use cases have grown, so too
have the requirements placed on KVM and the interactions between it and
other kernel subsystems.

The KVM Microconference will focus on how to evolve KVM and adjacent
subsystems in order to satisfy new and upcoming requirements: serving
guest memory that cannot be accessed by host userspace[1], providing
accurate, feature-rich PMU/perf virtualization in cloud VMs[2], etc.


Potential Topics:
   - Serving inaccessible/unmappable memory for KVM guests (protected VMs)
   - Optimizing mmu_notifiers, e.g. reducing TLB flushes and spurious zapping
   - Supporting multiple KVM modules (for non-disruptive upgrades)
   - Improving and hardening KVM+perf interactions
   - Implementing arch-agnostic abstractions in KVM (e.g. MMU)
   - Defining KVM requirements for hardware vendors
   - Utilizing "fault" injection to increase test coverage of edge cases
   - KVM vs VFIO (e.g. memory types, a rather hot topic on the ARM side)


Key Attendees:
   - Paolo Bonzini <pbonzini@redhat.com> (KVM Maintainer)
   - Sean Christopherson <seanjc@google.com>  (KVM x86 Co-Maintainer)
   - Your name could be here!

[1] https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com
[2] https://lore.kernel.org/all/CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com

