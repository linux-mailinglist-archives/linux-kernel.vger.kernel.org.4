Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF66E01C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDLWY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLWYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:24:24 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D3212C;
        Wed, 12 Apr 2023 15:24:23 -0700 (PDT)
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CCQAYC017329;
        Wed, 12 Apr 2023 17:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=qb5LCnced+tR9V4jeBszH4eecmT9tsNshbb23nqd1ag=;
 b=0z4tNAfbszb1cUFSKaVojP9JL1pcJ774Ih5xVhYepO+3ZCClUCfEw21YX21R9F7pTuMs
 8MlmyQl29YA9+KrDGyro2RExnTJVYjMWl7OKlRQQ6LzJzR9r9Hyu235WeU4LtfisKNnL
 HPZCbcFfgIZdRs7Eu2FK8Y33GAnl2fgP5Du/P0F0mSObXhL0xv5eWQv3ggQlgfuRrZfc
 Bs7kjApnbhqATO5W7opCjyiOW2xqUhtOaDxlFDCdDj3b/+6qph0MfVoLjYrkEINFD0B1
 uFbSp+XhbkDXuZ9NPgmcK45YWcLQRfEEwb8YPe7qlNEokrAO2Du69X2sqVCrtb5gVxOF Dw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3pu638ypug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:24:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBr7nsjF0yP3vmgtJrWYuWZFMkztc+Sl8HOrE/2ej0TCNuFlFmO//Rl7HnkFaWRJb3bXiAVChHHYSQC4FLb2AN8p1Mp339j3e6we1BxCCTlbnjQiMJlmXIv6bUNt+izsNEMYFfj/EuJ7zMy5ZF6f5s+eXTFWWSN9a6iMRNYGdciEZo1coqIiIPu4r5dj9IxyAwj0wb29c2tzIDHD/jfL2PQ6wsW0oSc61fqZ1Xj+ZFN3KvQRXAjpxQOKxzQi/tdeWazduaGJgQrvcFWRYo32kSaWAdpFuPZir+lgThEnKs9FdlBI8DVHKZnSLVIHqtDdiO6KVsQ1DYqIaPDwW3Y/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb5LCnced+tR9V4jeBszH4eecmT9tsNshbb23nqd1ag=;
 b=IixUWERFKSQGu4+3NK0gnFf3zGyfuSzZNR40VYS0Qhd6w/ptBpf/cXVSfanJeTL+EP7zbifRjCZIOREWkLMgCoCrw+SsDjvQjrcUx6QvKbVjsuFZDl/muHeIXomapYHgaxaxNwDuF5KmOArri00rW6iTYbzVmXguYxFmvlHjcmoaOzRi8FfDbh0j8PG2IvZ/EiJbgecwPC4qy7gDUWZh1rferz82zyTvjizh6tCjEF1vqBqkcmKZBADjVfuHadzvLbphVNfKaL82cfbwxS5wVCDFTy9xH0sxiTWsFko1enjb9+25k7AFJo/BSUjCGOlTogxSeTpmTGe3BGvOkjQvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb5LCnced+tR9V4jeBszH4eecmT9tsNshbb23nqd1ag=;
 b=LMFMvZQGV2ujFeRUpyeTZauxMykFEcvVIdUnoVzZvNU76Qhp/8hARq/BJirlMBZEb/FOmscjc4kDv3sJDAHijh10irZG4FhPYZm+Pj09uHp+XShb6ZYufEu7a+GapuFoCbG8kqAjd0Fj0hA36dyECi7++vx4wzJ/nAU8udEigR4=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by MN2PR04MB6766.namprd04.prod.outlook.com (2603:10b6:208:1f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 22:24:05 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%4]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 22:24:05 +0000
