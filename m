Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A596F4EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjECDCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjECDCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:02:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA501FCD;
        Tue,  2 May 2023 20:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQWsJMf51ElXDHsa/X9tMHln4132eJaUYYoZoO7kKKUmyOPxOJpGMQWAlIy5avLsd4gUykyQ5s3cdN5N/tPKmyDGVrXx6VRJmvL4QXdcCZNcA8AsG9U7YIvX6a0jB0IR7VQYK628xEjTuW4GrfZ2WSzKwWPAM4+9iJmHbcq8v3Q+HYu0D20/xXqpvk8xtZ8mp9/o6q5pfgm+XNfqYvv75FBYJuAv1KbMfmt7BC5y/CuD8+97hyEKir+YZjW/E/9IT0fwSK3JYx7LLtBx7dNOt+pBsnfFSwsZWCzAwSKPILV7RRDcDHNpi2okoHrce65KLjtR9oaXn9bqU5aSiEqOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvUIeX62wwSPxxKxiN7bLriVsU4Gy7579N+cgMFHHDo=;
 b=UuuW58NOodgMEj4NgZ6phureWUiJza6Zvtsyn+VlPTQ0bkjOGly25M0ZGHwdmyn1TRE8dwJhxj4FnWJoY9ibgWde3aV7qGvjI4yDZnleJ68R8cbO6lT42398+sQ5m6xsxNxUCIbi2tUELQ7yHpZbtISIuBT06CONtOo++Rh3dXa/E5P6ntvvMZ4np/Jx9oeOC5/cH5JO6K78tkuF9s/eAPLTOTyKj5dnMANiIDG80kJmjsSHqLVVZoWb44hnVajR2DSabxq5uIwDJNY8EUwbmeuZm2D/sjGgJeKxZfG012wJCiwi7UYn4kmKDyj2PQJ3/w/5XL4WsR622NqwMHu4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvUIeX62wwSPxxKxiN7bLriVsU4Gy7579N+cgMFHHDo=;
 b=KBPKnGmStApTZndPlBXQp1pJeFI2iTghiqs34583t1ZFhXvMnFzD8O/N21vG9oDMTQHCxSWd6DFVmDyfV2D5Ef7XnF6QFLRumeTwD0hGHaUnky2Lune1bZ13/3YEnq6D/UzOfghoMx4G3AowoFRppn39PexpFRqFUhZyJUZ4CFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA1PR08MB7214.namprd08.prod.outlook.com
 (2603:10b6:806:18b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.32; Wed, 3 May
 2023 03:02:32 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 03:02:32 +0000
Date:   Tue, 2 May 2023 22:02:24 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZFHOwEu6tKDjoPA4@nixie71>
References: <ZEnErxfnSn2JOpvm@nixie71>
 <20230428102015.810686-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428102015.810686-1-tomas.mudrunka@gmail.com>
X-ClientProxiedBy: SN1PR12CA0101.namprd12.prod.outlook.com
 (2603:10b6:802:21::36) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA1PR08MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: d12f2c65-f5d8-4f10-bbe2-08db4b82d691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnCTtfeFufjbCq6NMLKpssmjTeXrxHIf0Pp3NXxhkHebg4rY4ZfM1YjcicxwhA3X1cxYyrbLcT5tmVIg277Yj5IknKGUZkurDYi4wcEggU+B7KLXEvct5TS/3HW/HgD0TYVacsUYi7V2CN2hfzL/QBNN2tp5QsbnXgmbfwtVnd+8/ZD+OAQeaghF9/P1sllT5/eebN0ekqPHDFCTYRUV1BH3P9MBUv524c7QZAuHMCJ1cQDsREAhxfXOwLAru6JLvE5+J367y98BPZSExpGvmR8J+KHvPPB7HV92XbSC1QhmrSiPnRRlzSmE/T0iIHrX5W0rFCrrTz5TIJSmGY4eo0gTu3evc8tgY7iNLa8iZZMUTYEJQBlq31e31ybX42SBBZlq2WLcZ7aFngLCybNz1Qrd7co6OFkhrUdjS8OEqbZj1AQ47QbdCyyanw3R/hc2qDddtNdyVaOC9dsZiH+pbH14fTHaz+X4DoaHUjF74sPsI1MbpPd54vf60NQHgd1wv0kPpfd2jFvqQ//cjyHcdOvgMjJhnqFyoXg88fr8taJoinESILF6jK8r57d8o86w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(346002)(136003)(39830400003)(366004)(451199021)(6916009)(6666004)(186003)(6486002)(83380400001)(26005)(33716001)(6512007)(9686003)(6506007)(478600001)(4326008)(66476007)(66946007)(66556008)(316002)(38100700002)(8676002)(8936002)(5660300002)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQHsAFAPeB4waTIB/SZTKyrEHg0FvrGTegbo9EVYJ3F2uk+YKH0I605OlnFt?=
 =?us-ascii?Q?ZpgiXInzG/vwrNV6IZnJdN5kwvysybNItn2LeZ+4SWnIWN+VOw5GK5yKXVru?=
 =?us-ascii?Q?Qft4DkInxve0ztltPXyks3OJLXJC9OfIHG/Y/gIywYXcR44v7h1oCWuoAw+m?=
 =?us-ascii?Q?V1GSb4WgAZ91GmAL6GNAHQdqN/oKFpFTOrxiMM63PGt+NUbR/J56aMABf1U9?=
 =?us-ascii?Q?ah3s7jHduO5jtE2S8rWSwKiO71GUv/IJT+mMyYLqxmFOne87Lfo54iDOO9gm?=
 =?us-ascii?Q?F4amCSjOFkONSk+4dGjDfjusizDOQUzd/zFT5E/HmCnfMaY+6Zt0usWhfCZg?=
 =?us-ascii?Q?lV5gSZ4yYYIhvBtYvqOT4+pHJDRY1SZ7LuNg934MEv+daEcS5V88xhS0DO91?=
 =?us-ascii?Q?jwMWVmbQX2Xb8rY5/h3V1MV91vcvOuuSBWAUt7TbyuEIccITE62KY2bqksxH?=
 =?us-ascii?Q?NbuNptqA4yuARMRge9adlyp3A86sm9SReiQlNwfncsQupssefuFKnvqoF58S?=
 =?us-ascii?Q?gBsahIhjIhmPE+ioCR1M86xc3CVWMDh5aMUr3Zx7MJOGVgQHNiHRodpZB8Rr?=
 =?us-ascii?Q?ggDQjMKcydRLqYTUlY2H8xBp8+0PfuP5zGY5SNfCNPRI5ppdiqMgS+Ol0dQl?=
 =?us-ascii?Q?Sx/P0ylXspgU9lG0XM0k1qpiXkpqbejWJO/WyHsbkuzWvstsfeI06F8k0mN5?=
 =?us-ascii?Q?V4ToarEgfhuRCovVy7pW4AIqiJ1lNT7O49EgJAxh6JcypaIxQis8eAiMYHk6?=
 =?us-ascii?Q?FHoetNQ/GlUbi6HRWix+8t91hZ454ccz3opvFa93HqqDy5khNMooCesKeMXj?=
 =?us-ascii?Q?TnjzaoLpm8z8xzl5hpntKCk1z2eflV92ng9nq5inRAJ7GWKYkLkmosUqoNH0?=
 =?us-ascii?Q?hE7gcWSXfJ+htGIPkMXRmtTefHtgwBG0PA9ebnpbyPTOCS9kbyHEv/earmfp?=
 =?us-ascii?Q?uV96G9XroSuwHA6dHM4qw+3mlkywM/FcQs0sW+5YvnGDiHXbAjEiZ0f5zh8/?=
 =?us-ascii?Q?rplY/8XKNCT6B+Isrdy+3qo+HSZmNr0dR2bBA0A8JXVNfMeogdRw4V9RT4PL?=
 =?us-ascii?Q?RoNqwuZK8BhKFV4SCUFMuvWKyHU7cUXkNk8sK8dZuFz3UyWS3YgsjcgnG7wf?=
 =?us-ascii?Q?PTR/WCTSn9Lm66Jg+ossG2Xipq4bYq2/yrQ3zv7Ez1fwN5WYrYm+E5YXlsu+?=
 =?us-ascii?Q?AB8+RiV0Ip21EhkHoTwJ3oFINrhCdvhVQhkx2lLHzrFFgpkQTxYsYYh3752/?=
 =?us-ascii?Q?z6wJ0PNI7tmJhfEpScOsjZ1dmjWQi+4pRi8Ujm8mKfg42F0TVivXfRS3pssg?=
 =?us-ascii?Q?vhNXumIdk9oIMgGBDr7e01hC4YbQupurO3cbiKlO3C7peAOzywWVdMUhuUDz?=
 =?us-ascii?Q?GA6bHHlrHicFlXp3gtEPNBWIN/c0saCVPHSIxaGWfJ/E1IjWYwnRexfCx1jR?=
 =?us-ascii?Q?q3EnVTBO29Vb7hp0uRaixd0PuFHe+RHWV58NbGUFCvi9y9P6R9Ucd+2Noozg?=
 =?us-ascii?Q?cTlzx5MraAdw92YM3eRSOMo8TORmsQgvewIgVLs72vRTvV+P/LutqgFN6njb?=
 =?us-ascii?Q?CZdP9mirXUBNnb7zRDrD1tBIBCKi+5hQbSTCiAF/?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12f2c65-f5d8-4f10-bbe2-08db4b82d691
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 03:02:32.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iig3eWN92VpzEuHrNaNodnasX2vwRzacEAaW6UApjG/YvhmEUIk7uRF52N+P83Giyr73Ihyob1DUyueAgFHVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7214
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Fri, Apr 28, 2023 at 12:20:15PM +0200, Tomas Mudrunka wrote:
> LM8333 uses gpio interrupt line which is triggered by falling edge.
> When button is pressed before driver is loaded,
> driver will miss the edge and never respond again.
> To fix this we run the interrupt handler after registering IRQ
> to clear the interrupt via i2c command.
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
>  drivers/input/keyboard/lm8333.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index 7457c3220..9a810ca00 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -184,6 +184,8 @@ static int lm8333_probe(struct i2c_client *client)
>  	if (err)
>  		goto free_mem;
>  
> +	lm8333_irq_thread(client->irq, lm8333);

Just to clarify, my stance is that this call should go _before_ the handler
is registered. Your earlier statement that doing so would steal any pending
status from the handler is correct; however, it is a moot point because the
handler cannot do anything with that status until the input device has been
registered anyway.

Any events that come before then are off the table, and this is OK because
user space isn't going to start consuming key events until well after this
driver has probed anyway.

The reason behind my assertion is that as a matter of best practice, you
should not have two asynchronous threads that can in theory access the same
register. You are correct that the handler would simply return IRQ_NONE in
such a race, but it sets a bad precedent and opens room for bugs in case
this driver is modified in the future. It also creates one unnecessary I2C
read.

This is why it is much more common to register the handler _after_ manually
accessing read-to-clear registers; the register access remains synchronous.
In case you feel I have misunderstood, please let me know.

> +
>  	err = input_register_device(input);
>  	if (err)
>  		goto free_irq;
> -- 
> 2.40.0

Kind regards,
Jeff LaBundy
