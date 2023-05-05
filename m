Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F676F7DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjEEH2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjEEH2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E411B46;
        Fri,  5 May 2023 00:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2316163BD7;
        Fri,  5 May 2023 07:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C2CC433EF;
        Fri,  5 May 2023 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683271708;
        bh=HGcw8Vw0AzQTVV6N2gMPiN/OeHEKIDyg23ka93ctRj4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qTSQOBucqeabhs5gStK3QY/z89vtK5rbUaN1AFcEERtYYIFm3UcKh/2P16HG6K//z
         d+2bkfnjrtpd+rpL6ilQEz1KaIDRRj2z1gdTh/UqwwWZ6ni1NlviqlBpUPg9Wp1z1G
         loIXVNmga3WFkI9sGKAnwuv+L5s62Im1Y9ZS5cDq0AenVMFotdA+mz9Mp60HunwEgT
         kCvTV15TWTt3VDhNnZ+BlLQ0SFVZU1wrTSd/Ja9U4PCRe3bmLTrXl9M6hvgH+wf0RK
         oYDM4oA8+yyY/Dju72VLEhhSrVdVFrKWThK+tjxcUZ7Xn0J0/cL8yPeadH5iJ+rMJF
         4RpLH+TixdBqQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] b43legacy: Add checking for null for
 ssb_get_devtypedata(dev)
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230418142918.70510-1-n.zhandarovich@fintech.ru>
References: <20230418142918.70510-1-n.zhandarovich@fintech.ru>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>,
        Natalia Petrova <n.petrova@fintech.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168327170198.10202.6098292886788823721.kvalo@kernel.org>
Date:   Fri,  5 May 2023 07:28:25 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:

> Since second call of ssb_get_devtypedata() may fail as well as the
> first one, the NULL return value in 'wl' will be later dereferenced in
> calls to b43legacy_one_core_attach() and schedule_work().
> 
> Instead of merely warning about this failure with
> B43legacy_WARN_ON(), properly return with error to avoid any further
> NULL pointer dereferences.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy BCM43xx devices")
> Co-developed-by: Natalia Petrova <n.petrova@fintech.ru>
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>

Dropped per Michael's request.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230418142918.70510-1-n.zhandarovich@fintech.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

