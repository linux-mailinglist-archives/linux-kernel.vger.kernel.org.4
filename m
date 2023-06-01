Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8A71EEC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjFAQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFAQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0912C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96FCD64768
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED4CC433EF;
        Thu,  1 Jun 2023 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685636735;
        bh=l+ePt2FK/APO/1bTWCYSOwRV2JM29PgMTmVaxf/Mphc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q0tYBZgeh4013ojgqKPLYi6x96r7Ti5V2Ktnt/3TYb8wgXzKl6wvhCKErR1g3LbVN
         wncTukwRfrRNOE0ytbgH6KBqeJV6Cfk1wzfr3vLCSxJBlWllur4x3a2lFahdGV8xuN
         mSJyPGFiPOhMMVIj8x24rgsBjJjsfqCkEZ1wYlrDlx8dTJEANTmJ1II4tbqGU59kXW
         IcH3wFd/sZoqsFf74DHZEuY2l/GJzL+fsddAXinMDgnMuPREUEmFCntM33fW9WymQc
         jKMgHrKV9IaFKChzU4ShLrnby6SAztN50LFv7oBLvgxmgx1PbGYVmAYBwwhVNsLNRx
         aexSuitIw59zw==
Date:   Thu, 1 Jun 2023 09:25:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        zbr@ioremap.net, brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/6] connector/cn_proc: Performance improvements
Message-ID: <20230601092533.05270ab1@kernel.org>
In-Reply-To: <20230331235528.1106675-6-anjali.k.kulkarni@oracle.com>
References: <20230331235528.1106675-1-anjali.k.kulkarni@oracle.com>
        <20230331235528.1106675-6-anjali.k.kulkarni@oracle.com>
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

On Fri, 31 Mar 2023 16:55:27 -0700 Anjali Kulkarni wrote:
> +#define FILTER
> +
> +#ifdef FILTER
> +#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
> +			 sizeof(struct proc_input))
> +#else
>  #define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
>  			 sizeof(int))
> +#endif

The #define FILTER and ifdefs around it need to go, this much I can
tell you without understanding what it does :S We have the git history
we don't need to keep dead code around.
