Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D139663CCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiK3BX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3BXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:23:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7142F66C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 17:23:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn7so15163925plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ewUKpCuoaPzAR2fmrr+FD3H80AnrDry9LxbpWXLNvF4=;
        b=fb6DDgCaO06aAL+G5/T2sy0zhAJSlkluomnYowvIHNfrJbn2iaW5lHshIKewz5bOza
         ZaVgBpSB1cf2gMMANnU8K3AmjeUTIEKMNAbICy4G4jI4J2CpMNUvY/Js2ymp2Vkdcrpc
         I/d8R9iBlPs25vU0P4/h91XTk5DY/HLFSeS9bfgUuz+/VqMoOnk6kDmp8yWPVrf6tnND
         gTm4F2hpkbVA2broOTWoHcFoZM+TXUmFgKcJTGxHhtdYC50vDAMDfxB23yxt9I+Qq5xa
         Efw8DrsJ1oUnwHKABaYjsxPhyqo6wl960Zc0CTDg/x5TzQW5EkrrtjjLH6tEdMXomJIo
         QP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewUKpCuoaPzAR2fmrr+FD3H80AnrDry9LxbpWXLNvF4=;
        b=X2uYablb7xEnZh1sPsgtSa7v4iXFwhAp44wd2txE4h2anEjq3JmpdbFsp+mkJP+vhC
         RZ255ZKTgk3KJnEBQSmNI5ESAAzlzsvTb0iWveDcdwWLVe/HdWLYaMQ9WmQ1eUsu9xgp
         bsxHKNEr1+Z3H+HmIabl12WOrL2yTzoDdEYt4QR6csWB4brRvR/0V2MiDZ0tU2ecEBmY
         Lf0lzpR10qfPx7oeo4Wc2RghZUztJHuS5fUO3qb5ohyvV5Oa7CIJBhCPS7HMy3iPTPq8
         V4eoWDzAXGIYfXIg2ZYDeQfy+3936d2Pqa26SO8TXlW244GvR9RxNBvzBlF4ynUOeIuD
         ScUw==
X-Gm-Message-State: ANoB5pnK6AMnv/ALb7Y6/9kdW4n3XbjPHb1EVLPRx8Vsmcys4B4q+Cr1
        TZIFVu+9S4SFutrVAl04MmfR7w==
X-Google-Smtp-Source: AA0mqf7fkXBzPKsGf+r09kMkzskIdRv4AjvbWaWxjMbW/TRWAGLM3zhTZlBXjYYEDVoWL3AUhcc9xA==
X-Received: by 2002:a17:902:db07:b0:189:9ee0:cca4 with SMTP id m7-20020a170902db0700b001899ee0cca4mr4412610plx.74.1669771404345;
        Tue, 29 Nov 2022 17:23:24 -0800 (PST)
Received: from google.com (220.181.82.34.bc.googleusercontent.com. [34.82.181.220])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79903000000b0056da63c8515sm119230pff.91.2022.11.29.17.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 17:23:23 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:23:20 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: arm64: Don't serialize if the access flag isn't
 set
Message-ID: <Y4awiKLuKORZmU2z@google.com>
References: <20221129191946.1735662-1-oliver.upton@linux.dev>
 <20221129191946.1735662-3-oliver.upton@linux.dev>
 <Y4Zw/J3srTsZ57P7@google.com>
 <Y4Z2aWVEnluy+d3+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4Z2aWVEnluy+d3+@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:15:21PM +0000, Oliver Upton wrote:
> Hi Ricardo,
> 
> Thanks for having a look.
> 
> On Tue, Nov 29, 2022 at 12:52:12PM -0800, Ricardo Koller wrote:
> > On Tue, Nov 29, 2022 at 07:19:44PM +0000, Oliver Upton wrote:
> 
> [...]
> 
> > > +	ret = stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
> > > +				       &pte, NULL, 0);
> > > +	if (!ret)
> > > +		dsb(ishst);
> > 
> > At the moment, the only reason for stage2_update_leaf_attrs() to not
> > update the PTE is if it's not valid:
> > 
> > 	if (!kvm_pte_valid(pte))
> > 			return 0;
> > 
> > I guess you could check that as well:
> > 
> > +	if (!ret || kvm_pte_valid(pte))
> > +		dsb(ishst);
> 
> Thanks for catching this.
> 
> Instead of pivoting on the returned PTE value, how about we return
> -EAGAIN from the early return in stage2_attr_walker()? It would better
> match the pattern used elsewhere in the pgtable code.

That works, although I would use another return code (e.g., EINVAL)? as
that's not exactly a "try again" type of error.

> 
> --
> Thanks,
> Oliver
