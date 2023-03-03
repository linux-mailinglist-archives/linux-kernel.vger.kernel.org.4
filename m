Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2536A9202
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCCHxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjCCHxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:53:34 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418F330B25;
        Thu,  2 Mar 2023 23:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677829991; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bToTMVisRwaGZAy2Ep8EDZw0/7dYOPaNtyRClspqoIqRry3bapXKEsrQUvrxHbmykKJeL3NebAlSvkE4ZsyaWRXFAbbxoCnfE9OrD6laNXXwR+J9lgUgAVBjPIqpbjUaZg5C2SFY2Kt+pHYwQ3o0UtsQsfMqxeuT3NLANpeYv+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1677829991; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KecT7aJZBTtl4AOpLMt2qpIjfIOj61Svcu1Xb2PNyJI=; 
        b=X+1l2xYAmcRySH0xY9h/jnRoBl0eiJfQKLC3vlfmDgANQvidQlwXMN6WgTG8Pj8n/D9A+bP+q1chJbRbG5JmTyJKXRalZ9B0JuNul5OwVSd/8RVQierqa7W1m5tP4qRFE7fUIuIqNdtASkefaYqVgeIr8x8tXjn/Rr41RPXTGbs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677829991;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=KecT7aJZBTtl4AOpLMt2qpIjfIOj61Svcu1Xb2PNyJI=;
        b=C8KjfIzfJHHYq/13GitfC3gQpfhRE81yzh5tdynafyCwxzw27Gy9c9T5LIA7rS/5
        e1NLUiS4jxH7GTzuHWIkxoJ5r7pmlcD07EWg53mDN/YfMFW0Lc+AznsQa7qZQ2QlUwO
        6NPS8inkb91Mn4RKCT/usG4gCJsTkTbMACy5hWSs=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1677829990732306.4293848301023; Thu, 2 Mar 2023 23:53:10 -0800 (PST)
Message-ID: <b6dae90f-2c2a-3434-9995-527f33533730@arinc9.com>
Date:   Fri, 3 Mar 2023 10:53:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/20] pinctrl: ralink: mt7620: split out to mt76x8
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-5-arinc.unal@arinc9.com>
 <CAMhs-H9qVE0Z23Z3J8D1voo5UaKZrjUYU=7V=oRMd8=vVGASAg@mail.gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CAMhs-H9qVE0Z23Z3J8D1voo5UaKZrjUYU=7V=oRMd8=vVGASAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty mail?

Arınç

On 3.03.2023 09:03, Sergio Paracuellos wrote:
> On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
>>
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Split the driver out to pinctrl-mt76x8.c. Remove including the unnecessary
>> headers since is_mt76x8() is not being used anymore.
>>
>> Introduce a new compatible string to be able to document the pin muxing
>> information properly.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   drivers/pinctrl/ralink/Kconfig          |   5 +
>>   drivers/pinctrl/ralink/Makefile         |   1 +
>>   drivers/pinctrl/ralink/pinctrl-mt7620.c | 257 +--------------------
>>   drivers/pinctrl/ralink/pinctrl-mt76x8.c | 283 ++++++++++++++++++++++++
>>   4 files changed, 290 insertions(+), 256 deletions(-)
>>   create mode 100644 drivers/pinctrl/ralink/pinctrl-mt76x8.c
