Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D937561F2B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiKGMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKGMOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:14:22 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD9C57;
        Mon,  7 Nov 2022 04:14:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 130so10419297pfu.8;
        Mon, 07 Nov 2022 04:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ+gNJJepQlf8XJSvmdtr0TPbl2KfXJ0oNv3mgjP2Dg=;
        b=JyfGs+MDUZcifcgPVXFnVeOmLHENtS/FduSr39qrJ8yzXHLIIpPAPnvzSUsrZX3PyN
         zLoBqE/PkL2l2WsR7L56gKnji/tbaOKclVTJ0MQorKznw9Kt8UHAnAPH/+fLVrGljJi1
         EH4O4KJjq6vAvrWsI8lV5kybo9KnmrUA8DF40u1RniyGSMmvsoYr2olNuYxas8ZyNPA+
         8BZO9QygNtkNQFPvCquOpwTVB9CUA9LDeP//fiBrgKprVQcHqrR9nNI4Edh9cCDODFtd
         t9JGzjcqr1UZP46Alm4D/OP0zB/iVgAav42yDfphdgzWZxSMG/nQDTeY7spHCnVvn8Sr
         wSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJ+gNJJepQlf8XJSvmdtr0TPbl2KfXJ0oNv3mgjP2Dg=;
        b=2BIw3X8d5iAB5tVrKumFtun2nXDFFNYmbDOYbtx7OUyrBufDgtgSEG4RiqVcR3c508
         isIHKQ4r77Nf61yNSKMzWAIjd+Ozvcng7VaaEaHNXeAaU8JSiss7DuAmnGvGABEP1rVm
         A5nuPXKNz8vbhhrQs9hYv//2qwGSatHv7wUYhpdhXy1D/PADuSNq3W/Lu+h+3nOo17mc
         2lTEZHY1ajy+v02rcb0YbMXQI/UvevCjbLAmmCTf+l5wHI2+6MAfifaNgIsndGhfyxRD
         3NWvHq+K0+J9ksTJVTtwVkHQA15WYpqJV67rNQ5767xQxVIG7G1k1gNUTS+Wx77Yotga
         TUaw==
X-Gm-Message-State: ACrzQf2jm47760rqK6IFzIkKSJa2CQPHl2qU3VTFd0Rk7zPTzzhpnPTh
        rPBMkufkSwQl8jTsgK6lJCmLDtzQybM=
X-Google-Smtp-Source: AMsMyM4HXzx5BuHaRsAFLo+H6id+TDJGAPRqqnErE3GfBt1WV2tNRKTch9s/uiVXFwiAlaTJnRnWBA==
X-Received: by 2002:a63:5341:0:b0:46f:d05d:55cf with SMTP id t1-20020a635341000000b0046fd05d55cfmr33552519pgl.356.1667823261575;
        Mon, 07 Nov 2022 04:14:21 -0800 (PST)
Received: from localhost (203-221-202-134.tpgi.com.au. [203.221.202.134])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b001830ed575c3sm4828350plr.117.2022.11.07.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 04:14:21 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Nov 2022 22:14:16 +1000
Message-Id: <CO6202HG8VAN.1ROEE25G4KDK2@bobo>
Subject: Re: [PATCH v5 2/2] powerpc/64: Add module check for ELF ABI version
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Jessica Yu" <jeyu@kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>
X-Mailer: aerc 0.11.0
References: <20221031120733.3956781-1-npiggin@gmail.com>
 <20221031120733.3956781-3-npiggin@gmail.com>
 <513e1973-a1d4-c698-1441-9c7d0f5205ed@csgroup.eu>
In-Reply-To: <513e1973-a1d4-c698-1441-9c7d0f5205ed@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 3, 2022 at 6:35 PM AEST, Christophe Leroy wrote:
>
>
> Le 31/10/2022 =C3=A0 13:07, Nicholas Piggin a =C3=A9crit=C2=A0:
> > Override the generic module ELF check to provide a check for the ELF AB=
I
> > version. This becomes important if we allow big-endian ELF ABI V2 build=
s
> > but it doesn't hurt to check now.
> >=20
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > [np: split patch, added changelog, adjust to Jessica's proposal]
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/kernel/module.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.=
c
> > index f6d6ae0a1692..d46bf9bfda26 100644
> > --- a/arch/powerpc/kernel/module.c
> > +++ b/arch/powerpc/kernel/module.c
> > @@ -19,6 +19,23 @@
> >  =20
> >   static LIST_HEAD(module_bug_list);
> >  =20
> > +#ifdef CONFIG_PPC64
>
> Can it go in arch/powerpc/kernel/module_64.c instead ?
>
> > +bool module_elf_check_arch(Elf_Ehdr *hdr)
> > +{
> > +	unsigned long abi_level =3D hdr->e_flags & 0x3;
> > +
> > +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2)) {
> > +		if (abi_level !=3D 2)
> > +			return false;
> > +	} else {
> > +		if (abi_level >=3D 2)
> > +			return false;
> > +	}
> > +
> > +	return true;
>
> Can be simpler:
>
> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
> 		return abi_level =3D=3D 2;
> 	else
> 		return abi_level < 2;

Yes I think both of those can be done. Good suggestions.

Thanks,
Nick
