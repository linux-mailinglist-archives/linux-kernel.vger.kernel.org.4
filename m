Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC536701232
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbjELWao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbjELWam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:30:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934B4C15;
        Fri, 12 May 2023 15:30:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34CKQAmH050150;
        Fri, 12 May 2023 15:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683923170;
        bh=pgJzF1E1ke1uXdxCOXRhPbp9iOjFxxxNoopTt2gKb7Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cUIjkX64IQMKLiCJf28GSwwhD+hjUfl1hCR60B7yMtVP2HMRxOiRPUCy8C+HaM02I
         rezM8p0WQGgOm4HeIEX2Y2wLkP10XM2GLv9HtuBgmkdpRHHht95WLYBCpymgp+Znd6
         f6BMHd0UVWNdqbY29nAf+PuP66qEIXD9McwJu6ig=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34CKQAvO095225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 May 2023 15:26:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 May 2023 15:26:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 May 2023 15:26:10 -0500
Received: from [128.247.81.95] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34CKQAv3002127;
        Fri, 12 May 2023 15:26:10 -0500
Message-ID: <a5754d69-16c1-c217-f4cb-ea0b5e068bd2@ti.com>
Date:   Fri, 12 May 2023 15:26:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/2] can: m_can: Add hrtimer to generate software
 interrupt
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-can@vger.kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Schuyler Patton <spatton@ti.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230510202952.27111-1-jm@ti.com>
 <20230510202952.27111-3-jm@ti.com> <20230511062353.GE14287@atomide.com>
Content-Language: en-US
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20230511062353.GE14287@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tony,

On 5/11/23 01:23, Tony Lindgren wrote:
> Hi,
> 
> * Judith Mendez <jm@ti.com> [230510 20:31]:
>> Add an hrtimer to MCAN class device. Each MCAN will have its own
>> hrtimer instantiated if there is no hardware interrupt found and
>> poll-interval property is defined in device tree M_CAN node.
>>
>> The hrtimer will generate a software interrupt every 1 ms. In
>> hrtimer callback, we check if there is a transaction pending by
>> reading a register, then process by calling the isr if there is.
> 
> So what about system suspend, do you need to do something to
> ensure the timer does not happen to run while suspending?

Great question. Tested the MCAN using timer polling method and

it seems to suspend to RAM but not resume. Meanwhile MCAN using

hardware irq suspends and resumes from RAM just fine. Will look

deeper into this here soon. Thank you Tony for bringing this up.



regards,

Judith
