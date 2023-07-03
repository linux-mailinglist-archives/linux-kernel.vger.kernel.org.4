Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C3745DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGCNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGCNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:44:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A9E5A;
        Mon,  3 Jul 2023 06:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E71060F4B;
        Mon,  3 Jul 2023 13:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1006C433C7;
        Mon,  3 Jul 2023 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688391860;
        bh=3OalVom3i/o15fhhviP0iWfIaM4zX2VkZSJCW9xDX4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mrlyEnMZhO/WRRDMnScTjs1sNuS6ms1OijmFb7tsdNqgmdgGSDTdVrqn5JogCNmDZ
         h8i9Z0qGM9BHJRX7KAzEA207A0FJd9Vj4LQ+sVEePg9zJjJG2nbwTWbjQlYU4OUkk3
         USAkHhwgRa00xnZ0D8BtihEk+kaWNwYFdGNg8Tr88jqmdOOsG/cF0/KFni9Vxil+Dq
         KYCOTUJhTLGUc/jRIjyYIf8JC3jeVDGpBT15lQrWvfGIrUpCu8fvTo9nycRYiswPmj
         fnA4788psG8MI7ZAJEiESJM5xN9NAADQolt2tFLApFibRlAy72+TV/KNKu6wbnjgRb
         IzubSW8aZI8QQ==
Message-ID: <9ef45899-c766-e839-522a-3b048f8106f7@kernel.org>
Date:   Mon, 3 Jul 2023 16:44:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Configure usb0 as peripheral on am335x boards
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, nm@ti.com
References: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
 <20230630072047.GK14287@atomide.com>
 <f4fa80fd-1a6a-4718-0287-f5288cd9d912@baylibre.com>
 <7f44798b-e2bf-1620-da37-ca13bfd07a21@kernel.org>
 <babf5f20-ddf4-74bf-1788-f8e356acaa92@baylibre.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <babf5f20-ddf4-74bf-1788-f8e356acaa92@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2023 14:56, Julien Panis wrote:
> On 6/30/23 21:40, Roger Quadros wrote:
>> Hi,
>>
>> On 30/06/2023 11:30, Julien Panis wrote:
>>> Hello Tony,
>>>
>>> On 6/30/23 09:20, Tony Lindgren wrote:
>>>> Hi,
>>>>
>>>> * Julien Panis <jpanis@baylibre.com> [230629 13:10]:
>>>>> This series configures usb0 dr_mode as 'peripheral' for am335x-evm,
>>>>> am335x-evmsk, and am335x-icev2. This USB port is mainly used for
>>>>> RNDIS and DFU.
>>>> Is this a mini-B connector? Just wondering if it was originally attempted
>>>> to be configured as OTG or how it ended up with a host configuration..
>>> It's a micro USB-AB connector.
>>> I don't know how it ended up with a host configuration, it looks like an oversight.
>>> Maybe Vignesh or Nishanth can confirm (?)
>> usb0 role should be "otg".
>> It is rightly so in Linux DT. am33xx.dtsi contains "otg" and all AM335x board files inherit from it.
>>
>> So I don't think setting it to "peripheral" in u-boot is the right thing to do.
> 
> This series is for kernel (not for u-boot).
> Why is it a problem to set usb0 as 'peripheral' in kernel for the 3 board dts ?
> 
> With usb0 not set as 'peripheral', the 3 boards (am335x-evm, evm-sk, icev2)
> do not boot with uboot 2023.04. This error is returned, with LOG_LEVEL=5:
>     No USB device found
>     USB ether init failed
>     initcall sequence 8ffdbba4 failed at call 808024d9 (err=-19)
>     ### ERROR ### Please RESET the board ###
> This error is also returned with usb0 as 'otg'.

This error is at u-boot correct? This will need further investigation.

Does it function correctly in Linux when kept as 'otg'?

-- 
cheers,
-roger
