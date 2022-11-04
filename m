Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE690619BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiKDPkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiKDPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:40:02 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20087.outbound.protection.outlook.com [40.107.2.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A8031351;
        Fri,  4 Nov 2022 08:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQOwsOivqsBIAUXoDsZdDOv9L7FDjWSlVtSCtq//8U1iVtsAjPc3G1o7WmTwrF7x0MV91dvJZXgB4ecGJj1uNF4jafwO+8B2Udzi8U27G8VbfYWypUzcenDgArb/q4utJVGM69aXolcp1g5a1V2KHaTeLMnTu/x9iFgHcTtvr2sSdaRY30G8AMDTuxt8oiIsoHPKdaDXo6IbXk3swLCAPJ61yxUHBr06z9sLf5G2vuGb6OOLQuymFscXvMGZoHiKeES3OpOlcKID3ZMgfANsXvxAh5mG7pmppqMqHf19DrpVBBXrufBTBMH/abkAlWhauuWqmiZgIkMXaFV+BPCuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2IBX/nzIRtqLD2cyiysD9UwDedddRpxtqwDQwvUvfs=;
 b=BRSouZIPkm1E60GOrmDZ8EkwbwTNdhrEvk2pCNn9vSN2VnEL7A4QDHuu3LlMeE0ECh+trORSS2UCVtYSUVPmGuCS38og+uzSb2DdRV8EWh4YY0oX4ndKIBP8FT/SKjsSJFx95rbfUP+nhcS4sJYT3o1GYAIyG2IqSKZoiMyvNZNGL1eGck2M5qOb//9vcm9c1w5fXeL5uvJHdfCK3zgPYBoQY3j8BI+OEGJRQg/yZ+mRMnVXKLSOZz3CAZ+0G6vp0OkDVc/HhNwkB2ripcExmkj0XnAss5+qIFG1RqqV4SMC6SbAbmCOEYzFaGnEvUTM1jB99giMp464sjBOCS3RLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2IBX/nzIRtqLD2cyiysD9UwDedddRpxtqwDQwvUvfs=;
 b=OkDUiXbf1KrectFnmaTPyDBbBNPe01uhZacEEZo8UFrY/bZIb+qCc/bZnC1koyx7ZEgbTV2i2ml0UfBOSLpHv1ur1oXvzz14GlB23hLF2A+opFADn2O3HKWuOBRr8XrPeEaXlZ7vqP33KAnXI3IZ1CQJt0lQMDYc5G0+URG/IGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by DU2P193MB2084.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 15:39:57 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::5d12:7b6f:bc9a:303a]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::5d12:7b6f:bc9a:303a%3]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 15:39:57 +0000
Message-ID: <ca35058d-1f40-3f85-9e2d-bfb29c8625cb@xsightlabs.com>
Date:   Fri, 4 Nov 2022 11:39:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "lihuisong (C)" <lihuisong@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        huangdaode@huawei.com, tanxiaofei@huawei.com
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
 <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
 <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
 <20221104151530.44sms3fnarqnvvsl@bogus>
