Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C800C65C8E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjACV1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjACV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:27:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDC1AD;
        Tue,  3 Jan 2023 13:27:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l29so38705128edj.7;
        Tue, 03 Jan 2023 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hI++6uIbF26Dv21ktmycrREOIYmnkQTNouNNFxSqlfs=;
        b=qPrSO1WIAMiJ5FKOT9prYmL7H+27c9enK7XuCZQ7HivgXev8EZXQz6Duw/9LGFXYDR
         cuc1iHeqJJl9FNULBQnqVye/l3ryzZDT+1OVA2zlT16WpaEPdp2OcSWPWPaRQyXEqY0a
         qglCzpQm745f+Wk+aMLxzBHA+ch1UfUc9aDv9EyCtbDtenZ826WGAbTnG+Bz+/rQI+Ao
         dS0bq03WlJmUsFIMqYb+p+8eMuD9604TcnsryhKKkly8y+luXWSMbaskrf2VzoeWFbNl
         AR95IXWLK0Z54rPTZNzU1NAReSRHQH5Ke5iOJzn0QlAPSxqVqgBIplarraBlZm/7M91u
         BmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI++6uIbF26Dv21ktmycrREOIYmnkQTNouNNFxSqlfs=;
        b=u2edPfnX89+qRrWhOrvnt60bSSVR1Nea0ovwFW1osEyNATPRxwVRb51j6/GtOlO/XV
         yvq/ztbnlBLSDyU2ybjb4DcPgqxpRoHUNn6le9twgtGBek+s6pSvwFQHDiS50GbXq8g3
         0qh/Hq4II1oVMBMuSRCQh25p9G7IMMu7M9I8ePClI/PkEjdO4+iQjIM4jczYtkUzf9x+
         KWXC/ofgcf+BOCtWu/vJbptZPgnvuStgaDSRfhlSnXSMcakaYHzzNhpuJYBsOOxiMbNP
         pDsuoRcV9YzciCPO+Q4Tm5mspb1r86iPaT+T2AJRIXte7a0i+SF8Re1ppywC0YbtTw4N
         AqNA==
X-Gm-Message-State: AFqh2kqRIeVUcBBJZVKepv+LX26sv2nwlqipikewc12GNAhr+tg+uTnD
        y70mZ2DiEwm88NPMQfRQdfxAjkmuVNvLRo/tgYc87Q5c+rQ=
X-Google-Smtp-Source: AMrXdXuJemt4sp88WTvGhdf+4KvtqJ5cbVdF/C+z4wNNbIlxAEEXB2Sy9U3/SYnwiNVv1ddufGwzbM4BmyLoDiCFIPg=
X-Received: by 2002:a05:6402:120a:b0:462:2e27:3bf2 with SMTP id
 c10-20020a056402120a00b004622e273bf2mr4566144edw.13.1672781228785; Tue, 03
 Jan 2023 13:27:08 -0800 (PST)
MIME-Version: 1.0
References: <6c5948373d309408095c1a098b7b4c491c5265f7.1672490071.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6c5948373d309408095c1a098b7b4c491c5265f7.1672490071.git.christophe.jaillet@wanadoo.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Jan 2023 22:26:57 +0100
Message-ID: <CAFBinCAPY3s4w5MPvyP9Y8Ov_eKVWoMu8fJwvmbn6r_+Qg8iLQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: meson_gxbb: Use devm_clk_get_enabled() helper
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 1:34 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Thank you for this patch! It's:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
