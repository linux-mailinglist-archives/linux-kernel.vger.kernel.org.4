Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8B6B25E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCINw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCINwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:52:38 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843BEE2530
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:51:56 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 82so1951125ybn.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678369915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/6DLXCP5EOnjgGslNZNHpBotZDvx87R0Bpss3uddxqc=;
        b=RtlpuCP8t5GzSyvwBwNv8MTO6pmA+7diVgliZyk9iRCXAbWi7K+5UWL+j7GUx/SN7K
         4LmAyYhbzL9HHCMPb2stMKUDmY+AoAu0bSKhNmFN55asal08z5jkG4fNP3Epv/6AnOCc
         rtoIG+C1gv6BByERKlbfA9+ovGG2/dkVO5cJIl0bjQE5SlRuuMITYnb7E4k43r2+i0Lu
         Expaod2TS1lp0W5X2SKFd/+Vraag5FNCME0EHQHeU3s08XQfQni4qcEj1cFRxDp/6QHm
         CBQoDwrLF6wfrANbJSR3Z6pgeOUkcT7s/e2AAGovpr01dCyZpZ7dYkoNZOvbna0ErKcg
         x27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6DLXCP5EOnjgGslNZNHpBotZDvx87R0Bpss3uddxqc=;
        b=El8pZnhYf2YVjxwjRRkRHldBZVb45ffyRvJgJ/6FQTjMBnCuHV2hiLT2IujGH4crp8
         6vEik+G7mjxahTfi22cnUBKHrLZ3GTMH/IT1aw1EiniCBo3s7I1tbEmwru3PwOJgJjoP
         HnXbNp4IrrTs4CvVMhHwRhMrFgjwom7Wj4tjqAnSBDKjUWLFo3yc68FgBdZ5+UvwBGPI
         59rYGO8JMGT8F6fwgEanajPEzmGmU3cSp6zCbloC5mVlBcYUM5SIs0B62Jy/UO82ILRe
         BqXdkzJHo+YDCgJUx6CnaLWfFkrt4LFobIAnCXr+jW1dJdxjOOluNuvgtAauv4ijvWRl
         Vb8g==
X-Gm-Message-State: AO0yUKWDMTcvkGzI9Clp4dWctGbHzYM76K0MVzb9XfX6rgiEQutmbTIq
        O/zGWj+FcMarwDN30HY76yO7/7+3gSgyAvUaEnm0Kw==
X-Google-Smtp-Source: AK7set8E/oC6iGwGpPENJssFiL5/gKHrcKSrRBvGDe2vUMmjFwPkNfct6y+xvvPeBLDc0v5+U/bTupsB2sHqIj6bkUc=
X-Received: by 2002:a5b:1cb:0:b0:a6b:bc64:a0af with SMTP id
 f11-20020a5b01cb000000b00a6bbc64a0afmr13389765ybp.4.1678369915742; Thu, 09
 Mar 2023 05:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20230306144641.21955-1-quic_mdalam@quicinc.com>
In-Reply-To: <20230306144641.21955-1-quic_mdalam@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 14:51:44 +0100
Message-ID: <CACRpkdZLHOMSFyTKxwi=VWhtjnwy03DvDT+A2EZ=i3XsFpqQJQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: qcom: Use devm_platform_get_and_ioremap_resource()
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_sjaganat@quicinc.com,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:46 PM Md Sadre Alam <quic_mdalam@quicinc.com> wrote:

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

This patch (nr 4) applied to the pinctrl tree as obviously correct.
I guess it is independent from the other patches since I was only CC:ed
on this one.

Yours,
Linus Walleij
