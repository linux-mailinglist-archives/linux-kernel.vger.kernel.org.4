Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4D605E79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJTLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJTLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB5A14D8E3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72309B82708
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14DC433C1;
        Thu, 20 Oct 2022 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666264211;
        bh=w1WFkUCsuFyQqm5gIbtA0BNFyxV8B+fFrdl4wWjex2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUErpRO4VMh/7RsU+Q1UJvaPc411910wXfkC0IAUEHWFXF2jKOZIS89Fyqo0/WZIT
         j4v+40xtxHsaYS0lS1Mv8UhOPQ41Co4UlEtN4hrnRq85L2mOd2ZwU5JOavlFZEfA1E
         IBw2SrW9bdx1lPSlwMkqIUfASioaeUq7uNZL2fks=
Date:   Thu, 20 Oct 2022 13:10:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ubuntu <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: Request for assistance
Message-ID: <Y1EskCZF7qkiPW2O@kroah.com>
References: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:00:59AM +0000, Ubuntu wrote:
> Hello,
> I have a diffictly deciding where exactly to split a long line of code. for example, this line of code is too long
> 
> uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
> 
> if i spit it this way:
> uCTSTime =
>         bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
> 
> It does not help as the second line is still too long. I considered doing it this way instead:
> uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
>                                 pDevice->byTopCCKBasicRate);
> But i did this on one of my patches and i was told it is not advisable to split a line between
> parenthesis '(' and ')'

Who told you that?

You are close, the code should look like:
	uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
				     pDevice->byTopCCKBasicRate);

Like millions of other lines in the kernel source tree.  When in doubt,
look at existing implementations.

hope this helps,

greg k-h