Content-Language: en-US
From:   Robbie King <robbiek@xsightlabs.com>
In-Reply-To: <20221104151530.44sms3fnarqnvvsl@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0395.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::10) To AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:446::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2335:EE_|DU2P193MB2084:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dfdcdd-48b5-4982-0221-08dabe7ad3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tshDTCCyq1VqYoOpoQUvwLX7WG09hzbQZtMPIjeZg+5aHDHH3mRLYHfpkMS2KWsXMrMxEKUM4IPlVqKcXhdI23pPZGpG89rU3w+NHNqjMMmXkh4l66XFU2JkhVP5acLH/aVfpkSKEQZlRTftScpYFC10CuxnaLLzrTyD9LvNFvh9zwazUSssjq3uOR+q82lmtkJwtGZHDGeu2AJzoFDilG4UxRoq6bCuYdZRfXHLwm5AIJYmZMCthuQswda1RDYGMKyYN8ef0YKMLUIodFDy7aof9pZIcNoK4PlTp41+S1z9LGK2hsQH6KwwwUGO4OvhByXmLQPMY4kx/NAYqIce9vGahT6xP+uLd4Dirm4kO9UgGoKYpNeE+CNLZJAyTOCqeEbPuMiQmTWcjHCRQVsYqIV6acE6KG9EuF4hHueqessBrxrJjPWv5up7q0gsF9K3/z2XXBbHGUAu+8eTRBguRWD00uu5kUMkvuJ5CiHoQTwZPFtcgDL4d5rHEbNzu9ktHcoxMIRSakTWXoolkPLIjNxf+waFHvaTgv8o9icdF8lYrCc24HEV8w8jGGtMcAhpct76IZDmwLeKklEXN5Ec19Aei59LDP4SWq73n8fSWuQoXLRNdh0pYYOJ+aXVAd3ONGnDg9X+QcSQpvBRt4fVy5Svr8Rz4wgdzgvjYqWuuRWWuSmSFipW5TqiIFR2/ZFwUm9Gi8HaDtXdBvqoiwqSv7XXc3Eg1BFVNijdT+zfzzyZWFQ+rzRY+bVcZ4X2BFYhVbMVdYfbJojQhCSgv8l3rdEcjLIoNIeXnn9lWuSlG2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39830400003)(136003)(451199015)(83380400001)(2906002)(31686004)(4326008)(66946007)(66556008)(66476007)(8676002)(6512007)(41300700001)(36756003)(31696002)(86362001)(26005)(316002)(6916009)(6666004)(38100700002)(186003)(8936002)(5660300002)(2616005)(6506007)(53546011)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEtCQnNub3JHNWtqQ28xWGdSV0tjUTlxdFNPbHdSdEgwc1ZjNWt4Q09VdlNM?=
 =?utf-8?B?bkRZdVIzb0I4eEVJYTRwRVBxbmxJR3JueGRIUDNtK1Vnc0p0T1BBZmcxOVg0?=
 =?utf-8?B?dEQ1cmxtZWMvNzA5NzB5MzVvZ0JzU3g2RWV3RWRKTGtpVVNOeTRodkJINlRN?=
 =?utf-8?B?NlJCazRyWGx2cWJwWURmdy92Mk9hUVpmY1czY2VXdE1CY2tsS1dQWjJjWXF6?=
 =?utf-8?B?SldkWkxOa2I4NlZBSVZZMHNXMVBvMTBNTklMS2szeTRJU3dlbkc0WnFlMHd3?=
 =?utf-8?B?QUhhL1docGFPdjRwMU5oVXZkc2pqRUJicHBUUHRvR3VCY2VTOFpsZWFlN09B?=
 =?utf-8?B?Z2t0cDZyWXJETVVObkhmb1VhWG1uTEl2RUwwSlRvb3d2WXVrblpJcU4yekpG?=
 =?utf-8?B?RHd0eTJJVXQzTkRxY1dpQ2hCZHNEaFpHOFpNRW56TlZvelltWG1JaU5Wd3Z5?=
 =?utf-8?B?QkhwYkxkTUEwMVJaNGdnNVo2Nk5EbVJ4YVZYRlArZkV5bmV6WjhaazlGU1dY?=
 =?utf-8?B?RnJsemZlNGdNd1hTQ25PS2tCd0FSVzVBVG9Fc3Zjb1EvNmhIZGhoSHYrWWJt?=
 =?utf-8?B?OVovMTcwbitVNngyak5JeWV4VkliOFFvSE1MbHVwOERBMTRsd2ttRkZNeTVN?=
 =?utf-8?B?STVLa2x4NUtzYk9zNUJaNU5BdE1ocnNucGJLem1TWG0zbTBCd21ZV2tmM3hB?=
 =?utf-8?B?eW02YjhIMmdSMGM5b2hXUVh0aUljSWRIdWRJWTBFV2N0NGpGWDVtak1CbEZ3?=
 =?utf-8?B?VWVNQzg5QXk3ZzRrSFpCT1lnRUhSMjR1eitqVnlkVHI2ajUzR0FzNXQwRGFt?=
 =?utf-8?B?cWRXd3NnMUFPSytuNTZKbnNtSFdwWDVtK0xZZW91NUFvOWc1SmZicXZXc09u?=
 =?utf-8?B?VExNQ2JNYlBERzRheHhMMzFyY3F5aGVFaVViak5Kc1R6bTZIM2NMT2dqYmdD?=
 =?utf-8?B?ZlpHZklxblZDV0lNSFFTcm83TE8rL3BETm9xUURaMHhvd0p6RDZGblhSZGdU?=
 =?utf-8?B?S2JoZ3ZlR0pPSmo4VXVqM1BmYWlOY2V5eU5qa2s0NEl3ay90U1ZxV2xsMWZI?=
 =?utf-8?B?Vkx0RzlEa25QZDk1WVpCcWs2Y1hWSExpaUJpWVptSlhBckgvSUJqbFpqSVVY?=
 =?utf-8?B?OXdMSW9iY0dSVUxZS3R0RSs3RHBhcG1nenF0eWViT2tFeXRjMTBFZlFJeW1D?=
 =?utf-8?B?bnFBR1NsMHJIcnJjK0NDeWFPVHJTOHMvb2YzTnNVSHVEdTZGTm14bnNPa0w1?=
 =?utf-8?B?cU4xWElyYVhWaXRCa1RNNGpVWDFHRVVvUlZZZDI5Sk9MbFBKdWlvWklGMkdB?=
 =?utf-8?B?eGlxb1Jja3VaV3NCOThNc0lnY2EyTGhJZEFxSFlhSHFEUVZDQ1VrSDc2cXRL?=
 =?utf-8?B?WXozY24wZjRzTlNYcEZ4VHpZS0QyQzdkYjlyaHRpcEJKa2RSVzMrNitFeDkw?=
 =?utf-8?B?SE9GT2tEd3ZZbWtvNmRzN1dyeDhzMWQ1MXBDSXg4VGVFTkVoemFMTmZYaGMv?=
 =?utf-8?B?a2RDTEQ3VmZoYys2K2IvYW92bytvS0ZQVjA0NlUyQmVYdmkzM1lhVmJ3L3Zu?=
 =?utf-8?B?Zmx6cmFMbi9JTnJWZWJFREV1YUU0ZFVGUEZzQVlESXQ2eEVRVURpMDB3Nk1h?=
 =?utf-8?B?akc4cEhTcFRuTEFTU1ByMVZjL2ZXWmxnL1ZxVDFvaFNDazZBbjF4WnR3VWtT?=
 =?utf-8?B?aHU5L1ZTQ1VTOW5KcHdtaE5xUE9tSEdKSmMzMWlGaEVWaStnN3AxRGZXKy9n?=
 =?utf-8?B?Mk1FY2VjanJveWc4TmhuVVp3MGNBL25QRHg0ZkQxb2FXa00xUm9rUHBBY2xP?=
 =?utf-8?B?L2doZTZwclhPdEJoRUg3UVBseWsybEp6WGhTUmpSY0JXbGt3TmJ6ZUcxSFdv?=
 =?utf-8?B?aVpNd29WUUxic1ZNYnlXelBIczZ4dEoyaU95MHpkcVRiUlJRWEc5SXRiWnpH?=
 =?utf-8?B?QXlyWFUrdjJMeiszT0trdWZyV2dCY1orNTk2c3BsRlNsa2M0TTFwVTdaLzZx?=
 =?utf-8?B?a0kwcS9WY2VmTUF3MWpIL0VtbWFocGYxM2xrSHdJeVZFWEZNTS9NZWZTYmtU?=
 =?utf-8?B?K0dWbHMvT1RqbnNNSTZzSXl4cEpqcEN3YkppQ1FEeHpOWlFGSlo2UDdwZHFS?=
 =?utf-8?Q?kpPOzuSgm+mSjDnzyk22Rc4Cl?=
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dfdcdd-48b5-4982-0221-08dabe7ad3d7
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 15:39:57.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeSH5tvZ26QuNv95tIU93U+7g8fwL19AhELiWkhHkp+9rpHbuQSlkZ4SAQZffYKblWsjJtJ7+gNYJszdwhNdtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/2022 11:15 AM, Sudeep Holla wrote:
> On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
>> Hello Huisong, your raising of the shared interrupt issue is very timely, I
>> am working to implement "Extended PCC subspaces (types 3 and 4)" using PCC
>> on the ARM RDN2 reference platform as a proof of concept, and encountered
>> this issue as well.  FWIW, I am currently testing using Sudeep's patch with
>> the "chan_in_use" flag removed, and so far have not encountered any issues.
>>
> 
> Interesting, do you mean the patch I post in this thread but without the
> whole chan_in_use flag ?

