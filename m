Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA7615E93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKBJAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:00:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610FB27FD1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:00:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k22so15842649pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FT0OTm0z8Frae+X539FGbdzsRWYK/iGZxdOx8XXi/LE=;
        b=Ig3AaOKwaXv4W1clrCaP8ht9oTFJTJo1Q07+8IC4AQqku4WSccnAXUtNfF47HXfycn
         yMl9xYjc9FN7TzblMaY83aki5Bi1NrwwE979V5vosIul1TWadsMnn0I1MNMNPr6UY3+a
         hlBMOg0gpoT3fVxCfwx113dt4hnQVi+wrSIu1Wtjx9y6bQGCIbGDlOqcqGBgt9imRNFM
         kGyn24WPVbNsNZhx6P1R2Dyfz6rH5Jt9EZN5pvLtY4WDRcFswmPIjqKnB5qqyYn1Jl3P
         QXu8/qirt0KRyVqE8yHL1TY1DuxrIhyxXlR8A5LfGhwhQDpKx/w2APECkdvP8XRIaYoU
         R0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT0OTm0z8Frae+X539FGbdzsRWYK/iGZxdOx8XXi/LE=;
        b=jTBmbjz6CC0JPoTJjWijIZOEtGNjYxRAb6JCQR5xlIGyP/lvaKFK9c+xE1cRTadl/B
         6RsN7UuJz5YQr7/Xq/Cb1uqYUmPiC3JB1X7jftQAQQQoz0yQBhiY3OXAoSa4C1njkQMM
         gt3LeCVz1zooPwDAs7Ic44DVd5CnwnItzwwcAOxA7qHoBT0QYewOygp019d6FtxZQCWq
         0SK/FXC7ymJrMiexTIg+D9/5YlzAmsD7klL/pL9A2mBObnAUIrBQlF3P9gZaItV8YnH7
         verlLIL+SijOhVF1rjChMAyRKx7jq7Bemy0vPFLY3rFvxC9bblDgAFDr6ncon0NtZDc4
         hSNQ==
X-Gm-Message-State: ACrzQf3jqn1T+kGG0tVl6ksQlIA+SIH7uWGmCdbgGiyHyv05qdsK1Dfh
        snUL4Q4/zFihR2A45upfbuIC
X-Google-Smtp-Source: AMsMyM6A8PrZycK/qPAPz/hujdmNg7sh4GoiwoUL8lyEDkoBWeQ9zBwvq9rJPp/VyCpGbtdYErn1TQ==
X-Received: by 2002:a05:6a00:e0b:b0:56c:8c13:2a54 with SMTP id bq11-20020a056a000e0b00b0056c8c132a54mr24047174pfb.17.1667379649902;
        Wed, 02 Nov 2022 02:00:49 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id z10-20020a63d00a000000b0046f7b0f504esm7136389pgf.58.2022.11.02.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:00:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Qcom CPUFreq HW driver cleanups
Date:   Wed,  2 Nov 2022 14:30:35 +0530
Message-Id: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains cleanup patches targeting the Qcom CPUFreq HW driver.
This is a spun off of the clock provier series [1].

Thanks,
Mani

[1] https://lore.kernel.org/lkml/20221025073254.1564622-2-manivannan.sadhasivam@linaro.org/T/

Changes in v2:

* Rebased on top of cpufreq/arm/linux-next branch

Manivannan Sadhasivam (3):
  cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
  cpufreq: qcom-hw: Use cached dev pointer in probe()
  cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq

 drivers/cpufreq/qcom-cpufreq-hw.c | 118 ++++++++++++++----------------
 1 file changed, 54 insertions(+), 64 deletions(-)

-- 
2.25.1

