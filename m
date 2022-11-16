Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5361462B012
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiKPAda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKPAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:33:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99BBF;
        Tue, 15 Nov 2022 16:33:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDD6360E65;
        Wed, 16 Nov 2022 00:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D87C433D6;
        Wed, 16 Nov 2022 00:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668558805;
        bh=iJTS8EkzL0qvGTxZzjMwXMPRiR5MYwHdPFSOBGvjoIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFUB4eL5N8849Ih8QW0Damnjjrx1Z4QyyXiWEzgbuU53ZMCcg61Stj4psKEJv7njf
         703IBe5xj0D65WE4M36vYzhjr+8Tqrv5Lx006hqZ0EadVYSZeh9NM+AdT2jbfEjNl6
         2klBpa0hchPyHkt7bNXss3SNeNZ6M1Ubt3cbTSeco2RA7W0N1NBfnMi8rK6CS+cBuo
         vZgrmDtEQ0CMZW8qx1ecqN5vgbTmF9ela3pehhFuU9IDp5e2uS1REejfJ+xOujAQAH
         JJxktQ9nkP23xybzooA+tNMhOK3LfyFFK+sTGPfHTgccbTDZ6cacIZWVt0sxVNijXT
         bhKBG3XnWlkew==
Date:   Wed, 16 Nov 2022 02:33:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] KEYS: trusted: tee: Make registered shm dependency
 explicit
Message-ID: <Y3Qv0hehr/yKNvy4@kernel.org>
References: <20221110111140.1999538-1-sumit.garg@linaro.org>
 <CAFA6WYMKSjvgNgbf=cJXiTE3LitS-whtRbqJW1cdkHMJ1TsdUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMKSjvgNgbf=cJXiTE3LitS-whtRbqJW1cdkHMJ1TsdUg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:44:20PM +0530, Sumit Garg wrote:
> + Jarkko (Apologies I accidently missed you while sending the original patch).
> 
> On Thu, 10 Nov 2022 at 16:42, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > TEE trusted keys support depends on registered shared memory support
> > since the key buffers are needed to be registered with OP-TEE. So make
> > that dependency explicit to not register trusted keys support if
> > underlying implementation doesn't support registered shared memory.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  security/keys/trusted-keys/trusted_tee.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> > index c8626686ee1b..ac3e270ade69 100644
> > --- a/security/keys/trusted-keys/trusted_tee.c
> > +++ b/security/keys/trusted-keys/trusted_tee.c
> > @@ -219,7 +219,8 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
> >
> >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> >  {
> > -       if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> > +       if (ver->impl_id == TEE_IMPL_ID_OPTEE &&
> > +           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> >                 return 1;
> >         else
> >                 return 0;
> > --
> > 2.34.1
> >

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
