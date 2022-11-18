Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73D62F4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbiKRM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbiKRM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:29:24 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE79ACAB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BggZgnZScM4svskQ0+XMGCex6DkTUgle3sz9b2BMVmfe4YyuK9wIubFsaRArhQdYT6jq5ZOn9S72SmL1LLsEkddBmYPvHgmtspsDY8Thnv0sRG7F9dvdGepTZlO2zP8Suq8aFucQa6kjasfrHSxAR/A0nYUiDI0ydgyFx/fyH8r3wZGX+/mugUleId0HIDXa1IiP33+KsYYZsxOZg3o67XQflK4UZxL4RJ7SXrmIrda4z6JNzFmfTu5defHPxbSuzMFjBqFSpsJBtwGiN5Ho46vgWHqL/j8/wXB/UYPz8hrpfFmjpRKq5fIY/EuOcaThnUUdLp+kIqQoW+tSNXIGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62WL9D3+1ncBlxOPaYn3Ys0suKxJNg14U5FxAy8SQk4=;
 b=cOpiCXp/ciRRXch0y0aU/Vnr4hoL6qa0wzdL0a7XBJWbeeB9shxJ5wI+uYlSvmdTxJPfjV73yMGlKYdFt+ARkEUGgXutX6vJtENlIBZgI978zPgNzNFLvuxy+dFrCuT2YCiFegqQ+uh2tuwsH+BP11msETtEFH30EPNPEwVLIRmbJ5uu1Tu6bNKG/Ffzo0txj8durcEr5ks5oBozJfBrPTJFSWfFBh/9+2TEqC7fALOjx90YOy29bRXlss3+J4fDsQEpaDIiMbt11mopxdqUeh9mZD3au2zVvoR3vNziylNjlmubP3UJho4T4Yk9ZzwidAQdyrDPEvUNNlBLu/SKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62WL9D3+1ncBlxOPaYn3Ys0suKxJNg14U5FxAy8SQk4=;
 b=13O5RYeyrdpb2g1C7TjS0cE38IAT0NMTnFbiuuAfgGsoM4+MSX96vghqvVkeqIsubAvF7p8cDlMu77+c7oBxAVpfMHohm9u38/lpcXntqT0PRfk7O+Qldk5dlqPXaMjcg2DSf6qnVY+m+FEqBi9WzK9XdW2E26yWjtvFhnBmcvzdrnxG5rGcB9huO10Pfjb2FHHcGdtTv4vUke1bOdM1oPfWqhzH8Hv8QsdXIJQOYq0GRYcbPwoqpamJ7y0KP9yfdrMWRj37tVeDSB+2b/HKuRC6zTMaG6SVwoU+u4PO6al/GQLePd8KA2Zgp1ykKJS/8gry/yJxqnVHBIwQApVsbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 12:27:50 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 12:27:50 +0000
