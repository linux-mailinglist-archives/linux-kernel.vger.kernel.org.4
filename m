Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA16636627
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiKWQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiKWQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:47:41 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317BC764;
        Wed, 23 Nov 2022 08:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/N2dkWCH23xhSj1cFv5MgoMmnEgdF+fzcRWnoO6nK5SKaFwzZ/TTWLvSOM7kUxgfTz2yaaImVtNZFD4uhU2QMzJNsxJ9P1YQ1CYK6EQ5fXoy+N1FYoxwd4eiy7kpFaDtTJePMVOyqvLogP+XFIiNGMw0KfcwmGbIDrbOKaSxn58Zc1QzGHJPcFFBtQ5X+OOywA8R4pfc/NHBkIfn/UejBWnO6gsXdZktMm/pNXiQ+LZV6Rpy20cJibV8J7liM/mzcvkMo5fndvaBDJBBiHAZoPsacFrPnHutUf9HBcDyln+GLWJtDUymdO0Uf45n947J6kiZAQlAyPAofv1pp3z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8RtdiLgsFVmJWJGZa1D3Gx4oywDP3r8yvkBVtR50bo=;
 b=FNhVx93myyye5yJV6RQNHPcuBVidgVU5Th3x3Mf5GYoQ/ehp2piwM2OdQOkDHTpjml1IHd+Kb9rWMVv0blrFqFKKZ8+XDiAh2rmxWctH4xRF0Zb9jrAhvojDyz/jUphAc9YC9qgsJuPqWxhiMH2GePMIseGceGDC/P4wqO/aiIYFYeYgrWt9eXpXrkzDUz3QKKO84CzylvtCJ3NdJRjX7j9RgmuwjXS4+WrEx/StH3I/Hce79QWyak1Y8OUIM0p02IJQfTghBFB84oa75GjepnXqf5vMk5/9yasYeOG/ESwytjZ9PfuIoSB3vs+gWTE22rhKuEqHwHre4bd1heuLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8RtdiLgsFVmJWJGZa1D3Gx4oywDP3r8yvkBVtR50bo=;
 b=sdNaPWBzH6olgoh+p007vvbLR+nTOSb40ryZrSX+CKfMCL6BPQ7Tk6nD7E85ba1U7bvdn9uBAoeQzTouqxnoe7726OvSP6fnQYI2aVkII9BUWwN1ZpcyefSaK3fvsA8D/jQm8bq67YYCDCy6v0QEcOjNqSGq09iJ6ccD7PPM7DqF4A/S+Hi5aE0WX2QfRDo3Bqzjh74cgt8mb9/M3WvJGZss4mGEOJWxwwShv2xTcR9SkAjFSGHSbe/kIkdmj9+L9jSUMVTASmAcouOA5L5kcib2ran4KYc6S1RJ6ZvaOh7vWH30U4I/iX+35m3E4AoVfme76dFwiUIxzjd08cH1nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 16:47:36 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::88c9:1477:70d9:86e9]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::88c9:1477:70d9:86e9%5]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 16:47:36 +0000
