Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF571F43C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFAUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFAUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:54:42 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD9189;
        Thu,  1 Jun 2023 13:54:41 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b02fcde49aso8241965ad.0;
        Thu, 01 Jun 2023 13:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652880; x=1688244880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPwIIZji4mV+ZRru26BAK0A17cLTb3lSIzhJ0eieN5U=;
        b=J+88XhuXISTqusx0iTMC+i3zRwGscoq3fKAggjVfW8m2N37wgSWj8HbPagvprzm3QX
         p9seo/B1xAQBX5OhxQ+drk8wv3yAoNij0bXr2YpSu6ymENJsGJ597DEhqHu3zJ0iHcTw
         TCVvVGy7xBb3IaSXj99XexwlejylC2RM0OeL+Cud9CM153xl7oL+sApM41tqgiDxhY5H
         OazU5tNinLc1i0uGQraU7VjVcx6dyZ8cyxy0w2UsrjOyk8oKkPAgokMVveB5cG1Ku0PI
         udSPr7DbUWVrGk676s1uE01oicGQ9cXr0bY92k5PQwyPwTqZDQ/FK5GdwZT1nHFdUfOI
         o8Bg==
X-Gm-Message-State: AC+VfDyqjDgTzc7QKZts0FxEc6zLLB9ioU5kPVEWwuTPIgyyObbj5HYw
        G1L7L/0ohSscbfurz4iPoTI=
X-Google-Smtp-Source: ACHHUZ5hUChDXbEmqYIU8V8OQaDiPwT6USDEoTMPSLkgzUsyWLT/1zZYL1PVhpX7Lh14eAmy+9e7hw==
X-Received: by 2002:a17:902:ab96:b0:1a9:bc13:7e20 with SMTP id f22-20020a170902ab9600b001a9bc137e20mr404142plr.44.1685652880497;
        Thu, 01 Jun 2023 13:54:40 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902758d00b001a52c38350fsm3929463pll.169.2023.06.01.13.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:54:40 -0700 (PDT)
Message-ID: <f6a79164-944c-a355-40f3-0bddbcb37357@acm.org>
Date:   Thu, 1 Jun 2023 13:54:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Content-Language: en-US
To:     =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?UTF-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        "chu.stanley@gmail.com" <chu.stanley@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-2-powen.kao@mediatek.com>
 <1c182151-6e8c-5068-b38c-f8e842e6e13b@acm.org>
 <CAGaU9a9TsoaUtoMX8cNmAhfBnCddRtWYEG8ACdRNJfri+sdasg@mail.gmail.com>
 <ec9c378c-fedd-5a90-bb12-085395e0d22e@acm.org>
 <fd0fceb04efa34e6d86f09c5554746cfcc5c993f.camel@mediatek.com>
 <4ea8427d-8b09-d35f-0e2c-2df486b79692@acm.org>
 <d5f239c6f104d9dd4e5493d5d06709e33f12226b.camel@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d5f239c6f104d9dd4e5493d5d06709e33f12226b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 07:41, Peter Wang (王信友) wrote:
> On Thu, 2023-06-01 at 07:23 -0700, Bart Van Assche wrote:
>> Thanks, I had overlooked this. Do you agree that the above shows that the
>> flag I proposed in my previous email (UFSHCD_CAP_SINGLE_CQ) is sufficient
>> to support the MediaTek use case? I want to keep the SQ-CQ association code
>> in the UFS driver core because the next step will probably to switch from
>> one CQ per SQ to one CQ per CPU core for UFS controllers that support
>> multiple completion interrupts.
>
> If the UFS device speed is geting higher and higher, one CQ may not sufficient.
> 
> So, UFSHCD_CAP_SINGLE_CQ is not flexible for us beacuse we may want to map to two CQs.

Hi Peter,

Let's take a step back. The MediaTek UFSHCI 4.0 host controller only 
supports a single completion interrupt. A significant disadvantage of 
the single completion interrupt approach is that all completion 
interrupts are processed by the same CPU core. This is known to cause 
problems on Android. If sufficient time is spent in an interrupt 
handler, threads that run on the same CPU core as the interrupt handler 
may get scheduled too late. This can result in e.g. audio glitches 
noticeable by humans. Hardware designers told me that the area occupied 
by a single interrupt line is small. So I think it is fair to say that 
the (nonstandard!) approach of only supporting a single completion 
interrupt in an UFSHCI 4.0 controller is not a good choice.

The UFS driver already supports multiple hardware queue types 
(HCTX_TYPE_DEFAULT, READ and POLL). An interesting optimization would be 
to combine the completion queues for at least the DEFAULT and READ queue 
types. Introducing a vop to configure the completion queue ID would make 
it almost impossible to implement this optimization in a generic way.

Asking to add a vop that improves performance by only a few percent for 
a *nonstandard* controller and at the same time that makes it very hard 
to optimize the driver for standards compliant controllers is something 
that I consider unreasonable.

Bart.
