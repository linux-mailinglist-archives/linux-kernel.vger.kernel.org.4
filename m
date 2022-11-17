Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A9D62DD07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiKQNnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKQNnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:43:09 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0573426
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:43:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKo2wddXWEr3NtdBocU7IAnWj/AjFb+f1NOomQ8d/pxiewZVKmHBomgx72KA4xH9t7CqGGwX4gw+Em/t7Q4AUUh+xIaHGpvJlOKKo+/imBKUKXYLMnWDjKmp4QNkUmbwQ0tC2UgY46WiPWEhy59oPqYougEsv/MrQzaLTLp9u7cAQFwMgYwYYJOkEEUp0pt2PyxQ0p6yPOVW9q8eYDBWNBhGYR60JJOEc9mkahLsAaxXrteHPaSI1fcnv5zj13r/F2xyzpde8cwi6UBV/AjTnbYRJpavIkVE4hleCvw2H4r3TT/iDuiiiSZC3SD1Bis1d3heCYqtgDLkdqqJ3R+5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BdQr5hmwXN65YhynlS5KUnisl+BNxZqEDvcJQUzAEk=;
 b=kO5ixbaokZtU89YWyUa7Nwu8EDz4RuM+OoM4GZA2ii3Mcs1HHlaSTdf4I0LN0gRIZwhIkv9o591o2Sx7gQ8CJ1aFjMZBq6e/3f9dENng8tFZoqaYR3fqNemfza0oIGUT2AjpkwYw37ei0bxCosAGEok4VWgxudU1al6d3vT3JDcOHZbMw0cNvwCvX3fjx+LHVAl851oOu8KdvUHBwtkVMUdtFan5Qi5hqA2Sx7Sa/xnlF1oUnEseJrI7etbv3aoz4X+6Wf9Gg2pYwDrTLuOPNejIHz48t7ZCydwS0b+9WgkMP2nDUR8j9oWe4LdFWkg5A5h5bPTDC3cd57H6AciMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BdQr5hmwXN65YhynlS5KUnisl+BNxZqEDvcJQUzAEk=;
 b=zQlSXhTF2lQH/wTrqmHXoI6W/23xc1vMq5zdITwkeiAJEXzdY3uxsvcX67V9/LDrSxSIhvyh5MAEarIfCV/pmC9avpR2BWwyEdcL/0cMcp7y7jo/OPMEsHvmKy0Rp11oTQ7ryQMQxXTZnLWcu+JYO2X1ORrx9A6UxHpGf16iXR8OvroSQ9hD0LZP2UT11bvN0TQIRlwFmC68WImeaLfn/rOujaBLZdlX4mnfru4PEgMU5pCw1YR4144aXOoLIk8KFZMALIxpW2NAoLesCh46WSpm/omkqcByQi29mZNLzfYtM45bwqh6Cme5ipx+nkyi3FUz3vnDoJUfEIs2SVU1Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 13:43:06 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 13:43:06 +0000
Message-ID: <1d3324da-16d2-2230-2fb4-433ef6acfc3e@suse.com>
Date:   Thu, 17 Nov 2022 14:43:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL bit
 is cleared
