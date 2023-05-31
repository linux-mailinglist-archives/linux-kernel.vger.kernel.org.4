Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE2718F40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEaX4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEaX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:56:01 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A62B3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:55:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bad97da58adso227203276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685577357; x=1688169357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffeGkCCxmZRXaX7kleQQatpanGiTdKsdCLgHFebf7mc=;
        b=MDCGoRZhkbFSyrwM+BZajfxrFe4migeTv4EwyyMQbeTVfPN+J52+EtQYEbLRGR6rQH
         2HeSjOG2CjZH03dICRBEuxiVmb+dvvP6HYD01cLmS1ZUL4G1qUtPZxgep5a5UlcULw/z
         yJo5gpfkvRak7iZaAFq7+T2NH7ze2sYHDCYCIcuaIe4vHibmamyNO2NmlysHjFKhABdP
         jx7b8Ae700tfB1aXArLg4Z1/uv6msoICNXZwZeFEOz+psstPKtkF3Y8+DlPSM0TF9LDM
         ZmC1v7yrzKgLQmDy71Caka45zQ/f4FXWukeYn1nInSs/2N1+lPLy6YRv/k7uwxpKdvXR
         b3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685577357; x=1688169357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffeGkCCxmZRXaX7kleQQatpanGiTdKsdCLgHFebf7mc=;
        b=J8F8+tpm6Z0XhZPfFLiNCjJJbgsLc4K9xyYBQlfQdJjoobxUSnr3AXamSWeeccEUUs
         SGccArOFnUn9dc4ezw+g2ioGL51dGOtAomlhl/bqY/uoaYo7wI3ZhGswlfXGOqn23WcE
         GSsHRsbV/qtCdrV2Kq6SKXrO+1Xbe/quUODYZglBpdRp+MfUpSiPPRirLUr83Etw7e0R
         N98N7jH+MivGYZEZfSL4/ZmzoepiFI+YIWQEhmPSERIg+csGL4X3dM9BWFZWnNBv2CDo
         1+G/dtY6qeyVNGG8ztkGPRsQil77/3xBhVxJdwbDNptHylydH8R8phtKJ70keMU5eOwz
         lntw==
X-Gm-Message-State: AC+VfDxmsauul+EBvoJZ+VHwDRppvSaUAfxH9FJnhm+A/QEsZzJpSnSO
        kaA4EmDsPm1MAwxx6PqXGAMRbw==
X-Google-Smtp-Source: ACHHUZ6njTT2rGRvIomrKde2z8U6i+z2vnjrl7WjICXc5t40i/G594dgSjmvG2Pa1k3fizXXmWDSpw==
X-Received: by 2002:a25:264b:0:b0:ba8:4859:3eb1 with SMTP id m72-20020a25264b000000b00ba848593eb1mr8234829ybm.42.1685577357054;
        Wed, 31 May 2023 16:55:57 -0700 (PDT)
Received: from leoy-huanghe ([156.59.103.123])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c25200b001b042c0939fsm1969251plg.99.2023.05.31.16.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:55:56 -0700 (PDT)
Date:   Thu, 1 Jun 2023 07:55:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 0/5] perf tools: Modify mksyscalltbl
Message-ID: <20230531235455.GA132356@leoy-huanghe>
References: <1685440265-7021-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685440265-7021-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

On Tue, May 30, 2023 at 05:51:00PM +0800, Tiezhu Yang wrote:

[...]

> Tiezhu Yang (5):
>   perf tools: Declare syscalltbl_*[] as const for all archs
>   perf arm64: Rename create_table_from_c() to create_sc_table()
>   perf arm64: Handle __NR3264_ prefixed syscall number
>   perf arm64: Use max_nr to define SYSCALLTBL_ARM64_MAX_ID
>   perf LoongArch: Simplify mksyscalltbl

Either in my mail inbox or on lore site [1], it only shows up 3 patches
but not the 5 patches.  Please consider to resend the series.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/1685440265-7021-1-git-send-email-yangtiezhu@loongson.cn/
