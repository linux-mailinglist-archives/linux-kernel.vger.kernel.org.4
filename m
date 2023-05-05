Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6306F8C9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEEXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEEXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5410D9;
        Fri,  5 May 2023 16:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB0064049;
        Fri,  5 May 2023 23:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE07C433D2;
        Fri,  5 May 2023 23:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683327905;
        bh=XEls8cwJ9PihLtpf+B0rKLZ28vKzCt/oNFmXwSPyGBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XilQ/Vh/UD1tIZCxAQQ+QHytgnxpjUeJDJbIJSsHNNr7MH7+JLo5cm1wFMvCh9ZJY
         +hT0xuYdHLzYDZ92IPmUNVoAG65m2H0o2JnlqarI3Uh42MUh3iNV7+NmqWODb3fpSi
         gRgzF7EwqqsUN61BGPzM/V+/7tbuLX4ZsG2PYO4YqK6Kgz0Z+E2DdpKJfsvGVGGldQ
         iMTqudUcmHOB/lChu3/EcfigLOB2d/+85W2AktNAi1rfOyGU9ZZE54OzK1IDpuU4xa
         +Bnh57fiAMxW6ebhmgJaKKCMpQozBKH6bQ7DUXInkjjmGBQ1V38gZeh18whqKTyyOV
         it2aHsnrmiwHQ==
Date:   Fri, 5 May 2023 23:05:04 +0000
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping
 key at boot-time
Message-ID: <ZFWLoOZZTnBrid+7@gmail.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410225936.8940-8-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 03:59:31PM -0700, Chang S. Bae wrote:
> diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
> index e85dfb6c1524..820ac29c06d9 100644
> --- a/arch/x86/include/asm/keylocker.h
> +++ b/arch/x86/include/asm/keylocker.h
> @@ -5,6 +5,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/processor.h>
>  #include <linux/bits.h>
>  #include <asm/fpu/types.h>
>  
> @@ -28,5 +29,13 @@ struct iwkey {
>  #define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
>  #define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
>  
> +#ifdef CONFIG_X86_KEYLOCKER
> +void setup_keylocker(struct cpuinfo_x86 *c);
> +void destroy_keylocker_data(void);
> +#else
> +#define setup_keylocker(c) do { } while (0)
> +#define destroy_keylocker_data() do { } while (0)
> +#endif

Shouldn't the !CONFIG_X86_KEYLOCKER stubs be static inline functions instead of
macros, so that type checking works?

- Eric
