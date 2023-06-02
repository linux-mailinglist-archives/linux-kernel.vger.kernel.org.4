Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E3720C2B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjFBXCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFBXCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB818D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3F561F55
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 23:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06931C433EF;
        Fri,  2 Jun 2023 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685746936;
        bh=fYigfzOcxFRHWwMscO3wkkw2DhR7y12cBw39ZlnS/xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oB0OrsCFyKp9cVcnqvB62uPXOvyifqR2n6b6yPImGYflokBzsNLq47jhgqq/T+qej
         J3PdMOqW9QCUXk/R+JYml5trXX3bbbWANTwNXP+0vjQYFaCnp7rV984jHc/lSfNfG7
         1cbuhm7dSrZUBH7aa4MhVNZntmDheES4zdwqVYkqLBSmNCFeZ+8IsveCNykKouJoYO
         uthIHns3ldgqEGKkHGssBw2qT/5xzisxuDvh72+Ch4D0LEORzs12efIZE6znLaR1FJ
         IA4DUKPc8ITCSXeGU+1nMW+ms8wdNq/5pqNIj06CThXT+y9slnNH85y5/2sHDTBv75
         Qp1I6bb1x22DQ==
Date:   Fri, 2 Jun 2023 16:02:14 -0700
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
Message-ID: <20230602160214.292749c9@kernel.org>
In-Reply-To: <F283FB65-7F15-4137-9182-0A20D6A0338D@oracle.com>
References: <20230331235528.1106675-1-anjali.k.kulkarni@oracle.com>
        <20230331235528.1106675-6-anjali.k.kulkarni@oracle.com>
        <20230601092533.05270ab1@kernel.org>
        <B9B5E492-36A1-4ED5-97ED-1ED048F51FCF@oracle.com>
        <20230601094827.60bd8db1@kernel.org>
        <FD84A5B5-8C98-4796-8F69-5754C34D2172@oracle.com>
        <20230601101514.775c631a@kernel.org>
        <F283FB65-7F15-4137-9182-0A20D6A0338D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 22:23:01 +0000 Anjali Kulkarni wrote:
> > Not much, really. I think the requirement is to exit with a non-zero
> > return code on failure, which you already do. 0 means success; 1 means
> > failure; 2 means skip, IIRC.
> > 
> > The main work in your case would be that the selftest needs to do its
> > checking and exit, so the stimuli must be triggered automatically.
> > (You can use a bash script to drive the events.)  
> 
> Thanks! So this will be part of the kselftest infra right? 
> https://docs.kernel.org/dev-tools/kselftest.html ?

Yes, that's right.
