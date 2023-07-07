Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47374B2CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGGOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjGGOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:10:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1682708;
        Fri,  7 Jul 2023 07:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM2mQdHsL5dBHDq04G0JuTY3Eh6qWUU6ls257VSoE3nyAalLO3L2eFGCfDmyZYjummZjOoyr4q2Cbg5OvzN2CRV3B3Mt64nw49RHTFY+aahjBZCiQOLRTjc+Ts4xvpx/Ssy0kOl9M9WTutSqheCRI2kmUTxvUJ5TtM2yOBE9YR7cBcP7SRrgnb5nhGqfDRMVInO1Vd8Yv7Ipq40312DNjYdpkKnjC9FsdTi3IkpMPa5An3iCtMyOhyLeddz8uIzTCu59gzQ3vhfjg/zzERurqNlh/SWcP/VLMZ1MwQaaYGEfSGjKYk98x+bnmHn3rTWIaZwvK64oIoMQRWYJKkBeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCoO2EcZsuG+CY2iYG6H2iwpG/VhSLmXsSFZqEcJcEs=;
 b=N+rB2gOx30bYItJqb8OEKJcDPbJx2QU5/UXIFpyR9F3u82LB7iXN5RhTaSCdUZGCkaBV6kazzsd0+LZXIBEbA+N0vwzCXulhJrVMb+edTNlBgQd7irNgjRcn3N0l6GGQTHrELJVRF6UELhWknKiVJL9FwCVw3aOjH98RPVx0WPwcbpUGaA43/TX+9kY5pMAilV1qFIFZWECJbX9PGEKfsGEXHdBbJVu7yrts9//vtwtHyzcr2ADUpHSQRnABEPP74C5PowoicMckb8W1Tn3YJy9e7x+HaalBqbxSG77ZAV3UdEslB11pyael5TkS+hKBvvKinjQRWS4QNGtMoeSAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCoO2EcZsuG+CY2iYG6H2iwpG/VhSLmXsSFZqEcJcEs=;
 b=a4L+fFJgmO3abD9Gc424N/c2Dxq8xz6FDo2RO655rLouANN8ClsQXWVz7kH7wPvuB5UxmGs4lNaY71TFYAT4T4xisaWAA9EmfjRyTPFtJjAbhrA8BoHaIPrEjNW2pCDmE+nF2PUTFt+5BJB+uhHGPWN2thGGioJYsX4iOE/kiAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:09:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 14:09:52 +0000
