Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D573E5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjFZRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFZRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:06:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F26E7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:06:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b539d2f969so23596195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687799201; x=1690391201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2t/6AuCGHu+g1mzUi3uHQSoDcB61+uw4A1sl2aTsDM=;
        b=VL9wL2ourXiEvavwXqheIk73JPQwGGIH/H2tda9/Zck/TvRhVxV9oYsIvIrgQb2uoR
         czgVjuZJvSCtc/cyiZpI1tdiOBFAQQxEZNvUpN/teRyo3rlg7ua/6w2MBf4PNwaTjIGC
         NtvQawe+cOaK43vt2lJ5HRfxkQyGbEIAOvS1iFM5Z275b/luF8a5GGF7Lf9NxkJ66W4P
         Ud2s3StNuqd0sR3p6jbbkyzVCnoT9jc3SvLXCJl/SgCqy6x37qogwLNqITcPb1H79Q0Y
         ll7gBl0y8iSAzAvqj/f1e1CjK0Nrbgego8zQl40fh8WlXDSt4H1GSgzTs7teof7ND609
         R+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799201; x=1690391201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2t/6AuCGHu+g1mzUi3uHQSoDcB61+uw4A1sl2aTsDM=;
        b=gIWYMOp09upsho/5WWNhnJMhijtrwbEOkPUQxHSCo32DqYFPI5otrsPy1BnBKadC/B
         GNuR0uRH37Jrt1KERpgYCsOepmRGhw3dx4Qywbq5gt9rSRb3+WC3M04iss7mMdznDTvN
         tjKuzAMkDpiC0U2KQhpufixlX1Qf4G8NookajnH0kpKBq/0LkrY5QZRjuTevqzXc5R4O
         3y4YNi66lQzinfTZXrarPG7BF1luE4H7teqDi8LttfU+Gw1gqDAiY4d5sr66YNCdqlh/
         dcO/X6mxLTr//DhTizAsnv4P+uaYWY5m0mQsi6VsbcRQUv8uvYoJZ2cKQusgalCXUt+i
         pdew==
X-Gm-Message-State: AC+VfDyvwVAU8eWfZul9Sa9HSz4xBdrOoN44FzW2fuXi5WfKR2NhbuSF
        zt46y9iwl31M9k33vpVmjMFeyg==
X-Google-Smtp-Source: ACHHUZ6unRv0OlEcCIZYcuG4X+sRKYMWHVWf1+9GkTHOWMxxJlTDQ3OSvpC2peZAtNC3r4ALhBBm7A==
X-Received: by 2002:a17:902:c1d2:b0:1b5:e30:94dc with SMTP id c18-20020a170902c1d200b001b50e3094dcmr8092819plc.7.1687799201193;
        Mon, 26 Jun 2023 10:06:41 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902988c00b00198d7b52eefsm4420214plp.257.2023.06.26.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:06:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:06:35 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 2/6] KVM: Documentation: Update the field name gfns in
 kvm_mmu_page
Message-ID: <ZJnFm0gD4K0uc92G@google.com>
References: <20230618000856.1714902-1-mizhang@google.com>
 <20230618000856.1714902-3-mizhang@google.com>
 <ZJTnvuoVWLhv0H0f@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJTnvuoVWLhv0H0f@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023, Xu Yilun wrote:
> On 2023-06-18 at 00:08:52 +0000, Mingwei Zhang wrote:
> > Update the 'gfns' in kvm_mmu_page to 'shadowed_translation'to be consistent
> > with the code. The more detailed description of 'shadowed_translation' is
> > already inlined in the data structure definition, so no need to duplicate
> > the text but simply just update the name.
> 
> The definition of this field is changed, but apprently the description
> here is for gfns. It leaves some confusion if we just leave them
> unchanged.
> 
> > 
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  Documentation/virt/kvm/x86/mmu.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
> > index 561efa8ec7d7..149dd3cba48f 100644
> > --- a/Documentation/virt/kvm/x86/mmu.rst
> > +++ b/Documentation/virt/kvm/x86/mmu.rst
> > @@ -221,7 +221,7 @@ Shadow pages contain the following information:
> >      at __pa(sp2->spt).  sp2 will point back at sp1 through parent_pte.
> >      The spt array forms a DAG structure with the shadow page as a node, and
> >      guest pages as leaves.
> > -  gfns:
> > +  shadowed_translation:
> >      An array of 512 guest frame numbers, one for each present pte.  Used to
> 
> guest frame numbers -> shadow translation info (gfn + access)

Will add this one. I will avoid the "(gfn + access)" since that is
already described in the comments inline and it may subject to changes,
eg., adding more bits in the future.
> 
> >      perform a reverse map from a pte to a gfn. When role.direct is set, any
> 
> Just "perform reverse mapping" is OK?

I will tend to leave that as is, since it is not a major issue.
> 
> >      element of this array can be calculated from the gfn field when used, in
> 
> May remove the "of gfns"

will do.
>
> Thanks,
> Yilun

Thanks for the comment, will update it in next version.
> 
> > -- 
> > 2.41.0.162.gfafddb0af9-goog
> > 
