Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4EA66E4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAQRUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjAQRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:19:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E964B1B7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:19:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso189279pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4+uVVLZLx9S3b5j+KW2LdAGdGkzXPxcqIXMG9Qphu4=;
        b=Zmn3vSdzFkudY+uxAJeib6OqefKZoI53M+UVhVxk2WqR2FoAQbJhzqbFjoyLB3qXB9
         lHMKsdUruoW6hzOcRIWmshuAOb9h8Y/4UBcZi1pttXgzlfscvTA9tjaah3KbnJGxxBLJ
         /3QDrtBjDmHfkOVpCl977w9bfXT5XyLiEzbDZ+kWPBRK6u1r9MNoJDdnMj7oT3XfBFtu
         dAdo+4aGgprK/zoYlyKrdcETQJ8ra6JbFEkwq7ciUPFGyAlZz6/v1YCzxsrjFeXPedhJ
         /6Dvo50B3sKEMIz7aE9c049Ta9U81C+hcjVUYchXseAfDiIxshTY43AbOe19k47/xzyT
         QDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4+uVVLZLx9S3b5j+KW2LdAGdGkzXPxcqIXMG9Qphu4=;
        b=V6v3bj0lIJ7hJa8L6o6p4ArSm5NfHMR8l5KlTT1f3X+1oHaQcf5u1K99NVaextO8tH
         nj4cZBSQTu5Zj7oMYN+IVxDlzfUdQRVK4LAHs1SbQD2CkvCSpB4TFOiY4Saf3zuGBDw+
         ATAM0LVCLlMzzM3kHw3v/04IvUQDPboAWhK7qdPiB669n2p5+zjNskaadjTJOC6rOX9y
         kx8J7jZ/ekWoB4E2eWS8yMcCE+NQErQ2kObGjCX/ZRcwnZZoR9hGeR5mbgLCWDqDoTSY
         +LUJu3GnClFp/a+vd9Wiio/02mzc3kDiypvAn+VLj+7aBHEVRBWRiV0dYPYUSKLuQ9gk
         qVLw==
X-Gm-Message-State: AFqh2krectvA6gusWbrHVJBOb6pwNJVVIpFN/HKyO+w9Xbf90xq+PwCW
        Bnpjp8HFMtmlVQwQcdjPKicNGw==
X-Google-Smtp-Source: AMrXdXuNA5Xq8t9IxmI5BkWk1YUjI2YY7hE8dkqUdf57/E+MmKpR4ttvP/Oqs+rhiKGbfUTmqtB5lQ==
X-Received: by 2002:a05:6a20:93a4:b0:b8:e33c:f160 with SMTP id x36-20020a056a2093a400b000b8e33cf160mr89085pzh.0.1673975947148;
        Tue, 17 Jan 2023 09:19:07 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001943d58268csm15120181plb.55.2023.01.17.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:19:06 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:19:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, ashish.kalra@amd.com,
        harald@profian.com
Subject: Re: [PATCH RFC v7 07/64] KVM: SEV: Handle KVM_HC_MAP_GPA_RANGE
 hypercall
Message-ID: <Y8bYhpITRA+RZzWK@google.com>
References: <20221214194056.161492-1-michael.roth@amd.com>
 <20221214194056.161492-8-michael.roth@amd.com>
 <Y8GAGB73ZKElDYPI@zn.tnic>
 <Y8GEGnmD90bySl8C@google.com>
 <460524f8-e52b-e195-3bd2-27e41f367f5d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460524f8-e52b-e195-3bd2-27e41f367f5d@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023, Nikunj A. Dadhania wrote:
> On 13/01/23 21:47, Sean Christopherson wrote:
> > It's perfectly legal for userspace to create the private memslot in response
> > to a guest request.
> 
> Sean, did not understand this part, how could a memslot be created on a guest request?

KVM_HC_MAP_GPA_RANGE gets routed to host userspace, at that point userspace can
take any action it wants to satisfy the guest request.  E.g. a userspace+guest
setup could define memory as shared by default, and only create KVM_MEM_PRIVATE
memslots for memory that the guest explicitly requests to be mapped private.

I don't anticipate any real world use cases actually doing something like that,
but I also don't see any value in going out of our way to disallow it.  Normally
I like to be conservative when it comes to KVM's uAPI, e.g. allow the minimum
needed to support known use cases, but restricting KVM_HC_MAP_GPA_RANGE doesn't
actually achieve anything and just makes things more complex for KVM.  E.g. the
behavior is non-deterministic from KVM's perspective if a userspace memslots update
is in-progress.
