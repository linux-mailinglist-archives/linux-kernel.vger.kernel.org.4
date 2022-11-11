Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81162513A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiKKDB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiKKDBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:01:55 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745A165A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:01:52 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2x4An031421;
        Thu, 10 Nov 2022 19:01:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=npN8b12L6hFl/ehqHyArucGRNQufY2gYCtTlkP99by8=;
 b=E6Z6Oyc5PV02rqAFGovYOTnh+FoZ1GuHyImBUh2/PN20ApIjRBQ227Vs7Ciidg7nf3Eu
 QW8M3JkErgS6w1wUjU1HzxCa6nZKf217sKlmOoLfgIpacuWmwKk6e4CK6NfPx30+BCsY
 eebtiyy9pM9p6JrGIQFpMFai4CVfCgWF6vr2+1ZnRjloAmQjph+O5h/jkr0aCy0bC3MP
 gyV7Elgoe/1BW67FQhVDD1CoxnEt4N4sXQ2JTLiXmns73uDOZmMl3s3oqS1nYdL2dxCF
 vKrzcdRZc1kiJCpCm75DIGF1+GnJgM3gH9zPlI1cVtYPhOyHCm+kLw6QmUhwTr7M9ug4 dg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3knqbkn2ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 19:01:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g46HS8S5ng2QkrlnJbxTw7FgkQWAYgFjDamlikLNqo7LQQx37P7Mjy2UMVqWj6ZMpMxpSCOAnpNXd7wab03s8K79898ew57y/Ym+1z5e77uH5FyZoNnAFhhGfLOaJ7bFuaptuh86Q5b9PsEzFmml8vocBSX2QQreR8lG3n3zHXijKaDjWPhdmU+XnwhtU3NU7XfUMjUdU0LWCmSkXvxxoNo4AUvboXe1/Uuf9Yg4AAovRKBL7LTbBMsovwHarz68QqqcYvtu+c9k0r9fNJ7Re/KTceHBFE6uoPVivA3Zvlf+JT8JVlm/F4D6gy/A94KtfGW9N/2Ixp6Q1C/igzCjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npN8b12L6hFl/ehqHyArucGRNQufY2gYCtTlkP99by8=;
 b=amPqfjwCJ42CRuDKm/CPdkFK6CzLXOVTFXz6CVa0xi6/+vpHehMDr7zMnWPRXofOQAxHWVjXII7F59iwUuy/uAHxHkfVGlTwG0wCzz+UVLJKoHALUp9LPeY9L6HhAqH3YJ/v4raoXSWOdpdNnmR64xkweL+gYBo2r0i/cqiQAnEsiGi/oT0NBJFtAViNasYMrcPF6VGpGfqaoYT9+UemUWKp1OixMGDJykxbqIkSA1Ul7NBesPhhnCNoWzcRNhZfkmvVHE2rU1soKqxaXMBHE4cGp2dZTJJ26hzmFh2kdIAm2dy4VR5Um3lSMOEnPdoz81Jw1NBY+LPXTU3RvAcxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 03:01:25 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::d789:b673:44d7:b9b2]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::d789:b673:44d7:b9b2%5]) with mapi id 15.20.5791.024; Fri, 11 Nov 2022
 03:01:24 +0000
Message-ID: <f0e35731-07df-bd80-329f-a5ad9818e1e8@windriver.com>
Date:   Fri, 11 Nov 2022 11:01:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] soc: imx8m: Increase the clock enable before reading the
 register
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
 <20221111024607.GH125525@dragon>
