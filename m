Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BC658DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiL2Ntd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiL2Ntb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:49:31 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5091EA;
        Thu, 29 Dec 2022 05:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNWufXSklnW8eXXnYTFu+tEZVNEkYxpncNMi4DQ2zkAcmvqdY+mT48rt9ppwDyYFjtHn6qsKw3mO7muNZdxmY9CACadm/O7cUW+N0hQyRPPctFPDaadqRweZSWDaVKPwE86VyOxGYJMN7G4qOOIRXgHlc7X7WE6bXPjnwcDb/QbUj4uaE902NFF0pqNFwuXmaxYHwtWSl2g/oUHMEid5PrbBkHu0O0DOXvG6doTi2t6SVdKB9OHetC2CrwrLEyXQeByJS7NbJVAmsA5tcd9zN6EdiIyWujdj+5AlJQRnR38pXJZH91x2mDUYbjTosO3PHo4RAKG3qiVV8PAt1vlTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOGAfx/guPmUARXxFkmG6O4/lEBz4kLkW3y8nSEDQps=;
 b=RptzvDFmo81OCIg+hYIaCsd/7BcmdGABX86RFWInPlCo0UOAzt3j+f3amKkqWEm+PCAYMsG99DVXADAnqmuZVTCvTtEOeccURc1/f0rhANLlCoBxWcBmDhpJLw1peQ9qXarLF/weRo6d3ElnpJtQsALFALwhf/QoF+RZLNKr0C4vpAan9jb0qdRBTxjeY+dBD8njUTGQEL4vOpeOsGgyp4pxTW7HmLk2AA2dVlmYOdg5Gdv4+OBTu5a41dhvTyZ73Ja//Jj6AamNbdmfcGpBXW3uoJDkE2WHwiBv43V/H62odv3DhjFo3oqXi6GIvQD1aZ2kjleI0bdyhiTUr37tPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOGAfx/guPmUARXxFkmG6O4/lEBz4kLkW3y8nSEDQps=;
 b=Nrem9Pt4JNVHsfP25qDFwa150WxW14hb3gAaAjiS7LhgaY70opxjKF7nwGBkhn/C5bPRuR4zYQJbj3anZNba/SQZB4zAMMaeGpPro14ovyjPib59vMPT7iFrXSPkm+9+IfKqJDvW7LSVcQt7ucWa8UONWNbWPVxcZKMeH/te49krZYUEOAImWJ7jKov79jpyXAk7+b9nrc4HLkITkOAhuMEAsRattOBjcG3EOgmSPOGKQn4hHvMNEYKcMJqoIIY8HH8v0ZTXRNZtv0KqzvRRM1+7UiM3vHw3uB/aAE31R0SkZHLTwnlascUh+srwF1bVau9Uunq2A8gHWYtnJB9sHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DB8PR04MB6955.eurprd04.prod.outlook.com (2603:10a6:10:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 13:49:25 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::8d51:14ac:adfd:2d9b%5]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 13:49:25 +0000
