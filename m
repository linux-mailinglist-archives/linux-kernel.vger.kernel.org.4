Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2268F5EDF13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiI1Opk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiI1OpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:45:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622488DDA;
        Wed, 28 Sep 2022 07:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnSfhwr1izJTepmBwKoPCTmMiZzz7VljR53RVyuNeT9e1RomMPLNpQ+swxa0UV25WHOCVRZ8T5mv3xJjQ1uuOkwyhH41D4yKbX9JkrUITkU25gbsOIGPiY3lbjCTPea+FdyF/4bUShGncN5WnPM6jLu92OF5RqNocwPLIBEaeAikNrm8r8V4b17a5pew8kJtInUpFVU6dDQx5FePNhHkNHvLEd0ghckD2zQPlk0fkMWsFC209J1fensSK/xM3WzqSDw4xAOKyutzQw6+6ox6rubE0NTyjnh/SgOyAaBI3gYOE8VPE1k3IFWJEdKYVP9MH9zylFwdSz8EqfqO9Oun5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsBAAlqAcFeXuFfhEGXw4s+953yGO+xMnYx7JtfD2cU=;
 b=WaI6jzbMnGGDeiJAdp4xr3jSLIEYVwHUwIJKOCNa5u+vEzinalgTUF1plxuxPbYzmBkrbQM/lP6V/cjgrHizRDl+M4VFc3oB6+wSHB2jPFJbNgmJxD1Ts6oPPXQMGb9vY/Fgdw8DKD/Odn3ljDgW/bdZMRxLwSCXpO5IVYdsqt361im8CyAnE3XWQzrCUCrmgFqSQ3EQcfOWTPWxnZmpZjoejSsmeQrAumMvlH5xIllcFjerWHruf9mfp+pDACn/Wsxss1s7bj1G6meLU3H6DMa1Y8EDDhK5FBZ0N+YzT1Jy4EpFv+SNgMnSlNCXkhGxxwbekjce7vQU7FR0HPGhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsBAAlqAcFeXuFfhEGXw4s+953yGO+xMnYx7JtfD2cU=;
 b=UsXb3kpFM44Vd/4/Z8k1JNLNWlZuG4I7EkoLgllHU5LeiY7lg7oVNljfDmKAMpxHxOJS2N466eaRRX0gxTblOcOlA0TMGJY2VyWdnQoO3MRS8TlkaLoQAJ2AlKG+LmTrIwWDdZ9q7/TgyqtFx2XDesvJX6JkxQXkipo5SapOfmq/mpvKm4oUzH+q7VU7ktMhNC/e+QOJnQunEHtAMyOV+x2NG62nFT38jaaLO1WT85PYLsOclkoRDOhbb7YJWbd+QGfy7oLQtZgrvsBc1BUMxLVF35RrFaSsIQ2s2Hht0zHL7aAT48rknTrINShY2iGA9td2t8CSgg2hyabRlUtDAg==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 14:45:03 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::7940:4aca:1c44:40eb%8]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 14:45:03 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Sanket.Goswami@amd.com" <Sanket.Goswami@amd.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Thread-Topic: [PATCH 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on
 Tegra
Thread-Index: AQHY0zyLsV8S8CEBhECRiwMjQ26pFA==
Date:   Wed, 28 Sep 2022 14:45:03 +0000
Message-ID: <PH0PR12MB5500C51341C9F412C0045019AF549@PH0PR12MB5500.namprd12.prod.outlook.com>
References: <20220928131615.3286936-1-waynec@nvidia.com>
 <YzRQBEeLorfC8KAL@kroah.com>
 <PH0PR12MB55004C29C12FA17B9767CE98AF549@PH0PR12MB5500.namprd12.prod.outlook.com>
 <YzRaQEyByzqwt2y+@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_|BL3PR12MB6452:EE_
