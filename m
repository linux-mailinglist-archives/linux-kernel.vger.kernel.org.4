Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1486106CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiJ1A1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ1A1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:27:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A198C96;
        Thu, 27 Oct 2022 17:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6285B82712;
        Fri, 28 Oct 2022 00:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A81C43470;
        Fri, 28 Oct 2022 00:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666916830;
        bh=ar2vAUeJp1Fss0BY6YHlg7m1SFzX7KDPJuR8DDTS1Pw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gvEH3r80quhFTCgGtDp6SZsI4k7FrSXzRy0dSujUUpq1JAOjEgAbE6rTq2t969c8E
         ZyCoO3BgUIfu/hP9JmW/5d5ptATjoHcAgKn+zuAdyEEWgbSeYqdsZvsW3Ip/OqbDCm
         Ju4LMPz7t/aVo8hVLaMztaKUZII4Q8WXY4a/lqBUBAVWs/WN+yb9EfIssq5V+xXilg
         UbBKm1dDzEAApR5QDh7L+sevwZ/8qFJOHzS8muBD5PaZmOL1EDrd8dw66JiVGywwBg
         EHAKjnh4rGkBj9d0yjczw9xeCOmaYTC0ZCP+klt7lN/Z1anhZvJz+PbHQuv4+B9W5T
         T3JZAw3XOpzgQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018160352.1591428-1-dario.binacchi@amarulasolutions.com>
References: <20221018160352.1591428-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v2] clk: ti: dra7-atl: don't allocate `parent_names' variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        kernel test robot <lkp@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Oct 2022 17:27:08 -0700
User-Agent: alot/0.10
Message-Id: <20221028002710.89A81C43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2022-10-18 09:03:52)
> diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
> index ff4d6a951681..78482d1a4a33 100644
> --- a/drivers/clk/ti/clk-dra7-atl.c
> +++ b/drivers/clk/ti/clk-dra7-atl.c
> @@ -188,24 +188,17 @@ static void __init of_dra7_atl_clock_setup(struct d=
evice_node *node)
>                 goto cleanup;
>         }
> =20
> -       parent_names =3D kzalloc(sizeof(char *), GFP_KERNEL);
> -
> -       if (!parent_names)
> -               goto cleanup;
> -
>         parent_names[0] =3D of_clk_get_parent_name(node, 0);

Can you use struct clk_parent_data instead and assign index to 0? Then
we don't even need to use of_clk_get_parent_name() here.
