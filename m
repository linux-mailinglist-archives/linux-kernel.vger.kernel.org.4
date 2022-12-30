Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4D6598F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiL3NrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3NrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:47:19 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD70DD1;
        Fri, 30 Dec 2022 05:47:18 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id g20so11127178iob.2;
        Fri, 30 Dec 2022 05:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPlF5GPACJ7tc/xfdCV9WtHQwz/gtCn+OAsHdfRx9JY=;
        b=2mnscl/SVqsjVnwqZDLSKbOHA0BQBXqS5ti7iPXYKYz61K7kRWz5TJqBz7SVlghYzI
         tK+EHS4nhRSCkxCtEu3TVpSAJ3vDySv1nD/gNHKaw9rp32EoSAvztFbuj/5yl8UUkiQQ
         e/gxud8LKyvwoMuL5yBgIRIhGoWyjUkGd9MQjBGGbrW7obAfIyrmMwoiPCPiDwrkqPbH
         II0pd+IDjslh242nydwuCJTYkhl9JoHkTZgxvx60/Zxd75nTtb/BxKKQkaL8kc1zGNhX
         uGdh0D9Yg7KQKdL08LqNDxPX9SNYxlmMWsVV53KR+6u6CCKMwvHYV0pCFfWw2UgA+16t
         O1Ww==
X-Gm-Message-State: AFqh2kqzSRFLE788jaMDoquIh5DhcJwT/HpeW7JKF2vHz7R3vihze3Z6
        3opNN5+JkXuI4iDzsqJ5MuEfZ8ywrHMo4YI8QgY=
X-Google-Smtp-Source: AMrXdXuTfRUS/EimsFwvSQNOQZwUu/AHIIKV2ZIh+H1Sq50AznmALmEtfIRGHefdYg6rzWEzJBWLyhBm/UGcEq8rh34=
X-Received: by 2002:a02:3b4f:0:b0:39a:98b:480e with SMTP id
 i15-20020a023b4f000000b0039a098b480emr2435567jaf.125.1672408037690; Fri, 30
 Dec 2022 05:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20221228114558.3504-1-kvijayab@amd.com> <0e299876606352ca868d7b71991c66a1c1d361cb.camel@intel.com>
In-Reply-To: <0e299876606352ca868d7b71991c66a1c1d361cb.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 14:47:01 +0100
Message-ID: <CAJZ5v0hzo7zSWjbC2h4S+B1ZShmrz8q_TtuUTGRGarhdh2HA+w@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi/boot: Do not register processors that cannot be
 onlined for x2apic
To:     "Zhang, Rui" <rui.zhang@intel.com>, Tony Luck <tony.luck@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "kvijayab@amd.com" <kvijayab@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mario.Limonciello@amd.com" <Mario.Limonciello@amd.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bpetkov@amd.com" <bpetkov@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 2:23 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> Hi, Kishon,
>
> On Wed, 2022-12-28 at 11:45 +0000, Kishon Vijay Abraham I wrote:
> > Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.3
> > spec mandates that both "enabled" and "online capable" Local APIC
> > Flags
> > should be used to determine if the processor is usable or not.
>
> ACPI spec 6.4 is released, so better to refer to the latest ACPI spec,
> say,
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
> or
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#local-apic-flags

ACPI 6.5 is out even.

> > However, Linux doesn't use the "online capable" flag for x2APIC to
> > determine if the processor is usable. As a result, cpu_possible_mask
> > has incorrect value and results in more memory getting allocated for
> > per_cpu variables than it is going to be used.
>
> Thanks for catching this. I had the same question when I was reading
> this piece of code recently.
>
> > Make sure Linux parses both "enabled" and "online capable" flags for
> > x2APIC to correctly determine if the processor is usable.
>
> A dumb question, the Local SAPIC structure also uses the Local APIC
> flags, and should we add the same check in acpi_parse_sapic()?

I'm not sure if this matters in practice, because SAPIC is only used
on IA64 anyway.

Tony, what do you think?

> > Fixes: 7237d3de78ff ("x86, ACPI: add support for x2apic ACPI
> > extensions")
>
> I'm not sure if this "Fixes" tag is accurate or not.
>
> Checking for the Local APIC flags was just added last year, by commit
> aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable"),
> and the variable 'acpi_support_online_capable' used in this patch is
> also introduced by that commit. So, to me, this patch fixes a gap in aa
> 06e20f1be6, rather than the original x2apic support commit.

Agreed.
