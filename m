Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FF66F6940
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjEDKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDKqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:46:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEDA46A1;
        Thu,  4 May 2023 03:46:41 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2fddb442d47so234826f8f.2;
        Thu, 04 May 2023 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683197200; x=1685789200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zdCbcdk6QnPG7VtZ4x/vz7lPGcrzozQcS4ayWI86dk=;
        b=eYOUhKuPf0y6qqzK9CH3z+7G4inH0kM0KxHDm/Gkl1damXhzYAHC4YUIuAkTh3+ZBz
         AE4h00yOO6PFeiYwJSLpSHw4fMiwfLAj8ukDTIG9QEytbCz3hPPmBsALMItjM5amj02B
         C3IrYwrzX8s7BUxNCl4Zd/3gQSbwMgvxnDjdpQByg6mNK+oznsvQcP+GCk2k4X+CcXYT
         Q+PemxD//w/A35pUVizFR57Ed3FSTGNk1IvabkW0s44bmK+Q1Kvx1jEaMoUgFvjf2vM9
         zZ6wLw/lLLVoRbF+xNGYmhnW1dCU6rpZu7bBjSgwQv3nrnwLUMds8E3HypaDnsNtjh9L
         leyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197200; x=1685789200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zdCbcdk6QnPG7VtZ4x/vz7lPGcrzozQcS4ayWI86dk=;
        b=crd6KX1fe3hEfsjVQl4HlItHiupIrpQmdTq5IMcmPfU8dJ4VVOF36WkpBxR574yD5P
         FmzFhqS8gz5EQhvuygrwynTrEtJ3RI4vleE3U2g9VzL0n2hZwzTmjIqBef0nQOpeH306
         Y/qVJVFkVYMqfLGUmLuFPwDy7dFh78UYMXCIllUseQ/bOr/MLvEqsoItnvr3yXk9oKHp
         NzdJMM9dHrIy/RhQAc/nM29kWT+WU2MlLpNk9WJfXvW3vSa/+mPHkUAud+jupLi1fYDf
         fl+PfdcXy2XKowypF8rAcvP81bW3QA8SUB55PFOGjZe1bJcZoaYGpT6qXf9w1nqPjHCh
         tsig==
X-Gm-Message-State: AC+VfDzbLUCX83PMraN94S6PSTkEDqpFumsMUBJ4JIGeOj3OsaoWCvmp
        bfEEDXZgdVqa8nr4uC6Z7RU=
X-Google-Smtp-Source: ACHHUZ6cs+Y79ICix1jxy8NAosC1izVsG4yj853+8KjnsyXcTX/Dtjp/1mmMjebtPBdMwPNQ2F2aZw==
X-Received: by 2002:adf:e904:0:b0:306:4063:1afe with SMTP id f4-20020adfe904000000b0030640631afemr1997467wrm.71.1683197199879;
        Thu, 04 May 2023 03:46:39 -0700 (PDT)
Received: from suse.localnet (host-212-171-7-24.pool212171.interbusiness.it. [212.171.7.24])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bcb88000000b003f173956a82sm4550146wmi.21.2023.05.04.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 03:46:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     raghuhack78@gmail.com, linux-cxl@vger.kernel.org,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed mem
 alloc
Date:   Thu, 04 May 2023 12:46:37 +0200
Message-ID: <2755196.BEx9A2HvPv@suse>
In-Reply-To: <ZFLaG8jHHXmRp67w@aschofie-mobl2>
References: <20230428012235.119333-1-raghuhack78@gmail.com> <3235466.44csPzL39Z@suse>
 <ZFLaG8jHHXmRp67w@aschofie-mobl2>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 4 maggio 2023 00:03:07 CEST Alison Schofield wrote:
> On Wed, May 03, 2023 at 08:32:37PM +0200, Fabio wrote:
> > On venerd=EC 28 aprile 2023 03:22:34 CEST Raghu H wrote:

[...]

> > >=20
> > > Signed-off-by: Raghu H <raghuhack78@gmail.com>
> >=20
> > Is "Raghu H" the name you sign legal documents with?
>=20
> Fabio,
> Rather than asking a specific question to determine if this is a
> valid SOB, let's just point folks to the documentation to figure
> it out themselves.
> I'm aware that the 'sign legal documents' test
> has been used in the past, but kernel only actually requires a
> known identity.
>=20
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sig=
n-you
> r-work-the-developer-s-certificate-of-origin
> https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md

Alison,

Thanks for your suggestions.

I have just a couple of questions about this issue...

1) How do we know that the "real name", which the Linux official documentat=
ion=20
refers to, should be interpreted in accordance to the document pointed by t=
he=20
second link you provided?=20

I mean, how can we be sure that the official documentation should be=20
interpreted according to the second link, since it doesn't even cite that=20
document from CNCF?=20

Can you provide links to documents / LKML's threads that state agreement of=
=20
our Community about the "relaxed" interpretation by CNCF?

2) It looks that some maintainers (e.g., Greg K-H) still interpret "[] usin=
g=20
your real name (sorry, no pseudonyms or anonymous contributions.)" in a=20
"strict" and "common" sense.=20

Can you remember that Greg refused all patches from "Kloudifold" and why? I=
f=20
not, please take a look at the following two questions / objections from Gr=
eg:=20
https://lore.kernel.org/linux-staging/ZCQkPr6t8IOvF6bk@kroah.com/ and=20
https://lore.kernel.org/linux-staging/ZBCjK2BXhfiFooeO@kroah.com/.

It seems that this issue it's not yet settled.=20
Am I overlooking something?

Again thanks,

=46abio

> > If not, please send a new version signed-off-by your full legal name.
> > Otherwise... sorry for the noise.
> >=20
> > Thanks,
> >=20
> > Fabio



