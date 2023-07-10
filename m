Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99474D264
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGJJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGJJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:57:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEBB30ED;
        Mon, 10 Jul 2023 02:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKq94d71BbkJedM4JPazNhKh3vHx9GhQMvOrSkC8JQLR6IS1+daGLnY+5k5zUyXPLb7VB/dUQlPLhUEC//+E4/Dp4DPUzkOGgl9z5noEVmQN9LaxCAASCtxZduq7YLas4jUt1ASK9vpRa1IyEqM1oo4x8WiIE6KMh9ILn4EMLPyi/I/xEDMWfISPgdCcG2C2BHSyeWUaVUr32MMruXHciapXzctHsRiALw8UTFH3+DstOVTqqi300dKbuyBmw5CMvMe5qAzVOO5/I3nQ0P55WQ1333EV14svQ7eTP8MYsMjnxjq+lYxpQW95r559h+7QRoYvx+XNlUv7KA+k/bZiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcACC08flFdwz7WT/AUq0BGDWspg9g4SJTa6SnivBNM=;
 b=HkMJzywgCdBTiC93WI2NkQZrEt2wZk5HqlsSQMekn7T3STu91pzt+NiScTlL41FeB+l72nf2AtgONA3D7p9Ik4B7Hgs01TpkkMsnfPqRjy1j9KFZfsSf4XDO4QzWvELF/FioWkG8DplPOa8zt+WCFo8rDorcy2ThFUmB9D8eBI0L0zdpyxwJMFawmO34ACDGLsD74ygz7VkWz/a9wjssavWFBPiXdxez69sGmLdHFAyzKUaqVbRpTBK9E+X+DWnVyEAcdZ+BeoNbAwwHe2n1sUtAxM7KZ54RatbOlM9J/0eXSNfLr9yuSXbADzS7EAkggWuBXjPVGWob+jHtILa9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcACC08flFdwz7WT/AUq0BGDWspg9g4SJTa6SnivBNM=;
 b=V3zizAkHTr71HzTIYeGhJeP+DM3d2Rv/LTe2AMUfTpfCRlx1+AVuxITGJRGFda8TrwkDuQGWYdUi52pFY35wh2hmFZDwPQvRufeHRgePLh0CAK6GyImxpZP4Nh0TgsRyKPSHzxcM1MYV2wDSngZEvMeLQjfvMyVbXtcTSDRkzskRM6+YnerlgA8rPhMUV8Mb8fqA79bxCHGLqPQ+KQMrcVtEeqNkM+nUPdLe2/5ALLZSNdkBh9b+Zhn6BTjfggmvzzymsUo76UoHt/C1InNPj2YHat+KAJPAocGrouaHIpc0WS3cx1hlnsCS3OuCI6MV5137xhp6p5Iayjim7UkMtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 09:53:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:53:25 +0000
