Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7530C622582
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKIIcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiKIIb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:31:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E133209A9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:30:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v27so26110539eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KEosSqcp4BPkxkVKDaVPG2cOg3OrufQrszZfeTNLmc=;
        b=zZmIPn5inLCawgf28H3rXNu/bzYowjBolfcRIChBPh/LhhzHeu+kFXZPCF0kcT7RSl
         wxLJA4npAvs3vEkaiGN8QFRtF3821XH16aWQ+zh7hivDJwrTEODFxEesXuv/p/9C0NmQ
         U0LHjfvxr8RHSrnGmC7MScFJp7cQ59BsVZ+zhqBFSzz0dAyBt4yoM3dToLoMTTFTtUPc
         BzjmkvL1qnx7RJAOt3kOuw838pvjOQYVYvEWAUffecoH6sH8VBVWBWTe8tY1g8nAuw6i
         r7rvsoweIabQCnTrGWDiONdBXbCSrR2HMpPdb2ko5QrP+YJQkwgJLkoGHlyxDxyZh/aO
         CwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KEosSqcp4BPkxkVKDaVPG2cOg3OrufQrszZfeTNLmc=;
        b=dr98kXp6JGitisC1N8T5IAFGrYyx0mEwR3LfeGzQbjvGlBh6mUqTKRG0Pk/rfGt1iP
         iB0C2hupu+ahoTmY5StT/2lzRR2aBligWmw7ADew5ZMO2jmRTH0/mX7S2vNSzLZPVc8Q
         DPe3G60b3Nlx89Ho5ISJw8P1wBnhftl6dJpkmi5OPAe3p2Utesw3tViKL6ggPXFnAfIl
         ff8+y0qRbIvYGTymYVyID1YKQqkRfURve6WqZsTyP5UAPAST6CBqYg0GEIQqEAGNk9ET
         j7+72tfXLoHZRdjhZ0/0Teghx2hhOFimMzWfzRw9nyhWuGiJENI2N67ehd5lSsh51idv
         AAKQ==
X-Gm-Message-State: ACrzQf0PPAeHLFVxwRiQs0C/QxL1p1L4UExmV+6rzUCdYtPQAeo4SSIb
        /p0HJ/uv4U0RpZhGeNmwJ7XLFuzg+UBPxXAgan31yQ==
X-Google-Smtp-Source: AMsMyM7IN2FtSuX/WH4eODp1gpontwnXe64B3dbs+WawXshFYIcrLqgexXQyR2mZRH85H6+17W9sVEW+IlYHRt0xAD0=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr59294762edb.46.1667982615144; Wed, 09
 Nov 2022 00:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20221109061122.786-1-zhuyinbo@loongson.cn> <fc52c692-4cbd-e5f9-2e62-d05b5330052a@loongson.cn>
In-Reply-To: <fc52c692-4cbd-e5f9-2e62-d05b5330052a@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:30:03 +0100
Message-ID: <CACRpkdbu-gqNBK0=L8pOr2TwYGOv2MUvFxzYiBNfJ5KyJT+A8g@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 7:42 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> I had added some changes in these series patch in v8, please help add my
> change and merge it into your tree and sync it to linux-next.

Yeah no problem, I took out the v7 version and applied this one instead.

Yours,
Linus Walleij
