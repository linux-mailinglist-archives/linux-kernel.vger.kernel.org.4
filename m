Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5473A3CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFVO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFVO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:56:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F09E9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqawvTSD9MBXud5fjxhnIiUBYQYlnrQpAZKhZZaD1HLemkOZYEtws7KxzHWRSFn/DZGp3daNy+FWHo0Wdb9VYipaeE26NkOLsxUtYLWMYQpCj76yKiw5Z8Iz1uLW8JVtSPvUD3V+TyJhyBgKUn2eDatcUO/WEPjjrfuTxip2DEQaDV5cZTJd82EeFWo+UUlZkA/I/qtfrYe+rHPCYc+cZrgI0iWa03HRxjHvHPpusq9P0QAXBW7KzY45hKb8Ue96m+BbBq6OAWeDsXkYdUS9MC3tEFq+hcS8OJnhswcXd5Zo2m8F7miQbOdXLPQUA21rlHGY4TAHoTsh031VUmioJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c77r9jxygKjLoiIj65XuNDEJ6PoFjXJulnKGIAqBtF8=;
 b=HXUTFBMDhzl9l+4lVFeXzXgGvj+a5BIgJW35vfoKB/vr5wDEvA7iTMI1hBAAU2quWV1UCKymFhYahgIqWO65bs9+W/53sCWAGHY9t3IyFZ8lnKit/0cqSVG95IOUdCJszNj54xp7d2dW+1wcNq+pYhtOSSGdEQtT1xL76WZmAslLvzNX0yNQc/3c2k24Xp+SxySYnd8SSuDx8aO5tWBEdfodeQKsoWpVCDgHMSB7VLEIvJ27p7noyNDPdnVzTAKooi8kqnvMUL5bgLZ5izGzMxR20Qy/+a1BKwaRPkVGca6HiqAQaE7gJXZa4jyQ35rUgCU+Fjsh9i4m4i3P2+IbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c77r9jxygKjLoiIj65XuNDEJ6PoFjXJulnKGIAqBtF8=;
 b=c9jN0LexiKxzCVeAXXSa0Nh8+m+8kkJ1WkQ4pqK8KLH0GO3tJAc1Z/gHqPV+E/LMHKWlXE8uIM1hu8zIjjrAfzv+JXvsG82oXnSUKhv1PaGFwRcqMen08WmplOIZKIyUwpPAfOr4NLVjQxisJqtF6Ed2EsYHlAP/6XsRcCLHujhJUgeJwo/QbGof0IamUfxlYIUhnL6eAEfA4TiSg7BAbq/pUWig9Z0CdTNYON33k312EP6S6hbtqBwifooQk9P2Iw43XLkaRHLqRQ1Ar8ZtxQf4ifSHpArWmzUT1YkfW9RAiQ0IwerVkAg52NjVH4Qonw0/N62n4iuHzB5knCQUJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 14:56:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:56:55 +0000
