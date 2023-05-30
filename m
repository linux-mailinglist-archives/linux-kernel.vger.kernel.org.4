Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22FD716653
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjE3PMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjE3PMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:12:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0CAB0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:12:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso5097442b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685459530; x=1688051530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PXZe3EXlAkMKdJhgYvpR9WnbJkKx1aPWVPLYsgdSCp0=;
        b=AHUi1Q0uxvq1yojNNWM27xAyY/5x1EvANnavaQWFqqA8Myu7acYzmXPy3PnG1zkD6h
         wDMb/uyJ4XO0zwZEYPArfWxLOkOiOx63n4XoGLyDvbbPYtT3d5PITn8xAKdyokmjQHFw
         hiNZXPsg5Pe8bF85Zn2riaUcxYV2br3/dMOR1z5CHdYbIy3k3zNACkN1EKlusTcNFkBA
         Mmo9bGpJJeGtgCP6u8PO++LvSVnPRITOg4aOP1XBr3OndkjutibyS4/dJEpobaRNDLBb
         CxDJ+xsc/9sMUUiUTqkk87rnorIW/wwaoFNhMZxfuXAZdXzM55ybuEmEIs8zj0hE3MtR
         wtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459530; x=1688051530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXZe3EXlAkMKdJhgYvpR9WnbJkKx1aPWVPLYsgdSCp0=;
        b=gKTYeqffUThGQGlDty7cHNfRX45XZgwx43O/OXJcBGP9r43X8VMNbiYycbZJGpxmD0
         EGb8GZBlv4yejRtf/a4qUA9X2YHQRE4YQgKqzF6290zLw4BTHx4c4kFIRYrscLuBGrrR
         BIz4T9JBHS7/mtC4oXg5HtI98Diei8HglfmFyckQ2gGCiJiMzmjLiVbON9EvtrrEINog
         xr8qXXAq+usIv449MsSJS0uiDaoOejQfXzfxsRof/0bTZGhr1no9uWsMzbM65F1orYMD
         1IV4UeF81AsXkiT/ET2fznz7vUOrgs34e6z3doSjuQoCK2fnVSip53eIHsby81F8NDqT
         PXuA==
X-Gm-Message-State: AC+VfDwzcWwDqqYz4+U/9MS4oY3RfeMI+kEww8ORfrZ6Ta06Ypq8B3ni
        BS/5ERkextJI92S9M46t9mhib7yMWOYRBuBQer7P5g==
X-Google-Smtp-Source: ACHHUZ6gJX/HNxjQ97t6UmNIGPvxKmCnXU4VBGb1OMIMZ79GfO8VpBvRPxPpgqVByZqJFmOq6s+D90C97NUyUE8YQVs=
X-Received: by 2002:a05:6a20:8e2a:b0:10a:cb95:5aa3 with SMTP id
 y42-20020a056a208e2a00b0010acb955aa3mr3301523pzj.7.1685459529601; Tue, 30 May
 2023 08:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 30 May 2023 16:11:58 +0100
Message-ID: <CAJ9a7VhoMFqzSnvfq=kJzoPbTS3nPenyWPE5t-n9j+G2CL3SGA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add support for a streaming interface for TMC ETR
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a few general comments about this patch set.

Firstly, I am assuming that this is a standard TMC, with the new byte
monitor functionality implemented in the CSR block.

Now that being the case, all the byte counter operations, the sysfs
block_size, file ops to read the data and interrupt handling should be
in the CSR driver, not the TMC driver.
This counter is not part of a generic TMC device - but a specific
hardware addition into your system. As such I would expect it to be in
a separate driver.

The specific enabling of the CSR counters from within the enable code
of the TMC should be removed. If your device is set up correctly as a
helper device with appropriate connections between TMC and CSR, then
the enable operations can be handled automatically using the helper
function mechnisms added in this patchset:-
https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/2BBWZCBJWP3AOLBJSB64I5727JZFA6QZ/

I also see that you are assuming that you will be able to read the TMC
memory faster than it fills - as there is no guard against overflow or
detection when the TMC buffer wraps. Given the amount of trace that
can be generated in a very short space of time, I cannot see how this
can be guaranteed. Any undetected buffer wrap will result in
significant decode failures.

The normal sysfs read operations synchronise the DMA using a system
call and read the RRP and RWP to ensure determine the start and end
positions of the buffer. This cannot be done safely without stopping
the TMC. Moreover, you are assuming that the buffer allocated is a
contiguous flat mapped buffer, and not scatter gather.

The change to the TMC core code - even if this operation could be
guaranteed to be reliable, should be limited to extracting the data
only - ensuring that the above constraints are observed.

I'll comment inline in a couple of the other patches

Thanks and Regards

Mike


On Fri, 26 May 2023 at 16:35, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> This patch series is to add support for a streaming interface for
> TMC ETR to allow for continuous log collection to secondary storage.
> An interrupt based mechanism is used to stream out the data from the device.
>
> QDSS_CS_QDSSCSR_ETRIRQCTRL register is used to set the IRQ byte counter
> value. The value of this registers defines the number of bytes that when moved by
> the ETR AXI interface. It will casues an interrupt which can be used by an
> userspace program to know how much data is present in memory requiring copy to some
> other location. A zero setting disables the interrupt.A one setting
> means 8 bytes, two 16 bytes, etc. In other words, the value in this
> register is the interrupt threshold times 8 bytes. ETR must be enabled
> when use this interrupt function.
>
> Sample:
> echo 4096 > /sys/bus/coresight/devices/tmc_etr0/block_size
> echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
> echo 1 > /sys/bus/coresight/devices/stm0/enabl_source
>
> cat /dev/byte-cntr > /data/qdss_etr.bin &
>
> The log collection will stop after disabling the ETR.
>
> Commit link:
> https://git.codelinaro.org/clo/linux-kernel/coresight/-/commits/coresight-byte-cntr-v1
>
> Mao Jinlong (3):
>   Coresight: Add driver to support for CSR
>   coresight-tmc: byte-cntr: Add support for streaming interface for ETR
>   dt-bindings: arm: Adds CoreSight CSR hardware definitions
>
>  .../testing/sysfs-bus-coresight-devices-tmc   |   7 +
>  .../bindings/arm/qcom,coresight-csr.yaml      |  62 ++++
>  drivers/hwtracing/coresight/Kconfig           |  12 +
>  drivers/hwtracing/coresight/Makefile          |   3 +-
>  .../hwtracing/coresight/coresight-byte-cntr.c | 304 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-byte-cntr.h |  49 +++
>  drivers/hwtracing/coresight/coresight-csr.c   | 168 ++++++++++
>  drivers/hwtracing/coresight/coresight-csr.h   |  59 ++++
>  .../hwtracing/coresight/coresight-tmc-core.c  |  66 ++++
>  .../hwtracing/coresight/coresight-tmc-etr.c   |   8 +-
>  drivers/hwtracing/coresight/coresight-tmc.h   |  12 +-
>  11 files changed, 745 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
>  create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-byte-cntr.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-csr.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-csr.h
>
> --
> 2.17.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