Message-ID: <80f92635-6d14-8ff3-17ac-de2e5b977947@suse.com>
Date:   Thu, 29 Dec 2022 14:49:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 04/14] sound: usb: card: Introduce USB SND vendor op
 callbacks
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-5-quic_wcheng@quicinc.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20221223233200.26089-5-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DB8PR04MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: c24555f4-b798-4ee3-f984-08dae9a37eac
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25UvJLzIJNi+EsjKt5Vge8hETjTsp7in8TKuQaiMqtRQkmEUjO9pltptqYEmjXpQoJGe1HGCv3DcKrqmmAdJNX8vaFxB1/0Pq6y9G8I9ysBlt01Kn3KlfdjkXr1AgMnLyOWk5lvoPjFUkoqVhnlc87mtaamarmBbaoD4WBduoJECMy2a9hDqyxclvOBB4UC2HmFHyksc7lLY1ShKI1PCAqk2wb4GP63265E9kC/8omypjhkE7qj8Xsmtg1d55P9ALVqKXv0ZKbHE2NqLUa+yd/h6gNg+eUskZSLPMdbeLJjToY/B3ahkTx72LTVL5QQPyoKq4x/9erVZlVCJS62DLLeIo0Lc2sHpOqqMCF8GvVyR+pm4LCNrDd7IYGlRN/WNiWEFgfOfIq9dKDhjr6rIX+w5uwh0NPVFDC+nfIa+2qzOkMERL8nsdiYwQdibaGL9vcraqOEEZQg0YyUOtQ6gfUDcQdDAFE560YqflBaaaA/fB5dTn0LbjYon/WbPzJ5MVMHXh2zEro5U8OqPjShj4JmHbdqsin44zB/YGFgCFL40Vtd+fiW6JziQxZGQZbjuRjFml6+ycNrmLs6XM2IfsWiPaAmFME/gT67E2qixNRWZjAAQvOvKutAfOLPfGqfuT1HUDLVqw+/aehMQi5S3SdC+gmQQUsCHnywT2r2An8zpLCnyxNAbYr685iqfn4fegqrDaY/6xAQb297CemdLI2a0z64XjfqhNVqeOTzLh8Min/EtNkrR4iRAihrFNWC3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(6512007)(31686004)(5660300002)(4744005)(7416002)(8676002)(41300700001)(8936002)(66946007)(66476007)(4326008)(66556008)(186003)(2616005)(36756003)(921005)(2906002)(478600001)(6486002)(316002)(86362001)(6666004)(53546011)(31696002)(6506007)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVRZHcwMjg0dUt0NWZ5OFo1dXRvVGFtR0Q3RnRDQWJQV3FEUjA5QTJQdGVy?=
 =?utf-8?B?NGVnVEUvMG5yai9rWmcvL0dPS3Q2Q0NGZFhPZVZCK1ZlVUcwOTRCNUI5dDZw?=
 =?utf-8?B?K3Jya2tIOHJZYmlmdkJrNFZRZ0xuODRIWTNoSkRQak5xMEFtK0x1WmJRZTMy?=
 =?utf-8?B?MkE4clZyL3UrWnVKbFh6aTBZYTYwcUJha2J6bDFScGt4bWRvYkg4dURNSThr?=
 =?utf-8?B?RHF6eE13cmlET2wxMUhLZERXemc4VGgxLzdxV2pYS3Q5L2tvVjhWbWVhS1hX?=
 =?utf-8?B?SlNaWUdqUkJ4Q08rVmt4d3BRbnFOcDdqVHdNRmdYOVh3K1lNQ3JjaTNTYTVu?=
 =?utf-8?B?V0FQM1lSbnlyUHRjaTlpVE9FVExCbkVEcjJENk5odlk1bmdJbGtXaXlwMUpN?=
 =?utf-8?B?YlZpbGNxdFcrb21jRTRFYzY3dFZjM3lrWUxhaERuM0lGQnE3d05rMHUzQWdU?=
 =?utf-8?B?b0plRVNVNzY5LzdWdUlSMUJvMzNMclZNVElud0hMN0tKVzlRSHB4Mm9rcXl2?=
 =?utf-8?B?NFRvUzI2VktyYnhCc2l4em4yM3VoYlZ1T2JjQ0s3V1JYOUhIenF4dEFTM3lx?=
 =?utf-8?B?c01Sb3lOOXlucndTUVF1M29GRHA1WWxMd09qd2paMXQwd3pPVndlRzB5UzBG?=
 =?utf-8?B?R3hVUVJkMklJWmRmVCt1aGRWMEdUWTBsd0Z5ZDBNQks1Y0M4Ui9oQVlQcmVP?=
 =?utf-8?B?N3pOMEF1RnVLL0ZldExvZ3pUOWtYRzVYSE85N05jbGh0L3FQOGcxVnIvbGVU?=
 =?utf-8?B?THRjWVVaRjM5Z3BuYjh6YTkyMVZxS3doTSt6SWt1ckVpSjJ1YjcrYmU2M2hP?=
 =?utf-8?B?VDlNOURzSmxjU0hBVitZT01LR3I5R01KcmRNWGhhaG1QZFg0blJFSHVBaGJU?=
 =?utf-8?B?T0JGVHFEL05NbGx6SHFES3JHZGRzcURhd3l5c3hBdHBKSmtnQjIyUlI4RlFQ?=
 =?utf-8?B?UXBPdnNDSFN4Nk00ZHhzZGFmaGNucUgza3RBdGd0RWlSaGlIM0pReXQ2QnR6?=
 =?utf-8?B?d2N3VGJkenUrTlhXaWRHTU8rM2NkclpXbjVaekQ5WE1XVUJXQlUvTXcyZ1Ev?=
 =?utf-8?B?V29PeldjUCtxNi9qa3FHN1pubXFKMUNlZDRUNzl5b2lseG00MnhrSVdNalpR?=
 =?utf-8?B?M0gzZVpsdm1hV25JYWcyUmhtbnFSZndRSkxESW1GY3NUU1pLRnJOaVIySUIw?=
 =?utf-8?B?YzRqUlZjalpuNXRoTTdpeTZsRFNIbjRmck92Y1hmbFh1UDdXWUJSTUYrc3Fq?=
 =?utf-8?B?NE1GaFFTeUtjTC96ZituOWw2dGtxMDhCRGVKcGZadHRRYTAzbUQ2dTY5OTJw?=
 =?utf-8?B?QmN4MmhJcFNob3JMZ2t1TkppcnFOcVUwRHZrbHJhK3RnU0Mxald0TXYzQVpr?=
 =?utf-8?B?RndMc3c3U0RKM24xWlIzUzNxRytod0pWSzhRYVBrY2l3UkdCYWZxRVFlTE1i?=
 =?utf-8?B?SjVVRzF3KzFlUWJsS3B0Nmw2VmtWSWZiYjhxcmwwUll3bkVuNDU0R0lFSG9j?=
 =?utf-8?B?SGhDZjJwcHEzamNnMDBnUFdYRjQ5bUJhNUpOaTE1SjJNcmowVGE4bklrMURy?=
 =?utf-8?B?dVdlMkZxT09qakZMeFFaOFZYMEdXVTF0b0RpYXNlWFpXend4M1FRRjdXK20r?=
 =?utf-8?B?TXdJZ1AwMHY1MjFpR2txZEY5RFVWM1BDV3V6TU9kNWtsdHdIOXo4eVdwdXlu?=
 =?utf-8?B?VEM4K1VZWDlnN1Zxemh4aEtkWmhIb3JPSjk0dkdCSlF5dTVXR216UlR5MnRn?=
 =?utf-8?B?OWVqbThNdW5PdTRSNGlWanFUbFNBRU5QR1VtZEZsb0YzU21SMmlDNUhST05p?=
 =?utf-8?B?SUZWWFB2bWJoTE9jZWczZkNwSENHMU9TaFdrOHlraU5HK3pSd2QxbVg4MXNr?=
 =?utf-8?B?U3dzSmZ0TDdxTEdodHVoekRoMVZnRVFUOWZyeENpenJnNC9CRHVZbUVtVWp5?=
 =?utf-8?B?K2oxcHpsT2FrUTZsTmJ1aWM3Vld6UWZrMkpEZDNQQ01HSlVWQ29DeW1ZZ2RI?=
 =?utf-8?B?REU1eDFrbzE2eTgvZDdQM09yY2RHSkpNdEZOUFE1aklIR3gwbDh0RTF4WFZi?=
 =?utf-8?B?bmFPWDU2V0pBdUwxampqc1JjMG1UUm5janozcC9qeGJWd25ycTZpcks1dkM2?=
 =?utf-8?B?d3lFTHhpcEpYdTBuMU81dm5yd1BWY2xyRVh4K0RDUzJhSWdUTGMvamhiQ1Ix?=
 =?utf-8?Q?ApZTjEnZBoTOB9myhv3h6EwJEdBJ4B9dsPL591YtbCEl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24555f4-b798-4ee3-f984-08dae9a37eac
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 13:49:24.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evRh6gyk/8CzmlodGygCF/60r6j4+/2zFdKLVNUM2SqGpN6thOhdbiYWQ4O8XDj+5OCWPqjZ0vt2CTFtPdR0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6955
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.12.22 00:31, Wesley Cheng wrote:
> Allow for different vendors to be notified on USB SND connect/disconnect
> seqeunces.  This allows for vendor USB SND modules to properly initialize
> and populate internal structures with references to the USB SND chip
> device.

Hi,

this raises a design question. If the system is suspending or, worse,
hibernating, how do you make sure the offloader and the device are
suspended in the correct order?
And what happens if you need to go into reset_resume() when resuming?

	Regards
		Oliver
