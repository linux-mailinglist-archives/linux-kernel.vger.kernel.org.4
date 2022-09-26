Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963315EA655
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiIZMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiIZMkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:40:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EC100A99
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:16:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dv25so13250471ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=bAkC/5EhMydvusKw4x8gqMb/4C/GgXVqhEpf5Mgd+O0=;
        b=pMVX6OCEV5xca7iP7H1U/l/XUIjwsbwYpOZhD0Vk8zPIBv3dBXTlE/ZZXvtoRKF4qI
         nWKbN8YJFSlkfyLxqSrVfC6Ddyge84q7KkCHq+Z3YkYtUFJ5jSB8uIkpwLaMcPtOvl3d
         TY3tV8hfG/fbCEkohLvS9Or3bg7qkqhsusZE7s0QCD8daD4H2i313uA8ZlenbOSHlEuh
         bn0z4jRcJD/c7ccW8qKl65ebzxu2cLBmSiA6rmwIb1cpdhgVb2thJyM1Y1RjiwQrD0jr
         UPwvU8oAqfJbcfgPymnrovUEvqp9CrSeanTfligziE+1AdONA3CQltNo1bcI+VkdjDo4
         81aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=bAkC/5EhMydvusKw4x8gqMb/4C/GgXVqhEpf5Mgd+O0=;
        b=NGwb0vOGv379O0WtPAGR37bbhsG2cvALjSxW205RCO6Q0lzlrZ3h7rOBlZklhsD+AU
         BNdFWMqUUKZ4Urhu2rQMZwskR6A2YrUOUNsjRb5Nhj45amqYcSEVLaOvYjeuRN2rKhOV
         9INKReVB3dBX9k1x2sVKGiIm+BtWPuxEAUjeRmYzG3PvVrJMNvO6J9iPUG4erYMj/4Nx
         ijc0j2vfFvsvXUz/8NoY8ujVSY14v/U6vnu23Y7+GS+2DWuNgxmys2s7TRViJhP1TTxL
         Fset/bUDobIeQo0JZwDs2yvv6tnb0CGjimelyJSMZNQhkkrVmm4ShKMWYVvm+AhpVXmA
         1qoA==
X-Gm-Message-State: ACrzQf1TgFy2nVrzVFiL5HRfsDOelmjLsUFGBTaLa9gTaY6ayK0SjsVe
        8weuE08tFTZRF84qeddesaFzMVCXWp75vQ==
X-Google-Smtp-Source: AMsMyM4Nfn6b4ILBSLFgD2196HLA3V4ld76UntR6VJ9hoyz4eIomwtEn5Je2Da0hOv9MQdgc/ZlCyw==
X-Received: by 2002:ac2:4e09:0:b0:499:1e3a:54ab with SMTP id e9-20020ac24e09000000b004991e3a54abmr8257161lfr.170.1664189041936;
        Mon, 26 Sep 2022 03:44:01 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y1-20020a05651c020100b0026c423959desm2313408ljn.25.2022.09.26.03.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:43:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Tomasz Figa <t.figa@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Subject: [PATCH PULL 0/2] Two patches for next cycle, v6.1
Date:   Mon, 26 Sep 2022 12:43:52 +0200
Message-Id: <20220926104354.118578-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi Arnd and Olof,

I got two remaining patches for v6.1 - DTS and ARM/mach code.

Best regards,
Krzysztof
