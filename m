Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDB6E60A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjDRMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:08:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7439B47B;
        Tue, 18 Apr 2023 05:05:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b9so1546781ljf.13;
        Tue, 18 Apr 2023 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681819514; x=1684411514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46J6GzW9SMxNFr8fYJhfNVMAkEm/oWl1Dzn7CkJE/p4=;
        b=WPBDlfGOW6XlWFMWV5mqklvKP9LPXG3BW1vAhqkuHGDWo6sGPz9hUSHduvSSygVbTp
         l8NCkMm5UDOPogD8MzwlYIHueOvoILh0H+bOPvBHb4uDj576vlxS7VqLt9crV6TcNU/F
         7Ldi28OFAQ3WaHw8nRXYxhrTPHxikbUHKgDkTsmgXRcbl29CUEjJi35AUJlAtC9Dre2U
         3horpkcYuyEzk3tdlT3bd/4lDsSy0Hl4xieZQHax4RCpMcaC5nRQGHVGBzAoDkij+S2u
         kFle/FFxR2vlYYIotcOlOWnJxUj7NRwtgokIn3qvpSYsgEy0fr+5MslDr46bFaIsnDrw
         Mivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819514; x=1684411514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46J6GzW9SMxNFr8fYJhfNVMAkEm/oWl1Dzn7CkJE/p4=;
        b=iqqGQEtbyVyfDuDoREbm97A8zMWd+f65RFJEDjfxfRVIzdplDdqXMFmKTLzHBOtzyN
         HgID0SV+ATHxbNtpLxvTUxvdZw29YsMC3b3cTeCeQySoq8OEmpA7q5nBOQEHWnLvHxyK
         U316/05JhpzV5nPcpTeiDW4FJmc5k3POp94uEIK1NNBt2IceW+pg9ccSzl+63KOhEujP
         iD1vJ7uLWzxocXq0fmsicpKMRXD4cF7XNKGzouDrG33d29dusbFHFpQ3Obzvz0pIemor
         WoMP/i44GkE1viJYSqk/wt0BAAlawAu33TV8Kn/aTgFDKOmAGXPdBlU6A5RsVaZWUOe3
         mW5w==
X-Gm-Message-State: AAQBX9f7CQKwdVITAfwTCxm4uw2LNHidBKQo79GfhaqPv/QmqrJh/jQK
        HXKLNMR9VwSZQJPGnXKbXAM=
X-Google-Smtp-Source: AKy350avhTv+2hMQBXbqPTe3NHvXhZA5uEx+8kQfQXSzFvjJHY1HxupkwepTsTFBOEKKtV2stNW9rg==
X-Received: by 2002:a2e:9a99:0:b0:2a8:a5fc:d0cd with SMTP id p25-20020a2e9a99000000b002a8a5fcd0cdmr644708lji.47.1681819513790;
        Tue, 18 Apr 2023 05:05:13 -0700 (PDT)
Received: from pc636 (host-90-233-216-43.mobileonline.telia.com. [90.233.216.43])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e9b96000000b002a8c1462ecbsm1069879lji.137.2023.04.18.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:05:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Apr 2023 14:05:10 +0200
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Make drain_page_cache() call return directly
 if cache is disabled
Message-ID: <ZD6HdrXAueycm/bX@pc636>
References: <20230418070259.1353785-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418070259.1353785-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:02:59PM +0800, Zqiang wrote:
> If the rcu_min_cached_objs is set to zero at boot params, the
> krcp->page_cache_work will not be triggered to fill page cache,
> and the put_cached_bnode() also does not fill page cache, this
> also means the krcp->bkvcache is always empty, so not need to
> acquire unnecessary krcp->lock to get page from krcp->bkvcache,
> this commit therefore make drain_page_cache() return directly if
> the rcu_min_cached_objs is zero.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c8ba2be026fa..ce995fc1c644 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2924,6 +2924,9 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
>  	struct llist_node *page_list, *pos, *n;
>  	int freed = 0;
>  
> +	if (rcu_min_cached_objs)
> +		return 0;
> +
>
Should we check for zero?

--
Uladzislau Rezki
