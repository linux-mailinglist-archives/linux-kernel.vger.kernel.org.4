Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B446DB972
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDHIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDHIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:01:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E03A84;
        Sat,  8 Apr 2023 01:01:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa44so1330406ejc.4;
        Sat, 08 Apr 2023 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680940902; x=1683532902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5tWKyBW1O5WmbCgc/4ykx5MxlKMaKP2zAFZ1gL/EkE=;
        b=LKe4kQDtEH01/12w5TidPgxQ/hk+cRbhpRzXvRDRz4VqLeaVkBoBELY8ndkWtkr7Xw
         2Ll031OvIyJyI2GwzSSm3a7cgms3a1UNy7QV3jD8p+ykRAh5JRffn4bfyOj3MlFuKoQb
         HCwCShmsF39vt/x7fV9tVxUXGgMPIXzjhvJxqbvH9v1l56uxJjEthLBefU4UHlBrqvub
         2ZCxCvWsXUpzQ30Fm0eLRyjjRWBPlxQ7OMSfcLmfyfAO7ACe9EV44pCseiurV4vgnJd9
         xxbvpewi1sj4VEzH1UpPW+cKaRnKFfFZHUkWyLaNCIHPRNTiadyEvkaYgdpCnRn9cVoW
         59GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680940902; x=1683532902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5tWKyBW1O5WmbCgc/4ykx5MxlKMaKP2zAFZ1gL/EkE=;
        b=REYwWGJU0OZCNHN6t2IEQ2hs+oNEjCq5X2R+W8kTkwkeFfrNHZyYnsarr2DkVwF7l/
         rjQo/OjB4NfOUdj1mxi4i9VCTiehRJcw8cWMTKdVTpXXFcMWGyMqUMc1FMWe2R0u7zqM
         l5NP4nRG+2QNYWfFRmVTtkW3jzi3lKbXLUZiF/AMMrK7A6NScxjErtbVUQ8/1jybtDmi
         aef+B5CzgP+hotvx3DCoAg64kO85IjcrsPooDnwM2ssd8zQHtL70I6W1XB5pvm1e0Fc7
         kG2K8yTMqRQ0+7wPxlw3bqiQFu2Fft2C4ivM22oC7BRjAybhmWUp0+3WAGTqkf22rkE2
         aqJA==
X-Gm-Message-State: AAQBX9dl0cuziLwYya9gJvJ8geoHBJ39x4OS1hxDWbfCLnzCd3oxdCM9
        VeKwRSTgClu9qgCjAtnDHH8=
X-Google-Smtp-Source: AKy350bl5z3CITJRDeP4kexVek58k7J2u1EX5Y5MvhCvgaCshsDhwBqpj6fPDcbUoQYc2ENDd/zV6Q==
X-Received: by 2002:a17:906:b1d7:b0:933:868:413a with SMTP id bv23-20020a170906b1d700b009330868413amr1832817ejb.15.1680940902037;
        Sat, 08 Apr 2023 01:01:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090617cb00b008c16025b318sm2878015eje.155.2023.04.08.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 01:01:41 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add power supply for INA2XX
Date:   Sat,  8 Apr 2023 11:01:21 +0300
Message-Id: <20230408080121.7306-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI ina2xx hwmon has vs power supply, add one for correct work.

Changes from v1
- fixed regulator disable and release
- set correct supply name
- added supply description

Svyatoslav Ryhel (2):
  dt-bindings: hwmon: ina2xx: add supply property
  hwmon: ina2xx: add optional regulator support

 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 5 +++++
 drivers/hwmon/ina2xx.c                                 | 4 ++++
 2 files changed, 9 insertions(+)

-- 
2.37.2

