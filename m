Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAD70BFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjEVNif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjEVNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:38:33 -0400
Received: from sender3-op-o19.zoho.com (sender3-op-o19.zoho.com [136.143.184.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F905C2;
        Mon, 22 May 2023 06:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684762661; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=f8yckhKnjvX29o/6OVAPDAvPWP9bBU7oRRrwnUMiuXPPoPBhZTsZ5OG/x+n34rnpjDOc2OI1trj+3ucKaIKWWeq+sizFTOCyZLMeWIEjb5zVmLfSc9LFUsY4U5quxwfupmO2SITKmEHhAOnGfiN+IDj1Ar3WTc43I3sagy9qwlk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684762661; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=W1ojuZaAzaiPlZJBWNie4sJa5sp80jGKgJddNADgIK8=; 
        b=EH/G8W+fJ7MlKtbDemFzMxuAOSya4I7Vq9n0xiqsZ6ATjdqhai/Xq3OW6xPEm0FPiVYkKZoVTqoYLYNdCbyzrbkWwWRbNwAPaTAcSs7xy04vawSsNtig3dTWLTRKPOkFcGZcKmOdxgnXCqv3rNZYKhOK25q1ttEYp+V4gQo7tYM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684762661;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=W1ojuZaAzaiPlZJBWNie4sJa5sp80jGKgJddNADgIK8=;
        b=OUrZBb8z+jJ6s62X6sb+CWDt63qTp31HJ76A2+NCUBTfMjkl4WUEwa08xvQWXrQk
        qynMF5vnKIQhj7q3GEZ/NPJWAfH5v4jBqjXodeynMlaKPTU+xJ85lGKFOaIN8A5A0o2
        Tp9Gi5aZFzw/aQ7DD6p23qZOdNBqBjHsBVKMm4fU=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1684762659016377.77661140896896; Mon, 22 May 2023 06:37:39 -0700 (PDT)
Message-ID: <0346d5dd-bcb8-1bd9-6943-2c9d83587364@arinc9.com>
Date:   Mon, 22 May 2023 16:37:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 00/30] net: dsa: mt7530: improve, trap BPDU &
 LLDP, and prefer CPU port
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <5feba864-b792-4fe4-a58a-e1b22bb7842b@lunn.ch>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <5feba864-b792-4fe4-a58a-e1b22bb7842b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2023 15:25, Andrew Lunn wrote:
> On Mon, May 22, 2023 at 03:15:02PM +0300, arinc9.unal@gmail.com wrote:
>> Hello!
>>
>> This patch series simplifies the code, improves the logic of the switch
>> hardware support, traps LLDP frames and BPDUs for MT7530, MT7531, and
>> MT7988 SoC switches, and introduces the preferring local CPU port
>> operation.
> 
> Hi Arınç
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> says:
> 
>    Avoid sending series longer than 15 patches. Larger series takes
>    longer to review as reviewers will defer looking at it until they
>    find a large chunk of time. A small series can be reviewed in a
>    short time, so Maintainers just do it. As a result, a sequence of
>    smaller series gets merged quicker and with better review coverage.
> 
> Given you description above, it sounds like this could easily be split
> into smaller patch series.

Later patches require the prior ones to apply properly. I can submit the
first 15 patches, then the remaining once the first submission is applied.
Would that suit you?

Arınç
