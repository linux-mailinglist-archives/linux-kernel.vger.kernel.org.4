Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01920699382
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBPLqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBPLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:46:24 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9557773;
        Thu, 16 Feb 2023 03:46:16 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GBk09b026027;
        Thu, 16 Feb 2023 03:46:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=t5DYf7kfu+KMxgNdFFZPBYuoQLbLANjgWvQbrT8ldiI=;
 b=TTz6h5DoKcw6Ek+nue4gnaq7Z1rIlH0UjAQnNnGpDL9xaYnwzQQXSl6AY4tXZCG114rJ
 Db5reyKGFqx7pirRJua9RxIxDHaB6ZaCL6Y5Mx/fKm8XeMi5htt5YNO6yxAKINP9EExq
 SRMSHcZvjl+aysBE9QbcQkPLUi+T21RZjsNQ8z9mHKCOmwRf5n6RPvhDevzimeIIRSEr
 garLDjYBJ5Dsar8aganJk0rys5fM8A43aAG22GZxABU3oJS7RhUJQ8VfZo0pLuKMSOI/
 Ouj5Ef0TPzFofyht5opCRcZ5qSazBXXSxMXyb8ivRwHRWNrHJp5/ciLK65thuI2HgkAw zg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3nsc110b51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:46:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI4H91duwrBdjdPTpye4I9/6enlFeazm75DKxmrjw+YhX2x9ocjA6hWcz4scqPlxRY6iSFDSPFaq6F5xq7NHwwBGf5S869ovkTZcHMstCLYD9rSF4B4+cuC+9uLdN/bFHyePmkOgxPlMJuilSVG92qr0ZlYPxgcReSyUT0kc4qBEabW4rJzw26DWioos1+zmGmEGABw6EWAdsiPkkwWp0XVqE7YCqa6YWN8bAWR9jiApNbfz0ccBWzaMzeZtraWuv4EutpKVde0gCyGyvczbmhsHGXpR/cHuWS9Fpe1ODPUT6YTSJLjzxVoDmwsfboIUIlMRv0El7bGO7qus7X8U6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5DYf7kfu+KMxgNdFFZPBYuoQLbLANjgWvQbrT8ldiI=;
 b=CuZgUT0bQFjhWXmi+zi5JZD4Ae1YGWwAXHNKJsbWHP/UpGXpgxtygYbeSmkhXoeoJNiRtCN94WJf3R+MPQYmH4yzd7JWNNSFGxPykxpigF90sE/9QOojNRIwjbr4Fy4QNtPs5Ko1C177NRZLL36Xu3/tYQkhSju5KKhkQWFhes7fN0a3FSsQdY2ElaibmvHX1+2IdITCkSuoIowvf877XfCna0jN2j36AEm7OC+pwDonlIf4g+2zbrgemX/5g5n1IJ9OEVgm5PzY12I4P+u51EUveduwk75/24RhjEvbynf++QaxIXcY6UcbEAsbjaV22t/6b9JZok0U02M0Szip3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 11:45:52 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::d4bc:86a0:7a8b:3899]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::d4bc:86a0:7a8b:3899%7]) with mapi id 15.20.6111.012; Thu, 16 Feb 2023
 11:45:52 +0000
Date:   Thu, 16 Feb 2023 06:45:48 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Kaestle <peter@piie.net>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acerhdf thermal question
Message-ID: <Y+4XbJR/WxCyN0EK@windriver.com>
References: <59c24c3d-eb1e-cdee-3d2e-aa1dda5a96fe@linaro.org>
 <ee826228-3fbb-bf66-b2a1-8e8be2776175@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee826228-3fbb-bf66-b2a1-8e8be2776175@redhat.com>
