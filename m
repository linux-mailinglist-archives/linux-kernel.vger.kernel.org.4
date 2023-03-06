Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF036AD18C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCFWbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCFWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:31:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6CF6A05E;
        Mon,  6 Mar 2023 14:31:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00A99CE17F9;
        Mon,  6 Mar 2023 22:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579A0C433EF;
        Mon,  6 Mar 2023 22:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678141862;
        bh=3RH6Lj+D0k6nUlkCe/B+3mDKPE4YWOnpQN8pqKQ5HcM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rUZiYVGpUAjYWJ7YKrIeSgAuVfvEi9RXlhGMflabjnTQfc5fOu3enom8Ki6cJQSjI
         eZ9EW7K2A5ewSuMn055XyiumMlhdLFVrSrtJVaOmvoa76AY4YHvkX1v2mQOOD/MeBN
         jllDtRThZDncZSzM/Yj4h4XibuatmEZH9CwM9o3Xzp1IabmarV+2D6zDbyXbNE87MC
         bpU/sUFHmXtqilR5YcTz6bOZjf7OFdyuAry3tdK5WDNDC/AQ52YWsK2zuVFzpePyDf
         HOieLD/Ksw8DO8WYpWnpTofpwa+ixtBKZy0xstKwXt5/wPTlFcb+azqQk1iQ8zS51S
         OPjNCRb5gr2NA==
Message-ID: <3b0a1481873a2a7c26015fcedcc673b3.sboyd@kernel.org>
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
Date:   Mon, 06 Mar 2023 14:31:00 -0800
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
> diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
> index 67a7cb3503c3..4eed667eddaf 100644
> --- a/drivers/clk/clk-k210.c
> +++ b/drivers/clk/clk-k210.c
> @@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw =
*hw,
>         f =3D FIELD_GET(K210_PLL_CLKF, reg) + 1;
>         od =3D FIELD_GET(K210_PLL_CLKOD, reg) + 1;
> =20
> -       return (u64)parent_rate * f / (r * od);
> +       return div_u64((u64)parent_rate * f, r * od);

The equation 'r * od' can't overflow 32-bits, right?
