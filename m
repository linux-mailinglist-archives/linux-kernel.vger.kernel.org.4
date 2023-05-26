Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5F712194
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbjEZHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbjEZHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:55:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03233B6
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:55:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so2950505e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685087748; x=1687679748;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpL3uEFDFKjWPCzPHepbX3dXRR3FC7vQMJr4NbW5aP0=;
        b=ZsmckDA7LsnkaxJrVK3tmKlQynqgJmjjQExD9NUJJQWMHTIEwcW7losOa7i2BN0h5I
         MEZcxabmfA9WXWfq8eiIf3i8TL1R64xlt80d+FDLftZwo9jhgZBNHFHObX/A7IF//BZa
         riuWVfy40aXz5gv+TbtkHR2uHquyS/5Y3+BVFhqYXN5gR0AR3tGoxA1Kv7i2wHfaOrpc
         +fCC5wU5n6Lu8YhZZbMTRFaQkxHpQpahFj/TDlZddjgCRznjBebeDAa1l0xXBReAofdA
         Yfv69f24tLTyzQHNVeRQUPEYB1Bam7qfEm+9L4GJkwMpH/O/LQV/17HO3n218QgkTFzF
         wruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685087748; x=1687679748;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpL3uEFDFKjWPCzPHepbX3dXRR3FC7vQMJr4NbW5aP0=;
        b=WDTXvO7jf7MOwdKa0AegXHej+GwFQ6Cbw0ViW+de+tCKoSwj5hSlfWo14+eQievm2G
         r1GiOV4UVygeDXqXtXK/w66UrZBxMYlL4pniW27etHr+WW92uafLFNE6uCHnyQcB1tjF
         /6SKMPH79/+8ZREax5fwRcZmflMflpVVNVazDXwLoCoPumRIyn4AXu5ZOWt00Bu+AUh+
         /IUfgZV63g17woXwAInb/QLmLu/lJsryN4RnQ+P0AOYSBhr+Tj/ifRvVqr1vl/MEDoCW
         LslN8WC8FzScvyy8bIqnqJRxIH3iR8Vf+HgaNlQ5wg7L3w+denospYaAIic5z65YdxUs
         aw7Q==
X-Gm-Message-State: AC+VfDwgHQL5mkiKAuHayugnlJNqLWKiHG1fZKQocDdWsiqobLuxrlIQ
        w60VSemH4PcxlfescgJScmmRjw==
X-Google-Smtp-Source: ACHHUZ6z8AFtLFz0PBmEeCqM+0XShGQbQjRhgt9gvT+iqFu5g6ijXhOgbPWqkWX/pxyhC6PMZxcd7w==
X-Received: by 2002:a05:600c:283:b0:3f4:2897:4eb7 with SMTP id 3-20020a05600c028300b003f428974eb7mr901242wmk.38.1685087748449;
        Fri, 26 May 2023 00:55:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n14-20020a1c720e000000b003f4b6bcbd8bsm4390597wmc.31.2023.05.26.00.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:55:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20230516085039.3797303-1-dario.binacchi@amarulasolutions.com>
References: <20230516085039.3797303-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] drm/panel: simple: fix active size for Ampire
 AM-480272H3TMQW-T01H
Message-Id: <168508774745.1495117.6907071154193975716.b4-ty@linaro.org>
Date:   Fri, 26 May 2023 09:55:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 May 2023 10:50:39 +0200, Dario Binacchi wrote:
> The previous setting was related to the overall dimension and not to the
> active display area.
> In the "PHYSICAL SPECIFICATIONS" section, the datasheet shows the
> following parameters:
> 
>  ----------------------------------------------------------
> |       Item        |         Specifications        | unit |
>  ----------------------------------------------------------
> | Display area      | 98.7 (W) x 57.5 (H)           |  mm  |
>  ----------------------------------------------------------
> | Overall dimension | 105.5(W) x 67.2(H) x 4.96(D)  |  mm  |
>  ----------------------------------------------------------
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f24b49550814fdee4a98b9552e35e243ccafd4a8

-- 
Neil

