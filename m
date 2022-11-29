Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB263B996
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiK2FyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiK2Fx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:53:59 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8B4FFA0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:53:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y17so4505995plp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGUEPx1xzxhjCBjmyfak65lMBIhLucPqClHTEgv0v+Q=;
        b=VwfG/CQdnAymgSvzcRNNCSRZrRkblh4qro+UykiPwg0yquXUtChJ1t0+eAeOC2m54g
         9H5541QUKuRXUmcQjNkTZ86LBsxKqY+FI5vLZCgiJcsRyHJBbVrff0Szv7O37DtNbGGj
         mwXUUk+t7+jrh4nWqywyqo+LB5PoyM46jbQBybzkF4MapNsD8MOAe9Em3tnOpoFZgI9J
         9IJcGj+BgB6X+FAVduyqT6sSuX8HjoWQqK8IrJWIJ2z2U6byMvWoN2i9Z8n7o0yP2ubh
         5dcD3Ds0vboDBrp8VM9rJ1r0HJOplIzSrPIhRQ+WPXnoRWs1T9wthISuCoBICaugiIlO
         O1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGUEPx1xzxhjCBjmyfak65lMBIhLucPqClHTEgv0v+Q=;
        b=ylguh1X5c4IdDEwujFJnGs0hf2/rlhWBNQiM0W2Zk3AQSfic2QB73tvq8QFQ+EtyJG
         9UFBQgC2c7ljW1p9YmIrsvnkJIq8hcNe0IUkoRai9VNkAwcNvLGQHjYULtMlxf6cW55E
         ngF8bcreeTxzFqGSbZgt0sB2zg60XVCSQRcOUOqH2eSV2jstsqLvBZn/pQuoTZKXVYep
         a2UWteRNz5NyI/kjUa5r0zt3WBfRuxp3sK5IsunOqw1nFJbnLzObThwbJoQBAHFEN0F6
         yBL7iV6byUp2dzqMLDtVNM0snQYRXY1Z+SdwDqMam+EDPtevwAAh8z5nBmO7LgXHPLGv
         mA1g==
X-Gm-Message-State: ANoB5pkOgLLZDXpWnD+YQ0JPYGY7FRfaOxs13aD3tuNHzNpF24OmrYGj
        qHixYtaDoaTa6XZBjNO/Jnn+
X-Google-Smtp-Source: AA0mqf4agF2oc0K3ovVJmPb81+pPhrHenKyRWvpFKt8Me3twmKftFTAZIzSSqrl0TGA3bY5+Z5p9NQ==
X-Received: by 2002:a17:90a:4745:b0:213:1442:24be with SMTP id y5-20020a17090a474500b00213144224bemr62656499pjg.15.1669701236727;
        Mon, 28 Nov 2022 21:53:56 -0800 (PST)
Received: from workstation ([117.207.29.115])
        by smtp.gmail.com with ESMTPSA id h7-20020a632107000000b0044046aec036sm7614112pgh.81.2022.11.28.21.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Nov 2022 21:53:55 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:23:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bjorn.andersson@linaro.org, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com
Subject: Re: [PATCH v4 1/2] EDAC/qcom: Get rid of hardcoded register offsets
Message-ID: <20221129055351.GA4931@workstation>
References: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
 <20221116143352.289303-2-manivannan.sadhasivam@linaro.org>
 <Y4SmtfSzLbYea+f0@zn.tnic>
 <20221128181705.GP62721@thinkpad>
 <Y4T/YlDdDk7gVdfB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4T/YlDdDk7gVdfB@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:35:14PM +0100, Borislav Petkov wrote:
> On Mon, Nov 28, 2022 at 11:47:05PM +0530, Manivannan Sadhasivam wrote:
> > Well, yes but that would imply both LLCC and EDAC patches going together.
> > Splitting them will break the build, which is worse.
> 
> Sounds like you need to check out:
> 
> Documentation/process/stable-kernel-rules.rst
> 
> first.
> 
> Hint: there are provisions in there how to specify dependencies between
> commits.
> 

Hmm, I did miss reading this. Thanks for pointing out.

> > Sorry, it is because I only tried building for ARM64 architecture. The
> > error you are seeing is for x86-64 and I could now reproduce it as
> > well.
> 
> Yes, because arch doesn't matter here - the .config does.
> 

Well, arch does matter here. LLCC driver depends on ARCH_QCOM ||
COMPILE_TEST. In the case of ARCH_QCOM, the REGMAP_MMIO is implicitly
selected and you won't see the error with built-in or as a module.

Only if you unselect ARCH_QCOM and use x86_64 (or any other arch) with
COMPILE_TEST, then you'll see the error with both built-in and module.

> Therefore, as requested:
> 
> "For the next version, you'd need to fix all possible Kconfig build
> errors before sending."
> 

Sure.

Thanks,
Mani

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