Content-Language: en-US
From:   "Wang, Xiaolei" <xiaolei.wang@windriver.com>
In-Reply-To: <20221111024607.GH125525@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0194.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d025ae7-fb96-4281-c0ea-08dac39104ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICLzcEBmSSZ+cYvkP4HbZ0mAHBRKmSpMAe7knfquLcKaqXJiJCSvG6tzgI3pSf9LdsMCo6sKXTvifHMIY0mH4M42KrGlsQ40ThrWLQINpIscxXC1JnWbbzR2dL304TY+owBRsx6byr6Wu10ZIq7pGzDHoJdD4ZzMAvty0w///9Upzes7uEK/gf54lYC0fuuymSSni2FoKB+obclD/Nf60Kslh33xopZPe8tBcXcF2j8IjQGU87ZvTdKxtstbnkmBQ0GZJtAtjKPAjO1gI+0qYJYTMOhqLJgj6Rha/JknGnRTn5ygAF76/SH8dHXh8/w8gfCpmH1mfZPYg2srjvevse8N7bBADmehklbb/dembJ2IppKWNphWWLmD0TkA6+azuXaA+/bNvPADFCKcXBIDjVHawNEVMKfxXZbezmUoQBERi4ITTFPS478/ZIlcBciBuq7GjsG0Rb4a8J2oeOZ4aTm/Z2Z9H+s7ks+qMJEnPyiLfp5GjTV32tmxT+dCrok8M7/lqCIvwdoWUY/tmOwYBeH+U5RwYL1iqbpWxGdZWV6xmxsvwUkoCWpTqD4mr33KaCiCxevsh0DSkDUUGb3VPW27wZspSc110515w5pFvVG4Sn5B0OSf9gQj0sBMxGMtI/miQDh+q5EGz7cqXEUx4jBJ+5US7h5K5It2DpH7F49gnj1E/jsTfy67fQGlzc4ro4F8z257BuFcrtu5pTzCG5ClLBO/XjVWFYIqdzb6DMCsfnW46pOjJP2Msm5glp3b0E+zfJugvVGZjKGB1NQy9fGhRPfEv5fep3RvL2zu1b1G+VelZc7S4Mn9MXJukGU1t+i7E0KJX2QOGZ8U0QHA9FP/LiBsoryePnsIwHJdZ3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39850400004)(396003)(451199015)(31686004)(6486002)(38350700002)(38100700002)(478600001)(6666004)(83380400001)(316002)(6506007)(6916009)(86362001)(31696002)(53546011)(26005)(41300700001)(52116002)(66946007)(8676002)(66476007)(6512007)(66556008)(36756003)(4326008)(5660300002)(186003)(2906002)(2616005)(8936002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlxcEdqYzdUM0xVeVBwSkFEaXIxR3hvMjBXc3BnTWgwakxXaGpUUDBwRXZ4?=
 =?utf-8?B?eDZ3TmgzMkpRV3BGak80Q29keENvalhmaGdYcWUwbVBHZWJmd3dUWEVYR3Jy?=
 =?utf-8?B?V1VjZzk4SVMzVWZjRkNWb3NZNGRjWkw4OTR4cld3bEtpa2JaT1FHL0FLTFdZ?=
 =?utf-8?B?dVJxRlR3QjVpRHJ2c0ExcWxlWG1kVDBOUVlERm9ZWTdUbUVVYWJETE8yVFRC?=
 =?utf-8?B?SHBQbnF1Zk1UNkp5RkdTQlRTeHdodnRCSjNpM0QvK2M5NStKYzVEV09UNk05?=
 =?utf-8?B?Ym05MFFHSTdQZFc5YnlvcERzeHBaZzdYdGRXVFllNHRZVmdoK096MG1uYnlv?=
 =?utf-8?B?WWhMaUgxekd2aDJrNzVLZkpJb053QzFkS0hxeDdBUU1TUE14aUFWV2k5cXdI?=
 =?utf-8?B?YTlyYTIwTmowYWIwWDNvTHNXRzBMVGphRmViUEZRNm9MWklxMnFJVUllNDJG?=
 =?utf-8?B?TGNOUGJBQmtJVUhvYUloODhZRkQ5SENja3RvakJER0N5Tll0WEFMc29iMEk5?=
 =?utf-8?B?STBnVkJnQS92ZUdFRlZJRjRnVzBFTXpIOFdGZUlzeFZiYlNDZk9Nc2RucXVH?=
 =?utf-8?B?ZU1yVWRGMkxFKzlpRlVNTVhRaUs4MU1NMmFJWU1BUFZCZDNaL05GQUlEdmpw?=
 =?utf-8?B?ZmttZDRtVVYwNWt4OTZuTWhpK2JLQ0FnSWJOZTQvTGp6ZFNTUWRuSEZJS3g5?=
 =?utf-8?B?b1daMXJCcHUzVTh4SHo0K1ZhR0xxWHEyRHpCKzN5Ym50SUgwRDE3RGpSNU81?=
 =?utf-8?B?SzZsZ3UxNkZGMGNDT0VTK1lCc2xvaTV0MEJQZGgvOW51TzYyb3A2QmhUNVRS?=
 =?utf-8?B?YnRvVWpGTWg0NUVWakJWNlZKdUNLaElWSWVIY3ZpbUswSUQyeU1ETnI2TFlY?=
 =?utf-8?B?RmRiU2RGYzNoUGdtb1ZyM0s3OWFHOTVaYzVvYzV4ZW4wUjB6M28yVjlBYXU0?=
 =?utf-8?B?RUJ2c1g3OFZDYzZXY0ZKMDd6ZSsvL2UvYm1DK3NZcXN4RVBLWXVIRVBjUW16?=
 =?utf-8?B?cXlFZXBTYmVsb05VWEkyQjFvVGQ0eVNmNU50VzdFZHlFNHkyOUhGTEd0L3V5?=
 =?utf-8?B?QVZ5aW5ld05XUW9Fdm9IKzVMSHhyUmJTZ2I4VzRpRytMblBiQVZ2S3NpQ2xy?=
 =?utf-8?B?QUMxVW9XWmRoMlpVZWljRkpmM0d4UGdUZGVGMnJyS0M2TXBzdDk0M0pSdWhv?=
 =?utf-8?B?YmlRV0dZZXJYS0FJSFNIcEt5N29LZnFtYmlPd3NHWi8vWmZPMnljWXdUSEZt?=
 =?utf-8?B?VU85Y3d0aStwQmM5SHgzNWg5VS9BckhrR3YwckVEVE0zc0h2Q2JXT1gxcThS?=
 =?utf-8?B?dTR2YitnbmdIL0dBbTMvaXRsVy94aU5xaWwrK1kyalY5ajlHSGp6cFFZM3BF?=
 =?utf-8?B?YUI5RHVYbVRpODEwTDNoMlMwOW1tNTVoYkdYMDVxczVBQ0p1bjZYbFFMU09C?=
 =?utf-8?B?cnM1OGFFWHZ5alJMUE5WUW9CQ2tNVlFXRU9UVzVIVE1mMTNJZFE5THpUNTF5?=
 =?utf-8?B?L2dNNnV4TE1hWFdKSFdOQUFVNGkvNkJORXdnUDlYbW9aL3FJV1pldElSQitm?=
 =?utf-8?B?T09ueWZFb1NVYTRhQXJoeGFmenFaYWJ6RUhZaTh2RDQ1dVBJOE95VjJ4RVdJ?=
 =?utf-8?B?T3ByVG53amdlcFpTTnlqVS8xK013ZXhOUStvM05OZ2s3bzJhcmFiVzZjUDBi?=
 =?utf-8?B?Z3JtcXJ0K1pmSXd2YXhuTGV6TFpIbXFBZ2MveGMxSkVUbXV5WE9TL0JpSGd4?=
 =?utf-8?B?bG5jakN2S2NKNW9XVVZham81RlJseGVlZ2VZMittampkbW9mNW9JRWlTUW5n?=
 =?utf-8?B?amRDUHBRT3IxQlI2aE5ZZ29hOW53RVIzbnF4RVhEVkljNDdyc2JheDVIN3Zw?=
 =?utf-8?B?V3g0R0g1YXVtbldnT29wTXRDRzNXSDFLcVJnM0g0a3VsYkN4aDJNaE1LS2sx?=
 =?utf-8?B?QkY0RXoramJQbjgvQmUxbzRhY21BL0ViRE1adHg0LzRoMEdPT1AvYU1XdnR6?=
 =?utf-8?B?MU9EdHpWRXlvNmg2emVpMHZBZDc1UEFQR3ZMTlZCb25qaFl4Uk5wdjJHa2hC?=
 =?utf-8?B?NHJHcm1JdnBEME9haXNDcDMzZ1d2OE5PS1FMbTMvNVhsVWlLS2VPdHBjMWg5?=
 =?utf-8?B?b1hPK1Z4VFRZVFltV2RPRlhiOVVNUDhTS09XbE8wTUhNUXBFLzNZT3JSOXgz?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d025ae7-fb96-4281-c0ea-08dac39104ea
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:01:24.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztTuTDwLpw0Blu8U6Gr6zdk0MzpAFTDICCF6p86yELVXMNkwAJVYQCI/cC7rX3zPq9h4ud1TanYlVG9IniePtrjkXdGk5IxWGIJYTSKWPW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-Proofpoint-GUID: haLEHGWS8RWyDU3Kgai82Ar_I5h3nFee
X-Proofpoint-ORIG-GUID: haLEHGWS8RWyDU3Kgai82Ar_I5h3nFee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2022 10:46 AM, Shawn Guo wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Oct 28, 2022 at 12:14:18PM +0800, Xiaolei Wang wrote:
>> When executing kdump to start the second kernel,
>> since IMX-OCOTP has turned off the clock, the clock
>> needs to be re-enabled, otherwise the system will hang.
>>
>> Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")
> Are you saying this fixes a regression caused by ac34de14ac30?


