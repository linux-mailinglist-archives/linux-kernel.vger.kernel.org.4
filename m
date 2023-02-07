Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E721868D842
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjBGNIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjBGNH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:07:57 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C233B0C8;
        Tue,  7 Feb 2023 05:07:33 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 317D6CsR033880;
        Tue, 7 Feb 2023 07:06:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675775172;
        bh=ekpjB4H4unY73nJ7BkdNZHsEInjoxv8tnvp+z0/THYw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SCEbkJ2JVL81GhMal0ahTjr9ZTbbGSd8TKcQIa4oRBAIu6mb9j1H0tabPyPO0VffD
         FuyDvoy7q9/99tVHVuZiwhjxfeX6cQrRiPLdTqJhWONkdCAzN9B28XyOn0Ct4fPi/r
         zkr9KGvedmNaoDGAZxRerzS6sliLz5U3i3X31rHI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 317D6CE3036467
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Feb 2023 07:06:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Feb 2023 07:06:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Feb 2023 07:06:12 -0600
Received: from [172.24.221.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 317D67Rc025797;
        Tue, 7 Feb 2023 07:06:09 -0600
Message-ID: <f624e2f0-5fcf-a5b4-8376-6ef37a799493@ti.com>
Date:   Tue, 7 Feb 2023 18:36:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/4] spi: cadence-quadspi: Reset CMD_CTRL Reg on cmd
 r/w completion
Content-Language: en-US
To:     Pratyush Yadav <ptyadav@amazon.de>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Takahiro.Kuwano@infineon.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-2-d-gole@ti.com> <mafs07cx8f1oc.fsf_-_@amazon.de>
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <mafs07cx8f1oc.fsf_-_@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look Pratyush!

On 1/27/2023 8:46 PM, Pratyush Yadav wrote:
> Hi,
>
> On Wed, Jan 25 2023, Dhruva Gole wrote:
>
>> If one leaves the CQSPI_REG_CMDCTRL in an unclean state this may cause
>> issues in future command reads. This issue came to light when some flash
>> reads in STIG mode were coming back dirty.
> Can you explain in more detail what you mean by "reads coming back
> dirty"? Because I don't see any clear reason why not resetting the
> register would break anything. We re-create the register value from the
> scratch on the next read anyway, and as soon as you writel() that, the
> old fields get thrown away anyway.
There's a hardware bug due to which clearing of this register is necessary.
> [...]

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

