Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97766C8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjAPQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjAPQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:42:13 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB4B3E603
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:30:12 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id E0D0413E0C9;
        Mon, 16 Jan 2023 17:30:08 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1673886609; bh=EWAvrD4RojL0LVOAIJLliUiQp4sAh2O0X95WyClxam4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=alOM8Qzex40r+j9quWCOGy7tiIciq8Q7+8fiyc9/pZhoxFF5X9wUKW3NqU+Iaq7p6
         KTq6Qtohzbxc0PzE/MYr3dh7tf5HLtLEgZT1nUAC/zHWMSubGnajgAAgxK8TRiObis
         G79qPHNI/lz08EJ9YJBczwh6sM5qfg7MxLxKlOCD/2tjLUjtoibZQaBH8v2SHAKYhd
         fUDUzxjcAN/l7nU9lijkPyZY+eZ/YYDyWchZBnZ4BF/VldaIFy+tGTwKkYixVn4zjn
         svympXbsTq8lyZUVakVP6liCaCU9Bo1OblIWUdR/3JR4PQ30FnveEN58ml2GozYFIL
         xKShC5ULUX+fw==
Date:   Mon, 16 Jan 2023 17:30:05 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Message-ID: <20230116173005.21bd7b67@meshulam.tesarici.cz>
In-Reply-To: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
        <20221209153656.3284-2-eric.devolder@oracle.com>
        <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
        <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, 12 Jan 2023 11:23:18 -0600
Eric DeVolder <eric.devolder@oracle.com> wrote:

>[...]
> After looking into this for a bit, to allow hotplug without kexec_file would require quite a bit of 
> code movement. Why? Because hotplug is basically built on top of (part of) the infrastructure that 
> was needed for kexec_file.
> 
> I'd be inclined to suggest that KEXEC_FILE be a required dependency for CRASH_HOTPLUG, ie:
> 
>   config CRASH_HOTPLUG
>          bool "Update the crash elfcorehdr on system configuration changes"
>          default n
> -       depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> 
> 
> If that isn't feasible, then it would appear quite a bit of surgery is needed to properly separate 
> out the items hotplug needs from kexec_file.
> 
> Thoughts?

I would have thought that CPU hotplug can be handled in the kernel only
if the crash image was loaded by the kernel with kexec_file_load(2).
When the image is loaded with kexec_load(2), then all data structures
are prepared by the user-space utility kexec(8), and the kernel
generally has no idea how to handle them.

In short, I believe that by definition there must be this dependency of
CRASH_HOTPLUG on KEXEC_FILE.

Petr T
