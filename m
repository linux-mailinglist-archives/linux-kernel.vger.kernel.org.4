Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267DD6D276A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjCaSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjCaR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:59:59 -0400
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C123687;
        Fri, 31 Mar 2023 10:59:42 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VGZ5j6019655;
        Fri, 31 Mar 2023 12:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=TAM7zX9yrdmPFpitGm4QezDue1QSmk/8eMLnbA/79IA=;
 b=JRD5VweYZd83sH0CmwanVm+LCqwjxIU76ky+yBwg+NDYkqTw9l9v5cWcFZJQ0O45C1Lx
 ghmABjSyCGCeWZDMfhX2+pE2Vi9l++udDK7G7AAVLCAPhpgC4Oe1m6Vw5pgJl8FSi+fL
 P5dp4IpDQBmTxl2LmCLgqs0f5MpoKsWRMKPxNWcsAnNs+RIN3T8JRWREBtJMI1/laWqi
 1lfXeU/XWJYmwT5P+dJ50eCrFI3PXL5mZ8DYqW0nD5LgIWV+bq/+xKM44kbbPxl+mSMe
 fEv+IK4sS04VHsqLwtVOhgXz5bfGlfh0M33GYd3iGs6ST8L4jBCB0MKXLTaCVxXbfZed Yg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3phw1fdeam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 12:59:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWKCRWGYemBZVbSXj5eQfcHGAEvwJ0o2jXbjK1XnKY538mASqlezJ9+CpH6kHUzBAsLiJ7KKCib0RrfhXJ08LsKnjbgkkyx8L8khqvIL8/Y2f7HL+VeBerHrnChtzdKri/KlvMDNxSferU+3OkWzIX5CvjJOw0UBaMbz7vSmNvHJ9KIPEXVnw5QEjPP92s9yXzWvAIlphkPE5QvuoxEnYpOluYYsZEHhow2mWUhdJelrYFZboov0mLyPSQAanRGp1A1ZdhO1P6BovJBjQTxEvDGXwLAo1JbcmAvYdOgcx2Ba1RLtJWGuJ6jBo+9EZ2Io7ofJxxcfcpPAhJjIiO6TEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAM7zX9yrdmPFpitGm4QezDue1QSmk/8eMLnbA/79IA=;
 b=LRz7WmFMXyzBNfAqfPmqDuygAtVem/bvq/ulF3qJVaOw508X9yGWCQQtKupl0opyhxT5WVaL1yzNsag3FXnCC9kz3ZjJNSgyVvnhrp957ZExj9BL/A19HLK/EAElVH3nFU+plzIuw+RmIw3yyd1i8m1seWvD+FaM6trBzw5ryTpvCLjlUciveqHaDAWpu1uHqnBWtEfVbwmEWgVoyw8QFha7EQLYs4LWsECQuExSL+x5Ei0VMzl7Q/HhgqVyqpt5c8dQT6msygJgqgHj66CG7dBY2NFaF/xwjzfKgU0TsrrmNqig0yavZsMo2Hlos0gutdsFCXNpRBhbValC7a77aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAM7zX9yrdmPFpitGm4QezDue1QSmk/8eMLnbA/79IA=;
 b=Z+kBimN+q9F5F3Ux+zaQBI38iO6+8IY+90Sa5YpHBkjdyvN/ATBewTIhxqB1MvADsOMYB0XuW0UBeKC6xB05KmLHc8qXY8zJbVKqbxctzbz5VOkFylPbB1jBo6f6uhEmPeFRxFOJ6oR+gl5V/RCkoQW2rl7mlXDdiFwiAHPRfaA=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB7853.namprd04.prod.outlook.com (2603:10b6:a03:37e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 17:59:36 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%7]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 17:59:36 +0000
