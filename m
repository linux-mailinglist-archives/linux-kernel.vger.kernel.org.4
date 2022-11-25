Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D66386C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKYJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKYJwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:52:16 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A424B75F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:50:08 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3a7081e3b95so36754657b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrGPbt7+gFrjOqTTDVA9r8HJGdi2ZWQrKu6kob6wExQ=;
        b=HSxmUv5FKMmGGgQMiYABH+USehR8qx4VYLZNSXjSsNxFAYaLigsuYU2V6FTKkuXQGl
         VjUj99v7MF25itLp1fwr5PfVEzjdQ4PCztIiXL7aoGdpVM80JTx55W18b2YAqGihxOJl
         OPITq8Cir3YtTo8TbQhCq3SaEBsJKz+58uO7hAskLQqpxND60e8DOJhrzQhkVed7M4oP
         JyZ6Tng/432MbYrAkyO4lG3PesKgFSXtjtz0RH/R9IzOt3GJmYlXZEy6mcLveDDlueuR
         yx9dz6QuJNuihbZJA50hb1m04nn4CQKK3PkQtCOy8vDoMt8tjB33UG+bjZR3tbCk5gDa
         KiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrGPbt7+gFrjOqTTDVA9r8HJGdi2ZWQrKu6kob6wExQ=;
        b=NswR3h1kjYamXQRSrhjx47UTieFinnMC1ta+rYtTzPtDokZaBMuhxnwW0XnMs9HdkX
         maEk3VrIZIiuOoZICLGDv5Whl2d+us7m0l4xmK4Pw5XnE012/8XjSPCmV4p0C0j2Ink4
         wF381bPB7oWn9u+E9JrtWkTHjvRX0A9pjSdRaGNmCJ8Y29QbLFWFTfEfmK5UuJV7IJC/
         wK/53jCGFWomxBv1SWMF3xFUYYDq6W0c5ykqO97VB4eBhs+Lxmor5q0KWg1oE/k6o9ov
         old/+707wwzaEfOQwowoHyg16tl5m44t971Jq8lTcnMPOkNn4k1bTpW66ocXaqx4wo1E
         lw5A==
X-Gm-Message-State: ANoB5pnasew3K+8YukaQVtDopEOUdBwdMf0llY5nyb5YDdmoN51SupxF
        1ltg+mbVs+jb6wj9d/mKt/SMop5DwUM6pZEXTiKYbA==
X-Google-Smtp-Source: AA0mqf7NzqxiaaTwio4jRdufXatY31p7/C26EagsRuZljFpGklR5KE44ICliG3SEX/Pe80fHYGnghxMK1CMzmjAQCt8=
X-Received: by 2002:a05:690c:285:b0:3ab:189e:3465 with SMTP id
 bf5-20020a05690c028500b003ab189e3465mr15273059ywb.343.1669369807253; Fri, 25
 Nov 2022 01:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20221125070156.3535855-1-zhangpeng362@huawei.com>
In-Reply-To: <20221125070156.3535855-1-zhangpeng362@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Nov 2022 10:49:56 +0100
Message-ID: <CACRpkdZ3XdKy2EXOTA-NdAvYa+7DOBB8rH66r4FExjjFPZqTuQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: add missing of_node_put() in pinconf_generic_dt_node_to_map()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     baruch@tkos.co.il, ldewangan@nvidia.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 8:02 AM Peng Zhang <zhangpeng362@huawei.com> wrote:

> From: ZhangPeng <zhangpeng362@huawei.com>
>
> of_node_put() needs to be called when jumping out of the loop, since
> for_each_available_child_of_node() will increase the refcount of node.
>
> Fixes: c7289500e29d ("pinctrl: pinconf-generic: scan also referenced phandle node")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Good catch!
Patch applied.

Yours,
Linus Walleij