Message-ID: <0f7258d5-ff8e-fa4e-ab8e-5125c42a6d07@suse.com>
Date:   Wed, 23 Nov 2022 08:47:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] scsi:iscsi: Record session's startup mode in kernel
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221122213040.4128105-1-haowenchao@huawei.com>
 <4d21f806-6653-5457-918c-563a3032d128@suse.com>
 <00f11c61-a53f-c48a-017f-4c06055ea708@huawei.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <00f11c61-a53f-c48a-017f-4c06055ea708@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|AS8PR04MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 248a2808-95d4-4a45-b1f7-08dacd726cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4C5eqpWU5TWBIbv3lgwthoYcg9e/AKdxCLpbtFP4+dCdWBouR9H136P8mdTyyFbGOay8zHqTQZ/tpN9JQNnkHYrzIaCFK52Gq/cvNrZzEJGeURHEbSSo4dUL+Nfw60aMNqL0ZfbcUd6yI6bQUI5cjCXs55MNxVwnxxiDB+GhAPdS2aSWNfBxCBLgCmGE9tKrarPyPXSNd9pXxRinc7U27MQDzVhS26zWOZLQjtFG6NovZwqGSHtjCb72JkNlNFOEaCc6BXKAY/WbgLoVu7vKHAC1XxKt0nSCAljjsplvJ0QN7lZUW8PIhRsmefAm3sNFcklbijyKt4EzjWK3J6XEPhQ+8sgMu+rBxOTUSRyDpyylLhhf7uveNhnacT5yw1kOon+0ZkOz/UByg8o99uffij+zH5gjBlkQFA3i1yTk3xUOJ1iIJxrE+WYug3gq3uKrYOFui1XOXFQNLA9x36vvu2jF7w+9wT271/cD4nlQyk0plnqUrSm7MMvVp0xuROjFJO7KKm+dnzpG+ika5vHB2nIsjD48zp5CXjAGn7HHYamQoe8FBlgI/neZowOc1clY3xVhB8UrDAE0a9DjRp2N0b2Qw2PgmGKk/gn+uMJ1dCDEJNAZ9WQVDOLgDphyCkBrcV5ZlOUSothhKb3eWJZ0Kn2ueW7sMBAwTLVfychSn0dDBXi6or/jep90+WqqBlPigYfzIGgJbKr/F6e5ttWFKOXvID8DQaEJSLopps9zpYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(31686004)(6666004)(6486002)(478600001)(2906002)(6512007)(66476007)(66556008)(2616005)(41300700001)(8676002)(53546011)(186003)(316002)(36756003)(110136005)(6506007)(7416002)(4326008)(5660300002)(83380400001)(31696002)(86362001)(38100700002)(26005)(8936002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRJQ2FMcTJFV1pScjFRNDMySE1iMDFaWThCUEtOZHFxb2ZIMXBpQVlWeDU1?=
 =?utf-8?B?aUF5TzRyaXg4Ukt0alZINWp6dFN0MTZWMGRRYXVSZ09OWmtKenZLZDNubTJn?=
 =?utf-8?B?b2JCeXNRb2NEKzEzMzdBbkVYS1hwOUxXSzNlQUVpM0NKT3FoWE5VeUFHWURp?=
 =?utf-8?B?OXNnSHZFeUxRWW42NWhBUDVRdHYzdldkWlZEQmdOWWJLSXJ1ZW1wdS8wemh0?=
 =?utf-8?B?R0Zod1JsS3lZTUpaWi81cjhGeDE2bVoyTjdDRnFKaFJZbkhFL3llNk5vRVcy?=
 =?utf-8?B?N2VZUnBxcTZ0VjFOa21JZFYvdjM2Vm1YSG45bERoSkp4ZXBvZjdDMVk2WWxm?=
 =?utf-8?B?T21pMEQxWFlYN0grY2t3MmtPUlFMWk4rV2ZDeWdJQ283VWJUOVF2ZDVjc0x3?=
 =?utf-8?B?MUp3UndEL1Z4dVZhUi9MVGlwdHN5VHRDVURET3F3SDBYYmdnMmRPa2pLVkdR?=
 =?utf-8?B?WGZNOTZveGFPZ0txcDBQUm8yVXh0a2w4RXpvNU5maENTU3RBWUhLdVFENkM4?=
 =?utf-8?B?dkhiQ1ZXdGk0aDcyRWJxMWRpZVU3R1hSUWFGRkJnR3htcFNKWm15aXFHMnRE?=
 =?utf-8?B?SW0xYnV5Tm9RZm9lQm1nVWJBbldKMWsyUmZBZlVLeHQ5YUUwdGVLSTBobi9z?=
 =?utf-8?B?K1ozYW40ZkVoVWNDTFhRN3ZvOTg2QmxmMkUvYTdUUThjVkNFWi9RSDFBRVFQ?=
 =?utf-8?B?ejhJd0dwanovcFhhRzNSSWYwUmFwNmlKd2tmZkZMamtXdjFjenZSYjV2TkU2?=
 =?utf-8?B?ZllZUlFJMEhDQ3VKbkgwQ2RVSE01TGFKYUU0U2Z5aEhJdjJoNzZ6Z1N6enYz?=
 =?utf-8?B?ZGZzNzJDNk91VHlidEhZVk1sNEc1YWZRUE43bHZibEhWWk5DcUZKclVZN2pE?=
 =?utf-8?B?NzJITFI2aHFlYXhodmNpVDR0aG1Qb2did2FDRHY0TEt5aXFIQnBJSmNBSHRh?=
 =?utf-8?B?N1pySHVrTkEwZ1BEa0o0Y1B2QnFNRUVUd2xIbVVGSkgyM1Y5bHMyOS84T1U2?=
 =?utf-8?B?dEpjU2poYVlPSzZ2akVYQ1NqVWwxaFVScjcrbUNneVRGcmVsTE9Kajcyek5l?=
 =?utf-8?B?WVVtZmNLU0ZwOVM5MWVsd2JQNlRpeUU5b1QwOFVaa3pDTjA2ckwvYkdWOEpL?=
 =?utf-8?B?SURYNnF2ZmJRR0tYU0lkUW1SaENFNmJONXFNUEhNeit0YkZ2MUhyeUZWamNY?=
 =?utf-8?B?T3FsSzVPMXBGUE9xY3E5eFdmVndiSi92dWhWVXB0SmJLRlBxK3NCN2hPSDJB?=
 =?utf-8?B?Z0h5K0Q5WEM1VlNmWnNkZnk5OGVRUE81M1EyK2t4aWdyWk1iNHhJMUI2UTJM?=
 =?utf-8?B?bFRld0FKYUtTclJEM3N6Y2FScGFuTkRVMys4YlRhTkZKZVRleWxPaHc4NW5p?=
 =?utf-8?B?V1ppYkhRbkY5eWNkMjhvU0loczN2KzdnVzZkN3E3eURZVnlYNmRDaGlQYWdJ?=
 =?utf-8?B?UmpIMFhLNmd4MTF3L1hVdEttVTRyQWh2Sk82cEFKMXZvL2NWMFk4UkRKcEtv?=
 =?utf-8?B?SWJFVHJtUElDVHM1Nkp0TkkySktoTldOamFIUTVMb2RIWkpjWm80OWJWUnRa?=
 =?utf-8?B?WFVpVmZ6Uy9ML1czTkVHek9uVUpmVitzMlJZQjVMb2FtN0NhRDNPQk5kSmFu?=
 =?utf-8?B?eGFpMGp1Y1d6WVF6b3VST0ZrUFhSME9zRnhMUyt6OC9CbURIUG4yRVFvTDFX?=
 =?utf-8?B?TnVXMGFGaGNaMzR3VGUzbWZ1Tmt6QnVDRGhweXdpSEN0b1haa1NvUi85SnhE?=
 =?utf-8?B?VWlxM09icnhOcEpWWEpXcy95VHd5Z052N2ZPTThTMXA3V2ZwV0czUURHalBR?=
 =?utf-8?B?eUp1ZGtwd0ROai81MFM4ZXM2N2pIMkFYL015TkdGOTQ0WmtBMWFHbFMvNG4x?=
 =?utf-8?B?NnA3STQzbmhTQnZqb2d6VzU1a242Mll0NlBFOUNGMnNicHNkMGl2aGQyNFFS?=
 =?utf-8?B?dzRRMnpIcUF5SHlVMDdJeHozeGlxMTMrVXA0TmdIaVRGK0dQNEdYNVc0RG11?=
 =?utf-8?B?ckhnNktuSnBMZzhNcVVuN0NhQWFJLzhQZDErYjllSWRSTkhmSFdDTmlpb25K?=
 =?utf-8?B?MlA3Wm9iNGw4WlB0OGlCT1ZsUzRhZm1nV3FtbmhPNUJvMVNMdmE0Yk1OTmlj?=
 =?utf-8?Q?ihMWTqx1xt9ITW1N4eZORx3qf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a2808-95d4-4a45-b1f7-08dacd726cd4
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:47:36.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZlfF4HHL114aUyxla/DEUjxJ87usxV0Op15Mjox0qBNK7on8AGmmqBUolQrsvzirNDvb39zL3TL7X6elyKNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 20:41, Wenchao Hao wrote:
> On 2022/11/23 4:00, Lee Duncan wrote:
>> On 11/22/22 13:30, Wenchao Hao wrote:
>>> There are 3 iscsi session's startup mode which are onboot, manual and
>>> automatic. We can boot from iSCSI disks with help of dracut's service
>>> in initrd, which would set node's startup mode to onboot, then create
>>> iSCSI sessions.
>>>
>>> While the configure of onboot mode is recorded in file of initrd stage
>>> and would be lost when switch to rootfs. Even if we update the startup
>>> mode to onboot by hand after switch to rootfs, it is possible that the
>>> configure would be covered by another discovery command.
>>>
>>> root would be mounted on iSCSI disks when boot from iSCSI disks, if the
>>> sessions is logged out, the related disks would be removed, which would
>>> cause the whole system halt.
>>>
>>> So we need record session's start up mode in kernel and check this
>>> mode before logout this session.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>>> ---
>>>    drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
>>>    drivers/scsi/be2iscsi/be_iscsi.c         | 1 +
>>>    drivers/scsi/bnx2i/bnx2i_iscsi.c         | 1 +
>>>    drivers/scsi/cxgbi/libcxgbi.c            | 1 +
>>>    drivers/scsi/iscsi_tcp.c                 | 1 +
>>>    drivers/scsi/libiscsi.c                  | 5 +++++
>>>    drivers/scsi/qedi/qedi_iscsi.c           | 1 +
>>>    drivers/scsi/qla4xxx/ql4_os.c            | 1 +
>>>    drivers/scsi/scsi_transport_iscsi.c      | 4 ++++
>>>    include/scsi/iscsi_if.h                  | 1 +
>>>    include/scsi/libiscsi.h                  | 1 +
>>>    11 files changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
>>> index 620ae5b2d80d..778c023673ea 100644
>>> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
>>> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
>>> @@ -947,6 +947,7 @@ static umode_t iser_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_IFACE_NAME:
>>>            case ISCSI_PARAM_INITIATOR_NAME:
>>>            case ISCSI_PARAM_DISCOVERY_SESS:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return S_IRUGO;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
>>> index 8aeaddc93b16..a21a4d9ab8b8 100644
>>> --- a/drivers/scsi/be2iscsi/be_iscsi.c
>>> +++ b/drivers/scsi/be2iscsi/be_iscsi.c
>>> @@ -1401,6 +1401,7 @@ umode_t beiscsi_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_LU_RESET_TMO:
>>>            case ISCSI_PARAM_IFACE_NAME:
>>>            case ISCSI_PARAM_INITIATOR_NAME:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return S_IRUGO;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
>>> index a3c800e04a2e..d1fb06d8a92e 100644
>>> --- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
>>> +++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
>>> @@ -2237,6 +2237,7 @@ static umode_t bnx2i_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_BOOT_ROOT:
>>>            case ISCSI_PARAM_BOOT_NIC:
>>>            case ISCSI_PARAM_BOOT_TARGET:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return S_IRUGO;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
>>> index af281e271f88..111b2ac78964 100644
>>> --- a/drivers/scsi/cxgbi/libcxgbi.c
>>> +++ b/drivers/scsi/cxgbi/libcxgbi.c
>>> @@ -3063,6 +3063,7 @@ umode_t cxgbi_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_TGT_RESET_TMO:
>>>            case ISCSI_PARAM_IFACE_NAME:
>>>            case ISCSI_PARAM_INITIATOR_NAME:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return S_IRUGO;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
>>> index 5fb1f364e815..47a73fb3e4b0 100644
>>> --- a/drivers/scsi/iscsi_tcp.c
>>> +++ b/drivers/scsi/iscsi_tcp.c
>>> @@ -1036,6 +1036,7 @@ static umode_t iscsi_sw_tcp_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_TGT_RESET_TMO:
>>>            case ISCSI_PARAM_IFACE_NAME:
>>>            case ISCSI_PARAM_INITIATOR_NAME:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return S_IRUGO;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
>>> index d95f4bcdeb2e..1f2b0a9a029e 100644
>>> --- a/drivers/scsi/libiscsi.c
>>> +++ b/drivers/scsi/libiscsi.c
>>> @@ -3576,6 +3576,8 @@ int iscsi_set_param(struct iscsi_cls_conn *cls_conn,
>>>            break;
>>>        case ISCSI_PARAM_LOCAL_IPADDR:
>>>            return iscsi_switch_str_param(&conn->local_ipaddr, buf);
>>> +    case ISCSI_PARAM_NODE_STARTUP:
>>> +        return iscsi_switch_str_param(&session->node_startup, buf);
>>>        default:
>>>            return -ENOSYS;
>>>        }
>>> @@ -3712,6 +3714,9 @@ int iscsi_session_get_param(struct iscsi_cls_session *cls_session,
>>>            else
>>>                len = sysfs_emit(buf, "\n");
>>>            break;
>>> +    case ISCSI_PARAM_NODE_STARTUP:
>>> +        len = sysfs_emit(buf, "%s\n", session->node_startup);
>>> +        break;
>>>        default:
>>>            return -ENOSYS;
>>>        }
>>> diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
>>> index 31ec429104e2..b947a5bca380 100644
>>> --- a/drivers/scsi/qedi/qedi_iscsi.c
>>> +++ b/drivers/scsi/qedi/qedi_iscsi.c
>>> @@ -1437,6 +1437,7 @@ static umode_t qedi_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_BOOT_ROOT:
>>>            case ISCSI_PARAM_BOOT_NIC:
>>>            case ISCSI_PARAM_BOOT_TARGET:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return 0444;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
>>> index 9e849f6b0d0f..1cb7c6dbe9d3 100644
>>> --- a/drivers/scsi/qla4xxx/ql4_os.c
>>> +++ b/drivers/scsi/qla4xxx/ql4_os.c
>>> @@ -468,6 +468,7 @@ static umode_t qla4_attr_is_visible(int param_type, int param)
>>>            case ISCSI_PARAM_DISCOVERY_PARENT_IDX:
>>>            case ISCSI_PARAM_DISCOVERY_PARENT_TYPE:
>>>            case ISCSI_PARAM_LOCAL_IPADDR:
>>> +        case ISCSI_PARAM_NODE_STARTUP:
>>>                return S_IRUGO;
>>>            default:
>>>                return 0;
>>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>>> index c3fe5ecfee59..39c14d2a8aad 100644
>>> --- a/drivers/scsi/scsi_transport_iscsi.c
>>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>>> @@ -4367,6 +4367,7 @@ iscsi_session_attr(tsid, ISCSI_PARAM_TSID, 0);
>>>    iscsi_session_attr(def_taskmgmt_tmo, ISCSI_PARAM_DEF_TASKMGMT_TMO, 0);
>>>    iscsi_session_attr(discovery_parent_idx, ISCSI_PARAM_DISCOVERY_PARENT_IDX, 0);
>>>    iscsi_session_attr(discovery_parent_type, ISCSI_PARAM_DISCOVERY_PARENT_TYPE, 0);
>>> +iscsi_session_attr(node_startup, ISCSI_PARAM_NODE_STARTUP, 0);
>>>      static ssize_t
>>>    show_priv_session_state(struct device *dev, struct device_attribute *attr,
>>> @@ -4488,6 +4489,7 @@ static struct attribute *iscsi_session_attrs[] = {
>>>        &dev_attr_sess_def_taskmgmt_tmo.attr,
>>>        &dev_attr_sess_discovery_parent_idx.attr,
>>>        &dev_attr_sess_discovery_parent_type.attr,
>>> +    &dev_attr_sess_node_startup.attr,
>>>        NULL,
>>>    };
>>>    @@ -4587,6 +4589,8 @@ static umode_t iscsi_session_attr_is_visible(struct kobject *kobj,
>>>            return S_IRUGO;
>>>        else if (attr == &dev_attr_priv_sess_target_id.attr)
>>>            return S_IRUGO;
>>> +    else if (attr == &dev_attr_sess_node_startup.attr)
>>> +        param = ISCSI_PARAM_NODE_STARTUP;
>>>        else {
>>>            WARN_ONCE(1, "Invalid session attr");
>>>            return 0;
>>> diff --git a/include/scsi/iscsi_if.h b/include/scsi/iscsi_if.h
>>> index 5225a23f2d0e..e46e69c1fd02 100644
>>> --- a/include/scsi/iscsi_if.h
>>> +++ b/include/scsi/iscsi_if.h
>>> @@ -610,6 +610,7 @@ enum iscsi_param {
>>>        ISCSI_PARAM_DISCOVERY_PARENT_IDX,
>>>        ISCSI_PARAM_DISCOVERY_PARENT_TYPE,
>>>        ISCSI_PARAM_LOCAL_IPADDR,
>>> +    ISCSI_PARAM_NODE_STARTUP,
>>>        /* must always be last */
>>>        ISCSI_PARAM_MAX,
>>>    };
>>> diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
>>> index 654cc3918c94..af4ccdcc1140 100644
>>> --- a/include/scsi/libiscsi.h
>>> +++ b/include/scsi/libiscsi.h
>>> @@ -327,6 +327,7 @@ struct iscsi_session {
>>>        char            *boot_target;
>>>        char            *portal_type;
>>>        char            *discovery_parent_type;
>>> +    char            *node_startup;
>>>        uint16_t        discovery_parent_idx;
>>>        uint16_t        def_taskmgmt_tmo;
>>>        uint16_t        tsid;
>>
>> The iscsiadm/iscsid tools refuse to logout of an ONBOOT session.
>>
> 
> Sorry I did not highlight the key points. The root reason we need to record
> node_startup mode in kernel is userspace's node_startup mode is unreliable in
> some scenarios:
> 
> 1. iscsi node and session is created in initrd, the configure files of these
>     nodes would be lost after we switch to rootfs

That is not my experience. When I boot from iscsi root, after the system 
is running, if I tell the iscsiadm to logout of the root iscsi target it 
refuses. I will test again to verify.

> 2. someone do iscsiadm -m discovery but did not specify the operation mode,
>     the iscsi node's node_startup would be updated to which specified in iscsid.conf

The default on iscsiadm discovery mode is to replace the info on a 
discovered target, but there are other modes. And they don't effect the 
current (root) session.

> 3. someone do iscsiadm -m node -o update to update nodes' configure

Again, does not effect the currently-running session, and can be 
considered shooting oneself in the foot.

> 
> What's more, it seems "iscsiadm/iscsid" only refuse to logout of an ONBOOT
> session when logout is specificed by "--logoutall". We still can logout an
> ONBOOT session with "iscsiadm -m node -u comamnd".

Again, I don't believe that's correct. I will test it.

> 
> Based on these analysis, I think we should record the node_startup mode in kernel
> and check in userspace to avoid logout ONBOOT sessions.

