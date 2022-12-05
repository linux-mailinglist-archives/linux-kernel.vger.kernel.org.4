Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0E6436A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiLEVOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLEVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:14:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA32B183;
        Mon,  5 Dec 2022 13:14:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vp12so1525435ejc.8;
        Mon, 05 Dec 2022 13:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwCLtcgRqAXaeCXVskNsfVzWFdvmdwTNRfhMMyafH50=;
        b=nqQlU52LHVuHNQPy2g4cmtI6I8xJfVlddc5Cndp6VOX+HVh2EkEYhxu163qni6ouO1
         Mwj/l0vXDKR/1cOLAx15GYMJIJeWgLY7W0GlvO5o3u5Llo1w/avJNuL06Mk5QbLT0n89
         0W4dHN/bvLUQcSJIY+q+UKLPPcvPza2BteC4yR8BQVaWJ6WIU3GvSB8NgCNhcj8MKMhq
         6BgHba6QKO1BiVEySKfWE7bb4AypaCyelEODU11KGIr+6NjQv9U+0NtDPxRy1L5wkwH1
         f3onqe4vNErYXuJJO21En+tjM38OvqryDqw63M67bttvMlZ4BeZQjF9bDxdI9WfjrCaZ
         M0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwCLtcgRqAXaeCXVskNsfVzWFdvmdwTNRfhMMyafH50=;
        b=wYL3W/tlFvzaN/iy4PV/6ROxTlHcLN56Gy6Zl2ipvk4hhTtpjjPXXxV1FUfXG5uVqb
         LG8rYvHXISYRno2njkUpid6HHvHaYwBPCaeyeEOk+2VJ4WIiTwGLyVyylrKLNZUSfd40
         zGQBUjwp5qLik7CdmHzwA4UNgW70S0Dc4xOUHOvdwtKX7t7i+9cG/ejMqtCLptW7V9oc
         ueND+pVtxJW2vuGqyZlVkPxiws+1BYAXUtMKgHVJEwufmW5haDoaGHdA9SvRw4kt+dlt
         kqE0G/CioCYhwppgyyoA7vEo4j9GanUmawUj1I1qMGwAYi40WUg4DPtlmT330htaWe1y
         +KWg==
X-Gm-Message-State: ANoB5pn9RxV/Jmj0ibRvL8mIIG+6Qsc/AoN+z8vwJp7Wl34xYDzZStwP
        TuLBWW1XMn6z5wec6Nd9K4AWAQcyZpOQvA==
X-Google-Smtp-Source: AA0mqf527m69tsEGmdPutWKFPV0Jzva42TA/gfB89ypPw7CMGtIYrCgOUwTqqC3WL5n8OcaF1Bo5QA==
X-Received: by 2002:a17:906:524b:b0:7ad:a030:485c with SMTP id y11-20020a170906524b00b007ada030485cmr68688048ejm.605.1670274859173;
        Mon, 05 Dec 2022 13:14:19 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ca13-20020a170906a3cd00b007c08439161dsm6631006ejb.50.2022.12.05.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:14:18 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: fix ccu_mmc_timing.c kernel-doc issues
Date:   Mon, 05 Dec 2022 22:14:17 +0100
Message-ID: <4105181.1IzOArtZ34@kista>
In-Reply-To: <20221122184844.6794-1-rdunlap@infradead.org>
References: <20221122184844.6794-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 22. november 2022 ob 19:48:44 CET je Randy Dunlap napisal(a):
> Use '-' to separate the function name and its description.
> Use '%' on constants in kernel-doc notation.
> Use the kernel-doc Return: format for function return values.
> 
> Fixes this warning:
> ccu_mmc_timing.c:21: warning: No description found for return value of
> 'sunxi_ccu_set_mmc_timing_mode'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


