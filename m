Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454B16BA4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCOBg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCOBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:36:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68FB1ACF5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678844167; x=1710380167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oplxjgXdM5PxlwEDg42IRu+esUCZcy0BkDT5Uan3IsA=;
  b=FW/y7ZW8cip+isJKx+mbMdVT/76pET1lKJzM7MGUUR3WBS9hyx661GoA
   qZIeLrMrr+WpFQCSQZ6+gtn+dlgYJKG9MZfWA67Vc97mRRD99N7M72XLS
   yd8XE595tCzOtpjvkVDyPYKnE6cTsheFp6MGEqWGpAh8pALa18j5EgnWC
   q7bhPw4J0c/w96zHPSxrqT2Kyx6NFa5VzSZNsDk4A9XwzVh1RaqGz3jxK
   8b3B/6YsHfB4TxfpJIpTrQclU0Bwx7uRlHTd50OnV1IJhayhA9GWE43pd
   r8/e6Xvib/MQeV2jru4XXe8lLF5WobY7YL1C8wlv20KFPOSd9fdvYV9rC
   w==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="330029965"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:35:59 +0800
IronPort-SDR: B0PFZTNoA0UhUOk101EZ95aATIqQRqeX4pP1sxfLUtQbfeGJumV549EuCwZ1tnMZV+vLl09raT
 U9EKYPnw/4yXC5YlKZjwkE4diE9v8oBahqKubaUobeLQI79cpT9JXIpkGgii0Yrqhzo+fE+gqd
 0XDlI2qBtymLpEDN6oxAHVU+Ea1geD3vdD2GZIf2iZJdOcO7R8+j3K+GsrFPawOwk+uoBsglNk
 QuhQSNl1ZthyqYDn4OYDpWNPMaXb6tGaDEub42Yj302rs9BvNwXc2skUIhYhXw7qVHhFzYZeXH
 X9E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:52:26 -0700
IronPort-SDR: xKDcAzUWxSoy4tJYD7kFgZS6YY7AyseGcpQQfD1HUUhCnEP8NecUE38IFqkLO+8IRLdhBDUXkb
 WA8N6DODtFcoTlsLOhz6HuS7FYyzJrybqfDnxbMgbhmvRQpYsbzUewPhr9zvlx5uLn7rTlOOSr
 P4Uc8uY1VkV67bF5RzVHFrHN9dZ54DTsqqqF5J0lFqEo+FXWJt9W0+h8+md7x5FcHafMMruuce
 5Rc7K2//g6XjLDufnN7cIbyVDuzg+b0g7SmO2iJt9EZIGqU6UkKdCa3D/1YesuoS2eUyDjFLJy
 Ujc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:36:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbtJb35wVz1RtVv
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:35:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678844158; x=1681436159; bh=oplxjgXdM5PxlwEDg42IRu+esUCZcy0BkDT
        5Uan3IsA=; b=CGZJpxYm1k6ns4KCac9t0Adn0IgrR+kyLgvehRdaziLjsG1e/2L
        p3JuOXztGyYSgi/hIH9mrRS13fEnPx1JHKVIQdNumBSTFODj/Fg5OsZb3HWH3S/v
        dHyUgTX8udLlBhDZecPMno3yltn83BvgSPy0IqJb3rsSbOCjx9sSonWmMCltIBW7
        dcRCtKWpVl05EDNbgP6Ys0KF9Y7fmv2hBHNBdKj690bAuH/2x8ScCg9Ef0wcpRjm
        U8i5DcvYst45YZFi6CVlTTWOk3xJ15S2LbJEtI7Pz3hz4Ry1fsq2EG61qLHHASDW
        rge4NtpiHV+2NZy0I1Ow3BgVPoBU4tD7BCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AE_v0EjFgIX8 for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 18:35:58 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbtJZ0wLvz1RtVm;
        Tue, 14 Mar 2023 18:35:57 -0700 (PDT)
Message-ID: <f218e051-48de-06d1-bf0e-2517f6b3ae38@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:35:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] pata_parport: fix parport release without claim
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230311192538.29067-1-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230311192538.29067-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 04:25, Ondrej Zary wrote:
> When adapter is not found, pi->disconnect() is called without previous
> pi->connect(). This results in error like this:
> parport0: pata_parport tried to release parport when not owner
> 
> Add missing out_disconnect label and use it correctly.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Applied to for-6.3-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

