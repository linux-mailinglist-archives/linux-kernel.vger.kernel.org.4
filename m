Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E5608EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJVQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:50:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B071863C8;
        Sat, 22 Oct 2022 09:50:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bp11so8982234wrb.9;
        Sat, 22 Oct 2022 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OL5w9hmJ5NSe0NhK9baWxvFR9c+SkOOF47EHeGtVWKI=;
        b=kDnGOGLqU/iKq3uvUZT8yXHDHpzKdqkPUjXULyVdzDgvAr+j8CPsJM8OjEp+lDdwFd
         GBS1XrXznRRJ1q/6un2m1L1KLxGdGwmciUHhAQcdts/EyNZGGqsYAQ/h8ZkdCLFluASz
         Nn43F0QKXUl/Zb7nweXzO9tPHe1VBjzc+eYy6s1NOlBgIDC4zvE7iRBME6IfKW13Rthd
         CQa3YENA9ia9T6vaLw8GMEHF4v8pM7dINo+kUSGgJbtH9V+yPujzpXbIlHISTZYpu7YI
         0e5A9tudbDId9Xm9QBW2FMW3V86cTnOk6hcYTn/CtGHtLhwk3D5dRT0MTpYqOJPOGaQI
         0PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OL5w9hmJ5NSe0NhK9baWxvFR9c+SkOOF47EHeGtVWKI=;
        b=AcHN+/0cxGZ6rCy7MuwBtjWdokwVl57kVD3kWFTGU5/VuRlpjn1EarU60h8hxOFC++
         dH0FJFFT3mvaLSQyz35FGqil8Yn7e3r1lXgZbdE+J/xEzzRMFIQ9zKhSsr6AirWL8/VU
         N3aZwVh4RuQWy5bumNqKvf//O4/tPTi4XZ5H/vcXXG7zAPDZpf5pdydZ0EyRSx+18y8s
         Kjq2rq/blKbz6Jm7HfatbNbJ1SFNxvpI72ofLNh7DzO4crApiCqUq10rHyl4t4QNHBIx
         CnzJH1LwHqvIi5YzrNy/Fhu1zDyr6kp+8r3iGMbJ8d9RrDXrxAHZVLi+6/D/VvnmYgVJ
         R4zQ==
X-Gm-Message-State: ACrzQf2QNH2ZyWa9+1hCdsVtahPdCBEi8P3gTpVPsE/ZAr952KsXTUga
        4kZ0EGxXAENXER3n3XiRjvA=
X-Google-Smtp-Source: AMsMyM58OR9oKXrGb18IoJyXHD00j6PpC8jKGB4e5Z8i7rJAM3+JsmJMsMq6A4A29V5ErDMgfBT7SA==
X-Received: by 2002:a05:6000:510:b0:235:e5de:8da0 with SMTP id a16-20020a056000051000b00235e5de8da0mr9461523wrf.416.1666457456896;
        Sat, 22 Oct 2022 09:50:56 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.133])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003c7084d072csm3196787wmq.28.2022.10.22.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:50:56 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 0/2] serial: 8250/ingenic: Add support for the JZ4750
Date:   Sat, 22 Oct 2022 19:50:45 +0300
Message-Id: <20221022165047.4020785-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JZ4750 and JZ4755 have an extra clock divisor in CGU called CPCCR.ECS.
It needs to be handled properly in the early console driver.

v3:
 - fix build errors
v2:
 - serial moved into separate patchset
 - code refactored to avoid peek in CGU register
 - Krzysztof's ack picked
v1:
 - big patchset for the whole JZ4755 support

Siarhei Volkau (2):
  dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
  serial: 8250/ingenic: Add support for the JZ4750/JZ4755

 .../bindings/serial/ingenic,uart.yaml         |  4 ++
 drivers/tty/serial/8250/8250_ingenic.c        | 48 ++++++++++++++++---
 2 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.36.1

