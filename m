Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599E6AC38F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCFOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCFOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:41:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFAB279A1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:41:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cy23so39382626edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678113697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qmumDQ5xHhb1nsDe4w90chyWCa+4iJ1hJ1sUP+qMbw=;
        b=HYuknRk3WiWcSuVxdgZr7IuzWaNpgellgpTqoRpk4T2VpV/HhCDm3UdBmISkRI2MF9
         AYKE8j0jKRqZHrupjy0KrJBUUAAtAj67TLXy75hMCLJR5j/wN4EhamtWh/RjsyUHGfCX
         lr4SAMPYe7o9ti4TuGSaGZbMMXgEzo4CToNBaVbw2s9SFJAQKRwKZyxGYv23MoJR31IL
         CYhn0u/090i11GMgAnI50zv4ydBbXjKTxjDcQDV974GjVe0Hx/kW92bSLnpHPJQerXui
         /QkMAqaN+wnuvbjFR98RbwiIL0oCEOKo5KNTCU33k+18Trd422A9QDCKjx9TDfP8EGcV
         zprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678113697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qmumDQ5xHhb1nsDe4w90chyWCa+4iJ1hJ1sUP+qMbw=;
        b=N0jYPtOkLMD9JHIwQD/3ugXQCuOT3e5eDzVjBgxSD+nFtXeJza6NDVpNqBaLvGq+3Y
         bUfcLJ2Vp6P40utEln8qN18tTpSRv+IlzcSF5i2MLZ+GFVVeIybGU8kUg/mjWELB16UI
         dto+nMhUlUYqSn3D4ogPWWlu0yePXdhG5tPB5hnlW4sAaNml51OU7oeeYWsBd/XnqtHf
         r190beiN8+A6hZjW+DDp0AXtUqtQzUt8iw2bKxtNnRRRvxbO1kNaJccCy+1Uet+gWuBa
         Q1EJXjVBLRXzbnmL1goI8l4omOLDlkmfWoV2K2pu14u/AN5jU8rLnuAENd4z1KfRGTZl
         lIog==
X-Gm-Message-State: AO0yUKXOL9bCZSA9gq/Gwz0mqBzoQt6j0uugzjzXflF9NuEaDOsL/1+p
        ppKsN6JRYskABv/1grERs/ddNFlktJ8MqDySkIk=
X-Google-Smtp-Source: AK7set9Fpbk62D73iRfBEKdGRoPrH+hCtWPYEz16g73QV03ih9+05TnqoP4q5vPLshJDuqKD4lOXNg==
X-Received: by 2002:a05:6402:1503:b0:4ab:553:75d8 with SMTP id f3-20020a056402150300b004ab055375d8mr9945972edw.10.1678112892860;
        Mon, 06 Mar 2023 06:28:12 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906a38e00b008b8ae79a72bsm4636763ejz.135.2023.03.06.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:28:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 17/27] memory: remove MODULE_LICENSE in non-modules
Date:   Mon,  6 Mar 2023 15:28:09 +0100
Message-Id: <167811288496.11610.11937459322909682733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224150811.80316-18-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com> <20230224150811.80316-18-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 15:08:01 +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> [...]

Applied, thanks!

[17/27] memory: remove MODULE_LICENSE in non-modules
        https://git.kernel.org/krzk/linux-mem-ctrl/c/38ffd3eca02502d1d41b8f1430e5a8e302522bd4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
