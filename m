Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E976ADC2B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCGKnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCGKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:43:01 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382EA7EE9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678185779; x=1709721779;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+LVO3F5En6AqL41D+hH/tg3GKjgWE12xa9SmTfU53w4=;
  b=EiQK4LPr7NnNRESKoZin7VQXMugAnn4VRS4aMKilLZDCPUioFDYlvlEz
   hPFpujDY6sfYSm98TYeBMY9BvEssgueMHEWgFpGPplj273MStiqMiMgbp
   CJ+c+aS4lbEvJ1zl1H7F3W2v33itUrTo3uV9C9BIem+YdF4Zh8+PsmA3L
   VnNoxd3BAEwWsHrjoEoxkVuZRtkxH6k1A0BDflxsRpiE6wan2dSKrDI3v
   zkkC5rYEbklV8z5EqbrZVtCkkQbIC2ThYXkErxjE+T21W/ltFy56UyXFD
   wUvyr4t9jVsKyKLgF5H9VWfxO8g62cei5N9BpblfVDACTsKGINmrx1ZGH
   g==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="224997659"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 18:42:56 +0800
IronPort-SDR: PzkM4y6S66Bm917t9tup1vPxuosU1K2Sd1FM0wFsmrNOu7mTz0jWquiMNkwMkNvjfcF5p8q7el
 nUl2n56xuvrBYofaM3efMrFlXXeXFJIFA4xkTh7hDaOS35Q7lC6a6YBksZkYy+Ih3gjMJp7NOj
 x9Y/GQ89ZG7iQtVXQzfZnAcDl1NI1S6+iYHykXwq6zPxrPZkzXXeiUpqe3bzWwLZrmQQTRQB8A
 EaXnxYtHcML00pva27OTct2rh8pJ/KllXWYDW1eW1blnX9HpwFQ4+XHFnuzQopcjUaj6XP5jsB
 Eeg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 01:53:54 -0800
IronPort-SDR: bfAo6Y+cS7RCROIkHDlXM7cBi2MvRP24N2NAUX1IcdnnHZ423Ss0+G9V5ET4BSDnbxeLRZJHex
 LQLR6PPfYcB5xXKxXSStNhoSj9Y3Iwta6cV7ZCc3W3gn/Y/kjgjAsOOwc3cDXeW/qHPFMaFVMy
 X8060RyIImg4R3vBpfmL9YH7BQ7pc4p+eri5H7y3wibGgC4q7776NC0qYxuNk7d8hAMpTQa9VH
 KfbNi7YtnQJp6cLlmjq+4RYp0XRJy19SbQ5zEBVTRPOmJx1iFGcp+p+OL8bTt93qhwIUDHz/TK
 92s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 02:42:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWBqM5PXtz1Rwtl
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:42:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678185775; x=1680777776; bh=+LVO3F5En6AqL41D+hH/tg3GKjgWE12xa9S
        mTfU53w4=; b=QnGK3Wk9GsSyj5KfqDrTjG++jMnDI2lAxJHYL0K4FLtLPUJmdwa
        TK+jMfwx7EJFzWvYcyNbTKHm5iIwQpu7bcgtjNQlONKObRr0mIGowkNfnpW4g+hN
        soQ2fWLjczlYucbDnE/cvkrguMu/H6itKptiiETR2QrMw50JABCJliVmhL+hJAkr
        PlATr9FExwRk3oAPNjd9koO25F9dVy0W783Ut69QwfXbzWjGLAUkyGueat7WE2a9
        exnoxwwmIKj7ixqBfM2WWKwlqwbISXFAG7aw7b4eG9DUXdkNWJfyWoJ9v2QtznXf
        rmvD8b5vydQb5nVqSsbh818Y1xkPELII46Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6vfF6cOuLk4v for <linux-kernel@vger.kernel.org>;
        Tue,  7 Mar 2023 02:42:55 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWBqK3WwWz1RvLy;
        Tue,  7 Mar 2023 02:42:53 -0800 (PST)
Message-ID: <e5ed284a-77ac-df6d-1473-e4d96955f65b@opensource.wdc.com>
Date:   Tue, 7 Mar 2023 19:42:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
 <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
 <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
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

On 3/7/23 17:13, Krzysztof Kozlowski wrote:
> On 06/03/2023 02:22, Damien Le Moal wrote:
>> On 2/23/23 00:59, Kunihiko Hayashi wrote:
>>> Add UniPhier SATA controller compatible string to the platform binding.
>>> This controller needs three reset controls for Pro4 SoC, or two reset
>>> controls for PXs2 and PXs3 SoCs.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> Rob,
>>
>> Are you OK with this patch ? I can take it for 6.4.
>>
> 
> You got Review (which includes also "Ack"), what are you missing here?

By the way, I am not seeing/have not received any Ack. Hence why I checked with Rob.

> 
> Best regards,
> Krzysztof
> 

-- 
Damien Le Moal
Western Digital Research

