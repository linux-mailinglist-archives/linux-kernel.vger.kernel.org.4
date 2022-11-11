Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146BD625D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiKKOoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiKKOnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:43:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFD365862;
        Fri, 11 Nov 2022 06:41:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k2so13072021ejr.2;
        Fri, 11 Nov 2022 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxGaN+2HFd8fmu++thB1+61M14XRErmSFsbDID3TV/U=;
        b=Q6jWQWCzMXhq7eCh71FSNeIJ7svvyBei2i7RNsGPHd3BlgB70oOdzSR4IJJG+Yfsrc
         8THTiItI3AvFG8GMWY4oOdHzIh2I4j26qQ5PaWgqlXrPkOgGaDXxBeHyJMhiSsJOrw53
         SsOKL22gDCI72uBvkZBkybPysorH1WPFf7NDNClsMaZk3Ke/JNxQlHTRq+F+ArQTrBGf
         6bIkkb8/ScwJ81gpbC72YuHZkeoX4IHLCKq9miDdBDzcycrbkjbnuJtBYS+eAZSYzuMc
         5qgqmhGYJMxmkqfdvBywGcR6tvo5fLCvq5GtQxv9SmF9dFdCN4NwMfcCSZrJeQs5+x0O
         wPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxGaN+2HFd8fmu++thB1+61M14XRErmSFsbDID3TV/U=;
        b=wVYsFbbgHsbjSpkorIUNlJJuIg+oJ50i9F0rBfRcK7mqpI+2gRY/0FIldQszUg+nYR
         SfTfFPU6oDXwFz3GjAbYO+4/Kbu2bfLRgYJsbeoIvxzoJx+BbyDJszEb3J3Y/CmYKJ3m
         bPm6fJ46zjj910HmteKMz5QCq0MzXbocJgsd4lG3WKHQHqIuVCInzhsvu9xzjVLIhSOO
         kTE0mpFYsvLa3gN1WsHxcjU/xKbFYrjp9arFaXU607c784xQvof7C8SLSOJHSwmQeVyv
         ULmm/YXUmVGLcxi+SsYcEwyYcN2JFRjZiX0+PSjHZQrChl/1GfXwEhQBeU87mPUH3uYN
         7lfg==
X-Gm-Message-State: ANoB5pk2FsM5f+X+FCi2pqc8K1Ze3J7elnB89AADAgb6s/DzeY497/2W
        qhgCQcTVqNkxAJbbE2ss2VtDV4goYb4=
X-Google-Smtp-Source: AA0mqf6tvtr2510oCM0aGqc5xX7cJEXX8qrgkgjjYDXC+Bx5ntxiAX/ilH1BOf7bwxObXqH1NE8dkw==
X-Received: by 2002:a17:906:5054:b0:79b:413b:d64 with SMTP id e20-20020a170906505400b0079b413b0d64mr1971719ejk.538.1668177696110;
        Fri, 11 Nov 2022 06:41:36 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id eg25-20020a056402289900b00457b5ba968csm1158729edb.27.2022.11.11.06.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:41:35 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com
Cc:     bbasu@nvidia.com
Subject: Re: [Patch 1/4] soc/tegra: cbb: use correct master_id mask for cbb noc in Tegra194
Date:   Fri, 11 Nov 2022 15:41:30 +0100
Message-Id: <166817763540.519550.6000067127559043663.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109135717.3809-1-sumitg@nvidia.com>
References: <20221109135717.3809-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Wed, 9 Nov 2022 19:27:14 +0530, Sumit Gupta wrote:
> In Tegra194 SoC, master_id bit range is different between
> cluster NOC and CBB NOC. Currently same bit range is used
> which results in wrong master_id value. Due to this,
> illegal accesses from the CCPLEX master do not result in a
> crash as expected. Fix this by using the correct range for
> the CBB NOC.
> Finally, it is only necessary to extract the master_id when
> the erd_mask_inband_err flag is set because when this is not
> set, a crash is always triggered.
> 
> [...]

Applied, thanks!

[1/4] soc/tegra: cbb: use correct master_id mask for cbb noc in Tegra194
      (no commit info)
[2/4] soc/tegra: cbb: update slave maps for Tegra234
      (no commit info)
[3/4] soc/tegra: cbb: add checks for potential out of bound errors
      (no commit info)
[4/4] soc/tegra: cbb: check firewall before enabling error reporting
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
