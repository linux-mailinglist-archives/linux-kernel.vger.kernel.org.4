Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA672F2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbjFNDAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNC77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:59:59 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6652CE;
        Tue, 13 Jun 2023 19:59:58 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E2kEQ7030644;
        Wed, 14 Jun 2023 02:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=Zo+i6hHFRtmeiTuShCSXBvanGTeBagJWtN08D+ugjz0=;
 b=b6W49B5waiAXb8ptjvrzzLdO4Sy/2rc9ehqY6rOY8mhJcjj9bR08UPdGd66KRDykzNJL
 qyNcA/8kbocNnBEt87Opo07nOLJzi6laxk7dm3Zoy9LXm4xF6v22YSjmfAboxff6zR53
 XGNJewb4hPEtSHTyq70pAelI69uBtzTn+S1weNmk4SX1mgxa0e2tLkvv/GvKR0Fir+ll
 sU9Q/asqIBVF45OfA2lCmqRay5IFfcMHhKNbq6WgKDHfgx3RsaGu2bUtbJ2lCOXf73c0
 eywukN9gJR5EiovMJWFo6Qt37kndHqbeXIi835KTr70Cf/s6mPUl5iu167fDbggo6zUX uw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4ed03dcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 02:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWg9NwsHb7B0K8fvnHHJB+dydrS5AyXSutzBJQo5LO19ZddGudMtOGSkjSyPkB3jAHgpaBsKGttLCrv1psdaU1BEDBX9IFngYHiuaQOSA/WhnMzWkF7+o25NYlgQHKSwV7xpXqqNiYLz5qnS+JEfF6PDl5ZQ7R9K8S8a9MouOqGP+XAfW8ExjzMDu8Rp4UKZBOFx7609cTZehlV+OSKnunnvRH4Kn/cTVeCFYVWAREV9C1IpLAEMC3wL0rBFl0JRjC6keAM+Eq526rLuQxgUFHnnHkNiG5FFb9FLL1SUMp4n3lpOMsYI/o7DcOTImyKBP3g8a68rqBlEfq1iioRLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo+i6hHFRtmeiTuShCSXBvanGTeBagJWtN08D+ugjz0=;
 b=K5+7zV/dFqkp6SzXMPHxvml6e6iHihXi02F+9vhYeZnVRYLvZouksfPKPxqC+WES/CnCyP6RK7iq76s9ZAuw9FkXwazW5UtXGGPPgRaCm7nUna/WE8ums8tABWG+1vDJsGxmRJ0jYDG8uGYGroMCrKNRa+px9WO3PhKWZMtUizWnXFzz9nwjjUnd9CGcz1NtWAjvFjkGAgL2L6TFCuh5MR1iPppYxnitqwTdoHuN0Y+honZm2mYKNzrVeszcAA6HakaOPYTvXmwvokDoStVpBXLQkNEMWI/3c71eTmmBYXgvqj2MYpmA9uJv0VGNqg6zXJ9iEZ7wG4UIqcXv0W9s+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 02:59:44 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242%4]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:59:44 +0000
Subject: Re: [v4][PATCH] pinctrl: freescale: Fix a memory out of bounds when
 num_configs is 1
To:     Peng Fan <peng.fan@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504233736.3766296-1-xiaolei.wang@windriver.com>
 <DU0PR04MB94177E959F6A18D4FABE8D8B88729@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <980ecce9-b880-574d-12f9-9fe2167665f5@windriver.com>
