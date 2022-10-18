Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9960284E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJRJ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:25:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFD923C1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:25:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b5so12808744pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smgOzVjWqVIBBGSbk+bAqgSK+ImSgqCNvhjx9z8C2ds=;
        b=Prf7xxc8c6RO6831Ks9ssdZq9ofHZAcpE0hdIQ+d1AkuWLxyhtob5UiyGEajV/rAI7
         xgDSn/tg2vMoGP9+Y3mziadWZ3N28bU5CYJXHnoeTqq/NuzQMxi5gmOudYdPOw+X5Gxr
         ndG4v/RSevGxcD8K/0XJ67T9qNiNuXCgmy9ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smgOzVjWqVIBBGSbk+bAqgSK+ImSgqCNvhjx9z8C2ds=;
        b=pZPJQuA0Z1aXf6SWoVz5tHoiudq2b425VPABCXmikbCmTdrE21YO8loXn3wAnXhBwk
         1dpG3H1rb3P2VS9FcAN9oCxfvi7010MjCQh5tZw5wm37ZVeSln4kxjQs0BV0WAEcbFXY
         ti+nb4BuJHx01SwAAmeuAgtmYpKfSPzjrdR/WBX65njtd0FDwbzEgJZT5yG9muzp3Rds
         JvQCb1x5IbsfS5Mn7cayW3LTQddCI956X+/KV5PsQQKOv9xWkTUrgY5vclATRUZS4wXC
         A6mHSrO2zZRkXDv7xjpkVI2rdZ2EnvLQV3F37U6TEnx5npn2arxww91TT20fcRmA32Cd
         gBRg==
X-Gm-Message-State: ACrzQf0WVuWrTxGGUkLw3rJA8p/XYMglNZ6HA5Wk59i0HWX3thz74O05
        mfFxQeM2FLpsBCA2tOZhbPZDPQ==
X-Google-Smtp-Source: AMsMyM7ajtyHBS+TRXtSQEwKaZpL/hbRdnb13JjeLJa7NsINcenQRY+eAz3SpJVDbIWZtAyazRaKaA==
X-Received: by 2002:a63:4307:0:b0:464:a24d:8201 with SMTP id q7-20020a634307000000b00464a24d8201mr1911063pga.116.1666085129704;
        Tue, 18 Oct 2022 02:25:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m20-20020a62a214000000b005609d3d3008sm9039968pff.171.2022.10.18.02.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:25:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ruhl@www.outflux.net, Michael J <michael.j.ruhl@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/2] igb: Proactively round up to kmalloc bucket size
Date:   Tue, 18 Oct 2022 02:25:23 -0700
Message-Id: <20221018092340.never.556-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; h=from:subject:message-id; bh=fe46aJaXIAy8NFr6NaDoWVctMGkMgluCIMsXEg4daWs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTnEFofbxhgG6+Oz/mqUhGoxgqnLDQsrMFGGpTPSL oHyi/4CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05xBQAKCRCJcvTf3G3AJvpsD/ 9e+QOmvIyz2MVEyVrcUOvmy4j+puTP/6PIBx8eB78oe+SxMHCsGBBNxooJbXME0Mw0qM5zEHzbks7a ND4MP+VamgnU/UfGcxGX/E9VnNcPHieQmpuAikOhqYsKaFYvuVohgJhHsDKf/MevMr9ZH1Zxa/efi7 gYUQa0QhYgT6mQ8FJZHXZdpVuAa09KMktmCO28YKnF/v1/qGMJJzE5X3ekdi4lvgxw4YGXLBZuariM Ky9jvuQrz6BE1TMRWBdMadND9UaBjhOGdu2/vPI5ZmQ6fO2n8fM//mX5C8jDh8M+Fuu8JdF290B8ci lveHjW12jkXfGrnnZNLew69uvexfjw1GIJRFzqFNJR+Hmlcv4x4SSBJwxhRoVB3aTpeLiMaQJIqjau tyKUPepOLR5jKxzOVvQ+cwJigmY1E4TxY/YLpBqDU5PAnyOxxIbzSQRe2B/bkTa4WpJ5P1lqwvybLc Qn+ffjYdd23f279GWcGonSAGKCzShx0QIJ/NQTZD2a6+uSvnG0nzNJ5+PosRlr1YZxC0yGjfDrfa7D Xp5cRYOMhDXFwm+GPH23JnsrMDK4pwHAde8HAiPYp00eN1efRiOSvHjv0j0bvfQS505N7wQowiy32c mQC5kJf5z26Ib8AqFERv3eMDM5Uwbyn3NapEjQh48vEXIg4KkNwdzcKyKcrA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In preparation for removing the "silently change allocation size"
users of ksize(), explicitly round up all q_vector allocations so that
allocations can be correctly compared to ksize().

Before that, fix a potential Use After Free under memory pressure.

Thanks,

-Kees

v3; split UAF fix from bucket rounding.
v2: https://lore.kernel.org/lkml/20220923202822.2667581-7-keescook@chromium.org/

Kees Cook (2):
  igb: Do not free q_vector unless new one was allocated
  igb: Proactively round up to kmalloc bucket size

 drivers/net/ethernet/intel/igb/igb_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.34.1

