Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC46391AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKYW65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKYW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:58:55 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F5611A3A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:58:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l11so8124565edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zrh33fKX0AFIpQoDMHBkz3JckH2DUhXrvzHY5NCN5no=;
        b=mQdoKuKnzMEl3ts3gcoDtpsH6y8L7YdGJz9PaUC6jCAz9+M7NZkUnA6V6SqAhznP7Y
         tSFx861pQR1oB+THa/q9XGELxGpmBvcUQmUyvfoFAlMjWclqOJDRddY3FyBqzZQmhMpV
         9pefcrcTsPH40Gman4KI9NLTs6tpUVgF3+lfJMMavgurXtira3YpuBzgwsJINgNYY00x
         1WIvktfNncDKhZXOODC7yW2xvwJBbrpRLNYGcIi5mTstd789NPUD4Y9hgC90cjfFgssJ
         wUTe7DcnjEEwXUvKfzW3MBmGThfDDE04xy3diEaIcefXRqYa7/FREMt7YIEu4h9XvocU
         GEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrh33fKX0AFIpQoDMHBkz3JckH2DUhXrvzHY5NCN5no=;
        b=7yRCA9jIObW2VE8eabbRTINat4+WXm+2MqWsbDqYKEZvVjMx37EnhJpVHleM2EHat6
         2NxZMruRRyHv6/AsYv8raJ2gk69jdA7w7Zw5b1JELozdsHt+ybp/SG/SfuzDePc3ajA2
         IpQfS//Cux1zxKtO+96avTjmKQCuAwaNI1DqTyB9c0asCe1lmNMgtgsKGdSiaCpbo2wD
         bkqTTrMFeUbwbJNOk4ZBR1jm/1egmTLC5j7Pdga1NcQlPKbirisxeBy6WyMZrhXzBx+6
         DUIHho8E3gxeykv9Hgr7rCNUxs3P5jPzcemNIeBbga6dmOq+QARRIss91l53dXj0byya
         aMdw==
X-Gm-Message-State: ANoB5pk7SEAF1SbtY2zfgZxDlGd5hDN8Yv/d8aeHTi0ZbXU9quSbRHUW
        JrJ+RpCYEDdlfdT4R96qTF7/syIHMbrSA63jPAQ=
X-Google-Smtp-Source: AA0mqf4qEx0qk48E7n/igXoN/8ITAy2dKB3urhN+QYQA7vj8vY/aA7c4YoItihhZk+R2xjYeYeLMIUoiVHRlbku+l4c=
X-Received: by 2002:a05:6402:3893:b0:461:b033:90ac with SMTP id
 fd19-20020a056402389300b00461b03390acmr25787621edb.257.1669417132710; Fri, 25
 Nov 2022 14:58:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668602942.git.mazziesaccount@gmail.com> <a2f0835e8d3b5f5768d887ce47a1575ae11b19f0.1668602942.git.mazziesaccount@gmail.com>
In-Reply-To: <a2f0835e8d3b5f5768d887ce47a1575ae11b19f0.1668602942.git.mazziesaccount@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Nov 2022 23:58:41 +0100
Message-ID: <CAFBinCAxL1WapkjHo6B_FNj_r3Y0jZ6P7qmXPjWfGK-ivuT5+w@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 2/2] gpu: drm: meson: Use devm_regulator_*get_enable*()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 16, 2022 at 2:03 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> Simplify using the devm_regulator_get_enable_optional(). Also drop the
> seemingly unused struct member 'hdmi_supply'.
Personally I'd replace "seemingly" with "now" because hdmi_supply was
used before (although only in this one function, which makes it a bit
pointless).
This is minor enough. So with or without that change this gets my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