That's right, diff I'm running with is attached to end of message.

> 
>> I think the RDN2 may provide an example of a write only interrupt
>> acknowledge mechanism mentioned by Sudeep.
>>
> 
> Yes.
> 
>> The RDN2 reference design uses the MHUv2 IP for the doorbell mechanism.  If
>> my implementation is correct (and it quite possibly is not), acknowledging
>> the DB interrupt from the platform is accomplished by writing a 1 to the
>> appropriate bit in the receiver channel window CH_CLR register, which is
>> documented as:
>>
>>    Channel flag clear.
>>    Write 0b1 to a bit clears the corresponding bit in the CH_ST and CH_ST_MSK.
>>    Writing 0b0 has no effect.
>>    Each bit always reads as 0b0.
>>
> 
> Correct, on this MHUv[1-2], it is write only register and it reads zero.
> So basically you will ignore the interrupt if we apply the logic Huisong
> proposed initially.
> 
>> in the "Arm Corstone SSE-700 Subsystem Technical Reference Manual".
>>
>> Apologies if I am off in the weeds here as I have only been working with
>> PCC/SCMI for a very short period of time.
> 
> Good to know info :).
> 

It helps that your linux / firmware code is easy to follow! :)

One other minor issue I encountered was that a NULL GAS (all zeros) doesn't
seem to be supported by pcc_chan_reg_init, may be a good opportunity for me
to submit my first RFC...

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ed18936b8ce6..3fa7335d15b0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -100,6 +100,7 @@ struct pcc_chan_info {
         struct pcc_chan_reg cmd_update;
         struct pcc_chan_reg error;
         int plat_irq;
+       unsigned int plat_irq_flags;
  };

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ed18936b8ce6..3fa7335d15b0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -100,6 +100,7 @@ struct pcc_chan_info {
         struct pcc_chan_reg cmd_update;
         struct pcc_chan_reg error;
         int plat_irq;
+       unsigned int plat_irq_flags;
  };

  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -221,6 +222,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
         return acpi_register_gsi(NULL, interrupt, trigger, polarity);
  }

+static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
+{
+       return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
+               ACPI_LEVEL_SENSITIVE;
+}
+
  /**
   * pcc_mbox_irq - PCC mailbox interrupt handler
   * @irq:       interrupt number
@@ -310,9 +317,12 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)

         if (pchan->plat_irq > 0) {
                 int rc;
+               unsigned long irqflags;

-               rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
-                                     MBOX_IRQ_NAME, chan);
+               irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
+                           IRQF_SHARED | IRQF_ONESHOT : 0;
+               rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
+                                     irqflags, MBOX_IRQ_NAME, chan);
                 if (unlikely(rc)) {
                         dev_err(dev, "failed to register PCC interrupt %d\n",
                                 pchan->plat_irq);
@@ -458,6 +468,8 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
                 return -EINVAL;
         }

+       pchan->plat_irq_flags = pcct_ss->flags;
+
         if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
                 struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;


