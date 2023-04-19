Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C879A6E7EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjDSPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDSPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3AB763
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F61625B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F423C433EF;
        Wed, 19 Apr 2023 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681919370;
        bh=6BEx8wgaCpg8XmB3hRUKMSTOEy3ZNoEAUnUvTeDGYw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EI37X4dJYvc72ZSriDDOIKM6RPmEssYj7rxwvrIowUvGX8PFIvC2kV91I3TdDGcCj
         q0S/PBJVv0WmQQoNHUo9WSynhOb10AvpLObg7tpXCJRE0oo3xlA/5CY3oVfKwRREtI
         /1Jd72IvOCxdXE85gxyq661kbPJ19XGGfm9+f+XyrpdLul/0d4J/aTRqz6yUd6yG14
         ZL7cvNXiflJqDq3klujdbGC7e0rv69jR0bsnrj0ix/VO8AwlNSNKHaLQ6zo02gZGdL
         ilDJHPyQfw4wxnb+RZ2a4sSKeDNLk7RGl/TYqfvh3EyhguSybVuM/sCDVAvLM5tk7Y
         OFpj/a5zG6UmA==
Date:   Wed, 19 Apr 2023 16:49:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230419154924.GB9904@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <d74c94a6-77d1-41f1-82e4-a046f7935aee@sirena.org.uk>
 <20230414113254.4e0618c5@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230414113254.4e0618c5@donnerap.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023, Andre Przywara wrote:

> On Thu, 6 Apr 2023 14:49:44 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> Hi Mark, Lee,
> 
> > On Sat, Apr 01, 2023 at 01:18:50AM +0100, Andre Przywara wrote:
> > > From: Martin Botka <martin.botka@somainline.org>
> > > 
> > > The AXP313a is your typical I2C controlled PMIC, although in a lighter
> > > fashion compared to the other X-Powers PMICs: it has only three DCDC
> > > rails, three LDOs, and no battery charging support.  
> > 
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> so is there anything Martin and I can do to help this move forward? I
> guess broonie's tag above means that the regulator part is good, so the MFC
> parts can go ahead now?

It's on my list.  Busy time.  Please bear with.

-- 
Lee Jones [李琼斯]
