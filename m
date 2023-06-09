Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C196F72A57A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjFIVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjFIVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:43:55 -0400
X-Greylist: delayed 2559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 14:43:54 PDT
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6EB35BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:43:54 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IUQNd031404;
        Fri, 9 Jun 2023 16:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=MOeO1TAeQ2XFAhwSWjOvTHqY3o27mG4Iumq4TQTeykM=;
 b=xC3qjdsISf0B6kYw/KMQohvt+exr/HYRAM3HVZhlA1VX569nH11dA9m2OCscXDwP5WIL
 GrjPmxi3ohw/KWjgu+OVYPW6uO53Ylw/MfYK3aiPqr7EB8Nt9uQXqzMazjIXGJx+7Gru
 jBb24N2FjuOtSN9lanmGTVH3qV8EbVttSz6Yhkgp5rYru6iwMaeZL5Qz4YUuy5v0TzPA
 jxi8RDPO5gWPGq9XbJSY+BLrVmOnNn/EoeFqSdvvHUN4HtMBsgbcmrMTncY0yRfdDXqN
 Z5Pg7fFlORFJN+UUh/QqkEjT32WBuE6NSF3wKRi+8PQLthitkAoPfFhO6d1i6y4OgqJn Jw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r2aykxn0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 16:01:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIXivHBLKhRcO7Eqbdi63CMq3HmU6RXzN6msb21aZRKG1I5xtk5GAxN6t2LAhzRbEdwnzvrfa77GxIWZn03OC0BXXpg2njW+NZF/7AJQJbJ3dwhompbSfCit3I9GwD8+jY3MRdPLdtgkrlr1eLb7+pF7CbOVVkFgYLmCNRhSUSmyUrlmL6TWptaWzMjwiTfep4P0ImYYDLarEOGKBt8wIYfSwXSSKdHJEp0gfIA0RTdEVGD6H2MPo8JREzFHlNyN9kWK/wWlPAnu/duJ4C6R4T3dL9R3cKPwAr6aqvxoZUmbpC54Wo1q5r49Xtc/DX6H1aKpxwqZpeINUwI8Ei8k1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOeO1TAeQ2XFAhwSWjOvTHqY3o27mG4Iumq4TQTeykM=;
 b=Dj2IN7dkPniD3huTj+yJLNjscE4jQNclhOlC6JNtOEbGL3LN8RRsJQAZmabZENbBQm+23kSWkMz+sKSs1akZGQpfIucteK7eA8qf8sbOTuY6M8L0A5kPXD7VwT04E2sXeGzcziJ18a0/8ObiSSSUVGOD97SyKDYOpEmCz8oAgjZDTm/Stg+7B1xmapfz0qM1zYrM5d36eFZ8f17PxGN0Iu4HXR7yAKgP0VnYJECh7v1Sxw0Zmhok/UR++JZfkDq9pXtBey3BPak/WCVsSUL8ko+Zjtiwia7DTcRcdQOxCTst2McyAnDRcbEZoYNENea7hIB3K6A53r15eBElWRBQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOeO1TAeQ2XFAhwSWjOvTHqY3o27mG4Iumq4TQTeykM=;
 b=Fo6GRDTikNJOVZR5hDR+bt3olnZtx4y7j7xcQ6plQDVe1Vv9bygFaHlS7VkDB3x+ZNOiUJzLgDQfUbDIK8wfxf+IYR8BZMG2J1BgZ0SpDQ3+xOPUAs0+ctTCvGdJdlTGgSk6p0QFiSRGWGVzDKJ3yJRhyD1MVFXi95aJkubaFUU=
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by SA0PR04MB7225.namprd04.prod.outlook.com (2603:10b6:806:ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 21:00:57 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0%5]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 21:00:57 +0000
Message-ID: <38f38f66-0fd5-4e6c-4839-8272cef77046@ni.com>
Date:   Fri, 9 Jun 2023 16:00:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
 <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
 <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
