Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE096A757E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCAUkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAUkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:40:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FAF49881;
        Wed,  1 Mar 2023 12:40:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BFE2B8102B;
        Wed,  1 Mar 2023 20:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1956BC433EF;
        Wed,  1 Mar 2023 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677703206;
        bh=3T5u7dkDAsPrbxEHx+00olxtswdTDxmHeL8X++DQMz0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bBY4zDWuO3/5/do1ue34nu9FOpW4N7sgq2tmlErMuJlJYNCRoajpWMBmwvFXg2GPh
         58p0cuEJczQEDWdcEC2NM/wcRYiLBdhovE3aEIES67TMFjNbTs2AlvZwuak/UDwfD9
         wHnvwYva8TGq3WRCHEerHIyrT5MrW+GIEZHcxHMGMlw1AJM4ktmTlgdLPEUsvwvfIS
         qDtWCx8yIsPa/pqD/lN3kgdhnMsponE0AV2UA8rpXKtwzpTb7uw9JaM9a4iMB/CIfL
         c4ri/tTeFKfIllKmIDKRCwEOrheD50zhsBtpG4Bnm77QxkvdtvB+tj6MHK/1CREhba
         DmEQFxfV6bMKw==
Message-ID: <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230301012506.1401883-1-saravanak@google.com>
References: <20230301012506.1401883-1-saravanak@google.com>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using CLK_OF_DECLARE* macros
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Date:   Wed, 01 Mar 2023 12:40:03 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2023-02-28 17:25:06)
> The CLK_OF_DECLARE macros sometimes prevent the creation of struct
> devices for the device node being handled. It does this by
> setting/clearing OF_POPULATED flag. This can block the probing of some
> devices because fw_devlink will block the consumers of this node till a
> struct device is created and probed.

Why can't you use CLK_OF_DECLARE_DRIVER()?

>=20
> Set the appropriate fwnode flags when these device nodes are initialized
> by the clock framework and when OF_POPULATED flag is set/cleared. This
> will allow fw_devlink to handle the dependencies correctly.
