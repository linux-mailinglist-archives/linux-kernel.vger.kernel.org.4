Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46567610770
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiJ1BtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiJ1Bsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:48:50 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275FAC4B1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d13so2612652qko.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0w7DYUpPoHwkKsz/O/epVHDzkGEN4zz7NZ/8XRkaZ5s=;
        b=bv+ZXexWl0uhqX5/Zmj34Ib4dbITg9XnYqNa/61/AAXlCpniuIH9FLV64XwGINmaty
         FIlRPryc7+tX85M05cf/YNRLYxCEtW1neU7iHAr88UYZy7raN1Aqet11Z7eQMNHaaPnx
         1OwJeztoRKs/thbnZjcIdAR0h5QuWOzpDnNcOBODAt0Bmj/LKnQM/jFC/YkE55Qx5qOx
         LQFKySgG4ai07KgZOi5hgajtGci1cK1O9UFHdQORdIT7zTcobmGYHnp/aGmpnqKVREg4
         fXRmp5RQ7J1YUl6sleqJKNXTlTQgHD3DUfW/mi9KpmG1ZxiUBi89Sx3tCut46GRfc836
         10lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w7DYUpPoHwkKsz/O/epVHDzkGEN4zz7NZ/8XRkaZ5s=;
        b=xsp8GPaWFUPMuWlAMTgm8EB41exrUcFahCZRRQnUEVxQCTrXbEZ32/7ffMEKmVS9dm
         0w6leQNgCZi7wNZXeAtXZY0VcKf3GGYACoaD1Onpd/K9xbmaF2cHYmpNpvF0v9gIX9lk
         8WOH2OsMVKKsfInRXvnJ1tNGUtoGnDNoEk71+qfA5Kg2S6xmGlc9wbLoFMDiepFOrb2h
         cCGMAbvBHwSVVodzvaG1+ywnuW2Ap/2jsyocX7YKzx4X5G/IKcKqr6SodbvFozkGN4oK
         6yZjDpW8JNhpxReCwnQO+Nuhm7NFsJzRlr6JdN7cU8dKCPfK/1m3uvAOp+kxhGBSgxOA
         MXZg==
X-Gm-Message-State: ACrzQf01sXxE39jPJ1U6am2LmtkVn4ooqqgU6FHA68eSa72mWu9zniUv
        Ex6k3dPgbJLUzeNHe5xdLD1wiwv3IWM=
X-Google-Smtp-Source: AMsMyM6Qu6vpDOrUXI5ppiyQCpj3SD91PK3TAGK64Xc+L1mtK5kPjiBKNMImU/JDskNFNc9WENFg3g==
X-Received: by 2002:a05:622a:550:b0:39c:f017:4b0c with SMTP id m16-20020a05622a055000b0039cf0174b0cmr43157180qtx.452.1666921718100;
        Thu, 27 Oct 2022 18:48:38 -0700 (PDT)
Received: from localhost ([2601:589:4102:4c7c:d8d0:78d7:ad97:2651])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006b953a7929csm2080764qkn.73.2022.10.27.18.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 18:48:37 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/6] bitmap: remove _reg_op()
Date:   Thu, 27 Oct 2022 18:48:28 -0700
Message-Id: <20221028014834.572819-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_reg_op() duplicates functionality of other bitmap functions.
This series removes it.

On top of this:
https://lore.kernel.org/lkml/20221027043810.350460-1-yury.norov@gmail.com/

Yury Norov (6):
  bitmap: add bitmap_empty_from()
  bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
  bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
  bitmap: replace _reg_op(REG_OP_ISFREE) with bitmap_empty_from()
  bitmap: fix opencoded bitmap_allocate_region()
  bitmap: drop _reg_op()

 include/linux/bitmap.h | 11 ++++++
 lib/bitmap.c           | 89 +++---------------------------------------
 2 files changed, 17 insertions(+), 83 deletions(-)

-- 
2.34.1

