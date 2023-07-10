Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA474DB16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGJQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGJQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:30:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC31127;
        Mon, 10 Jul 2023 09:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpVdaFRsni60Db1OmSdNU+clKTzRRRT+UD1HWPtwJsanMAgTSay96iSsm00iDzSrDQEyLDZEP121RU6G4IfIG4tftfnP5GVVgTxJgcW6WQeOCDt54VlZTwne9twnxX0nry9jBQrOqe4xybVM9QPcsiClcQqg7GHN140hinBSGdfW20CbdIccz/Wf4s1auluy2no4oxBAAxNNvPSZ7pTpoLSaqfwkH2hIvnRpHEGFcCjLYZCQaefFSpfeMdSZ5Cvf+bqVixDLNXj2dmYkWUUQBkCFgI7Yifam3KDogMS06GWKfNZmSMZDqNsKCaOas/qas+8V4Bg7SXJJOyIjAoWdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh46fF74ot/ephvEELvxK9bKe23MM9skwHEfls3eIAw=;
 b=bKeviAGb9mOYg5tVfzt1f0g731G5w+WSaZzOWRRgOOnQvmjCA4r524VRqaPVx6vrP4BpWDjB6dyhTIbrWKIoactcTLdfShH8aNZgucr3gtdy1NCNiHP7sEiFIaVsN2sms3CFpHCK2vo/QdfqUuPjIagQyFDbX5FyHqpKIL4J+vaWlodS1d5fEQob1agSjTbciaGTs+89iX3SZdxRcRWLOcJUPT+xZ4Mn6XrsOuPv/EjdwMOJNIC94ZbQqmifjoy+kY54inGQCvKZC8dEcR0M1uvFmIyD23NdiwcdYyjf6Uyj5n9MBr8k6P8ddfM1e7vj8+vyedwRCMip7NJMS4+jGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh46fF74ot/ephvEELvxK9bKe23MM9skwHEfls3eIAw=;
 b=ovimCb02fwp7dXQCr7Bd5TqPoI7fO8NvpKltuBpqCnOGs32sj6fFQEUi1JPFqoO2QKO1KVdKq7G82z3RRczmKsrjcYr4LtzqGvnZSeDg096cX121eINQRJYM9DNMhOs+ciJ2CfhtlpM08eDCecT47BvDJ6ZNQy11Rt1Szl2BSXlpM8oL8/rah038bC0OMSpv5BE/6BWOm1ole7q9ShDGxAS76UZZyaqXgSpHVo7WEsaTVfN96ZNMYmIBZ4fCUpMJwq0NpcG1r7XJ48gb3nCcmGBFm/AQg7B3XPyev3e7dakLfMr+vmHTFIEoh/OqB4JtFEoRfh+lSMUPJ+wNekbjtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 16:30:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:30:28 +0000
