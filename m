Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9497264AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbjFGPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbjFGPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0001FD0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686151710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxLtlaE05xIT9NZmGVGxp/EURIr6OC1Lp2hDELcXxAU=;
        b=TnHnF2ZsHsVIE1IYn9z+/850cHTBl3dWSuwJ+OtTrComqx9O25Jhfc2GahNqnFeQE4B5Ww
        ulinPkfdNZOCEXX1y9kuds4nTr0ovyzmjeAnnVt5EHTHQEFl60PCJChx7+UuUNof81v+JX
        dJ1b2lU+/Q9UADuPiJyvHYSz6aPV+3E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-ZE1lvRXXPz2L_NYpBk17ew-1; Wed, 07 Jun 2023 09:44:55 -0400
X-MC-Unique: ZE1lvRXXPz2L_NYpBk17ew-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-564fb1018bcso123061377b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145493; x=1688737493;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxLtlaE05xIT9NZmGVGxp/EURIr6OC1Lp2hDELcXxAU=;
        b=Bh8lNXpN+QuXaAOzzX2OfOx/N3Ab/MmRcZs1mlE6gIPQ6GwQy6OL/7k2DVarjwEdC9
         9Qi/74GMFT+g/YCxjq7UUFKlTwtcI6Nqz/TCuAT2a3RfX6JWB4kP8wnnwf5v6MRTzyQF
         A7OZnnTTLjc2I2WrnfBkZs4+GggX4CwmljIBN+G7SNolVcwREOJtxay/ACVyOSI5+UtK
         OAtdOpEYmJk98snwIoQ5G8qfvZXxNaueDjvnJH1V5eJXxo9hd39yDhi+cXDvEPKbA1sd
         funQaRw07Y9/vlRyG06VvJu691im+xWzagg4bTkc9s1h8eG5x4okb10Z33VB0XMYVN/y
         HUyw==
X-Gm-Message-State: AC+VfDx9HKCM27apkcVeGpX/L6UHzpNiyVCTHGTSXObllqLGm5gdj10d
        tAhFB2fpGcDf92b70mmR4ATxuZdIEkUj/8vqOKOX9DXvvut6r4twTB8x1AGQhLmWd/vTgxeAEBd
        llKmn4nsAt5alKw7Vh9uBYvOc
X-Received: by 2002:a0d:eb0b:0:b0:565:99c0:a690 with SMTP id u11-20020a0deb0b000000b0056599c0a690mr7226037ywe.36.1686145493488;
        Wed, 07 Jun 2023 06:44:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wTaHqLBZp6jWJoe619kJAiY31OJl2xtPem1GubEkGBi48Y4e3G4HrsBbsiFfYL5yENCqRhw==
X-Received: by 2002:a0d:eb0b:0:b0:565:99c0:a690 with SMTP id u11-20020a0deb0b000000b0056599c0a690mr7226006ywe.36.1686145493096;
        Wed, 07 Jun 2023 06:44:53 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id j203-20020a8192d4000000b00568cbb028c6sm1115953ywg.85.2023.06.07.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:44:52 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:44:50 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sa8540p-ride: enable pcie2a
 node"
Message-ID: <ZICJ0pFc9wM4vjz2@brian-x1>
References: <pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhjnny@jvphbpvahtse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhjnny@jvphbpvahtse>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On Fri, Jun 02, 2023 at 03:33:21PM -0400, Lucas Karpinski wrote:
> This reverts commit 2eb4cdcd5aba2db83f2111de1242721eeb659f71.

I am all for reverting this commit however I think your commit message
needs cleaned up.

> The patch introduced a sporadic error where the Qdrive3 will fail to
> boot occasionally due to an rcu preempt stall.
> Qualcomm has disabled pcie2a downstream:
> https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/rh-patch/-/commit/447f2135909683d1385af36f95fae5e1d63a7e2f

Personally I'd remove the mention of the downstream kernel is this case.

Also your paragraphs are formatted weird with a newline at the end
of every sentence. Get them to flow together as a regular paragraph.
This is the relevant line that I have in my muttrc file to help.

set editor="vim -c 'set spell spelllang=en' -c 'set tw=72' -c 'set wrap'"

> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:     0-....: (1 GPs behind) idle=77fc/1/0x4000000000000004 softirq=841/841 fqs=2476
> rcu:     (t=5253 jiffies g=-175 q=2552 ncpus=8)
> Call trace:
>  __do_softirq
>  ____do_softirq
>  call_on_irq_stack
>  do_softirq_own_stack
>  __irq_exit_rcu
>  irq_exit_rcu
> 
> The issue occurs normally once every 3-4 boot cycles.
> There is likely a race condition caused when setting up the two pcie
> domains concurrently (pcie2a and pcie3a).

I would also add that Qualcomm told us that upgrading the firmware on
the PCIe switch would correct this issue. We've upgraded the PCIe switch
to the latest firmware and this issue is still present. Apparently we
need to use a specific older version of the firmware that we can't get
from the PCIe switch vendor or Qualcomm.

Nothing is hooked up to pcie2a on the QDrive3 so there's no loss in
functionality by disabling this. We always have to remember to revert
this commit when working with an upstream kernel.

> This is not a solution, so this patch is disabling pcie2a as it seems
> Red Hat are the only ones working on the board,
> we're find with disabling the node until a root cause is found. If
> anyone has further suggestions for debugging, let me know.

This should go under the ---.

Brian

