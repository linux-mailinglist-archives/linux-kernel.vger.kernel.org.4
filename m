Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252FE652745
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiLTTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:44:24 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2090.outbound.protection.outlook.com [40.107.105.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CACC22;
        Tue, 20 Dec 2022 11:44:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyKMj7Lk5DQApQqfGJuNl95k71IMAxM8TBdXfEhIapjWN5Mr//I7Adu/qJq3c0JIU4e7rRH9+SjXvSc5VgFoMURtCnFsn6kcQB3YzowphiZu3eqLp+x8BNUpmVNGKf+V8MUY7x4UamNOmQVPGxCmWYUcU0IrXw7e/APOew2Fss8f2211SLmPn7AXTOQAI9GG1WOgLM5RjgFwPwM11DUVg8MhDdWww+n7zVdDqqHL5/wqkidvfTiL2p+0dXyLnu8uF1jtBFzDkfKwo/dhZ7h0pKTNkbruultqeNhCN1q/1TysNaZhKaNny5oa5O48Ev4V2YgeLxNEup08wVEvu0Y9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXdRkEKQLyCpoxtDcDu1bNdHgF0TgxY5NlEaA6Fvh+Y=;
 b=hN8kNsG37Q0QMRB2Lhes64acQCrKAH2DyNORqmpQzVCCroT5RdEhpjo/0V0b8ezNh37+0fI6jjDUVAWD5zQJeHIAXDwKpxdUqu8DdzJVSIIdVzHhLOqdWWNmMQag8W4GsCIIII3HrEEgyildD29oVUJQ8H+ecnLdwgFm9F97UMui6lHGUVMJjx3BCopHAdqsrzQYKp/+x+/7jyw0tE/TQbS5KHdTat2v4ZlO1Sn0pbp3aP5IZJz3Ua9ojiOQ9gWSCn2VDjx1TIdJp6cctTkP89hKc/k/2Yv5HCYXCFr5QiZFDo9hSZBw3KolzvNZNgo+M5V24jKM+GBso32NaCorjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXdRkEKQLyCpoxtDcDu1bNdHgF0TgxY5NlEaA6Fvh+Y=;
 b=KJifZO7ecFSIeu/XM6lzUA2mkj+i0kGamlch9xnEcJeuJ7SbO47CLk7LdT/ZlmbDoTk7GX1bllLbhPWPTEqqBoKXPwphVSBnCUDSnhDapyOn50k3PY8C1e85+cTxLqxazUO3NAwAs39q7si+S+UnEI3IGT5Wu5G0ty7foXjxmPHqnNOWHsP3PGq83LsXutKvsFm58TG03ab1bQ0QIGG3Afr4r2WfPwiqqcehckUjNZVyp/1Qmmlp+MotHKTPf8dd742ndNkVgD3ahjP53iQj9cxkF5VuwpLvP5hrxkhWtG26Au2/8i5FZ/DFjC9H1glyhj65Yu/OHs7OZKAUVWcTIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBAPR08MB5830.eurprd08.prod.outlook.com (2603:10a6:10:1a7::12)
 by PAXPR08MB6736.eurprd08.prod.outlook.com (2603:10a6:102:13e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Tue, 20 Dec
 2022 19:44:19 +0000
Received: from DBAPR08MB5830.eurprd08.prod.outlook.com
 ([fe80::da7e:a56c:aa93:9ce8]) by DBAPR08MB5830.eurprd08.prod.outlook.com
 ([fe80::da7e:a56c:aa93:9ce8%4]) with mapi id 15.20.5944.006; Tue, 20 Dec 2022
 19:44:19 +0000
Message-ID: <2e5f30dd-c694-7b83-69d0-685e769ea5b6@virtuozzo.com>
Date:   Tue, 20 Dec 2022 20:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
Content-Language: en-US
To:     Sagar.Biradar@microchip.com, james.hilliard1@gmail.com
Cc:     martin.petersen@oracle.com, christian@grossegger.com,
        aacraid@microsemi.com, Don.Brace@microchip.com,
        Tom.White@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gilbert.Wu@microchip.com
References: <yq15zo86nvk.fsf@oracle.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com>
 <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
 <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com>
 <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
 <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com>
 <BYAPR11MB36065EE0321C0AE6A4A3ECC7FA049@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4oej_E3tHm6tzOAhA=n2WughvDfQsaxKbP5Sxb+CeZu=w@mail.gmail.com>
 <BYAPR11MB360625E5945D5D3B29571857FA099@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4oNCrwHBRu-rUZtnxoqVkvyxG_Cg07RTAuwpNsGfjWKcw@mail.gmail.com>
 <BYAPR11MB3606FB1E651EC9B51BD8A0B7FA1B9@BYAPR11MB3606.namprd11.prod.outlook.com>
 <BYAPR11MB3606E15393A4C11CCFAF9C53FAE69@BYAPR11MB3606.namprd11.prod.outlook.com>
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <BYAPR11MB3606E15393A4C11CCFAF9C53FAE69@BYAPR11MB3606.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0101.eurprd04.prod.outlook.com
 (2603:10a6:803:64::36) To DBAPR08MB5830.eurprd08.prod.outlook.com
 (2603:10a6:10:1a7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR08MB5830:EE_|PAXPR08MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: e9112e52-4788-4513-ef0e-08dae2c295b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBOY8K3ZtUTNHqhEnxOIGHzWMUb/MU5b1JuLM4XCDTue+2/KA2OdvmxifotPAZsymXi8RojKGT852/zAkn4RLdi+QjDvSFG5oCnXbR7hwOXSYTR73REmDPW4KEMlYnL/QDXCwUW5oVA76c1cDh7ax92LwzFY4Tv/+FhXyi2hdjqIJKKLRx6cqBZzw8vpqQQbKDM2MvQYF/Jo9fom+8g1tUAoW3b3kBuUtrOVcH2TcHcFny9Q8gDzppnG9GMvJEiB1bUjyF6pXiBZsmz+gSbHCG5kGVk9vBBFK+BpHPy0CzlraeL+ZRO3VPt+tIkPeh1/xjgZAgbx0eUYFx6twQ/Lj5XFzjwMDpSgUz4UlDJCNI6hhJRj/PQQz59DipRL7qmdQtOs4NvkEv5rt8B+xLmY7uptfggISd8O2oifYArKYug0zjxVXrTJY0fLZBEafikkRSqhquQaA9ZAt3wU1nC1rjSGpnCihkpZDMP9mC0CPm+hA+nL+j2LxQer5EE8oagEJXHmrmssWBckbLd5iXljljFx9zvnIzOWqMXApgggaOOavllotInhXj7hCh3p7EH250pUz6Nko9m6AJ3uEDGIayMPioMrBwG4cjainspdBTg5yMTycUOfGO3DKJIGUbnJxe6VvH13eONn8eSUO67lGIxNNRkI2v1hZkBC1UqPQmgPy/I5mVj6NttBk5INpefJA+2Ot0Y5USZD4/8NmDQBokAFnLowSv7ZrtAck06quTVADs/p5/rKwWPf88BsfbXyJchGVDkQvtb+UIRi4ngbPUi9TmA5wjhxNOtrbrtfbVcPYYm3gygJACs9MIHUDkRwSj+T+Na4ciNmNq7yvPWjpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5830.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(451199015)(31686004)(38100700002)(38350700002)(2906002)(41300700001)(86362001)(36756003)(316002)(26005)(6512007)(186003)(45080400002)(31696002)(66476007)(5660300002)(83380400001)(8936002)(66946007)(966005)(2616005)(7416002)(30864003)(66556008)(4326008)(8676002)(66574015)(6666004)(52116002)(6486002)(6506007)(53546011)(478600001)(43740500002)(45980500001)(473944003)(414714003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHE3Yks3dHVlSXRjakVGLzBqSkRPYjRyUEVnVXJFQ1V5VWNpakRJdmtseU1W?=
 =?utf-8?B?cWNQN2F1YU5hQmlTODJvZjIxUzRtVktwZko3cEN2dUlsWUFldXVPTFg5OUZt?=
 =?utf-8?B?dEY1dFEvNEFyVmh0U0ovRTRqZ2wwUjd1RkhvTzVEa3NBRlBCT2xHODlyZVpK?=
 =?utf-8?B?cFp6SkRHUWw4M3ZvODROSEJKb1o1d1dISTNOMmpyaUVpRUwwamkzakNHTWE4?=
 =?utf-8?B?ZVNnRXExRGg3d0U2U1k0SFBYaWxkaTVuOWVsM0lZRVpscWdBWEZnSTlScitS?=
 =?utf-8?B?N0kyMG9OWTJSTGpQS2ZObENwK1hrK0dGNzJZYmUrM3JkN1doMkpYSjFmUGZp?=
 =?utf-8?B?blAxaE8xczJqaXN2aWcvZnorU3FxYm9wUVdkM0xjQXBNL01pb1c2b25sbzAv?=
 =?utf-8?B?ZFQzbEFKZGN5MHN4cTRhVlcxY1BlczNrU0ZleDZPNVlpOGZ4Nmk3SlhQSmFT?=
 =?utf-8?B?SnMxeEFUaEtLcGR5L2N1dWwydk9IR0ZDajRLUXBHdkNTN0ltSU15UWU2Uk5z?=
 =?utf-8?B?eVBLeVIzckFVTk1IdEZjSi80akllOUVMcVVPM3FJMGg2RUg1VExra0hTU0V4?=
 =?utf-8?B?dzN5c3RCbWdxRWhHYUZtOUFDMVY4NWhmdm4wb2NleW1KdStlMWZFZEVNNFc3?=
 =?utf-8?B?b05FVlRiNzBDYU1MU2Y0RXpxZUFHV2xIZXBsbmJJclBXYmhML0tOaERETkxP?=
 =?utf-8?B?eFlKem8xVm4yZEY2Ti9la01qUDFhSG1udXVPQysveFV2Z3hrVjZPVDVIMUhq?=
 =?utf-8?B?bzU4ZjF4MG92bVJETklFMEpaeDcwdTdmcmhRMHFMdk9hZ3ZwS2o2VmpMeXJh?=
 =?utf-8?B?VHhwTVVTVlIxcUhEYzNCSEFGdnpBRUtIaGIrazB1ejZLQm83VFY4SDl5U3Vi?=
 =?utf-8?B?RVJ0bXNSREoyTS8yYXRLTDBmZDlHd2NkRWZtZ0FZTndKZXRMSkxISXExbUs1?=
 =?utf-8?B?Qk8zd2N3ekJnaEQxYktaS2c0UGEvMlpUN29vVDhLREZsR3ZZTzFpMmhEdDR4?=
 =?utf-8?B?QSs4WEt4YVpsbmlQa2VFckpqK0JhZ050ZGRNU29PaXFWMHAxNDNzcUw4eHdU?=
 =?utf-8?B?TS85N2JjRWdTcEo3WGZGaWxhTkh1Zi9TNUo0dUQ1cWQ2dDlPZXpmWGM2UUlO?=
 =?utf-8?B?d2lySmVWbVl1WnZBU045WXNFT2JmSmdPYytocjJybjlCZ0tiV2czSDlZaWRS?=
 =?utf-8?B?WHpnNkVneU43cDNSeGJJMmZwL09yMUtPT3dETTNrRDVDZ3M3UkJ4dS9RWDNR?=
 =?utf-8?B?TFljOCtMK296dWtHcDVtQkw2ZVNiMEpoK0x6RElFRFlMalBxUnZJQk5hc2c4?=
 =?utf-8?B?ODhHRFVXQjRIYkRDZ1dxRDg1cWRxVmNySU5KTVpERHN0dEVBZ2QrS2syV2tG?=
 =?utf-8?B?bkVXRE9aYzBqM3RxbHBla0Rnc0h1a0NBNEJNbFZKeXd2Y0dMVXZwcnZqSVpN?=
 =?utf-8?B?M0JmWVkwamlxaFhtNUp0TEhhOEtFUXc1NGprb0ltanNLcFpjVCsvZXBiS2Nq?=
 =?utf-8?B?NTJKbytTUmhqU2xRTzdUVktnVkRLRlJwU3AzYjE1MitqR2xXNHNmZWlEYm93?=
 =?utf-8?B?YVRKWkZySy9mZ2hPV29hL3dWMzRHSXJyYWIzWXYyUmRZUmErNUh3Zytob1cz?=
 =?utf-8?B?RFJ2dVZjYi8zUU8zOVlweUlWRGowQ29YQWtNWVJnNzVpOFJuN0RkWUVnbm93?=
 =?utf-8?B?d2p0RE5neDdvNG01WXVqMGFad1VjZFc0dXIvLzN1QzZKSXYweTQrNDlLdGgv?=
 =?utf-8?B?N1RyWk1oTUswRzZoTjZUdTcxeC9VK0hWWVhvNTFTalBjeXdOU2Q1QzNQQVZY?=
 =?utf-8?B?N2ZrcmJNRmttVDFOd0xSZkZsZk0zQ0ZsQjVIeUZMb0lFYnJFSUpuZW0xNHNq?=
 =?utf-8?B?SlZnemNQbkJ5bTFwRXoweFVWQkpGMUFQWmIzZmJpT3lCdHdCampiQTRRZFlj?=
 =?utf-8?B?eXVHL0xKR0tUV0lkeEVFcmhBbTFCcTI3NkpRUFhxN0Vsc2dzU3hPUmlodlhu?=
 =?utf-8?B?Z25DcTcvMzlabEplRXdBUlFoNFh5aXpXN1J1OFZCVzdpclNYdDZXcE5UdTFP?=
 =?utf-8?B?a01FYmZtSUl5WjNqVHB2UkRVcGpuWXdiVklZMTc2TG9XenlBS1k5K25oUHRB?=
 =?utf-8?Q?t3iUeOnrf7ppg7cyEK3c/NliT?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9112e52-4788-4513-ef0e-08dae2c295b3
X-MS-Exchange-CrossTenant-AuthSource: DBAPR08MB5830.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 19:44:19.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNkFOi73JIRJ/NS8qW47hCrsny62ppd7t+dnt232k1FWRe47ZVxBN7dl45+hrQ/voWOhpsOQu/yCxkyZQBkSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6736
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.2022 21:44, Sagar.Biradar@microchip.com wrote:
> Hi James / Konstantin,

<skipped>

> Konstantin,
> Is it possible for you or someone you know to test on your original test bed with the "msi" set to "1", and post the results?

Hi Sagar,

thank you for looking into this.
i'm very sorry, in my case that was an customer complain for a Node in production and it was long long 
ago, unfortunately we definitely won't be able to test anything nowadays.

--
Best regards,

Konstantin Khorenko
Virtuozzo Linux Kernel Team

> We are parallelly working on additional tests locally.
> Please write to me if you need more information
> 
> 
> Thanks in advance
> Sagar
> 
> 
> -----Original Message-----
> From: Sagar.Biradar@microchip.com <Sagar.Biradar@microchip.com>
> Sent: Tuesday, December 6, 2022 11:30 AM
> To: james.hilliard1@gmail.com
> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com; christian@grossegger.com; aacraid@microsemi.com; Don Brace - C33706 <Don.Brace@microchip.com>; Tom White - C33503 <Tom.White@microchip.com>; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly resets under high io load
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi James,
> We were in the process of finding the related information and we have finally found some details.
> I am reviewing that as I write this email.
> I will get back to you once I review and sort that information with more details.
> 
> Thanks
> Sagar
> 
> -----Original Message-----
> From: James Hilliard <james.hilliard1@gmail.com>
> Sent: Sunday, December 4, 2022 5:26 AM
> To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com; christian@grossegger.com; aacraid@microsemi.com; Don Brace - C33706 <Don.Brace@microchip.com>; Tom White - C33503 <Tom.White@microchip.com>; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly resets under high io load
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Nov 17, 2022 at 11:36 PM <Sagar.Biradar@microchip.com> wrote:
>>
>> Hi James,
>> Thanks for your response.
>> This issue seems to be slightly different and may have been originating from the drive itself (not too sure).
> 
> Yeah, the drive was having hardware issues, although it does sound like a potential error condition that's not being correctly handled by aacraid.
> 
>>
>> The original issue I was talking about would still occur with the missing legacy interrupt on certain processors.
>> We are still actively looking into the old "int-x missing" issue that we suspect might possibly originate from the patch.
> 
> Hmm, are there any available details on this "int-x missing" issue, I couldn't find any public details/reports relating to that.
> 
> Is there a list of CPU's known to be affected?
> 
> Does it occur in the vendor aacraid release that has this patch merged?
> 
>>
>>
>>
>> -----Original Message-----
>> From: James Hilliard <james.hilliard1@gmail.com>
>> Sent: Thursday, November 17, 2022 3:26 AM
>> To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
>> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com;
>> christian@grossegger.com; aacraid@microsemi.com; Don Brace - C33706
>> <Don.Brace@microchip.com>; Tom White - C33503
>> <Tom.White@microchip.com>; linux-scsi@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
>> constantly resets under high io load
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> On Tue, Nov 15, 2022 at 10:05 AM <Sagar.Biradar@microchip.com> wrote:
>>>
>>> Hi James,
>>> I have looked into the patch thoroughly.
>>> We suspect this change might expose an old legacy interrupt issue on some processors.
>>
>> I did see this error once with this patch when a drive was having issues:
>> [ 4306.357531] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 4335.030025] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 4335.030111] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 4335.030172] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 4335.189886] aacraid: Host bus reset request. SCSI hang ?
>> [ 4335.189951] aacraid 0000:81:00.0: outstanding cmd: midlevel-0 [ 4335.189989] aacraid 0000:81:00.0: outstanding cmd: lowlevel-0 [ 4335.190101] aacraid 0000:81:00.0: outstanding cmd: error handler-3 [ 4335.190141] aacraid 0000:81:00.0: outstanding cmd: firmware-0 [ 4335.190177] aacraid 0000:81:00.0: outstanding cmd: kernel-0 [ 4335.274070] aacraid 0000:81:00.0: Controller reset type is 3 [ 4335.274142] aacraid 0000:81:00.0: Issuing IOP reset [ 4365.862127] aacraid 0000:81:00.0: IOP reset succeeded [ 4365.895079] aacraid: Comm Interface type2 enabled [ 4374.938119] aacraid 0000:81:00.0: Scheduling bus rescan [ 4387.022913] sd 0:1:41:0: [sdi] 27344764928 512-byte logical blocks:
>> (14.0 TB/12.7 TiB)
>> [ 4387.022988] sd 0:1:41:0: [sdi] 4096-byte physical blocks [ 5643.714301] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 5672.349423] BUG: kernel NULL pointer dereference, address: 0000000000000018 [ 5672.351532] #PF: supervisor read access in kernel mode [ 5672.353262] #PF: error_code(0x0000) - not-present page [ 5672.354860] PGD 8000007ad6ac7067 P4D 8000007ad6ac7067 PUD 7af0892067 PMD 0 [ 5672.356444] Oops: 0000 [#1] SMP PTI
>> [ 5672.358075] CPU: 9 PID: 644201 Comm: cc1plus Tainted: P           O
>>       5.15.64-1-pve #1
>> [ 5672.359749] Hardware name: Supermicro Super Server/X10DRC, BIOS 3.4
>> 05/21/2021
>> [ 5672.361465] RIP: 0010:dma_direct_unmap_sg+0x49/0x1a0
>> [ 5672.363223] Code: ec 20 89 4d d4 4c 89 45 c8 85 d2 0f 8e bb 00 00
>> 00 49 89 fe 49 89 f7 89 d3 45 31 ed 4c 8b 05 ae fd b0 01 49 8b be 60
>> 02 00 00 <45> 8b 4f 18 49 8b 77 10 49 f7 d0 48 85 ff 0f 84 06 01 00 00
>> 4c 8b [ 5672.367024] RSP: 0000:ffffa4ff58c7cde0 EFLAGS: 00010046 [
>> 5672.369020] RAX: 0000000000000000 RBX: 0000000000000003 RCX:
>> 0000000000000001 [ 5672.371073] RDX: 0000000000000003 RSI:
>> 0000000000000000 RDI: 0000000000000000 [ 5672.373007] RBP:
>> ffffa4ff58c7ce28 R08: 0000000000000000 R09: 0000000000000001 [
>> 5672.374795] R10: 0000000000000000 R11: ffffa4ff58c7cff8 R12:
>> 0000000000000000 [ 5672.376418] R13: 0000000000000000 R14:
>> ffff88968e1ec0d0 R15: 0000000000000000 [ 5672.378136] FS:
>> 00007ff103d25ac0(0000) GS:ffff89547fac0000(0000)
>> knlGS:0000000000000000
>> [ 5672.379760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 5672.381402] CR2: 0000000000000018 CR3: 0000007ae90cc004 CR4: 00000000001706e0 [ 5672.383023] Call Trace:
>> [ 5672.384673]  <IRQ>
>> [ 5672.386282]  ? task_tick_fair+0x88/0x530 [ 5672.386469] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 5672.387921]  dma_unmap_sg_attrs+0x32/0x50 [ 5672.391431] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 5672.393273]  scsi_dma_unmap+0x3b/0x50 [ 5672.397079] aacraid: Host adapter abort request.
>>                 aacraid: Outstanding commands on (0,1,41,0):
>> [ 5672.398180]  aac_srb_callback+0x88/0x3c0 [aacraid]
>>
>> Does that look related?
>>
>>>
>>> We are currently debugging and digging further details to be able to explain it in much detailed fashion.
>>> I will keep you the thread posted as soon as we have something interesting.
>>>
>>> Sagar
>>>
>>> -----Original Message-----
>>> From: James Hilliard <james.hilliard1@gmail.com>
>>> Sent: Monday, November 14, 2022 12:13 AM
>>> To: Sagar Biradar - C34249 <Sagar.Biradar@microchip.com>
>>> Cc: martin.petersen@oracle.com; khorenko@virtuozzo.com;
>>> christian@grossegger.com; aacraid@microsemi.com; Don Brace - C33706
>>> <Don.Brace@microchip.com>; Tom White - C33503
>>> <Tom.White@microchip.com>; linux-scsi@vger.kernel.org; Linux Kernel
>>> Mailing List <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
>>> constantly resets under high io load
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> On Thu, Oct 27, 2022 at 1:17 PM <Sagar.Biradar@microchip.com> wrote:
>>>>
>>>> Hi James and Konstantin,
>>>>
>>>> *Limiting the audience to avoid spamming*
>>>>
>>>> Sorry for delayed response as I was on vacation.
>>>> This one got missed somehow as someone else was looking into this and is no longer with the company.
>>>>
>>>> I will look into this, meanwhile I wanted to check if you (or someone else you know) had a chance to test this thoroughly with the latest kernel?
>>>> I will get back to you with some more questions or the confirmation in a day or two max.
>>>
>>> Did this ever get looked at?
>>>
>>> As this exact patch was merged into the vendor aacraid a while ago I'm not sure why it wouldn't be good to merge to mainline as well.
>>>
>>> Vendor aacraid release with this patch merged:
>>> https://download.adaptec.com/raid/aac/linux/aacraid-linux-src-1.2.1-
>>> 60
>>> 001.tgz
>>>
>>>>
>>>>
>>>> Thanks for your patience.
>>>> Sagar
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: James Hilliard <james.hilliard1@gmail.com>
>>>> Sent: Thursday, October 27, 2022 1:40 AM
>>>> To: Martin K. Petersen <martin.petersen@oracle.com>
>>>> Cc: Konstantin Khorenko <khorenko@virtuozzo.com>; Christian
>>>> Großegger <christian@grossegger.com>; linux-scsi@vger.kernel.org;
>>>> Adaptec OEM Raid Solutions <aacraid@microsemi.com>; Sagar Biradar
>>>> -
>>>> C34249 <Sagar.Biradar@microchip.com>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>; Don Brace - C33706
>>>> <Don.Brace@microchip.com>
>>>> Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405
>>>> constantly resets under high io load
>>>>
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the content is safe
>>>>
>>>> On Wed, Oct 19, 2022 at 2:03 PM Konstantin Khorenko <khorenko@virtuozzo.com> wrote:
>>>>>
>>>>> On 10.10.2022 14:31, James Hilliard wrote:
>>>>>> On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
>>>>>> <martin.petersen@oracle.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> Christian,
>>>>>>>
>>>>>>>> The faulty patch (Commit: 395e5df79a9588abf) from 2017
>>>>>>>> should be repaired with Konstantin Khorenko (1):
>>>>>>>>
>>>>>>>>     scsi: aacraid: resurrect correct arc ctrl checks for
>>>>>>>> Series-6
>>>>>>>
>>>>>>> It would be great to get this patch resubmitted by Konstantin
>>>>>>> and acked by Microchip.
>>>>
>>>> Can we merge this as is since microchip does not appear to be maintaining this driver any more or responding?
>>>>
>>>>>>
>>>>>> Does the patch need to be rebased?
>>>>>
>>>>> James, i have just checked - the old patch (v3) applies cleanly onto latest master branch.
>>>>>
>>>>>> Based on this it looks like someone at microchip may have already reviewed:
>>>>>> v3 changes:
>>>>>>    * introduced another wrapper to check for devices except for Series 6
>>>>>>      controllers upon request from Sagar Biradar (Microchip)
>>>>>
>>>>> Well, back in the year 2019 i've created a bug in RedHat
>>>>> bugzilla
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1724077
>>>>> (the bug is private, this is default for Redhat bugs)
>>>>>
>>>>> In this bug Sagar Biradar (with the email @microchip.com)
>>>>> suggested me to rework the patch - i've done that and sent the v3.
>>>>>
>>>>> And nothing happened after that, but in a ~year (2020-06-19) the
>>>>> bug was closed with the resolution NOTABUG and a comment that S6 users will find the patch useful.
>>>>>
>>>>> i suppose S6 is so old that RedHat just does not have customers
>>>>> using it and Microchip company itself is also not that interested in handling so old hardware issues.
>>>>>
>>>>> Sorry, i was unable to get a final ack from Microchip, i've
>>>>> written direct emails to the addresses which is found in the
>>>>> internet, tried to connect via linkedin, no luck.
>>>>>
>>>>> --
>>>>> Konstantin Khorenko
