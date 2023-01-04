Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AB65CB39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjADBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjADBJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:09:41 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9213D23
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:09:40 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n4so34465394plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VT5QZhcZZeDbsiEz/fllfSXONvy51XdiSS8QokpwQg=;
        b=Q4DEfeoNUsJnujmG5WDcxlCAMaEfhBmMWAS7aUzEC2GW3ofbkRwZ22ZYFjITsxmo6K
         bb0vjmVJXZL0G/l4TGKr3KMTIDcdwQUeKoeFnx6I8MLcodY9TVH6AGEpkz9x9GWI5hwx
         k7R0UjHzbUt2Ai1wJRy2IFQHhF6DWYLx8cxQAFMWDWI6Xgrug2FARlR3RiNRVi4rCbo9
         AP/OLiZNnuV7UvZFm8qEsAphMEm93ULbKnV9d+A7rgWdhM6aiDUP6a5tWQx2bF/ggq6A
         f7JPgRzWEeYZPXHV5Lm4ZgFljKv8WtzXvID2mUUKGwqdRm31BuBbvKfhkRXpKAhdOylW
         Zj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VT5QZhcZZeDbsiEz/fllfSXONvy51XdiSS8QokpwQg=;
        b=q0uY7kEniPurMImTeNRijTGYCuPSZ53yoSh0MceBFLpVD8dG+6eCSHZbSiBCxes32f
         ZgF5pLojuCTYwJ4TJMdk3EQ+Pk8gPPhJmoj4/yADrDU26j5AUQNecDI2yN4UppeJZwi2
         aD+Y5h5S/MD6qVNjAeOHhmc37iRz7fxUnQoh+J4mlp/aMj/AxnEdmyDgr1pGdFKOWrGC
         g4KJBk3x2ZFkuLQnyvZ02GT9xEulitTXq7HqqnPBwYEsVwM7CL+KCbAD9cr5Iwbcg5/G
         RrkxuqD+H1nBrBmIljbq2LbE51YxGvZoq9rDWWICwpQbDzTIh+PZOQnoTRjI9TiqFG+2
         lKFw==
X-Gm-Message-State: AFqh2kqBa8lTFZfqHLxP3pfeqj/mEqDWTgwHJbL8XqmQUACcQjJ6NekK
        WhOvzs6DKmYa9xKhcPo8Frh23w==
X-Google-Smtp-Source: AMrXdXt4xHOajqscKlKaEpBiTyEw5HpxcS2+BmkjFSTy1AWvaTA2O2HtoOh9s0+BdQR2dE8QR1delA==
X-Received: by 2002:a17:90a:9912:b0:219:f970:5119 with SMTP id b18-20020a17090a991200b00219f9705119mr3677621pjp.1.1672794579775;
        Tue, 03 Jan 2023 17:09:39 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id dw6-20020a17090b094600b00223f495dc28sm19707506pjb.14.2023.01.03.17.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 17:09:39 -0800 (PST)
Date:   Wed, 4 Jan 2023 01:09:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH 12/14] KVM: selftests: Use wildcards to find library
 source files
Message-ID: <Y7TRz1AY95SlKOHv@google.com>
References: <20221213001653.3852042-1-seanjc@google.com>
 <20221213001653.3852042-13-seanjc@google.com>
 <363f4713-6105-82d1-351e-423d07470cdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363f4713-6105-82d1-351e-423d07470cdf@redhat.com>
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

On Sat, Dec 24, 2022, Paolo Bonzini wrote:
> On 12/13/22 01:16, Sean Christopherson wrote:
> > Use $(wildcard ...) to find the library source files instead of manually
> > defining the inputs, which is a maintenance burden and error prone.
> 
> No, please don't.  This leads to weird errors, for example when "git
> checkout" is interrupted with ^C.

Well, don't do that ;-)

Are there concerns beyond having an incomplete and/or modified git working tree?
E.g. could we do something crazy like fail the build by default if the working
tree isn't pristine?  The library files aren't terrible, but the number of tests
is getting unwieldy, to say the least.
