Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111197266DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFGRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjFGRMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:12:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02010EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:11:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so2496890b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686157919; x=1688749919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWtY5he6E2U22BGtj3uJgNRgjOP3X6c6EEgHAfVceAA=;
        b=mXect4J9DJmCaxC7euotMiP2tk7blJ93LE1V553qNvnTmgH2GBDVmDFCW6KtS+vMN7
         Axb0cX1wJcgTaXm1IdIPtXfvXLDZpE07394pEVTrE2EVF/IZvAIl+cI3LEK+6Ds1SLKT
         Zts25GUsIdKWoR6Z11646M2mmeheA6oHVWYMwDBK4U5ejNAAmW/uoJI7wnNntiAmwrMC
         rM4DXU3ImtDRebjK9ONq1qEODm7k4Sw2nHN2ZzXetQcjOZrL0sV2of4OqDDo4SAkdanR
         FHSjjp2mkYKC7sGhMCpwfoQWDwYad8UwSext4uZZOPzYyjNv2RvxaCkNvhztbXyh7PzX
         bMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686157919; x=1688749919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWtY5he6E2U22BGtj3uJgNRgjOP3X6c6EEgHAfVceAA=;
        b=c99jmHjtYFQxxNqawJGuyvy+5hQGCgjmG2sGUzoQ72WRb8dhi5g5ADfnr2aXNHXpgy
         TojwXL8CEXcs/9KlvkJteXg6TIOLIvlqCW2/uS48KVjWIrwhl+JaEQT+jdxKUrwhATz8
         4nixJlq17gERdN4TN6VDtE1nXGiF3pJl3wI3j8RSIu4DttH85XfGiMh/2Ze8hdX+oKth
         v2PL6dsg0RRTDbX+utJ2vLarYEG4XDQYj5witywqZmvqdIQAcTne9XIokAtCbiqBEtid
         lLeptw74bJWFdp/6GJSoIvnbrx+eEmUPmtdpfVUZYc9CoyQizeYnaY3f5Ge0FYPdGLbk
         dQhQ==
X-Gm-Message-State: AC+VfDyYLHMsU5NsyzuDjtcASSyasJV9qyZaQJmQOPC9SMGtX6E3BeRT
        99keu88B9oAU+JxNTQV7344g
X-Google-Smtp-Source: ACHHUZ5QgjgWoC5EH7Xt7czYHcPm4hEGhW8TrMZglVc/Jysfh+b6M9//znCzHXVkkqT037ZWx2uYdQ==
X-Received: by 2002:a05:6a20:4425:b0:10e:e218:d3f0 with SMTP id ce37-20020a056a20442500b0010ee218d3f0mr1743242pzb.54.1686157918848;
        Wed, 07 Jun 2023 10:11:58 -0700 (PDT)
Received: from thinkpad ([59.92.97.244])
        by smtp.gmail.com with ESMTPSA id 21-20020a630c55000000b0051b71e8f633sm9228268pgm.92.2023.06.07.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:11:58 -0700 (PDT)
Date:   Wed, 7 Jun 2023 22:41:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20230607171153.GA109456@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607094922.43106896@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:49:22AM -0700, Jakub Kicinski wrote:
> On Wed,  7 Jun 2023 20:54:25 +0530 Manivannan Sadhasivam wrote:
> > This series adds a network driver for the Modem Host Interface (MHI) endpoint
> > devices that provides network interfaces to the PCIe based Qualcomm endpoint
> > devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
> > devices to establish IP communication with the host machines (x86, ARM64) over
> > MHI bus.
> > 
> > On the host side, the existing mhi_net driver provides the network connectivity
> > to the host.
> 
> Why are you posting the next version before the discussion on the
> previous one concluded? :|
> 

Previous discussion doesn't sound any controversial to me, so I thought of
respinning. Maybe I should've waited...

> In any case, I'm opposed to reuse of the networking stack to talk
> to firmware. It's a local device. The networking subsystem doesn't
> have to cater to fake networks. Please carry:
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
> 
> if there are future submissions.

Why shouldn't it be? With this kind of setup one could share the data connectivity
available in the device with the host over IP tunneling. If the IP source in the
device (like modem DSP) has no way to be shared with the host, then those IP
packets could be tunneled through this interface for providing connectivity to
the host.

I believe this is a common usecase among the PCIe based wireless endpoint
devices.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