Content-Language: en-US
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
 <e606aa11-aeb7-fcaa-d699-380be4adc1ac@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <e606aa11-aeb7-fcaa-d699-380be4adc1ac@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DBAPR04MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 856033f3-3f3a-4a2c-5d55-08dac8a1a80c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4VSoyjaDYgNtCO7dp6MKQs3CqEpyxR1jVrIJnFUUBlyBAyTT7KMNvFl6FNKv6+Rf/O2vHBSphPX6C3QD4MftjYvdhQHMEidRhuZ4zAl2CnBy3PdLMUV6vZCNpVjSAfmIQ21oX3LqlLumkLfTU1zxIWRU7ufcprxvPCl+vgYWWbkg2TRg+ORWd2nXcLTuAHPqc8/8TewJZbgOmNnQ/sWk5rBobBfcZqYEOqZatQouvskt6jUOIanZCWHJflrkA3zfz72q+J19ubVQGAQBsMrdMAuphpZlr9feURkxNGaIienR9lexc+LcaVzvdeBRrrXopsCohQ6F90UJ8vGW532JMgaD7o4zRSO70vORsq6J64E2MX+THVHFuOvSzkzV9WN4kJoz+m1C2f+4wKRrqpIC1wjSUgCFkYN3xOdb69o+iSHw2u4fn/1WiPMhaZKtEVAgdFU6danbyF43nAyRMAPxpbadUeCFMsp0tZtfMnM5gKUT4D4RkRWaMXx4E6sDubAH/ciMvdJx8iUHZkVozIXZCB4vlmuQBBfcdNVcU5V42a3Smpp1kN+5Rn38ak5WHLnk7JvB29mlMERrHUa/ybkXZTlzuGysLVFNeG/2meGgB22dmhUWk0lYhn2BIWsxfPnKg1wKvf7ggGRxnEI266+/Zr5jGN65fO7c3jmZHPQ0MSOIxj3I81fEWZLFPIwWRyy+ntEw7+9Ql5tXarxZyJYkjKBAhwf0/LBiCwtELe4JtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(31686004)(2906002)(83380400001)(36756003)(41300700001)(2616005)(31696002)(86362001)(38100700002)(6506007)(6512007)(53546011)(6916009)(54906003)(26005)(8936002)(186003)(5660300002)(8676002)(66476007)(4326008)(66946007)(66556008)(66574015)(6486002)(316002)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3kzOTRMYmZ2dTBrTWVEL1MxZ0xLQWtOcXoxeVhOZ3VFMWhyTVBqUjVkck96?=
 =?utf-8?B?cklSV2twc0swSElQbGFuYTR6QzRaTkNRcjNWN3hDQzJkZHNXQ1RlakdHWFhs?=
 =?utf-8?B?akJRRnRYb0tRY0c2a0ZRcjlxTld4aDR2OHpucEdyaG9SbS9lc0Yza2grU3hK?=
 =?utf-8?B?MnpaeXNnVitxSG9qNzlEeFVJdnhpQmFoeGFHRWhEZjUydExvV05sZU5aOTR5?=
 =?utf-8?B?bXJCT3N2djFlSzVJaVZjTmd2b2lUbG9NYVdPdjRMZllDaHFnZkxNd3c2bGl0?=
 =?utf-8?B?WjYvNzNSK1l2VkNSbDN0MUtZeWs0QnB3NU05NXV6aS9iMlpPV1Z2WEJMR2d4?=
 =?utf-8?B?SW56TU5XL2pHOVlackFpMk4zUkpqYnRnM3QyWEVseHVIWUp4YXNKeUhaQTRW?=
 =?utf-8?B?TjlTK3EzaHZxQlZMRit5Vis4QXVMNkgydEJHREdqNEFtRFZGSC9NZitGb0VH?=
 =?utf-8?B?Nm9HVXlzL1l3SENvajBVenhmTHVjOEd2cFRJWm1acWFTWFhDT1h1NjFlNFVD?=
 =?utf-8?B?NjFzZ3pwTkxrRHZZWE1NNWFzSldHR2FYbEJ5SmRFVllzWHRndW5ON3BUak1U?=
 =?utf-8?B?c0lYOTlDdlRKMUtFODNTdldTZHJDKzlaWUx0RUgvZThrdmJvSTFKb1JKVlZ0?=
 =?utf-8?B?S1VEOTRIMUwwK2V2UFZwYWRLNHc5endmU1lTWlVaU29OV09CMUR4YitiTXlE?=
 =?utf-8?B?d1hYUlMwQmpMaVZTcGNndUJDWmVURDZqMnVzd04ycEZLRzlsbDZ6ODkwMDBJ?=
 =?utf-8?B?SGdPT1c2cUhvVi9aVk9uTnQ4NWFncDZQeFUxcGg0YTZMdTZoMzZ5Z2xjdmtF?=
 =?utf-8?B?RW9YcklkTnYxRWpUZ0lwWFVyNmJWeXRZUHdLMUJBa2w0UmFIS0pNcDFFM3Zn?=
 =?utf-8?B?aTdvWGVsa3ljWG5YTUUwSEFwRFo1WDdtRFFQa0l0eDhNbXFIY3BVLzlWdDNp?=
 =?utf-8?B?Qk0xZWJoU1lpV0Z2L3dhSmw0SEUraXplR3dHRm84ZENIUUVIYUVlWExobDgz?=
 =?utf-8?B?UVRjRXN4QWtmS3d3QStZTXk1aDFnM1hnMFNSSWd0WHUxemdyaXZsRXM4OXg1?=
 =?utf-8?B?M0RuMjlJcFQzSnVuMU9FR25EZHpPcjVteTFtQnJOdGRTWHdDZktwNzVhaTBi?=
 =?utf-8?B?QjIxSU5xRE9VT0JXYmZKQzFzS1BBb2ovMXdwbDlQUmpCVU1nWXdHQ3UyZXFI?=
 =?utf-8?B?Wnl4aVV4SjI1ZmJUMStmd3cyalZRelh2Mm1oTEZsQnRyR2VpbGRPeG5zY0x3?=
 =?utf-8?B?cHY5cjZjZUNZYlgyZEhuMCtWV3NnZWdJQ2VkS1BMV0kzVkNxTndKN0ZDQjYv?=
 =?utf-8?B?N3VhcnB3NTRhdE5kQXV5N255U3RmVGwxN3JZbVlhU1JBZmNnN3NubitHTVVI?=
 =?utf-8?B?MXF5NURBY3hKUHp2d0x5QkFFVDh4dG5TclVzZXlnazdFRFpJYzM4RVI5dWlC?=
 =?utf-8?B?UEhvcUVmaXFIaFRJcjBvU2tBd3VCZjNOaXp4b0xnWFEvRnVPdC9FdTRJMkJm?=
 =?utf-8?B?Wm5nREJleHh4R1E5N01BUE9NR3VEU3FOZkpzQUwrWTUvZXNWaXhXZjRXQzM0?=
 =?utf-8?B?Vm5pZU1RelRCUmEyYnRlOFF6TTVFNkhFZWNLaVVvN296ZGVsbTl2OXdVY01L?=
 =?utf-8?B?L25FcDdGUnVOYzBrQ29lOEtBckxtZklJeHBVTXY0WmNOeFpQODNUK3JQcnAw?=
 =?utf-8?B?WVZ4YTR0TjJhb0hZeUd1enJVcGRFTjNBWmN5THZtc09HQi9ydTFrdnJNMDFG?=
 =?utf-8?B?Q1VxSkRXaHJxMHVJbVJVMytseUtQU0N2Z2JDWTR2elBJclU1Z0cxNFFYZ09v?=
 =?utf-8?B?ZXNRYUNSMEJmVTlVQkVaQ1M0TFp6VDBmTlRRazl3a2JHcUE0SEFXVTB4bCs5?=
 =?utf-8?B?RDRlcUxoOUt3ZVdTMlFvckI3U1dFVkxVcUVXNU9XVVVWRkFjY0ZGZFZaMEFX?=
 =?utf-8?B?K1VMZDJlZG9MSXFOM1AvVDZtaFB2MkZMZGRTODVWamlhMUNtcG91aXpFWk1h?=
 =?utf-8?B?RHZXakl6QWwxT0c2SVpDajJqdzRyb210VG16NVd2My9oam5GSEwyN25ZaFFV?=
 =?utf-8?B?ZDNqRDJPZ1k3eUs0dWxjVHhTYk5Td3FWbklzVitRS0xycHhvN1p1QmZHYjJj?=
 =?utf-8?Q?BI/50KFvYg45D18bIEYBkVf3I?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856033f3-3f3a-4a2c-5d55-08dac8a1a80c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 13:43:06.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aj4HkC60nOhpuqg3vX/MkgCg3AXfY4oP14v7QkWx5Ve6tQ8xHI7NF+iQJ0PSikT1jz/yIuYGooC2nonZkG7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2022 13:28, Andrew Cooper wrote:
> On 17/11/2022 11:41, Marek Marczykowski-Górecki wrote:
>> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
>> the table is filled. Then it disables INTx just before clearing MASKALL
>> bit. Currently this approach is rejected by xen-pciback.
>> Allow setting PCI_MSIX_FLAGS_ENABLE while INTx is still enabled as long
>> as PCI_MSIX_FLAGS_MASKALL is set too.
>>
>> Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
>> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> 
> The PCI spec states that devices are not permitted to use INTx when MSI
> or MSI-X is enabled.  The mask status has no legitimate bearing on irq type.
> 
> INTx_DISABLE exists as a bodge to mean "INTx not permitted even when
> neither MSI nor MSI-X are enabled", and exists because in some case,
> transiently disabling MSI is the only safe way to update the descriptor.
> 
> 
> I can believe that this change fixes a an issue, but the logic surely
> cannot be correct overall.

Question then is - what can we do without altering the sequence of steps
Linux (and likely other OSes) take? Imo Marek's proposal is the least
bad option, because everything else would be more intrusive or wouldn't
take effect for existing released kernel versions running in guests.

Jan
