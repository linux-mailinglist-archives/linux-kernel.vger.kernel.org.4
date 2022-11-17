Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BE362E0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiKQQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiKQQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:00:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8E22BC6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:00:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q1so2317858pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WeXWqGLnMnk6uS6XkKZbr/nN6eSE9M6SqY0Ycssq4Dg=;
        b=PUS4jdB+kqWabwXwuFg3VjIMIsjSVWnik9vZDbsjJ3S1YGa1A0mdY4EFcfp/b6wuGh
         Ie1KuTrSGuy3q5hBbBuzlvOccif2bvxxDOc9HUdwaZGkJ/m1FCTNU/F/Lwur7sySFogt
         7bsxtUyXBWZEloqP4EJfIpcUMlwYfpoUG1U809+jrJJz0lEvRuALyH5zjAtAFay7O06m
         C0sXM/5WIRNwcqda38DQy0Nt3Q4fXMJW7YCBbgJnJZq7O8oHh+X9nOiCXqBLFBWm5A5l
         nyTMBLMX3J4q2JJRtZPFlaefYqgthHcxCByWo2u+7v+ulBnCHcFiehT/7c9oJxUU6F38
         ykBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeXWqGLnMnk6uS6XkKZbr/nN6eSE9M6SqY0Ycssq4Dg=;
        b=grRavQtO97jRQ+cB+uSrucCPJgwwbhWl0bfcRWUL6T3M1p3k/S1xXje7SpByvP1qjJ
         gVWp7Zj9PAwndvxF6Z8yeApGAdsQ91Vk5JX/ADjRq3/DeOj9yx9Xamhrlfmtx66B5ZB+
         k+wXDEzyllzzmHaHU+FZnt7grT4HDfPzrwGWugT/GCD0FoiYP0N9e1keCJcOVjgBRJvj
         Iwoy+GlpZeG/72SCR5t6SreHfZtCeDM2aidTux1USPF9Sknz2geMTxmpvdNk8tyiTigZ
         hcivnJlQHSTiHghJnH24xA7/dexqNWnuBx9WMJGAyLurp/OCQzMgtEU4EztFFn2VJ6E9
         AJSg==
X-Gm-Message-State: ANoB5pmSCLZMM6GCH6SXytF9PfPbXybaWeVTs0VmCVPVWX9zKagpq2KU
        i3rU3RewCU/ZEKZ0AoLYlJa1Zg==
X-Google-Smtp-Source: AA0mqf6xLyDPJpFM5ANLVXCIXp6GJqaL+20inLmVRY8uVTrkvctosjsvdu8xHT0YU5iw6N0lZNtYZw==
X-Received: by 2002:a05:6a00:f92:b0:562:317c:2a8 with SMTP id ct18-20020a056a000f9200b00562317c02a8mr3664989pfb.49.1668700840241;
        Thu, 17 Nov 2022 08:00:40 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b0020ae09e9724sm1040623pjb.53.2022.11.17.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:00:39 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     soc@kernel.org, Jerome Neanne <jneanne@baylibre.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com
Cc:     afd@ti.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 6/6] arm64: defconfig: Add tps65219 as modules
In-Reply-To: <7h5yffamcf.fsf@baylibre.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-7-jneanne@baylibre.com>
 <7h5yffamcf.fsf@baylibre.com>
Date:   Thu, 17 Nov 2022 08:00:37 -0800
Message-ID: <7hfsehbmfu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Kevin Hilman <khilman@baylibre.com> writes:

> Jerome Neanne <jneanne@baylibre.com> writes:
>
>> Development boards from TI: SK-AM64 PROC1004 include the TPS65219 PMIC.
>> Add support for the TPS65219 PMIC by enabling MFD, regulator and
>> power-button drivers.  All drivers enabled as modules.
>>
>> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Could you pick this one up via the soc tree?  The mfd & input parts have
been applied.

In case you don't have the full series in your inbox, it's here:
https://lore.kernel.org/r/20221104152311.1098603-1-jneanne@baylibre.com

Thanks,

Kevin

