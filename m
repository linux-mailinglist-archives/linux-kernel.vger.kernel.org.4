Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC295666996
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjALD0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjALD0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:26:45 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EECC75E;
        Wed, 11 Jan 2023 19:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnjY6sSFUi8W8vefl72jdRU/XlPThDLf0/OyY/ZEYeepzc39xh01CW7/i8tROuNvJ1oLhqwCsrpr8F6rxrjvNSpgPmB0t08SK/nKFfm/kCGE1oc7dyTCpFl4KXKZHzw8+HxyQDm3OSlKdi3dvepQGAWdjE7dXiRxgJO2Gi+A5LlHgMhifDYSBsn1hSjn/mlU1g/0j+4uyFuf5hpfYDaYNk8hY4aBVdd8O0vbzFFt8LAAy7DCzR9bZvKJRcUKQ0DsgadMu1mDE1YwxmcAK1KNvXChP8PVKXpc0qziXOHN1/un9o1ydLKSq69evL4apZj7KmdQHDQAs0gZMH8n9yxQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QmQF4B5QuUY+9yw2Ql9u57j+Sn4xNXGuAzPwcZ/psI=;
 b=gGIWEUSvyk+gSmVn3M/Pc3a7mgnDeX2w4vb5pToHprLAQCJ5tdL01OWgW2MsMMOw8BoJq0JKpkOn/BM4n3cUGtaPg+k8WWyuxX6RuCz9XcZjz+WrNCmoAKH7Xt2sAKqrXNJP180qcTxOFSQN/Tn+SkBTS8dJ/ql2l1RGvBlCu2jsCQyNBs3PD1rsWtkL7Xm+GvqArlaAMB9aDKG54JjueVtRo3A/BUB6aajyXNmLjXvNXDXnSHOvCW48oQoKSU7u/bCgbmCkZ8eePC4pYUrSiqGc/sWWIh1QGJiiflkdz/SY8Mk2yCWXF0+RAmARaZEzOkWsAb92go9WQVi+/koeTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QmQF4B5QuUY+9yw2Ql9u57j+Sn4xNXGuAzPwcZ/psI=;
 b=glfOoJJJaEy1ulPNVdEU6RS8oNxBbaMCbAcvpZNuzR+w9mwfICAdODwp8Y7mXhDVaawtmWsibfG3GJuLqWxSRRw6sYMvDZRo9X5Lz9xRZRZjsZKHSjUbV/mUW3eboTN5adOdD4YzAv7Gt0oMJVtwNvvnFkVinY5YA3RGeM+rQ2uAx7gOFM7nbqsl4CWbTB9ecpDqAhruZA8iuKrePi83i4d77xzhhxE/TNgWJ9GK/LN+vL4TaEL6ZmqJ5Q7NUNQrcVk4BGVgXI/xtckCtVvgfOF8GIHloVQT2lewjIR+BP5lzRtdBKNJk597TOWrrjRwZDyH53BQ1aq4L5wXipMx+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 03:26:37 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::913b:8afd:f0d4:9a3f]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::913b:8afd:f0d4:9a3f%7]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 03:26:37 +0000
