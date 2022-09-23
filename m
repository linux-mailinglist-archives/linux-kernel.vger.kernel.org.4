Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC605E70A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiIWAUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIWAUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:20:38 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E268BB6D71
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:20:35 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1280590722dso16286907fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=wOI+7RifnLsYvXIuNif1j+Pe+3PvkPZ4LwCVFhf/miw=;
        b=cZWwxqBBqFBqZum7y2sdaWueRJk5Us1AGAxvEJgqRMCQuHx2yI/jwjQB1XYgoNLPOf
         /0N+AC55M/O3nmfswF118uqVF39kqxBXHVJvYFMjMCeZChRo2LWTJwzZwFEtC3AOr8V7
         MTqTmjysE6gePjdjSrSQb9Z4FEDg+SBdA+dM0antiTxZgySwVqouwi5mKlPWCr7Sp2AR
         RKM+fzaxwOHgYEfGdJLcpFt5+MkaRtZa7/nv4IEFotZOJMO/rlLDG01/MMUCL7/z7Glg
         5BXxZQ5az53lcqjLErse5UYvf6c2rBDqyKOR+3RqlDovaIVn84kJegwADk4YTz1qyTlt
         MIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=wOI+7RifnLsYvXIuNif1j+Pe+3PvkPZ4LwCVFhf/miw=;
        b=n9m6X4hZoVfI/61bsPtUawdtRKpSQltegBQ1x2LQRZkrtWzieqgFyLWpWCkHpnphmu
         KdQR0AWzyIL0T9pVbjuNp3bqKK1V6QLULdnpOQZ4Zv4rV7rtmBtPDouIHrQrwyc35Kb4
         m6rEgawl/a7VU/T9jke8YjfZpbGoOfGsDiZE/0wuiUnKTcQCvXHOQ5q26RDiKXHsVI3o
         Ygq93peabdlvdMUbT2G2faQOCHIwvWYvHTUXvRe5+bBZJHwUOTwTO8P210ICjc7GP6ir
         o3GdfOGJQS4LJ4WfOogP6up5JVMpoEVrnDCYm7gXt7V8iVKJlc1PaktCIZRSLVWgtOHb
         obcw==
X-Gm-Message-State: ACrzQf1jbFjnoA19TZgIGJBGBpCFIeNKRuyYFWk6msjlF+sR+T6F8QxV
        CG3QKFoDvYo90n6Qsyb2sA==
X-Google-Smtp-Source: AMsMyM6G4hH7WcGJQf2c+vIHQ/UgvzOI553Q8KD5llT+YUAU3KJEKt3k3/pk0J5PdEZ8Z6RFRkwWEw==
X-Received: by 2002:a05:6870:d7a5:b0:11d:a0b:f62b with SMTP id bd37-20020a056870d7a500b0011d0a0bf62bmr3438571oab.190.1663892434995;
        Thu, 22 Sep 2022 17:20:34 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x9-20020a056870330900b0011c20ffca67sm3825860oae.28.2022.09.22.17.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 17:20:34 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5d3f:d09:85d2:d6e])
        by serve.minyard.net (Postfix) with ESMTPSA id 45A14180015;
        Fri, 23 Sep 2022 00:20:33 +0000 (UTC)
Date:   Thu, 22 Sep 2022 19:20:32 -0500
From:   Corey Minyard <minyard@acm.org>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] ipmi: kcs: aspeed: Update port address comments
Message-ID: <Yyz70LckHqyiNhGa@minyard.net>
Reply-To: minyard@acm.org
References: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
 <YyywI8265vECnEHv@minyard.net>
 <HK0PR06MB37794D51E9DB4A864249F96691519@HK0PR06MB3779.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB37794D51E9DB4A864249F96691519@HK0PR06MB3779.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:08:07AM +0000, ChiaWei Wang wrote:
> Hi Corey,
> 
> > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
> > Sent: Friday, September 23, 2022 2:58 AM
> > 
> > On Tue, Sep 20, 2022 at 10:03:33AM +0800, Chia-Wei Wang wrote:
> > > Remove AST_usrGuide_KCS.pdf as it is no longer maintained.
> > 
> > Even if it's no longer maintained, is it useful?  It seems better to leave in
> > useful documentation unless it has been replaced with something else.
> 
> This document has no permeant public link to access.
> Aspeed has dropped this file but we keep receiving customer request asking for this document.
> The most important part regarding KCS port rule is still kept in the updated comment.

I mean, if you have code that is implementing what is documented, why
did you remove the document?  I don't understand why you would retire
documentation that people still want to use.

I could put it on the IPMI sourceforge or github page as a historical
document.

-corey

> 
> Regards,
> Chiawei
> 
> > 
> > 
> > >
> > > Add more descriptions as the driver now supports the I/O address
> > > configurations for both the KCS Data and Cmd/Status interface
> > > registers.
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  drivers/char/ipmi/kcs_bmc_aspeed.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > index cdc88cde1e9a..19c32bf50e0e 100644
> > > --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > @@ -207,17 +207,24 @@ static void aspeed_kcs_updateb(struct
> > > kcs_bmc_device *kcs_bmc, u32 reg, u8 mask,  }
> > >
> > >  /*
> > > - * AST_usrGuide_KCS.pdf
> > > - * 2. Background:
> > > - *   we note D for Data, and C for Cmd/Status, default rules are
> > > - *     A. KCS1 / KCS2 ( D / C:X / X+4 )
> > > - *        D / C : CA0h / CA4h
> > > - *        D / C : CA8h / CACh
> > > - *     B. KCS3 ( D / C:XX2h / XX3h )
> > > - *        D / C : CA2h / CA3h
> > > - *        D / C : CB2h / CB3h
> > > - *     C. KCS4
> > > - *        D / C : CA4h / CA5h
> > > + * We note D for Data, and C for Cmd/Status, default rules are
> > > + *
> > > + * 1. Only the D address is given:
> > > + *   A. KCS1/KCS2 (D/C: X/X+4)
> > > + *      D/C: CA0h/CA4h
> > > + *      D/C: CA8h/CACh
> > > + *   B. KCS3 (D/C: XX2/XX3h)
> > > + *      D/C: CA2h/CA3h
> > > + *   C. KCS4 (D/C: X/X+1)
> > > + *      D/C: CA4h/CA5h
> > > + *
> > > + * 2. Both the D/C addresses are given:
> > > + *   A. KCS1/KCS2/KCS4 (D/C: X/Y)
> > > + *      D/C: CA0h/CA1h
> > > + *      D/C: CA8h/CA9h
> > > + *      D/C: CA4h/CA5h
> > > + *   B. KCS3 (D/C: XX2/XX3h)
> > > + *      D/C: CA2h/CA3h
> > >   */
> > >  static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32
> > > addrs[2], int nr_addrs)  {
> > > --
> > > 2.25.1
> > >
