Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A16ED801
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjDXWeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjDXWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:34:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5E61AA;
        Mon, 24 Apr 2023 15:33:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef302a642eso24319211cf.1;
        Mon, 24 Apr 2023 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682375637; x=1684967637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3dxvzFGuNd+GK1v6Xpewb7r8h5x3GkgpfQza5pdVPw=;
        b=Ca1ukqhl3oE2R7BQ6t2pwmUsZOtLTRnmqSKxNgCu7B+LE+qMiG4MppRPp2Ye0+Hw8q
         a+WZtAOqwp4U+tSRPmm/tJeMus+6vRJ45qYI/6TBHy8hJLjXaMvPMITlygvitqTonnky
         Tl2DcgSX6yti9eM714Ho218MSta5g4jUVbucsNj1LhioHd5w0dSzudR5408OG14mRhb8
         pO16frteZYXWxZbg3kHqEVGyrZ3ykJRY0vyhqjBN3eU+Uz7dfdUewjoxJcmkVmqeK1lq
         61wjU/A17luXmvK/GJJSRXvUluzauyQHkF2bD7LLRUCViID1f+PqPTj7jI2k+h1Cw0hC
         WXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682375637; x=1684967637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3dxvzFGuNd+GK1v6Xpewb7r8h5x3GkgpfQza5pdVPw=;
        b=k646APjPwaD1G3RjEinsseSRYuFGOCx3k8mhL9dF8DohF2sQMYcpZnRNaIG0uDqXki
         K2NBZgQ11wP9wTKOlegz6NoukfFsJX9YvyN9JKi6SLV2V3WX67tfPH6xWo/KlbjqfwIV
         wA2MuBtom+2p9fBQbmm9dOD/WDoIUXT6Zf0HKF11S/CCCDhWdveobYJDf0tChcKayDz8
         sSxNPZ9F7HQttGhH6+xvsyzvTaqS2qEzS7WPVnXK3IY9mfRYA1rMRYwAUYlCajh/Jr3w
         kzShNdpcwuadSa1Q9co4Wo84GcDfrJigcdmXDjZyDqBPikxaT/aXJWdi559jA7/PUxgD
         IYZw==
X-Gm-Message-State: AAQBX9fpFEtth604SxwlGAa/cAsjLkDuth/xacQ1daqQYyHOr1/9ELHa
        qAQTDX06Rm6Wvr9gJ2+Dhs0=
X-Google-Smtp-Source: AKy350beUI3p9M6Or7yAtNz9byVmSnmVIVdWMbwU8v2ZBuSfWZ3APT+O/On1fsh4YcztShdIYMRsUg==
X-Received: by 2002:ac8:7e81:0:b0:3b8:2e36:9d24 with SMTP id w1-20020ac87e81000000b003b82e369d24mr27467565qtj.50.1682375637161;
        Mon, 24 Apr 2023 15:33:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id dt9-20020a05620a478900b0074df7857e72sm3892003qkb.34.2023.04.24.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:33:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: add missing cache properties
Date:   Mon, 24 Apr 2023 15:33:53 -0700
Message-Id: <20230424223353.4018682-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223208.115555-1-krzysztof.kozlowski@linaro.org>
References: <20230421223208.115555-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Apr 2023 00:32:08 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   bcm94908.dtb: l2-cache0: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