Message-ID: <b92e2f18-4fd0-0510-4a85-36d7a200c9fe@ni.com>
Date:   Wed, 12 Apr 2023 17:24:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230410211152.94332-2-brenda.streiff@ni.com>
 <b2f81c57-9b7c-9ad6-6ce6-cc94703599db@linaro.org>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <b2f81c57-9b7c-9ad6-6ce6-cc94703599db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:806:d2::19) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|MN2PR04MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bad68f-c2bc-4651-5e47-08db3ba4a032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5mpTTL6WJewDwTAWx+nlHjFSreXX6ShvKflTETAlWPMj24lRHBPIN5IwOg94tY0zmAEKntwy8mvPlRUTqFwsrIHYGbz2DBqDs62U/Dl8INjB10rPQvIXZHwvpqG89DlrjsIJNFR+txCxwjU331MmKG91t07syVh5Fo+mPQd4MsL82ajJr1XuqC7RN0wnHipw/pze78jm/giuvVWb9NT3a0Rx62qVCJfPfdLrZjmlC4bwvZ/OVF2XYr3fy+rR095Kg1loDnH7JixAdMmbp8z0a5zoIlQsqI02nNpA84wr60gkxXFeQJ1fgY2zuSlqtqlMIKcSGBpMmdNkiocPGco1wlSyKEbXnb9eREZ/Q0GCjGR2C0egO6vbBQ4/CnHjgxSDaI7njdHND2CxEkT9/l9oKoXpxJ1v2CzjL4dd9emPsby0hbfksdrrTKZmZJlk69xLhPvS7p7LTD2WAGaAFjCzACsh+dtFqG0njMH5mGi107X/eIy6/anSucB4uTLyVDQfuFaynEB1d2VxOjl0bcLBMSjdIX5CfWlrCDzChY0u6wIGR9m6UxO2GI1bj1oeJ67qVGcyszPTN0dheVYGUAADBZQbKCMiT7K3REVaV5SL6U00cJg2p0bJvVg0P2mrntfoskg09Gyt/UWRR6gTNWJ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(2906002)(4744005)(31686004)(8676002)(8936002)(5660300002)(44832011)(478600001)(41300700001)(316002)(66946007)(66556008)(83380400001)(66476007)(54906003)(36756003)(6916009)(4326008)(31696002)(26005)(86362001)(6666004)(38100700002)(186003)(6486002)(53546011)(6506007)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWd3RDJPL3MwNEFBcGR4UWZUallrR1pOYng5S282WkJVWUMzMGtjOXR2WDNr?=
 =?utf-8?B?bkk2WlRaYVFFS0xQRDdpeUpzU0trVDVZdnF1R2JLVEVrdG1OcFhwTzlTTmRr?=
 =?utf-8?B?M1o1U2ppVi81MHRmWVZKaXA5VXgxb0c1RlVuVVV0MWlvbVBwcW15UDBCSWFj?=
 =?utf-8?B?bDBPRDEwczhacGpKdGZLMWlaUjY1LzlMVG1hQ3R2cy9GZWlwTWN1V2R1OERO?=
 =?utf-8?B?VGJzZDVSYmROTDQwRmNLaTEzeEkycHFLTVRINUdwUHQ3cXRjL0ZVK0VTWlNx?=
 =?utf-8?B?Ujc4NlEwVDBNTlQ1dHVSdkNGakV0SkNQekQrdW5MTXF4RTNSS3FXM1VBZTdW?=
 =?utf-8?B?M3A3Tk5MR2Z6VlAvT1psam04aDYwZTkyUG13ek95a1hxblVTTmpiQVVNLzhP?=
 =?utf-8?B?ZFVRRGNCeHNXQjVLLzYyNHAyVHRtOUdnWmp5bmlKbEJPeExEcWgwc3dCSExV?=
 =?utf-8?B?RkszZDlER21VYkg3UDhrQndySCtuSlVReXFkdVkrU3RxQ05FSU84Q1ZHN3Jr?=
 =?utf-8?B?YlRZRDdMNnhSREhHTWRIRWFFM3pzSFV0bGc2OXNHMHlOOWJRMEhCZFBpV1hk?=
 =?utf-8?B?ZkJLVjVuWkN3V24vaEFjWVdmSGVSTE5wOVpoT2JpYWxSNVhuTGtsT3VpRWVu?=
 =?utf-8?B?YVROTDFERzRJTTdaY3ZJNE1PK2tVZTlxZHByTEhSaUZJeGlLTEJFamdDZGNy?=
 =?utf-8?B?MzQ4d2NweFBjcVcvTzR6K1lvR0xnbjNIQWJEbzNvdENzRFh1UjFwRUNKQTFy?=
 =?utf-8?B?ekZBVW03dXcyVlRUN3Z1YUxGZ21mdTNadmFXWkRzTFZXckZOaHlaZFY1YTRv?=
 =?utf-8?B?TXJxajdFcDFkNE1vT1R2czc5ajVvNmUwS3NUOXdTb1h2MnczRnpLMVR2Y2JI?=
 =?utf-8?B?b0xuQy9rbGx3d3J1dGwwTmlQMHpVK1ZkOStNbGNCa0pyMzJwRTBPWWFadFoy?=
 =?utf-8?B?VHYwWjdocFN4QitoUmh0UjNieE53dmRiQWN0U1ZTZVRrWTFJQXJPSHdNNmxl?=
 =?utf-8?B?NjVPdVF3WHBGczY0RXdXRmIwbWI1Vm5tbHlLTDJwOEpVWk5kNGVEdnZXZ2Fy?=
 =?utf-8?B?WFJUUC93UWVvV0FPZlk4UjZnZ2hoNUZsL0kyMVhKL3Q5N0xseDZ0NUduR0wx?=
 =?utf-8?B?YmpiQk9icG8zb0RFQ1lWM1U0SDMvVXpDeG9GcGlhNDczRHhjY2ZscVFodnNt?=
 =?utf-8?B?UXRpb0Z2VnlBUTBiTUFubE9KSFV6ZkJYd2dkTWFLUjJKSFNtUGlUQTJISXZy?=
 =?utf-8?B?YnBKanVJdUdaUWhVU0lsdnRITGp6ZkxyUjJBN3g4RG5ZSzZZcFFUR3pCc1Vr?=
 =?utf-8?B?UEVqUlV3Q3RuR2RDVzBQelRySFc0SzJVWjBNdzRsT0Jjd3pkZElUMDlOclI0?=
 =?utf-8?B?NnpsVWFiSDFyKzJwOFdXSEY1SDVHZ3J3Uk10dUE2UzlwYld1UkFHRFpzeWp1?=
 =?utf-8?B?b3dnd3QrTnhidDg2QVVlNG83S3BZZHRiR2pkdng5akZQTG0zR0hMdVVPNnJZ?=
 =?utf-8?B?TFhqRCtHMnNQU3pyZzYreWUrUjA1dWtJaTFZOEM4dmNOV0JPYVZqWVI2akpz?=
 =?utf-8?B?N0JPM0FJWXlycFU0VnQyYmRuODJxTHRlcmZNbWdSRi9VQ0pCNi9KTlphRDIz?=
 =?utf-8?B?OFNSU0hVVkFuS0xkWUE1dTFLczF4NEtQY3A2UEhsZGQ3eER2Mzg4d1h5Nk9r?=
 =?utf-8?B?UnEzM1ROV0pVNkxDK1ZRdHdHMHBBNmRIOGt3cWlpTXMxWUpiakR0czZpa1BR?=
 =?utf-8?B?ZGpIZ1ZsYW1XV29wekpPZ0g1MDRDY2hETFZGK1IwVEdyQituSWhma1duSWFw?=
 =?utf-8?B?QnE3VkFkWUVRbHdoTzlSUVFwaDU1T1BXRU5yVlpsQy9uZ3lybFlrSDNpSWdT?=
 =?utf-8?B?dWkyMHdHNnFEY2RvQ0kyWVQ2U3N6c010a09relAwRnp6dmZ1Q0hzdWJmZUM3?=
 =?utf-8?B?TWNzTm1USWwyVU4ySWNOWXN2YmJoMUZVVHhDbDA5RXlYM0c2aUxZU0hZakVI?=
 =?utf-8?B?TXJZUHJmNkNVamtMTnYxUkNPbngzem5XellZblBWK3RINVRNandXSDFYTEQv?=
 =?utf-8?B?S0hDNGw5dWp1UUw1aS9PdHlXdEYwSXdWUCs0dmx2MHRmaU1PdTVmMEYyMVQ3?=
 =?utf-8?Q?Lh2Pe95uio8VlG0iCgvsl6u5F?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bad68f-c2bc-4651-5e47-08db3ba4a032
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 22:24:05.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvRYXUcfLv9BTWtmtXR0vc//fm7I2McigArGVnLSbGyvkSFplS29D772uhPMUhzjF6ARUFSvKycYK0d+Uinynw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6766
X-Proofpoint-GUID: HkIAh_08iApyIVwZ6CtVdLI_Y7EnVPys
X-Proofpoint-ORIG-GUID: HkIAh_08iApyIVwZ6CtVdLI_Y7EnVPys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_12,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=959 mlxscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304120190
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 00:44, Krzysztof Kozlowski wrote:
> On 10/04/2023 23:11, Brenda Streiff wrote:
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clock-frequency: true
> 
> I missed it last time - why do you need this property? You do not have
> any clock input, so which clock's frequency is it?
> 

This is the clock frequency of the UART; on our x86-based platforms this
comes from the LPC clock, on Zynq-7000 it's derived from a clock in the
FPGA. This is used to set struct uart_port::uartclk in the serial core,
as it is for other UARTs.

This clock frequency can vary based on board design (especially on the
x86 side, due to different LPC clocks) but for a given design is fixed-
frequency.

Would you prefer this be documented further? I was following 8250.yaml's
lead here with the simple `true`.
