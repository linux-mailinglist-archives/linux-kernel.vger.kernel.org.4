Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79A73338C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbjFPO0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjFPO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:26:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B330D3;
        Fri, 16 Jun 2023 07:26:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35GEPh48037867;
        Fri, 16 Jun 2023 09:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686925543;
        bh=Pvjp0zpmxsyuufHh7izfqxh0vKwlbuqJ0cxBzxOE1HE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=y1ZTPJL+wEFXp3CZbtgCoafIvbOaB/e64sWqx/XPgZOrKwbBN12flulCRctHP2XX6
         j4gY2NmU3GsH+oXm+6uu3fpT5oK1gEwhjsoioFTQWFXBstGaf7jTMkONl2R+KOnsXW
         SVBVwrxWEi61uMIH92SSZ08mXRl52EgGUWrOO++E=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35GEPhev001555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jun 2023 09:25:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Jun 2023 09:25:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Jun 2023 09:25:43 -0500
Received: from [172.24.217.203] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35GEPc20009741;
        Fri, 16 Jun 2023 09:25:38 -0500
Message-ID: <04785de2-6096-95ea-71fe-428796a4d65a@ti.com>
Date:   Fri, 16 Jun 2023 19:55:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 2/2] drm/tidss: Add support for AM625 DSS
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230608163734.2578-1-a-bhatia1@ti.com>
 <20230608163734.2578-3-a-bhatia1@ti.com>
 <5eb55b7d-f1e9-0dbe-cbbf-bd27ae521e5f@ideasonboard.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <5eb55b7d-f1e9-0dbe-cbbf-bd27ae521e5f@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the reviews!

On 16-Jun-23 18:15, Tomi Valkeinen wrote:
> Hi,
> 
> On 08/06/2023 19:37, Aradhya Bhatia wrote:
>> Add support for the DSS controller on TI's AM625 SoC in the tidss
>> driver.
>>
>> The AM625 DSS supports 2 video planes connecting to 2 video ports.
>> The first plane is a full plane supporting all the features, while the
>> 2nd plane is a "lite" plane without scaling support.
> 
> The DRM planes are reversed compared to the HW planes, aren't they? Is
> the above referring to HW planes?

Yes, I am referring to the HW planes, and the DRM planes reversed as
well. =)

> 
>> The first video port in AM625 DSS internally provides DPI output to 2
>> OLDI transmitters. Each OLDI TX outputs 4 differential lanes of video
>> output and 1 of clock output.
> 
> I think it should be explained that OLDI is not supported in this
> version, but will be added later.

Okay, I will make the change.

Regards
Aradhya

> 
> Other than that:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
>  Tomi
> 
