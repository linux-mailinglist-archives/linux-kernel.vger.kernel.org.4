Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC5773A586
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFVQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjFVQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A9199B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C439618BB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1C2C433C0;
        Thu, 22 Jun 2023 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687449936;
        bh=bGJb9KPE/IV5Zd0tYxLR111YS0I3sKW4PtkFyur9DhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NK+6eHe6L0L78Be5H7fn6sxPDPJxrKDLa5hhBBnztQveeFbY85pf9ba7T8MC6vnz0
         ofnDVwhZsDmiZSaqSxWcFEvD+hAPRTfZSuBzoWSBqy7nZxJwHEMI5+ohtZ8XrFLGrw
         6kpn3szDoaZMcx1AjZbT6mz920Q58FM6WxqcBa1pCx0JjAQ7gd0kd7lc5sedFM83Pp
         /Yk4N7Afi++erylzhEfhNzLV3hjXtIcmvE1Kh1qibrLdoE9xjIFhaSyNcklvzBX8Sy
         O6Np9qWFlvc1eNDVvuUkVk3GmoRy5rHzOj2pf+6ulgpbCTrLv7zm3r1/m/6de+QbrV
         nn0cnWO6ibKAw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: make ARCH_THEAD preclude XIP_KERNEL
Date:   Thu, 22 Jun 2023 17:05:18 +0100
Message-Id: <20230622-silk-evolve-368ad6a8dc17@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621-panorama-stuffing-f24b26546972@spud>
References: <20230621-panorama-stuffing-f24b26546972@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=603; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5ZUX8qXS96tw03nhohzbJCyJS9nal0fl1eIDx0o01AY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClTCq37Ftyc0mL6trLB98kcDvXLG+LaLoerTK+c97z87 52H2qqFHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiImg4jw3xZM5aHOaGW7o0v Duw33CrUHLxTpWyBcb7l5Z45Ccc0VRgZViX7zOBoYyrQNGkMXdT9+GlF+J9Ok69Syr+t+AqO3mJ hAQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 21 Jun 2023 20:00:31 +0100, Conor Dooley wrote:
> Randy reported build errors in linux-next where XIP_KERNEL was enabled.
> ARCH_THEAD requires alternatives to support the non-standard ISA
> extensions used by the THEAD cores, which are mutually exclusive with
> XIP kernels. Clone the dependency list from the Allwinner entry, since
> Allwinner's D1 uses T-Head cores with the same non-standard extensions.
> 
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/1] RISC-V: make ARCH_THEAD preclude XIP_KERNEL
      https://git.kernel.org/conor/c/273235194e4d

Thanks,
Conor.