Message-ID: <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
Date:   Mon, 10 Jul 2023 12:53:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
Content-Language: en-US
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0197.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5fba17-6df9-4385-5a81-08db812b80e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzamXNvVN1h3OEM39McvEtzIElDcKkKEXyGQH08wAzynSRx1HuYuhUAW0U6TM+dI9ZmvvetOfpZHOyI8a/r9x7JGhftTvix7Jy/4m0bSuch5xruwZVxKksGmIx3jkePA7jUyOwfyz0mxLuhj7vmrlEuzJXi26lAQZ/FYwRqdeRixuos0X7sZTdeM6OOW4S0/rRWnAMDAEElu03WxxZVMyPRxFF1oXZtBqwcccTIJf88e+e3/XEXXNBquDL8bo8e10qFFJGLLxFKzflNcjLy2BC+FJnvmXJdMJxfC+GM9CIpeaGhJsX+P7U+Oi6rmRfVweJAwKxeIwXlrZDy1sWDVfKZyToF3UGkv2ARQUyyv0LyjZQb8sg9wfrWEmANiDrRQHH/SpjIp4QifNGXXqRXQhvxw52QCHsUFHtTaFFAqR3Dv/ocg+3AZMMsFbvXHT5lJDaxx4sgxoBdsi6OvmP8viTD7C1nVoDR52KZSMaz2Hx6j7oCI4o1ZkiFw9AP+iFZtp7bfjDvyLH+xfkwaJ5vrv+FTln3+9ksdLpf/nskVcaRb+zFGEN62vP2YH04D6DJPjLPIMYUTDr2PZOqibwVxIeKOVyZltmJk7ndvH4c8mG0KCVh4SVuEbXYyN/RQc+wOK983xmIFJ+df0RkolSDHZEzKSF06ZE9mSK6aIrQ6YsUZS+JmldUJJB8tEI6iUfzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(451199021)(86362001)(31696002)(31686004)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(316002)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(54906003)(83380400001)(6666004)(6486002)(478600001)(186003)(2616005)(6506007)(966005)(6512007)(36756003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmZ5R0lFZGdWSkdLQXlrUE43SHpyYzIwRFd4RXFVcDNNNitGQWpiVndoUWd5?=
 =?utf-8?B?dklYMUVpTWZ4MUV6MFpQNVVhZktheXZwU01XMHJJQ29mcURNbTl5enR3MzNK?=
 =?utf-8?B?V3pRckVsZ0lkK1ZiR3N6Yld5ZUEzNVJQTWRhM1dlamVSYkhOeFljelRVOHky?=
 =?utf-8?B?ZW40aEwvMllWZGR0aEZOelFHRGwyU3B3Mml4VEh0VDc3QjhGZm43Sy9leHBB?=
 =?utf-8?B?N1ppOU1mOGVDR3ZIdGpoTjZueHRDa3REWEhLV25FaytEWkluWGRYRmZEdG1X?=
 =?utf-8?B?RzR2REFtVTRYUWlMeVdoY014QUdsV1c0OVdZY0NTUUc3T3pCK2Q5RDBwSmJV?=
 =?utf-8?B?bzZ5MFNjYXBKVXgveGlhWjRYanJGeGVEaDVudWovU2ZwcSt1ZkF0dWM0ZGhl?=
 =?utf-8?B?OFM1ZUFyWXpWKzV5U1oxNUYrc3lybWI5UWFZVURCeXAvQVpWTXpTTGExV1Y4?=
 =?utf-8?B?RGI1N2h3VHR0L0FxM0dyM3kwQm9OSTlKbDdPWTJ6blNxcXpPTFl1L2ZLR0tD?=
 =?utf-8?B?OGdubXV4cWNhODJmUW9OVXZLbkJ0ZmNBbnBWdHNHelJaTThjRUJBZkxFUzhW?=
 =?utf-8?B?RHFDaFFzdTRSOHVvdG95U0dWRTUwQjluamtTQVlYMC9yakNzMUkvRHBOT1Yw?=
 =?utf-8?B?UFVlMzhSSURYdXRwNVRkalBleXFvaWVlQjM2MUI4YWVuazdBbmlZcjZkQWFa?=
 =?utf-8?B?VTBEMk16cVZpTTc0SFhKdHhwMzROcGl0eHN1R0srQjVMNUtoa3J5cTJ2NWYx?=
 =?utf-8?B?YVBjaHh2MjNwRkhEVUlvaGFac3NzTzk3S2cxa3VRL3pxOU1BTitPKytJM0NQ?=
 =?utf-8?B?aVFMMnp0TWV0Mzk2MmpBNFdIOXlaMW5hL1p0ZGVQU0lacWQyTmsrQkFQN1Vv?=
 =?utf-8?B?UW44MFVpelNJNWsrUWJlczR6VzV0N3NWZkRTVTRvNnJDbUpkM01tTzdBaEoz?=
 =?utf-8?B?NG9YRWJRNFFDd3JjT2pBVHM1SDBEQUZMYmVFcnVxK3R3dVd6OTVITXFYL291?=
 =?utf-8?B?QitUdVRtS0JtOXZUQlV4TDZtN1dMamVSTTVYdlhvWTgxdWdySjc1ZHBzbUUr?=
 =?utf-8?B?Nks0eUhIS1BrVUlEM2Zod1BsUXl0TXZ5bDhLWnRPNmVTSnc4aEtMenJ3VERn?=
 =?utf-8?B?TlZMRlJzeEkxejJzNy9ESitoUjB0YXMwdVlNT09LV2ExSHNDU2xVSWNwMXcx?=
 =?utf-8?B?MVVQTW9jemt4U0FWZFg2NkhXUm9QSTNDMUFlMjhEU2toRncrOU1GN1YzWWlr?=
 =?utf-8?B?SzliS2k0ZGxMV0pSeFI1RUhnWlpaYjFNVnVhM0U0bW1xQ21iakR1MUoxcWFx?=
 =?utf-8?B?TmpnK0pKZkNKNzFRSDNHNXJML0xNTVBKZzZRd3J6UHlIbXRBWUxVNmxTaU9L?=
 =?utf-8?B?MjRaYzFEVDFRRjFiM3FDUFowK1BpbGQyUFVLY1h2cEtNQWtldWN3ZDRKQWcy?=
 =?utf-8?B?MXQ1RnVFcjJ6b0U2aUFrcDByazgxVURzYWY0STBSaCswZHZVWW5mOXU5WlBq?=
 =?utf-8?B?TWJpSEtiakgyZUw0bU9CSWdvdTNHN2NaNlhZbElJNGh5ckJnb1d3dGs0S0ZO?=
 =?utf-8?B?bFJTbkF5aEVjVFBWVk4ybG5LRTNXa3UveGhLeUk4WEtKMDFNdmpqbXhyTDhw?=
 =?utf-8?B?N01naFoxSE56LzVFemZ1TWtYTlFYMzRxejgrS25UTm1YVHJZTk4wV0orYUpp?=
 =?utf-8?B?NjdDRkFRWEFrK2FXMU45TVp0RzQwRUVQRVBlTHJOYm1WQ1M0eWpPa0gwUmNQ?=
 =?utf-8?B?TzhXLzRzMXZoU0M4TFNrSUEwVGtZM3N0QlladjhWZE9BNTZ1OHVrK3RoK3Fx?=
 =?utf-8?B?eXo3cXdZbUUzWmg5Vi9QUUx4eFkzQ3FqR2FzQ0t6UFhqVDNqNSt1L0phQjR6?=
 =?utf-8?B?VmtBNGJQdWFWejlxdVE1VTB5V3NxZWdvZVlSMjFHYXFkelJucnVuV2RNSnFQ?=
 =?utf-8?B?UzRjZHVHTDIrekI3dDBFaTg4THRaaTlicGdnZkZUbzVwRnBGODFZSDZPUEVt?=
 =?utf-8?B?dTlTMC9LSlQxRHdMR054bDJhYkkyc3ZVUHI3WVRzODhGWG5ldU04b3lzSC9t?=
 =?utf-8?B?czJsTTN5UGlOellvM1JVdlVjQkFxUXNKc09aU1ZLcUxWaTgvdE1jMnUrZHBW?=
 =?utf-8?B?dWFSb1NIZFZZSjFZeHVSOTBxcGhYclZ5TG9DMkJNbDdZR3BVMC9nWFY4djA0?=
 =?utf-8?B?ZWtxVVk4SFRlcVI5ejlnUXRRRHNwUkNpNXJiaUI4UTQ5d0dvbHpRZWUrTmxK?=
 =?utf-8?B?ZjNoNDBBNDNRZDZsYWJ0djlob2p3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5fba17-6df9-4385-5a81-08db812b80e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:53:25.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oM942S9pSoj4Ea2I1N1y82pMGdtisVvf9ptRNzucX16JRGkjP3NE+PO5tb+0Sv+uoTHEfpgYqOhyKdGuzrvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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



On 10/07/2023 11:27, Daniel Wagner wrote:
> On Thu, Jul 06, 2023 at 07:11:58PM +0300, Max Gurtovoy wrote:
>>
>>
>> On 20/06/2023 16:27, Daniel Wagner wrote:
>>> When the host has enabled the udev/systemd autoconnect services for the
>>> fc transport it interacts with blktests and make tests break.
>>>
>>> nvme-cli learned to ignore connects attemps when using the
>>> --context command line option paired with a volatile configuration. Thus
>>> we can mark all the resources created by blktests and avoid any
>>> interaction with the systemd autoconnect scripts.
>>
>> why would we like to ignore connect attempts during blktests ?
> 
> The problem I observed is that there were two connect attempts (one triggered
> via udev and one via the test itself) which disturbed the test. The interference
> resulted into a complete hang of the test case:
> 
> https://lore.kernel.org/linux-nvme/6g53yj5afhhonwf2psf7ft2gkakkwewy7klkix3y3u6uclpa5w@tt2yfzigyxgg/
> 
>> We define unique nqn/ids/etc. So we never should disturb other running
>> services, unless it uses the same parameters, which shouldn't happen.
> 
> Yes, that should do the decoupling between udev and blktests.
> 
>> Agree on setting the hard coded values for hostnqn and hostid instead of
>> reading the /etc/nvme/* files. This should do the work IMO, isn't it ?
> 
> Do you mean that nvme-cli will ignore the udev trigger when a different hostnqn
> is invovled? At least for the well-known discover controller the hostqnq
> doesn't work. Though not sure if I understood you correctly here.

All I was saying is that your issue would have been fixed easily by 2-3 
LOC by removing the usage of /etc/nvme/* files that are usually 
configured by system administrator and use a default values for blktests 
hostnqn and hostid.
The usage of --context in blktests is redundant IMO.
