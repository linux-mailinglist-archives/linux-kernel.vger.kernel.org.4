Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAC722ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjFESjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFESjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0BAEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC6561597
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6422CC433D2;
        Mon,  5 Jun 2023 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685990356;
        bh=33+KTPIjPakdBxCr6qfiCLnamUiHY+NjSa8DozXb0qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o/iwLQHCoNd7FLrkgJNiVjXsBomsWPngNGuK9A/Zf0WcwHYrFOLpEoooPn8j0t79T
         +rg5f8MTO/QxHt46ePHsDL5Waf/h6XNHmjw9bPLGEuen+YIJnIcdCdhcr3Tk6MA+fv
         R30t50LVXJ4LpX06A4Y+EnqFhFML5fPCattWPxGfob4GVQUxQDUgEXFo82F+MusJ54
         14mCk5vMS78FLCoeeulOEYrS3s50gG/e4vhqTXSMqex7myFHUXzhf/20RvQQVhBdhK
         bbS++cVXnht0zwzUc/uOF3WOFMoyOZZx7TX+M9ejUL72dTuK86/aqbPZgk68Ca+Zmd
         F+gvWp2C248bw==
Date:   Mon, 5 Jun 2023 11:39:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pengdonglin@sangfor.com.cn,
        huangcun@sangfor.com.cn
Subject: Re: [PATCH net-next] net: ethtool: Fix out-of-bounds copy to user
Message-ID: <20230605113915.4258af7f@kernel.org>
In-Reply-To: <f6ad6281-df30-93cf-d057-5841b8c1e2e6@sangfor.com.cn>
References: <20230601112839.13799-1-dinghui@sangfor.com.cn>
        <135a45b2c388fbaf9db4620cb01b95230709b9ac.camel@gmail.com>
        <eed0cbf7-ff12-057e-e133-0ddf5e98ef68@sangfor.com.cn>
        <6110cf9f-c10e-4b9b-934d-8d202b7f5794@lunn.ch>
        <f7e23fe6-4d30-ef1b-a431-3ef6ec6f77ba@sangfor.com.cn>
        <6e28cea9-d615-449d-9c68-aa155efc8444@lunn.ch>
        <CAKgT0UdyykQL-BidjaNpjX99FwJTxET51U29q4_CDqmABUuVbw@mail.gmail.com>
        <ece228a3-5c31-4390-b6ba-ec3f2b6c5dcb@lunn.ch>
        <CAKgT0Uf+XaKCFgBRTn-viVsKkNE7piAuDpht=efixsAV=3JdFQ@mail.gmail.com>
        <44905acd-3ac4-cfe5-5e91-d182c1959407@sangfor.com.cn>
        <20230602225519.66c2c987@kernel.org>
        <5f0f2bab-ae36-8b13-2c6d-c69c6ff4a43f@sangfor.com.cn>
        <20230604104718.4bf45faf@kernel.org>
        <f6ad6281-df30-93cf-d057-5841b8c1e2e6@sangfor.com.cn>
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

On Mon, 5 Jun 2023 11:39:59 +0800 Ding Hui wrote:
> Case 1:
> If the user len/n_stats is not zero, we will treat it as correct usage
> (although we cannot distinguish between the real correct usage and
> uninitialized usage). Return -EINVAL if current length exceed the one
> user specified.

This assumes user will zero-initialize the value rather than do
something like:

	buf = malloc(1 << 16); // 64k should always be enough
	ioctl(s, ETHTOOL_GSTATS, buf)

	for (i = 0; i < buf.n_stats; i++)
		/* use stats */

:(

> Case 2:
> If it is zero, we will treat it as incorrect usage, we can add a
> pr_err_once() for it and keep to be compatible with it for a period of time.
> At a suitable time in the future, this part can be removed by maintainers.