Message-ID: <862a78b5-b89a-0b26-e0f8-f910dd3434ba@ni.com>
Date:   Fri, 31 Mar 2023 12:59:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-3-brenda.streiff@ni.com>
 <4687fc63-65ad-c717-70b4-731079be38f7@linux.intel.com>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <4687fc63-65ad-c717-70b4-731079be38f7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0024.prod.exchangelabs.com (2603:10b6:805:b6::37)
 To SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2436101d-6e2e-424a-ea64-08db3211b05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xvuERLjOUkC9xX7iGjt8TlWkJ1N5Ueilsp0AzAqxI5rOGEt5knRxGKERqVvEokQ8yR/8QjfGWH/UWW7/KMRK2nEjr8izB/PIoWrT07T4qqcghL2sz/aQb1Bx8iEqz9Dr9NLzN6MN0apl6nM4r/NHU/JbgUJxeCSqwAqwwyYedz6UqGTEOveJsTV7f/OaclAjInMVpdER2Ujvf2myU+sRCpXGv4l2QVbk49//JuBh4N8YuEQoG924mzkL0hov70tVR9MRBBKMDTljtAULNkitxRUuKgPwCM7YTiJsGHaBL7xrbvIqaE1tkljbteqyk++h2L8PgCZf9ofUBy5HWGiNv61jFp7cWFce+TiRrHUe6S6U2beIcbkAewzaBc+MDsJEja7/MfF1wacsT0X6UT6G6p2usIsNpZBcvlxLgTOFSyfct9zQ48XV4D02ysjY0QcT0GsMQ7uKQHvJSFO9jv0OMW4GuMr/7AOSGuSBazR7toPAEJIjyerQ3uQ936wdrrAI4BQ/cyd/KzNJWBmLoG/UOxKaR9naoI8HOf7tyDnZjFXhds0+JSJTdqqYvXbvCwUE36pNvE+YDxqlyx7soA5zyzrJN9Kv1v4R1804g3XM+VbMaSrgJ+wCf69rrpBOPUGrI8op5LTtEGv1nK+u1+Pag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(186003)(66476007)(4326008)(53546011)(54906003)(26005)(31686004)(66556008)(8676002)(6916009)(6512007)(478600001)(83380400001)(2616005)(5660300002)(6506007)(316002)(44832011)(66574015)(41300700001)(4744005)(2906002)(6486002)(66946007)(38100700002)(8936002)(6666004)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SENCRzRpUGU4Y0RjcWxlcEF5UzNjc0hUOHUySGk5SUIrQ0orSkRYQ0NvN2pH?=
 =?utf-8?B?TitkTk5PenB5UUJVK1l0T1AwSUZIZjJkLzJ0SXF2NHBrbXNHbjBuMmVSSWps?=
 =?utf-8?B?WWZmMS9aMDdLZTFaRS85V0dMQ0Z3eGhaSTZ3K2JrUVF0L1Y3dVBEalpKQ1Ji?=
 =?utf-8?B?dUJKWElENjFPczM1TTA3NlpaQ3dLZ3NzaElFVmgrN0E3SHhpOUR2MjlSTFJC?=
 =?utf-8?B?SVRkWkJzSUlwcVdqaGZoRW1wRmpSblRJTnVwdnhHcWFaajVneDB3YnVkTVI1?=
 =?utf-8?B?b29aSWtaTkRjcWh2R2J6a1U5c2tIdW9xREloamRNRlo0QzhBS1F3R1Y1WG9u?=
 =?utf-8?B?TVk5Nm1EbG41SmJDUG43cm9kK1YrRGFiWHV4NHR6dFhjVGZ0NXlCTTBqdUQv?=
 =?utf-8?B?SWMzYTlOYXh4TUJZalRzSTlUU2NIdG9NRDkyc1JGSkFQV0ZKQUowS0NuRzB0?=
 =?utf-8?B?Z2FSRmNsMGIyck5Eem1WT0gxUGFDWVo1TFhHU0h4SWU5VXlTdHlneU5md0E5?=
 =?utf-8?B?WW1oMFJST21NNXRsZDNUY1NXVitvRDcxdEdCNmRDS2hGUGEvV2hSZXJ5dFg0?=
 =?utf-8?B?Y2R0ZzVkRGJNc05JRGZqUk01dTdwZ1ZLYzZVSnRVNnhRYm91cUtXTzVTaDdy?=
 =?utf-8?B?dEl1czVlL0ZSSFFSbWYwd1M4Q3lKU1ZGRnNWODBXS2pLVWYweFJ5OHdJRFUr?=
 =?utf-8?B?MEJ6OTIzTXdCcHJPbEhqazF1aUlIQndjVWdEeE80dmxpRWs1WHhxVUFML2Vw?=
 =?utf-8?B?V28rd044N3pVUTRGZ0ZLeWxlUndjUkFXdi9BN1RQQ1JLbi9mdnpBUHB2MnY5?=
 =?utf-8?B?UUI5UlhpdEhld0NGOTNjbXZzNWYrRlVLRTNJUit2dDFTSXR3Z3Y1b2VmaEt3?=
 =?utf-8?B?RmpwY21DMmFtbzJTOCsvZXpucEd1c2UxZmRWMEZnVFVudkpPd0NLczE3TzBw?=
 =?utf-8?B?K2FDTjZ1NFlqTHF1bFBHaHNXUGNKSVpZSlFyRGpmWjBhMjRRcjdzMEZZM1J0?=
 =?utf-8?B?N205c2VmaWQ2dTZWSDhEbEg2N01CYXduM2p1UjhGbFBUK1VYM3AyMFlLSDNy?=
 =?utf-8?B?VlRzc3RFV3BTMWdEcHpEakpFeDZQeE9GdjRYeDdML3JRcU5RYitDeC9GVTJF?=
 =?utf-8?B?NEkybEVrM1plNzVhMTFPckR1Q0o4UCtXdkJxZUJOTVdnc3pMcUVHRFNKaWZ6?=
 =?utf-8?B?anBRanNhTW5Hd3R0My95QkhqZjdkSkZTZXErQzdWQ3E4SXN5bEJWTWIyYUNn?=
 =?utf-8?B?LzRKV0dCamhVWDNiN0pNOGF2cWUxSXI0bkV3aHRWUW02THNRQkd1UnhjZVFw?=
 =?utf-8?B?cVBHdFltVHlHODIxanpleTlTZ1lqeE9TenJHWlNLaW1nU1ZJaUhPZ3pINVZa?=
 =?utf-8?B?Wis1VGs4azIyclgxTko5ZG9reXJCczdXRWVHUWUzb2xyZlpMTlc2K2xSeXVM?=
 =?utf-8?B?eTVKaXN0Tk02L2xxY0UzY2dHNDVOaldUWkRLcnMrSWVQMUk4NTRNNGI0T3Ry?=
 =?utf-8?B?K3FIakszV3JSYXVsL1lXRkhaZmpYRHJxMGphTTVnL2U1ZXR3TVEvT1BBQUc0?=
 =?utf-8?B?N0Rqek5sRlJObUhWbTN4dmUrS3hrdnBRUi9kRXMzT3FOanpSd1hpYnl4VFBi?=
 =?utf-8?B?NnBObEd2QlE2cjJlV3puWmhVTWFWYWh6YkJUS1lxaFdTcmwvTmk5VWNJMG05?=
 =?utf-8?B?MkFwbTBZdGpHT0REZHZSMFl6VGRZdEdmSWZDWUZtR3ZzZFV3Mi93ZVNNc0lJ?=
 =?utf-8?B?ZGE2ZTNRTHhJUERYaDc1WlFSRzl4eFNMeFU1SmU2V2QyeHk1MVhyUlpONndY?=
 =?utf-8?B?OXRXWlZ5YTJlZ2VIS21KK3creXE1SUt2MDBCSFVJTm93K203allScjdKWWl0?=
 =?utf-8?B?Q2l0b3kvdCtKVU1lVjhsV09iZm9BU01jYlhNeGp5M2FJVFRGSTQ4Smt6SGhs?=
 =?utf-8?B?em5iRTdXYnQzdi9CWUMxS2xWcS9tL05MbDZXVi82aHFacjBPK1gzVDNLejhw?=
 =?utf-8?B?YWR0bFE4QUtDbEg4dTJteGR0UXo1NksyOTl4NmdjSVE2RHB4RXpRT3F3emtD?=
 =?utf-8?B?WERtdHl0cGFhRjBLSnZSRkxxalpBaHVNVmxLQ1RhK291azlWTURYalA5T0V4?=
 =?utf-8?Q?YunwJbyi0mGIpRkAffOKrkRyT?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436101d-6e2e-424a-ea64-08db3211b05d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 17:59:36.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o6TawV2V20K0RVUgOAUJmN0trU2J6ysqaQJC8oqetFi/lbv/rxWxawj5wmg1WJscz/OHsIzdKqIE+tADLWdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7853
