Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59BC651895
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiLTB6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLTB6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:58:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B83D2ACE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:58:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x2so10782685plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 17:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwWABKvuFP4RgmKS9H+uBuAFTn5t+z05sqc7dXE4FnI=;
        b=WlxZAD8qAm28cyRXiJvdf65gW9mHlAcE5IzwgdaHfa9fKNhIKBJThlEwzMwfjOWQlf
         DsD47j/ZJYPxxNRlrv0CGcok80iKMWlmhVX6yGbP1YoDxDb/1N1wXHKSjZtW1rRYDVHQ
         1yqsVlKncERtngYYNPrJ5v/PGG20EvMmK5KEG4v5maJboXDfBzwkcvJZR5tNxYdyyLMh
         kaKU8Hpzc8oP6zHLHwZiG8DIXSxqO6CUhE+oVk6d1AbFTGAN6/LevE/I2j5CqI/xHCUi
         8Ti1T3ai4EpQq4pfE7oEFWu7GhIwmVx9Z/ECxH2Zuk/8sM4k/wvHdVU0k86N2Ya1MUzT
         LabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwWABKvuFP4RgmKS9H+uBuAFTn5t+z05sqc7dXE4FnI=;
        b=has58mbJcJpZu4mlHsV4qtcmc3nWslXOViec9en/1a0sOP01r7Dc7GozqlHm2//T81
         TBQ1P33uHhJpg5ivCUX0rMsKopWVR0gMKHjQ34r22yltih6I3HiVEQvjZnVItL0DTxiF
         0TqYe2RNLOj+mFSWR2Iy5nehLZXh/ViM7BZpx8CM3nK0Qj6LqZCO8ICV54S5GCoKKUdZ
         FtMFJlpcAeBCmGK5zpbreOui5gDVnsPrFDRRc84cjbqycvX9SEZF4opeh2kUpQcLiSBF
         W+tvLUieTNN4j+NFq9DjvwCrW+FtCSdfsIZttZW8iRdtXLdOTdCNNE+jbwYqPz8xN2rQ
         ileg==
X-Gm-Message-State: ANoB5plGCOS/Mx8e1hWVYX6Uc7aFP5ykLb2SnRS526uSxoMLdkXgBOEQ
        qY/CsMIbEKKftzXI9uHdk3xzKQ==
X-Google-Smtp-Source: AA0mqf7TEFRuP19SHHJukzG4DJ/R9b3xcfnbq9/jCxFjJgqXPnpx7FEw1hzVVUm8h1VO1jj3hM4PuQ==
X-Received: by 2002:a05:6a20:4d92:b0:ac:16ae:f46 with SMTP id gj18-20020a056a204d9200b000ac16ae0f46mr51694192pzb.15.1671501485512;
        Mon, 19 Dec 2022 17:58:05 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id e35-20020a631e23000000b004784cdc196dsm6975692pge.24.2022.12.19.17.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:58:04 -0800 (PST)
Date:   Tue, 20 Dec 2022 09:57:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH] perf: makefile: add .DELETE_ON_ERROR special target
Message-ID: <Y6EWpXikuoxLnajU@leoy-yangtze.lan>
References: <20221217225151.90387-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217225151.90387-1-changbin.du@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 06:51:51AM +0800, Changbin Du wrote:
> As kbuild, this adds .DELETE_ON_ERROR special target to clean up
> partially updated files on error. A known issue is the empty vmlinux.h
> generted by bpftool if it failed to dump btf info.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
