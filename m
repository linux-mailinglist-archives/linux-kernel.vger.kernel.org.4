Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B318571EF76
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFAQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFAQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3308195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60095647AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B124C4339B;
        Thu,  1 Jun 2023 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685638108;
        bh=NAEpQiWq9IAmY1tOE/V+2ZvrYEYSuad9TRbmAHGYccY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cKyGGBptkS8lmAm8KpkDIU5YS0wj2xi1fEgibcRpwQyssiRTp1BlZ1tCCyHN6Qf6c
         LbIZQtpDWJcV8KRO5ViUQG2tgjKnjhDI3EsB1PYp77fGmNLAlgVsi9CE/VFwkhKDGR
         qp1DpNDICBS5pdcK4bQcmZL7fUJION6LVDmwDGigwu+yisY1Vuf+q6K4OfTbqgJ952
         hKwGkCs6xWwXt8fSsK+kCQdD46SSC2g7/YGpdU1ocwRHep9p5XwdegjzXFbRypIukl
         BkpMhL9DosyJfIVzMAiQ/8b5/IzfsGR4sCnuo/yYMFaW1PIY8YjfCvSfUK6wZ/MJod
         rGiNHpNoxxi4A==
Date:   Thu, 1 Jun 2023 09:48:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Christian Brauner <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] connector/cn_proc: Performance improvements
Message-ID: <20230601094827.60bd8db1@kernel.org>
In-Reply-To: <B9B5E492-36A1-4ED5-97ED-1ED048F51FCF@oracle.com>
References: <20230331235528.1106675-1-anjali.k.kulkarni@oracle.com>
        <20230331235528.1106675-6-anjali.k.kulkarni@oracle.com>
        <20230601092533.05270ab1@kernel.org>
        <B9B5E492-36A1-4ED5-97ED-1ED048F51FCF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 16:38:04 +0000 Anjali Kulkarni wrote:
> > The #define FILTER and ifdefs around it need to go, this much I can
> > tell you without understanding what it does :S We have the git history
> > we don't need to keep dead code around.  
> 
> The FILTER option is for backwards compatibility for those who may be
> using the proc connector today - so they do not need to immediately
> switch to using the new method - the example just shows the old
> method which does not break or need changes - do you still want me to
> remove the FILTER? 

Is it possible to recode the sample so the format can be decided based
on cmd line argument? To be honest samples are kinda dead, it'd be best
if the code was rewritten to act as a selftest.
