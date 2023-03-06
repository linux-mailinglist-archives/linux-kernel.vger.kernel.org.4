Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FC6AD1C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCFWlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFWlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:41:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BA72033;
        Mon,  6 Mar 2023 14:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D85FB80EB9;
        Mon,  6 Mar 2023 22:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02359C433D2;
        Mon,  6 Mar 2023 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678142474;
        bh=u9uGh4pi784kK/BdrEWdlErP4vljBHvgMSyzioqQplY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ip9f8Hne+4n32QOvIfj1Q0VWOEfjj+Gv9Xt56nJ7n6E/U7BB6ipsGjQLEkUrkKBH5
         X8z6Iv/4C1kyrGgImFAWZ4PP1REHhRD9BKCE2UDsHMmMVndKqMEx7JlU/0xekKNkmh
         1snJPo9fNXmEwb1RsocN7MDmaX6fGXI2xpQR283vJLIbN7IU2qjLpZmZIPfKy0tZPo
         qNZlLibu9fYBGeO5qnLyaExJtdFY5xc4br6yReOc/06Uc3xKIK59jWwMLmeKC8TXV7
         8TBaql55HOU8Iyj0vUMCLTNr4AfjUuRRY8qX+hJqdojw3WqyNAG6mCsx1OEgeMJus9
         jfKdEk6H62jfA==
Message-ID: <774cb6d15fef0e0b41e7a071eedef980.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230301002657.352637-2-Mr.Bossman075@gmail.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com> <20230301002657.352637-2-Mr.Bossman075@gmail.com>
Subject: Re: [PATCH v3 1/3] clk: k210: remove an implicit 64-bit division
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
To:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-riscv@lists.infradead.org
Date:   Mon, 06 Mar 2023 14:41:11 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jesse Taube (2023-02-28 16:26:55)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The K210 clock driver depends on SOC_CANAAN, which is only selectable
> when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
> have been sent for its enabling. The kernel test robot reported this
> implicit 64-bit division there.
>=20
> Replace the implicit division with an explicit one.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel=
.com/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---

Seems better to merge this one-liner earlier to unblock 32-bit.

Applied to clk-fixes