Message-ID: <54c45867-e9a5-fb6b-d242-0a02305e70d4@suse.com>
Date:   Wed, 11 Jan 2023 19:26:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: qla2xxx: Simplify if condition evaluation
To:     Deepak R Varma <drv@mailo.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y78HoiOWkc3RrEgN@ubun2204.myguest.virtualbox.org>
Content-Language: en-US
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <Y78HoiOWkc3RrEgN@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 566504b3-8a56-4a54-8d0e-08daf44cd035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbtZ+HDF2uqK5fLhyFgJAuK586wrBkPAi94mo4c+2v+DRAtIjNPAHGn6abPDo39KUsqAMQYP8H7T2qiY8qo14wDBy8QD2eudBNWdKG4gXkhnkg/u8zdfLjp+Vc9zt07D9Kc5wPzO/2w3k+OAXsRXRmKmxXHNu4iK2FvI0UNz6l9gXDHleQUyU+TzPhUmkSSa0X7WAdHHficW7GbwcguwiZYz9Hyp2p9ZUXF9xOwQPvUVzJf091nsVzJyK9N8qNAZcBqsn1nD6CWrcRin7FDatc2Rpln2vCUDMyDjsrV7g922l8NLx4MsQ7EJrvfaxQwKpOPyXvRJdwnCxzD3yLysBaDuRUFQglUX3FGwgMna6H21tJlRIXBiACk/i42AAFmrqDotnyHe47nDv0a5D5hJ2TmM7HB23dFS9bZbpBtKaoQHywq2rkp0d3lMYXgCXLp7qU3yM5W0VSYBn6GnLMPqcdzYVkd1mHDyhgrHiqbsLtaDxAAJ7ee0A8oI8ImQwn32zQ6SKddy6vYORZJjIAxiCOcMgvx784phRw9+Roo2zIDL9OeFeaxji3u48yqWeVfh7+JqnS5bTeFKihLns2200Zq3tAgit8E6dDvqliHDJ6RqLuOALYgeUZhyFF17+SdOSspnJBQkTTGTakFP2nsmo6zQs5KvStEFAnyl8+tU9NKK5lkAqK4tLJP748Y0KVvzXToMb2JgRWecA+Q7uCcJ3KblHQqmMDDCu8ydIgMx1ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(41300700001)(4326008)(110136005)(2616005)(83380400001)(8676002)(36756003)(66946007)(66476007)(66556008)(54906003)(316002)(86362001)(31696002)(8936002)(5660300002)(38100700002)(2906002)(31686004)(6506007)(53546011)(6486002)(6512007)(478600001)(6666004)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ovTDJyL0Z2RFhpRkE1NkVHbTVrbHVONHdVQUNNMTVaMGV3bWczQTdvZk50?=
 =?utf-8?B?RzFENjk4OE4wRTZnZDZyQTdlVnhyYW9rTzhaV0VMajJKejBrU2tyNnlobWhY?=
 =?utf-8?B?cXNrWjRhdGJuRFR2Qjh5NlhDMXRkeWxpV3NMMXlTQUFuUmhud3d3bU9QZU4r?=
 =?utf-8?B?UzcvRnNzY3g1aUdwUnFkR2FMV0NJNS8yUE9Nd0IzU2NLcEFlbTJOT29ETzcz?=
 =?utf-8?B?cnhaTEFqVERYM3JwdGZoZnVvdlpPeU9TT3pFcEdzVUhYNjd3VW1uU04yRDUz?=
 =?utf-8?B?YjlTQlYvREhkWDgrNkhiY3U0cFFuZ0hPM3g3QmJyU002aG5DTXAvY2xUd09q?=
 =?utf-8?B?NUVHNWs3bFlrcHE3MERrNEFOb0l0dFB5Ym8xVi9iUnFXRGpJQ1VhclJLMHE0?=
 =?utf-8?B?bGlISXpDZjRjdUVBZE5vZVl5NHZEYTRPT0dXQUdiazl6Zi92alVuU0pnbStB?=
 =?utf-8?B?dFl5czlHLzVlVm5ad0p0VXZLS284QUQ4MUl1cVBGaDlDY01iT20ybDJ3Zktu?=
 =?utf-8?B?WXlWT0xDYXM5aUVYMlNwTXhHb09OcUVET0NiV2V1QWNFQUlsa0RPK2lzWWhx?=
 =?utf-8?B?eTc5TzdYZmErYnp4Ny81VFlCSTNVMVlTMzl6aTZwMjBsSUJPODFMWnhlZlBJ?=
 =?utf-8?B?OHVFbEU0TnA4TjNWMnNQOHZqdFJTVnZPYzR0WnhRTnpCZUxoenAxWUd5MWdy?=
 =?utf-8?B?OHdSVFphL2F2blo0MlZUMzdUZHdLTkhxbEJ0L09ZZmh2VFNIdlJTOVE0ZXp0?=
 =?utf-8?B?UFMySjljV25HVjE5QUxqd0RLQ1hwcC9La1cxWmkwTEtyZkJDckExTE9OVms1?=
 =?utf-8?B?ZVpBWkdNQUgrRGdlb0lERnhxdXhBUTQxZjNReXU0aE43ZFBveElwZ2V2ekox?=
 =?utf-8?B?M2Yvb2JkemZpMXdBcjNYTytseWw2YTdkK2VXTkVJQi9Cc3YyS2l3UzY0Y2N2?=
 =?utf-8?B?cU4wNng5Uis2dFA5NkJQYW1YM0xQYUdjaUdGazRWcS82MFlySGw3UTFTQzNq?=
 =?utf-8?B?TC9JUUlac0hqL1BGOXd5b0dtVVU1cFBTUStjaFI1QjVGcUNIcEcwUmlvdHlE?=
 =?utf-8?B?VW1NaDJtUTUxZU5iS052RkRyVGg2Q3hZUktNNVpVMEgrQ3ZsZENybzFlVU1Z?=
 =?utf-8?B?OE5NVUVqRDI2WEdBY3VYWno0Z09EcWhJa0FweUFyTVNDRGtPRWNhTWJOOW5G?=
 =?utf-8?B?eHhvNkdUWDhWWFJjTk1pb2xpcWsxaDltd0NILzhhYlcycUJrV3JHOFBrYlVW?=
 =?utf-8?B?WXRadjlLQUdGTDlaa3djMTg3Z1pERW9uNzJPR1hXOFBVZnoycVEwWnFZTWFj?=
 =?utf-8?B?SlJjS1BQUmJHbUozYkl3MHJ2N3Q5WkZvV2lISW5Oc1pBK2RBWHd5Yk1SV2ZI?=
 =?utf-8?B?eVV1RGlWWTBDZ05pLy9xRjRVK0JITTF5SXMzdjJkZGFLNjdBVTVJUGFyVFFa?=
 =?utf-8?B?ZkIxM01FUUdtUTg5UjEwcHpQaGNkZG8xalkrVkRrS1NTaFdTbFJtdVlUaXhk?=
 =?utf-8?B?YUtKS0tvYXR3VW1CNEdzbTI3QlBLdjVEbTJwd2xQNm00NTZ0bVAwSURISVhL?=
 =?utf-8?B?TDhVTlArN3Y1WldMbDMyNndreTA2SEpwemhWbjRZcm1aS3pzUWQxSFNFcjQ2?=
 =?utf-8?B?eGFEOHFaUkVVMEJFaS9zd3FaTGhScld0cVRtQ2U0Nm5sTHMwN2l1SFowaTY0?=
 =?utf-8?B?bmg4d1VoSnZmMVU3blZCMzNGWThiZHRtZkRNdEJqQVp2ZUJlQ3BaSDNTUnJP?=
 =?utf-8?B?aVNveDBEQ2NvVW1zRlVRaDFRZGI2SU9kWDRCTVdtczczRkpQUHQ2TWJXWisz?=
 =?utf-8?B?bldJc1dteDRrczdaeEUrVFFlYlUyb2U1aGV6cUdqL0J0VWFQd3JicHNsYTNH?=
 =?utf-8?B?ME5tdEM5aC9hZEE2UzRFZkU5R2FkV1Q5K3RaMTg4WVFmTGlJR2JkM2JMdGp2?=
 =?utf-8?B?WkhlSmJSVDRPVEhCRVpDVWJtRGJLWFVQeGV0bDN1eU1OdnlZQno3Y0dUN0FD?=
 =?utf-8?B?TEhEaWRoUVo0Sndndk43VTlVMmlyMXhiNG5kTlBFSHpxaUJQWE83ZzRYVVhP?=
 =?utf-8?B?bnRncXRjeU9raVFXV2FQYVpMQm44clV3ZXhxTXR1d2dkemlKTzVvTldla1l2?=
 =?utf-8?Q?px2ag1QIp5L4rkV9m9O1vHMVH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566504b3-8a56-4a54-8d0e-08daf44cd035
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 03:26:37.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sfw2eA37Qxup3w7ZGhnMu8Ms+nwiNUV3+HxF1WRz5TNI5lEOAYXYOiI+u7mcf4QZp8iSm4NYSUjx2vUKjmn57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 11:01, Deepak R Varma wrote:
> A logical evaluation of type (!A || A && B) can be simplified as
> (!A || B).
> Improvement by suggested by excluded_middle.cocci Coccinelel semantic
> patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: Change is compile tested only.
> 
>   drivers/scsi/qla2xxx/qla_target.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
> index 548f22705ddc..bf6aacf4dbd1 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c
> @@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work)
>   		}
>   
>   		if (ha->flags.edif_enabled &&
> -		    (!own || (own &&
> -			      own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
> +				(own && own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
>   			sess->edif.authok = 0;
>   			if (!ha->flags.host_shutting_down) {
>   				ql_dbg(ql_dbg_edif, vha, 0x911e,

It seems like you missed something in the translation. You left of the 
"!own" in your replacement. You are translating (!A || A && B) as (A && B).

--
Lee Duncan

