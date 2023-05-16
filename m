Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207BA704B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjEPK4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjEPK4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:56:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DCAB9;
        Tue, 16 May 2023 03:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZLb+DdHQZFYeJDYseHsXVDLdUDvF5L/KJLAawnyH37jAxC3H+rGj03QlaGn4ed3qAgNwFbVlO6Xg96RdJXg+DvWC1DVK3jOb1nEQ3p5ItSJH8oJS6x8bZmi4169lpie5/9OVyAvC6zIubAen84o9KpAr0Cd4b7sGseOSl3F9ydbY/eWX6VkrZ7i/tl1KLLd5PrFhtZiyrBoL/7xaEqKEDSfg+j3u+DZAznK+/oLGSEXwTNDhWD5vaMQE2c69kyUyEHxq9e0asshXl0c1zDsXkAYvmwWjKVa8TlXjdqGh48ZoYFMaHT0BE1RXbLFizwiRzGva/L0PagDOz06p51MZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZhHARucR3Ia4aMPbqEHex8sS4jSTeHTG9y9BbYi/Gg=;
 b=TKo6rR8uBDTA+ybA/4wa+T19f78tC/pNl1zRWvy+t6z76TNxA4OF0px9LkqPK6C6utdHa/pqblWM7F9n5NcvNBY9Zyrnay32i92R7MFn9wBTlM2BZFCd+ckZ1bg+U5OXUNEiwdXw9v7vI9miMeGu9RDt5x8DZwIne/oSISO1SwBd4ETvUN4zjj4x4q/qOPJF85Zk8FlJ2LmU8CQ1iQD13mY5aWeg9Cpq09si6rSAiivnkJmdSipif+uLfjElLVSAyL1ason4+dxSWV1P6po4kWsp4N17nbBKc51VMvV6G/2s3NZRQx9LpTCf6CegJUFQkYIweuIyFwpRSKIUTaxDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZhHARucR3Ia4aMPbqEHex8sS4jSTeHTG9y9BbYi/Gg=;
 b=TvmvlpKwwiyikv8J2rq7ckD1TXPXOoQFr5f2jrNR9ThteUqeodCPDRmQjjWDYpAQANxxKEPo2KUyCAAlNOS0TorYSj2AC5POTZ1T4M5PLf+dpFjPQ0AVjHNzH18BvSoJ8bVFC9bk/BwSagRJUhN0j2TyoUZ5I1+QHAxS6JXpz/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:56:43 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 10:56:43 +0000
