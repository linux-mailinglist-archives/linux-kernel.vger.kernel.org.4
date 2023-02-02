Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA71E68899F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjBBWUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:20:35 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5661D6E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:20:34 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x4so4160028ybp.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGcZobRTdH/JxXnU9+WBJ4Rh+WSSCFdcKJ2+1POHNc8=;
        b=qj18/+psCD8U249ZAMhJdxVzTrH9/NzO0ysNy7vc4Z5Gz8NyY7dofSKriHP/IYTedj
         v4xgASQ9lHE5zMbriwpfxz2+/caVXXxnoPj+xNeGVLTkNCzjOK95aOt0zdqdUIn27Kzp
         GHkYLsggyKsWSpc8gQ34mo10ooRzMLHHtGn382SGD4SvEDzY1/FRa86CbCI5JlpnHL37
         sxJJtP91lYSRR9npj20Q4g23YeYG22G7RVuYs+x6whRgNyDwaJDENkYUdMzppL4PBqR9
         2KhbNA1NvOtLHR9FuawBtmbFOM6fpphf63/OP1kk47ztnz8PjFtPaYvb/HWqhkuGuwXe
         cuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGcZobRTdH/JxXnU9+WBJ4Rh+WSSCFdcKJ2+1POHNc8=;
        b=nb6Kr5Pn40nC4JZ4rVCh26CuB884jtAYD5vBlNkmY9tuI1Mp9SPl5YiuV9IFNV+hWE
         8A1p8msVKXVm+EKzAhKcU/5PTIRBI9i482g5l1SuZT6WTZVACwvWFLdx8eBInf33tE7f
         6R9U82Y/y8jpFvTfyCq3/Sbb++/8cnus/FfpltXOb5DP56RdlDP2+o/Iagu6r4qI69Nh
         KJDSIoidpyr6ktNR/laV862ZAO9ZMq4JjnCbOsAWN9cz0Sq1UOhPlDPH6SfveLlsZt/8
         P1h6fiXJ/ofWKNNK/9tn/6s4/aKvGw/n3ZtlkzxzvRFcxx2jeDItKrgOoDubXtOEu95Q
         VYwQ==
X-Gm-Message-State: AO0yUKUOyl+tz3kOdW9DowTXK121QGfej8JK5g7WJgyDM+FIovKwHl8t
        a1fuHfnBTBuVsQ5RT2e/KXqOLixnwqFRqEwbJmwA7w==
X-Google-Smtp-Source: AK7set8e1FAip5uCDI4KXqLOBcMrFExpDUcB0oVoLeXIQG/31VIhhFAXhZPv/eW2iatFYpSbsSsL6OZP8uElMyxzkmg=
X-Received: by 2002:a25:5bd6:0:b0:80b:66c5:9fc5 with SMTP id
 p205-20020a255bd6000000b0080b66c59fc5mr980309ybb.210.1675376434121; Thu, 02
 Feb 2023 14:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
In-Reply-To: <20230202143305.21789-1-m.zatovic1@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Feb 2023 23:20:23 +0100
Message-ID: <CACRpkdYSG6zuqyd9W0f4HgwzD2S9dLXv+9Scg0NYWvoPdf8LHA@mail.gmail.com>
Subject: Re: [PATCHv2 0/4] Wiegand bus driver and GPIO bit-banged controller
To:     =?UTF-8?B?TWFydGluIFphxaVvdmnEjQ==?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        martin.petersen@oracle.com, beanhuo@micron.com, arnd@arndb.de,
        avri.altman@wdc.com, iwona.winiarska@intel.com,
        fmdefrancesco@gmail.com, dipenp@nvidia.com, ogabbay@kernel.org,
        bvanassche@acm.org, mathieu.poirier@linaro.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
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

Hi Martin,

the whole patch set looks very sensible to me, I see there is still some
DT binding things to fix (it is a somewhat moving target, so expected)
but the whole design looks very sound to me, so from a GPIO point
of view (which is a minor thing though):
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
