Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6B6AC387
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCFOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCFOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:40:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED4C252BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:39:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x3so39385323edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678113581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK40+IrvuLAaGEzw1vO71ZMnvX089nmXSE+KdSBZGxI=;
        b=oXp6sr1ZZNV3kCcVqAjnKrsCZTq6Yd+kGZEwGCDR/CvIa91FWOC8MFGhga5zbAHKUE
         zixJlvHstgoRDL4/ZAvyKWwIaHK1mBgOUF4WQaBbid7Fi2w3r8sleHK8F89FRqkbfeE8
         k/1d3JKT9h6Cl5bTQ4aU+QxWYjCvKb6Gs1j27tKo1xuv+69f4aVtXkk0FmgVHSWSrcPW
         EzEfTX/9CrfL3ZmE4OoJbGcJ/B3d9aTzN5mZCkUY4tB62RJ3E79IpauK52c0Po5xcnhD
         ++ywZUSh3IpzJdLxo9lzbNGunVyZXt7Ndz7+e3JizTpDhSsfGE5+pIf4KE3ar1k6cNL1
         fRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678113581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK40+IrvuLAaGEzw1vO71ZMnvX089nmXSE+KdSBZGxI=;
        b=XY9QncnjTVtw2nsyKn75w7Qf8nC86JgqebayxsgMwl+sQz7SSliCWW5Fear7U5rdm4
         LcA2RANi52qU806V6WtbgURpRwKRSg2i9Fr9y9OSGPXmLxm1Z2iU03B9Mlk4qMnhsQaR
         2pJJ9Lq4lTI5sGhqoKu2nERAZcFTg5FRJVdDMK7Ykr7H6L01vY6j6/zp9udfjVfPqxhf
         92PujEhHflJ0Vr8gp427NwdMZC2hc2u/z8eoNnceFs1aBQP+bREVstqAJT34o1flX8v3
         WHV7emN7uA66KqyUTxOPCu7GQ/CUTuNvbMvFS/gBAWW3DBaqzwfr4QfzfMtInsTQOCrD
         8P7A==
X-Gm-Message-State: AO0yUKVU92w2yNWNMF7SEmQboNcVb8UNUMx+VRMFXW+Jm7zknAnO374t
        xiq10SXwB4avf5woxYS+4FuTd/Zz4dsBb1Rp7lQ=
X-Google-Smtp-Source: AK7set9tagM4MvfxFASDbgv+ClynFHyi2+EfGVgbjvu5S9HDWrjjA77I6x2FIorpAtxNw/VW+IojBA==
X-Received: by 2002:a17:906:5e0c:b0:872:82d3:4162 with SMTP id n12-20020a1709065e0c00b0087282d34162mr10260275eju.44.1678112891814;
        Mon, 06 Mar 2023 06:28:11 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906a38e00b008b8ae79a72bsm4636763ejz.135.2023.03.06.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:28:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: (subset) [PATCH 16/27] memory: tegra: remove MODULE_LICENSE in non-modules
Date:   Mon,  6 Mar 2023 15:28:08 +0100
Message-Id: <167811288496.11610.7328079575847216501.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224150811.80316-17-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com> <20230224150811.80316-17-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 15:08:00 +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> [...]

Applied, thanks!

[16/27] memory: tegra: remove MODULE_LICENSE in non-modules
        https://git.kernel.org/krzk/linux-mem-ctrl/c/ee5ca07b2041dba178e11f33c79d4bfc20227f09

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
