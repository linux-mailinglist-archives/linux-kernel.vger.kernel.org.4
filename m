Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE55B4A68
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 23:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIJVxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIJVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 17:53:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738E2DAA9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:53:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dv25so11914932ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6L+PSUGxbdCi19Kzp6BZonN1w/q5i5nMluVZJC+p5yc=;
        b=oA2uqROCT54LhRWj64l3rPm7M+LihrVNBFzDjQRtmDzhEdFWFV4yuo1+Z6N1ScH6T4
         lpvp49uyil2y0E3VGzSNhkZempJXL9Fm27zi352oAgdwpNPZYl8OD+dG0soJ2O88lpDu
         tn91F4x2ZI6SBLyIx6SzvkwmHsqmeTgN97WBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6L+PSUGxbdCi19Kzp6BZonN1w/q5i5nMluVZJC+p5yc=;
        b=h5njFpv/x2iPAiSOaKtrpcsWBfUQsVI612/HhpNEyrpEW51Fmd2qkIVUwcs/4bL6Dc
         ttzsbcH4G2ESfIYXmkBfQxEYwASQyfkllhj/mDeZvdggO3mYms/778hlRUZav1d1jX5q
         7W7fbb8eqHux29ePlTJmi7LbRYF0Yza+DWXkM6GbyPsY88AcM4lCCN+phPco3uCTGYQQ
         ZQL3xwSk5JC/HE/sJVbbe9O5yIK6pMIKXPhc9n3zdrJL9+qUQ02mndOqZLxxzO7oXdnQ
         bSkrlIujgl04dOkWFIFu/aZYR36zOo3FvmjC3kfxeMjrTKWi+qKsapDpFJPkbSIBL7M+
         0rMw==
X-Gm-Message-State: ACgBeo1t8qM482zECdjgBd9k2v9MRRu9rLYbc3l0y7+0Zoh11E5lhTYR
        3tiZ1y8Cjqaw1k8NTkyr+aMzfnQhQbNryJO8
X-Google-Smtp-Source: AA6agR5P9xSySJQIy3uMARM/IRa+332fOaE3CYn35r3jwbhJKQCpx4Pke5XTkP/kPWDWNLCGpgyqyw==
X-Received: by 2002:a17:907:25c1:b0:77b:9966:ccf1 with SMTP id ae1-20020a17090725c100b0077b9966ccf1mr2321308ejc.763.1662846822118;
        Sat, 10 Sep 2022 14:53:42 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906301000b007306a4ecc9dsm2212030ejz.18.2022.09.10.14.53.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 14:53:41 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id k9so9221672wri.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:53:41 -0700 (PDT)
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id
 r2-20020a5d6c62000000b0022a2f59cb7dmr7792616wrz.405.1662846821172; Sat, 10
 Sep 2022 14:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220909102720.v3.1.Ib599a6001558a4afd11016e7016d74dce748a749@changeid>
 <20220909102720.v3.2.I22ae48d8ee064456073a828393704809360c4368@changeid>
In-Reply-To: <20220909102720.v3.2.I22ae48d8ee064456073a828393704809360c4368@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 10 Sep 2022 14:53:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMJRU9hSXUT7Y47xMku1kAuuTap9xhjWt541GOzhvy9g@mail.gmail.com>
Message-ID: <CAD=FV=WMJRU9hSXUT7Y47xMku1kAuuTap9xhjWt541GOzhvy9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] input: touchscreen: elants_i2c: Add eth3915n
 touchscreen chip
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
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
> The eth3915n requires more delay time than the eth3500 when poweron
>  & reset.
> Define EKTH3915_POWERON_DELAY_MSEC as the poweron delay time of eth3915n,
>  about 80ms.
> Define EKTH3915_RESET_DELAY_MSEC as the reset delay time of eth3915n,
>  about 300ms.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.com.tw>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Just to be clear, this can't land as long as your Signed-off-by and
"From" address don't match.

-Doug