Yes,

Although there is a problem with commit 7d981405d0fd, it also solves the 
kexec kernel hang, commit 7d981405d0fd is reverted, and the kexec kernel 
hang will also be introduced, so the clock needs to be enabled when the 
kexec kernel starts.


thanks

xiaolei

>
> Shawn
>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   drivers/soc/imx/soc-imx8m.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
>> index cc57a384d74d..28144c699b0c 100644
>> --- a/drivers/soc/imx/soc-imx8m.c
>> +++ b/drivers/soc/imx/soc-imx8m.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/of.h>
>> +#include <linux/clk.h>
>>
>>   #define REV_B1                               0x21
>>
>> @@ -56,6 +57,7 @@ static u32 __init imx8mq_soc_revision(void)
>>        void __iomem *ocotp_base;
>>        u32 magic;
>>        u32 rev;
>> +     struct clk *clk;
>>
>>        np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
>>        if (!np)
>> @@ -63,6 +65,13 @@ static u32 __init imx8mq_soc_revision(void)
>>
>>        ocotp_base = of_iomap(np, 0);
>>        WARN_ON(!ocotp_base);
>> +     clk = of_clk_get_by_name(np, NULL);
>> +     if (!clk) {
>> +             WARN_ON(!clk);
>> +             return 0;
>> +     }
>> +
>> +     clk_prepare_enable(clk);
>>
>>        /*
>>         * SOC revision on older imx8mq is not available in fuses so query
>> @@ -79,6 +88,8 @@ static u32 __init imx8mq_soc_revision(void)
>>        soc_uid <<= 32;
>>        soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
>>
>> +     clk_disable_unprepare(clk);
>> +     clk_put(clk);
>>        iounmap(ocotp_base);
>>        of_node_put(np);
>>
>> --
>> 2.25.1
>>
