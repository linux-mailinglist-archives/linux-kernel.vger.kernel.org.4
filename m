Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC15F70DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiJFWCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJFWCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:02:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ADE1142F6;
        Thu,  6 Oct 2022 15:02:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x59so4691887ede.7;
        Thu, 06 Oct 2022 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=q8/n3EMD5cnLWaIZS6weR3Cz4dVlkLr18gotr5nuyIY=;
        b=mknW/K5+nRpvbAoFF+wPkCGRLTnkZ0J3ANaHD1k5R22m0oZibnQnQx7/i2xA/1XT1C
         fBBP2byMcKnVhmSCOor92+msIN4pM5H8cOomwRbDGepoFD4CRfkHQMrpcSZnG8EkBEm0
         HEquvnmTrxpk7WKulUq8u4eCqy8y0dP+TmtvaGdmD/Gy4S6QEiSMkOgI8rm6WQisy98o
         rrb9jODo3atjPu0qeVpDv9PCBb7OPukqK5pNWKkVJajZGziWjt3v3v76VnfeLGnyLrwE
         +i3PldKubNKlcHYBfgOOqSsdzjALWRZF/YoKL6P0zAKm4xn0/BS6MOYFZwEc+p3pZXow
         PzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q8/n3EMD5cnLWaIZS6weR3Cz4dVlkLr18gotr5nuyIY=;
        b=qDzuEM9KGGb8dFEL7tYcTSmr/R7MlVDvJXGWI/NPsEEARcsBUcJS/fDILQzcZUq3d6
         ls1A2oXvZdftJ1w96DV4y2WUNRdZwkPuq0hMrP/JpCe4D122K8bLr47JSZYPrDK+zcsl
         qTEiVH8ubQaiCSfVV4r6fMCxXTvY69Jh9BDabHD6mHG19/SBD8jDic018UiJZaKXjiIk
         /Y+SFq/8fG2ojLoxpNZ9DU5TLL0EEZM26Q2ocQRZ3ehp/J52eV5YaYYRi3kKys4VCRpd
         AZ70IUSgzlFWQzsEKxXxhz0QP77pjcQcZEHUbIZsuYdxCKV4GjL01APiOgxMe/sFWDhz
         wJ1A==
X-Gm-Message-State: ACrzQf3t7xb3duEa2fRo66ARA5m+tezbYOiu8wMg2c34BKYBcIsU3kz1
        8bAoN9Z811pUn2RBHml6YvrPrFmQ5mKLFA==
X-Google-Smtp-Source: AMsMyM7Q80bsglq+Gt8IWNpz7Vpm1iZAP5p3wYEdito9JSxFIfIdZamXJNSBP6POTkAtu3xuMaY2dA==
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id ev6-20020a056402540600b004521560f9d4mr1790233edb.333.1665093762599;
        Thu, 06 Oct 2022 15:02:42 -0700 (PDT)
Received: from mypc.localnet (host-79-17-38-224.retail.telecomitalia.it. [79.17.38.224])
        by smtp.gmail.com with ESMTPSA id ti5-20020a170907c20500b0078bfff89de4sm269924ejc.58.2022.10.06.15.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:02:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, ira.weiny@intel.com
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Date:   Fri, 07 Oct 2022 00:02:42 +0200
Message-ID: <8124835.T7Z3S40VBb@mypc>
In-Reply-To: <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
References: <20220929160647.362798-1-kristen@linux.intel.com> <3694452.kQq0lBPeGt@mypc> <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 6, 2022 10:45:56 PM CEST Dave Hansen wrote:
> On 10/6/22 13:37, Fabio M. De Francesco wrote:
> > kmap() were not suited in those cases because it might sleep. If the 
intents 
> > of the author are simply map a page while in atomic, so to avoid sleeping 
in 
> > atomic bugs, your conversions looks good. 
> > 
> > For the reasons above, can you please say something more about why this 
code 
> > needed a kmap_atomic() instead of calling kmap()?
> 
> This question is backwards.  kmap_atomic() is the default that folks
> use.

Sorry, I can't understand why kmap_atomic() is the default. What advantage we 
get from disabling pagefaults and probably also preemption (it depends on !
PREEMPT_RT also when we don't need that the kernel runs in atomic?

Do you mean that the more code run in atomic, the less pagefaults we allow, 
the less preemption we allow, and so on, the better we get from Linux?

Do you remember that what I say above happens both on 64 bits systems as well 
as in 32 bits?

I'm a newcomer so I may be wrong, however I think that in 64 bits systems we 
gain from simply returning page_address() and from finer granularity
 (less atomic, less critical sections, instead more preemption and / or 
migration).

Why shouldn't be kmap() the default choice in a preemptible kernel if sections 
don't need that disabling of pagefaults, along with preemption (which get 
disabled many more times that only migration)?

Am I still missing anything fundamental?

> You use kmap_atomic() *always* unless you _need_ to sleep or one
> of the other kmap()-only things.

What would happen if you rely on switching in atomic as a side effect of 
kmap_atomic() and then you convert to kmap_local_page() without explicitly 
disabling, for example, preemption since who converts don't care to know if 
the code is in atomic before calling kmap_atomic() before or after the call 
(as I said there may be cases where non atomic execution must disable 
preemption for some reasons only between the mapping and the unmapping?

If I were a maintainer I wouldn't trust changes that let me think that the 
developer can't tell if we need to disable something while converting to 
kmap_local_page().

I hope this time I've been to convey more clearly my thoughts. I'm sorry for 
my scarce knowledge of English.

Thanks,

Fabio

> 
> Folks don't and shouldn't have to explain why this was using kmap_atomic().
> 




