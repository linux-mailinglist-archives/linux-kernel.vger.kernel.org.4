Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA97314FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbjFOKPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbjFOKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:14:57 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC82710;
        Thu, 15 Jun 2023 03:14:55 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8UEgw022050;
        Thu, 15 Jun 2023 03:14:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=LSdvXR9dU34niG36RcffO9roTfA9kN4PQcx5ljcCCHg=;
 b=nDG2o20LTEsEL0DrF0LRiYlgvdp4duHlnig5BdCrom0WAFRwQ3PyfHcOnM4CJtyz9K9Q
 VOmHWadOczphqtvCqvw29TogHSvZSJ5XqdyLVoq2bmlp9AMHG3p8mnjTMaHnNUAQ0UwD
 Y9s5IQg8qaJ5OW7TVRj6bJFsDXq3oXdtKmvuB3gDNQmfZhohbOzuiAhhnBrgyQNEzC9s
 o1sHirfrMarx4POtrlVSha6iEAYFmhybNdcbmno+Ij+5qW2XLRPD+U4ryP/kB9V+2oSb
 NrZ77sCH5T5zA+jw569mhcJom6kzo7LWj/I744MXSabweWgoID41BJ8zD59k/+NW5iTt Rg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4rphmgst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 03:14:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgWc9Cung7Kry+3SXkcmd+AXfKKY7zqsCIjeWXVoZNTHyb22Vc5yyxvVqP6rI5yRkOAQ70U+jbf1+PL/dbUvWsA36nJOMBl2K4xAFE026rMlTxW3e5K3cCye1nxIQVqFh/RkkFXuxNZBK7c4m5lmRqrTCWj2zee9Zm2uHyStKysq1PkM7oN0GdVsedzqBCvFZp4Hb5CuAFK2W4kNj7kKjIK/3G78BWw9ocjXI4XshoOONGWGAqFzoJDYTIRB4bNXOABHfYbqZC/eCdNC17B7Pjswey5za1FwWylin5fmQrKtmyRe1M+B6+J7Oq7nbnpnODv6+X9L5O8xhvzUaO6Juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSdvXR9dU34niG36RcffO9roTfA9kN4PQcx5ljcCCHg=;
 b=j+CxEFoeztZBDp4tdbFRV5OQGT0D6oYahuJBTKOd7UsQ/10S1zq5ngWFVlV7zKop+T3wLLKp30xAZScoIGtUMlxFmo40dpzyenjftq+29VVrbbzZ2s6zQq/k+nXlEumkS3jWW4KEyK1vo6qTP/FAEZlzxtcAa55W8kwP6OjyJ9FSyvcGrcn/RwWSpnWkYSW5dFnAO9KvalEm9BJeijZQO+qIKclKzMXrfkLfrJ1DDjCoBhoHVsH1Lg3kmwxEf2jlFDFzRjstEtmEAjf/vfU23WHLy3NCGtM4rZpotrghJSfkWQEuiAQYtpq8/GTlXqsBzjR/po2wHjf87sg2agYCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 10:14:40 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242%5]) with mapi id 15.20.6455.030; Thu, 15 Jun 2023
 10:14:40 +0000
Message-ID: <b75076e5-1137-bad1-d9ae-bb9b6945a5c3@windriver.com>
Date:   Thu, 15 Jun 2023 21:14:29 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] usb: cdns3: Put the cdns set active part outside the
 spin lock
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504131602.3273835-1-xiaolei.wang@windriver.com>
 <2023050503-handful-shore-ae11@gregkh>
 <3a9c2750-1c80-506a-69ec-a92250dfeaa8@windriver.com>
 <2023061507-mummy-salvation-c45a@gregkh>
