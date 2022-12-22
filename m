Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279F654666
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiLVTOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiLVTOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:14:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64D28E24
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:14:41 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id ml19so1823983qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJNaFLC8BKqHDga1qfAWPtgnMSOxG5YailbfsAfU+ik=;
        b=b61Hcf9HQ4PdKZUPZZLS3zdovc4g6u1yYBjSZgqYu6QJAjBaXfM3ZQUO9y8930Wl8o
         5VplkZ9Tddes/053LAXLBP2Yeu/xoJFUXi0nNmXuIWvwOum0uE6dBYUiwQCYUhLt0vi1
         6nttqcTaSWh1ipcrOsn2D42Af5+OwmrLsWf2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJNaFLC8BKqHDga1qfAWPtgnMSOxG5YailbfsAfU+ik=;
        b=2xaPNoBi7NpAF8g4Faca+q8v4tg9f1eLGtlxcCSvzmaPWxx/89QE/i4z8rJIrHg2GJ
         p5ylJjxcq74tGAyab+I2j5/Vqgshf9K+Bmi4mo0XnlwN9LvZoeUP9DDCKktuJ5yCRPAG
         aiN961i1TIlmV02K7XxgRYnIxSG7z0J5Y+eFQxHLydhPBFjVQSMluWYyD91qBez+/5hb
         NjH4cp8nzNHiu3bj4xDgn/HjO1iF7AUxwh7HcF11v2dkc705eaOyCs6ookLPWW2fZe9y
         /eg2YtWjhcCVaXQSxV6sQtf1y2pJrnoCynCa6VXe8cb8XpEWW28mjtBMTIqn/5AH15/l
         NRAg==
X-Gm-Message-State: AFqh2kr0SyMmCUMEm0ntL19Pa5WC1TgG+tGIkKamDPMxbJ/Xk5eHsXzR
        qqCo+Ppeiv6B8MED93XPWQJom8FTQioDeQuX
X-Google-Smtp-Source: AMrXdXsNJnluQyExlIdtp52abknVeQ30AnN3FW9DeVX/GsX+Sx4FGD3xKT+M/ObzVK4JclI0Dd67WA==
X-Received: by 2002:a05:6214:5b04:b0:516:d25b:a5d5 with SMTP id ma4-20020a0562145b0400b00516d25ba5d5mr9529413qvb.16.1671736480192;
        Thu, 22 Dec 2022 11:14:40 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a449100b006fc2e2198easm806135qkp.95.2022.12.22.11.14.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:14:37 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id a25so1363709qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:14:37 -0800 (PST)
X-Received: by 2002:a05:620a:4720:b0:6ff:cbda:a128 with SMTP id
 bs32-20020a05620a472000b006ffcbdaa128mr277409qkb.697.1671736477239; Thu, 22
 Dec 2022 11:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20221222164914.508929-1-acme@kernel.org>
In-Reply-To: <20221222164914.508929-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Dec 2022 11:14:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4u5rpaPrOokekEg_5Sud=8SZhA=KTALXNOC_S89jKBg@mail.gmail.com>
Message-ID: <CAHk-=wi4u5rpaPrOokekEg_5Sud=8SZhA=KTALXNOC_S89jKBg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
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

On Thu, Dec 22, 2022 at 8:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>         Please consider pulling,

I have pulled this, because it's purely tooling.

HOWEVER.

You are now on my shit-list for violating the Christmas peace with a
pull request where most of the contents were not in linux-next, and
weren't fixes.

I'm PISSED.  Right now I am in the mindset of "I pulled this, but I
never *ever* want to see another pull request from this f*cker".

Get bent.

                    Linus
