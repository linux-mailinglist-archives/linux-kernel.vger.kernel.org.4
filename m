Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4864E5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLPBhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLPBhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:37:03 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6632F026
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671154621; x=1702690621;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R3LMaKP/CM5OTKDx/LYRMNxUfE2LzWDEN0GY7X/wPpA=;
  b=e2XoyqtTBaT+Z/tS3VMzHxaImNdjZbtfrejo13fDLhMTCYc3WHpOIbWC
   abU8VrFicTrszzkV+il3SI4RegrlxqJPf2bm/XAmBtVA1bx5fagNjujQL
   WD5+na1BT9fYA0ocszd/DqYE8AF5wM1FxqPesYw6OXwcyDPAsMvdF+c1R
   ejmcplAjCfcZ4RFhe9n1TdFOnpgA2cx+fXNOewK7LYqsZd5Dn3Y3FVqkZ
   gNJ85T3LhOqqFXyEMnLhMCVpIHneO8hrWr5bcN7oPRHZZcGtRTM04xP8i
   HJJdu38ImlkLtePetIIqclUB9UVPFD/lvMiT3A7gWFokJi9dHwQbJ8j3P
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665417600"; 
   d="scan'208";a="216993582"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2022 09:37:00 +0800
IronPort-SDR: s82+dmxXAheRzcKuD48PJi4BwAwOeW3ijagbny9juf53ntL63RVTF79+PVqdqyrFdi5hxH9aEo
 agOzqLizxqu2IfqRUtHpjAPrUo6q+JxRmfrorD0aiDqOpJnR9cW0zthYOS9eAtS7dWwatQkmqf
 hFaln7kRmuTIOrhVXlIvdDZuIQKmIzPQj4BL0s6WOOztSr21xTSgnlzJ7L+NQ4+0K+kbwqe1q/
 4vHCjDe7d5DCQzPvQNERXXbChUb4TMGK0DOVg9cd3xzsRUSCaoZOiZLo1WKFOuOl4Pk+hcHuwO
 MuY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 16:49:36 -0800
IronPort-SDR: NAc52oDWYeTmWD22lcJw0oXWon8G3OenVuOpa0uy+OPBHA1DVTcncTZzL6WpYdubOzn6zVAnMF
 gLfVcyiXLnPeS6X861EoH6pylxMSsuhfBTljQV1X9gJdt1B1ge+icjP41RhvvpN71OXCbJOrDU
 ytWTAPdjbRDv+AYaw+XV9TGUoQZgUfx8x3XxKts3PWs2QQmmm2OpDTtpm9MLo6f+kUWVqh8aXb
 52coQ7xiENRKhM79G4Zd7ccKvzC+LMSlHOaI4G/eOudmrxHsnTwGT6a2K567d4Bb5yMA2V/RFh
 /Sw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 17:37:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NYBXr2652z1RvTp
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:37:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671154619; x=1673746620; bh=R3LMaKP/CM5OTKDx/LYRMNxUfE2LzWDEN0G
        Y7X/wPpA=; b=smhASSGxMWHQQllMaOPC+tDqASAmhtjBeW5+TMpbuw0YDuXqseE
        4JBxwSoKpHufX3gk6+FuRS0u55Yexba6VHq1MFo3UoRR5Nk+GjJ644BWJqbQ2RgG
        DTy0BF+UtrylveMLPmzOOpwh5BEcFBnO/xZE+1d4PBESDHYPk/C+++cLPvLmIOiP
        eBqg82OpQDHgudi07EgEfqRx9FX5Jr6jzvSZ2SL/xiaUjFrxMKyDDJVflgRwc4eh
        JabChcGp+TnEk/MrCirDZZ7u+6PKoJlvQraTaP+9os1/ldbf5BL3b2yxDBsgW/bO
        Wdm1b7ELuoSKui76033T3nptuBGYh4ektLA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WCwa4Ik7XnKr for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 17:36:59 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NYBXp0lcnz1RvLy;
        Thu, 15 Dec 2022 17:36:57 -0800 (PST)
Message-ID: <958736d1-918b-d1a0-d6f2-0841f4470803@opensource.wdc.com>
Date:   Fri, 16 Dec 2022 10:36:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V10 8/8] block, bfq: balance I/O injection among
 underutilized actuators
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-9-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221209094442.36896-9-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 18:44, Paolo Valente wrote:
> From: Davide Zini <davidezini2@gmail.com>
> 
> Upon the invocation of its dispatch function, BFQ returns the next I/O
> request of the in-service bfq_queue, unless some exception holds. One
> such exception is that there is some underutilized actuator, different
> from the actuator for which the in-service queue contains I/O, and
> that some other bfq_queue happens to contain I/O for such an
> actuator. In this case, the next I/O request of the latter bfq_queue,
> and not of the in-service bfq_queue, is returned (I/O is injected from
> that bfq_queue). To find such an actuator, a linear scan, in
> increasing index order, is performed among actuators.
> 
> Performing a linear scan entails a prioritization among actuators: an
> underutilized actuator may be considered for injection only if all
> actuators with a lower index are currently fully utilized, or if there
> is no pending I/O for any lower-index actuator that happens to be
> underutilized.
> 
> This commits breaks this prioritization and tends to distribute
> injection uniformly across actuators. This is obtained by adding the
> following condition to the linear scan: even if an actuator A is
> underutilized, A is however skipped if its load is higher than that of
> the next actuator.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Davide Zini <davidezini2@gmail.com>
> ---
>  block/bfq-iosched.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 527def05ce44..0ec8310331e1 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4830,10 +4830,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
>  
>  /*
>   * Perform a linear scan of each actuator, until an actuator is found
> - * for which the following two conditions hold: the load of the
> - * actuator is below the threshold (see comments on actuator_load_threshold
> - * for details), and there is a queue that contains I/O for that
> - * actuator. On success, return that queue.
> + * for which the following three conditions hold: the load of the
> + * actuator is below the threshold (see comments on
> + * actuator_load_threshold for details) and lower than that of the
> + * next actuator (comments on this extra condition below), and there
> + * is a queue that contains I/O for that actuator. On success, return
> + * that queue.
> + *
> + * Performing a plain linear scan entails a prioritization among
> + * actuators. The extra condition above breaks this prioritization and
> + * tends to distribute injection uniformly across actuators.
>   */
>  static struct bfq_queue *
>  bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
> @@ -4841,7 +4847,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
>  	int i;
>  
>  	for (i = 0 ; i < bfqd->num_actuators; i++) {
> -		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
> +		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
> +		    (i == bfqd->num_actuators - 1 ||
> +		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
>  			struct bfq_queue *bfqq =
>  				bfq_find_active_bfqq_for_actuator(bfqd, i);
>  

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

