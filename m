Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1CF5F7177
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiJFW67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJFW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:58:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D712BEFA1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:58:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so3103657pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 15:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=T+CEJtAZnc2GDDwSotfE8CfL0V8jiLrzM2Svg4iqZbA=;
        b=lzW3h+esCqFARjrEX15yJhjZ4dUujUjSo63SEh+Gd9Hw06dXzzxu/mRMzhqPUKF/1R
         jOhJIK5SvJABZ8mDY3j2KzEew/lYbq6FPmlK8+tblrLGJSyYuMxxic6041/VOaENWN/1
         U62zUdkEYscO06AFI2cEx3KHvI4IRt22TiLIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T+CEJtAZnc2GDDwSotfE8CfL0V8jiLrzM2Svg4iqZbA=;
        b=vPm3i3Qn6RklnK/xvWqxRDIbLKu7wJ+nQkizxA1r85QK5iJpCx8CnkjBEsuhC6ivVb
         +rylRkygLGMaoj68exaX2HgONh8KK2WGgF1LYj0FCpIIf1yAgMfXJVKYZcqz+kDtuJaI
         +/aDNXvwhW9/cUQbHPu4PqqQdTWLi//CutgpYNvPWZOYtxP6DEOB2JS7aEJk6pTRZs9o
         9TBnffFlohP56Rrvyt2PU/OYArTYwLEeqGPJgr3zO9gXvnU+yivSkWH7dRn7ugTuBqHG
         ZWJ9d7ey187LrtqEH0EHp5Q+0dk5E/YY8mrvF5y72p8xsDLNCgX4EdGr8wXVKExl3Ig2
         hEWA==
X-Gm-Message-State: ACrzQf1bxD+x3xSIZau7Dn4DbCKStYgyAwTUkNfwsI8mOdKVLC0m8SAv
        Ksl6cn9v6Ntn2wYnZ4iAu8imMg==
X-Google-Smtp-Source: AMsMyM48onVK3sX9oSAQFX+6F3BL4lSX22t+n/J4JFWx2rOMFeagXp1MqeBXwVCqeM+rdUEMBqb9tg==
X-Received: by 2002:a62:4e8e:0:b0:54a:ee65:cde6 with SMTP id c136-20020a624e8e000000b0054aee65cde6mr1979233pfb.42.1665097135729;
        Thu, 06 Oct 2022 15:58:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b0017f5c7d3931sm118936pla.282.2022.10.06.15.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:58:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org, dlatypov@google.com,
        gwan-gyeong.mun@intel.com, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] overflow: disable failing tests for older clang versions
Date:   Thu,  6 Oct 2022 15:58:49 -0700
Message-Id: <166509712398.1833114.15283539764161050044.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006171751.3444575-1-ndesaulniers@google.com>
References: <202210061321.xSA91B7C-lkp@intel.com> <20221006171751.3444575-1-ndesaulniers@google.com>
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

On Thu, 6 Oct 2022 10:17:51 -0700, Nick Desaulniers wrote:
> Building the overflow kunit tests with clang-11 fails with:
> 
> $ ./tools/testing/kunit/kunit.py run --arch=arm --make_options LLVM=1 \
> overflow
> ...
> ld.lld: error: undefined symbol: __mulodi4
> ...
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] overflow: disable failing tests for older clang versions
      https://git.kernel.org/kees/c/2d4df670c64c

-- 
Kees Cook

