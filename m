Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB306FC507
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjEILfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjEILfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:35:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A522D58;
        Tue,  9 May 2023 04:35:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f139de8cefso33274447e87.0;
        Tue, 09 May 2023 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683632117; x=1686224117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAjLxf81Fsfze5ee8+9aMhvLTmCgUl34iyRmfeaLkcc=;
        b=oWDWvpWmPXiPMas0xDaR8hzPYdvhnLLKn1woROGdVxLcwxuV9BcqttRtRA0cmWtbyy
         ihsbuGrOx4GHyPrvBWZTT6q3///KIUz9ZNxQUneDXwkujFsvFQOWfNS/by5X4siTE+kv
         IaTQucgPcC32EY0xooNvWyawTnY8/PTYTsAWrgm1ejhYWIIVYvzjErykVFlVAELzqy5E
         2VUEVjJU/IIUdAI8eGJZdHJEvGu6wnchJ6pcKxf08zwWf2VuPTauDkaq9LK9ykyaBlza
         Sav70WM+Odx6vFLCib0EmAhvuMzmdsSCcL4mK9z9gClTt7bENcNxhacBkFc9ioVHXSpA
         0hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683632117; x=1686224117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAjLxf81Fsfze5ee8+9aMhvLTmCgUl34iyRmfeaLkcc=;
        b=RbbNq2h+o9GJx0CFJ4TT8PFSnWtj0uLSHr15kySGtzyQU2+rA1czj/uHy0XuwkqwzT
         B/j6LpqUSosSsNpdC2son9bJMT07PLvyUA71XQzkWDH7JSoJWpHKONkHfZ6I1lgJ7+ZI
         3r8hQ+llO8J3gDbwdAYMsxbxF8AS1gZwPBUvnGr0OTm+W4ML7l9jQuKfqWLtWAYQ7p/X
         OMxGrb15Qe51zNB9dF4FjKz3muZdoXMyzloPPUx/m9LouOJ+6xbdtuXg1+MpW7sspXyZ
         o25icPoq5vQPfTAxWGGD8RmS2LTm0V91Ks7/rW9bO35AXyIDc1Ts4Vya4CqUim9RB22U
         62bg==
X-Gm-Message-State: AC+VfDz9d4DLEGshjv4ho2Wk4Zz0udfs/5oGKszhQJeSTAhwj87qE3tL
        pQu5Vc+jSix1em6GAxMXt5g=
X-Google-Smtp-Source: ACHHUZ5PaZQJHKJwGOI8X/9RlU8php6koUYl462ViHkvaspmxZuW5PDLG59PrVUywL4GCBO4ywcc0g==
X-Received: by 2002:ac2:4311:0:b0:4ac:b7bf:697a with SMTP id l17-20020ac24311000000b004acb7bf697amr690386lfh.4.1683632117428;
        Tue, 09 May 2023 04:35:17 -0700 (PDT)
Received: from localhost.localdomain (93-80-66-133.broadband.corbina.ru. [93.80.66.133])
        by smtp.googlemail.com with ESMTPSA id k16-20020ac24570000000b004f25ccac240sm108940lfm.74.2023.05.09.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:35:16 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v2 0/5] Refactoring for GMA command
Date:   Tue,  9 May 2023 14:34:59 +0000
Message-Id: <20230509143504.30382-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make one GMA function for all manufacturers, change ndo_set_mac_address
to dev_set_mac_address for notifiying net layer about MAC change which
ndo_set_mac_address doesn't do. 

Add mac-address-increment option for possibility to control MAC address
assignment on BMC via GMA command. 

Changes from v1:
	1. delete ftgmac100.txt changes about mac-address-increment
	2. add convert to yaml from ftgmac100.txt
	3. add mac-address-increment option for ethernet-controller.yaml

Ivan Mikhaylov (5):
  net/ncsi: make one oem_gma function for all mfr id
  net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
  dt-bindings: net: add mac-address-increment option
  net/ncsi: add shift MAC address property
  dt-bindings: net: ftgmac100: convert to yaml version from txt

 .../bindings/net/ethernet-controller.yaml     |   8 ++
 .../bindings/net/faraday,ftgmac100.yaml       | 110 ++++++++++++++++++
 net/ncsi/ncsi-rsp.c                           | 108 ++++++-----------
 3 files changed, 155 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml

-- 
2.40.1

