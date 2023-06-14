Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3716730644
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbjFNRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbjFNRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:46:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F681BE9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:46:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so6807224f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686764810; x=1689356810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzvZItVXWj7Fm3dpt0cy7Q1fFjOE2nErFj2dQ042GeY=;
        b=hmsYpe5ougKzE7tgwwFGqBa1AOzW8K6nhqS+tC9vYUxsKM+47j2X7imD+RxXv1SLF4
         J1LynbR1DYW5St42KMIqbxHKt33vNT9EFHG1h8nJAJZ2EFdZ/ThE7qvdSklbUX6RgeST
         dRODVPz0wMP2thPYEo6iPxpUfwyWyV+GQLNTscXHwPWWKjZvqDZTewq/GiBoCcu4oGgm
         pQM//vXikTp14Vebbl3xOv0zDd1pBZhNW4bxiMaXF/DBhmjbaliwTkPvshHJs8bE9RG+
         YkCTMTmljrWU9t1CKUeOe1a1KUEeBCxlOYIgFUhdyjmmKvD3oMNkuEAdawaVO5KbZdyy
         L/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764810; x=1689356810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzvZItVXWj7Fm3dpt0cy7Q1fFjOE2nErFj2dQ042GeY=;
        b=MBFlMImWY0hE0le4lLe3lT/rgOEruf0a1bSUa9fwuhXbjYPSf/aU8PjwBFZ6rEtcN7
         fpk71/gTPJxIWa5ypWTDMSKqSwUy0tTniGPRhxpp85qiUMCokjx4Tvaztgs7774axHSp
         geL+TlxYdoKCRi92S4CutkG4zmqn14Fz7XVl0BS9q8BNHWHx/APDlQ0bLB5r0QO1oY+v
         sgLROMVcJtpFiN7D3n0kM6WWMyzfxoGEjCQMMxswPcW9iPXhKMecgDvqKorqdqGRgJ5Y
         LN+kiIPu4wht3H3ui+Dn8bIlKic7CO+hxa00uUlfApfj+zLxkIaIQWbYHy8vJJK9G11/
         aagA==
X-Gm-Message-State: AC+VfDyLtoXPYx9zdc6k9IwaxvLUIHsd6DaN+Q3aWowZTahkJ/vSrh97
        cubwn/W/+fjfN+jZd4q5ieatNQ==
X-Google-Smtp-Source: ACHHUZ4hja7oRvWwXVXRpEQrYEDib7oARRRdvU+GnBSdcfg64rhKwiAWYejr1P6GOrV9050gfRUVmw==
X-Received: by 2002:a5d:68c4:0:b0:30f:c601:63d9 with SMTP id p4-20020a5d68c4000000b0030fc60163d9mr6644634wrw.65.1686764810661;
        Wed, 14 Jun 2023 10:46:50 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m4-20020a056000180400b0030633152664sm18738740wrh.87.2023.06.14.10.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:46:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Bob Gilligan <gilligan@arista.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH-next 0/3] crypto: cmac - clone fixes
Date:   Wed, 14 Jun 2023 18:46:40 +0100
Message-Id: <20230614174643.3836590-1-dima@arista.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make cipher cloning possible in atomic contexts + prevent use-after-free
on the crypto algorithm.
Those seems to be all pitfalls I found while adapting TCP-AO patches to
use crypto clone-tfm and dropping per-CPU requests allocations.

Cc: Bob Gilligan <gilligan@arista.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org

Thanks,
            Dmitry

Dmitry Safonov (3):
  crypto: api - Remove crypto_init_ops()
  crypto: api - Provide gfp mask for tfm allocation
  crypto: cipher - On clone do crypto_mod_get()

 crypto/algapi.c         |  2 +-
 crypto/api.c            | 20 +++-----------------
 crypto/cipher.c         |  9 +++++++--
 crypto/internal.h       |  2 +-
 include/crypto/algapi.h |  1 -
 5 files changed, 12 insertions(+), 22 deletions(-)


base-commit: b16049b21162bb649cdd8519642a35972b7910fe
-- 
2.40.0

