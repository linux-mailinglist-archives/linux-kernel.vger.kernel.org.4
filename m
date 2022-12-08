Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5F647059
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLHNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:02:06 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E78E598;
        Thu,  8 Dec 2022 05:02:05 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id q10so873563qvt.10;
        Thu, 08 Dec 2022 05:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hf8w5dCI8SN8jx8p/uI1zYTlW+tlmcbclme8iwGq8uU=;
        b=wd5FB4RIxl89kOS5bHWyvVXfoRTfmHqUwjNyXztcJaSy47513H/Reacrc4L/VPrsV0
         AF0Bv4P/crZ70uLE7T5Kll9ItDNj8z0Ok+YrWOCsTwcyFwNl+mUgKWogJu7QR4+I3nh6
         2cZZugSOYPHNuoruktktU2z2Qjg+8Lsax/I9hdDTyjKaH7HnEyKmN4VkKY07nm6plobL
         LnEgkCFTcN9SVppy/k9oU5/HF1VdW586HDZs4zTBbFLMKOH/iAa7p5gJLxDKU9Pr4AbW
         EupGUffJxUFRWiJSJp45YuVEZiU5BBlh3VH3X7ZJMYiE2CJAqXEuNVR9zrmL9JPIlNYT
         D7Gw==
X-Gm-Message-State: ANoB5pnFCsynEnXFNrlxZdeRrPISWnBUXbPc+N4BhN51pVR4Fg/UftMN
        a3dlG5apVs+HSYHyON1WOFQu6Ez+ncjVo4EgaQgOF+PD
X-Google-Smtp-Source: AA0mqf42V25f4DFkTROd0mn8pwc2QIzYAHjGOqeNpnET/+SplRdUK2bzUH/jToONq39hYrQE3KQqLyhVeVKktLCWqOE=
X-Received: by 2002:a05:6214:2b90:b0:4c7:27cf:dfca with SMTP id
 kr16-20020a0562142b9000b004c727cfdfcamr28403564qvb.3.1670504524902; Thu, 08
 Dec 2022 05:02:04 -0800 (PST)
MIME-Version: 1.0
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
 <080936167059.CAJZ5v0g5kTRE+x-8xC2WwQr11j01ox=Nk0aguiC1_HGPU8W=Rw@mail.gmail.com>
 <9e19c594bcf144fbb433fb4cfee54e08@baidu.com> <CAJZ5v0jofKbdRbKzLSEMkjQjP1GTcbt7OYqO=0ZYvpt_HwTQTg@mail.gmail.com>
 <3fb3526aa012449db95767c6092da8f6@baidu.com>
In-Reply-To: <3fb3526aa012449db95767c6092da8f6@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 14:01:53 +0100
Message-ID: <CAJZ5v0iEYwrNjD5wqq-VA4C4KLwYL6O9SXu2bEEh87-4WmsExQ@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] cpuidle-haltpoll: Replace default_idle with arch_cpu_idle
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 1:43 PM Li,Rongqing <lirongqing@baidu.com> wrote:
>
> > >
> > > When cpuidle-haltpoll is built as module,
> >
> > But it isn't now.
>
> Centos is compiling it as module, it will fail;
> Other user wants to compile it as module, they will fail,
> Syzbot random configuration building will fail
>
> Unless prohibit to build it as module as below:
>
> config HALTPOLL_CPUIDLE
> -        tristate "Halt poll cpuidle driver"
> +        bool "Halt poll cpuidle driver"
>         depends on X86 && KVM_GUEST
>         default y
>         help

Ah, OK.  Sorry about the confusion.

Yes, the driver (not the governor, though), can be modular, so yes you
need the export, but please change it to EXPORT_SYMBOL_GPL().
