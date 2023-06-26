Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E273E705
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjFZRzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFZRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:55:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272A10D2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:55:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666eec46206so3205746b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687802108; x=1690394108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aQQSDBr5oatmPC3jRYA52hLZn7olUfljW9YDHvW1zAM=;
        b=V2GYqB5ZQKGlBdGq4Ggv2HY9SnXrvS+6OQvar/tPaSl8v1rTUd9eo+OUWlhFfPVPG5
         TGS0qUSoBeb2t39d9BAjPi8XnBSRP905tos6b6nJlFup7RpRn1ogqPkikP9uDkMTqx6Z
         4UCmTXYnSIYE3MclrgU36J1AyaPBuorg6mUGcJgYEiu2CttmuUFFs+9egk0mex0tW4xS
         7gchAvfYnRtXV1lveCg00na72TrbNbbNlg8rx/EQOxQ9NXoMlkYkU0Ut6ghgwdp/467d
         3Z0kW9QXnIksBQJsBfIkOh05l8Bv+FocfBmGOXHsbVoS2CXWJx1GW31R52ED6wT86jDB
         pJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802108; x=1690394108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQQSDBr5oatmPC3jRYA52hLZn7olUfljW9YDHvW1zAM=;
        b=i5RDYTnxiW1eIm2t6AdWgitBHdxtvVGSsxcbDsCUJL0iV70hk87iUGx6D0iYmk2Dj1
         5tbUNJqw8naSt5j/U0WDF+AScyZEYMDMvtm3zKY2yaXE0FJaBO0OVGui/21csZXfDgl4
         IsONwHkwJxcJiISH8PYrnz2vQunpu3Q9dvhdU66IsWWMNAC8zbLqGzPM3GC0KMvuLGib
         Np/YYn5sP6m9uku4HfJ6kcwuKLp+xdHLCBgmBgYLTvZVe0XHeGBBcwyvSJ21A9iOOdEp
         ypt5fcM8WgVAkeqJbIjaakaVmm94O6ZGu7BBSfHRcFDw6oJiEbGpchUKY+f0VcZ+N1Ek
         K4FQ==
X-Gm-Message-State: AC+VfDx5O84sK4UKCPlTpWxQVRDiDPgTgr24hoJ3sc+qpRosKnTJHjhY
        VzKg/GyYglrE+Yot8YsfPMrXtQ==
X-Google-Smtp-Source: ACHHUZ56YKQ0psWle33+Ep3NAFri1ZgeDSD/fhC7v/Y4sIg81RSp2vNIPzt8E+8LzDLkd08G0/E0OQ==
X-Received: by 2002:a05:6a20:7da4:b0:11f:3f4b:9687 with SMTP id v36-20020a056a207da400b0011f3f4b9687mr33878996pzj.56.1687802107970;
        Mon, 26 Jun 2023 10:55:07 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id w16-20020a634750000000b00530621e5ee4sm4459318pgk.9.2023.06.26.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:55:07 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:55:03 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "bgardon@google.com" <bgardon@google.com>
Subject: Re: [PATCH 4/6] KVM: Documentation: Add the missing
 tdp_mmu_root_count into kvm_mmu_page
Message-ID: <ZJnQ9w5deFHhElu9@google.com>
References: <20230618000856.1714902-1-mizhang@google.com>
 <20230618000856.1714902-5-mizhang@google.com>
 <1af0f4de320fd5ba96d63b7f0bdbbb061a7466f2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1af0f4de320fd5ba96d63b7f0bdbbb061a7466f2.camel@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, Huang, Kai wrote:
> On Sun, 2023-06-18 at 00:08 +0000, Mingwei Zhang wrote:
> > Add tdp_mmu_root_count into kvm_mmu_page description. tdp_mmu_root_count is
> > an atomic counter used only in TDP MMU. Its usage and meaning is slightly
> > different with root_counter in shadow MMU. Update the doc.
> > 
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  Documentation/virt/kvm/x86/mmu.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
> > index 36bfe0fe02bb..3dce2426ad6d 100644
> > --- a/Documentation/virt/kvm/x86/mmu.rst
> > +++ b/Documentation/virt/kvm/x86/mmu.rst
> > @@ -230,6 +230,12 @@ Shadow pages contain the following information:
> >      A counter keeping track of how many hardware registers (guest cr3 or
> >      pdptrs) are now pointing at the page.  While this counter is nonzero, the
> >      page cannot be destroyed.  See role.invalid.
> > +  tdp_mmu_root_count:
> > +    An atomic reference counter in TDP MMU that allows for parallel
> 					     ^
> Please explicitly say "TDP MMU root page" ?
>
> > +    accesses.  Accessing the page requires lifting the counter value. The
> > +    initial value is set as 2 indicating one reference from vCPU and one
> 			    ^
> 			    to ?
> 
> > +    from TDP MMU itself.�
> > 
> 
> 
> > While this counter is nonzero, the page cannot be
> > +    destroyed.�
> > 
> 
> I guess this sentence is implied by "reference counter" mentioned in the first
> sentence.
> 

Will make the changes in next version.

-Mingwei
