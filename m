Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A987261AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjFGNwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjFGNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:52:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DF61BE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:52:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75d4f06b302so62377085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686145952; x=1688737952;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBCy6Zr3tLUZoNRTWAl9DUYT1FQNLXNhhe11Jl7EVJw=;
        b=0C0UEcws8800wGAcfU9YjUSxWnq5/82Hz8dLip01clh8YgJqhfQAhSdQM/bRFYglqw
         BkFRmwNIC2wT1U5h0HObDAp5lkrdBVH6bKt2dwT4ugzdDyLKpZaYxWHCwiLplJdjXZRx
         aAqyVqX1sC1t6edvZlsbs52JcQ+JKet2zKf+e80GIEbtKibc0OaHtP07v7ZcMI+FxPMy
         nv0L+vWB5lVz/+HFIvc4xU1uZ0vaRRzxQqyY3fRmeuv0LYR0o1RRBOpXwfaoDKuER1vP
         QQF9wl/mb5fvfpO2cjkf69nmiPjrwww3q0SqVu/HWYAOeznBdMG/StrXRXlLPoLuRswQ
         wd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145952; x=1688737952;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBCy6Zr3tLUZoNRTWAl9DUYT1FQNLXNhhe11Jl7EVJw=;
        b=h/b1sxydv1RCq0/iaqc4hpow0a75NXBuaYYMM85Pxxo+ORdBGgf+t1N1w6wylLxmLc
         pJo1pUUv7nALSh99a5S/TS7uVfzIaFu8DnCksBUekXCpxdeWnMtU5OyN6JfbOZcE7exb
         mwDlnbMBzkeOqdVHAo7uUdIaCd8Rh7rfm6aB75BlV1KzlAGYGU2K8dUMVymoqzrzeutA
         j8wBlBGEGkrHSQRphdCriEhw4uQvmWbP2L/akPzzVqd3ruI3I4QDa+UD4RU9iJyJe7wk
         clHqbzRNdUWfXUCOisTZTB+2kPfyYDiBAMlZ6j12IIqTIwxUNSyi70eBLs7FLeV6pc2+
         8wQA==
X-Gm-Message-State: AC+VfDxGEMZbZHXYhRxQL4OMF6MjKJLbiOEB36Ai5HgzaUyYoD4cWkyH
        Zfei73wFnTVgKsW7c/P9PxOCUQ==
X-Google-Smtp-Source: ACHHUZ4fQ6pIyhB3M/I8i99y9dSNcWczKJKV8fRBAt/6EkdwqWBTOtLxNvG2mG7MjkYS368wiazRpw==
X-Received: by 2002:a05:6214:d8e:b0:625:88f5:7c62 with SMTP id e14-20020a0562140d8e00b0062588f57c62mr2038353qve.2.1686145951989;
        Wed, 07 Jun 2023 06:52:31 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b0062119a7a7a3sm6141611qvv.4.2023.06.07.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:52:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230605122159.2134384-1-zhongjinghua@huaweicloud.com>
References: <20230605122159.2134384-1-zhongjinghua@huaweicloud.com>
Subject: Re: [PATCH -next] nbd: Add the maximum limit of allocated index in
 nbd_dev_add
Message-Id: <168614594988.134969.5912378237473757521.b4-ty@kernel.dk>
Date:   Wed, 07 Jun 2023 07:52:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Jun 2023 20:21:59 +0800, Zhong Jinghua wrote:
> If the index allocated by idr_alloc greater than MINORMASK >> part_shift,
> the device number will overflow, resulting in failure to create a block
> device.
> 
> Fix it by imiting the size of the max allocation.
> 
> 
> [...]

Applied, thanks!

[1/1] nbd: Add the maximum limit of allocated index in nbd_dev_add
      commit: f12bc113ce904777fd6ca003b473b427782b3dde

Best regards,
-- 
Jens Axboe



