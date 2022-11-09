Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63076623124
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiKIRMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKIRMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:12:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DEB175B8;
        Wed,  9 Nov 2022 09:12:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a67so28102749edf.12;
        Wed, 09 Nov 2022 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdpCW3bc/jcdSgpgyyMyHoNFC6KThem8jvb+gK7E5/o=;
        b=pK9msVoQf50NdtWtpIXXlkZrHnEWpyZYXzAWvx61omamtFI3Hu9csIWT7JT3lPtr6E
         QGSVrULPRqSRkC5295UNjb4Gj8EQfoiyRJWy4+k1lbfY3c+22OIoEXc8g5nfZkTV4heP
         CXGhOI/q36uLYf2xENguFOUu/oWcA5n9klh5vf3ixcoi7oqg8fWj1iuiHvZUESD8GI72
         bVYpLNx6PFAsGOn1FOnCG2r7EG9htj4Y6vpzkNvjTv+gp6Fp0BmTBPh/RGvEOKhUe/5q
         8gzhh6JPDz2Vu7+kUIww4/c0yjxxR6qdfrdHw/AMiZhMOZkBBCYzloy6WHOX63huRt4j
         gyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdpCW3bc/jcdSgpgyyMyHoNFC6KThem8jvb+gK7E5/o=;
        b=CQcKR5t8BBP4mTonLq6vl1ESWGjpJi3HSBBrV8R8V9wL0FWyLkvcdZuCrtAeMDlqPm
         Kg5Cch6RCmaVeqzyH65XrgaorofQqGSEd4qgm0WKxT6VOcCSn5rNxa/FwxwMbigMs4aC
         cHVyUskuP+E5L0ndI2IZY9glwhKjtTfuzFVOKO8YCVgcjFOuKos0BLJ69C/Gt/TZfHXC
         N3I+YVIxgC6Fl+XBnK1QXgL8VPoJ17b1sYOkgBXHJ8VnJ46A9+eR8BXiakf46L+w7rQh
         SojEYN347fC/zYleGQb7JqK5IP7f2oZWIwtOLv6IP7WrdygVCb7uBUboKFOzFHS9urwm
         XdQA==
X-Gm-Message-State: ACrzQf338NCmccskH+xJWy7hAB44r+nCoKgRX5Bhq2prpF8HDui0bJFX
        J+LJvmBRhznvETXoBi0Hyh0=
X-Google-Smtp-Source: AMsMyM6EJMzUY7rLwPusiIvQLOBzAMFWUGe22HwzXfwYL4gg165ptAUE1ivXgSZer5IhdM6K1ztEtg==
X-Received: by 2002:a05:6402:344:b0:461:7d4:9c9 with SMTP id r4-20020a056402034400b0046107d409c9mr62045783edw.141.1668013934364;
        Wed, 09 Nov 2022 09:12:14 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090632ca00b007adaca75bd0sm6154098ejk.179.2022.11.09.09.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:12:13 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Wei Li <liwei391@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Correct the header guard of ccu-sun8i-v3s.h
Date:   Wed, 09 Nov 2022 18:12:12 +0100
Message-ID: <6441491.G0QQBjFxQf@kista>
In-Reply-To: <20221108094335.3597008-1-liwei391@huawei.com>
References: <20221108094335.3597008-1-liwei391@huawei.com>
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

Dne torek, 08. november 2022 ob 10:43:35 CET je Wei Li napisal(a):
> Rename the header guard of ccu-sun8i-v3s.h from _CCU_SUN8I_H3_H_ to
> _CCU_SUN8I_V3S_H_ what corresponding with the file name.
> 
> Fixes: d0f11d14b0bc ("clk: sunxi-ng: add support for V3s CCU")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


