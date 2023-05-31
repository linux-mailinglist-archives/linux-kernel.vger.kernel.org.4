Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2787176BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjEaGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:18:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41511C;
        Tue, 30 May 2023 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OMeS+07AgIwC67dUdNYRuvFtsnzkhUi03Dd3OAGMjZo=;
        t=1685513903; x=1686723503; b=kujNYQXiS7mBi1bJ4NU9P9qKKvbngqdr0sb7R6YJ/1Jek9Y
        dLCEULDjPnnEyPr9K4fJmwiFQrzCu5IFA8kJpV1ia4m/kMFwAVEFTYBwL+9CW809HkOssOdr24CqN
        suO9MUyLnteEwJ2lwl2+rdqq7n5hVBjhQ3UvkmpTiojn9Kh0yjjFbLMO4zfZKifUFo3cCo2m1mTYe
        cAMqgFwgBFyu0dtqXtA+dlXpNq1MGBvXc7QwYnKpvwce2m23KRFdsSxdcmie4Ha7eR8ZjtE+nNSUU
        +wINm7n0nTEl3n0Agfby6wgPgmLsh9jg59soWj3XIRm8QqM2jr3VsVON9L0rLh6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q4F9q-009CER-0i;
        Wed, 31 May 2023 08:18:06 +0200
Message-ID: <8033fb8f9677cf9aae411e97eb554d251ca03011.camel@sipsolutions.net>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Date:   Wed, 31 May 2023 08:18:00 +0200
In-Reply-To: <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
         <202305311135.zGMT1gYR-lkp@intel.com>
         <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -		strlcpy(ifr.ifr_name, pri->dev_name,
> sizeof(ifr.ifr_name));
> +		strscpy(ifr.ifr_name, pri->dev_name,
> sizeof(ifr.ifr_name));
>=20

> >   arch/um/os-Linux/drivers/tuntap_user.c: In function 'tuntap_open':
> > > > arch/um/os-Linux/drivers/tuntap_user.c:149:17: error: implicit decl=
aration of function 'strscpy'; did you mean 'strncpy'? [-Werror=3Dimplicit-=
function-declaration]
> >     149 |                 strscpy(ifr.ifr_name, pri->dev_name, sizeof(i=
fr.ifr_name));
> >         |                 ^~~~~~~
> >         |                 strncpy
> >   cc1: some warnings being treated as errors
>=20
> Ah, yeah, this is another "not actually in the kernel" cases. Let's ignor=
e this strlcpy for now.
>=20

Well, strlcpy() isn't part of libc either, so all this would need is to
add it to user.h just like strlcpy() is now?

johannes