Message-ID: <994042dd-9532-0dfb-8f86-98c897db75fd@amd.com>
Date:   Fri, 7 Jul 2023 09:09:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/4] Fix for interrupt storm on ASUS TUF A16
Content-Language: en-US
To:     dridri85@gmail.com, Friedrich Vock <friedrich.vock@gmx.de>,
        nmschulte@gmail.com, npliashechnikov@gmail.com
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        andriy.shevchenko@linux.intel.com,
        Hans de Goede <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        open list <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230705133005.577-1-mario.limonciello@amd.com>
 <CACRpkdbrwg6wRbFKCfr0H766Z5bX5rANZ-YGAfM6P2q3Khk=bw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CACRpkdbrwg6wRbFKCfr0H766Z5bX5rANZ-YGAfM6P2q3Khk=bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 64831334-0f9d-4134-f4f4-08db7ef3d4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTiSd6MfeFN5rmFpopdioE/j+G6GHb5xxuLxNi0Ez9IDBxJ4Plzq6/rdLE1qNWMnjxXNWL6j0KOW3s+oQbfErsT+2+VJqcDHSFG1drqP4weHsr9TIOQ6f3Iffjj9BSI0CwUSTFRhl/ozebrj9HIPW0SZXyd4FSyLJDZW4eutWknnGb3im4YGR4EU4MVhvyHBARDVtmTtKF2qgnr3g0qNmeY4AgQlShN/Qa7dutNLnUWoCiu26xj2lbxtFSp2YTT+3h5S2L2tLgyhUkMZsgJl7AocF0dtMzyfj/WKFKDxL8oKRxBm5ahJ2LlnuNhbUi6To+QzTuf0453eyw11IK1jeq+a4+6FcttIaSvin70CPcS3ow7Tfs0cMhNsOOK2Y8GKWPLJ7Z3CVoHoadH1+o5n/HDoqEHmCgYkgw8FdbtSvsqPo4gNnUiF3uhKl9tjVtanHY4W5u1GcePT5GBsugOPxxQrczeDLj+/hNxb0ehg5yjbOdrG00BX+v/X54AflW7ZTC1IP/0nAymQXt+ZmTzl9ztrcN5gYTgU571lsQIco3rfoeCDsgIeX0+5V3jnDIeUFPURbY2Wi4OjlsyrJIExukReyhoF0eRO/zR66svypY8oujDX8nwB+BaQ2yERg2xqCWKA30TI0riZA8mxUHHcSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(38100700002)(31696002)(36756003)(86362001)(31686004)(41300700001)(8676002)(26005)(5660300002)(6512007)(53546011)(6506007)(186003)(966005)(8936002)(4744005)(2616005)(2906002)(83380400001)(316002)(66946007)(478600001)(6486002)(54906003)(4326008)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEo5eXdYdG9ZbzJPbnc3dXRQZ0Ixc2NTVEZLSmRmdzJzL0NVN2FMMk15cHdZ?=
 =?utf-8?B?MXBiR3h5SUsxRFR4R1FsVC8waU5zMWtuRXdTeHVFVmRxUW85U0QzVEczNFNm?=
 =?utf-8?B?UkM4Z1FnNURwdGNYc01ZSXlxaFpFM0FWVi9IbU85eGY1aWNib1RwMWoxRjVL?=
 =?utf-8?B?UXAwV2Y5TGdlZzlBZHNMbDVDU0xYNlkzM205Yk9HTVVYdGMyYzhVS0hrM1pw?=
 =?utf-8?B?YkMvZXZKbVQ5RCtPM2I0aVBkQ3EwYjNjSTl1aG8zUnFOczJ3c21wRTdiZW04?=
 =?utf-8?B?Vm12bVZSMGJZUENkaDdvaEMwYlNucnRGUzR0VXBQWjVFckxmZjJqbXJsSXcx?=
 =?utf-8?B?QW54Q3dSc3JSMzZSRkRacG5DaDFCWndtT3dMTE4vR0xETEJiWkt5ZXpZZkpr?=
 =?utf-8?B?K05hcG11cXVsSi80SDFrS0JrSlJqZVpCTWRkSzZqTkl2dlJ3Um1YTC90ODh6?=
 =?utf-8?B?NlF2dXp5UG94MnhBWktsVEhWWmxNWVNQRTUzMnR6VFVtbDM1Vm5ESXExbkdm?=
 =?utf-8?B?eVhkam83K1lmL0hObDFZMWNSeGVVdGEvRzIydWxBNHJMdkN4K0VvbWlSbW5L?=
 =?utf-8?B?b0l0d2lCcExRMndkVjZoZkxwNDZyOEhiNTJQbEdaL0ZBUDNVM0QrTS9ubVZY?=
 =?utf-8?B?T2Q2c0FHYkp5VHZ3SVBEY0lpZUMwVmJzdHNmd1VTSzg1am5hdVl5N01xOWNr?=
 =?utf-8?B?RzdpYjFGeHJPZ3dNaG11REl0Vm82RHdFRHJENVhqczJONlc2MGgrQnZidFZR?=
 =?utf-8?B?MmVzUjBKQW1BbGpxcUkvWFNMZ0tIWmw5L20zRkZzQy9LTWh0bU9CeGxMWU1j?=
 =?utf-8?B?Q3ZMQndoWGJNaFVKODdHakV2Y0pIckgwNWdLWVVmOSt1WWNDWGpoalB1SkQ2?=
 =?utf-8?B?UFA5NXBmeUo3ZTM2MFlrWERQV3N6TjFNZ0YxeFpJdFF1Qy9XWWIxc2RQaXRz?=
 =?utf-8?B?c01ZY1BmRHRKSU5hcmc2bFc0NVI1bjlJTERlSWhXQ045WlRIemlWbDh4cTZv?=
 =?utf-8?B?NHFyNzdxWURCN2lUbjE5clNEZmZ2VWpoQ3pvcVNxUCtaQ3R2VHBVTlpPcVJv?=
 =?utf-8?B?a0JrN2t1MXJNS1ZDNWsrZS9JTTNuZUdFNit1TnFBRUdzSFUvakp5RUNsR3hw?=
 =?utf-8?B?MncyKzVsYTliMnRubWJ5dHhBV3FaNG9SbkNwTndUa0RMOWR6SWFURlNMNGRp?=
 =?utf-8?B?dXNGL3hUVXV3WXR0OUk3d0VwZ1ZaVGhuM0k0ajBRU0hta1FadUQ0ZlJtKzhU?=
 =?utf-8?B?bWoxQnRwUlViYlN0NlJGVTNmOGgya0RIZDdkUUdnMmtCcWpQTW1kZXRvRzd5?=
 =?utf-8?B?Y0Z1MW9VQVliUHMxU2NuM1hxUk41WVRvemcwdW1yU0ZmN1pBQkVERW51Rit3?=
 =?utf-8?B?OVNkYU5rQUlYWFh4RzF2NG1mdmdsdkxUaU5EUlk2MUVIVjhtVXNHUEExc1J6?=
 =?utf-8?B?Q1JhaE50T3VjeHdjOXl2QnJlR3BSWExxbzVQYWtYdUtBTDV5SWZ4cEdBSWJ2?=
 =?utf-8?B?ck5FdVcxNXZtblpiZVFMZHUvSDhnbVM4MGxCdTJGQ1lOZlUvdlQwTjBBSS9U?=
 =?utf-8?B?YjMyTzRVVGE5czJ1cUlTVXpPZnZSZTJIbzNpVmk5Q0E2NUFIbjFIK09pR3NQ?=
 =?utf-8?B?bE03Z3hCenJLSzJGVy8xWXVIUEhXdml1Qzc0Z2k4clhwQlVFTTlYQXZGc3lp?=
 =?utf-8?B?Y2F6UFlNTTV4UXRSQ2hXOHVxN0FtMWxKUmdCL0N5bkVpRGVkV25DWm9walRK?=
 =?utf-8?B?QVRyNU4vNytRN0FQTkFHcUpFeTBVOHl4N0JUK3kveDBWSUFKVnJ5RmJNWFpi?=
 =?utf-8?B?YnRYYVBjNzZHZVhubzRZWWhpNmtQd1BVcGVKMHdPSXoxY20wc3oyNWN6WW1G?=
 =?utf-8?B?REFkT20ydXpPNDd6VGJRZzFrZWVNdGNraWwzRnFtbXJ6Z0s4VU5VeTJuY0l1?=
 =?utf-8?B?QkpCT0tneVFmbEt4dGczMzQxdFFQaTdDRkhWU3plYlFiMjZYMzR1czQrbnZr?=
 =?utf-8?B?TVN2YjhQQUxDcFlUZUhyb1dpSlRIU0JqOXptZUFXTm5UTWFwbTB3cjl3aklO?=
 =?utf-8?B?ZElFZGxocnNjS05JcWd1WXM1ajF2eGtWQjROdnpWM0h5T1l4eWlmSUdGVmps?=
 =?utf-8?Q?lB1mBARR0OOVJsjRvF+F32WJv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64831334-0f9d-4134-f4f4-08db7ef3d4f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:09:52.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBZWMwwWu9HQ3/++C65eTnkyAF/4SWKmuEKsqe3F9Fzaj8NduBtMzlj9xr5O1ZcPuoDuBBSBIOOPitXkqUEZwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/2023 08:50, Linus Walleij wrote:
> On Wed, Jul 5, 2023 at 3:30 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> 
>> An interrupt storm is reported for the GPIO controller on ASUS TUF A16
>> but only on Linux.  In comparing the GPIO registers from Windows and
>> Linux the configuration for several bits specified in _AEI() was never
>> actually loaded into the hardware on Linux.
> 
> I queued this up for fixes as it looks pretty urgent, perhaps I will
> even send it to Torvalds before -rc1 if there is positive feedback.
> 
> Yours,
> Linus Walleij

Appreciated, thanks!

To all those that reported this issue, the branch that has all the fixes 
committed is:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=fixes

If you can please check this out and confirm everything works as intended.
It should - the patch was split up into 4 but the meat should be the same.
