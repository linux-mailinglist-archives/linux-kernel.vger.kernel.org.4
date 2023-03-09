Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFA6B1F51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCIJG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCIJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:06:36 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E8DCA5F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:05:52 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id s13so646234uac.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678352751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v8gsX6vrStQeUsH5rKVIzb0ItwKWklQ0bcioQcBInIM=;
        b=EIqqh4WUJAtlIJKJ771rFSqQgKiSfrYcZLZHwsUo1vvE8JiE+4QAXbubHsVrGOdnSL
         5euNxBsrcXw8gcyvMmkmuinOIEt68oVv2COdPyy89xisH3eOUc3Wo199eFiXikoK9+Ql
         WKcYH8AqYwihfM72j7FWRBVxFU5GUN46CEC/sjfZDRsUBJg2OZP4XIyCoZL62zhpxQ5g
         vqOow3L04f+6laqkMm4gk8ZGShc0kKYuJIii7HBe9W1zY4e/rTKoEJk3PqOyeFaeT/B5
         gXQVked/eG/Dru+iA/ReY6JUxlhho5xYorDo5Imc1JKxfau9UvIt636C7WWRY9Sy7tQ8
         mYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8gsX6vrStQeUsH5rKVIzb0ItwKWklQ0bcioQcBInIM=;
        b=8NBozjegDoIOaB9FLf0dqcFtmNAeEv03MCvUSNboynXLQXXAaJjaARAzar1wW7buqa
         ZCDPwxzeYzfkaZxs87wiFPaf/tzi+tNqjSJQTnwY/9Tnh3Oc0KCObzw7qhq0JO/Vja7w
         PYNsuM/8epVFZiU5mVVxulq1kkTNvqQUepPreukwWVTuYAZjYcPvS+A5VGIiLWJKP3fq
         KrPbokYLTZxvOqCSPiFvZtwL5my5GeYjV2EO0lEjjA+JbyuwOqXarUuVwbsL2PuqL66m
         7o8lxPBasZhkUT7Xj2/0DWLLbihoECxpPlE69rTf5BstpuwRno9SOtQwYoMTKcUhlRh+
         1+xg==
X-Gm-Message-State: AO0yUKVqo5nipldmFYONnRnoD87IoxQZ+ufPX5GZ32y7cVHMexiTjKhz
        5wo+2ZExfS8bOFuEycT6VXni2opCxL9SRtWEXkj9mQ==
X-Google-Smtp-Source: AK7set82OSvQFONVJyN8LBKOpbv2PUhiDRWDVoZ9Up/z/SqG1ikX8WNfSePirnax3JBNhUFcGRz8w7Dqf2d6saiDLR4=
X-Received: by 2002:a9f:3001:0:b0:68b:817b:eec8 with SMTP id
 h1-20020a9f3001000000b0068b817beec8mr13953524uab.0.1678352751125; Thu, 09 Mar
 2023 01:05:51 -0800 (PST)
MIME-Version: 1.0
References: <ZAhkQUmvf1U3H4nR@elver.google.com> <20230309005831.52154-1-haibo.li@mediatek.com>
In-Reply-To: <20230309005831.52154-1-haibo.li@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Mar 2023 10:05:11 +0100
Message-ID: <CANpmjNNw6utf5ozpwu1keDG92Ew_vL6B=LZoRw12p48eVJeNnw@mail.gmail.com>
Subject: Re: [PATCH] kcsan:fix alignment_fault when read unaligned
 instrumented memory
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, will@kernel.org,
        xiaoming.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 01:58, 'Haibo Li' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
[...]
>
> The below patch works well on linux-5.15+arm64.

Thank you, glad to hear - may I add your Tested-by?
