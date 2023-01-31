Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2B682B11
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjAaLCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjAaLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:02:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0799A234FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1A1FB81B07
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB567C4339C;
        Tue, 31 Jan 2023 11:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675162928;
        bh=bRqEfY10DI/ElKGgak14w3PjLKkH8pmgrhnheNwGgN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7zpcfwadDkHKiNV5OrUEOKg6NEgMt/0LZUzqLffFMVlYaRROJJOyfuKkyNSvjqlf
         YWAYmgUgYN3cWvQUtJVphPaknR8sKy3Teghj19R9O8EcNxYVf85MSwoRKC5GfOFcDk
         lHgKCSz2hYTWuErEMWuo8ScdqVR76q82YY5bUyUeRPOd+QoF+Os8PuTooLzTi3bt4j
         nQrXHk5DyxbRieRLp1yfBbfAdzy1R4gHaL51ShopJhO2qxkXYTXrOc8jlKHgYPCtJ+
         /uADFWgkv/CqFEPWNTzOe/8HccTC63ldz0e5F8r+x71ERRz7D159QE4E3F/qpJgpnn
         Jv8Dcd90U7pGg==
Date:   Tue, 31 Jan 2023 16:32:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/8] soundwire: stream: Add specific prep/deprep
 commands to port_prep callback
Message-ID: <Y9j1LNjmHxex/HLy@matsya>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127165111.3010960-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-23, 16:51, Stefan Binding wrote:
> Currently, port_prep callback only has commands for PRE_PREP, PREP,
> and POST_PREP, which doesn't directly say whether this is for a
> prepare or deprepare call. Extend the command list enum to say
> whether the call is for prepare or deprepare aswell.
> 
> Also remove SDW_OPS_PORT_PREP from sdw_port_prep_ops as this is unused,
> and update this enum to be simpler and more consistent with enum
> sdw_clk_stop_type.
> 
> Note: Currently, the only users of SDW_OPS_PORT_POST_PREP are codec
> drivers sound/soc/codecs/wsa881x.c and sound/soc/codecs/wsa883x.c, both
> of which seem to assume that POST_PREP only occurs after a prepare,
> even though it would also have occurred after a deprepare. Since it
> doesn't make sense to mark the port prepared after a deprepare, changing
> the enum to separate PORT_DEPREP from PORT_PREP should make the check
> for PORT_PREP in those drivers be more logical.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
