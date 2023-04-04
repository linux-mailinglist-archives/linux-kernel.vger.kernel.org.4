Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30806D62F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjDDNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjDDNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:33:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5566440F7;
        Tue,  4 Apr 2023 06:33:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so130712457edb.4;
        Tue, 04 Apr 2023 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680615197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwJEg4kSiJeG+bKb2q14x7GGOU7NSkchl/j92yiXg7U=;
        b=MuSYdjh+QCayiQUJkOf4m2rMPRu9rdcvWCbuNkWLBvmnLEzChkNwfyKu5udGZzzji4
         EzT9Fg5IegIGfU+MIwoDKE4ExsCmce0oZaSSKL5v9zZCuQDatW1p6xGPEYGpjOHFvl1c
         SrJB3sj3nOaffX+WY+BaLuaRPMwOPlnTSYPPI/pkOnF/QkQk801MSydcGKcllfUxqHtc
         fP71AlCI6Tgo1CrIB/09Xh2kJeBPIn/7LHtQGAG2tNpoj82pt5UeNQIGCmiMF6f5oV5x
         iTOxLBBiQJVZVKzMbyCjaiYHwlcOqs9vzOsimiT8ZWPIa5a+AWqU75sAspy9hDuVWYPD
         4Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwJEg4kSiJeG+bKb2q14x7GGOU7NSkchl/j92yiXg7U=;
        b=vI9vB80/aRhbsxS//lx4Sccw3IdB5Dw5T5iIF8Tnn2pRdBqmUZGozlrGhGq0/Sknko
         SLg9kH2gLgm7fx181Duj+u8++4G5hFn6Ew+/2FHZfcCDckUQaYQjzFzySZljEx1Y/jD6
         4yqbWa/Ys1YubLcv0kHVP6qj7JySDjPQfqEhL6CF2BsWiL6uAXp0cjW1GMKmHFoeEH33
         XUc3bgNTX2h9NXvsrmCOK7EYcnyODJ8vUuLzBvHsjE9aYeWQPpyoE9oQ7j3Ahpt+q0p2
         WqUlWYkreZE1uTS3j1fxxuz1PfhNq8L/QmeikDGd54XEtKbznESHVW4tnVsUOdegnJJn
         m2rQ==
X-Gm-Message-State: AAQBX9d9wHXmqYVbE1y1V9jJ6ZIWcNNKi6713iy2omhALpg6CcrH2MDI
        BpqeUgk5mS6IjzETG2a/QuSviUK4wLc=
X-Google-Smtp-Source: AKy350az63E2FCXZQbaFefKrXrib3smOd7HNt/z9zFCes+JoVB7qAcIQuPE4II/SVA3m8pS5qCA4zQ==
X-Received: by 2002:a17:907:7656:b0:93f:3084:d6f with SMTP id kj22-20020a170907765600b0093f30840d6fmr2399049ejc.18.1680615197522;
        Tue, 04 Apr 2023 06:33:17 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906341a00b008df7d2e122dsm5918324ejb.45.2023.04.04.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:33:17 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Tegra DTS improvements
Date:   Tue,  4 Apr 2023 15:33:12 +0200
Message-Id: <168061516877.2141244.5510663138589135443.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090403.5274-1-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com>
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

On Wed, 29 Mar 2023 12:03:59 +0300, Svyatoslav Ryhel wrote:
> Path for mmc devices are replaced with labels for
> better tree comprehension. CPU paths are replaced with
> labels references as well. Fixed accelerometer mount
> matrix for TF101. Added 266.5MHz peripheral opp node
> for devices which need it.
> 

Applied, thanks!

[1/4] ARM: tegra: transformer: use labels for mmc in aliases
      (no commit info)
[2/4] ARM: tegra30: Use cpu* labels
      (no commit info)
[3/4] ARM: tegra: asus-tf101: fix accelerometer mount matrix
      (no commit info)
[4/4] ARM: tegra30: peripherals: add 266.5MHz nodes
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
