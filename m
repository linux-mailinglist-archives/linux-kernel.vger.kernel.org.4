Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C7681E25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjA3WcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjA3WcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:32:05 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650582DE43
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:32:03 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-51ba4b1b9feso6417687b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skjZ7zrvUldsqxQv6fmmWTawDIpJ/RoIfn/nYqoiZWo=;
        b=QEXdNuQ5hEhdsUEfuwdYpdcQhRoLW1LDmoXD0oDISEYinsMExRfUf36mW72+XcfUII
         5LNaCLyDswzhEuTzgX+WblZ1/EPgqFJ8F6dpm45eX/5xfN85/ZP0aNBOh+uy0JWhSde7
         zfvUQNj5WrrsMkIblZ/s66loaAFhIgWSOLZbL3TAdrd215HVVV4A1i1q2MgUtJbN2sOa
         eFg10oQh+JY5wP7JrRmblExDjUIL2fhzNKw+D7PbLkcIXWAv2i8per83fJ+whffB024i
         pZ9Tkwtigo7SXwbV5bhwzK1ct/53Zj6YUl1sNnkb5KqP8FtCg6t84j1AV76Fti2YLfNA
         zBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skjZ7zrvUldsqxQv6fmmWTawDIpJ/RoIfn/nYqoiZWo=;
        b=5ZZyhujYA326halvLOCsByhUmef0IEVrWMCfInFtWzvOhciA3WlEwZzzFcQQnto1ny
         KiJKjDDQ5YhO2VGNLy7XbFhPa55oScvfZDyL79jNnN7U/jEQFeN7hluYyXzqvvDCIJCv
         aa/I4e6nGRRrbW7UFj1h9V12UsPmDJjrPh9h0DZ5MPFpttmwLZqZZGa5nQPTCQ7JQnT/
         MebznDn0sIeUaqWpKNJkK83jvKP9q6RrA/8/5WBrwP0lHWW7Xmydb+6OtiNxr6rP8/HC
         C8Rv++CU6AtZS+G9v42fICtxgQI1AztNSL1oCr4G7SeHoUT+ZejrorykdRnoA/aslVMC
         CvzQ==
X-Gm-Message-State: AO0yUKVh0+smfg+4MWaN4h9r9fboMovc+Z978+oJfIXDPxmC70FoVIBW
        eaTxPEmhutuhysnhjbGdk7Jitp93Jh0le9QvNi430g==
X-Google-Smtp-Source: AK7set/ouXAVankrNwYj1xEQDazhfSPde9attbZo+h9D0l5ir656lWUIhIQ+1oQuF+L7x/AYiQCqqerKSFPkyPayHpk=
X-Received: by 2002:a0d:e701:0:b0:506:66f5:fd24 with SMTP id
 q1-20020a0de701000000b0050666f5fd24mr3154161ywe.130.1675117922613; Mon, 30
 Jan 2023 14:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127181244.160887-1-sebastian.reichel@collabora.com> <20230127181244.160887-10-sebastian.reichel@collabora.com>
In-Reply-To: <20230127181244.160887-10-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 Jan 2023 23:31:51 +0100
Message-ID: <CACRpkdbQfaCX=ZbFQh3p_T3biWEex-QZofXTrbVKd5hYOzMAug@mail.gmail.com>
Subject: Re: [PATCHv6 09/11] pinctrl: rk805: add rk806 pinctrl support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        shengfei Xu <xsf@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 7:13 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Add support for rk806 dvs pinctrl to the existing rk805
> driver.
>
> This has been implemented using shengfei Xu's rk806
> specific driver from the vendor tree as reference.
>
> Co-Developed-by: shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: shengfei Xu <xsf@rock-chips.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Is this something I can just apply? I haven't had Heiko's review
on it but it looks innocent enough.

Yours,
Linus Walleij
