Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB56B72F2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbjFNDQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjFNDQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:16:25 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A610C6;
        Tue, 13 Jun 2023 20:16:23 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E2vNwD025700;
        Wed, 14 Jun 2023 03:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=Sp12foVswWcS4VaAv+z3ZhyHyi3QkLoCrneC0emNhwk=;
 b=akT+ka5xH5RdwiqNp9Rpnh/2CCMVI4rxTB89vsiqjdRkdtmXYizeOEpySHautI4Z++Bc
 e4fzkoe+ZQsCTHCEQh/XufI9mcz8k1Cne6lVU3LX3Sq/XcroLkoNQ+BuYB72JRbjLYWX
 kRVaFznYMwbsu1ZUyJjKiijwkEjruj0TEID7Pu8ytov2O1dRuR0DWSMPVkWC/cPq1ifT
 Us6ty1THv0x356UK1UTQCz5cstSDvhQA++yzd4BafmIhv0zp/ebuEXkjFmX13FrdW5hC
 2/+j6gSxtlWEZ2/cjOYtKL8F5uZHoy7DszNTkx8oH3eTpdDo2bnUUVEoPsKStpeodDpE Zg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4g583beb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 03:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEk3KDCeBYNqQtnNuaWlhDHPD4KZ0m6wxsrX/WM4QY1VDks8TQ9ih4aMTIKBx/EccgotyLd8dXNLaOijD3S4X0yAoB1RRTYDYECrPTVwhFGklkMtFdWgHvXv6/k/1+STDDKZcIPCvl13fb+1ERzqec2hHV2agnmKwbJoU9cTlLwb66p5515WMC+wVI9Ujh6oUeNkrCe1dd3ckbXayFXUPWFbjZDw/zsTrt2VrfnneOPNGrvXkyML3+EvIhFLOMphR8aNGyzZ7Qd6HH9GXgrJdyhznwS+/cMJVg9ErigLDd4CsKkh7+1iufH/i1K8iEzbN1y2QgyB3YyMeWbhxQCiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp12foVswWcS4VaAv+z3ZhyHyi3QkLoCrneC0emNhwk=;
 b=KhKBIb6kRw3B/T4k/W/RiMy/k5r6St+TLTM0f7dhHmGyJiY3WnjPfIaRp78+TGMyOUBNDv6RI00fZsMkkzdvTnMOh32Ptj0blF9yqHP3H/AdGoSVbV6I68I3DrfXWnRQKYw+dAAWWkqlNjy++eQObz/4iIq8m4orwBWX6hgi9WfZy9TnxHzLMR7PwMc/8ELz8tUDMHPK5dHD39/8IIq4JQaKusJ6tBryWpLJR2KZ7enmNPhghQP/U77Go9DOm0iWQstAhwBeAH67FEtg7Pm1q1DEFV0+sBPEM1EmhK6dz7K2j5VZkmxVadfTAfv9GlQGRzWzRqDH/mGTdsnqFYUbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Wed, 14 Jun
 2023 03:16:14 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7024:8e67:fd05:3242%4]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 03:16:14 +0000
Subject: Re: [PATCH 1/1] usb: cdns3: Put the cdns set active part outside the
 spin lock
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230504131602.3273835-1-xiaolei.wang@windriver.com>
 <2023050503-handful-shore-ae11@gregkh>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <3a9c2750-1c80-506a-69ec-a92250dfeaa8@windriver.com>