x-ms-office365-filtering-correlation-id: af618aaa-efdb-4581-8d79-08daa160072d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTEwVmsOHNdP9PeRTLKU/NDhtzM/k3BE2n+xM5eXJ/3Rl2UF7Lqvos9aJgq6O5lePnjS6IYE4gVtmBwAe8riv7gNWylsGFBnieYDzFhYKLTdcZaluFvoG2jNUja4dBWqU6muccolYwVIllZB4A3FqN9YjylEUGfiT6AN2NNyjAptfQPywK1yHdCFqstU/ataq8oJXc0UmX9NXlTiWKLs1NmCSGA4R9ISPYOCZYw0fx81uMuMXba7iFGtIr1kn2A7KnTDqUQzklKQJp20n9F3842mHNMqe0/BEJij/j/eWCAojaHvsMpWkr33erZGrMuppD2tYYP7hVDGVZqi5VUZIp4rWkuZdv/4Y+pIYU49aDdAWkvFjlYB8ofc+mhoNutWGeCbWnA9NSc0oBj4ZWEBt8a7Y5gFkEN5FRG3uT7bBBiLBQASNbAoboCGhDS2uvXuGbRBeKSd97FH1UoLACO8tqUpKXb54R+d//IanmLkwS3njkxWl30+VBFj9CEBXZblYSPVB9KeiF9VStGl2AVnUpN0inmo03XH42w6HiJHMVc3oLnyU00K3A2gWbFUDd+G2yqL0/hMbcugPHmGAcA4cJqdCuOYNb+z9hDly9Vn0d+RHHmh+37efCsV8uNHk40Hb6fQtlvQvcwJX1mUU0vLhdc4LtZ5zqlVTcB2yDIIZURPEK64LDnu59u9+W5U62PodN8b921QgU0gOHZdZSIepGASIwfGtL80CJUZ48YV0jAu2RKIg2BHOwPncHn2cve+WlPcLAK4HWLW2Xa9LoLYEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(53546011)(71200400001)(9686003)(26005)(6916009)(6506007)(7696005)(316002)(54906003)(2906002)(33656002)(478600001)(38070700005)(122000001)(38100700002)(55016003)(86362001)(186003)(8936002)(41300700001)(83380400001)(4326008)(52536014)(66946007)(8676002)(66556008)(5660300002)(66476007)(66446008)(64756008)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nE54Fj2+lKNSnMA9VmtB1SZv5HBr1Kuobej9jFGGP/buyK6pXyGqX2LipNo0?=
 =?us-ascii?Q?anMGohSDV5cP/RUFsYIPdlFNiQSD/NeysjmAUE1z4UxNp7sv+XL7x22uoj1t?=
 =?us-ascii?Q?EZcKUnTdFgw2ZHbEngL9Vzayr7cBuJIyDAcuG3nm/hsBv1vUSDI3hUwEz9i+?=
 =?us-ascii?Q?9dvSlPqymj8xVdHIovTNUbp0fXjUo7j9zgRJNP3oh1S7pmI8Y7/wrUP+ui2F?=
 =?us-ascii?Q?FCE5YtvmidZX9Tc7ieAVdbPFr24XACs7vPlsK7izPqPQ7u4sEmbAAXGH6xNQ?=
 =?us-ascii?Q?FdLXyJ8WRQ5yhanekwDUkUyuWIKoMVkkpQCJ459CjPKz3ayqBsdpLfDf9am7?=
 =?us-ascii?Q?/iLGBAdW8mkOG2QkNpMilAjGOFhbRAgSgHGWKPWJ7ihlxwsc22G3ITOtCTxW?=
 =?us-ascii?Q?G/4CXHBz0H246EVG3sB26ITRuCkvE4ofjAQOQ9O5HjPuf1D7KhNddC8N7l9M?=
 =?us-ascii?Q?ScbHWhOGhsEuB2LWrcosLrmCXPrLWMtL0MADjlgG4KPD8LJsxSW4b+I9TIaA?=
 =?us-ascii?Q?h+Ov50pzCi4YPMDf3JsXpUA5yFe9aMfHzliJrqjy86Xm2cK48afzFNWCIXFq?=
 =?us-ascii?Q?5CVRxppIacm+OyhuoBGWIFw0hcADUYRPPHAG6ZDQU8kvSBLsp0V0SXQj5ecP?=
 =?us-ascii?Q?17PSY8Ox1hqjDKfSvbbeyOKeiucfWlzsts+0TJMYEaGIMSOdrf3vcUV2IeUd?=
 =?us-ascii?Q?oaowg2qMdZy/ll83pcGNmATix2sufjlNlzpKHkk5s9iz1ab9174qW6j1Qkow?=
 =?us-ascii?Q?OrtU+/B71ODa2DQIQP6SMbPJ2vTAMMdYVgdVp2xsvIXuP/VZ/CTimdkpFywE?=
 =?us-ascii?Q?3Vc5hG8HynT0mLrGXG3PRNUkY82wiEGmFiy/yl5P415VyrhtCMfG8ApP7uM5?=
 =?us-ascii?Q?K9pM4pll69Lbne0bCVO5fdDSnWItpJWwys4oO36YvUt1HSogosxkL9kx0oaq?=
 =?us-ascii?Q?Fqi6UPgXx9oJQL6dEmKr9EAsPWOQM3Uu3bJusx3HE9w5zL5UMuInNd/mr0cO?=
 =?us-ascii?Q?v+zkF3uqIZdowTq3DbBq/1HBqQ9kvPGi5GY0oIMOmpdj7PitLibam67Hdb/X?=
 =?us-ascii?Q?iAGCGLv0a7w+MlkB0+O/k2AWHfE2+AiY5PlUkcdLwqggiD8zsK2qEA1b6u+l?=
 =?us-ascii?Q?oYGgtnH7d7MKqsYGqwjojkedK1nuqYth/5rouvUiIrrlTBHQBtikb56cTz9h?=
 =?us-ascii?Q?7KMk6J4bkCdUzBbxQpZSA1Epy8AVpBl57+9PEuJYGm9F2XDfwxNsm1NCr5n9?=
 =?us-ascii?Q?Ry4t3BQyQElJHhsxxxEMGsDnTiSixwBsfkG6Bxtx0PF7DpObwHw5efzc55h4?=
 =?us-ascii?Q?QEPoT/8EjujcnPTv5o/hKv9CojmVLpoeUMJqgWX2OJXCwHUbuQZWM41Vo7yf?=
 =?us-ascii?Q?hlzdlQaJGNcXVmwCY5GJdw/EY3kOHaErcpVYSepMu4YyjVHERzEQSgD4Ynby?=
 =?us-ascii?Q?PwJTs6/SgxSDAaFfWbF4ZeOtttTZmvB/8VHYvUZOt+eQGDcn9miTqBAWPhzV?=
 =?us-ascii?Q?v/dulHt+9X/JMUtGMjsveFCjBKbcnpuGllxnwA/1MTliFFVWw+LcDEFRbE7R?=
 =?us-ascii?Q?Vshfvj+RdIJLQRWig0r6gyfKAbpjiiDxgEeVySzQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af618aaa-efdb-4581-8d79-08daa160072d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 14:45:03.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDxldWvW91DxcW3he6Hz3G7QFgtYWGjgkbgzfyH3aR2PZOu13N/vo8EnbRETTpQkf/xg8mHGvf5VOfSam3nYLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 22:29, Greg KH wrote:=0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> On Wed, Sep 28, 2022 at 02:11:36PM +0000, Wayne Chang wrote:=0A=
