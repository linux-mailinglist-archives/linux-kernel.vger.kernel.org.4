Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D399965B5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjABRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjABRay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:30:54 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741EBE42
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:30:52 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w203so2403155pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4s4wsz0Tk2Jz2ceTAUaJ6etP/WVSBkTpQfdDdNo8WCc=;
        b=DpPx6wfB2HnOq2BBjbvvIxqTb0V7oVXkys0a+9vVYmu6kd7dh4YkESkKpARAH9vR6A
         jHkpAqIvLr65TsVny4PE9y43+4HLxDD4NdyJ6CAH18egz90QLtrLkuwJpsAHSwRfOl0/
         q5tPr9nOADl8DFxsqzfaMdRk27+rUOoyNgjrYdwgFJfBRi9k2oTomkQFNqfKi8xxinpv
         lSfYOehB7y3IsL7R0oANqXtl7JzJHCA0OE9vMAt3D87yDEQyB0WAcAChe2AyBg5658Jr
         ccVX1PUzlcvtoRAF7sgkXLLHN4pxEcr33n2oz7iCPYbGBuSGgyEKB/6U6khBWxjSeMOf
         0krQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4s4wsz0Tk2Jz2ceTAUaJ6etP/WVSBkTpQfdDdNo8WCc=;
        b=za7/+TKR86CY3miVFJkYRCCKRDkMM+IzbHmhDpPLm8pmmsd1w4jrE9S5SOL4zWzyMa
         1xz0bIzk7R63OtHE0gP2FCC36eZoultKeT8h+R1y9cw/azd6o5cbZXC0GqN06yxgnJmZ
         2JoSYGcJFNKEWl/ZdCC+2fOagyqYVqOXbpmV0pPWm5ojP+izYUpkFkoWKFSGqGtwCIxZ
         UhSVPj+WnTkkHyYoko4ZfYWXXHVWd7gtJccqnug9I0KyfjtbtJZTHfjL3M+jRGnRjNE+
         X0uK0lEDu/Z6hBPBEZolFoN2OBw5WLZqAeNynJLcUNVsWJHRxAO72PzyBV9EHwVD4XC5
         Ezvg==
X-Gm-Message-State: AFqh2kpLr0zggpjzLa2pQaC0PUt2RZ0dqbL9fJwCBvjuAAmPaiF5SWFd
        iFM/zRzKMgpoAnFtE/1UC4Ub
X-Google-Smtp-Source: AMrXdXt5RpPjZsD7c+56DP2frozOtIwA9hlgCrBcqheqig1WsrUF9YF8gSP+pm/elGNIQSHCpk5gZQ==
X-Received: by 2002:aa7:8043:0:b0:573:487d:e852 with SMTP id y3-20020aa78043000000b00573487de852mr49354904pfm.4.1672680651935;
        Mon, 02 Jan 2023 09:30:51 -0800 (PST)
Received: from thinkpad ([220.158.159.123])
        by smtp.gmail.com with ESMTPSA id j186-20020a6255c3000000b00576259507c0sm18779367pfb.100.2023.01.02.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 09:30:50 -0800 (PST)
Date:   Mon, 2 Jan 2023 23:00:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 00/17] Qcom: LLCC/EDAC: Fix base address used for LLCC
 banks
Message-ID: <20230102173045.GB16638@thinkpad>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <Y6wcFjqpBUoxAkdk@zn.tnic>
 <20221228164711.GB256211@thinkpad>
 <Y6yDI43UZYfGDuOm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6yDI43UZYfGDuOm@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 06:55:47PM +0100, Borislav Petkov wrote:
> On Wed, Dec 28, 2022 at 10:17:11PM +0530, Manivannan Sadhasivam wrote:
> > Well, some maintainers prefer to pick the independent patches through their
> > tree. That's why I moved those patches to the start of the series.
> 
> Once some maintainers experience a crazy dependency hell between trees,
> they would find routing it all through a single tree a lot easier the
> next time.
> 
> > If you are fine with all patches going through qcom tree, I do not
> > have any issue :)
> 
> I'm reviewing.
> 

Ok! I'll wait for your reviews on the rest of the EDAC patches before doing the
respin.

Thanks,
Mani

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
மணிவண்ணன் சதாசிவம்
