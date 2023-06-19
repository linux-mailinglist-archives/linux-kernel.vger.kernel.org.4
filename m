Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAC735A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjFSOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjFSOud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:50:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F01AD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:50:32 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C895C1EC0398;
        Mon, 19 Jun 2023 16:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687186230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oYKdPeBEwTAUlAiZzuVusNxVM+kxlyg9CTET+oS2gLM=;
        b=MqKXXFb7O4SKaXiXMiAhDFApA6UN1Sm6bcKn2Txd5rbU1vruwZm6lkE9reelWKIZUYKJEl
        dT7aXj3miTJfIb1otsklkB0ndWGEWyhJojCGL9gQZyf/WVN7yEXQdUJ6MF04HVMt8+x/HA
        DFAvyI+rkYktt+po3mOxAXp+De/uZtY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CDTyTjsdyFE6; Mon, 19 Jun 2023 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687186227; bh=oYKdPeBEwTAUlAiZzuVusNxVM+kxlyg9CTET+oS2gLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqSkpN5zE8/WvNaKBY83qDmazt3W88AhxN4B0sxIdEHfsePI6hXivjVJF03ke0Lp4
         Bp3shhLzwRCso4iy10AEprbn1A6LZvv7qKqS5Rwy4XvtN1u+um+3APN7sv/t5kI8Jo
         C5bPMeVZxMxitjw7lt5duEBmYuC4t4kjtdS+6+OQYQROqm6HLKXNQI8W3XZznMApw6
         ZtiTHwN1tf8racVBqmCIHrqaGNzOupQ8m7R+zrtcLjhE1qV0Ga6iJqtOQMUJMUkd2w
         hozAsm6IvQ9VhdHigExJJGSiSBv4kxOy+dQkuNghwa/OHo9BQLz4eAi8zckyELCgNA
         ZRUxgXU/d7TU6YshNTVFRQopQCjXvNPwXxwp8x+ZpsaBH/OWvurqFPs05v6zTsBynJ
         isUCOKZY6l3mS+k97hvKQfhd78qt0Tq37AERy+vPKwwlp4rMoliHV7UqaL/fgefFu4
         7xcmJ5HPVtRxHobrpg1budF1Y1G2l3dA7DCoNuI2M2Yb2tXwEwF8TTea3lzo7AXQFl
         R2UJsIXKQA/zJYfnwOFdMhroB7V44uqsYFEr1HjqtwAu6Nad++OOTFJllj6z6n3WSm
         lC80oRXog16T0BYFvF/8CncLHowAZ2Tkm+fX/26sG5U7WFf7Bdqg349X3eGKqSyqao
         6TOihQT+f4WAdyZgam8ll8KM=
Received: from zn.tnic (p200300EA971dC5b2329c23FfFEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62F5140E01DE;
        Mon, 19 Jun 2023 14:50:16 +0000 (UTC)
Date:   Mon, 19 Jun 2023 16:50:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gorcunov@openvz.org, suresh.b.siddha@intel.com,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1] x86/apic: Fix kernel panic when "intremap=off" and
 "x2apic_phys" are set
Message-ID: <20230619145012.GCZJBrJKuiape5djVt@fat_crate.local>
References: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 02:52:36AM +0530, Dheeraj Kumar Srivastava wrote:
> x2APIC mode requires "Interrupt Remapping" to be enabled and the
> "physical x2apic" driver can be used only when x2APIC mode is enabled.
> However when "intremap=off" and "x2apic_phys" kernel command line
> parameters are passed, "physical x2apic" driver is being used even when
> x2APIC mode is disabled ("intremap=off" disables x2APIC mode).
> This results in the below kernel panic:
> 
>   unchecked MSR access error: RDMSR from 0x80f at rIP: 0xffffffff87eab4ec

Not a kernel panic - that's a warning about accessing a non-existent
MSR.

Can you send full dmesg? Privately is fine too.

How exactly do you trigger this? What hw?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
