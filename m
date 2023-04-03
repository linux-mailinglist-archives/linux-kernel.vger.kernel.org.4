Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D636D4485
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjDCMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjDCMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:34:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91641A7;
        Mon,  3 Apr 2023 05:34:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so116741406edb.4;
        Mon, 03 Apr 2023 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680525295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtVxUa5GbvQbInbpWYGe+NpGQEqqfRWgDia/3ptEFZ8=;
        b=Qy8xeLJ6dpwfZhNZ1gU/VF/ba1JTXpwUzL1OWA2ckScUKRoLUpm2BPvChv3nBU6X8W
         YXlBNjs+PC0i57Xzi54EifATk/md192XF72vPr5V+dQqFkLuZLtQFN+6vStMKglY/Jcq
         5U1AeM1IWZFF9Gc87MqANj7/85iwYLWP+GJUnKMlnAZnzEvq8ReodTKdzVHQfLb3LrZM
         t1SBd6n3iRaWfPlkz8TNSiLgXguQzKi0DGp5LnY1dXoZGHdPBlY4WCn0c9Cz2kqLohvb
         u56wj6zpVuTusmt8NyoJGen/WjYf+6Vn+c3YT0wRFKkWM0YYsmtKtW2geNiFZPXau2LH
         /Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680525295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtVxUa5GbvQbInbpWYGe+NpGQEqqfRWgDia/3ptEFZ8=;
        b=XJVN9JMqve9/vwh8/yCfJ1DVUOSeQGMeE5PcUurh0/+IoGUJGYjEHbNMiJmKkXMnhD
         omj+lghmQ9mssd30VdIJWsmGd8HlBDXR+3f9e/yrx3UTMtoQG2MsN5klDEnp9j5HCbAR
         WzASGVExJRls8SUxjfQyGqjU8DK99b4V2hs2/rA525AZaCaFygIQzc36NLupQ9J8AQ+X
         q0Q03p6jw7CbucupJgFy6Pd4OOmNe4OMSjkdBBi8p7kOyune+vuQAKi5NV6bzP7JJ5kp
         McHWtK26qEXlsLHCibtN5pQ10G7sdXB81NoNVaeXnmgjCQcRn/7t1q4z8uYoo3p1WRAW
         y8cQ==
X-Gm-Message-State: AAQBX9doS6Gx5507ii8F1CHYXx1pA4za5gSYfeLjOQVHimYz7DeiceQZ
        3XF7+wR6xkJbKLvC9mQSMXgyIT3FZ30=
X-Google-Smtp-Source: AKy350byu/0moN89r2ygiunpwT2gKrbSfNKb4c47wGp4CAzddKiOCZ+04YAnb2pvDfNPzGKSEc761g==
X-Received: by 2002:a17:906:9f1a:b0:947:405a:955f with SMTP id fy26-20020a1709069f1a00b00947405a955fmr13323561ejc.31.1680525294714;
        Mon, 03 Apr 2023 05:34:54 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kd24-20020a17090798d800b00933d64cd447sm4480927ejc.121.2023.04.03.05.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:34:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: tegra: bpmp: Fix error paths in debugfs
Date:   Mon,  3 Apr 2023 14:34:50 +0200
Message-Id: <168052526462.1061641.10119003958456223259.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230301134756.999169-1-cyndis@kapsi.fi>
References: <20230301134756.999169-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Wed, 1 Mar 2023 15:47:55 +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Some error paths in mrq_debug_read and bpmp_debug_show would overwrite
> the return error code with a subsequent call to mrq_debug_close.
> 
> Change the code to only change the error code if there was no prior
> error.
> 
> [...]

Applied, thanks!

[1/2] firmware: tegra: bpmp: Fix error paths in debugfs
      (no commit info)
[2/2] soc/tegra: bpmp: Actually free memory on error path
      commit: 61228c9b240468dba55ef8a4ac93e777c810c68b

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