From:   wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <2023061507-mummy-salvation-c45a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:2::15) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM4PR11MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbf1264-943a-4335-fe1e-08db6d8954e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7pyDPfhy5VxDFqsbrqPvIN+quNuBIoMZRt6ADpN5yBENaDu5Hpsf680sSfspwy90aOQMyMfkCrm9FyAEyBanXHtgmh3MgTr2FONki1qDpFJ5J3BRr6eRet8xlPEghPhtEcVpOlvE0mqjv9pua4uOwFUl391XMmqzcbqAR8NhQ9Jk6cQ3vQKe6ox02g9pqXG727k73Qzr8ePaqjGbiyKa5FhWmy98xd7CL9O8+QuBweoinQ9pEnp2qTxFfwgr2SzQUjlWKZuIDabti6G3bDlP1QlX1dJDIF2Ai3/TJk8/eIGT/8okad/tLHIHVQCWYsTSUmIXvQSwwD1dMw5ksJKiVBL9HxQcfKlsnAdYFH/dMqqc8bDdG21VmyH6k7qcFS9vxqSiFndXsSnFjK1Tn9TdGmp8odgdifhyAiOzM9tcBAyQteHFUbtqv5Tw5lAs2G38NnukukJJFRILjfpEvueHGqcEhEqAkqGMYwhqdEMfz72o/1cYcBbT70TT90EtCFOLm76PMNWyopczjBshStxozZsbIatBaBsxvcDrNjXyhVKac++MmiBF3VLz2tDlsHCYTsau2ZqzTHfkQoaZLpgjjNUzDL/mbojU03c4F4nZVGDOBWwE56Q1UExAprkQOx52GnSD2Au7sS23U6DhWnlow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(366004)(396003)(346002)(451199021)(5660300002)(38100700002)(2616005)(53546011)(6506007)(83380400001)(186003)(2906002)(6512007)(478600001)(66556008)(6916009)(66946007)(66476007)(316002)(6666004)(8936002)(6486002)(8676002)(41300700001)(86362001)(31696002)(36756003)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3hRM2xnK3ZoSjRiU3dnbTk5c2RsS0dCQzdOZkF5eXJzbXhCcjlMZk52dE5U?=
 =?utf-8?B?Y2NJVGcxc3JjWFNNdGpoc3VWMmNxV0tLVG9ac3Q1VUpXSDAyeCtkSDNsaFB2?=
 =?utf-8?B?dFFsWGh1OUZuaGtxWG95cTFhbldyNlJKUUxwTzBrcjZlQmZLZkI3OUxQM3Rk?=
 =?utf-8?B?QW1adUZiWC91ZVc2MC9VVFVIY1FSS2NrdEFwS3RTZWlBV2cxWVByd2grWG1a?=
 =?utf-8?B?UGhDVE5YTStMekE2L3RVN2RSOGwrRWNGY2t4OUx0UVZ2VmtSeXh1S3BZcnNr?=
 =?utf-8?B?enI5KzRsWnZReTE3ZHhuTDl2MkJOek83UXNiSXFRSzNnWnQ0WndnYWIxbm5v?=
 =?utf-8?B?c2JpNm5uSTNMSXpEREw5WHR6YkJWbjRraGU5NEx1QkxUN0c2UVpxYzltOUJZ?=
 =?utf-8?B?VndqVCtrZHVqUS9PQkx3ek1ibjd2bHFUVGNlR1NrRm1JNURHK0Q4Q3dzSkNV?=
 =?utf-8?B?ekpBaVA3V1dtL1VLeDNFQkJPVHJXTUZSaVg3ZTVFL1lmM3EyQ2NxUjQvVVJQ?=
 =?utf-8?B?VEtWb2lCajl4SkRiV2pPelBMdFlZT2tGSk9vdHN3aVpZeERiKzMxdEd3dHBT?=
 =?utf-8?B?MFlXVXlLVlhGYVljL1hERHBBdGFWWTAyY3pCT1ZZMVUydFZJbEREWEhlMkhL?=
 =?utf-8?B?b2pJYk9rbDFkR3pKbEJKZnlSYnBVeUVVUFdOdlJHU3JiNlJKOEFZWHZNbGVl?=
 =?utf-8?B?NFIvZnlWWG9LYXBlTVcyeVdjT0I0Y0lqU0VCK2hydmNVZTNZWGFuU3NYVjFp?=
 =?utf-8?B?TlpIYm1peURZVDZ4R0kxaE5tYU4xMWg5SFJZRStYS1ZQaXV2cFVuVDEvV2xs?=
 =?utf-8?B?NG1ndlBBSVF6YWFsb3BFc1VRc3ZoQnZYaHF4dUVFdm90TlNqY29wNjAwNXRR?=
 =?utf-8?B?MW9JTFhrM3FMU1dqUEtyZzQwUUlvYzk3YXA5Z01aeGJYT3RFMGJDeUdoTUw1?=
 =?utf-8?B?dG9jakFQWXIxQ0Z1eWNTcitHZVlzMEVXaGIvUkVwM3NPQXdjS3lqcU1oRlhQ?=
 =?utf-8?B?N2pZRGxoZ1FjdW84eTZTZ3ZhYVlXTUZEZndmbkNKWmZMeTg1Z2dNeFR6Z0l6?=
 =?utf-8?B?WDRRMHdOUUNqeElwZEhJSzJRdmZqOEh3ZGE2b0JnQ05yN0xEUkU4SUtqSWxi?=
 =?utf-8?B?WlNXM3RyQlVqL0Y3cVNOUlFBekc2Y2NYQU1mUDF4Vjg0c2JZNlVLSUQvL1gv?=
 =?utf-8?B?dmgvS2piRUk2T1luVzBmT2RaeUYyYnVHemppSm8xNGJ6N0FwVVJSaElCZ202?=
 =?utf-8?B?Wk8yL0VRdW5tSU1DZ1kwTURLUEpxOEJiYUxFNmxwQ0lQV1Jnd3VqSlNqK3Bm?=
 =?utf-8?B?a0RkV3NXSUV3TG5hd2E1S3oxZFF3bFZublFTMmJISjlSNk03dDUwcjFnQlpN?=
 =?utf-8?B?U0U3T3R4WElaTDkwVUlKWEh6UEVBV1FxdWM2cVdud0NqVTQ2NGtURmdRbDYz?=
 =?utf-8?B?WUExWVdUckY3eFFhR0pNV251Z0h3ZHdUenVwK1d5Qk9DZ0QwUVdSU1VtZWtx?=
 =?utf-8?B?aVI1V3hSaVBFTWtDbEJla1BMUC9ITEhLeVdKblRoZTR6OWdWTTN3WUY2czh3?=
 =?utf-8?B?UXZWTG5tUFdSYmtmQ3BwOWttWFVZT2RrMWdPcittcXB1TjQ2aXcwY0hyN2t1?=
 =?utf-8?B?ckVsNXhBRGJKYWhhVW9tQ0JhK3QvSmlqcCt1SC9BYUJtN2J6YVdyNWRsWnZR?=
 =?utf-8?B?Y1NMdHFEUlVSQ08zejZpRkVOaWxLSDhXc2xYazFLZk96bm9rYXpTanFsT3A1?=
 =?utf-8?B?YWhPUkFiNGlCZHlVd2hwelpUMnNsUURXTk1Na2c2amlzWURkWTlBL2RCL0hh?=
 =?utf-8?B?enZud0Rnd3ptNEp4RE5VUjJ6OEQyY0xmTi9MbW9CUGdwdCtNeEROWnZ1Z0s3?=
 =?utf-8?B?N0dUQTdxS1NxUVFoa1BOWVlLUDJTODl2TFR4T2ZQejU1MitGL1A0bXF5QUM3?=
 =?utf-8?B?RUdQVVRJd0c5Y1duTHZTY2pkaHZYMXVPY0o2VXlzaHZibnkzLzhGeUtXZEZq?=
 =?utf-8?B?RWowbXRhZnhucU1nendhK1lxUi92am5Qb1hXWFFvWGlnQXpLcy8yOXVPWmlj?=
 =?utf-8?B?NHV4SDJKMzlKVW9qNTZQVFNDdy9DY3hBRXBoL1lxKzdVOGR2emtQamNycjhF?=
 =?utf-8?B?OE1MUlhyREU2TkNob3llM3JZOURZZWtZcGNGZUtmaWdpeWpSNU5CUlJoZDVT?=
 =?utf-8?B?bDVqdXFPR21FR2pheHBwYldaOThlUkljeFVOZHZnd2FoOUNkRmZycnRGRnRn?=
 =?utf-8?B?dkYzQm5sNXVTUEo2OEo3QTYxMlJ3PT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbf1264-943a-4335-fe1e-08db6d8954e0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 10:14:40.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKRw84hAFf9yJ1nLRULFchJzXhCwNkEXP505SXcJm4fhCNPTtp8QrFxjifzgiOE33wsVTnH94YSLycavSs39GPVZn3df+eyayJcGpegVzro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
