Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F76101F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiJ0Tpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiJ0Tpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:45:35 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A1854656;
        Thu, 27 Oct 2022 12:45:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 113285410D4;
        Thu, 27 Oct 2022 19:45:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 779D7540EBA;
        Thu, 27 Oct 2022 19:45:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666899927; a=rsa-sha256;
        cv=none;
        b=Tx3N8G61enaXP3hY00PQkoRRM+BDW4V3GjdXsV44o7sw1kknR/nSyveyG2GlGtgb9EZxjr
        zyGv1mqC+Cg/Vsrvt3Jk2dH6zR6u5ThoUU6e9ysoDnbXLRtYdZSS0CRT76RwE6REfM7uyI
        dHZ7XunaRTNXbkNsKLPyOc1G4+pszYdMbRBgNw7yR8UvV1n3lNPTmyvug6DIBhQjMkCS/D
        h6XP4zzdiHYTkqR8UdZ/0JGlDIOojhr43mNk8HcGY5JknIIzCzBlMywqVYXS7IIJricye6
        eFhOOFJFTPy0OvcsTUwYrZjhzD86g+5S5ZiztxepE1IofAWhpcID0v+M7T3G/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666899927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LgCJNes0M/e9uOGlPfODNjUYtuk1rQXw4FrNx0CN4O4=;
        b=YxvNjFPKWUt6mpgOpQcC90hhwgf1I+//m6iXB7aasdsKeaxWqyZYFyy+6L2iSYDBlD01sV
        QXpQfFKLQLL3lJFijdFUilBP98jJiyMPgGqn/pmhUbKYiB0ogMNK9+0ruVA7BmDnLGwKlq
        ePcMiJaTNLbauGQFaZ18z+FICVbltXtWDk9nYCxBEUnVEAEDm8rpQs0dOkNHffpfE6hPKy
        lV+gRz+OHKAataxBeH1HqJwxyN5IJ2lwLs316gS9pWTLyVToQA5gVqCJhCpTsMTmJrlo36
        su/rgV06Ex2tnBp2cP3WNI9DCE7HzSiU3R1Hppjhv2OpcdL41W1YbsgMoGTqQQ==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-crcnf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Minister-Cold: 411e9b1352b9e008_1666899927853_4160441994
X-MC-Loop-Signature: 1666899927853:3360058680
X-MC-Ingress-Time: 1666899927853
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.34.76 (trex/6.7.1);
        Thu, 27 Oct 2022 19:45:27 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4Myx3p2T7bz1G;
        Thu, 27 Oct 2022 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666899927;
        bh=LgCJNes0M/e9uOGlPfODNjUYtuk1rQXw4FrNx0CN4O4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=S861251m7hwlBl9VdDcTGQTXZ19uWIjz7MKZKMOzkvCb0tQZfFcwBMKLIoZZJvlHW
         LxthQP60HBgGOTqrxbbgsOG17hBYOlEebeLquGeC/2UbMwRVGpazOKupZTgjan+rzt
         r1UL2sA3QvPNHNYQWxqrkup5Um/UFec8NkdRNHlrDMOf0KfPT/4y2peFJZ7N08vkAs
         TemrAQ4bSKpu9c+hGYph5cyWbI6t2TWIbXQ9wwbGIO/3OlQ1qswhHTtBWZCdyfyxRb
         1dSC9Ka82m6e+uw9B8PaPd8FCo0RZccKvZlKSHeIBneIzlVveFLIkYRs7J8WwzOq0P
         kC28tuJhVaU3g==
Date:   Thu, 27 Oct 2022 12:23:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memregion: Add cpu_cache_invalidate_memregion()
 interface
Message-ID: <20221027192341.flsnbnmptd4t32ki@offworld>
References: <166672803035.2801111.9244172033971411169.stgit@dwillia2-xfh.jf.intel.com>
 <3ce6ef93-2f47-eda3-f974-0cfea7f43766@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3ce6ef93-2f47-eda3-f974-0cfea7f43766@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022, Dave Hansen wrote:

>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 67745ceab0db..b68661d0633b 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -69,6 +69,7 @@ config X86
>>	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
>>	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>>	select ARCH_HAS_CACHE_LINE_SIZE
>> +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION  if X86_64
>
>What is 64-bit only about this?
>
>I don't expect to have a lot of NVDIMMs or CXL devices on 32-bit
>kernels, but it would be nice to remove this if it's not strictly
>needed.  Or, to add a changelog nugget that says:
>
>	Restrict this to X86_64 kernels.  It would probably work on 32-
>	bit, but there is no practical reason to use 32-bit kernels and
>	no one is testing them.

Yes, this was to further limit the potential users.
