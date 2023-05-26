Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE16712B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbjEZRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbjEZRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:09:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABE1BB;
        Fri, 26 May 2023 10:09:37 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BEEBD8616A;
        Fri, 26 May 2023 19:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685120975;
        bh=dUVDzPz0F4pq5wY+7RaxA4sqopSuOHiJeZJyrtkMdBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PUdeCYwWq9rZSAS3jYtl6Z6TgEg1NFapeA9NRxUVEjM1+ikOOZo5ng0LslQfCRRK7
         Kkk/JyG02/MGLzn8LjNJ5sNsmHkIHQsiFhossxwnVQuzvK2EnvKgIpyH7xY5X9CqNj
         dCjCCD/JsKsdSeIkoKHPPfd+7g4mcFH9lEoQK7e8IL4opsXfd/4khHm4XuHCE1WCuQ
         zZl1a2OTVK+kQyJLrEGQNlwc2u4legGdtpL+COYL2FRil+0bFmWiuUjDhnVI5DJXPf
         XAwZ0hVIiQ1t7eyLwhHz6cpi7FPTRkMp/Pss0UJtZ3nZQb6ZY7L786b4eBrSXpO7+G
         0u9+6VluYl5XQ==
Message-ID: <2f7981fe-e3ad-8404-b773-1ebc05f63149@denx.de>
Date:   Fri, 26 May 2023 19:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 5/6] drm: lcdif: Add multiple encoders and first
 bridges support
Content-Language: en-US
To:     Ying Liu <gnuiyl@gmail.com>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
        alexander.stein@ew.tq-group.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        LW@karo-electronics.de
References: <20230510092450.4024730-1-victor.liu@nxp.com>
 <20230510092450.4024730-6-victor.liu@nxp.com>
 <b3b77a65-5109-0e29-99c5-6cefaba0492c@denx.de>
 <CAOcKUNXTFr-uyEeKkos1m0VwoB76SMdkrAuT4zHC9c8D03Apcw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAOcKUNXTFr-uyEeKkos1m0VwoB76SMdkrAuT4zHC9c8D03Apcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 03:45, Ying Liu wrote:
> Hi Marek,

Hi,

> On Thu, May 11, 2023 at 12:24 AM Marek Vasut <marex@denx.de> wrote:
>> On 5/10/23 11:24, Liu Ying wrote:
>>> The single LCDIF embedded in i.MX93 SoC may drive multiple displays
>>> simultaneously.  Look at LCDIF output port's remote port parents to
>>> find all enabled first bridges.  Add an encoder for each found bridge
>>> and attach the bridge to the encoder.  This is a preparation for
>>> adding i.MX93 LCDIF support.
>>>
>>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>> Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> ---
>>> v5->v6:
>>> * Drop MAX_DISPLAYS macro. (Marek)
>>> * Drop the encoder member in struct lcdif_drm_private.
>>> * Drop endpoint id check.
>>
>> It might be nice to check (based on driver data for each IP variant) the
>> encoder count, but that can be a separate patch.
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>> Thanks !
>>
>> btw if this doesn't get picked by someone in like a week or two, let me
>> know and I'll apply this via drm-misc .
> 
> Thanks for your review.  I don't see any more comments in two weeks.
> Can you please go ahead to apply this series?

Done, applied to drm-misc-next , thanks !

Thanks for the reminder too .
