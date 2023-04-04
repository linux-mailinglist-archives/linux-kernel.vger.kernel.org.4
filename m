Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D466D62FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjDDNeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjDDNeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:34:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4928144A1;
        Tue,  4 Apr 2023 06:33:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so130712733edb.6;
        Tue, 04 Apr 2023 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj6AAE4bBemvgWH7OPzB21B8uE7Vkqv4W3Kl15c9r2E=;
        b=n0i1awinG9E8S337ouwMBqHM20IpfPjlf84YjQ9SroLgB3kG0CmdNvRF+mekeo+v/L
         c9m2SLe6XcHrhAAILk5K2iQceebI4JlxSz+HE0+Ya4//Xnuge1eENvJpacS39krVEAkO
         rfkZJcJPLzasTTz0R+Vs1QS+RHm3jqwCehXBj5ULBu5rbvgRshnPe9Z6rNvztB+cdpsS
         T83P2hBtyOaSrMY/hrhtVEFXyNNqyJmDDRirzHt78y68DUGo3CO5bGRqYJYwjLvD+GOn
         IqqNEmjePC/SL7lOwql+8NOINKdvn0/tiqvLAHILapZ4pSC2LU6RnrMiPeGsZWHeXV9+
         EQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj6AAE4bBemvgWH7OPzB21B8uE7Vkqv4W3Kl15c9r2E=;
        b=LT4kOZwslDyvSHiLrTyZAR6EVGRYKvCMtJwMRVKsvFPD7PsrOFpO7Qw0Q7nNmkdT9n
         5m+OUkLGluAojPPa1YBTayebu0wTSpPyETb/NM4zSoxKHQSgmiHgzMQb2y6w74iMbc7m
         nfSyIjYPDkX7nY/dcO/AKOA6QtE7P9aOK0Z6tdusa+MBN0esOHv9GuvF47sTKTpGIPkI
         +Rzq6pDkQhqMklA7k72cUNKclIWfM1I69heIXBHqFTEposvELsobg6JoQS6ZLQ0dnBGR
         JReMMRncNYz0CjzU8Enot0tQTnZrXdLqQqyNtf6DG5WkfwwuHr463Ga5MEMTKwmtQ0f7
         r9hA==
X-Gm-Message-State: AAQBX9e9cJZpiTgsD7zAz129zYfR0Zc+k9xF8GJqK5JF+8CBNsCgp9IZ
        8YWTYTjmwjdHl/SzSe01GMY=
X-Google-Smtp-Source: AKy350bwkSXLO6QYvpzoePwPAAlm7RHyQM5h7B7l4VrnUybYq2A63vhPiqUsbragWApeQiUzrfX6SA==
X-Received: by 2002:a17:906:3bce:b0:8b1:2d0e:281 with SMTP id v14-20020a1709063bce00b008b12d0e0281mr2423674ejf.18.1680615198361;
        Tue, 04 Apr 2023 06:33:18 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id rv13-20020a1709068d0d00b0094928b18886sm592497ejc.52.2023.04.04.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:33:18 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/4] ARM: tegra30: Use cpu* labels
Date:   Tue,  4 Apr 2023 15:33:13 +0200
Message-Id: <168061516876.2141244.13032819432444292317.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090403.5274-3-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com> <20230329090403.5274-3-clamor95@gmail.com>
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

On Wed, 29 Mar 2023 12:04:01 +0300, Svyatoslav Ryhel wrote:
> From: Maxim Schwalm <maxim.schwalm@gmail.com>
> 
> Replace cpu paths with labels since those already exist in tree.
> 
> 

Applied, thanks!

[2/4] ARM: tegra30: Use cpu* labels
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