Content-Language: en-US
From:   Charlie Johnston <charlie.johnston@ni.com>
In-Reply-To: <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:21::35) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|SA0PR04MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b660a3b-76df-4738-8a14-08db692c9efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5nqDWbvJryFgFHOXpkCRb6+6JfOG4hldsuzSzKGVhvEIG2hG+O9z5libYaukDwVagY4rd4VyApAPyduWpsBiMPkY/9DyGEn3BJh02p18MMT/ET0A0eMFYWuCLisr/DXSdcXKvicoAzEpPxmiewixL3wTvPkDLLjE35/s01oHBaKM7ofGgfCj1xsd6/0As9tCjMgNOqcJzzhL1wwcAAOuSfyh0+pXhbueT3GxgVSHzczSEQ9UxstMR5VcKoNUiJWz7dJ6SgoSIfx/tLTpOlBNtJONxXEnyDH1dHoV8IHIShPxbFCcJcBUZ1SN+T6iq13EWSpJofu0DX4FWEuM5Clk53p3FDdsLnl/BtG3CW2u08R+Ib+tPb4LX6k85bfrtV6BXVax80vwa/3tbHaBgt7GZzscGPPz0K6D/BiiuiOHeEbvAZ53wZbvz45pXY7fxLJFCnvQSrWACQP7plCX0J9EMt8kI48/hzsJ7HW/txvartpSBVRL1W8E62kTFAgFDSZT2pc+uyBMwOmuHzKFR/0CA5CZu5AFr5Pi+bNDBQ5K9UfNmvgHNULqWqo6hzupwXRXxlN/QexywAGFPBajsDkOtgVYTKAuq8S4Er4JCUS6FncambMDZGR+Y/N85VvyKFkarbGqFoy2ZdP4kEXl8tCeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(478600001)(66556008)(36756003)(4326008)(66946007)(66476007)(38100700002)(6916009)(31696002)(8936002)(8676002)(44832011)(86362001)(5660300002)(41300700001)(2906002)(316002)(83380400001)(2616005)(26005)(53546011)(6512007)(6506007)(186003)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW1iTGhGTUhERTVzZW9RTStRNkgzMkdMZEtLSVlid2RkTGxaRUQwbmlPR01M?=
 =?utf-8?B?R1RXMmNiVWE0TGtXYjJJUjc0WUlxT2YrM0R3K2lQcUZKUG5RYkd2SWVEcDNs?=
 =?utf-8?B?SXNnNjBMenZGcU9vQjNQdWNuU3FzeW9jNlpZVzVqTEpHMmRNYnllWk0zeWcv?=
 =?utf-8?B?Q3IzZWNSWk9SUkZTTHI4N3BKK1BQbGdqZUtpU1dEOVhDUDRHNjFOeThNaDYv?=
 =?utf-8?B?RXhTRHVTRVpxMmpMMmkxWnFMRjYwN3VwelZOOGxGL0ROTGtpczRJWjF2bFNS?=
 =?utf-8?B?c3hoUkRucmRlcG8zbXQ1Y25OVm1JNHpGQTJhcU5uaEczV3hOSE1SMmhpYU5u?=
 =?utf-8?B?bkFId2dxbnJRT0kzakswaXExT2RXUVZMTkhjWEtjTHFiUWhXeUxPVVFHNUdQ?=
 =?utf-8?B?ZGZyYUlxVzZFS3ZsNUZQVTJ0ZUEvNHZFZHR1bmhZTkVPVEdRU1owWHV1SXJt?=
 =?utf-8?B?OG5MbER5b0daNGo5dGQ0elhzSXpKdEM1TkkwR09sRlF2c2NzMmo3dmUzdjc4?=
 =?utf-8?B?Wmw5Rnd0R0o5WkRvakF6ZlN6ZGF6b25leVpRMmdidUJiaE1JUTNwSitIRFow?=
 =?utf-8?B?ZHh1dmd4Z3RadmtPVWhPd2s3Q1JiVnZmK3hjMENVaXpaR2haclBPN1JmZ1p1?=
 =?utf-8?B?UklGeDlNTTNJbm5qaFJvVnNSNEE4aW1PTVcrV1A5WUF3Vy9WeUZNYk5GQUJp?=
 =?utf-8?B?Zkh2WDBhdWJOVERETVdBdWNJb0ovTjh2SStVQWtURm9kYlVDNHNPcjl2bWJC?=
 =?utf-8?B?ZW5nNzI5VzhBVHUwTGYwVzl1RWI2eE8zNFBqWVhNWGh4dGtOYTBnZ0FmOWVu?=
 =?utf-8?B?eVo0WFhSL0JnL2JIL2h0WDBranYrSWIwem9aMEhlb0dkWnE0Zk9rRVE5QTZh?=
 =?utf-8?B?ajdkRXVaM3hOc2FwcW9TcXZ0UWllOVJoN0dpM2ZzUFVaWExKd2dtYkNNaWRG?=
 =?utf-8?B?aVFkM0JIQjdpY1U1aGJzdXJMNXFGRmpWbTAzN0VnOFN4YWFuZkMzZ0FLbk4v?=
 =?utf-8?B?YXpUUVpuQWoxcnpTelN3Q2ZMUEw4ZHBPT2YzNGhpdHJGK09zSk9wWS8raVdS?=
 =?utf-8?B?YW1Ta2FBbFB5U25tdXhqMmZVS3JMTEtaZTh1RjBNQWVWcjNVRXdtRm80emFO?=
 =?utf-8?B?YkI2My9lMGQ1MmxNSVduYnh1VXAzVm9zMCs4QnRzeERpVTFOVndIOUNXRCtV?=
 =?utf-8?B?OFg2WnVwT1RGUXpSNjBNN1ZFeldOZHc4VXdSQnBlWmwwVDExTTZjVktWdUp2?=
 =?utf-8?B?MkFVMHJGVEpKbU1oZ0J2M29XTFZWT2U3S3lLbVllS1dRNzZFa3VVNmxjWkp6?=
 =?utf-8?B?Qnc4N2NLRFczM3prZll4NTkzRVNTUnAxZGFyQk4rY3Uyd3hFUm9FTFRZUkxC?=
 =?utf-8?B?cU9Rd09KcUNRSkFYYUJKdkdKUzlvWnF3K0J4dzlxUnFWTVp1ZktheDhqOUxq?=
 =?utf-8?B?UzF0SGtaSk90VTZZbjhCTWZPTUdkN2ZNWkUwUk5ZQjNFdVY3NWRqcWlMeEFi?=
 =?utf-8?B?cUhoeDJQeGRLaUFldGVDNFF3OWVZaUNlS3Q0WlM1L1lnRjVqRmFjY1dZT3FN?=
 =?utf-8?B?QldQQjljQjhZMEFkY25NZ1NidlAvenptbWFsYjNzVEJlSnVuU2RkYVZBQVhN?=
 =?utf-8?B?TUNlTnJsalNnZ3Y4TXluSFRIQ3pzcWM5WnAwODBFNlEvMXBxb01yZm9MZmVo?=
 =?utf-8?B?UzZnQ0JTUW9JQ095WTFsMGZEdmlPVXB4Ui83ajF3cUxPL2FMOGtvVk1nZzJp?=
 =?utf-8?B?NlV1cEl4R1pFdXc1QkZ0dHpuODQzMllvOWQwQVJVUDV5U2l6aU1qbkROeWtP?=
 =?utf-8?B?aXk4dTRyY01BcWZMcXdmdDhRUnBPMlpSWG1GOFZmTnJaaE5RQ2MwR25Vam1m?=
 =?utf-8?B?aDBtemtIMDlWcFk2RFJzVWlLQS80cUYzbG16QXZ2Wk5CNzdxd25jTXZwM1h5?=
 =?utf-8?B?RkFPdmFqSTVZOWo5TWE3aXpURkdXeFMybmdmOWEzWGUwRkU1TGlOazllVFla?=
 =?utf-8?B?TVFqSUhMWmo2TWw4VEdMWGJPaC9yTzUyVlJnbE0wRStVOHgycHVVYUlyc1Rt?=
 =?utf-8?B?OCs3MXhOWlc3SnZNd2hjZkdpK2R2OGNpeEZiRnFSY3VuaXpwdEV5T3hZM2Fm?=
 =?utf-8?B?TGlQMXpwYkt3RWw3TDdlak0ybHVrNDhWaHNycDdvbFBVeUQ4ZkI5WkZkd29Y?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b660a3b-76df-4738-8a14-08db692c9efd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 21:00:57.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdBjhMjn+ABFsjWr46I3U5gGIpIT1aOQh15TnuGfj+e4fAa/y5tIsZZiO5elpHu5/0fXW5+6rkNAcsfC3RVVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7225
