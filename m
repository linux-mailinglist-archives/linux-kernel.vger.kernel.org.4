Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B531562FBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242159AbiKRRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbiKRRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:40:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E920BD9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:17 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k5so5097599pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI5MC5wPkQQeEE83qP7tE3SCFpQYK/xq9Ol93cnM3VY=;
        b=gFc4SfbZvgjlbAJ650Ar86zoxHOUfORQSyStvBp17HLK7lxP5lrqFPd3H7gr+4Ayt6
         Ud/yj2PxnUbWSfETvS7Ohq73hj+K2B1RLD25ZA1swwLA8JwR13Oz7bR/zKNnRBV69dr8
         1vERiIK/GLorWogYSmx2pdLuuNxPbKoaI/V+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI5MC5wPkQQeEE83qP7tE3SCFpQYK/xq9Ol93cnM3VY=;
        b=uMW1b4E9hnN6bL9SvAMN1ukKOAdhvjCRjhrhMbaEIn9dwIToqR2cda+sA+wGB9u8MF
         mvlRx8y4XppX0+jsMFswzeGKpZ3CXavcB9Z5rvc6PtRwQlaOGqQNIMOQv/HiV2ftbhT9
         J1F7StJg0xW3024/MBenRmlkEPNlaPlwkB2MJij4bmRJPWZZkhlAmWF3z7VESdnGF80q
         5UnZCvIsqRLhXVZtOf6l/Kq9msMGLTEa+28WFvRv7Tv9d7maRUlvHtjhO+B99ZU8GswE
         tIxMjPt51FUAErJACR/D1gPv+wBJaFnMgf7j71v1ArR7K/k/jzMEQPH2FH5RXiMBOXqE
         2eTg==
X-Gm-Message-State: ANoB5pnAB3wqCcuwI4MQBeWkQEbSYlbLJFIX8jul1XKLafto/Q+Yv0/B
        E/FVhdmQU3esQ5shG0tHGdW2jw==
X-Google-Smtp-Source: AA0mqf7FFavVCClOULx9pEedXB/2PA+q16XqUjZI2216vnXrk6B4HMcy7q6rcPKHBlGCFkt/8m95FQ==
X-Received: by 2002:a17:90a:7885:b0:20a:d81d:a8 with SMTP id x5-20020a17090a788500b0020ad81d00a8mr14555998pjk.177.1668793216603;
        Fri, 18 Nov 2022 09:40:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001885d15e3c1sm3992123plb.26.2022.11.18.09.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:40:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     nathan@kernel.org, alain.volmat@foss.st.com
Cc:     Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        trix@redhat.com, samitolvanen@google.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ndesaulniers@google.com
Subject: Re: [PATCH] drm/sti: Fix return type of sti_{dvo,hda,hdmi}_connector_mode_valid()
Date:   Fri, 18 Nov 2022 09:40:02 -0800
Message-Id: <166879319847.2080862.11821072640113889089.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102155623.3042869-1-nathan@kernel.org>
References: <20221102155623.3042869-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 08:56:23 -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] drm/sti: Fix return type of sti_{dvo,hda,hdmi}_connector_mode_valid()
      https://git.kernel.org/kees/c/0ad811cc08a9

-- 
Kees Cook