>> Hi Greg,=0A=
>>=0A=
>> Thanks for the review.=0A=
>>=0A=
>> On 9/28/22 21:45, Greg KH wrote:=0A=
>>> External email: Use caution opening links or attachments=0A=
>>>=0A=
>>>=0A=
>>> On Wed, Sep 28, 2022 at 09:16:15PM +0800, Wayne Chang wrote:=0A=
>>>> From: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>>>=0A=
>>>> Firmware built for Tegra doesn't support UCSI ALT=0A=
>>>> command and has known issue of reporting wrong=0A=
>>>> capability info.=0A=
>>>>=0A=
>>>> This commit disables UCSI ALT support when reading=0A=
>>>> the capability on Tegra.=0A=
>>>=0A=
>>> You have a full 72 columns to use, no need to make it shorter :)=0A=
>> Thanks. I'll update in the next patchset.=0A=
>>=0A=
>>>=0A=
>>>>=0A=
>>>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>>>> ---=0A=
>>>>    drivers/usb/typec/ucsi/ucsi_ccg.c | 16 ++++++++++++++--=0A=
>>>>    1 file changed, 14 insertions(+), 2 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucs=
i/ucsi_ccg.c=0A=
>>>> index 5c0bf48be766..fde3da0605f5 100644=0A=
>>>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>>>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>>>> @@ -122,9 +122,14 @@ struct version_format {=0A=
>>>>     * Firmware version 3.1.10 or earlier, built for NVIDIA has known i=
ssue=0A=
>>>>     * of missing interrupt when a device is connected for runtime resu=
me=0A=
>>>>     */=0A=
>>>> -#define CCG_FW_BUILD_NVIDIA  (('n' << 8) | 'v')=0A=
>>>> +#define CCG_FW_BUILD_NVIDIA_RTX      (('n' << 8) | 'v')=0A=
>>>=0A=
>>> Why change this here?  It's not needed, just add the new command=0A=
>>> instead.=0A=
>>=0A=
>> The change here is to distinguish the FW built for NVIDIA RTX products=
=0A=
>> and NVIDIA Tegra products.=0A=
>>=0A=
>> #define CCG_FW_BUILD_NVIDIA_RTX      (('n' << 8) | 'v')=0A=
>> #define CCG_FW_BUILD_NVIDIA_TEGRA     (('g' << 8) | 'n')=0A=
>>=0A=
>> I'll update the change if it is not needed to do so.=0A=
> =0A=
> No need to make this change here, right?  Do so in a later commit if you=
=0A=
> really need to.=0A=
Yes, agree. I'll update it in the next patchset. Thanks.=0A=
> =0A=
>>> And what commit id does this fix?  Is it needed for stable kernels?  If=
=0A=
>>> so, how far back?=0A=
>> We are now enabling the NVIDIA Tegra products on upstream kernel.=0A=
>> The change is to add the Cypress cypd 4226 support for NVIDA Tegra=0A=
>> products including Xavier AGX, Xavier Orin and the upcoming products.=0A=
>> The Cypress cypd4226 is not enabled in current kernel codebase.=0A=
>> And thus, we shall not need it for stable kernels and backporting, do we=
?=0A=
> =0A=
> Ok, that's fine, it was not obvious so you might want to say that in the=
=0A=
> changelog text.=0A=
Sure. Will do in the next patchset. Thanks.=0A=
> =0A=
> thanks,=0A=
> =0A=
> greg k-h=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
=0A=
