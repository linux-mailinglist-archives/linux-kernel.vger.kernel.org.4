Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6849F717B99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjEaJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjEaJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:17:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25949A0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:17:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so39999145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685524664; x=1688116664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7AepgM+CjOnswGlLxaNY+jm6TytFlnAe++3Sm4Kqp0=;
        b=MPGBHzPR4C/6l9q3gAZjvYeCTIQ+vM+3e5c9e697to4TKyYpcn9hdK9Nop4Wq1A0aW
         24ptlOq10d/IGVGWGTiSwEdk8zYLBGYlG0W/iEw57zDAK+ThmwbISHO1aFU49Pu696qI
         ssJm2Zncrrn1lrT8n7tBpo2uaz37qGWVZPuamfMYLQm1W7pJBZaa6aPkpGxY1PwpvgpU
         TthuJ8sQvDiTaDYLs5SOJ/Rz10kfJ7Yr+E7N4wKKRDzTLL38aw3DpNgtHNqXgZldWV/j
         sBdoC+NSmVod3ETLxRovw3v9OhUoH5jC4KdR6RciePveV+ILQixh9SLF7GsXfX0DoLS4
         nxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524664; x=1688116664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7AepgM+CjOnswGlLxaNY+jm6TytFlnAe++3Sm4Kqp0=;
        b=RKcBPtbyrMHtD/uSYLFTyV+qK86cObG/e6XPHy7C2ihQknDRI6nSWZkS7xmqRsMqJN
         0rbjIVwcIQmaysbAkXoPVxo2gEJldcRU5DF40spEHdfVUXU/ijpyvwEdwvCM2XvNHUtG
         GyhP4FUKTgDyl9VZqVg8AJOoj35tNfq8NBvMXVaIFGQzVQdAS5q/NlfKkxVAjFTixL+x
         LJG4rSVB3e4vgPn7jUDQAXcHV1HYE4SkEm1qWqmD84UHbu+U1RXt+I7VO8pognu9F0Yi
         9+FYoItCmvOgn3CTnCrIqqqXYJpqNpBQJQUDUauNOR5fWczssxVzD2v831o4kHhKSinb
         zTQw==
X-Gm-Message-State: AC+VfDynQahtSph2uWvH7pREPJebg/pztzSqqI/Vv2WclFfs16TACeqd
        v/AYKiz307yqYGHAOFTmSX0TeA==
X-Google-Smtp-Source: ACHHUZ6NYp/JcTUWk5/h2fZGRs3qgogtaSb/m+zj5/YDtdgc2Asinv1mNGaNQIRU3GHgUOrKUZDBzA==
X-Received: by 2002:a1c:f615:0:b0:3f6:2ee:6993 with SMTP id w21-20020a1cf615000000b003f602ee6993mr3303330wmc.4.1685524664560;
        Wed, 31 May 2023 02:17:44 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003f3157988f8sm19683981wmd.26.2023.05.31.02.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:17:43 -0700 (PDT)
Message-ID: <7c1dc6d2-f87d-f577-82c2-92c17105e032@baylibre.com>
Date:   Wed, 31 May 2023 11:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] pwm: mtk_disp: Fix the disable flow of disp_pwm
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     devicetree@vger.kernel.org, jitao.shi@mediatek.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230531031001.7440-1-shuijing.li@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230531031001.7440-1-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 05:10, Shuijing Li wrote:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

