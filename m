Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20AF6ADAD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCGJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCGJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:47:31 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF135BCBC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678182434; x=1709718434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XAMMJ4e2XknIezt+JVgJt5gbEedpXSXNtv9cd7WBDBw=;
  b=ASAi0oNdMuNv2HKV1rT07DmQeQ2NT0LLV9pAO4+0VNXq/7DUMfhSIkrM
   eX63oqP4ZAcK9TLT7Sa0cNahbNrXVmH8FFo+CprK93/5XPl6GG+Wu0798
   a93IFFGxDy50bWlZ5ds5V6upVGv5cnjsPqkX/OPVZNmYQrXjPAcJlY+Zp
   KdFxs8wDa3gVMRwBadS4NdklrLnSfKE+183ieW2LQ2J21pF6v3Q8i8oai
   DDLbR+SknYTX38QgSv534BJE7kIYQAz2ni6xIHivzKxmVCpkKCYXK2k3Z
   mVa2zOTrAGIo7NfdypWGPRCdtcPP/dJNaiMSaq9Vr5YFHpO5eS5EU29R0
   w==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673884800"; 
   d="scan'208";a="223281642"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2023 17:47:13 +0800
IronPort-SDR: 7NRdJk3cZgAqqQfX6qWXh6fnMrtZXkOJXafGJogN72EkyyV6GjzsiHs0NWPtJijLXCIrweogtL
 EDVL6nvjalgZ3x6t4PeDUapUEQiJq2x9wL4rrtpfmSoart0FJMR2HokoZBfWfNcrUa7iTuvhDg
 99r2PPyEh9WEBpfwIonmw6VqCyt+E6T/bsvWot55/E8kBXW6U/z/gXIqGaQS9p9/vG79xklA18
 GGRE6VITQ5ln6hyBWfaf9wpcMNZM9NarmIGbJ02duIwphsmoQaOJr4Mr9zQluWZzQIvEXyCItA
 LP0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 01:03:53 -0800
IronPort-SDR: T/sunW50Uih1xOrPs7+ARIwZdwipFr4ijR9TmmTD+k23Hj+9NJM3CjUg/AkPK6BBgnTJUDivzf
 ITO2sF+/Kk1KpNcrpux0SdWt8aYOrzly3BgZbEAdFlgEPt5o1pqPZbefWdBiHqIvRscommhcsn
 iVdycXZe8Op3vJPOMwuIIpOyVWvYniQBSOGWtRyH0k4KZXTiJysW34dJTrAgodoMT+fi0lrX3q
 c3SYB2HgQbHwOn1AQnfOYO3TGZ23TGbNt4pfypnat6oKD/OATfOp2b38os/oGSD/jnKCAGNYfa
 Wm0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 01:47:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PW9b552r4z1RwtC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:47:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678182433; x=1680774434; bh=XAMMJ4e2XknIezt+JVgJt5gbEedpXSXNtv9
        cd7WBDBw=; b=UXMuJYYn3AioJLrlkjbnOI26cljlI3W2+RX5Bq/1jLOdckKLLZ7
        g9V3OP8FbOCG6vdHUyA9DI6KG9AWydFrGOUalLC/Irw8YmslretYIflsSfcrrK6y
        tyQQ7vA5ai1UaFdm1Hf30plbp2FISxAPyQaSoKPrt3QSzH1IDONWsqNt/M5foraJ
        +a1/12gOjMgoS9SFZoGsN72vVNZSh0q1o+U+dm+o5sOMeFzAEMDN1Ne6u+n8bsfN
        Bn8OLuJN9ftJiv/Z0+BFxAkpvou58vzIbt6kwRteanl08R1jDMscjAsTF5m1LfzT
        5wswwufDEeEs4nw6oTEN3QX7qK/1JfyI/QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xBIXvl9D7OLR for <linux-kernel@vger.kernel.org>;
        Tue,  7 Mar 2023 01:47:13 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PW9b31JKZz1RvLy;
        Tue,  7 Mar 2023 01:47:10 -0800 (PST)
Message-ID: <9e0c0ae6-0059-36dc-7cab-6b7e588c560c@opensource.wdc.com>
Date:   Tue, 7 Mar 2023 18:47:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
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
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Just checking with Rob as he is the DT maintainer. Out of courtesy.
I will queue that patch then.

-- 
Damien Le Moal
Western Digital Research