X-ClientProxiedBy: YT3PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::12) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|SJ0PR11MB4798:EE_
X-MS-Office365-Filtering-Correlation-Id: f9547db0-44a5-41b8-7983-08db10135adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCKCl/ekZ/Yw1Yd3TUs0vOOMVga1Xpa0MCFcBQ360r9v3iDqzQix2lgyP/MtjfXgC03pMhIygyXsLDoeOFuJKEkBjysLJte0EsIvsmCoM6DE2wVk1XqKuerK3LjhOXR5o8AlHekG7hgo+3FN4n0xa0poMc9CGD9a7haLyvvkN7KtVNJ1+/EC8XvxQ3k3+HzHLFfKIPxF7Q89SPFwYBBj8Yw7urZKXnps80gS4kZcrWak7iEG5wqN0cwLi0H587z1rRqgBMyc12BmNgjA5AA8fIVZgiJ1nVtrxMO0bFddQyR1KVR1h2Z2Z7EijKfBr5fvko82giGFHDZ8dAc1iQR1VD1BQRMDS7DAotiu21QOc+UWMMCAjoea5tgWzMthMJHvwoee+9kK2owI7yMwT/JYNE3ZOvmthz2pryA9AfQoWHTdW/NhKNk4V2rVO+E+TGEL4Z2h5HlIaZxDG9MH6l1KuqH/nWXdTfnNsxl3a5/cGB4wYHOrfSa8Q5qySay8VsLKABbErkhrpz2pmQOlivVsYCFvbsV+iMRaUXgjE4jf9J29h+iO1Eo+FlitXm2wDQ9DZjEcNBxP1EtRnBvNBjmsmZES2hYrfDiUMuWaB5TtN6XCyGx083WBoP0WxAos0bITi8tkiqvpVj363R5/Gjx0Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(451199018)(38100700002)(3480700007)(5660300002)(7116003)(316002)(6486002)(8936002)(478600001)(41300700001)(44832011)(2906002)(6506007)(6666004)(6512007)(53546011)(26005)(2616005)(186003)(36756003)(8676002)(83380400001)(86362001)(66476007)(4326008)(66556008)(54906003)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A2WMp3qHHac5EOnAoEi5mNbN25EuBIHA0QDGy/K5Jz3RiBkn+BndDNo8b40V?=
 =?us-ascii?Q?EBV37zgalupWbR0TsJpeyemhHbtcQmCi6dzQRhJwJ6z+IUJmdVFZsffyomef?=
 =?us-ascii?Q?flKgztZfKX/dMTbxsWkz5o+5+TA6GPTlw7W8JJEuYVmtoB2VaMlsqYLbjUnS?=
 =?us-ascii?Q?/6CkPnjOhCshV7cZ92OlHvQvpGoepnOsnfpv47qsf7i9TLbjkfuqwWYlN55t?=
 =?us-ascii?Q?yMZBnYOi9IdTAOEbbJcwS1cthPvMShfYZ3ZQRjXMSP4cFYDp1N9H8Zx4sf9m?=
 =?us-ascii?Q?SqlcsEiPW38+w7B0c46Rt6FSDT921+FT1PbHfVG/mTTWxGrrh+MZcjrxWg1c?=
 =?us-ascii?Q?nQfeCFNJolZPA9ml3qrdJXuWr9/J4Ir0dCFu2iR9UpM/yFBn2c3BPZRjyA8q?=
 =?us-ascii?Q?CN6H6Xj5VDkJfIg5YcYoalpzPB2gvXc/2LVe560lMr8aFMPnU+H6/VAvhLH6?=
 =?us-ascii?Q?DjJ87criEadNfzkXDx0YUcJ3JHkhNMPOs4+/iKLdTXTx3VqwFSs9mRMFP3+i?=
 =?us-ascii?Q?rsVlHaaFbHi41MartYv5ZmPOkx4meR+uPleyT0jxsSZydpjdLTNF47K5dUHZ?=
 =?us-ascii?Q?TgLJv4oKUm50PXVLjl6QW8fDobw8iDzXZosBCwKK5txMkoJW2vr+V+hgicPw?=
 =?us-ascii?Q?q+uTwSDnyB8QQ4qhtYbYp6x5273dwTv15dmIC4u9DiQQxUMtiAuHo2d8ddY0?=
 =?us-ascii?Q?VlmwlZxbsshiEDH2X4oj9ikQhCdH4T/o75WboYhGFPmAy7rBvnvhaUyNnsCx?=
 =?us-ascii?Q?xv8y9nIYxb8TMl9CCtCLXv5ggfHR0bs4Tgtn7QUUQ7gc7hQnPFjgOLVrBVxN?=
 =?us-ascii?Q?O0gYTwYLV94LkNW9cViyK4f/sytk8zRTbCnVecleZ9tAFHGduPZxawC8WIWI?=
 =?us-ascii?Q?qL/80mBhJ8Vqg0k/zX1X9tcdWmgabwGoJiQiS979OfuJtNIDxO9X2CEp4H3h?=
 =?us-ascii?Q?nZH0S1nkziPRvTNIG8Dgdzp8PNhGASyO5cCIk+lOE/d1hHRUpkTwjXkB485G?=
 =?us-ascii?Q?nMnIYcMbf0ju5bOk7eXt6aJWO0DifUU0i3MlSeR+JuKJo0ejosQ3JfYOiWq6?=
 =?us-ascii?Q?5CPZePuRQAt/J8JRlnv/j745V1hT+CF8hO5Om9LqCm5VP6osmrFX41NnGMAn?=
 =?us-ascii?Q?ExQy25o8nOWrhTRq8rH+GAwRGY3kjX0x701TiGAJsBHxlEiRr2/vCEKH45at?=
 =?us-ascii?Q?qZehaLdHLi4RWKzdaPnEuK9/Z+pYlIlCd3skDsCF0ETb7YYeBQ8qn8MUYP2z?=
 =?us-ascii?Q?oCFW5cfeaIkA6arj9PofQfxJdW+ivDmVXnmcq51fqnlxBkmLxuZwb//Pt6K4?=
 =?us-ascii?Q?PPj8HjX5zB7Le2keNBHn6oZSJn/00eAJmUAgkaj2jEoNIEBDXq5sObrIH+er?=
 =?us-ascii?Q?jy6TYExn0r0IYhyXke29yvfWPympHuk5OcowSibrerdeycayFAR7MGHAPUU4?=
 =?us-ascii?Q?/gkKzw0vnc1OZ5X5ONKtaI4wBjrMeqbderJJRLeSNOINrAWcQ8t1XV1jgYIr?=
 =?us-ascii?Q?o4x062i6YXID8AiN1+0fht21kV8N4l4lvv19rwwfcD0r8SHH9dCCYF6HnizR?=
 =?us-ascii?Q?csbyv1QLypFpKPf/g4XGYrBXsiOelXNvXRfVP3P5PoEEYX+XLeH5pnp15G5K?=
 =?us-ascii?Q?+DkNeNDyLX0hP1L/C5yulBQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9547db0-44a5-41b8-7983-08db10135adc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 11:45:51.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2FauYRAXK6ecawaupblNK0xbMTZ3asnACq2XL7f5Xp3SQeMxAYcudD4tOipRdZpYf8EzzcA+95BimG6lX2rCX+L2K2e6HipudJixtRPDQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