Message-ID: <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
Date:   Thu, 22 Jun 2023 16:56:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Content-Language: en-US
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230622085112.1521-1-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4aa897-8575-4b99-1f3c-08db7330ebe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuzHnoNUtS2vVfjL2gNzTGm7vWY2jWwqRybEBg01GG9s2zNM50YTcEl+1aYeD66Aw79KaBOtqtRi+teF00V2erKEUyMOR5WDEfLfnanFqg62pGHyS3+Xn7kZ1ESWHfbfUDOWGX9uDe1DW20TYNo/9bJ65bf4wroxMq45E9HlLWBGjkAx6XRVkGLGPyyjleZKegqMOYVjsn01Z7aqzbWq7h1uMjXZbZWzD1HlSqynSeyKej5BEx62a+ZF+Dv1NvAmXlB4GltCBN35R8pPoDsH/AJjPSypLld+LyZ/7fgua6azsUD0VODmghYyqQqaT94prYoiWhInBc6spkmZB+xpEG9gDRjm7i6mcUVdysLj2tmrZL9oSNptpZ7m73hMNkuimcvptoCO0akEiON+yGe407THkFNatKq3ib1ep6/0jFXZeY3TCj0Rf1nz3LLj2DEH1f5REh0rWUqCkbH9vL8VBNYEjEoxXa96C1pQWG7mbhZep48U9GyWnrhCvM/UGTLNKCUHRf0ip9/1Qed24u1bi+W0aDGIoMilfV5zQRAGUuC7Mw4aO40dlqIZcOb/FdCuJ4gVUFpdCI0tq6OWvKBLefh8t8gJm5fYaXRHLQEg5ph7Ep4Bibuj4bYmhpC8FxUAI/8FWJ7FbjJh0SeUgBD+bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(6486002)(38100700002)(83380400001)(186003)(53546011)(6512007)(6506007)(36756003)(2616005)(66476007)(316002)(4326008)(66556008)(66946007)(2906002)(4744005)(8936002)(8676002)(26005)(86362001)(44832011)(31686004)(5660300002)(31696002)(41300700001)(54906003)(110136005)(478600001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjFWT0tvVHl5dlhKMXZOalFOZ09DZ01qWDdCRGgwV3FrSHVTOUNhY2loU283?=
 =?utf-8?B?aVNVK0dvWVZKQVZJQWUySWVSQVQ1RTA1d21aMDhEQmt5N2o5czV0cjFRVitY?=
 =?utf-8?B?eElqUlRDU3pid1BYTEo3aStVNE5rTnFoRXpiUHNKdzFOam8wMy9BTnFzSW5I?=
 =?utf-8?B?blFQdUoveFZRQjdkN1lzcEptTmtLUzJ4amFCdWFCK3JoTHpXOHJFYTJDVXkw?=
 =?utf-8?B?SXkzZ2N3TnN1bThUdUdyRlQySnJpdmVaQ0lIUXZwZlllUERBTmZCVFlsZVJV?=
 =?utf-8?B?YXp0QVg5U1F6YUtoU05QTFoveS9xZVFIQ0NHUGN6V1pjSU42SGxHWmRaOURL?=
 =?utf-8?B?ZUZJbC9jNXNuMDVqTGVabDFJNzBCai80cmhnNlN4MDdORHozMGR3SDluMHp6?=
 =?utf-8?B?RnVPUXd2VCthNHdZdjhBSEpqV1hENHFrWnhMWmRrSWJBSnN4TThGWEN1cG9a?=
 =?utf-8?B?QmI3Z0RRanp5aXU0ZXVHTmk4ZXdZaUVRZ1JPUEIvUzF3b0VmVXRVWloyek1Q?=
 =?utf-8?B?Wm1hcmpBQlBybkdKOG5xK0NSVnNqK2lMV0ZCZUJiUVV4ZUtRWU1abHd6ckdy?=
 =?utf-8?B?Vk9pY1RjUTlmRlZZTDdZMGRVYVhyZ3U4RmxuU0FtSFllZGV5YVRCWUVqQkor?=
 =?utf-8?B?ZnVOa1BBRjNFL2JiazlXei8vcGR3MUdWSkxKZklscFc4YktGMThucG1xdmNa?=
 =?utf-8?B?UmZzWHJYRFZ1eFFXV3gzbmxJdHRhd1VkRUdJYmhUTzg1SVR5RGhpbVdua2tB?=
 =?utf-8?B?WEZ5Q3NrK1BFYmRMZ1RQYmthYUVyNG1nYzIyeG1WM2dzRHJuRVE2eWVhK3Y2?=
 =?utf-8?B?aTY1eFhEL0Z1dUFFYmN3eTRkWmdEWWFPTkZCak8vc2tKcW5iTFpURFkxa2JI?=
 =?utf-8?B?NnNSeGRJS2lEYzJncmFkaHkrRHY3Y3VlWmVqT0xWZ3p3RzgrY3N3cU9sT2RO?=
 =?utf-8?B?Q25vT3llZmxMSEJvcFNreC9hU2x1QzhNUFpTODBwMmpIblM3NWZNS0pNYWlR?=
 =?utf-8?B?N3dWZjdTMjh3L3YzMndHVmN5U0t4TisyTG5KOUlRSnhyZlpWZUNHeDBoUzh5?=
 =?utf-8?B?NHM4clVTNHV5aVcxTDAvQ2RKODltZm53T1lWeVBlR1dCaEtkZHV2aGR2QjRk?=
 =?utf-8?B?U1ZKYVE2Z1hGM29DbEp6dTNMRVFuTEZ0S0xxb0ZTV0tCS0VMTmg4UjBjUFQw?=
 =?utf-8?B?N1FVd3ZYU3JqVjNuNitzVVVhalUzeXBVS1Y0MUdsZXRzUEJqN2wrbDFRd2VX?=
 =?utf-8?B?cytDQ1ZjSmo4VTVrei95UWZ6TFRWMk85dC9salVVV2ErZEd1d2o4QlpkNXgx?=
 =?utf-8?B?QUR3bVZDeEY5eHRPMm1KTURqdUROMWsvQXNBVmkyY3pDZzBFRnphZ0l0eitK?=
 =?utf-8?B?UE5MUG1aejk4MnJEN2psWDhPMTJjZmMzZEtKeUNHT1hoVGRVb25NOVJEMlZJ?=
 =?utf-8?B?MmtJL2MrUk9XSi9SWTZHTUdPTGQyMkdTZktYSXlWM3lYSWZqR2wrcWNxUzNX?=
 =?utf-8?B?ZUtFVUVzcFowdUhHWFVMSUZhdGdNWEpqZDJhZWVuems2TFRGazcyYUp2Z1Vl?=
 =?utf-8?B?QVh4RXRxN0ZPVmVmRzJERXBrN0JRRFN4bEFWbjNwODdjdWtMZ3hSbStQOUor?=
 =?utf-8?B?b1hCc3dzZHJUVjd1UE1aeVA1UnBaTVo2ZWhERlQ0cVptZk9ZbzZKdDNIUmZN?=
 =?utf-8?B?aGsxak9mOGwyQkwydGtVbkRyV1VzVjIzd2dtYy9KSDR3TENjWGN5ckFXUVkv?=
 =?utf-8?B?QWVvWkRmWW5abng0Tk5PSUFJRW5mUWRET25TR284bjBOZFV6VnFCSFRZcjBq?=
 =?utf-8?B?MUNYelFqVzFrU2kveGhFVkVVUklsVGZGTnJkN1dqWjZvQVJQTzh6aERHdFVs?=
 =?utf-8?B?aWN1dU50cVduN0FsNURpMytKdEsyb3B2UFBLbm5Udk1BRHduYnlzaDNlRmJ0?=
 =?utf-8?B?cHMyekZ3VU1jUisxc0lBUTY1TXlyTmVxY1hFSWQ3cU9rcHI2UFg0NWxwOGVk?=
 =?utf-8?B?cENjWXR3V3Rva2JUd0RBNFl6aTVYTEFXYnZLaXhodGY0MWFzMlNJZUh2Vzl2?=
 =?utf-8?B?VWdpUHNVNEc3V1V0NUZWdVkxYmFvZTh3cHJMQ0M0Vk5PckxPdHcvUmtGZVRu?=
 =?utf-8?B?WXVvRFIwMHQ1ME9ZL0VHWEkwV0pyMjYwZWp5aGtORkV1eXgvUlJuZTVHZXpl?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4aa897-8575-4b99-1f3c-08db7330ebe2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:56:55.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5YrzEnyIGVPaBBU4vDJI0p8t1RQhw3X/7JwBHHlYrKCV4xVBB+fjB1qnvU3w+ioPqpfeQrCxF2oOjzY7snPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.23 10:51, Masahisa Kojima wrote:
> This series introduces the tee based EFI Runtime Variable Service.
> 
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
> 
> Changelog:
> v5 -> v6
> - new patch #4 is added in this series, #1-#3 patches are unchanged.
>   automatically update super block flag when the efivarops support
>   SetVariable runtime service, so that user does not need to manually
>   remount the efivarfs as RW.

But that is not yet resolving the architectural problem with that
userspace daemon dependency. What are the next steps for that now?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

