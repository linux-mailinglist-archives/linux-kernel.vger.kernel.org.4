Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D584631923
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKUESb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUESa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:18:30 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1E11C03;
        Sun, 20 Nov 2022 20:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004296; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G/zTHj12pak8TZy5UTM0TaeQXtk29vVSGC77Ga8410ygc1tJCudOK/ls8rSJmkdb1MuGZEbowlwiKT6L8aec4T2BnuG49jDdWmFpeWPLv5D5lXOUU/x6ieqZUOsoDAhu/JdXB5xq1Cd6GnypgtY+XUk1s2trtePXmxDFjOVcbiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004296; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=GNYADZcnxx6WkArBGDcoffHOVmoS+nSPURWj3RjmA38=; 
        b=U+UG/qLW098b4/hWy9UdQq1jQzj/athmHatXK5dHYhu2ktHml1Up700LbaIL50vb0ilpB5joef/WtT9c11VE860QJxbzfg9dzzRP4B9FKX4UB3kBwNPPW6psGR9m09H+CDj5RNmOmvTsS1neC0eaJeF/PvQdGrlDuFBf1utNF1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004296;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=GNYADZcnxx6WkArBGDcoffHOVmoS+nSPURWj3RjmA38=;
        b=Nvh9uIP3GO3O1ZJkOo9D6kD3qIcR4T7LtgELBttovaK0uP4XVd6Dczfq2N3SXln7
        enfM2yxMJkQiVT3205Z1fHt0poBujbQySD/tvNpnj9Qm7aPLs8XxKIZR7U/LRVuM2i6
        gYRG5FPaz5VT1ZqOrV6DfuOpRJBRDZmp05ziKyKY=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669004294902760.6808277013304; Sun, 20 Nov 2022 20:18:14 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/3] Some DT binding quirks for T-Head C9xx
Date:   Mon, 21 Nov 2022 12:17:54 +0800
Message-Id: <20221121041757.418645-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patchset is just full of DT binding patches related to T-Head
C906/C910. These cores now have an open-source fixed-configuration
edition, which enables everyone to explore with them.

The first patch adds an compatible string set for T-Head CLINT, which is
incompatible with SiFive ones by not having a mtime register. The Linux
CLINT driver, which is only used in M mode now, does not support it at
all -- having a DT binding is for OpenSBI.

The second and third patches are for OpenC906, the open source edition
of C906. They try to add some DT binding strings for it.

By the way, as we discussed in the BoufalloLab series, C906/C910 do not
have so many customizable options for PLIC/CLINT, so maybe we should
not add additional per-SoC-system compatible strings and allow only
"thead,c900-*".

Icenowy Zheng (3):
  dt-bindings: timer: sifive,clint: add comaptibles for T-Head's C9xx
  dt-bindings: timer: sifive,clint: add compatible for OpenC906
  dt-bindings: interrupt-controller: sifive,plic: add OpenC906
    compatible

 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml | 1 +
 .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.37.1