X-Proofpoint-ORIG-GUID: W1TNLKzjYjwV4wGBz6UacjMbR2LlRgat
X-Proofpoint-GUID: W1TNLKzjYjwV4wGBz6UacjMbR2LlRgat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_09,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 mlxlogscore=530 clxscore=1011 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302160100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: acerhdf thermal question] On 16/02/2023 (Thu 10:08) Hans de Goede wrote:

> Hi Daniel,
> 
> On 2/16/23 09:57, Daniel Lezcano wrote:
> > 
> > Hi,
> > 
> > the polling interval is specified and modified via a kernel module parameter [1]
> > 
> > The value is used to change the polling interval of the thermal zone, implying that is accessing the thermal zone device structure internals directly [2]
> > 
> > In real use case, is the interval changed at runtime? Or just when the module is loaded? If the latter, the interval can be passed to the thermal zone at init time without doing a polling change rate after the thermal zone started. In this case, we can remove the polling_delay_jiffies change in the code and fix the structure leakage in this driver.
> 
> I believe this very likely only is used at module load-time.
> So the changes you suggest are fine with me.
> 
> I have added Paul Gortmaker to the Cc, Paul is the last person
> to have done any real (*) work on acerhfd AFAICT.
> 
> Paul any objections against making the acerhdf.interval parameter
> something which only works when set at boot / module load time
> and removing the ability to change it at runtime ?

Not that I have any real authority, beyond "touched it last", but
that aside, I'd say that if it is blocking other subsystem cleanups,
then by all means make it load-time only.

It was already obsolete hardware when I was tinkering with it, and
to my surprise -- that was already five years ago!  There can't be a
large user base out there - and even less tinkering with poll delay.

Paul.
--

> 
> Regards,
> 
> Hans
> 
> 
> *) Real as in not related to keeping it aligned with the thermal
> framework/core
> 
> 
