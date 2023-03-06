Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F886AC41C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCFO4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCFO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:56:38 -0500
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75956CA29;
        Mon,  6 Mar 2023 06:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678114559; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=msY3Rd6XS3xqaxJl4LGanNjzLlMn4D8qSKys/ZRSpHDX9wFeRnbb2SWGgB1VYyQmaFcq+xB13R8jkUAiwHgQ+g5I0/T+ib1w2bUiMIwNwCxM8pOehbDfH7Mfym5+yPm8Mto8OoBxubperIwcEpq9oSgmIDpcxx/MyshGz2JZY3I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678114559; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9nd+k8XAgPSgixGUgbvKDnLLladecVQNt6nXtFJIVZE=; 
        b=kOGm43Rs2U1fNoz+m4m2WUtxQVDAT0YRuzmw8Owd9FW1Wnyo6hAL8bW5kaoAIwtMLDZ0bjasdubyK6UknMqw2WvTkM7BIlwlL3ECKT7HAQ/bUJMw4gHhF2uAb7N0I0G8FAM95sW7Me1grGlJErpLHA6cTJqwTVRzqJdG3652LcY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678114559;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9nd+k8XAgPSgixGUgbvKDnLLladecVQNt6nXtFJIVZE=;
        b=VA12CC+3jMsU/u8aqp6hpuRoil8nuXF/2ajC2F1arRIzefc4vtLnfnuLu33Z63Et
        vbfT1meJmQ2UdQ9qZKlSEb1HishyAySPdOVp/LlxD4VjI7BMeP/qhzXCEBM1HYXlyQM
        DF9nCGtgVgx1lSgqr/wK2qJUP9eCxho9M4FzsBeA=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1678114557969142.92607754783864; Mon, 6 Mar 2023 06:55:57 -0800 (PST)
Message-ID: <486ebf30-dde3-b77d-c292-ba7605313273@arinc9.com>
Date:   Mon, 6 Mar 2023 17:55:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to
 mediatek, improve dt-bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
 <CACRpkdayVLTT0x6hfnwvL-Atafkj8PRw5uwe7Wic3jtn+X-axA@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <CACRpkdayVLTT0x6hfnwvL-Atafkj8PRw5uwe7Wic3jtn+X-axA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.03.2023 16:50, Linus Walleij wrote:
> On Fri, Mar 3, 2023 at 1:29 AM <arinc9.unal@gmail.com> wrote:
> 
>> [PATCH 00/20] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings
>>
>> This is an ambitious effort I've been wanting to do for months.
> 
> Good with ambitions :)
> 
> As long as Sergio is on board and can test the changes and as long
> as the DT maintainers do not explicitly disapprove, I'm game to merge
> this.

Cheers.

> 
> I guess you will respin on top of v6.3-rc1 when the first round of
> non-RFC feedback is collected.

Sure, if it's necessary. Once I get feedback, I'll rebase it to your 
linusw/linux-pinctrl.git for-next tree, see if it needs manual changes. 
I'll let you know.

Arınç
