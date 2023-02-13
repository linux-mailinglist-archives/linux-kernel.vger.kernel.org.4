Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21269511A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjBMTwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjBMTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:52:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBD422A;
        Mon, 13 Feb 2023 11:52:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9297461286;
        Mon, 13 Feb 2023 19:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF6C433EF;
        Mon, 13 Feb 2023 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676317921;
        bh=yosMt8y8FMczadySYBJvycpEQJealM+++/A17K7k668=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hd4Wyi0QyJI5p+7Clrxk8rJ8Ri/r6xV7XI72mPuN9nZOWsk6ZGHrw4wvs5RLIrPKf
         0G3lSLgS0ItBogv/jsja2VhjzY0jsZVRlkrpjLqfCubMrNjPkTjBQrHCZCxOKi87Oc
         6VOwVOMTnIkXSJqp9n3f5IRYuGpIs+cLFUxseaDN/B63GLnfY3w3K49Xpg3IpLMPV6
         K7YgtNvdmpOVHsLcJJTVH4znnqFybVymTvcr/Q33PCXbkd48M+xj5huc8dfvHQPnzj
         ADoZhCUwBRZMYtj4LmD6RAnXkehfCWxBf9F7Lx2cA6/AB53Ij3yDQKYw/k04LFVevj
         n1dYiFoB7A0Bg==
Date:   Mon, 13 Feb 2023 11:51:59 -0800
From:   Kees Cook <kees@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_ACPICA=3A_Replace_fake_fle?= =?US-ASCII?Q?xible_arrays_with_flexible_array_members?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230213003546.GA3280303@roeck-us.net>
References: <20230127191621.gonna.262-kees@kernel.org> <20230213003546.GA3280303@roeck-us.net>
Message-ID: <66C64DB0-94A2-47E8-932C-519544C5FE90@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 12, 2023 4:35:46 PM PST, Guenter Roeck <linux@roeck-us=2Enet> w=
rote:
>Hi,
>
>On Fri, Jan 27, 2023 at 11:16:25AM -0800, Kees Cook wrote:
>> One-element arrays (and multi-element arrays being treated as
>> dynamically sized) are deprecated[1] and are being replaced with
>> flexible array members in support of the ongoing efforts to tighten the
>> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexin=
g
>> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3D3=2E
>>=20
>> Replace one-element array with flexible-array member in struct
>> acpi_resource_extended_irq=2E Replace 4-byte fixed-size array with 4-by=
te
>> padding in a union with a flexible-array member in struct
>> acpi_pci_routing_table=2E
>>=20
>> This results in no differences in binary output=2E
>>=20
>> Link: https://github=2Ecom/acpica/acpica/pull/813
>> Signed-off-by: Kees Cook <keescook@chromium=2Eorg>
>> Signed-off-by: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>
>This patch results in boot failures of 32-bit images=2E

Weird -- I didn't see any binary differences=2E I'll investigate=2E What c=
ompiler and arch?

-Kees

>Reverting it fixes the problem=2E
>
>On the failing boot tests, I see messages such as
>
>ACPI: \_SB_=2EGSIA: Enabled at IRQ 117440528
>ERROR: Unable to locate IOAPIC for GSI 117440528
>ahci 0000:00:1f=2E2: PCI INT A: failed to register GSI
>
>ACPI: \_SB_=2EGSIG: Enabled at IRQ 117440534
>ERROR: Unable to locate IOAPIC for GSI 117440534
>8139cp 0000:00:02=2E0: PCI INT A: failed to register GSI
>
>Given that 117440534 =3D=3D 0x7000016, that looks quite suspicious=2E
>Indeed, after reverting this patch, the messages are different=2E

Yeah, seems like a high byte not getting cleared=2E Hmm=2E

>
>ACPI: \_SB_=2EGSIA: Enabled at IRQ 16
>ahci 0000:00:1f=2E2: AHCI 0001=2E0000 32 slots 6 ports 1=2E5 Gbps 0x3f im=
pl SATA mode
>
>ACPI: \_SB_=2EGSIG: Enabled at IRQ 22
>8139cp 0000:00:02=2E0 eth0: RTL-8139C+ at 0xd0804000, 52:54:00:12:34:56, =
IRQ 22
>
>Guenter


--=20
Kees Cook
