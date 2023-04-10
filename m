Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953786DC797
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDJODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDJODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:03:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9C49FC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:03:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5491fa028adso424051017b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681135399; x=1683727399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6xr4dsIfUHocIJG6ABB+pNClK5aTEQgtpf+Nzcgpg0=;
        b=jdpoKBtHGpBjLql6hXxSl8zDPn2P3XiyI8XtHmZHRCE03v4ylTtc+lWRYVV+aBczxy
         GjwsGPsThFxTqsQk1lMxFS89y3mn+FU276qKYlLNcp+pxPjQKHkDmy8PT5pgKrxOXWJb
         W5pyTBe5SP/ZdCdf0s2UwsrROcQ12IzgWMJwu20z1jIVFjthT3YA+DD1Q6O8kuL8r+R1
         x8c5T64pVrJg6aWrYDJxTE/7XfJxDsLnlIost+KS4OPOSNNEdWh1doiPHwoO0m22hdxk
         C9RTiJh2OaF66YLhZvcS2dIPv9Ra6+986AeeslG+fp2elupF9MNl9rTKYpXkMJm11Ixr
         224Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135399; x=1683727399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6xr4dsIfUHocIJG6ABB+pNClK5aTEQgtpf+Nzcgpg0=;
        b=1e7s5lU2jtBfOyMyt4J9Lqsf7G8VnIMAVJb0yGg2dk/ih2u61bmPkbV6ckxBc3xMvE
         VVU0Alu8pIeBpwv2HxiUS05+MLjr7KvunROJ4/M7epQL8pC6XfKUARSGpx4QOKVcU9/p
         O+nomgJU9eY97PkoOb48ZjOw+Zs2n7huoio1DnXPHLk3iftg71COmDh0Xlb0FJ9XDWba
         9ezDg4a4S4AMW5FiVtCR4kcF/AVVeQb5UFEsE6RDsaoSu4lXKjek6RWGSqDNd28vQ8HC
         RKB1qdcqEu9J0g9201MZKtoD9x2H4+Sgue+0OQpn+t4dFARX+qQsLwDpLt+Vto1UhYYY
         cZ1g==
X-Gm-Message-State: AAQBX9cYVh+fB7ehbvrd17dC26qEDtaGGPsg2AQk7hz3RmMpGZptyTfl
        n1WjJzULUPLkTUirY3Gg5U1Dmw==
X-Google-Smtp-Source: AKy350bBCeFh6Cbf+Sny3UEpFSsxCCKFbaJ0LIdO6mUDKGrTOgz/Ux2gV0PLqhCtWB0JzIHkzXyx5w==
X-Received: by 2002:a0d:d614:0:b0:54e:84f6:6669 with SMTP id y20-20020a0dd614000000b0054e84f66669mr6953363ywd.49.1681135398537;
        Mon, 10 Apr 2023 07:03:18 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cm24-20020a05690c0c9800b00545a08184c8sm2821000ywb.88.2023.04.10.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:03:18 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 0/3] Refactor 104-quad-8 to match device operations
Date:   Mon, 10 Apr 2023 10:03:10 -0400
Message-Id: <cover.1681134558.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Add __always_inline attribute for quad8_control_register_update()
Changes in v2:
 - Drop FIELD_MODIFY() macro introduction; u8p_replace_bits() is
   utilized instead for the same purpose
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()
 - Replace FIELD_MODIFY() with u8p_replace_bits()
 - Wrap up control register update in quad8_control_register_update()
 - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
   data

The 104-quad-8 driver was initially introduced to the IIO subsystem
where it didn't quite fit with the existing paradigm [0]; these
differences eventually led to the creation of the Counter subsystem[1].
As a result of its awkward beginnings, the design of the 104-quad-8
driver was structured around maintaining abstract state buffers that
would eventually be converted to match the actual device registers
states on-the-fly as needed.

The original design approach for the 104-quad-8 driver was neither
efficient nor easy to troubleshoot, but it did allow us to focus on
implementing and supporting necessary APIs for the nascent Counter
subsystem. Now that development for the 104-quad-8 driver has shifted
to maintenance, it is a good time to refactor and clean up the code to
match closer to what is actually happening on the device. This patchset
is an attempt to rectify the situation as such.

The primary change is a transition from maintaining individual
configuration states independently, to storing buffers of the device
register configurations. To that end, the bitfield API is leveraged to
access and retrieve field states. Some helper functions are introduced
as well to abstract the handling of the PR, FLAG, PSC, and control
registers.

[0] https://lore.kernel.org/r/b43e2942b763b87afc85bfa9fe36e5695cba4c44.1475079578.git.vilhelm.gray@gmail.com/
[1] https://lore.kernel.org/r/cover.1554184734.git.vilhelm.gray@gmail.com/

William Breathitt Gray (3):
  counter: 104-quad-8: Utilize bitfield access macros
  counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
  counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and
    PSC

 drivers/counter/104-quad-8.c | 537 +++++++++++++++++------------------
 1 file changed, 258 insertions(+), 279 deletions(-)


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

