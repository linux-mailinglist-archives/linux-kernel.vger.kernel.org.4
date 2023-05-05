Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1E6F8CA7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjEEXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEEXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0AD3C27;
        Fri,  5 May 2023 16:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083AF64089;
        Fri,  5 May 2023 23:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E06EC433D2;
        Fri,  5 May 2023 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683328195;
        bh=mXw9zNMy/vcWygWO+q0RxSEPXTN5AIfnE0Kge2powyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPd4Rl+8NrMd3AdqO3cYS5efsxQkx6NKNmiss+u2Bg50EH6ySrj2EGbf69JJZi1jL
         VM39cUq4ZhY91v0k4JyIqTJl22p36bUxiOsP3OhePkbfdIBN02mLGKeWDLBARwGNp4
         uttN+9X8WVQEuWxj2H4Q08u2b50jFWRD/BG8hFJoF0WRNQHkUgZRXgFLc8VXDO/2za
         Aghkmz5xPY6KU5F1mEwsDDW0Dz2ZKL+4fo2CAFDTJ9o+P15ctKKHq+hpsvcKsJeTUH
         CE6JnmuxK1Ja76yzoqQASquBxHEQVChhW6xnslyKbQIzG8moMFyWrgAgKQEJt8TTor
         EzrCJkPT87aPg==
Date:   Fri, 5 May 2023 23:09:53 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 08/12] x86/PM/keylocker: Restore internal wrapping key
 on resume from ACPI S3/4
Message-ID: <ZFWMwQc4NKg7ueqG@gmail.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-9-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410225936.8940-9-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 03:59:32PM -0700, Chang S. Bae wrote:
> +/*
> + * This flag is set with IWKey load. When the key restore fails, it is
> + * reset. This restore state is exported to the crypto library, then AES-KL
> + * will not be used there. So, the feature is soft-disabled with this flag.
> + */
> +static bool valid_kl;
> +
> +bool valid_keylocker(void)
> +{
> +	return valid_kl;
> +}
> +EXPORT_SYMBOL_GPL(valid_keylocker);

It would be simpler to export this bool directly.

> +	if (status & BIT(0))
> +		return 0;
> +	else
> +		return -EBUSY;
[...]
> +		pr_info("x86/keylocker: Enabled.\n");
> +		return;
> +	} else {
> +		int rc;

The kernel coding style usually doesn't use 'else' after a return.

- Eric
