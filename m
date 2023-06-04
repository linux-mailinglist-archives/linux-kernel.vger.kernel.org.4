Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58AE7218E7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjFDRrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 13:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68AAF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 10:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D573C60FF5
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 17:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF716C433D2;
        Sun,  4 Jun 2023 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685900840;
        bh=L/YT96vOzfrD5Zbb2hKA+7cau17vtyz43WIU+qXB61k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bssiVLw+CmolrmdLynpKWU7Hg2h5P9/4yphu+aZQP8yn6Z9CRv+oC8r3PIYuhyj+w
         kAwhaQeHgR9wBGGop1rzGFdh24x/OooN3lxpucq1CJ7rrFN+yMlGypkzbyYcX0lBZn
         AVhrvpNU0Aua6anhLhanMt6XlQ672pqyW+65BOlXEl6thV8Ca+UYJtjEYYTXYnhgPT
         H1Ku3dFaAjEMgcdOlZ42pJ+XTzVWGbh+FTThhW1ABtwQWIpVctMktHrqFFw+//HFWe
         5oKpWGndOoFu8IjYFESL0zgEW6Hk3QVYFXRUniNsfLosQKoHLz0fsUN+Po10SUJvmF
         M7RjP2hoev/Hg==
Date:   Sun, 4 Jun 2023 10:47:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pengdonglin@sangfor.com.cn,
        huangcun@sangfor.com.cn
Subject: Re: [PATCH net-next] net: ethtool: Fix out-of-bounds copy to user
Message-ID: <20230604104718.4bf45faf@kernel.org>
In-Reply-To: <5f0f2bab-ae36-8b13-2c6d-c69c6ff4a43f@sangfor.com.cn>
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

On Sat, 3 Jun 2023 15:11:29 +0800 Ding Hui wrote:
> Yes.
> 
> I checked the others ioctl (e.g. ethtool_get_eeprom(), ethtool_get_features()),
> and searched the git log of ethtool utility, so I think that is an implicit
> rule and the check is missed in kernel where the patch involves.
> 
> Without this rule, we cannot guarantee the safety of copy to user.
> 
> Should we keep to be compatible with that incorrect userspace usage?

If such incorrect user space exists we do, if it doesn't we don't.
Problem is that we don't know what exists out there.

Maybe we can add a pr_err_once() complaining about bad usage for now
and see if anyone reports back that they are hitting it?
