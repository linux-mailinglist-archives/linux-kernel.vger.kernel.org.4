Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284F5FA0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJJPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689382408F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D539D60F77
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C2DC433D6;
        Mon, 10 Oct 2022 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665414636;
        bh=ldhbd4gbQEFA+pTqtSmtstrcNM+Qhq7eBd95J2vIhdA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UBia0qRg3uM2Fv6m57jcY4VKFldyUhPNfLQHomhUvx5AQ+4IACfN6SN5vBoZZn2dS
         hLFmjgW010B0xxT2620tnnbPBMUpyLMx9Q/HKXtKZTmdtxUlx8D0GpBaDrVE4ZZ+aa
         KcxuK9bpHNnamZc4fNQO241zMTiJh3CHpKexGqq12qTbJmx0RjbmGEbYZr1NIPdNRA
         0GZk9DljKVM6t3uc0sA/STL8FHZbwK+27mw195sqJXJWiYDt1Pix79mzhsVkIl7UF/
         drOtb0itKvE7Ou7bGMiqAYyLdhXIw3WVXo6LMTYXECmJ8PgMDTOUAfljt3WagetiKe
         74qKmzXLyIxmw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Wenting Zhang <zephray@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Wenting Zhang <zephray@outlook.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: always honor the CONFIG_CMDLINE_FORCE when
 parsing dtb
In-Reply-To: <PSBPR04MB399135DFC54928AB958D0638B1829@PSBPR04MB3991.apcprd04.prod.outlook.com>
References: <PSBPR04MB399135DFC54928AB958D0638B1829@PSBPR04MB3991.apcprd04.prod.outlook.com>
Date:   Mon, 10 Oct 2022 17:10:33 +0200
Message-ID: <87bkqjk93q.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wenting Zhang <zephray@outlook.com> writes:

> When CONFIG_CMDLINE_FORCE is enabled, cmdline provided by
> CONFIG_CMDLINE are always used. This allows CONFIG_CMDLINE to be
> used regardless of the result of device tree scanning.
>
> This especially fixes the case where a device tree without the
> chosen node is supplied to the kernel. In such cases,
> early_init_dt_scan would return true. But inside
> early_init_dt_scan_chosen, the cmdline won't be updated as there
> is no chosen node in the device tree. As a result, CONFIG_CMDLINE
> is not copied into boot_command_line even if CONFIG_CMDLINE_FORCE
> is enabled. This commit allows properly update boot_command_line
> in this situation.
>
> Fixes: 8fd6e05c7463 ("arch: riscv: support kernel command line forcing wh=
en no DTB passed")
> Signed-off-by: Wenting Zhang <zephray@outlook.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