X-Proofpoint-ORIG-GUID: a-6A--q_YA8-qtWc5mrOFl2JK1SlLudU
X-Proofpoint-GUID: a-6A--q_YA8-qtWc5mrOFl2JK1SlLudU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150088
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/23 8:49 PM, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, Jun 14, 2023 at 11:16:05AM +0800, wangxiaolei wrote:
>> On 5/5/23 6:33 PM, Greg KH wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Thu, May 04, 2023 at 09:16:02PM +0800, Xiaolei Wang wrote:
>>>> The device may be scheduled during the resume process,
>>>> so this cannot appear in atomic operations. Since
>>>> pm_runtime_set_active will resume suppliers, put set
>>>> active outside the spin lock, which is only used to
>>>> protect the struct cdns data structure, otherwise the
>>>> kernel will report the following warning:
>>>>
>>>>     BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
>>>>     in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
>>>>     preempt_count: 1, expected: 0
>>>>     RCU nest depth: 0, expected: 0
>>>>     CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
>>>>     Hardware name: Freescale i.MX8QM MEK (DT)
>>>>     Call trace:
>>>>       dump_backtrace.part.0+0xe0/0xf0
>>>>       show_stack+0x18/0x30
>>>>       dump_stack_lvl+0x64/0x80
>>>>       dump_stack+0x1c/0x38
>>>>       __might_resched+0x1fc/0x240
>>>>       __might_sleep+0x68/0xc0
>>>>       __pm_runtime_resume+0x9c/0xe0
>>>>       rpm_get_suppliers+0x68/0x1b0
>>>>       __pm_runtime_set_status+0x298/0x560
>>>>       cdns_resume+0xb0/0x1c0
>>>>       cdns3_controller_resume.isra.0+0x1e0/0x250
>>>>       cdns3_plat_resume+0x28/0x40
>>>>
>>>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>>>> ---
>>>>    drivers/usb/cdns3/cdns3-plat.c |  3 ++-
>>>>    drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
>>>>    drivers/usb/cdns3/core.c       | 14 +++++++++++---
>>>>    drivers/usb/cdns3/core.h       |  3 ++-
>>>>    4 files changed, 17 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
>>>> index 2bc5d094548b..726b2e4f67e4 100644
>>>> --- a/drivers/usb/cdns3/cdns3-plat.c
>>>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>>>> @@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
>>>>         cdns3_set_platform_suspend(cdns->dev, false, false);
>>>>
>>>>         spin_lock_irqsave(&cdns->lock, flags);
>>>> -     cdns_resume(cdns, !PMSG_IS_AUTO(msg));
>>>> +     cdns_resume(cdns);
>>>>         cdns->in_lpm = false;
>>>>         spin_unlock_irqrestore(&cdns->lock, flags);
>>>> +     cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
>>>>         if (cdns->wakeup_pending) {
>>>>                 cdns->wakeup_pending = false;
>>>>                 enable_irq(cdns->wakeup_irq);
>>>> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
>>>> index 7b151f5af3cc..0725668ffea4 100644
>>>> --- a/drivers/usb/cdns3/cdnsp-pci.c
>>>> +++ b/drivers/usb/cdns3/cdnsp-pci.c
>>>> @@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
>>>>         int ret;
>>>>
>>>>         spin_lock_irqsave(&cdns->lock, flags);
>>>> -     ret = cdns_resume(cdns, 1);
>>>> +     ret = cdns_resume(cdns);
>>>>         spin_unlock_irqrestore(&cdns->lock, flags);
>>>> +     cdns_set_active(cdns, 1);
>>>>
>>>>         return ret;
>>>>    }
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index dbcdf3b24b47..661d5597fb68 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -522,7 +522,7 @@ int cdns_suspend(struct cdns *cdns)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(cdns_suspend);
>>>>
>>>> -int cdns_resume(struct cdns *cdns, u8 set_active)
>>>> +int cdns_resume(struct cdns *cdns)
>>>>    {
>>>>         struct device *dev = cdns->dev;
>>>>         enum usb_role real_role;
>>>> @@ -556,15 +556,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
>>>>         if (cdns->roles[cdns->role]->resume)
>>>>                 cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
>>>>
>>>> +     return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cdns_resume);
>>>> +
>>>> +void cdns_set_active(struct cdns *cdns, u8 set_active)
>>>> +{
>>>> +     struct device *dev = cdns->dev;
>>>> +
>>>>         if (set_active) {
>>>>                 pm_runtime_disable(dev);
>>>>                 pm_runtime_set_active(dev);
>>>>                 pm_runtime_enable(dev);
>>>>         }
>>>>
>>>> -     return 0;
>>>> +     return;
>>>>    }
>>>> -EXPORT_SYMBOL_GPL(cdns_resume);
>>>> +EXPORT_SYMBOL_GPL(cdns_set_active);
>>>>    #endif /* CONFIG_PM_SLEEP */
>>>>
>>>>    MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
>>>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>>>> index 2d332a788871..0f429042f997 100644
>>>> --- a/drivers/usb/cdns3/core.h
>>>> +++ b/drivers/usb/cdns3/core.h
>>>> @@ -125,8 +125,9 @@ int cdns_init(struct cdns *cdns);
>>>>    int cdns_remove(struct cdns *cdns);
>>>>
>>>>    #ifdef CONFIG_PM_SLEEP
>>>> -int cdns_resume(struct cdns *cdns, u8 set_active);
>>>> +int cdns_resume(struct cdns *cdns);
>>>>    int cdns_suspend(struct cdns *cdns);
>>>> +void cdns_set_active(struct cdns *cdns, u8 set_active);
>>>>    #else /* CONFIG_PM_SLEEP */
>>>>    static inline int cdns_resume(struct cdns *cdns, u8 set_active)
>>>>    { return 0; }
>>>> --
>>>> 2.25.1
>>>>
>>> Hi,
>>>
>>> This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
>>> You have sent him a patch that has triggered this response.
>>>
>>> Right now, the development tree you have sent a patch for is "closed"
>>> due to the timing of the merge window.  Don't worry, the patch(es) you
>>> have sent are not lost, and will be looked at after the merge window is
>>> over (after the -rc1 kernel is released by Linus).
>>>
>>> So thank you for your patience and your patches will be reviewed at this
>>> later time, you do not have to do anything further, this is just a short
>>> note to let you know the patch status and so you don't worry they didn't
>>> make it through.
>> Can someone help review this patch?
> It breaks the build:
>
> drivers/usb/cdns3/core.c: In function ‘cdns_resume’:
> drivers/usb/cdns3/core.c:527:24: error: unused variable ‘dev’ [-Werror=unused-variable]
>    527 |         struct device *dev = cdns->dev;
>        |                        ^~~
>
>
> How did you test it?

Oh, sorry, this may be because I did not set the compilation parameters,

which caused me to ignore this warning. I will delete the unused code 
and send the v2 version


thanks

xiaolei

>
> thanks,
>
> greg k-h