X-Proofpoint-ORIG-GUID: WkbT6ZQDifc7seBIF6dPgU1UkfEM5ko8
X-Proofpoint-GUID: WkbT6ZQDifc7seBIF6dPgU1UkfEM5ko8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303310144
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 06:46, Ilpo Järvinen wrote:
> On Wed, 29 Mar 2023, Brenda Streiff wrote:
> 
>> +static int ni16550_get_regs(struct platform_device *pdev,
>> +			    struct uart_port *port)
>> +{
>> +	struct resource *regs;
>> +
>> +	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> +	if (regs) {
>> +		port->iotype = UPIO_PORT;
>> +		port->iobase = regs->start;
>> +
>> +		return 0;
>> +	}
> 
> Do you need the port io?

Yes; on our x86_64 hardware this UART IP is in logic connected to LPC,
and the registers lie in I/O port space.


>> +	int irq;
>> +	int rs232_property = 0;
>> +	unsigned int prescaler;
>> +	const char *transceiver;
>> +	int txfifosz, rxfifosz;
> 
> Try to follow reverse xmas-tree order.

Is reverse xmas tree also the rule in the tty subsystem? I was aware of
it for netdev but I thought that was a netdev-specific rule (since it
only shows up in maintainer-netdev.rst and not more broadly)