Message-ID: <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
Date:   Mon, 10 Jul 2023 19:30:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::27) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afb6a1e-6f25-4aff-6e96-08db8162f87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRSIRhbJs2vUknbVjX3+l8G/SAEiUAjqMGGoQs3gKagtPjPh6Bq9kfJOOKFY7Y/6guGIfvx9C8TyLivS+JwoHU8TAIsRtMAtOZZWUSwFfhhYhcFo2Hzv2tjGDGBd9i5toAenclMJxLeQEeFbUy1SF3VNZ17vB2pxOZSh8XXSFqnmfwE1oDan9eMRVNq/sPaE3mEkEOIxVTh8whGH8tV1K5ZlVbgJVy3aiDourgWMyf+IOnYo6ceNcqzCj2Wqkg47UNg0Ewyx4oteoHNB73myBMAdgvDH09jSa5DnUN/XyjIFVO/IasF6hdzYvMoYLobq9EzDwB+pq9gIdAaER3mJlr/W3kwK/pllIHi/qgbGQzop45ctt+cQO9iH5EoKEPP5W+o+wv9KMeit9+hGzQcc4kED+/J+8R5rxzE3xJWWzKgx+d7DSo1bKyGxGBlBUwEd4e8MpImyuzQ8FCQEmOupU+OkZJsOULZ6zdkLsf6kGCgZHWfmQHDsV4cLlyW5cxznpFiaWihljXAWhTyB7SlouZS1O0TjpN3uFHKcoC6rIBIqT+2XrJyGg85QYEnZbOeo1hQL3QXMJgcNSrbiJ3K6kFbs5JSBJtWywJZONfILtmy878w+BBzhuCIbg9ooAGBea2Fa1Fm54mux5aerUdC3Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(6506007)(186003)(36756003)(53546011)(6512007)(316002)(2906002)(41300700001)(38100700002)(66476007)(66946007)(66556008)(6916009)(4326008)(86362001)(31696002)(8676002)(8936002)(31686004)(5660300002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTN2YmhFMWdPbjIzc28yTGEvQUk3MFFnOGVOVitXS0tMalZaT092RWpnMmdj?=
 =?utf-8?B?d1N4dC9FRVBzN1oyc0g0YmgrUCtJMmY1OHBFdVYxdmUwTHpqUERxcDlVL01r?=
 =?utf-8?B?TTZna1BHZTg2MTFGcnNYNllJTkxrUW5McDFVY24xSHMvSnJDeSt5bFpESDhV?=
 =?utf-8?B?TzczT0k4VzJUMU1sRHJmL2J5Q2hsbjd0cTlwRzVuUDdNYlBkeDBpejhlRXJo?=
 =?utf-8?B?OXJCTVc3SHUyeWVqbDhqMUFKd29VZjI4R0pXekVqUlJITGhUN2FRZ0pMM3Y1?=
 =?utf-8?B?TkUySGErWm5oTWlWM2lZMHUzUHFTRkVMb2U5SHVSUDM1WTlnekZ1QjdqdnBW?=
 =?utf-8?B?SEtqV0p2QmhWTlhuaWNxZk4rZUtSK21tR2s5NWpZc2J3eDgxWmVlR2dBSlFK?=
 =?utf-8?B?Sko3RE04VG5JWm55RU9HZVBlV2lVS20xUVkyZzdLNWtTRUJXd1ZLMWhwNHJN?=
 =?utf-8?B?QkFRVFZBSE94NGxua2QvanNxaFJlRGZNK1A1UTZnRmZoVGR5clU2SjlZbTZH?=
 =?utf-8?B?cDhXS0t5TFBPcFpEcHZqb0dxNGdHMzhXY25mV2JNZHVlNmdWekQ4QlI0eDlz?=
 =?utf-8?B?NXV6SDVJbnJxVElxRFZRTWpsTlQ4VlBMclMzcmQrRWpLTzIyNGNFaHNabXM5?=
 =?utf-8?B?RDI0clU3QzdycnlKQnZoUzhPWE1HalNHUEpWeGV6cFl1Z0F2Y0VudUJxdkF3?=
 =?utf-8?B?NW0rYlp5VVB0Vit1dGxlSmNjMHZIZ1QxdkVOSTBqZ1ZSd0dNV1p4OERXK215?=
 =?utf-8?B?SDFoOXd0dXVPbkhSNzRjd1BQWVQ5NXFPZERXMGhxQkI4SzFPVk1MTmt3VWRJ?=
 =?utf-8?B?Nk5oSGkxUFhtenRoSWpJc003SFpoZ2psVHI5ckhHekVPUHU0Y0RrYnRNYzl0?=
 =?utf-8?B?MW5rTnkzUjJDdFVmd3RGSTZna0tYQThkbzJMUDVuTFZ1RU9GTnBHY25VOHB2?=
 =?utf-8?B?K3NtaXJSR2hUWGxoSytraXAyQU1PbEIzL0NHWHE2ZEluN1ZhYXBrTmJHOGgx?=
 =?utf-8?B?Y1NNSHBPbStNUUh0TlVmdEIyV2ZYRXRNdUtGcW8wMFBQMHR3MDluR0NUcTZ4?=
 =?utf-8?B?UEVkR3ZDaDEzeWZySDQ3U3orZjBnVkpUenYrQk9qRWlFVkVmeG52YnJ0YndF?=
 =?utf-8?B?aTlhZEpOOTZjaTNzcytReUQ5YUtUTjBDbGVONTlBYUlGZ1ZYYWZ5SEJ3QVlk?=
 =?utf-8?B?ZnNRRlRxdWVtVEtOdzhLV1l4MllkQjg1azQ0dWV3L1N6VkRCU2luTDBiVFJz?=
 =?utf-8?B?OWdxeUxOWkRDWEFyRVNNNW9CWHJEMFR2S2hOZUwyQWh1UXQvQmZ3UUhsTndV?=
 =?utf-8?B?dVJDdEN1cno0NExpTWViY2NZWVdUbWZwR0tBbGdMNmkxdy9INGRPeFRNYW12?=
 =?utf-8?B?RVN2Ty9hNXZ4UWFCNEV5WUQxbWcxWmx1aWluZkNBdVBlVlBLaEs4V043Nm9M?=
 =?utf-8?B?Rm5OT2g2SVh1UHZTMStiaDZiVVFDL2pkZk52R2ZwT0RNK1hzd3NUZ0w1K1hB?=
 =?utf-8?B?SWVRTEwyK0FmOWgzZjd3NjBSdWZ6TFJEVUhRcEs1M3cvbFp3dUQ3UVMyY2xp?=
 =?utf-8?B?Z0hnRjNmWGQrd3RMVEhHUi9HNlNKRnJzOXJBVnZwN0gwSitHSG13MUVlQ0g4?=
 =?utf-8?B?bTBMeWZoVUh5TTRTZlA0M0xIZGNqQzR2SkFTbDh1cHg1MldHZitWTW5GWDdZ?=
 =?utf-8?B?OStqdEx3eDhlRGl5VVBPcE9CWDVkMXdLTmZZQ2NUeFdaOHpXcDVTUGw1cXhD?=
 =?utf-8?B?dWhINmo0WnJYVVNjTEhzZHE1SlErcWJ1blZYMVVmT1ZIVTNub1M3R1V6a3da?=
 =?utf-8?B?RFRZYWZld0diU05SR2Nobi9hTnVGNzhJdWN2SEhpNWdPc1cwTjhVSEF5QWFy?=
 =?utf-8?B?MXIzazdzaDJzTVAzbE9zSHpkZy9MWG5xVTMya3dCRkhxTGpqRnRKTE5MRGYw?=
 =?utf-8?B?ZFhZUHJZYnI2WXNCdlc5YUxkZ293ZHdDOVpnakNIendPVVJMRTBqSUFiWjNh?=
 =?utf-8?B?R0hCbjVubVVqSzF2M28yQ0kyMUVjZk1ZRVR4eU5SK0lKbGFia3htbkdGM2p1?=
 =?utf-8?B?eXUyNlNQaEtzZkhmYkpBZlpZQlJya2Q2Q2J1bzM4UnhRWUk5NmRVMUxXVmc1?=
 =?utf-8?B?cVU1RDF6cmJRZ1d3WitpYTVtZ1NCLzVERjE3SkVIRUU0YW1NUUpPTmpGa1Qx?=
 =?utf-8?B?ZFdEcC9wcnI1NXhiRmtLaHFSMmg2akJlb3BNN2VaNFFsQmQrMTZJZmVtY2hv?=
 =?utf-8?B?RDVibW8zemtDbDlkTWdrOVVJRGhnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afb6a1e-6f25-4aff-6e96-08db8162f87a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:30:28.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXPbRsu/jPjL3E0DQpnqIHI2VfO1zdf/2ZubKDC41P6P6duQWDyqQHdRYeiLm6aZwZhi98srS6FmdycFdU7FPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2023 18:03, Daniel Wagner wrote:
> On Mon, Jul 10, 2023 at 03:31:23PM +0300, Max Gurtovoy wrote:
>> I think it is more than just commit message.
> 
> Okay, starting to understand what's the problem.
> 
>> A lot of code that we can avoid was added regarding the --context cmdline
>> argument.
> 
> Correct and it's not optional to get the tests passing for the fc transport.

why the fc needs the --context to pass tests ?

> 
>> Maybe it's worth cleaning it..
> 
> It really solves the problem that the autoconnect setup of nvme-cli is
> distrubing the tests (*). The only other way I found to stop the autoconnect is
> by disabling the udev rule completely. If autoconnect isn't enabled the context
> isn't necessary. Though changing system configuration from blktests seems at bit
> excessive.

we should not stop any autoconnect during blktests. The autoconnect and 
all the system admin services should run normally.
The blktests should not interfere with regular system configuration and 
should not use any sysadmin file/services/devices.

It should create its own subsystems, nqn's, id's, namespaces, etc..

> 
> Another option is to detect if autoconect is enabled and report this when
> starting the tests. In this case we could remove the context part completely.

the --context might be used in the some sysadmin scripts or so. I don't 
see a point to do so in the blktests since we create a new association 
between initiator and target on each test (or on each group of tests).

> Obviously, I would prefer to keep it but I am certaintaly not against dropping
> it and make blktests a bit simpler if this is the preference. I just need to
> remember to disable the autoconnect stuff when using blktests.
> 
> (*) Sure we can fix this but at this point. Though I think it's a bit strange
> for a test suite to depend/interact with external components in this way.