Date:   Wed, 14 Jun 2023 11:16:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2023050503-handful-shore-ae11@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: TY2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:404:42::36) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe26dc1-37eb-4c54-fc7d-08db6c85b5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8tOjR4H12WWX1xSI0+DCGRHm2BnV/d5w2xQ+pxtBKwX7HuVD25JRO1sNeIjnf6yka5ypA6HubB/5I+tC6MnlmhxiHXFgYeL02oqubq/+lwTmv+seTupdwTzNgrWvhz105I39q81WHzynmpEjHElmfz0XGKdbbtdJEvEY+MuL/nr/fRYB2IJvC/Evg2dSDCnBqGbWwcZp2hUsmPmGbShtECSSHZEUPcAIRxUevu9yTUnQjWHJyuwB3kobqg91NpBAggxMXa8RtQ4QICiBZ7486rOiQ+CGGD8nZOLWjnEneuvT5Gd4pue4D4cwRKx9ga98MtftM72TQdVctHrm7fWf+9sAbIXz2Fh9UbNRy9bpW9LSJZpQseBaEexgJRZ7Hc2z/kAKhSvxln8w0EisFaxKnF2NYD/jdVLJVIb2nUFsUwM0oB61dmgrmw4RKYgNODE2KGzrq7lpoNa4UKuTGI5LIYNYHtMWytQOWwI3ldQy66BdmZKsmvYW7wAIyXJFf0PC3AddXHSbfAYkaZqsapHTwP2KnGWQ7ptx/5JqY4fPIt/KYaUoNG3N6J+irkvkT4i5Q1kaEt5iILLnmZJUxk5vufvVa6/lZ0jMuSJJqvISy4rQgPs4RMG7Pm+12b9BuYIPgthbvRasljDiEdX+Da6csUaYwVDmmnVRKZdvtEMQKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(136003)(366004)(396003)(451199021)(66946007)(66476007)(316002)(66556008)(41300700001)(31686004)(2906002)(8936002)(8676002)(5660300002)(478600001)(6486002)(2616005)(6666004)(36756003)(26005)(6506007)(83380400001)(6512007)(186003)(53546011)(86362001)(38100700002)(31696002)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEo2c0pPUE1CRmI4NGVUMko2TStQUWF0WEh3Z2F3QnpoU1Nra21WMlFHWFQr?=
 =?utf-8?B?ZDgxdXhnQTlTa3poY3R1QzdDMUFjTUR1RU5kZ29tZWNKcmppbVlxV2V6VFc2?=
 =?utf-8?B?SGl5eDhqVk9FWnpSQU41Zk5WU0FjN0l4c2xTWjBKSGtKNTZxZTh0emRibVRD?=
 =?utf-8?B?UUNnaXdNblpDMmhPOWZ3YUZBTFpaU0ZrbUttUWJUQ00zNjRCMWkyTEs2eHNY?=
 =?utf-8?B?RW1CTWI2OVJEVWNOZ2E0WG1oZGFhcEFvcElyRUF2aEVsTjdoTlQ0UUYxSUd2?=
 =?utf-8?B?OVljRjhpY3JxY0tpM0JBd0lqNmxZbENrbGtHUU5mcndRanl5Y0lGLzJFQWlh?=
 =?utf-8?B?bGJ0S04yTXNjQzA3bFFFRUx3WHlWZ0hKaXBkclYrK0VaSlBkN2MvbG5wOVVo?=
 =?utf-8?B?YUI0TU5Ha2pOQ2ZWWlJOOXo5aWdFRXN3TllENjRKWU1LM0FqR1Z2TDBBL3lM?=
 =?utf-8?B?YnVsbHlXdlhOcXQ3cGpPOG5ydXI4SWdSVXJHS2FaSEF6NVVHY2xZRHJldURO?=
 =?utf-8?B?R2xzNmViWCtvMURoRmRyVlhZK0FrV3BxbHlmbmFMTEpMV0UvMDVhWFBrOEcw?=
 =?utf-8?B?bWRTREJZWmtYT01ZSmdjM05CU3dUQjB4dmtaVjNjdmJCMVZWczZZOS8yY1Nv?=
 =?utf-8?B?WEhod04yNmdXL3k2Tk85bTVhcncyY29SMFhrUy9DeHJQdVhjaTNqY1QraEJh?=
 =?utf-8?B?L2JmSmN5b3NjZ0VETEZFdHZmUzE4WSs1T2dUNHhEcmtDVVlCdkRHUlJ1eFRD?=
 =?utf-8?B?N2UzS1BoT0tWdzB5TUx1YVRaaFFkd3BPanRMVW1Ndk5VNTFtYkVRQXFiVUtV?=
 =?utf-8?B?clhRNGpIYU9nTEN3V2lDR093YUJKTFRWTFU5ZlIvVW0zQS9raUlLamgwejBE?=
 =?utf-8?B?TWtIZEtXYzFkTWhraEpzbjJSWjRSY2RLaHg5S05JN2dmMFczSXRJM2lTOEJM?=
 =?utf-8?B?bVJsK1ZoeWpsNGwrbWp5elFxaEthVVMxbm9pUmJqdUQ4YmU3bzBwU3NiZTF4?=
 =?utf-8?B?bzR4UHppRFdVS3Rhc2krRGgrSzk2eGs2bW5PTVYwckFzZmdjK1dMRzhUT1dt?=
 =?utf-8?B?cFlqYW9HQzRQY0ppSlJxSHJZd082Z3I3YkkwdGtCU3l1K3lZZDBoREczMXFQ?=
 =?utf-8?B?K2krN3FXVjhiRCs1cXByUkE4T2d1NytFNG5aREp1WDl5RnJXZ0tSMU9YY0tY?=
 =?utf-8?B?UUVncjkrR2dVOWoxNGE4cm1aOSthQ0hQTmV6NEcxMS94WlpCYW1RTlFVTzBr?=
 =?utf-8?B?VFY0dXBRSjdLYXZQSXJNTTg1TUI2aDBqUUhXWklNbW5qc3hJelcyS1ZmZWF6?=
 =?utf-8?B?YzZSSHJSelRzUE5xZS9UUGIycldiWTNEd3E5QmgyVTZScmwyVmMwVzI4TDA1?=
 =?utf-8?B?dVN1MkdHV0N5RzJHcXF4dVYxNUtOM2ZqY3B6TVgrN3dsaTJUQWZ0cFJOQk8r?=
 =?utf-8?B?WlNZNkZHOW5ON2ZjL2taRmkwUlZheVpqRjFRa0RRejBrWnY5V2pRNTBaTTBu?=
 =?utf-8?B?alZpOHFJZE5IVGcyQm14S01vN1hFOVEwS0VLcHNCclZmdnV0bUR5VzJDUlR4?=
 =?utf-8?B?YlRXRVBLU1pYY1lhVDY0RUYvQUNMWjJUa2xMZUloeUt2bU16bnZPa2JUVGlx?=
 =?utf-8?B?SWpOQXhHWFkxSjhpV2JCRk1TZzhsVDd0R1crMjc1QjlMUWlhUEIxdDdZeEo1?=
 =?utf-8?B?WUpTcUhWakkyeFE2SGFNbTd6R0QybC9KYXk0M0JQTis5MU5nTisxUzBTM2dG?=
 =?utf-8?B?VjlMT043ZVMyMXQ4NGoxQTQrS2poc2cyOXVXSzlEZll4QmIrRUI2SzNER2RO?=
 =?utf-8?B?eWJyQlU3OUhMSUxNNDdnZ1QyUTU1cnRSUFJWYU9iNmtDUHI4V1ZZSnRVRTQz?=
 =?utf-8?B?T0MyK0lNVkxabGV5WFE4N2xzUm1kU0JsY1lmeHN6K2pKNFRyR1k0clpldmty?=
 =?utf-8?B?QXgva09LdHF2cW9iSFJEQ2Rrd2lkVDFwaXY4ZUxzWk1tc1p5NXZ2WXpPbm5a?=
 =?utf-8?B?NTlPQ0tTRzltUi9GbFR1clBMZXJkOG1LeC84N2tsb1FWTFc4cFVORWlDemJq?=
 =?utf-8?B?UDBIY3BhUmh6cExFZmJ3ZjRpQmJRc243dVZ5cW9rdWMyb3ZzQXp2UytmM01H?=
 =?utf-8?B?M1d5U05nSzByVzhqV0tKcGhxc3NPaFZWTDg5RTR3MXZ6b1ZUV0RqZk5KNHhW?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe26dc1-37eb-4c54-fc7d-08db6c85b5cc
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 03:16:14.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+mVWpnMGZpw4BX3iB5cWg6JhwdjeabpuzhWuUwQR4jV92E63DWO4iKsiximCDWv0+jG7AE+aJKWNapyEfsAFJo+6IcQu8dSjQU/uxh57Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-Proofpoint-GUID: 5bN4YKJ108jfwUOQzLhbk-wkv2y_HBb1
X-Proofpoint-ORIG-GUID: 5bN4YKJ108jfwUOQzLhbk-wkv2y_HBb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_24,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140025
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/23 6:33 PM, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, May 04, 2023 at 09:16:02PM +0800, Xiaolei Wang wrote:
>> The device may be scheduled during the resume process,
>> so this cannot appear in atomic operations. Since
>> pm_runtime_set_active will resume suppliers, put set
>> active outside the spin lock, which is only used to
>> protect the struct cdns data structure, otherwise the
>> kernel will report the following warning:
>>
>>    BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
>>    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
>>    preempt_count: 1, expected: 0
>>    RCU nest depth: 0, expected: 0
>>    CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
>>    Hardware name: Freescale i.MX8QM MEK (DT)
>>    Call trace:
>>      dump_backtrace.part.0+0xe0/0xf0
>>      show_stack+0x18/0x30
>>      dump_stack_lvl+0x64/0x80
>>      dump_stack+0x1c/0x38
>>      __might_resched+0x1fc/0x240
>>      __might_sleep+0x68/0xc0
>>      __pm_runtime_resume+0x9c/0xe0
>>      rpm_get_suppliers+0x68/0x1b0
>>      __pm_runtime_set_status+0x298/0x560
>>      cdns_resume+0xb0/0x1c0
>>      cdns3_controller_resume.isra.0+0x1e0/0x250
>>      cdns3_plat_resume+0x28/0x40
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   drivers/usb/cdns3/cdns3-plat.c |  3 ++-
>>   drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
>>   drivers/usb/cdns3/core.c       | 14 +++++++++++---
>>   drivers/usb/cdns3/core.h       |  3 ++-
>>   4 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
>> index 2bc5d094548b..726b2e4f67e4 100644
>> --- a/drivers/usb/cdns3/cdns3-plat.c
>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>> @@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
>>        cdns3_set_platform_suspend(cdns->dev, false, false);
>>
>>        spin_lock_irqsave(&cdns->lock, flags);
>> -     cdns_resume(cdns, !PMSG_IS_AUTO(msg));
>> +     cdns_resume(cdns);
>>        cdns->in_lpm = false;
>>        spin_unlock_irqrestore(&cdns->lock, flags);
>> +     cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
>>        if (cdns->wakeup_pending) {
>>                cdns->wakeup_pending = false;
>>                enable_irq(cdns->wakeup_irq);
>> diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
>> index 7b151f5af3cc..0725668ffea4 100644
>> --- a/drivers/usb/cdns3/cdnsp-pci.c
>> +++ b/drivers/usb/cdns3/cdnsp-pci.c
>> @@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
>>        int ret;
>>
>>        spin_lock_irqsave(&cdns->lock, flags);
>> -     ret = cdns_resume(cdns, 1);
>> +     ret = cdns_resume(cdns);
>>        spin_unlock_irqrestore(&cdns->lock, flags);
>> +     cdns_set_active(cdns, 1);
>>
>>        return ret;
>>   }
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index dbcdf3b24b47..661d5597fb68 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -522,7 +522,7 @@ int cdns_suspend(struct cdns *cdns)
>>   }
>>   EXPORT_SYMBOL_GPL(cdns_suspend);
>>
>> -int cdns_resume(struct cdns *cdns, u8 set_active)
>> +int cdns_resume(struct cdns *cdns)
>>   {
>>        struct device *dev = cdns->dev;
>>        enum usb_role real_role;
>> @@ -556,15 +556,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
>>        if (cdns->roles[cdns->role]->resume)
>>                cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
>>
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(cdns_resume);
>> +
>> +void cdns_set_active(struct cdns *cdns, u8 set_active)
>> +{
>> +     struct device *dev = cdns->dev;
>> +
>>        if (set_active) {
>>                pm_runtime_disable(dev);
>>                pm_runtime_set_active(dev);
>>                pm_runtime_enable(dev);
>>        }
>>
>> -     return 0;
>> +     return;
>>   }
>> -EXPORT_SYMBOL_GPL(cdns_resume);
>> +EXPORT_SYMBOL_GPL(cdns_set_active);
>>   #endif /* CONFIG_PM_SLEEP */
>>
>>   MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 2d332a788871..0f429042f997 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -125,8 +125,9 @@ int cdns_init(struct cdns *cdns);
>>   int cdns_remove(struct cdns *cdns);
>>
>>   #ifdef CONFIG_PM_SLEEP
>> -int cdns_resume(struct cdns *cdns, u8 set_active);
>> +int cdns_resume(struct cdns *cdns);
>>   int cdns_suspend(struct cdns *cdns);
>> +void cdns_set_active(struct cdns *cdns, u8 set_active);
>>   #else /* CONFIG_PM_SLEEP */
>>   static inline int cdns_resume(struct cdns *cdns, u8 set_active)
>>   { return 0; }
>> --
>> 2.25.1
>>
>
> Hi,
>
> This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
> You have sent him a patch that has triggered this response.
>
> Right now, the development tree you have sent a patch for is "closed"
> due to the timing of the merge window.  Don't worry, the patch(es) you
> have sent are not lost, and will be looked at after the merge window is
> over (after the -rc1 kernel is released by Linus).
>
> So thank you for your patience and your patches will be reviewed at this
> later time, you do not have to do anything further, this is just a short
> note to let you know the patch status and so you don't worry they didn't
> make it through.

Can someone help review this patch?

thanks

xiaolei

>
> thanks,
>
> greg k-h's patch email bot
