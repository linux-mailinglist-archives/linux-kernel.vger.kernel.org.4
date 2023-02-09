Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B33690979
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBINDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBINDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:03:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2025A9C0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:03:10 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e204so635258iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BLhFFCKHm0oII2gyoV1aB9Sk1JL4f2g73gTx0u/oBCg=;
        b=SsrSgA7W7bB4sFMXfTS+q0CH/gxFqWUiJCqRSd3KHmT3Xa4ioR8qzUJ+TBoG/IfQNi
         8WRNpqu1r0iylVt1tQR8sjkU75SX1H2X/ZtPkZGsA4KdrbrEkAR8IJQxfUYEKsFfgynb
         CSkjD06fekzjYYLvY7I4uj+cVix9r6uFDm4ZmIMpSuCMvMwYJ3Txu9V5QBDggBHhlROt
         5Kp0XWqXLQRcE+6OglHnkOOZ00f80cYU57P7iMazOIiruVzUNaGKFodOavcdl4OYeS20
         XMfTMCdz3nJj3xivbK4fg1kbVqNVYzhfqTgW37MIZVE6d5tgLIKQtWo3p2mmFljO10c5
         7hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLhFFCKHm0oII2gyoV1aB9Sk1JL4f2g73gTx0u/oBCg=;
        b=qgiPS+GDwDJGQhiJo7p8cdHMWGR2Q+kDfnWm8DUoOAjjfRMIPdERsWu/wFA6V7OssZ
         Yv0ijjPxXTzn1SwlCMFeyhWN0+hR894p4uTFERhSaXbw60pUVvTDlVBtpccADzpLKKkB
         kCV2jxBf/oALHnab1lsL/IiFMP6mLIKBQfrokHqwsxe5buUoYn1g2s4axJImd/pjsMwK
         GDc+MeHGau8Y/lkV39oSQARLToeuvFK3aYkZYnNScddrLXf1LAtYRBt2MMBIH1wTLWhT
         lzLfL5GBypyN7L2w5Vlx2qCNRNYbFrEdujuQPxUvLJIoFoLanUhIQXvR/u63Qgyb12AM
         +LVw==
X-Gm-Message-State: AO0yUKW3tbcSXN59wWH9jUe9qgU74WH/PCYjSdG+vCk8AMdN6UI+X8MV
        DFtv6oEsaGeiIigyjhhZr8C44uYhdEH/AfxPieZGBA==
X-Google-Smtp-Source: AK7set/JihrZo9EK10tzAFsgIJq8Bjy8Qq/bLGfpFP5vdpqkdr/gvIREuns5dE8LD107MiBMBB1OcM+YYfX6Qz+c08M=
X-Received: by 2002:a02:cc64:0:b0:3c2:c93f:e40 with SMTP id
 j4-20020a02cc64000000b003c2c93f0e40mr3000524jaq.126.1675947789836; Thu, 09
 Feb 2023 05:03:09 -0800 (PST)
MIME-Version: 1.0
From:   Albert Wang <albertccwang@google.com>
Date:   Thu, 9 Feb 2023 21:02:58 +0800
Message-ID: <CANqn-rhFH+RivRdiGtdFpjFKEpsJ497Z-NrtJ+naSHE+gJrzMg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/22] usb: xhci: Add XHCI APIs to support USB offloading
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Thinh.Nguyen@synopsys.com, agross@kernel.org,
        alsa-devel@alsa-project.org, andersson@kernel.org,
        bgoswami@quicinc.com, broonie@kernel.org,
        devicetree@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@intel.com, perex@perex.cz,
        Jack Pham <quic_jackp@quicinc.com>, quic_plai@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wesley,

It looks like I can get the transfer ring address by calling
xhci_get_xfer_resource,
and the xhci_get_ir_resource() is called to get access to the new structure
"xhci_interrupter" for the event ring address. From code review, I can
say these
APIs allow us to get the information we need.

Of course, we will integrate this patchset to verify if compatible
with our design.

Thanks,
Albert
