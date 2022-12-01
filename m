Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A546763EB91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLAIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiLAItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:49:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98C8C689;
        Thu,  1 Dec 2022 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669884517; x=1701420517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e0sGk5FC+bQXFAkQVJL15UcqqaRVlO2Lo1qDc6ms+U8=;
  b=f9IeOvH49cL2xGrVCDsqD3NlkF76QgXbgm5JbLGgSZKW1BGWGw/viaSP
   3sMnyAl/d01sBLKw5pw3zy/1pswMPiBZacLoFqZQBItQjl5Umu6bVZ1wY
   usUYROYBss8YiDMski8otzHBy6ZbPdaZ+xc+Kb0tSwuU0G9lXaVEMQWed
   lCHxyp5JbBWXLBCOyDDUMnvd8qSHiZ7FQLK77acwHTcjuXlxp434EigEz
   bi8olOAbxkeCuSBHAD7zWANWsQ7aprn/OMAcpw/lUOJaGJUpmuCI9iQ4y
   1WT2cTndhgaAq1NWqOnTk6SGiCTW85Th5TbtRzfbpflMxOvCjM1ejmR8c
   g==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="125953620"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 01:48:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 01:48:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 01:48:34 -0700
Date:   Thu, 1 Dec 2022 08:48:15 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <aou@eecs.berkeley.edu>,
        <corbet@lwn.net>, <guoren@kernel.org>, <heiko@sntech.de>,
        <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] RISC-V: clarify ISA string ordering rules in cpu.c
Message-ID: <Y4hqTwpyxMqZTyoC@wendy>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-2-conor@kernel.org>
 <20221201082743.xjxcnx7zcwycdwy7@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201082743.xjxcnx7zcwycdwy7@kamzik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:27:43AM +0100, Andrew Jones wrote:
> On Wed, Nov 30, 2022 at 11:41:24PM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > While the current list of rules may have been accurate when created
> > it now lacks some clarity in the face of isa-manual updates. Instead of
> > trying to continuously align this rule-set with the one in the
> > specifications, change the role of this comment.
> > 
> > This particular comment is important, as the array it "decorates"
> > defines the order in which the ISA string appears to userspace in
> > /proc/cpuinfo.
> > 
> > Re-jig and strengthen the wording to provide contributors with a set
> > order in which to add entries & note why this particular struct needs
> > more attention than others.
> > 
> > While in the area, add some whitespace and tweak some wording for
> > readability's sake.
> > 
> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 49 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 36 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 852ecccd8920..68b2bd0cc3bc 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -120,22 +120,45 @@ device_initcall(riscv_cpuinfo_init);
> >  		.uprop = #UPROP,				\
> >  		.isa_ext_id = EXTID,				\
> >  	}
> > +
> >  /*
> > - * Here are the ordering rules of extension naming defined by RISC-V
> > - * specification :
> > - * 1. All extensions should be separated from other multi-letter extensions
> > - *    by an underscore.
> > - * 2. The first letter following the 'Z' conventionally indicates the most
> > + * The canonical order of ISA extension names in the ISA string is defined in
> > + * chapter 27 of the unprivileged specification.
> > + *
> > + * Ordinarily, for in-kernel data structures, this order is unimportant but
> > + * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
> > + *
> > + * The specification uses vague wording, such as should, when it comes to
> > + * ordering so for our purposes the following rules apply:
> > + *
> > + * 1. All multi-letter extensions must be separated from other multi-letter
> 
> 1. All multi-letter extensions must be separated from other extensions by an
> underscore.
> 
> (Because we always lead multi-letter extensions with underscore, even the
> first one, which follows the single-letter extensions.)

Yah, I need to think as if I am using De Morgan's... The DT ABI requires
"should" and permits this. The uAPI is "must"/"will" and always has an
_. I'll propagate that change to the docs patch too.

> > + *    extensions by an underscore.
> > + *
> > + * 2. Additional standard extensions (starting with 'Z') must be sorted after
> > + *    single-letter extensions and before any higher-privileged extensions.
> > +
> > + * 3. The first letter following the 'Z' conventionally indicates the most
> >   *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> > - *    If multiple 'Z' extensions are named, they should be ordered first
> > - *    by category, then alphabetically within a category.
> > - * 3. Standard supervisor-level extensions (starts with 'S') should be
> > - *    listed after standard unprivileged extensions.  If multiple
> > - *    supervisor-level extensions are listed, they should be ordered
> > + *    If multiple 'Z' extensions are named, they should be ordered first by
> > + *    category, then alphabetically within a category.
> > + *
> > + * 3. Standard supervisor-level extensions (starting with 'S') must be listed
> > + *    after standard unprivileged extensions.  If multiple
> > + *    supervisor-level extensions are listed, they must be ordered
> >   *    alphabetically.
> > - * 4. Non-standard extensions (starts with 'X') must be listed after all
> > - *    standard extensions. They must be separated from other multi-letter
> > - *    extensions by an underscore.
> > + *
> > + * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
> > + *    after any lower-privileged, standard extensions.  If multiple
> > + *    machine-level extensions are listed, they must be ordered
> > + *    alphabetically.
> > + *
> > + * 5. Non-standard extensions (starts with 'X') must be listed after all
> > + *    standard extensions.
>                             ^and alphabetically.

"If multiple non-standard extensions are listed, they must be ordered
alphabetically." I'll also propagate this to the doc one, if I have not
already.

> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Cool. I'll give it a bit before respinning, but I think we are at least
getting less ambiguous as time goes on..

Thanks,
Conor.

