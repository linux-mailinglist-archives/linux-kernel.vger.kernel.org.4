Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936DF675F73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjATVK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjATVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:10:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB7CD23C;
        Fri, 20 Jan 2023 13:10:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C89E8B82A64;
        Fri, 20 Jan 2023 21:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C8C433EF;
        Fri, 20 Jan 2023 21:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674249036;
        bh=wLkgPsR5vSZDOWEBXjVKqodCnOqgDMrn3SAnrDftXDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzq8gWdxYIpw3LE8DvysdyT0nQHUZZz7A2QpcyfzYVN0U3eV38JMo36fwQAb2Bg8F
         JpOenqCQLJN/WQBm8EdPELmm5mdqigxH1ZtTVNgKpcwtTxFUm6C8PfFBNJUypMFRcK
         Mxs14MQHT2tUGfmbXY6eHUJPm6HJlzz8AG2kwala+P0dXa0fpAycAYFmXJ2zUPWoxx
         1AkF5ee0PtTVPct3l68ZyAlx2pWN2RjZ/ks3ftG6vptvjjmya1TGVv79C0PVpLURul
         tr6kC70Pfozg/adVLK4ryPSoXAGSZ2rRLsR6WEb8a3fvxpiJXMV++31vjYgFCdJove
         o6KWRFUwnzOEA==
Date:   Fri, 20 Jan 2023 21:10:33 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH RESEND v6 0/3] certs: Prevent spurious errors on repeated
 blacklisting
Message-ID: <Y8sDSSbCcxydFDYx@kernel.org>
References: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212-keys-blacklist-v6-0-933267a80582@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:59:41PM +0000, Thomas Weißschuh wrote:
> When the blacklist keyring was changed to allow updates from the root
> user it gained an ->update() function that disallows all updates.
> When the a hash is blacklisted multiple times from the builtin or
> firmware-provided blacklist this spams prominent logs during boot:
> 
> [    0.890814] blacklist: Problem blacklisting hash (-13)
> 
> This affects the firmware of various vendors. Reported have been at least:
> * Samsung: https://askubuntu.com/questions/1436856/
> * Acer: https://ubuntuforums.org/showthread.php?t=2478840
> * MSI: https://forum.archlabslinux.com/t/blacklist-problem-blacklisting-hash-13-errors-on-boot/6674/7
> * Micro-Star: https://bbs.archlinux.org/viewtopic.php?id=278860
> * Lenovo: https://lore.kernel.org/lkml/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de/
> 
> Note: In the meantime I lost access to the machine exhibiting the
> problematic behavior. If larger changes are required to this series
> somebody else would have to validate them or take over the series.
> 
> Changelog:
> 
> v1: https://lore.kernel.org/all/20221104014704.3469-1-linux@weissschuh.net/
> v1 -> v2:
>  * Improve logging message to include the failed hash
>  * Add key_create() function without update semantics
>  * Use key_create() from mark_raw_hash_blacklisted() and log specific message
>    on -EEXIST
> 
> v2: https://lore.kernel.org/lkml/20221109025019.1855-1-linux@weissschuh.net/
> v2 -> v3:
>  * Clarify commit titles and messages
>  * Drop the change to BLACKLIST_KEY_PERM from patch 3, as it was an artifact
>    of some obsolete version of the patch and not needed
> 
> v3: https://lore.kernel.org/lkml/20221118040343.2958-1-linux@weissschuh.net/
> v3 -> v4:
>  * Drop Fixes-tag from first patch
>  * Flesh out commit descriptions and messages
> 
> v4: https://lore.kernel.org/r/20221212-keys-blacklist-v4-0-00afeb3137fb@weissschuh.net
> v4 -> v5:
>  * Reduce lines needed by function calls in key.c
>  * Add Reviewed-by from Jarkko
> 
> v5: https://lore.kernel.org/r/20221212-keys-blacklist-v5-0-52e9eb5a8827@weissschuh.net
> v5 -> v6:
>  * Correct Jarkkos email in Reviewed-by tags
>  * Resend to hopefully reach @kernel.org recipients
> 
> Thomas Weißschuh (3):
>   certs: log hash value on blacklist error
>   KEYS: Add key_create()
>   certs: don't try to update blacklist keys
> 
>  certs/blacklist.c   |  21 ++++---
>  include/linux/key.h |   8 +++
>  security/keys/key.c | 149 +++++++++++++++++++++++++++++++++-----------
>  3 files changed, 132 insertions(+), 46 deletions(-)
> 
> --
> 2.38.1
> 
> To: David Howells <dhowells@redhat.com>
> To: David Woodhouse <dwmw2@infradead.org>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Paul Moore <paul@paul-moore.com>
> To: James Morris <jmorris@namei.org>
> To: "Serge E. Hallyn" <serge@hallyn.com>
> To: "Mickaël Salaün" <mic@digikod.net>
> Cc: keyrings@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> Cc: Mark Pearson <markpearson@lenovo.com>
> 
> ---
> Thomas Weißschuh (3):
>       certs: make blacklisted hash available in klog
>       KEYS: Add new function key_create()
>       certs: don't try to update blacklist keys
> 
>  certs/blacklist.c   |  21 ++++----
>  include/linux/key.h |   8 +++
>  security/keys/key.c | 137 ++++++++++++++++++++++++++++++++++++++--------------
>  3 files changed, 120 insertions(+), 46 deletions(-)
> ---
> base-commit: 512dee0c00ad9e9c7ae9f11fc6743702ea40caff
> change-id: 20221212-keys-blacklist-2c79a64667c9
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>

Hi, I'e applied and pushed this now. Thank you.

BR, Jarkko
