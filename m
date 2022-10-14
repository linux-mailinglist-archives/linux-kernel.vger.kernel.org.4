Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7735FEC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiJNKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJNKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:07:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D014EC4E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 03:07:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j16so6816241wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPSC14H4qvXkT9TYkAZgmifJI9m19ef7qgoJ4OsHyyg=;
        b=vnlPWAmwmg0Zu0PEMDLBoa6dhUKeqWzyoHwUBGMfJ7nVwamcozMkMIhqh6E/zs7Y31
         bPNQRhSvMPKWcsBOvMJKluiIsuLnfxFpqHpTXCZAONw2Ppgoq9JpNDaBcoXk9hmT63dH
         sKKlPQlXA4+rChv4Xrri3HQgo+D86h/YVo40Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPSC14H4qvXkT9TYkAZgmifJI9m19ef7qgoJ4OsHyyg=;
        b=3GoAoHBx+RocC5H9HkD/oJtTOwRig24HJxoVITGRWqMjzc+XgUsid7/BzoZCax+SZB
         MQUqVASMtKuaa6JpU3lphXBNzmMI6ogYGlgAHo9oJwLQD/QP5p9/S/rSpkz6vUtvcLBS
         hAopRC0kr3K8HyioVa/l7ThnaYVhyjNAbKNmNCZXLqXkL4BkM3spZoxPkiI9zVLQeCpT
         RkgWi+3AGQftIOUwKervYWUI0PmJ94btGjskLmVbIVCl8DGKbl0P4YOFzwupAVm57SKx
         BrjYSMhX7XEWt5MZeOjXLJHGI8wZEA2iV+rnZyo/KaxpUoDLYOKlZU++fKrtGfTbi1BB
         d3YA==
X-Gm-Message-State: ACrzQf2309Ph7GRoPAaVIscZYcPMMMGBqWFv1t9knAdegZchS81oI3p+
        LNvpO8Z2Th+CouQE64yIUxsrKg==
X-Google-Smtp-Source: AMsMyM63n0BME1wzakGcd9fpHxmmjPaT7s3n01NO4QiDx0MC/YSVqw0PfekfOqiRcGaQE7RhMCABWg==
X-Received: by 2002:adf:9dd0:0:b0:22c:d6cc:b387 with SMTP id q16-20020adf9dd0000000b0022cd6ccb387mr2922910wre.353.1665742071061;
        Fri, 14 Oct 2022 03:07:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:5308:6600:49a0:d6bf:5c1a:f3da])
        by smtp.gmail.com with ESMTPSA id c15-20020a5d414f000000b002285f73f11dsm1931008wrq.81.2022.10.14.03.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 03:07:50 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, lei he <helei.sig11@bytedance.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2 0/4] crypto, keys: add ECDSA signature support to key retention service
Date:   Fri, 14 Oct 2022 11:07:33 +0100
Message-Id: <20221014100737.94742-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
  * fixed code format

Kernel Key Retention Service[1] is a useful building block to build secure
production key management systems. One of its interesting features is
support for asymmetric keys: we can allow a process to use a certain key
(decrypt or sign data) without actually allowing the process to read the
cryptographic key material. By doing so we protect our code from certain
type of attacks, where a process memory memory leak actually leaks a
potentially highly sensitive cryptographic material.

But unfortunately only RSA algorithm was supported until now, because
in-kernel ECDSA implementation supported signature verifications only.

This patchset implements in-kernel ECDSA signature generation and adds
support for ECDSA signing in the key retention service. The key retention
service support was taken out of a previous unmerged patchset from Lei He[2]

[1]: https://www.kernel.org/doc/html/latest/security/keys/core.html
[2]: https://patchwork.kernel.org/project/linux-crypto/list/?series=653034&state=*

Ignat Korchagin (2):
  crypto: add ECDSA signature generation support
  crypto: add ECDSA test vectors from RFC 6979

lei he (2):
  crypto: pkcs8 parser support ECDSA private keys
  crypto: remove unused field in pkcs8_parse_context

 crypto/Kconfig                        |   3 +-
 crypto/Makefile                       |   4 +-
 crypto/asymmetric_keys/pkcs8.asn1     |   2 +-
 crypto/asymmetric_keys/pkcs8_parser.c |  46 +++-
 crypto/ecc.c                          |   9 +-
 crypto/ecdsa.c                        | 373 +++++++++++++++++++++++++-
 crypto/ecprivkey.asn1                 |   6 +
 crypto/testmgr.c                      |  18 ++
 crypto/testmgr.h                      | 333 +++++++++++++++++++++++
 include/crypto/internal/ecc.h         |  10 +
 10 files changed, 787 insertions(+), 17 deletions(-)
 create mode 100644 crypto/ecprivkey.asn1

-- 
2.30.2

