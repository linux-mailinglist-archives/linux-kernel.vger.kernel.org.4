Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F97712083
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbjEZGyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEZGyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D16395;
        Thu, 25 May 2023 23:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 016BA61638;
        Fri, 26 May 2023 06:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9849C433D2;
        Fri, 26 May 2023 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685084056;
        bh=FBf1cGUiX8H3z5J/mnshqSgpyzk0LkYamotNDGOq9Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHVNb4uUOelaJSfCEdjU7lmZFDOlG0X/Q0edskh4XSZq090d5m4oShj2XrKqc27kz
         QS7cpm+RYkCP24vNgaV95MAIa2MgBOjG/Uv0HO8TMcRJa2eI+L7zIkb0xltqcs8fEe
         iEGiXtoqeItNk1WCpJBuBg8FWtm+7IBM4nwsicMYaoSKSl+hFoQv+LUWSwI+SbG92+
         3WgyHY7zktiXwhqhu021CgRJB8BBzGzF7CeiQ4q/2wxXuGN/2EwTz2t3xyHud7Qmwx
         TjTwkdTNzsga1jAvwu45X20+ft8mETOscRWOJ9qbbZmpL72rwQiSlAdlCDyp0MEfR6
         gY/Lfkr1BVp0Q==
Date:   Thu, 25 May 2023 23:54:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 10/12] crypto: x86/aesni - Use the proper data type in
 struct aesni_xts_ctx
Message-ID: <20230526065414.GB875@sol.localdomain>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230524165717.14062-11-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524165717.14062-11-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:57:15AM -0700, Chang S. Bae wrote:
> +static inline unsigned long aes_align_addr(unsigned long addr)
> +{
> +	return (crypto_tfm_ctx_alignment() >= AESNI_ALIGN) ?
> +	       ALIGN(addr, 1) : ALIGN(addr, AESNI_ALIGN);
> +}

Wouldn't it be simpler to make this take and return 'void *'?  Then the callers
wouldn't need to cast to/from 'unsigned long'.

Also, aligning to a 1-byte boundary is a no-op.

So, please consider the following:

static inline void *aes_align_addr(void *addr)
{
	if (crypto_tfm_ctx_alignment() >= AES_ALIGN)
		return addr;
	return PTR_ALIGN(addr, AES_ALIGN);
}

Also, aesni_rfc4106_gcm_ctx_get() and generic_gcmaes_ctx_get() should call this
too, rather than duplicating similar code.

- Eric
