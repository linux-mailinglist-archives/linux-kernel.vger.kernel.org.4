Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7848750740
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGLLzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjGLLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B1E198A;
        Wed, 12 Jul 2023 04:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F280061792;
        Wed, 12 Jul 2023 11:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5FBC433CB;
        Wed, 12 Jul 2023 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162800;
        bh=OtYO6AydkEf1nb5U4ddRemn+F34bsnKJ06meNnlLDQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hW1x64MJvYfOFj6blK0Gj805yBgRVIuPM4eUa491JazDpw/DL1kcgO4fHVEZEO9eu
         H/LIx5WawP6V0s9E1iy8LbOJOzUHtdCKDNBsbcawYygHDzvTWNtDi46yNtIDSidRJp
         XRlelviLWHN8nKaZ1SabyH8wIw4+3ndrx3xBsHIgzrT8q0A3ULiZ3WcRpSqVMbYyjk
         xCH8TLhnHO46F/XAPgWOqpw+x1hsJS3lA9kX6NqZtKRq4uMgiY5M/twu1XFXPaD4zT
         YmdUf52epWhdAzWNyrurbSEyA4J2TrRxr7tBV7XatO14BLuXkFrw0zoj36iPmT2lUp
         AY3USyadKMtTg==
Message-ID: <0201ab70-dff8-aa38-67c9-ca8e8ada72f0@kernel.org>
Date:   Wed, 12 Jul 2023 14:53:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-3-quic_eserrao@quicinc.com>
 <20230711215645.6wclz5uffqnlpnnd@synopsys.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230711215645.6wclz5uffqnlpnnd@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

On 12/07/2023 00:56, Thinh Nguyen wrote:
> On Tue, Jul 11, 2023, Elson Roy Serrao wrote:
>> This property allows dwc3 runtime suspend when bus suspend interrupt
>> is received even with cable connected. This would allow the dwc3
>> controller to enter low power mode during bus suspend scenario.
>>
>> This property would particularly benefit dwc3 IPs where hibernation is
>> not enabled and the dwc3 low power mode entry/exit is handled by the
>> glue driver. The assumption here is that the platform using this dt
>> property is capable of detecting resume events to bring the controller
>> out of suspend.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index a696f23730d3..18ad99a26dd9 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -403,6 +403,11 @@ properties:
>>      description:
>>        Enable USB remote wakeup.
>>  
>> +  snps,allow-rtsusp-on-u3:
> 
> Please spell out the whole thing as "rtsusp" isn't clear. Also, it's not
> just for U3 right? For highspeed, it's L2.
> 
> How about the name that Roger use: "snps,gadget-keep-connect-sys-sleep"

That property was meant to keep the USB device controller connected
during system sleep. So that name may not be appropriate here as this
is about allowing controller runtime suspend during USB suspend.

> 
>> +    description:
>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>> +      case even with the USB cable connected.
>> +
>>  unevaluatedProperties: false
>>  
>>  required:
>> -- 
>> 2.17.1
>>
> 
> Did you Cc Rob, the devicetree maintainer?
> 
> Thanks,
> Thinh

-- 
cheers,
-roger
