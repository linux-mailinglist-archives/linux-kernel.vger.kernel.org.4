Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F018703F90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbjEOVXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244201AbjEOVXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:23:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3D93
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:22:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64ab2a37812so780742b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684185778; x=1686777778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edoFxMkzkTHjczmI5zNedlq85EnkH2n3qvV1JIwmzOU=;
        b=GqlArdSYTkJRjSdUIq4SIFn7jPZla6c3RqlzcRARbw2GtuhhOcBxGjE71i245nEg2T
         zDUX+x5e7+px+cdJeAfOG4d2669o4akvGh7ambb4RG5KZidhaFn1qSg0TwPHejUzwEc8
         85WXkLaFf0+B94KMqX+QMxdbwBhVTNJzRRBFgvCka/UZlQy+d9jbhlD1Rt0s+qLNXybU
         +DpEdIlNvlM8mCm+ReWksRto7qCZJtObKe0ghLX4ZioZ95PX7THr7QJBIzP0mlzJyyDv
         KeQBaDTvNQ8bXBF8NPDIUMze5BnTz3/IzEJWvpd9Ozl2oMS7HhjJKosythbPKW2NZ1oQ
         mc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684185778; x=1686777778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edoFxMkzkTHjczmI5zNedlq85EnkH2n3qvV1JIwmzOU=;
        b=DkQfemKqZMmrAGB0na21u4tQ0VPMQADLpIDRl0aUdppH1RHDSaR/dGloZASKnhS0Lx
         uSEWYs3RiD3RYKefZbnFdraXGoGVQUdl1/d90sEWqc02hA8N9sqYd0G9cSeIPJcwrWt8
         YGwlFzQ6ogYy0RwNM0y47+HP3XL/lL6vsCPp4r7UpKt6Pd92UZE0Ha/jxQOEhFYjt7/I
         Eergr1FJQkRBhrkjt42Fu/Zk0ll2c2wxf9l6/aGDp6X8+AbW3bAsTn6eQoqUjlXWyqE5
         RubDKZ6RtM5+RaINr737grq53h3xZSRICjPlwx1tMLDO96S7JT4o4Xj0aPtm/ViKz1W8
         ZViQ==
X-Gm-Message-State: AC+VfDydyUgwcvwNFGooMP/nTWoqbA3AkD7/ZJWNeK8lGwq1kH+XdIpg
        PQSnBay+kTIPVoI9bnn/m/+PjA==
X-Google-Smtp-Source: ACHHUZ6mhhW+Ens3aStAidnoqGkyRqeTc3ZNQbJdm9enmSNkFNdh/lZd7E/A706Vqbkb1RmVDLTQlg==
X-Received: by 2002:a05:6a00:14ca:b0:635:7fb2:2ab4 with SMTP id w10-20020a056a0014ca00b006357fb22ab4mr40348439pfu.6.1684185778309;
        Mon, 15 May 2023 14:22:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78714000000b0062dbafced27sm10275996pfo.27.2023.05.15.14.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:22:57 -0700 (PDT)
Date:   Mon, 15 May 2023 14:22:55 -0700
From:   Deepak Gupta <debug@rivosinc.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
Message-ID: <20230515212255.GA562920@debug.ba.rivosinc.com>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
 <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <ad5b44e17c1c17ebdc581169fec7e80f7ef2a4d4.camel@intel.com>
 <CAHk-=wiZjSu7c9sFYZb3q04108stgHff2wfbokGCCgW7riz+8Q@mail.gmail.com>
 <bd7c4f53cd27224308bff305513978dced1495ad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bd7c4f53cd27224308bff305513978dced1495ad.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 04:24:24PM +0000, Edgecombe, Rick P wrote:
>
>BTW, I forgot to mention that there is another architecture (maybe 2)
>that is expected to use this refactor for implementing their shadow
>stacks. So FWIW, this churn is not just for x86.
>

That's right, one of them is RISC-V.

RISC-V control-flow integrity: https://github.com/riscv/riscv-cfi

Since RISC-V PTE have 3 separate bits for read, write and execute. Write
only (R=0, W=1, X=0) encodings had been reserved and thus cpu supporting
this extension will treat this reserved encoding as shadow stack.

It doesn't get messy as in case of x86 (due to overloading of dirty bit),
but it still will need pte helper which marks a page "shadow stack
writeable" or "regular writeable" depending on vma.

I plan to use this re-factor for RISC-V shadow stack as well.

RISC-V CFI RFC
https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
Note: This is still a WIP. As spec gets into stable state, I'll post a v2.

On my patch pte helper discusion and suggestion to converge with x86 on
pte_mkwrite 
https://lore.kernel.org/lkml/7693247c-a55d-a375-3621-1b07115a9d99@redhat.com/

-Deepak
