Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BA96A7596
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCAUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCAUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:48:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC88618F;
        Wed,  1 Mar 2023 12:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27FFEB8102B;
        Wed,  1 Mar 2023 20:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C00C433D2;
        Wed,  1 Mar 2023 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677703716;
        bh=VPTv1A4287bwDiH9IK6PQ594XUhisaUOXpP3BbU7cgg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nwO7VKWYtEXDtmlTuzjAl+wakycKAXOeB/WAtDeGh7jrXxsac1GxCslkuCUaDlZF3
         pJ4rbWOfuWBoQbrt3L7Cz3p9AM2w5gzvGbKCtCNq85Rq3gS4A5L1Ujd6WbYVMvnVIy
         9hPDpmo+G+JcVgt/uvMUyO85BDnIsRLe3ZUJAJD5HEmbtX23J0D/5XWxuXpYaPtAn0
         XLwI8gfA1SDK8Eio29VTtbi6cOmFCwFJp+fPEoEEyfjSN1NVJsRTcejbg3dmp8CEBG
         9h5iKoDlofWTYascGYnKj1g/8ChM/HuErfis69Qd5DbyiSJy3wXDh0vWAzgsb29tSN
         wMzQ43HHK13LQ==
Message-ID: <7cca9a24b24d849565cd6a4f40ddbee9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org>
References: <20230301012506.1401883-1-saravanak@google.com> <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using CLK_OF_DECLARE* macros
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Date:   Wed, 01 Mar 2023 12:48:34 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-03-01 12:40:03)
> Quoting Saravana Kannan (2023-02-28 17:25:06)
> > The CLK_OF_DECLARE macros sometimes prevent the creation of struct
> > devices for the device node being handled. It does this by
> > setting/clearing OF_POPULATED flag. This can block the probing of some
> > devices because fw_devlink will block the consumers of this node till a
> > struct device is created and probed.
>=20
> Why can't you use CLK_OF_DECLARE_DRIVER()?

Ah I misunderstood. CLK_OF_DECLARE() _always_ prevents the creation of a
struct device for the device node being handled. The 'sometimes' threw
me off.

>=20
> >=20
> > Set the appropriate fwnode flags when these device nodes are initialized
> > by the clock framework and when OF_POPULATED flag is set/cleared. This
> > will allow fw_devlink to handle the dependencies correctly.

How is this different from commit 3c9ea42802a1 ("clk: Mark fwnodes when
their clock provider is added/removed")? Do you have some user of
CLK_OF_DECLARE() that isn't registering an OF clk provider?
