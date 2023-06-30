Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956D7743EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjF3PdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjF3PdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7230C4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D9661775
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE9C433C8;
        Fri, 30 Jun 2023 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688139130;
        bh=AaZqyPu4KBOIBEEtN7KU734n/yfJRfTaIKV/pcXHMI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GWkZU+NBE41XcbwVwdV3ZqQxJF1C0sDONYK/q0gkBc2mYZ86dnEMCJBYRdvBdpWTZ
         /IY5xBnjRyatC/zVUooQpVgyk7rbJQEVukFcqEA1+oASVvNBHy/MD6DUIZTXecQ1Yd
         2g8o6ut49TDe7nn/YdRRCI/MmHfzkXmInTyR4NgJN2iCxVndPhu/r8S4GLlHbwVHpb
         e6NO4AtYUZieIYMr8HkhTlKgsy46tjaXaj+ao2NVUlSGmap+5Cg7013PKXqkAqtEPh
         mIrpyy5ryVJSChhFFvAfjyjieKw4WFoJnIV3Zh/JMMvRcn0QNO4+Ez96FeHpynWYlL
         GucCEsuGsWLMQ==
Date:   Fri, 30 Jun 2023 08:32:09 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: Destroy previously created kthreads after
 failing to set napi threaded mode
Message-ID: <20230630083209.05efaeaf@kernel.org>
In-Reply-To: <20230630054353.28934-1-qiang.zhang1211@gmail.com>
References: <20230630054353.28934-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 13:43:53 +0800 Zqiang wrote:
> When setting 1 to enable napi threaded mode, will traverse dev->napi_list
> and create kthread for napi->thread, if creation fails, the dev->threaded
> will be set to false and we will clear NAPI_STATE_THREADED bit for all
> napi->state in dev->napi_list, even if some napi that has successfully
> created the kthread before. as a result, for successfully created napi
> kthread, they will never be used.
> 
> This commit therefore destroy previously created napi->thread if setting
> napi threaded mode fails.

Please don't send two patches in less than 24h, unless someone asks you
to on the list. A lot of people read the list from the oldest postings,
won't notice the newer one, and it will split the discussion.
-- 
pw-bot: cr
