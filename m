Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57382620E37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiKHLHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiKHLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:07:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3F4C256
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:07:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j12so13860883plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/yRs+y53DAJ225f9gq7YtS+yadU9QI0BNYlnqPDhZM=;
        b=Fdy7U+Zeib9GDPNku63uXCnIrBz4DkypUsCcCh30aOQtdGK2jUOIoGolYp9bymh/0b
         tUEiG1j1BnM95r3GvtiaoUJvPhdxfqwIWzpCzasbD6njjb5BqrRv0iWcnIW0eu9BeXI9
         JcclZKwQo49yXuGNIuYkwzg8fHmUIy8h00d2oUUECfwZPKIgJ5MY6v5Ms2RSEP5u2gJD
         Pasi/KwpUYKQf2ldez+ue7TYnYIqe2AOsN6iak9BIPTOXZVcuzKgk5Hr6hoBUGNguQZ3
         J/nBisQGtDI+Dok3nG5xhwU3qb8bX6gjAfZ/a1E94uXpwXHdLVHL+G+vGVdh2mkNBGGg
         dcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/yRs+y53DAJ225f9gq7YtS+yadU9QI0BNYlnqPDhZM=;
        b=CwSVEPcTPdz1dIYj2NLJMABaYTM2/J2bRv/SumIw5R/wOYAWcZSGyyubVN2FBEdGK3
         gcJhaqRzEDLKSkp9RkhcXgpsB8RbNTojHRAB+QO081OVFCqtggSFskmGUazhnt2MYKR6
         xDwVpG8kXWv4u1gI9Aif7UfXKDIjvEwrOu+tdx5BbfZ9AAOyOOUUOuOcZiXLVj/qYyk7
         YVGhztFviYmTpCur7d6oIhV0yaI6a10ZUVC/1ysClQj1pkHu7i9e75j73GZQCpAeMI8O
         hJHycqesbhMD//mg7lYUfcoem6lgWkePKi75crFOhRIIYO8kVANWi3H+3AX8WBgnKIYY
         JoYA==
X-Gm-Message-State: ACrzQf3VxexT6siBckZN2sefThSxvx9B9IWsB9ZzP5NcPQrLNkODSajH
        /16yJdLWhBwKUhVnENWx/zpA5jXC83FwXOFC8mtV8A==
X-Google-Smtp-Source: AMsMyM7ruYnA4wSj+YXFuThf157la9P6XriUdgbY/9J3/RZR0+A7idD6kCIl96wiczH1I9YhBbcjEvL7sV34vKRsEsI=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr75338135pjb.164.1667905629698; Tue, 08
 Nov 2022 03:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20221027115745.240516-1-ulf.hansson@linaro.org>
 <166779074268.500303.10369639779721394913.b4-ty@kernel.org> <CAMi1Hd3rE+r4vMdBy_LxQEbAKaXRYntje==eiO8cxkgSU9jXdw@mail.gmail.com>
In-Reply-To: <CAMi1Hd3rE+r4vMdBy_LxQEbAKaXRYntje==eiO8cxkgSU9jXdw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Nov 2022 12:06:33 +0100
Message-ID: <CAPDyKFpa57K4yHq9MSBF7U7mXZyyMUe1eA1fMawO450-eSB3_Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Disable the not yet supported
 cluster idle state
To:     Bjorn Andersson <andersson@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, konrad.dybcio@somainline.org,
        dmitry.baryshkov@linaro.org, sudeep.holla@arm.com,
        quic_mkshah@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 at 06:55, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Mon, 7 Nov 2022 at 08:43, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Thu, 27 Oct 2022 13:57:45 +0200, Ulf Hansson wrote:
> > > To support the deeper cluster idle state for sm8250 platforms, some
> > > additional synchronization is needed between the rpmh-rsc device and the
> > > CPU cluster PM domain. Until that is supported, let's disable the cluster
> > > idle state.
> > >
> > > This fixes a problem that has been reported for the Qcom RB5 platform (see
> > > below), but most likely other sm8250 platforms suffers from similar issues,
> > > so let's make the fix generic for sm8250.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state
> >       commit: 5c7fa5de12a31c1425cc87ba2ef27e6ae0a1788c
>
> Hi Bjorn,
>
> There seem to be some error while applying the patch "arm64: dts:
> qcom: sm8250: Disable the not yet supported cluster idle state".
> This patch is already applied in your arm64-fixes-for-6.1 tree
> (commit: cadaa773bcf161184fa428180516bae33a7bc667)
>
> The new commit: 5c7fa5de12a31c1425cc87ba2ef27e6ae0a1788c,
> however, disables the Big cpu idle state instead. I'm not sure if that
> is intentional though.

It's a mistake. There have been a lot of various patches/discussions
around this issue at LKML, not entirely easy to follow.

Anyway to make it clear, we shouldn't need to disable the
BIG_CPU_SLEEP_0 state, but only the CLUSTER_SLEEP_0.

Bjorn, can you please have a look and drop/revert commit
5c7fa5de12a31c1425cc87ba2ef27e6ae0a1788c ?

Kind regards
Uffe
