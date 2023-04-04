Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDC6D5560
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDDAFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjDDAFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:05:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934BF40E2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:05:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j13so28837293pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680566738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8biJ1aBbukeLfwN+w/+0iRNiLUjgXR0WEnlqTCaXvw=;
        b=ofZA8lpTuIEsN+GsDqWo7mVL03MfT9lddpXOb0ihcNjz7Y9WqKBNVtSy8hdZOTQlUD
         gZg4g6Un/Ent8M6oUc0GdNsxAwDgszjkyxwKbnYhX2yc27TBdOjzoAxlfY4fdLUFo10O
         EGWRQ4tE14OzGgMYwRiUccsMJqhYcMMWNXPQBQHfKhQ/Keu5Q7G2n/G4hQ1T/5aPt0Ki
         +mYREkN4bUD0FHkFrIX6PhrvnrVRl9PI16qDYtKYULHPmeJJMqBn9qMmnXr/iOg3BhcG
         o/4IDrPzHiHL3QMzKF0QEIIDDqOMqh0+QnOKRDJUW8uDso0K7gwF5OPEAczflC0pYbYN
         6wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680566738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8biJ1aBbukeLfwN+w/+0iRNiLUjgXR0WEnlqTCaXvw=;
        b=r14rI3yTGzKyTiSB2hHQ4fPosqS/Djad+M8IBVA1GTvg7yFUvGTlf90ykaXxRPmcaU
         1/9Vk0kK+nsTb+nGZH63NAqOcZyg+kMZeiRghoUbfPwhnr2U5PFFbAptc1K7RNQGsdSa
         5n2Kx4QBiqGsJnzXID5tvITJUJ1Wqs7FmtMAuCzS2aiY+e4++AiKhLWHr+EJjGge1rWf
         0+4kEzaGrEYiSXE5X0qjRP4nO6Z8xAlXjX2j3DT+HSqxfCcGm+v77YFeLzfdJ8SVPTiH
         Cgikt8P723UJNJBKu/h+wQhASvxQXb17RtROULniyICZdTqjtvUUQb7xq8lL/jNK1i01
         OSlA==
X-Gm-Message-State: AAQBX9dFPCLyZSzWbz4K96XMhl9IXnaHNGstZ60sfca+G7asNU+5UmMp
        lj6F5/iAHZfthys+QCfQEeKbeg==
X-Google-Smtp-Source: AKy350a8EOWlE6/ey6qlDm4l3M/bElNRWs6BENfSo8Yhhz4VqjfFZVoicQqCKM9Tl+bt2b6qzQPHBw==
X-Received: by 2002:a17:902:f545:b0:1a1:a996:feb3 with SMTP id h5-20020a170902f54500b001a1a996feb3mr1094215plf.26.1680566733293;
        Mon, 03 Apr 2023 17:05:33 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902864100b0019c61616f82sm7098625plt.230.2023.04.03.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:05:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <bero@baylibre.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
In-Reply-To: <CAFGrd9qLzcDJO_Fk_-B6XYuuxQzQoYLXmdp0Qj1Tszr0-sqNgw@mail.gmail.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
 <7hy1ncydtc.fsf@baylibre.com>
 <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
 <CAFGrd9qLzcDJO_Fk_-B6XYuuxQzQoYLXmdp0Qj1Tszr0-sqNgw@mail.gmail.com>
Date:   Mon, 03 Apr 2023 17:05:32 -0700
Message-ID: <7h1ql0y0j7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> Here a build-able & working branch with dependencies:
> https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/amergnat/i350-evk-board-support

This branch doesn't compile.

Kevin
