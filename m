Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE271823E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEaNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbjEaNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:40:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C71B0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:40:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso44611855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685540437; x=1688132437;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY81Z3rKpTC7Qcg8kQy02pyAPk5AkPwDZTxzOqMeqf4=;
        b=kHtxkM35y5PLlVXSnadx0SO0Fodm31QHBQxiobbqiJTrMbucNm2lYc6Q8iifl8laIg
         IaC2mSQ/m+2rsQpucJsmVUYq+8FmKFbX4srNnYkI49Eq/aqQDzU3WE/YBLqgzyiHbRw9
         mt/bv71Lw55Eo84reKkXDlxLvk3iUFV+25dRHJ/iesezkDBjOqpRNniOGDL5kKoIYsNF
         g4qwgpoCKJqQmRpLB8qvKKZpNarhjiWuURL/ixuWinXpDYfHUkoCsiFtak7Dcj02BrXG
         n2NJEMS6liOF/kMUAb59Clb3tnm7bUm65vb5emfrAt6lfM3xBwhHRzRrNlHoSe7QJMUR
         2fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685540437; x=1688132437;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY81Z3rKpTC7Qcg8kQy02pyAPk5AkPwDZTxzOqMeqf4=;
        b=WJRnnLV7DGxmDMTuJkhnNzZanaqyvQO/7hsYWqtotpO4ehGEXc8fRtrPvA3MS4h1A6
         rUjWv5c8Kf4SNX3Z7IaRXvIcqKVuOGzyrtFG+3lidSadA4fOKvR9GTDqIRlD/M7OWaPI
         kEnqvUmFJQxj39cbA28i/dzSVp8FBsIcHFU3xXUIV9PYLiKpQSBMrOd8WkKQt0yo7aQ4
         vuMq2vijpIMVp0HPF/IcZPlIKG5rW3ToYWexbVoNyzrHNb9pwEe1gN9u4KKqDFtGKqHo
         ZIJTqgZG/fixmH3SSDijXKJOjtaUsCdBeE7FqRakmkZ17E83F/8MJDgHb/5GWJW7yj0O
         3MfQ==
X-Gm-Message-State: AC+VfDxy7wc173STxYl2geOD4IqJaAHIhPjBmzzBFR0oXOSGuFXcoAsn
        EsJGGQEaLWNxRvbzvXhp+QHUpw==
X-Google-Smtp-Source: ACHHUZ6zooShtZDr78/kVMf6gNlUoaFqzkstirZwHKSiTw/NJAqgj7RyfIqb1AhomdXwes49Xd6dNQ==
X-Received: by 2002:adf:e44d:0:b0:306:3352:5ba3 with SMTP id t13-20020adfe44d000000b0030633525ba3mr4370045wrm.25.1685540437610;
        Wed, 31 May 2023 06:40:37 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n7-20020adfe347000000b00309382eb047sm6866358wrj.112.2023.05.31.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:40:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     nava.kishore.manne@amd.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, git@xilinx.com,
        Michal Simek <michal.simek@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org
In-Reply-To: <28f30fb7695d8719b45edebb9a01508f8d7e5e30.1684244701.git.michal.simek@amd.com>
References: <28f30fb7695d8719b45edebb9a01508f8d7e5e30.1684244701.git.michal.simek@amd.com>
Subject: Re: (subset) [PATCH] nvmem: zynqmp: Switch @xilinx.com emails to
 @amd.com
Message-Id: <168554043640.102669.561753469291697460.b4-ty@linaro.org>
Date:   Wed, 31 May 2023 14:40:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 May 2023 15:45:03 +0200, Michal Simek wrote:
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.
> 
> 

Applied, thanks!

[1/1] nvmem: zynqmp: Switch @xilinx.com emails to @amd.com
      commit: fe0b59882c020abd6c305c0f508f64fafcbbbca3

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