Message-ID: <df8309e3-5a56-ccf0-fc3d-16fa52f9fa7e@suse.com>
Date:   Fri, 18 Nov 2022 13:27:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org
References: <20221118023535.1903459-1-marmarek@invisiblethingslab.com>
 <93b6385c-63c8-1b5a-13c0-838f7c03ccce@suse.com> <Y3d1UeCuDIMxmzTA@mail-itl>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <Y3d1UeCuDIMxmzTA@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AS8PR04MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0089fa-893f-4081-5f54-08dac9604f14
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEKbnPUWfuHm3Q7yunTw5PAqcpxZ2S7QhwKtDE2eAwzQ7CcQSNOir8nwDr74XgFnMiV/rGFRTr3nfQZGdyLN1pOTLMI1cNkIiD4p5Aomby84hVvVLHg6di8MlCOzAs6AOtH7SruccRwZ0WTcOPxfKzeWGHkdvkNMirZ4ltziFiYT3bjkdUrEydLNvibL1y+0rf3dPZuzjbu77f6XLcK8EaIgLR7zr2emvUEnW4RGzzE5dA4H5QIqfCSInHFo5Jqtml8ZIhTbF3W5tYh8jZLtySmVHWHs6qT8fpvq+k+fKYwSivPRbKCYTO2ZuaqpJC/ovC5akQDSNyu6picmVhD6Dy1kqUiZwYxzCPKs4qa4Bvjm2kFDn9z7E38qL8EFunAjBKgDuOcoXxmQ8A7LO0WKOEzgIN7CJDHWlZ8yqdS9S1OA5cyA3oEkLKV0BrJ/8rqY0npZw6Xh54SYzGtoy79bS7SWvnol7LhdcpQPWTvCW6msg2zw+57FW3jdOp8reiHwHp//rHmzAJ+KTA1BjExfFOYx1epgNQ4BoBX4t+7VJegD7Sac8BshFj/OhBU/D+lUQfo9nzYkIela/1wwvPWkwlCM9ows0azwN/LLU8XQmzDZw93gHcmQKipdSAtheCQro5sJ2qEVjr8XDs997JrHsxgKL6jTR60CNXPaJlxoX351p13xg+eNpi5ts5zLrGz4GrKnsL4Iz9BQE38+AUlotf1K13CSZQumzKvcSAdcnh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(31686004)(38100700002)(66946007)(2906002)(4326008)(8936002)(86362001)(31696002)(83380400001)(316002)(8676002)(54906003)(186003)(2616005)(36756003)(6486002)(66574015)(478600001)(5660300002)(66476007)(26005)(66556008)(41300700001)(6916009)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEIwSXNlNFBlaFVPbHpEZTBZVjRnWmRiNVVlcnlrdmxYcktDWXNTU1BRRW5E?=
 =?utf-8?B?T0xGTFlVQ2psMjBkQTJPM2VFZWpGeTBFd25mTW43ejhnU250dEN4VkpmTzB6?=
 =?utf-8?B?UVp3YVlEaHBxcGh0NW9YakZDZzFxMmxRenJ2RFJIUzBNMGlVZVR6S3FYME9C?=
 =?utf-8?B?V2VBb0xWMFp5Tk5TZXBUK0tlVHJ0THB5Y0ZpREZGMnJsNy9LdmY0bU95NHN6?=
 =?utf-8?B?Zm51emlwVGlIWjlValdCd1R4RXVEOVFHZEV3eS9pdVdYaVN5dUlsczhPSHdY?=
 =?utf-8?B?bHN0MUhOY01OdHI5WXVWYnBHM25UOGxySHRvSHdYd3JZMHB1TWNUQk1MakF4?=
 =?utf-8?B?MGFCdVVYdHdCZnVrNHhBbU11TlFnZENpSDBLVGdpdTZ4UzlFeUxNc1QzeGl6?=
 =?utf-8?B?U3FXTlJLTEdFcGZwQnA2eHVROEc5QzRrVUhvYWVxSVJsY3dnMXZoV1gvOFgx?=
 =?utf-8?B?MG1SYUViT1BHVkExbjhPZHFmQ2F1aVJpdWpCSUxodnAzRmlMcDBUUVNhWG9V?=
 =?utf-8?B?VG5rZUtsN3pwV0JRaCtHUTVNN3JCQlRNdUZrS3NXUGRFUjBGR3RzWGpqQ213?=
 =?utf-8?B?TG51VzRIU1Q3Zk1vdDFlbERTOCsrakgzV0tBRlowSStGQmthMkh2WWdZT1ZZ?=
 =?utf-8?B?TWxOZUlGSUhpL29zelk0eWUrcFBRelN2eEw2cXlDK2RmQ3pQVWlPdGExVi91?=
 =?utf-8?B?OEUvL2h6bVluZUh6c0laNngreHJ4bzF3S3MzdnVhOXdtVWVDV3BnVkhVaTVE?=
 =?utf-8?B?S2hwclVhbGJUMFJsVDVZRUJoNXZ6enFRbCt4RWM3ZUQ0L2h2YUlJbXhxTnEv?=
 =?utf-8?B?SW45WGRvRG9VSHVCb09OUmN4bk9PbHRSRGJ1bEloUitQOVE1aWdDcE1rZ0Iv?=
 =?utf-8?B?THFiTzI1Ykp1ZlFvK3dzek1NNzNVVk9JYUR1WDRLdnBBZUpFNW9tTkhYS09w?=
 =?utf-8?B?WEFUeW5GRS84cDY2dVlMRXJtcFBBeG5nTTRvVjkrSlpTNGdwdU1XK2Y5MFBj?=
 =?utf-8?B?UitDdWx4aHEya2FITmNKd0Rpb2ZuTG95S0oyRDE2Tzc1NXNJeWhRTXBqOFVT?=
 =?utf-8?B?R2hhdVo2dmlPVzlKdjlLSjFxd1VqUXdiSkpFM1V5dGpHb2lTTEVkUCsxeldy?=
 =?utf-8?B?TFZNd1NjWlN1dXlUNGxDWkg5RW0rUG1UY0pzM3JGdWV2YWlPOUl6TjJJOGFy?=
 =?utf-8?B?VmNPQU0vcFJVOERHVWg0Vm94Vi9YNXZRQjQvZ3NkaVQ5UVFoeDZhcmFwUFZU?=
 =?utf-8?B?OHM3a2ZFRXBsV01UeDRqZ3ZzWStETkxaaksvd3NIVzlhVWd5T3hGUy9uZDJD?=
 =?utf-8?B?eXNqdjk0MUttM3RxTFJ1QjJYcFBhOU1IVE5INkl4VldCVUY4R3MvZUoxSWhK?=
 =?utf-8?B?QnlxZWM1TkxSQjA2Yk95djQ0V1o5WlM5bVlBS0ZZVGo2d2NqVFZ4emJwT1FH?=
 =?utf-8?B?dURlUmhHQ1E0UGxmdi9UdTlNSjdsTDJXMTFqajdoUDhKOEdIYXc5YjVFelJT?=
 =?utf-8?B?UC90R1lwek1vUGJNSmtZaEE5TE5TcGhYT01sZml1SlJaeGJuYXY2WVdHank0?=
 =?utf-8?B?OG13c3lacTRTRWgwaFhtOG9yRFFTMTk5RFlCbzdLSi9yMFhsUThqNzczNXRm?=
 =?utf-8?B?NnpDcXlUU3krekdjYm1uUjFIYVVpK0hCZ0M0NnZWM3AvTHMwcXFMbVUrbU1t?=
 =?utf-8?B?SHdUU2t2YVFmamN5VDVlenhEWStraXdMR3I5RjFWV3htYnZrdVZndnluWjBN?=
 =?utf-8?B?ajM2eUl3NldsbnZvL253NUgwZjUrcHRHRU5ORWhiczFITTlDTUJTUnJ6bHNa?=
 =?utf-8?B?WmRxZ2N6RXdFVnFRNVYzbWVHVkQxMXorY2o5M0VQQklNT2NaWnJLVU5TcXdu?=
 =?utf-8?B?d1B1MWVxS3g2V2lDQnhxRUkzQ2I2eGJkejdLT1VJaVJuam1UbVcvbnFiRzZi?=
 =?utf-8?B?eXc4QTJRSlRtcVdiNy9lcEh4YlhxcUVxT3l2RVFHSWtQMVpvRGJxTVM3Q2hp?=
 =?utf-8?B?ZDNSY1pIUW5PSnlteW1iTGRLcyt1ZjJTc0wyOWlXMnc0WFgzL0VkNFBnUktR?=
 =?utf-8?B?cHJrWWhIcmg2UWVKdStHSEhxRU8vWXVtZE9sdUNMWXRUZ2V5cDlEdlVoaWtQ?=
 =?utf-8?Q?/EQB3ifp2fElO+6NtLNK/KjqN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0089fa-893f-4081-5f54-08dac9604f14
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 12:27:50.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfZKIA9MKuFRHwhiLh3oIQ+senolfnhNkiFywootz90IEdT+K/0k78KoEcypVZC71A/LWHSU81TMKwH7eTRP3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2022 13:06, Marek Marczykowski-Górecki wrote:
> On Fri, Nov 18, 2022 at 08:36:14AM +0100, Jan Beulich wrote:
>> On 18.11.2022 03:35, Marek Marczykowski-Górecki wrote:
>>> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
>>> the table is filled. Then it disables INTx just before clearing MASKALL
>>> bit. Currently this approach is rejected by xen-pciback.
>>> According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
>>> enabled.
>>
>> Similarly the spec doesn't allow using MSI and MSI-X at the same time.
>> Before your change xen_pcibk_get_interrupt_type() is consistent for all
>> three forms of interrupt delivery; imo it also wants to be consistent
>> after your change. This effectively would mean setting only one bit at
>> a time (or using an enum right away), but then the question is what
>> order you do the checks in. IOW I think the change to the function is
>> wrong.
> 
> IIUC the difference is that enabling MSI or MSI-X implicitly disables
> INTx, while enabling both MSI and MSI-X is UB. This means that MSI
> active and PCI_COMMAND_INTX_DISABLE bit not set means "only MSI is
> active" - which the function now properly reports.

Hmm, yes, this is perhaps a good way to look at it.

> Both MSI and MSI-X active at the same time means a bug somewhere else
> and the current code allows only to disable one of them in such case. I
> could replace this with BUG_ON, or simply assume such bug doesn't exist
> and ignore this case, if you prefer.

BUG_ON() would imply this state cannot be reached no matter what is
requested from outside of the kernel. I'm not sure that's true here,
so keeping that aspect unchanged is probably fine (and with the above
I then take back my "wrong" from the earlier reply.

Jan
