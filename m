Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B55EEA73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiI2AQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiI2AQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FF9118DCF;
        Wed, 28 Sep 2022 17:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A441860F09;
        Thu, 29 Sep 2022 00:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02029C433B5;
        Thu, 29 Sep 2022 00:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664410566;
        bh=LjaUXBIlmXcjGmqVHUKWhe2O7/mvO/3uzoLRWvl8Fwc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F/BqVPcnqizMU7KgAVnJNReZBIbYfdEyBVavrodWlHIfOdE5EVKa2mMI9WCMkx1vI
         JzVPkEwkaWEq9ZceEDFaIncjzonNpye3UF2Ca+WlQN3dkIdfUBfirhZpZuQSeASQJj
         7Y4mSDHbLg++dPZl5s4IbJNMhHxtP3o3WDXIkPnPcRcYEW+bpmGnRHB/fhOveZ28eZ
         gt4jb+cucpuSatdKKWKGSMcU7w77lNdhZbDD9i46tLkpKnOVEQVsGrYiZ0kVNrUT+q
         vwZdNMu5ipy5RpuoCkXgZHB4e84MVfHh9xGAx3AW5iSYhNR5N6XQf+7OtQZYmhAaSK
         n5gZj0sJ/gYiA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <be8772d962788a3d8a37c1f02abaa9821606a6bb.1663827071.git.rtanwar@maxlinear.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com> <be8772d962788a3d8a37c1f02abaa9821606a6bb.1663827071.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH RESEND v2 2/5] clk: mxl: Remove unnecessary spinlocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 28 Sep 2022 17:16:02 -0700
User-Agent: alot/0.10
Message-Id: <20220929001606.02029C433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-09-21 23:24:25)
> This driver is now switched from direct readl/writel based register
> access to regmap based register acceess. Regmap already has its own
> lock to serialize the register accesses across multiple cores.
>=20
> Hence, there is no need for additional spinlocks in the driver.
> Remove all spinlocks which are no longer required.

Can you confirm that the driver doesn't do a read, modify, write (rmw)
sequence where during the modification another CPU can rmw and corrupt
the previous "read"?
