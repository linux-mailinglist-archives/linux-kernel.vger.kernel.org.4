Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024B77263F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbjFGPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjFGPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:17:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D021BC3;
        Wed,  7 Jun 2023 08:17:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1ba018d94so54636471fa.0;
        Wed, 07 Jun 2023 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686151071; x=1688743071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CX0Oc+oR0doRcnj4n06+nk35DSi85z+omNnBlOlczO0=;
        b=alDCByfzDIV34p4I5QR5uqL1E+QPO1aOYeag0xlan/RSJa/t/xzeb4ZHIKwDQj3QS9
         /yqqqIrYwYUBzqMlbNEqcxlvTYVd0S9U/FQ1peO0LH4ocerNH4Pp6hq9qVqo5mbIIhVu
         U0hZJgmpcCC88hwhSS9Bx0uHkpAInOWZB/eAFW9tyZpgJl0hc28lHxu/E6WeF0WfrHZu
         I18ziSNssiKSLRzWKS9Dpb6GSqjEZFX0NOwD9bLxjtdL9+9bmxC3n9Zulu/4CMiuB1BV
         2CyV3he1fD1uPQ4LIHQOG7x+9fz7s3PdlmLXnufI7jHPm9W8BZ/Hv87IFvTPxi69HU1z
         C9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151071; x=1688743071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX0Oc+oR0doRcnj4n06+nk35DSi85z+omNnBlOlczO0=;
        b=V7r8r7DGo1zQYC3j06V+yYUEd9ewX38gqRfhe4M9vSKGaf+L4ijwqYGL9KTVzIhSGe
         t/70n6Ox+m13ZGlPUk2/icNku/ujkHYSQNkNN9kPFBV6w2MGZ9aMY7Zwz8+q8GVxGn8z
         icfFKhwPuQ9n2y0zIzrvgpb+y7BPx45FANhRkf1/cHr6old1eHM7bBT9BXCqVYSBq9A5
         irjMfv1BBIolU5w86jr6hhr8gSZWQdyeQ6d7Bs9djtnP0Hb9PkWCadYpXlBy0NaIwVjX
         8LJ+fs46pBpgKIGAaCRm8U9XzFEXPJqjeNqeSlu9uOX2cFuiK53DUz9MfUBfghePSo0V
         CjqA==
X-Gm-Message-State: AC+VfDwGs3iA75zflTtRCnnHMxxHMee3RHwuI1npVBEjE0/k9mA5OWj8
        aBBjiv2AGTl3lVHONgVF5oE=
X-Google-Smtp-Source: ACHHUZ4lxlkCjI39/Hnufpw2oEtp+i68IAqhAg7vE3iwbRhSDwNcb7toK919ZbaHvcZu8bHyUDy4/Q==
X-Received: by 2002:a2e:82c3:0:b0:2b1:b301:e651 with SMTP id n3-20020a2e82c3000000b002b1b301e651mr2529080ljh.3.1686151071292;
        Wed, 07 Jun 2023 08:17:51 -0700 (PDT)
Received: from localhost.localdomain (95-31-191-227.broadband.corbina.ru. [95.31.191.227])
        by smtp.googlemail.com with ESMTPSA id v5-20020a2e87c5000000b002ad9a1bfa8esm2302014ljj.1.2023.06.07.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:17:50 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vijay Khemka <vijaykhemka@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v3 0/2] net/ncsi: refactoring for GMA command
Date:   Wed,  7 Jun 2023 18:17:40 +0300
Message-Id: <20230607151742.6699-1-fr0st61te@gmail.com>
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

Changes from v1:
	1. delete ftgmac100.txt changes about mac-address-increment
	2. add convert to yaml from ftgmac100.txt
	3. add mac-address-increment option for ethernet-controller.yaml

Changes from v2:
	1. remove DT changes from series, will be done in another one

Ivan Mikhaylov (2):
  net/ncsi: make one oem_gma function for all mfr id
  net/ncsi: change from ndo_set_mac_address to dev_set_mac_address

 net/ncsi/ncsi-rsp.c | 93 +++++++++++----------------------------------
 1 file changed, 22 insertions(+), 71 deletions(-)

-- 
2.40.1

