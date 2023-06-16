Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682573266F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 06:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjFPE5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 00:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjFPE5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 00:57:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA80269E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 21:57:50 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61E023F0F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686891468;
        bh=SZ1z3iFCuctvpDLXu03zvj3Ivp+6TOQT0ngCLOJqvUM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=re0oWHBNfQuppDzUl4WRusVURcnpCy3TCezfXvU0vc9njq3ZFJJvOFp+O3LGw33oP
         nR+r7bTzUQPK/f2Oiyua7FVzCd9etrA7qLyf0QMCf2gUs/RwrY/Feok7IAFr+/uW30
         iVcP/gB3a9rpNmHMJ23FWzpwoIWDUUTmNap7by1x325Z6KMuj8LdStUgV/rt3anS/g
         QPCN4ewzWdTeuAt+vneSlHCJC6aAe7qLFWiVZc5QBUiWe/+JledKX0PHOv9X1ldgg6
         qqrmtwJqbLVTr8UbwQv+YR0py5B834LA1GeKV8+oeGLLRboxoHor1//pSaevSTundo
         /WtOV4v/YQ6Ug==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98281e071fdso15626666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 21:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686891468; x=1689483468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ1z3iFCuctvpDLXu03zvj3Ivp+6TOQT0ngCLOJqvUM=;
        b=FYxH1tkt2fqQOEvet1lFBJ20QbcGkev7qMh/DtWVio3bAiPqOYBaTS3qe2dGKbhHqt
         7ECggAx8/ISYrkD350eH77ZHcrmIUUuZDXNO8vq/FelXso6fAHmMhEM0q5aKEoktf1dB
         J/9m8stn6qGwVduzITBrLC4w3f3uxDxDvk3nRTWxjk9Hr/dfkJwdoiRYP9+824DKJfZL
         PvLukIgbuPrNFuQqefA4lSA9w6rtcH/tFNjo+o+oZhvuHVE+nS8v15dOw8KykRASDpj9
         WdWS86R6a44iGFxPi+toGUzg1MlvEXLB7XsqUb0xK4OKY9Hrwvyw4csHt5qAP5QBHRwJ
         Gvzg==
X-Gm-Message-State: AC+VfDy57at/K8QelRaJ+oOmknEIJJ8sFyOiVvORgaKCHfvERx8R5+5h
        yP8gtFsJrOITZhdoCoJ4+PbF2+nOI6BUL1OkDIEDGAeMJ6cg0hH/yha+5g6FSUvpNV+J3eoX0vt
        oVAsyog+feXUOby/8TRhbNJ2D9ZdowxAJgvTrUKpXFzBSHZWKGTIG
X-Received: by 2002:a17:907:7f9e:b0:961:a67:296 with SMTP id qk30-20020a1709077f9e00b009610a670296mr875494ejc.11.1686891468103;
        Thu, 15 Jun 2023 21:57:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jN4pd+MWptJyqeTblIv0eB11pe/b9g8vwziyU9GWzQNswt2di9XfJC6ufsG7/Ic5Kf+Yieg==
X-Received: by 2002:a17:907:7f9e:b0:961:a67:296 with SMTP id qk30-20020a1709077f9e00b009610a670296mr875481ejc.11.1686891467705;
        Thu, 15 Jun 2023 21:57:47 -0700 (PDT)
Received: from [172.25.0.170] (ip-084-119-033-219.um24.pools.vodafone-ip.de. [84.119.33.219])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906371200b0098282bb8effsm2638419ejc.196.2023.06.15.21.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 21:57:47 -0700 (PDT)
Message-ID: <49f9687e-39ef-aad2-b02a-eb54a21b70f2@canonical.com>
Date:   Fri, 16 Jun 2023 06:57:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC 1/1] wifi: rtw88: Add support for the SDIO based RTL8723DS
 chipset
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20230615142044.1357257-1-heinrich.schuchardt@canonical.com>
 <CAFBinCAEFvmxnBDJPSs+mGqAraGUDFkCB3SjRTEyC9waA3P8JQ@mail.gmail.com>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFBinCAEFvmxnBDJPSs+mGqAraGUDFkCB3SjRTEyC9waA3P8JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/23 00:13, Martin Blumenstingl wrote:
> Hello Heinrich,
> 
> On Thu, Jun 15, 2023 at 4:21 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> [...]
>> On my Lichee RV Dock board this patch is enough to make The RTL8723DS
>> work. But unfortunately after running some time the driver crashes.
>> My impression is that the crash is not specific to my patch but must
>> be hidden in one of the existing functions it is invoking.
>>
>> This seems to be related to not checking pkt_stat->pkt_len.
>>
>> My kernel was built against v6.4-rc6.
> As Larry has mentioned: support for the RTL8723DS chipset is in
> wireless-next.git
> You can find the whole series here: [0]
> 
> It seems you're missing at least "wifi: rtw88: sdio: Check the HISR
> RX_REQUEST bit in rtw_sdio_rx_isr()" [1]
> That patch should fix the exact issue that you described.

Thanks for your great work.

With the series on top of v6.4 my RISC-V LicheeRV Dock runs fine.

Best regards

Heinrich

> [0] https://lore.kernel.org/linux-wireless/20230522202425.1827005-1-martin.blumenstingl@googlemail.com/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=e967229ead0e6c5047a1cfd5a0db58ceb930800b
