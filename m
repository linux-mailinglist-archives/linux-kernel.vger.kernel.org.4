Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02174692C30
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBKAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKAkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:40:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01171BBB2;
        Fri, 10 Feb 2023 16:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8BD2B825B8;
        Sat, 11 Feb 2023 00:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB74C433D2;
        Sat, 11 Feb 2023 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676076031;
        bh=UKSvG2H35RhhTGJLlKDF+4pw8O05L9n2GRROzIg/SU4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e/A6yRDirseqEyazzRzQcgQUZMWhiGudcK3a6oqPZTePBlvqjCEBVO5+OXijS8cJA
         KT+HzgYgGAkw3DxOTQPB9mxWTE/nuJOnwzpyeIw9hH8xCfflKSJzAjynvorbjr69DF
         1q9ZsesHdXrAgGAatGVSbj8XYcT9/Bko8kTBl7/n9/Nnpu3JvoSaBFAesPjIV5iMdC
         gmXf9qbb8UPFbqqbrOSW1W4w8u634Zi8h1JRx6f75ylOmQd7vUGZHee6zJtOMYW7kP
         WUcNUbYReSEdGNwPORhbgC/rKY6JrtI4nQcSQDh2RKPC/JC8/xOCli6Y5zAdZactYQ
         OI6qcFPtyJtGA==
Message-ID: <e5b71c243022d341022b4f172060268b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230131160829.23369-1-ansuelsmth@gmail.com>
References: <20230131160829.23369-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/2] clk: Warn and add workaround on misuse of .parent_data with .name only
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Feb 2023 16:40:29 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Marangi (2023-01-31 08:08:28)
> By a simple mistake in a .parent_names to .parent_data conversion it was
> found that clk core assume fw_name is always provided with a parent_data
> struct for each parent and never fallback to .name to get parent name even
> if declared.

It sounds like you have clk_parent_data and the .index member is 0? Can
you show an example structure? I'm guessing it is like this:

	struct clk_parent_data pdata =3D { .name =3D "global_name" };

>=20
> This is caused by clk_core_get that only checks for parent .fw_name and
> doesn't handle .name.

clk_core_get() is not supposed to operate on the .name member. It is a
firmware based lookup with clkdev as a fallback because clkdev is a
psudeo-firmware interface to assign a name to a clk when some device
pointer is used in conjunction with it.

>=20
> While it's sane to request the dev to correctly do the conversion and
> add both .fw_name and .name in a parent_data struct, it's not sane to
> silently drop parents without a warning.

I suppose we can do

	WARN(parent->index >=3D 0 && !parent_data[i].fw_name && parent_data[i].nam=
e, ...);

or maybe better would be to make the clk registration fail if there's a
.name field and the index is non-negative and the fw_name is NULL.

Can you grep the code and see if anyone is assigning a .name without a
.fw_name or .index?

>=20
> Fix this in 2 ways. Add a kernel warning when a wrong implementation is
> used and copy .name in .fw_name in parent map populate function to
> handle clk problems and malfunctions.

We shouldn't be copying .name to .fw_name. They're different things.
