Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15DC5ECC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiI0TEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiI0TEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:04:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B20BF5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:04:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sd10so22725533ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YYEkPOqjhpHK7QuNDpSW1icWON78rkdfyhJquQM2y/8=;
        b=QniEgUxIIPob4hj9DF+Bak9AW/dqhl5JHkElLy1fTLgY2RtrTfpRKzaLpbyDrXL5SO
         Q4lOBBso7RjfBXJ2wb/ucp36el00jgR9IPf2LCIcnX3EvKvABRDyNIWhq77qvtTzHbb9
         uTLlXiFNTuvDGWDgImHjH42QztNpzR+ruaVCFSlz57Phv53Ee23cNPLzX9gs78SGkhVf
         LO66Tjc0a+ijD0wKa/PLVL57A6bgXSJUugjS/o/E2wI/o3nsWmkGCrb26QOqDQiKOj+2
         5w8Ja1ueyA08qDyy5HizUBD46M/TNY3SCoFcm2XGW4H2JJg+331cVKZrPlWrwnwyHYKm
         gdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YYEkPOqjhpHK7QuNDpSW1icWON78rkdfyhJquQM2y/8=;
        b=nUXuYHspFpi4YxkxT6AjYJMs4OTmnY58meqZQdcvL59FEwmrMkPNoV0RMZprx5P4d3
         2U2934daR8PIi7aXBUfC2///PG2V+qj77cyB9WHCAWOE02W86vaji2bah3OQrlOUg8AX
         H6yLzGNAjYEjh4HsSL9g/ycpQ/PB8wHaa9tORaiHRAv1Oha0J/aPR2wkI8F3yZUIUGdy
         SJrhGE6hTlJ5N93+CykgcwKWh8dGBjS0V9C2bNFxyIz67kJ9wrdCljteX+r0e5wCiJjT
         5SBIFFg8N63V83rF8IObfl7iXZrXsPBB+uC85mkOGGq3DS1spDWs6/lS6gHDjpeq/XR9
         npNw==
X-Gm-Message-State: ACrzQf1A7hGlCzSLhVlr433OntsrgXeRt6VDFtdvxcJZllDkbsrcO4oB
        v+lKm8XvZEeXQExO9CUacOFAFqAAtZ889sUksnGpwA==
X-Google-Smtp-Source: AMsMyM5UPT1wQQOK8mZlarkl31jHeZEVxDZ4ltAZeCzBRqHmXrcTEPip6RSsl+qk4gefnnF0cgiuwc/UlVcPfO/39ls=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr23781325ejc.719.1664305482137; Tue, 27
 Sep 2022 12:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1664298261.git.thomas.lendacky@amd.com> <afd222473c7b18ea942e754a6c4df26ed74eedee.1664298261.git.thomas.lendacky@amd.com>
In-Reply-To: <afd222473c7b18ea942e754a6c4df26ed74eedee.1664298261.git.thomas.lendacky@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 27 Sep 2022 12:04:30 -0700
Message-ID: <CAAH4kHZZ+3Q3-k_OQ+y7zkVnNffCpgP-Kd5Pp24epn0LyVgDag@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] x86/sev: Fix calculation of end address based on
 number of pages
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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

>
> When calculating an end address based on an unsigned int number of pages,
> the number of pages must be cast to an unsigned long so that any value
> greater than or equal to 0x100000 does not result in zero after the shift.
>
> Fixes: 5e5ccff60a29 ("x86/sev: Add helper for validating pages in early enc attribute changes")

Tested-by: Dionna Glaze <dionnaglaze@google.com>

-- 
-Dionna Glaze, PhD (she/her)
