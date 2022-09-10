Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E705B4A64
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiIJVxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIJVxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 17:53:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF82DA94
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:52:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q21so7573931edc.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1PPWCbKXlEnu4f5Y1l2ZGcr26PupHUMW55EBs/BVMPw=;
        b=jafaxW5FyQ4KBW/ss0lvDFQS+BytcTlCthxnY13MDRI2O751HlCvxQGZRO58po3QOu
         jBNoL1p04iABMzEsXUW+UewQmoEVE+zAtBnAxFa7/StgjWqJO9sn/z3XQ/FUvyImetKI
         45JNjteSQ84/waP9QAb74Id1C5s1XmyAS1kpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1PPWCbKXlEnu4f5Y1l2ZGcr26PupHUMW55EBs/BVMPw=;
        b=lWm65YrdxWOXEI08gAWBTfLMX8Dg9nckjUc4ht5AtTU7H5z26a8NyjjZwD97h9ZC/t
         9phZo3DGRLlIddkusI2gSM95F27weA7kv9SjrgHVN9nr/6QlRRRF7IWo99upJp1MFll1
         CUsytFMBI1kUEjs9w+28YzHcT5Yb3ztZ3P5ct+tykAeOE3iy6MzI9wR258fwcb3K+FXT
         VzoqCHXYWsc0xH08SJ85YcbLIBes4oR/lTPisJ0Re18dPVRwCHN2Hw0CnRW6ZiTNZqXW
         A/bao1q+DsAGeK8NKg3YzL9Ku8yOgKTiqDv2QS7dRXPDNhjimctOHM2ECP3SgX0YU7Wq
         DL2w==
X-Gm-Message-State: ACgBeo3+Kckyn//FMVO/HPE5f8mwynRLHHQ42P1lchJ7Q3reIr6ZYfdc
        iMeRWtFAzMsHnR8mUShB/zQy41UADWxlYKss
X-Google-Smtp-Source: AA6agR5ZjGhOJYCp9pfGewvL1HBjYGLinRipXbySO8FBMCfqgozihAJH2Fv0px3SYlCM2zwhC1DDpA==
X-Received: by 2002:a05:6402:35cb:b0:451:6a0a:6688 with SMTP id z11-20020a05640235cb00b004516a0a6688mr2288015edc.415.1662846778138;
        Sat, 10 Sep 2022 14:52:58 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7db8a000000b00445f2dc2901sm2808354edt.21.2022.09.10.14.52.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 14:52:57 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso4394773wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:52:57 -0700 (PDT)
X-Received: by 2002:a05:600c:548b:b0:3b4:61f4:804e with SMTP id
 iv11-20020a05600c548b00b003b461f4804emr4580041wmb.188.1662846776956; Sat, 10
 Sep 2022 14:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220909102720.v3.1.Ib599a6001558a4afd11016e7016d74dce748a749@changeid>
In-Reply-To: <20220909102720.v3.1.Ib599a6001558a4afd11016e7016d74dce748a749@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 10 Sep 2022 14:52:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtJ_UJkXJkMY0Ma4Fum8Xicqiv=ZX5QCJ=woL51VjFxw@mail.gmail.com>
Message-ID: <CAD=FV=WtJ_UJkXJkMY0Ma4Fum8Xicqiv=ZX5QCJ=woL51VjFxw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 9, 2022 at 3:28 AM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> Add an elan touch screen chip eth3915n.
> This chip requires more delay time than the eth3500.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: David Heidelberg <david@ixit.cz>

This has the same problem talked about in:

https://lore.kernel.org/r/CAD=FV=XEkPfU9wjwGrp59QJDAspUbWwmOTSZfE1Y5PWt1w309w@mail.gmail.com/

Namely that the Signed-off-by and "From" address don't match. You need
to fix that.

Also note that neither of your patches indicates what changed between v2 and v3.


-Doug
