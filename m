Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BCF7278D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjFHH3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjFHH3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:29:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFF26AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:29:21 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C623C4C;
        Thu,  8 Jun 2023 09:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686209333;
        bh=vlIinTewP+cDKlpKQXd2OIGqSCvgjHtEAu4OH/s26NE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PJYnkTDUXtPrki2J7u75rGyX5k/ctQpCgAREtF2QBGDS4igS0CYdsfvAgzIvWiiQi
         0VoIGOss7jCZUG+PaTALc2Lq5jNR9dhoEkyJV1V/3lRlcKkRfRdP8N5FG0EiO+QBzP
         IAHWODcqsOF/rTkVi3o+YiuyfbRaFNu0x6qBgskc=
Message-ID: <be2c4c02-43bc-5b16-2162-b8ace8d34996@ideasonboard.com>
Date:   Thu, 8 Jun 2023 10:29:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 0/8] drm/tidss: Use new connector model for tidss
Content-Language: en-US
To:     neil.armstrong@linaro.org, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
 <1f284e9d-5a1e-9fca-ceb0-478a413ae4ef@linaro.org>
 <1b31f36c-b1ba-43b5-9285-0f50384a78cf@ti.com>
 <42151d11-12d9-c165-0d4b-a0af80b683c3@linaro.org>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <42151d11-12d9-c165-0d4b-a0af80b683c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 12:48, neil.armstrong@linaro.org wrote:
> On 06/06/2023 11:46, Aradhya Bhatia wrote:
>> Hi Neil,
>>
>> Thank you for reviewing the previous patches!
>>
>> On 06-Jun-23 14:37, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 06/06/2023 10:21, Aradhya Bhatia wrote:
>>>> Hi all,
>>>>
>>>> I have picked up this long standing series from Nikhil Devshatwar[1].
>>>>
>>>> This series moves the tidss to using new connectoe model, where the SoC
>>>> driver (tidss) creates the connector and all the bridges are attached
>>>> with the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR. It also now creates 
>>>> bridge
>>>> to support format negotiation and and 'simple' encoder to expose it to
>>>> the userspace.
>>>>
>>>> Since the bridges do not create the connector, the bus_format and
>>>> bus_flag is set via atomic hooks.
>>>>
>>>> Support format negotiations in the tfp410, sii902x and mhdp-8546 bridge
>>>> drivers as a first step before moving the connector model.
>>>>
>>>> These patches were tested on AM625-SK EVM, AM625 SoC based BeaglePlay,
>>>> and J721E-SK. Display support for AM625 SoC has not been added upstream
>>>> and is a WIP. To test this series on AM625 based platforms, basic
>>>> display support patches, (for driver + devicetree), can be found in
>>>> the "next_AttachNoConn-v2" branch on my github fork[2].
>>>
>>> I can apply all bridge patches right now so only the tidss change 
>>> remain,
>>> is that ok for you ?
>>>
>>
>> While the bridge patches and the tidss patch can be separately built
>> without any issue, the tidss functionality will break if only the bridge
>> patches get picked up, and not the tidss.
>>
>> Would it be possible for you to pick all the patches together once Tomi
>> acks the tidss patch?
> 
> Sure

I think this looks fine. For the series:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

