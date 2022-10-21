Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE31A6074DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiJUKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJUKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:17:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79E22C811
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:17:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i3so2141023pfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chToiRE79dyQohjKWy6Xf0rYGA+c4XmQyOJON+t76kc=;
        b=rjjKRngueCKD+d8V9qYutKXKg/ee+3plDwAknU6X8UIqQnF/Rk1YTtksCagg1AKr9y
         LopHRul2ltTTW2e47xclaUWR4rX+7mX6wgok90ubsNd0c+2jv1gaAQ6s+c2uzHTKAB18
         Ii0Lcy2gI5HRb2WMWkyhgrSlQ+5b7a/loNCPPHpfs0JlVUn0dIRG6kdH0XRog20CM//k
         kqH3cp3k3BarrSf0qSrpL/Vlr7xH58LAq5U0ji1Rvr1k4gjKlWQiiTdRdl6e9B/RVJjE
         Ph+CQeJyBsQg1/67AtyZtmnCO5mqV82TF687+yN2iWk/DLkfxkb4qOGMUQVl6ccVUXJZ
         ImAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chToiRE79dyQohjKWy6Xf0rYGA+c4XmQyOJON+t76kc=;
        b=woaTqtuMxq7j2N4TWNfgkh8Wdq27Y4lfMsbDcaJnnhWOp6qsL6uYWodJPEXerVw5SE
         iUzoMahE9PrqSu5xQtCSS5Au8gwvAaHFrO/72bLTEU/zvHf/gnRgudaZF+xva4Sfslpq
         yvEL0ZH1ATKF5MFNSnKEoaa636AlUSrefDk0xnYGdXgLmZuYvTlye6X8oaFVHv9wtejX
         Hf0ukhMVEB43EC2Yfh0yTMEMDN3Jtd5tM00+YX/pbojpT8Wr8I4Y30Wt0Hddz/YBxUc0
         NaPC8hSh1ZQxs3x80vMbxQgKwvYElCfdLEXL5o4vdqdZEd+YF4uDjy02CfmQsQ7MXTGb
         Dbtg==
X-Gm-Message-State: ACrzQf26lGvRqbDMrnW/cIAi6UrBCJg+nHnAf3Wgq1l5hKm3RziAia+X
        rmC0cxtgVNEnZuyRYipHY1BR3UU4whzMDMV8o28c1Tu6z+iSj4ID
X-Google-Smtp-Source: AMsMyM6f8+NhRPV9siRP1Ip4IpYA7xrIdI6v8BGFxs7L5GsZRAq65sYX54oSLoG60GPK7yun+MWzPqhgAX21H9sWveg=
X-Received: by 2002:a63:fd41:0:b0:438:7670:589a with SMTP id
 m1-20020a63fd41000000b004387670589amr15439519pgj.148.1666347466778; Fri, 21
 Oct 2022 03:17:46 -0700 (PDT)
MIME-Version: 1.0
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Fri, 21 Oct 2022 12:17:35 +0200
Message-ID: <CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com>
Subject: [BUG] Intel Apollolake: PCIe bridge "loses" capabilities after
 entering D3Cold state
To:     bhelgaas@google.com, Rajat Jain <rajatja@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     upstream@semihalf.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This a follow-up from a discussion from =E2=80=9C[PATCH V2] PCI/ASPM:
Save/restore L1SS Capability for suspend/resume=E2=80=9D
(https://lore.kernel.org/lkml/d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.c=
om/t/)

While working with Vidya=E2=80=99s patch I have noticed that after
suspend/resume cycle on my Chromebook (Apollolake) PCIe bridge loses
its capabilities - the missing part is:

Capabilities: [200 v1] L1 PM Substates
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
  PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
   T_CommonMode=3D40us LTR1.2_Threshold=3D98304ns
L1SubCtl2: T_PwrOn=3D60us

Digging more I=E2=80=99ve found out that entering D3Cold state causes this
issue (D3Hot seems to work fine).

With Vidya=E2=80=99s patch (all versions form V1 to V3) on upstream kernels
5.10/5.15  it was causing underlying device unavailable (in my case -
WiFi card) - the V4 (which was accepted and merged) works fine (I
guess thanks to =E2=80=9CPCI/ASPM: Refactor L1 PM Substates Control Registe=
r
programming=E2=80=9D) but the issue is still there - I mean now after
suspend/resume the underlying deceive works fine but mentioned
capabilities are still gone when using lspci -vvv.

I think with current code it does no harm to anyone, but just doing a
heads up about this.

Best regards,
Lukasz
