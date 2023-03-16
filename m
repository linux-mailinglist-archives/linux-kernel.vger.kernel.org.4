Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4446BC507
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCPD6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCPD6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:58:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1552B2A6;
        Wed, 15 Mar 2023 20:58:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PcYQ43zL3z4x4r;
        Thu, 16 Mar 2023 14:58:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678939085;
        bh=42DOmCYnfFitbAJMdd0iLS327njtRQ3yzPRoQKunOk4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=htShWEohpinnGHC5CiLFPfDqt+XFVGYznhXQwthhnuq7fUExtFNuu0qN9mWPvxCNF
         5x1bd6e48mLt2SKe5Z7EUV9vH1fU5aQnD27stvBABbwef0Fvw6XMuavm3VXdjOxfQm
         arntoPBMGjPsea34pRQqYvWEZd3fjfIwadf/eyilrxxPt2qtZAScgy7NzIaE50MD8W
         AHSjym3WbqofZ5IhfySyoTDFTVX89G0E9fmr6IlwS5gJAbdN4xnbSfEpt9QN2XerFM
         GPP+QX3x7vP5sRBmAwk7oX+Uso8pDZHR4ykfuHxmjWZzdKHBbca4pv8xoybl3jLG9S
         Aa2CeV54WDFqQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dtsen@linux.ibm.com
Subject: Re: [PATCH] crypto: p10-aes-gcm - remove duplicate include header
In-Reply-To: <ZBE8/Rg9mK3JGBi8@gondor.apana.org.au>
References: <202303141631511535639@zte.com.cn>
 <dbbd6ff3-5e17-9b63-9027-359e37ace668@csgroup.eu>
 <ZBA1EVdy1DvfxgRO@gondor.apana.org.au> <87mt4fobmj.fsf@mpe.ellerman.id.au>
 <ZBE8/Rg9mK3JGBi8@gondor.apana.org.au>
Date:   Thu, 16 Mar 2023 14:58:04 +1100
Message-ID: <87r0tpmjoz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:
> On Tue, Mar 14, 2023 at 09:44:52PM +1100, Michael Ellerman wrote:
>>
>> Hmm. Seems none of them were ever Cc'ed to linuxppc-dev. So this is the
>> first I've seen of them.
>
> Sorry, I didn't know that you weren't aware of this change.  I
> will be more careful with these ppc patches in future.

No worries, not your fault. My comments were mostly intended for Danny.

Although one question I do have for you is what rules, if any, do we
have for deciding whether crypto code goes in drivers/crypto vs
arch/*/crypto?

On powerpc we have some in arch/powerpc/crypto and some in
drivers/crypto/vmx, and I don't really know why it's split that way.

It seems like drivers/crypto is where non-CPU crypto accelerator drivers
go, but then it also has lots of in-CPU crypto code as well AFAICS.

I wonder if we should move drivers/crypto/vmx into arch/powerpc/crypto,
so that all the powerpc CRYPTOGAMS code is in one place. That would help
to clean up some of the duplication of perl scripts we now have.

cheers
