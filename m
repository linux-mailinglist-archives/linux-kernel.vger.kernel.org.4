Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65276FFFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjELEhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjELEhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:37:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99662193
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:37:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHbZl5J04z4wgv;
        Fri, 12 May 2023 14:37:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683866223;
        bh=bFdF3qVgrRQwTQKB2U2Zclw0g6ascaQQQ/vCod6HYPI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qrQabGj51hz+dz3GgYO48fUDv3SpvtZ3BBIFG/OsDWeKuqaxFtQoyBD2HNLaAO30u
         8JEsuAvf8rqTc2mLlGhgKvCsO0Zb0xeHIhZSNJ7iQMrKT1gXJD+KbB3IRBVlKrO6u3
         EKyjd1iDbvy85BfrTNvBDHngrc4A+poGervWfhQgxpSpoNkI0ut/Mjl+DfgiZDjTV3
         vsjGyBr3hA0dznhnnn0GM6l9+Vz14j9enBbsZavd2fVrtQQOsDVrNSQo1eM6ykmGAh
         QT3unhjiZ+9kEOL7jsOfDTPqmSsUTo69exBDUPtuXy2V2Y+BUOaZpQkm0iHGHgkCuN
         nPeeVACZuosxg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/embedded6xx: select MPC10X_BRIDGE only if PCI
 is set
In-Reply-To: <20230505230032.19156-1-rdunlap@infradead.org>
References: <20230505230032.19156-1-rdunlap@infradead.org>
Date:   Fri, 12 May 2023 14:37:03 +1000
Message-ID: <87wn1ejhcg.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> When CONFIG_SMP is not set, CONFIG_BROKEN_ON_SMP is set, and
> CONFIG_PCI is not set, there can be a kconfig warning:
>
> WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - MPC10X_BRIDGE [=y]
>
> To fix that, make the selects of MPC10X_BRIDGE be conditional
> on PCI.

That would work, but using "imply" would be preferable as it doesn't
have to encode anything about the PCI dependency.

cheers