Date:   Wed, 14 Jun 2023 10:59:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DU0PR04MB94177E959F6A18D4FABE8D8B88729@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa9b01d-5bf0-41d3-7f29-08db6c8367cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btKS4DzVdjVNJPd63knyg36mNOxbd200Pm6GO+4VsK5jnHcoVbEBIXfxfNljY1/P1vqRfm2Kq2Pyxrtw5QEzfSzQC9md7EJPm+WjGi6ldXN+U01+npC6752C4dujp1f5mq2u4aD64kRVZWU96RsoN0ZmVowzJhZzNK8Th96h/JKPuw0E/RseK9WsO7QFzyHizLsCC0Qi3QHOwSC0uycsUiGI2JSkcgE2BExyUjOIiHQCXMOGcLK3BD0N9P1c1QL670iErGYB7Iim+4zjlRl1NOgMDwa56l39dZe/szNnbJVxatrf8c3gdlsJJiv9k6pYnUFCStlVRfluH/UIm6AwYKfj9tXvtSKI9rtivsDuJ4LmFZeQyXeEzqeF0wWWDcq633GNwFgj+fhTPsiy2G0KPgkT+Q7cQkgFoBV4m5wzr6r0H+MO7XZ6Bc9hMO4XsUPDK3R/woy+bL6E0R1u3IYUp0F5r/UNQoRzej+oyEOkYoO2zb8EmXu2Haea/8b3JzEneH+dC+1bVDdGO0pfqEmLBUBpbLVZG0pPQvAbykI4wIh54sxZ40W1DUjHIZoFGHDSOsLHwb3R1N8dAFEoX+S0XeWhT/a5BMTk5GS+8w2MD2eiy9K61GPPxrdul0khnUkDSIOaUbIoGW5JxwBcI2lpsLGEMsP/it47UGHFb3qYGtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(451199021)(66476007)(110136005)(6506007)(66556008)(38100700002)(66946007)(4326008)(83380400001)(478600001)(6486002)(2616005)(6666004)(53546011)(4744005)(2906002)(316002)(6512007)(26005)(186003)(41300700001)(36756003)(54906003)(7416002)(31696002)(8936002)(8676002)(86362001)(31686004)(5660300002)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJnc1NyNGRGVlJNeEdWZXRBU0FnSFQwVFR0ZlNqeHltaEcvUzRKN3ZIK1VD?=
 =?utf-8?B?Qzl2ekNRaW5jNnkzRXEveEJKNk92alhaanAwQkY2K2E5Vmg3aUVyU0hkc3Zz?=
 =?utf-8?B?Tmt1Q1dLVG9qVW5YbHhCejFmV21qWEp2UWljSnNka2crbmc3S3huY3V4MzJW?=
 =?utf-8?B?ZXIzVktVdWFkRlp2L25VT2t6aUFaayt0eFhPZ0FVV2w5NTBNK1BBYXN1bGZR?=
 =?utf-8?B?WGpucGNGazFlZzlFU3NUMVhnZ0ZSanVRTDFadVFueUV2NVorYVBRMHdVaVVx?=
 =?utf-8?B?eThON3lnRmxKdVIxcDIxdnprZGZVby9uTVNwTXRmUXZlTHpzdmxSV09qd3dX?=
 =?utf-8?B?UnZ0ZHdqTmhqblQ3c0RYK3NiWEJDRUMxUnBNWWltR2tMWmZFKzFyQk83VTF2?=
 =?utf-8?B?RWdMQ0d1akNQakRlb1ZoT0lhRlBxZ0pvbkxjeFEyT1J6ckZwUW91WFdhRFFs?=
 =?utf-8?B?eWVNUkxwYkpuQ2hMa0wwc2JhSVNmQjgxYzM0eHhJam4zak9zd1NFR3BqMXND?=
 =?utf-8?B?ejQ2YzMza3Z4c29hMk8rc3owV2c1NlZZV0szNnhER0dzVTRuRVVJREQ4VDhZ?=
 =?utf-8?B?c3lQRGE0Tm9QdDB1MmZSV3k4WVd1UXNsUmF5bmdHMjRPSkJJcDhjN0Y5bi9L?=
 =?utf-8?B?cGJFNGJXaml3VjVlTTRjLzYva1VMc1pUN1JvU0kxeHBJdjA3UXBWTzcvMVVm?=
 =?utf-8?B?UC8vR0lqM3gwd3hPd0wxcHBOZEpQL3R5bkUzdUtPaVNQZ1l6NE9yc01kS0lX?=
 =?utf-8?B?cjNiZEpPUTF3d3I1V1ZnMzFKcmN6V0l3UTRGNTVWazNseS9JL0R1Y1FINm1Y?=
 =?utf-8?B?N1duV2Yzb1kxMU0xdHdNVVZ6MzdzS1VsNHFpTTJJN1hTOEpTbGlyc05BZDN3?=
 =?utf-8?B?RUg1bjlyR2doSEp5bEtoMmsyUEc3eTBJMktQV21IUXZJelVHREdZZnYxYU5N?=
 =?utf-8?B?cUF5bk10dG1rZnM0UmFodkp2OTVsakxaUUpkUXdObVlRQlBvcWpIeTh5VXA0?=
 =?utf-8?B?V1g0SVg5bUxvUGRCL0tyeUJ0SFpxcXZxUjhZSUdialBnN3ZBbHRnc1VBdUwy?=
 =?utf-8?B?NjAvdmxaUEl6dWJYYjlZS3F6ck5qYWptNjgyVlgrK1lDVkJHeXRTbnRHUmVh?=
 =?utf-8?B?SjQwZWtLUDBzMzh2M3VwL0g0Z21uaTNzSXhsMGV4TGdYSUNBRzFZSlYyeE5M?=
 =?utf-8?B?RG9MazBDM1lsZWZQd3J5RVVrMmpwZVRhOWg0N2hBTTVxdHVCeE9ISnoyUmY3?=
 =?utf-8?B?ZlI0cWtMaEhmNzhNdVZMU3NTU3d6R2JsUE1WeHFFR3A2ZWVYSXFzYVU4Uklt?=
 =?utf-8?B?emdLNFFFdlRKZG5iNHRiMnBvc2pDbzlqU1dTVUpsck9ZZVovcUxHSVJSLzNC?=
 =?utf-8?B?NTV2MWxUWUZlRktsRlVzZTZ4TnB3c3E5K1JMWlpLMnhXbXVBODNYblpNOUFr?=
 =?utf-8?B?L2puOFZzNGIzNzZZd0l4bjI5WUdEUjVYUzVYZjRqeVdGR3FvTDVQclZOdTZU?=
 =?utf-8?B?UUJQRndpYk9TSGNIRmtXcWtxRFVFT2dHTkFIcDVrdzhBOEprNlovNkVlZFdP?=
 =?utf-8?B?b0Yyb3hldzdpdkxacXNETGNMSXZDaXYwTm52ZXpjdGM1aXFmdjZ5aURkUGR3?=
 =?utf-8?B?Q29XeldWNzU3VHdjUWt4VDB3c2Y2ZmRIMWVPRHV0K2hHODNiamJ1ejF2Z1dG?=
 =?utf-8?B?ZFhOalNlWE5UWjVzUWxFRWV6Y2RnVkNtYVliMHJka2t0dmMxT2taRTRWaGI5?=
 =?utf-8?B?d0prSURyMC84MG9DZS92SjdGM3cyaDU5MkNYcEZ6eFI3ck1OTFJSTVMvVWxY?=
 =?utf-8?B?UW16cWptdGtBQzVBbEU2UFVhb0ZLeXJsRDFXU1dabXpIWnZDcTFFQ2pBYXIw?=
 =?utf-8?B?NThvQnRqNXZqZXhpanFGM3U3VVVzeHZIbk1jMlpTaEdSM1ByL2hiS1A3Nnll?=
 =?utf-8?B?WGNuZGU3Z2hUU0dmanZETEFtbmFyaXNNUjRIUklIVmd3Nm5oOUhLNzMxVG5B?=
 =?utf-8?B?R1Z0blhoc3Z4WFNWclRDSEpsVmVyUTA2QkRSM25nZkZiMWdWUEJrK3N0QTBq?=
 =?utf-8?B?RDVGWkFHR1V0ckJ4eUdaREc1aUljMEx3U092RkpJa2dXWW9lQnU1ZkR2bFhG?=
 =?utf-8?B?dHAvYjVBS1RTcHdDRjg3Z1FVSVgxM2hPMlpxOE1EYlpFUDFGcUt6R1k0bkNr?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa9b01d-5bf0-41d3-7f29-08db6c8367cd
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:59:44.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OS0VA7xEWrKGpReqh8kve3ByenITYOkrTW/fqrHcEvx2CSHHlUA2WeT1YdG1IHpk/eBiUPwjmgElZ533ZDkAtv2lMx8OkpWcKBDa1yGzZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-Proofpoint-GUID: we3qUguQvgqapbF72vXV2lqMgDNeZcnu
X-Proofpoint-ORIG-GUID: we3qUguQvgqapbF72vXV2lqMgDNeZcnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_24,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=922
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140022
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/23 8:53 AM, Peng Fan wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>> Subject: [v4][PATCH] pinctrl: freescale: Fix a memory out of bounds when
>> num_configs is 1
>>
>> The config passed in by pad wakeup is 1, when num_configs is 1,
>> Configuration [1] should not be fetched, which will be detected by KASAN as
>> a memory out of bounds condition. Modify to get configs[1] when
>> num_configs is 2.
>>
>> Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Can someone help merge this patch?

thanks

xiaolei

