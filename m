Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3FC5E70CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIWAqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIWAqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:46:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A49FE21F7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:46:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a20so7496538qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=mXVWJIJwSO3raPa9ufywv7c+77gnmVznFVtzSWE/PWI=;
        b=CnUtdlr3MflXY9APdCyGECCKCC6Tg9h7Xm0eVaSftVCuFpx60N0VpT3gsXKWp2kJTY
         BXfmkKkmCmMzeBqeM5TSPaMsFazVxYCHrB9XzOgVrMnFKe3GXPL9xlqeXzL71fci+GQQ
         1xYLa7an7rxSru244yJW+eB9FK8APVNsjDKGTjwtGH7hKxgKNOS0B5QptjEbE04XDya7
         3zsVN2/eKX24VQntvodQAVNVCUPnO7xHK7i8AYcAo4Z+kwLOlvwVEbVBcMyipjuBhQIL
         ZEE/yM3/2wqIf/Gz7jH880f9PvFOwqvoAYltFFZAufrTg6Lrk5XgGIlT8vo3hY8RiTex
         i16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=mXVWJIJwSO3raPa9ufywv7c+77gnmVznFVtzSWE/PWI=;
        b=4CZCzMWfxtmptleWjmKv5WnhzI3Py76WhOQmpEAKBx30jXMRHhjjUXRR1Pm1I95zrX
         dJ6z5cojrTjjjhfUTOyhZiO/TRjwHqGQvIgsbdmq76QMgNr6HMEyuUr77cH33LMxxjhr
         RYGVUvWHxkGVU1AgfsP4n9jaDoGZFJs63CgUrgkLsbAkPzmMDUNr7S2FKX1SRyV1JnXC
         rE+5MSSvqFkdlNr/VU8uJO/XavdqKS2jUtaguLca6fKq46seLCI7CWTbFPtsrVCPEsKA
         IhF8D00HINDdXXgD5OoZBQT+ZP44C/Xtt2gegWIy0zVNf+iqE9FQa2QfP599QICRzvbj
         igYg==
X-Gm-Message-State: ACrzQf0j1qEL8ZCKfO4xwoNgwz+Vli/MSpB3bdiDuyPIbvHKL9BlqM6R
        0pOyUPOzFekY+l1/3TDCaw==
X-Google-Smtp-Source: AMsMyM7Vwi8UT8AzmcUsgZ+9Dfnkxh4vwpyYFitMUQ1x78fA2yBEqtNkAHc+z3c3ThqM2bEfFYa5lA==
X-Received: by 2002:ac8:578c:0:b0:35c:d9fe:98f7 with SMTP id v12-20020ac8578c000000b0035cd9fe98f7mr5175139qta.360.1663893994524;
        Thu, 22 Sep 2022 17:46:34 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id br30-20020a05620a461e00b006ceafb1aa92sm5152695qkb.96.2022.09.22.17.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 17:46:33 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5d3f:d09:85d2:d6e])
        by serve.minyard.net (Postfix) with ESMTPSA id 9E69A180015;
        Fri, 23 Sep 2022 00:46:32 +0000 (UTC)
Date:   Thu, 22 Sep 2022 19:46:31 -0500
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
Message-ID: <Yy0B5+jzc7R7Drz7@minyard.net>
Reply-To: minyard@acm.org
References: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
 <YyywI8265vECnEHv@minyard.net>
 <HK0PR06MB37794D51E9DB4A864249F96691519@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <Yyz70LckHqyiNhGa@minyard.net>
 <HK0PR06MB377992E9AF7B91CE41452B4A91519@HK0PR06MB3779.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB377992E9AF7B91CE41452B4A91519@HK0PR06MB3779.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:38:08AM +0000, ChiaWei Wang wrote:
> > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
> > Sent: Friday, September 23, 2022 8:21 AM
> > 
> > On Fri, Sep 23, 2022 at 12:08:07AM +0000, ChiaWei Wang wrote:
> > > Hi Corey,
> > >
> > > > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey
> > Minyard
> > > > Sent: Friday, September 23, 2022 2:58 AM
> > > >
> > > > On Tue, Sep 20, 2022 at 10:03:33AM +0800, Chia-Wei Wang wrote:
> > > > > Remove AST_usrGuide_KCS.pdf as it is no longer maintained.
> > > >
> > > > Even if it's no longer maintained, is it useful?  It seems better to
> > > > leave in useful documentation unless it has been replaced with something
> > else.
> > >
> > > This document has no permeant public link to access.
> > > Aspeed has dropped this file but we keep receiving customer request asking
> > for this document.
> > > The most important part regarding KCS port rule is still kept in the updated
> > comment.
> > 
> > I mean, if you have code that is implementing what is documented, why did
> > you remove the document?  I don't understand why you would retire
> > documentation that people still want to use.
> > 
> > I could put it on the IPMI sourceforge or github page as a historical document.
> 
> This document is a personal note of one of our former employee.
> It is known to only the owner and his supporting customers.
> Most of us has no access to this document.
> In addition, after chip revision, certain information is not guaranteed anymore.

Ok, I'll take the patch.  Thanks.

-corey

> 
> Regards,
> Chiawei
