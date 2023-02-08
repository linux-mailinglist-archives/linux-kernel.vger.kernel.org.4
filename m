Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5010B68E591
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBHBsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBHBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:48:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABC4EFF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:48:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso695857pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 17:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaWmVwukI1ayQ/CHcE8yufMV7Id8NI5E9IHNugGw6TE=;
        b=boeq3f5yUhZov8hpw0E8yN/K7WkvFei34Oba03Q9i/pDEyKo/o9qITtDfoz6R3zeaJ
         ahHw9iSTuVAv4aLCpbOh0vwFO+EjpQFl0YItr/XLLGRgkG/KCxY8r1YUh7uBxHEOfeah
         8ag37wVrZoYsR+NuW3nA1zhNzJk/DhSzY4cUbqrCb2QBctLywku/lFYg2VeltvUNCRpQ
         3beMQDNfG6D8KFB2YqvhlBeNLcBAKFS30vJbQ1s+7Lvup0W4X8jj1PpD5kYpqm5p0d2/
         ln/QL9FqT0BTtryO06E7L9qnaf7eWqu09qY4lfdjTUpHv1js/g6XoRAnoEpXEiZTuMmk
         ZB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaWmVwukI1ayQ/CHcE8yufMV7Id8NI5E9IHNugGw6TE=;
        b=Kgq1z4pM/p5RtcCf7XAtBmwAufvoDHKKJ9UycyVLi5RWwA2102dYa7YCzoQgq1N9dn
         Ov/pTmHz1UT4HBC4uOy3y4OYWA+99uQyPHm6SHD0/Ie0U3h1BncD9LAGId/86lTG/q12
         YS3Qbk09H++cgro88/clXt0fBUT4HsOC4vAQFEGy8fQD5bYvYa5QvBht6TxrIjk2Qs88
         zvqd2cVcaA5Ty8QxTm4OcbLRedfkFnEWGDqbJpTFPbx+3cIkSHph73mMIjyb+/oBivhX
         HUDjNQL3j+ZooUaI1FE/ebVGWPwZenHJQgw87LbSL+o89UhsmdWKPftX0ZKOYSpjxvgf
         SYCQ==
X-Gm-Message-State: AO0yUKWd08HCGptLwbaH/XSakm4QjDIb5FVuTEzBPCgh3OJOHzJLh6CJ
        EYjPRzD07QeoPYRnUudfVpzAdA==
X-Google-Smtp-Source: AK7set/pP1FRr7jt6j9nqI06yKqTZM/V7+D23d9yLYh6Y7Vn/ookEMRRIWeJyV2n1HV21mzVW2fJhQ==
X-Received: by 2002:a17:902:c20d:b0:198:af50:e4e0 with SMTP id 13-20020a170902c20d00b00198af50e4e0mr115157pll.6.1675820921284;
        Tue, 07 Feb 2023 17:48:41 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001992fc0a8eesm2105493plb.174.2023.02.07.17.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:48:40 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:48:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH 4/4] KVM: selftests: x86: Repeat the checking of xheader
 when IA32_XFD[18] is set in amx_test
Message-ID: <Y+L/deE3+Uywm4kE@google.com>
References: <20230110185823.1856951-1-mizhang@google.com>
 <20230110185823.1856951-5-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110185823.1856951-5-mizhang@google.com>
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

On Tue, Jan 10, 2023, Mingwei Zhang wrote:
> Repeat the checking of AMX component in xheader after xsavec when

s/xsavec/XSAVEC.  Not sure about xheader, though it seems like that should be
capitalized too.

> IA32_XFD[18] is set. This check calibrates the functionality scope of

s/18/XTILEDATA

> IA32_XFD: it does not intercept the XSAVE state management.

I didn't follow this.  Is this basically saying "Verify XTILEDATA is saved by
XSAVEC even when disabled via IA32_XFD"?

> Regardless of the values in IA32_XFD, AMX component state will still be
> managed by XSAVE* and XRSTOR* as long as XCR[18:17] are set.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/amx_test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index 18203e399e9d..9a80a59b64e6 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -235,6 +235,16 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
>  
>  	/* xfd=0x40000, disable amx tiledata */
>  	wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILEDATA);
> +
> +	/*
> +	 * Bit 18 is cleared in XSTATE_BV but set in XCOMP_BV, this property

s/Bit 18/XTILEDATA

> +	 * remains the same even when IA32_XFD disables amx tiledata.

I would phrase this as "even when AMX tile data is disabled via IA32_XFD".
Software disables AMX, IA32_XFD is the mechanic by which that is done.

> +	 */
> +	set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
> +	__xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
> +	GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
> +	GUEST_ASSERT((get_xcompbv(xsave_data) & XFEATURE_MASK_XTILEDATA) == XFEATURE_MASK_XTILEDATA);

Same feedback about using !(...) and unnecessary "== x".

> +
>  	GUEST_SYNC(6);
>  	GUEST_ASSERT(rdmsr(MSR_IA32_XFD) == XFEATURE_MASK_XTILEDATA);
>  	set_tilecfg(amx_cfg);
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
