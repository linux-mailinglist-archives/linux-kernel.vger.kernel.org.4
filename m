Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8B5F2424
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJBQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJBQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:48:02 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D43BC65
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 09:48:01 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-132555b7121so1709005fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5V7YZ0+ktOu0SHwnyBsCm3AdNDong6F+vrNbNuM7bbY=;
        b=GEQDDsXx2bge0DbF+SFb3vaHrAyzfXxiAkg3V+Zu1llwesowMG/IJKGmQuv2ZgYrI5
         CMk25nDEeg31TeM8AyU/+rd7U4v4y3stdw7RNxweY2d3CO6fgWT9VDHyOuRiI1ZV6bML
         H329wGKu+mzO7JT5PQB2bj8yFSW+krdM6hvI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5V7YZ0+ktOu0SHwnyBsCm3AdNDong6F+vrNbNuM7bbY=;
        b=E+iIO3qtnLBVWDNPMlqr8dUTvF72uvFJlSrbd6YaCHsVt2L3lr1+tJGkEU8LWLIhxH
         IcmaqILKmUy9qWQdRqQ/OxSmvIPkP7UgZVgN1b2IQHR7JDZ/pZ/AV+0386TfWiZ6pHNb
         O52ICLMBx6SzRfL8NoKkr+K3kAqhvMOUvhFWQmEV8zWO52LefF0ZVeygBVva4tqJBhLY
         SrBakx2J4l1FwmBdO+2AnuO5T/DnJnKBlcCIoeT7OwFRkTb8JMo3rKIk0cWAAJ4lRsNE
         NkJRsjgDiJy2vNqHx1DJfABW6iMkZx8PWSML3GG0hagpSKGk8Ss00ODfKMM8S+H2HF/h
         J11w==
X-Gm-Message-State: ACrzQf3a6cs6gFp9fSI3Rg5ULgl71lqUdHgcqHOXAEEVs9ZzxRgugTtF
        zVesh+IqO3kwu5u3QF17jcbYpANqUbniaA==
X-Google-Smtp-Source: AMsMyM7ZHiIQnHCCF+Xr1uxemVjZGGmMynAsNIoXCtNYm/gwvhujLhHH1iLQO66BangzC7FA8EKM/g==
X-Received: by 2002:a05:6871:98:b0:12c:8f0d:c868 with SMTP id u24-20020a056871009800b0012c8f0dc868mr3509366oaa.295.1664729279317;
        Sun, 02 Oct 2022 09:47:59 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id l3-20020a9d7083000000b006561d30cdc2sm1916338otj.23.2022.10.02.09.47.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:47:58 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id n83so9449013oif.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 09:47:57 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr2698976oif.126.1664729277363; Sun, 02
 Oct 2022 09:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <YzluYmeYjbxCr8wd@gmail.com>
In-Reply-To: <YzluYmeYjbxCr8wd@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Oct 2022 09:47:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJUKa9+7t7XdJskKjADRe6XuYc1ZvmTSfrxD+470AiSw@mail.gmail.com>
Message-ID: <CAHk-=wgJUKa9+7t7XdJskKjADRe6XuYc1ZvmTSfrxD+470AiSw@mail.gmail.com>
Subject: Re: [GIT PULL] perf fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 2, 2022 at 3:56 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Fix KVM guest PEBS register handling.

I wondered why my diffstat wasn't the same as yours, but it turns out
it's because I got this one from the kvm tree earlier.

It all merged fine, just surprising.

            Linus
