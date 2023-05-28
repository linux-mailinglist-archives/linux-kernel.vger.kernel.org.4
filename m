Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DE71381E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 08:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjE1Gte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 02:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjE1Gtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 02:49:32 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF497E1;
        Sat, 27 May 2023 23:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hX9P5lvl8LgTgqVaadxLEgewbYd4/EQz3gtdX5/LcvQ=; b=Be07+G93NyFsGhXgT2GahsLqcz
        euE0VVDkUpez5z5OY+iJmU3ZxAuGLXvclLMXNzEs5zVUnpXMecIZ7tUzKVHy0G8bN3CjFI2/0ew6a
        7wSGcGtR2QrurQ99rfp9Oe6BaVgFqoBXM17hCQLzCWwFzfdI/eeYMjRB0isxDTg8wIDS7Gna43foX
        Z6v4sNPuEgJi+YNNADfyrtwQAgnw2mlN2rDutwWafWWdzXRtrE5kGCqahZaBVEKs248wu9VnE+T40
        8WKQMUcXGEaaCFNdZCRuktuJt9qM1cf0s5xJyWf+aijuEdO7HMla64N2XpUk1UUY0oLRfUmBuvKdW
        3vn++SUQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1q3ADR-00CsP3-7E; Sun, 28 May 2023 06:49:21 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id 3E194BE2DE0; Sun, 28 May 2023 08:49:20 +0200 (CEST)
Date:   Sun, 28 May 2023 08:49:20 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Nick Hastings <nicholaschastings@gmail.com>,
        1036530@bugs.debian.org,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZHL5cCNUzVdleiag@eldamar.lan>
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG3mbc3zdR4KcUW/@eldamar.lan>
 <ZG6cY8xjfob4Bvcs@xps>
 <ZG98fQ+MD4O0nGGE@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG/8cxxTJ9ZzrVPQ@xps>
 <ZHCYRmD7YeIWoy2W@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHKrC4/G6ZyvRReI@xps>
X-Debian-User: carnil
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario

Nick Hastings reported in Debian in https://bugs.debian.org/1036530
lockups from his system after updating from a 6.0 based version to
6.1.y.

#regzbot ^introduced 24867516f06d

he bisected the issue and tracked it down to:

On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
> Control: tags -1 - moreinfo
> 
> Hi,
> 
> I repeated the git bisect, and the bad commit seems to be:
> 
> (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
> 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
> commit 24867516f06dabedef3be7eea0ef0846b91538bc
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Tue Aug 23 13:51:31 2022 -0500
> 
>     ACPI: OSI: Remove Linux-Dell-Video _OSI string
>     
>     This string was introduced because drivers for NVIDIA hardware
>     had bugs supporting RTD3 in the past.
>     
>     Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
>     had a mechanism for switching PRIME on and off, though it had required
>     to logout/login to make the library switch happen.
>     
>     When the PRIME had been off, the mechanism had unloaded the NVIDIA
>     driver and put the device into D3cold, but the GPU had never come back
>     to D0 again which is why ODMs used the _OSI to expose an old _DSM
>     method to switch the power on/off.
>     
>     That has been fixed by commit 5775b843a619 ("PCI: Restore config space
>     on runtime resume despite being unbound"). so vendors shouldn't be
>     using this string to modify ASL any more.
>     
>     Reviewed-by: Lyude Paul <lyude@redhat.com>
>     Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
>  drivers/acpi/osi.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> This machine is a Dell with an nvidia chip so it looks like this really
> could be the commit that that is causing the problems. The description
> of the commit also seems (to my untrained eye) to be consistent with the
> error reported on the console when the lockup occurs:
> 
> [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> 
> Hopefully this is enough information for experts to resolve this.

Does this ring some bell for you? Do you need any further information
from Nick?

Regards,
Salvatore
