Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F54659021
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiL2SJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2SJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:09:36 -0500
X-Greylist: delayed 2081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Dec 2022 10:09:34 PST
Received: from hetzy.fluff.org (test-v6.fluff.org [IPv6:2a01:4f8:222:2004::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABD712A90
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:09:34 -0800 (PST)
Received: from ben by hetzy.fluff.org with local (Exim 4.89)
        (envelope-from <ben@fluff.org>)
        id 1pAwnn-0008Me-Uh; Thu, 29 Dec 2022 17:34:48 +0000
Date:   Thu, 29 Dec 2022 17:34:47 +0000
From:   Ben Dooks <ben@fluff.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ben-linux@fluff.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH] riscv: uaccess: fix type of 0 variable on error in
 get_user()
Message-ID: <20221229173447.qhcaamchxv5jkbpo@hetzy.fluff.org>
References: <20221229170545.718264-1-ben-linux@fluff.org>
 <mhng-33b9aafc-448a-4400-9a06-cb222724363a@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-33b9aafc-448a-4400-9a06-cb222724363a@palmer-ri-x1c9>
X-Disclaimer: These are my views alone.
X-URL:  http://www.fluff.org/
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@fluff.org
X-SA-Exim-Scanned: No (on hetzy.fluff.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:31:27AM -0800, Palmer Dabbelt wrote:
> On Thu, 29 Dec 2022 09:05:45 PST (-0800), ben-linux@fluff.org wrote:
> > If the get_user(x, ptr) has x as a pointer, then the setting
> > of (x) = 0 is going to produce the following sparse warning,
> > so fix this by forcing the type of 'x' when access_ok() fails.
> > 
> > fs/aio.c:2073:21: warning: Using plain integer as NULL pointer
> > 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > ---
> >  arch/riscv/include/asm/uaccess.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> > index 855450bed9f5..ec0cab9fbddd 100644
> > --- a/arch/riscv/include/asm/uaccess.h
> > +++ b/arch/riscv/include/asm/uaccess.h
> > @@ -165,7 +165,7 @@ do {								\
> >  	might_fault();						\
> >  	access_ok(__p, sizeof(*__p)) ?		\
> >  		__get_user((x), __p) :				\
> > -		((x) = 0, -EFAULT);				\
> > +		((x) = (__force __typeof__(x))0, -EFAULT);	\
> >  })
> > 
> >  #define __put_user_asm(insn, x, ptr, err)			\
> 
> Looks like arm64 has a pretty similar pattern.  They've got the __force
> __typeof__ already, but given the similarity it might be worth refactoring
> these to share the error checking code.

I looked there for an idea on how to fix.

> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I'll give this a bit of time like usual, unless anyone's opposed I'll put it
> on fixes.  I wasn't planning on sending a PR this week anyway due to the
> holidays.

Ok, it's a warning which would be nice to be fixed.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

