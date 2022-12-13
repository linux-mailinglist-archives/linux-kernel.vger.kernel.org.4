Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05E64AD18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiLMBfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiLMBfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:35:33 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80CA1D32A;
        Mon, 12 Dec 2022 17:35:31 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id s10so1892580ljg.1;
        Mon, 12 Dec 2022 17:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zb/ZHYsfpuPE/e/VMYYS35g87tsNwG0rS/3SSWmqwM=;
        b=n8NcfdIg6zC+7GYOZRDEqHwVohEYbdGENYOu78w/SGUnlf5fsI6g8y9z5h+I/yyHM3
         rb6BG6WwhxHrD1dGvin62Vd00wolV2sH8ryaUTkOAsC/R3uEXV3HUZus7AEULuMNi+WW
         505GINYoKD8+PrwUhHwHbVHzXB0EQBHhQ++vSX1SQnGACcrLQVStas8h++mcfYcAkY2m
         VEIkLmnXQOtkuFyQaJEL+qeyxJLtkyI258DHGnwuVUk8w0b5uw728Z18hMKxUEZkWmIg
         YiQTH9FNVMmbuVgMT/4Zi5R1ZSCMIQAaThz2hEbyBovQC+EBVypcWrVsEyuCYlQsqErT
         e9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zb/ZHYsfpuPE/e/VMYYS35g87tsNwG0rS/3SSWmqwM=;
        b=t5PBoT1ZV8G1J523xuZZcOGMlS03bxdY86YSkxAERkmpEOvUzMiKDLm1UKIrDN11dN
         x5G7QsTI6/ckmibilrjfDvV7Ak0q+/EvX3IP+bIey4xDzsH0k/od9xYLSwGIJLkxtpV4
         KwBuke/xOlzwWBKQCJHDWPpPbOK4IUiVET5FDhYiJ+FMc0ROWBUL8/zxHcsHQMa4DGCl
         EJyftoPdMMSRFJB/HOQw/gdK9z+Fe0LeNqwRCbCu7fpaxcIEj1R3S2Znn16xpfUPnqc3
         Ay5NxH9Kj5EFGBw6Pe9U2pNpQnFXjK54/xqmpgdkUvAw+9tEaetnDRIwF11unAb1n3ih
         AECA==
X-Gm-Message-State: ANoB5pl6GayhQBRF4rKvMYodQZI4fyxFN60P3uMNqrH4GY8O5oInbKVL
        yoSVBiki1ec/NDtj3gkqw59pFeBxMQFY3EgBsQ==
X-Google-Smtp-Source: AA0mqf73iuyZli6w+OtnP0n1VKe8vc3UJcz2tCpAF5JhY5bzS+k5Om7Xfnw+Joupnm6UpNl61qWbLznTWiQlpQ8mXHU=
X-Received: by 2002:a2e:be07:0:b0:26c:6dce:ce59 with SMTP id
 z7-20020a2ebe07000000b0026c6dcece59mr26743109ljq.130.1670895329782; Mon, 12
 Dec 2022 17:35:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1670541363.git.quic_asutoshd@quicinc.com> <d9aaeeca38fe813aad7d78222a46de444e9698a9.1670541364.git.quic_asutoshd@quicinc.com>
In-Reply-To: <d9aaeeca38fe813aad7d78222a46de444e9698a9.1670541364.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 09:35:17 +0800
Message-ID: <CAGaU9a9FPKP_MeFw3x24ps_kS-BVjNHxEab6OjvZEZow-J0e=w@mail.gmail.com>
Subject: Re: [PATCH v11 13/16] ufs: core: Prepare for completion in mcq
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 7:36 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Modify completion path APIs and add completion queue
> entry.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
