Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C57338A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbjFPTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbjFPTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:00:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA93C2A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:00:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57003dac4a8so45006837b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686942015; x=1689534015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXxXe22E+eki9MrnMaj+ggUpo157SDobcL5kHe+WAic=;
        b=Hw86hCOP2CHeGuNxPCyMHj6CM9vtw/JxFPKCgtdwpbTYrkI8rqTXkVyJFIUJe+K8bB
         fGRjXt4efYlQlvH5JgEWQbgRoVrXNSagZ3oeG6R+7eNxfV4ESk/5yYe7S3F3OB2klX9W
         6LReKj+zkai67q1m5zugTSYCJWzeGAzp0SEG0ihWEdiOXrs1g4/qI9nVlAL/Z0WljqPI
         2VMzSkwdtMNVLvXQrvOsM6Srz1DKZuXpglj58R0+favfEyHtvDIZxbOhMJMKclhxjf1B
         KQ4tB40PbFYNNROaXKTtFLF6rFfwTvX9fLSFoP94OMXUydtqLMXQRJH+XOFEidRdKpUN
         1zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686942015; x=1689534015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXxXe22E+eki9MrnMaj+ggUpo157SDobcL5kHe+WAic=;
        b=YGl2t3YrZXbdN7qaHnw+aLIN+TbmqeV4LV8kniHjEC/DYlvuP17AtvNdj3+wExRR3b
         GSggXRHW79S+XwUT+oSTZOMNh9/Z6GIo3h4fKAid+V2U48YtUh8rFT/u13tTuL3SMw21
         +qKAAWbi2krS22cioyShhLnVUwhSUCgUwJ6E/g79EoH6UqJyeC2/zd7hitR0jTZZHr8V
         g1hIC9IZRAZnVKbbhxMqWKltM0md9Dkfq5RtqtOzYaBetUj4SVaxEthWdPXfpAEcueEl
         fTi+PN3MvotZ5Acsf/xTMUcwQu9dd1w5wdwH9pxX1KMxiPyyX8DIipFKWNiq7C2qShnl
         xTNw==
X-Gm-Message-State: AC+VfDwooPJZdm+V0oUDSTi2FDyksU7vM+gl0PLOd9vDu65IqZXY+m4q
        wygWDLLlG18TOtGhymHek5FAqssZKU4=
X-Google-Smtp-Source: ACHHUZ7XV3n1X8KcqbAgBDp6BcaDxj/gnWyAkT+Z5YCqfczUiy8hBqRISMvWMkvM2R6iJshncClYZMHMA88=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1702:b0:bc7:f6af:8cfe with SMTP id
 by2-20020a056902170200b00bc7f6af8cfemr8392ybb.4.1686942015019; Fri, 16 Jun
 2023 12:00:15 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:00:13 -0700
In-Reply-To: <ZIx6xCgdILbjcw7H@a4bf019067fa.jf.intel.com>
Mime-Version: 1.0
References: <20230603193439.502645149@linutronix.de> <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx> <ZICuhZHCqSYvR4IO@araj-dh-work> <ZIC/b+AwvH2wIz/o@google.com>
 <ZIECZMHxtEYnuBAJ@araj-dh-work> <ZIFPDvsKGZ7MVSMt@google.com> <ZIx6xCgdILbjcw7H@a4bf019067fa.jf.intel.com>
Message-ID: <ZIyxPbtwwObi0Qkv@google.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
From:   Sean Christopherson <seanjc@google.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrea Bolognani <abologna@redhat.com>,
        "Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=" <berrange@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Ashok Raj wrote:
> On Wed, Jun 07, 2023 at 08:46:22PM -0700, Sean Christopherson wrote:
> > 
> > https://lore.kernel.org/all/BYAPR12MB301441A16CE6CFFE17147888A0A09@BYAPR12MB3014.namprd12.prod.outlook.com
> > 
> > > If there is a specific test you want done, let me know.
> > 
> > Smoke testing is all I was thinking.  I wouldn't put too much effort into trying
> > to make sure this all works.  Like I said earlier, nice to have, but certainly not
> > necessary.
> 
> + Vijay who was helping with testing this inside the VM.
> + Paolo, Laszlo 
> 
> I haven't found the exact method to test with secure boot/trusted boot yet.
> But here is what we were able to test thus far.
> 
> Vijay was able to get OVMF recompiled with SMM included.
> 
> Thanks to Laszlo for pointing me in the right direction. And Paolo for
> helping with some basic questions.
> 
> https://github.com/tianocore/tianocore.github.io/wiki/Testing-SMM-with-QEMU,-KVM-and-libvirt
> 
> Surprisingly SMM emulation is sadly damn good :-) 
> 
> Recipe is to generate SMI by writing to port 0xb2. 
> 
> - On native, this does generate a broadcast SMI, the SMI_COUNT MSR 0x34
>   goes up by 1 on all logical CPUs.
> - Turn off SMT by #echo off > /sys/devices/system/cpu/smt/control
> - Do another port 0xb2, we don't see any hangs
> - Bring up SMT by echo on > control, and we can see even the offline CPUs
>   got the SMI as indicated by MSR 0x34. (Which is as expected)
> 
> On guest, the only difference was when we turn on HT again, waking the CPUs
> from INIT, SMI_COUNT has zeroed as opposed to the native. (Which is
> perfectly fine) All I was looking for was "no hang". And a normal kexec
> with newly updated code works well inside a guest.
> 
> Would this qualify for the smoke test pass? I'll continue to look for a
> secure boot install if this doesn't close it, just haven't landed at the
> right spot yet.

Good enough for me, thanks much!
