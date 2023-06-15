Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32422732273
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjFOWIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbjFOWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:08:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6762D1732
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:08:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-982acf0a4d2so141516066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686866882; x=1689458882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOz3L+kRjBytpnnLqGgO6dyDcaayWisUVnxeMxbtNDg=;
        b=Vqi4LSPcG6dDCd5sMBVwnjdoxJfb7BO1Rc5MHNoFq44yux3eFngoTaOMoKA53SNAzt
         UzBGQva5HVYQcrUZOhp71c3i3hIaMe518lE4+1C6QZ3OQw2xX2710hwebohTmdN7zjXG
         dF5RHkmJwSk73lfMJCDgFDTh/YDMTCxvs+qaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866882; x=1689458882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOz3L+kRjBytpnnLqGgO6dyDcaayWisUVnxeMxbtNDg=;
        b=EzGc1Wa3QtnLr1qx1Cghk/MP8Cc5cNjfjYbThs90DewWpCfukimgzkA7Y0jZ6rgQJY
         uje+jgNSRgyeJGyFDLagGIP8ndrVE1S0Pl3J1z32ilMhLwB72hKc9mm8nRmA/yVmfLti
         Tb2Ec5wBGl8WDLZ8TzE9CONsMVNSYBpmv25BhuDsEAcjcoeivA2wDkYWEqIOvBnCpmGY
         xMIbiOcs7wztU2a+/RirIngGz3k/Xgf7UM7GJW+ISnCfRLi0u3LFPo+CMPpPdDMumQOK
         IDP1o2C7lnoJs3txE1XgWaGyKbPBoAZqNtO4wEDC8NjgLBMwp6EsQ0Bk8N+LKlRZObcl
         Rlsg==
X-Gm-Message-State: AC+VfDznGvRxLidWAsnEYgbzlDJVhIyWD7yn9m3y7NCsqThdW/tRcbdR
        uGzNeh5KFEKGciACO31FpIEJpNU7M+h6FfnMG837fwQw
X-Google-Smtp-Source: ACHHUZ6h79+zqEjJxCOrfYzVQJ9WvU0hCyxWByhRPJsk7ndV0BlNuZ7m3yQLM3REFJeMVVw55iLKhw==
X-Received: by 2002:a17:907:a41e:b0:982:b5d0:ca7b with SMTP id sg30-20020a170907a41e00b00982b5d0ca7bmr226264ejc.67.1686866882478;
        Thu, 15 Jun 2023 15:08:02 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090612cd00b0096f7cf96525sm9961724ejb.146.2023.06.15.15.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 15:08:02 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so40965e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:08:02 -0700 (PDT)
X-Received: by 2002:a05:600c:880b:b0:3f7:ba55:d038 with SMTP id
 gy11-20020a05600c880b00b003f7ba55d038mr266133wmb.6.1686866424119; Thu, 15 Jun
 2023 15:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid>
 <36565295-ebaa-2a66-3389-ba5eb714ab34@arm.com> <CAD=FV=W7HXYRJ7RUeVH0hQ7KjYtEvNABCi-F4iN_wRO6uuC34w@mail.gmail.com>
 <34c7c65f-e09f-fa55-c1b9-de08d71a1ac7@arm.com>
In-Reply-To: <34c7c65f-e09f-fa55-c1b9-de08d71a1ac7@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 15 Jun 2023 15:00:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEx+71U5-WWL6c8vwqUg0Asceoz1aCd3YBub9-FcL61g@mail.gmail.com>
Message-ID: <CAD=FV=UEx+71U5-WWL6c8vwqUg0Asceoz1aCd3YBub9-FcL61g@mail.gmail.com>
Subject: Re: [PATCH] Revert "Revert "Revert "arm64: dma: Drop cache
 invalidation from arch_dma_prep_coherent()"""
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, andersson@kernel.org,
        amit.pundir@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sumit.semwal@linaro.org, Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 15, 2023 at 12:04=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> > Presumably the fact that the firmware gets a physical address means
> > that the firmware needs to map this address somehow itself. I can try
> > to dig up what the firmware is doing if needed (what attributes it
> > uses to map), but I guess the hope is that it shouldn't matter.
>
> It absolutely matters. Linux has been told (by DT) that this device does
> not snoop caches, and therefore is acting on that information by using
> the non-cacheable remap. There is nothing inherently wrong with that,
> even when the "device" is actually firmware running on the same CPU -
> EL3 could well run with the MMU off, or just make a point of not
> accessing Non-Secure memory with cacheable attributes to avoid
> side-channels. However if in this case the SCM firmware *is* using
> cacheable attributes, as the symptoms would suggest, then either the
> firmware or the DT is wrong, and there is nothing Linux can do to
> completely fix that.

With help from minecrell on IRC, we've found that firmare _does_ map
it as cachable.


> > If this wild guessing is
> > correct, maybe a more correct solution would be to simply unmap the
> > memory from the kernel before passing the physical address to the
> > firmware, if that's possible...
>
> Having now looked at the SCM driver, TBH it doesn't make an awful lot of
> sense for it to be using dma_alloc_coherent() there anyway - it's not
> using it as a coherent buffer, it's doing a one-off unidirectional
> transfer of a relatively small amount of data in a manner which seems to
> be exactly the usage model for the streaming DMA API. And I think using
> the latter would happen to mitigate this problem too - with streaming
> DMA you'd put the dma_map_page() call *after* all the buffer data has
> been written, right before the SMC call, so even with a coherency
> mismatch there would essentially be no opportunity for the caches to get
> out of sync.

Switching to the streaming API for this function _does_ work, but for
now I'm not going to make this switch and instead going to go with the
fix to add "dma-coherent" [1]. That seems like the more correct fix
instead of just a mitigation. If someone wants to switch the SCM
driver to the streaming APIs, that'd be cool too. On IRC, minecrell
pointed out that at least one function in this file,
qcom_scm_ice_set_key(), purposely didn't use the streaming APIs.

[1] https://lore.kernel.org/r/20230615145253.1.Ic62daa649b47b656b313551d646=
c4de9a7da4bd4@changeid

-Doug