X-Proofpoint-ORIG-GUID: Ac5X0eHmF1yR_hEmo9YES5paikNx8nk4
X-Proofpoint-GUID: Ac5X0eHmF1yR_hEmo9YES5paikNx8nk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_15,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=877 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090177
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 02:30, Rodolfo Giometti wrote:
> On 08/06/23 00:07, Charlie Johnston wrote:
>> On 6/7/23 02:33, Rodolfo Giometti wrote:
>>> On 05/06/23 22:31, Charlie Johnston wrote:
>>>> For consistency with what ptp uses for minors, this
>>>> change sets PPS_MAX_SOURCES to MINORMASK + 1.
>>>>
>>>> The PPS_MAX_SOURCES value is currently set to 16. In
>>>> some cases this was not sufficient for a system. For
>>>> example, a system with multiple (4+) PCIe cards each
>>>> with 4 PTP-capable ethernet interfaces could run out
>>>> of the available PPS major:minors if each interface
>>>> registers a PPS source.
>>>>
>>>> Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
>>>> ---
>>>>    include/uapi/linux/pps.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>> index 009ebcd8ced5..85f472330da8 100644
>>>> --- a/include/uapi/linux/pps.h
>>>> +++ b/include/uapi/linux/pps.h
>>>> @@ -26,7 +26,7 @@
>>>>    #include <linux/types.h>
>>>>      #define PPS_VERSION        "5.3.6"
>>>> -#define PPS_MAX_SOURCES        16        /* should be enough... */
>>>> +#define PPS_MAX_SOURCES        (MINORMASK + 1)
>>>>      /* Implementation note: the logical states ``assert'' and ``clear''
>>>>     * are implemented in terms of the chip register, i.e. ``assert''
>>>
>>> I have just one question: are you sure that it's safe to call idr_alloc(..., 0, (MINORMASK + 1), ...)?
>>>
>>> Ciao,
>>>
>>> Rodolfo
>>>
>>
>> Thanks for taking a look!
>>
>> My understanding is that idr_alloc(..., start, end, ...) can take any end value up to INT_MAX. It also handles any values <= 0 by treating them as equal to INT_MAX + 1 since the end value is non-inclusive. I can't think of any reason using MINORMASK + 1 here would be an issue since it's much less than the maximum value idr_alloc() allows.
>>
>> A number of drivers (e.g. ptp) just explicitly use a start and end value of 0, but I don't think that change would fit here.
> 
> I see and maybe I should replace the usage of idr_*() with ida_*() as PTP does...
> 
> However the right-thing(TM) to do here should be dropping PPS_MAX_SOURCES at all!
> 
> Let me go deeper in this issue. I'm going to produce a patch set in next days. Have you any chances to test it?
> 
> Ciao,
> 
> Rodolfo
> 

I'll have to check when the system we used for testing is available again (not easy to find a system with 20+ Ethernet ports) but I'd be happy to test a patch!

I know an increase to PPS_MAX_SOURCES was tested on that system.

Thanks,
Charlie