Message-ID: <78cf0ccc-e98a-f5cf-a545-af8fe3161778@amd.com>
Date:   Tue, 16 May 2023 12:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 20/23] arm64: zynqmp: Rename ams_ps/pl node names
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <373136eccf8d22cdfb499adbc8d5f5510d6c1035.1683034376.git.michal.simek@amd.com>
 <20230510083233.GH11711@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230510083233.GH11711@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0203.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::33) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: bc731686-328a-414a-d6a2-08db55fc3bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUCiio7DXDPJS6wabp8kwGqI6e5xSPr679iexbNS95a/LqoeU+cXNZDl/28LGDf6u4LfZ6BWpFir1BW/RpydwHr43VXXO1a/cfvb+vMZo8YuYJbI63a2E4yha6NheDsu8aviWS4Doo5oTiQBkLFaIocfjtFhaxKS4u9nurCYo1Wph0tdCIKwf1xc7kCGFNiPZlt15Lolsb0iD50Fgjxr6gpsj1TJ3Rq6L9rXtqIx58rgV+k+zp9bFZBdmruoUWDiORq2qS1/0IObUnoje7kkx4pa65eGr9OTmbv9hRyKMPdIFfcXkDMGq9lZNLzVeKu0g1xRvLWkWNe38z1+5vdzhj3X+5Tg9DLGTDtXQi9DD6sGjQ0BPH4qNVRC9WQxgsxyRNAza8FEaYMHMIL9t9hwgAEXKPSwABgIp1yR/Xz+NVEKb1KqXbtp2rpFfgvSrL8GsI7ZMq8iyC+yPUV0MS/PH987pPVtV+iyBCZVZoSUCpf/dwmdNug0ttoXFGk3z5LB4c5xOthIwPvT0EuZh+YAcaFvHgZIzqAnKPy+IDsz4HLZrbtuOPkplDDcRo48J+H3NXYUyLeHxlccKHTH9eORHyEFIDev6Bn5FsVERld2x9SOSh4XRDNC4PVm7X4OaO+8Uozn2k032UvVfsMKCDwF7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(5660300002)(8676002)(8936002)(7416002)(44832011)(2616005)(186003)(26005)(53546011)(6506007)(6512007)(38100700002)(54906003)(478600001)(6666004)(6486002)(31696002)(41300700001)(316002)(66556008)(66946007)(86362001)(66476007)(6916009)(4326008)(36756003)(4744005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXFVZVJDcUR2clN4aDhOY3VYRGJZYVV5RnFEQ0k4blRlNEtyeE5aTXFHQk44?=
 =?utf-8?B?M2ZtRTc1QWwrOWdWeFFTU2dzUU9oYmMvd29QWGtzNVc3aVdwUXMwenI0b2Y3?=
 =?utf-8?B?ZEltNnpRZUp2aWdDVStuM0pWMEd3cjJ3MTBoZXhtQUQrNlJNbW43Q1Y0b1ZZ?=
 =?utf-8?B?eXhJWlRvMkdSVUhaanJvRXRzSXZHR3RWY1pDZkNZV21wUzVOOXVzeXFWcWdS?=
 =?utf-8?B?eEJyRTRmcUFxSnVySlZBWVdmdHgxT2VHOElTZnN1cW9XRUViTkw1NU5RZ0pB?=
 =?utf-8?B?L3FlSmlQTnNBakNUeFU1cXZPUFdwYXpoUWZuZ1plR3RmanNXZ0s4TFJucVpI?=
 =?utf-8?B?OC9FdW91V3pXbGh2Q1FnOXp0N29GaHYwcS9iUzJZak9IaUhWaG9rNGJGVHZY?=
 =?utf-8?B?Z1RhSFM1Nmp0ejBkeHFVcVZ3L2s5ZDU1U1NpcUd0NDBmTUQyT3ZZYUF6TmxE?=
 =?utf-8?B?SkVYcGdSMTlrNmdmZkt1R2o3RU9CbXhvbTl0RmJZamdvbEdsSzBXUnlkTDFL?=
 =?utf-8?B?WkxmamE5YjlZZkZjalBzWXlRN0o1VUc2MGt1TzNxMm44TEdodm1mTlFNbFE3?=
 =?utf-8?B?UERPWFl5LzY3TnFJK0t1WEVzZ2Fpb2s5T0dMM3FIelIxVHRJek5BY0dJWTN3?=
 =?utf-8?B?bVY2dE1jWDZuQ0ozQ1BqTVF6QUd0NDUyb1BWN0F1TUZlUUpHQS9ldzEzcGdz?=
 =?utf-8?B?Y1FTbGFhSzJnOEluOUppUmZWRVdGcUZjNlBBRVlHZFcrNjBHOTFYeVBRdTJP?=
 =?utf-8?B?K0cxUExPbHdCTEJhdko5ckNqR2IxdUNrZXhIMUx5TnAzZ29ISjU4Vkw2TG4z?=
 =?utf-8?B?cWMzdUZmM3FBL0hGd280TlJaMThVVjM0OHJ6QkZGV2liT3B5aU5iUk9WM3V3?=
 =?utf-8?B?Y2hDckZwQ0tmT1AreWc5MEdZWHlLaGlGckhySjRnUWRwZmROV1NoRzd1d3py?=
 =?utf-8?B?dWxVeitGTnErbVBkRHlsWmk0RUU2NTFnRkpZUjR3Y3hNNzNsZVRZdzVMZlFx?=
 =?utf-8?B?VUZuNEd0L2xVKzI0YlZHQy8wQmdVdHcvK01FdmRycEVmQTM2cXlsSzJoYk5C?=
 =?utf-8?B?TzBsTHFtVWpPaUxaakdYNjVadlNtcjZEN0JRbk1iUy9ha0dHOHdvQlNaQ0Vn?=
 =?utf-8?B?Zm9OK2JUT3AzMFNOODgvUVBTOHRDazd3VjhGTld0M2l4SHlrMDJKem82TnNs?=
 =?utf-8?B?K3JZV3Urd2d4Y1IrRXJJSDZONmtkckNVcEVpcHdhd25OMEFmYWk2ajczZUl1?=
 =?utf-8?B?SXN3NHZpbXdiN3JjbmcrTmVHZFJkMlBEWlJHTXhENXgxaFhMRWtXRXJhR3VK?=
 =?utf-8?B?MFJBblZCUVNXdUJWNEIzNFFGdnlvWkhEWTkycjVTd2dBSEMxUVFieEhXbFNt?=
 =?utf-8?B?cUJrajNlVWNmaU1zaVNCK0lsOTc1SUxMWkt0YkE2YStFTU1leDFYZGZ5UGgr?=
 =?utf-8?B?Mnp1TnYyUCt0OTFVdmZialdjMUFzZkg0STBhcllkZkwrU052YnpIcFdGbjFO?=
 =?utf-8?B?cm9xWVlHc20yYmJ0V25ZUnF1L1AzUVNZMGlvNXpoajc0QkhsUmMyN0hxb3h1?=
 =?utf-8?B?ZGNmSjdXRmZYc2NwajBUSTJUR0p2djI1VEdnWkRmWlJiSUlYTHptNWVrbnlz?=
 =?utf-8?B?dzl2bkJnelhtY0s4bGVOcEZpVXVZTFJTeVNkcUlsSEhGQnplSUVwcTFGYW9p?=
 =?utf-8?B?b3pOczJwNkhVd3ZDaHBUdTFnTURZQmtRWFRwWmZ6cmFYSngzLzdwdjhvY25H?=
 =?utf-8?B?WXJhbmRrSUdmb2w2WjBScGI0VW9RVkFRM1pFQ3FDdzRPZTQrbmNYUTlNSE1L?=
 =?utf-8?B?dHFhTWpabUZGc0UxKzFuL0c4ZTR4cmR2bnJxQlVmM1VZTUNxYVhlOFdidndl?=
 =?utf-8?B?MHpNUGUwOUpJTnhINkZyNE1nWHNXaUtBd3ZCbFNTUUdIaVpBdVJ3aVplZHV4?=
 =?utf-8?B?WEV0b3lFdzA1NndPNzJSSkFYUFZEejJxdGFsL3hQcmJPckFDV2hQV0JXNDZ1?=
 =?utf-8?B?MU9DY29QMi9rZCs5SHNiL3pEdDZmTFJUeTkrMm41Yjl3OGZzb29nYm8wZTl5?=
 =?utf-8?B?Wmg1eS9uQk1mL1FCaVVyd2IwZUMyY3JmSVhNUVVRaXZUcGVhRjNRTTMvMlJw?=
 =?utf-8?Q?blBknSV1exY/pEvb92QbV/Tc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc731686-328a-414a-d6a2-08db55fc3bbe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:56:42.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWKoyj//TpxLIgvMFOCJiq7Xm/a5IUhTASeVwADYiCnkZTugoRv+pUQtbJ43g2lM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/23 10:32, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 02, 2023 at 03:35:48PM +0200, Michal Simek wrote:
>> Fix child node names to be aligned with commit 39dd2d1e251d ("dt-bindings:
>> iio: adc: Add Xilinx AMS binding documentation") which requires names as
>> ams-ps@ and ams-pl@.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied.
M
