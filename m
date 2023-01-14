Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D366A9E6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjANHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjANHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:12:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F659CB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:11:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c6so25579583pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hhoYOhdFd/1XWBMyQAS/0V7h4xRZx/EixJ0JzHFu+g=;
        b=s/rwqXRQRrL287PIModN2dUSPDh/Rdn5QjNd5Xp+Axm/oMwq7OfgSfuDuisdK92Hq5
         MTLo1kefENmoT+Q58au/HYoJ7/OhtfVipv0+5dmgr8+c4+Q7Hvxbxjsj+5nOA0MLeWVN
         DZR+h96VSYYvWFA2l9s8uXTAmA8dvCNTT6eoE8OZ4jbckdImpMl0O4UCDnMxY3h9cCNC
         6rOTpmW/MGaeggiUS23KBUei63wgqnewzos/1PZYDzseOX5DojemX+yAlGmZW6kx2Hok
         3qYLB75spkgntclw0xXCtIluVmHzwlWYz9Gx4TPqTBOz1t/vZa0Xd/p/WDU0cOXB9M7d
         THVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hhoYOhdFd/1XWBMyQAS/0V7h4xRZx/EixJ0JzHFu+g=;
        b=ylNWbRNLQFVJIsyatOpMOBUhaaWErwUHBZbpIoTm7OlFB6piTaPC8IOp7+IaEyqqWc
         22RROD2+z8lwXFNVUFoaszxBEEeKAnDV9DrovaQHxpgZJWc1vmEVOi48x+ktrlzkEe1c
         MJNRMiRBWT2a878P1hRcmEQNqCN9y/nMEe/VudLwzsyfg5N3CHK10AgCi3HzSfGhh6ks
         I8kyecdX8CCxrPA+/j5fHE6RMnz9yJtkAWVFrptJU/xn9qjZyLe9TpBAazmStDOz/GFh
         mFFy97ShQqWNCd7E/7sNooQDJeDWm9NAjxfVz19cT3q77uXJhVf6GL7X4i3yRA6JKwtg
         y+Vw==
X-Gm-Message-State: AFqh2koZ6vNglSRnH0B6hQKpYzit1VjdhHm+YKVQ+BXc6jyrRzLRcIbO
        kdeYHS9naEQ2+n7DRgq4jfOA
X-Google-Smtp-Source: AMrXdXuRiszNGrahdiih775tFedEbPuYrEDVDujrhEjX5i2q3iO2KN2NrvpKq7SntYHOH003BwajVw==
X-Received: by 2002:a17:902:e5cd:b0:192:9140:ee76 with SMTP id u13-20020a170902e5cd00b001929140ee76mr86976458plf.37.1673680290585;
        Fri, 13 Jan 2023 23:11:30 -0800 (PST)
Received: from thinkpad ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b00192d9258532sm15316913plh.150.2023.01.13.23.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:11:29 -0800 (PST)
Date:   Sat, 14 Jan 2023 12:41:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com, abel.vesa@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org
Subject: Re: [PATCH v5 00/23] ufs: qcom: Add HS-G4 support
Message-ID: <20230114071124.GA6992@thinkpad>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
 <Y8BNQZ/CFljuxsSL@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8BNQZ/CFljuxsSL@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:41:13PM +0530, Vinod Koul wrote:
> On 22-12-22, 19:39, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds HS-G4 support to the Qcom UFS driver and PHY driver.
> > The newer Qcom platforms support configuring the UFS controller and PHY
> > in dual gears (i.e., controller/PHY can be configured to run in two gear
> > speeds). This is accomplished by adding two different PHY init sequences
> > to the PHY driver and the UFS driver requesting the one that's required
> > based on the platform configuration.
> > 
> > Initially the ufs-qcom driver will use the default gear G2 for enumerating
> > the UFS device. Afer enumeration, the max gear supported by both the
> > controller and device would be found out and that will be used thereafter.
> > But for using the max gear after enumeration, the ufs-qcom driver requires
> > the UFS device to be reinitialized. For this purpose, a separate quirk has
> > been introduced in the UFS core along with a callback and those will be used
> > by the ufs-qcom driver.
> 
> The series lgtm. This fails for me to apply though due to other patches
> I have picked up.
> 
> Can you please rebase the phy patches and send those 
> 

Done!

Thanks,
Mani

> -- 
> ~Vinod

-- 
மணிவண்ணன் சதாசிவம்
