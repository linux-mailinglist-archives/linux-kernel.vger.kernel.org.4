Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9C64A0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiLLN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiLLN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:27:58 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9F9FF3;
        Mon, 12 Dec 2022 05:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdyeypch4WbXaKx3UpKoza6sJICxhvXpBnWH0/l07gCDB6vfR9sLpfqvn9d7hzaIavO+3luIKctAMsyWIHNaCeWrqn3l70sGOC+VFN8tqhnX6qxJoGFvBi2Tq4IvUv7rzuNl/9s0gjLsk1Desqb7MRw2iADUp8SsOagOKghwQPa2yuB6Jtn0FQsEPGLe4h8eQHmGxVzmUxcjGeZk76u2fs2IkriVIdxWzLCnK17R+m89tUb+RIjU4RSDJsH35tAkMGi+Hkd4yIHxQgjXNmfMjED3xhlu/j19eGWaeC6p0uZs/Lj4f8K4jW62B9U3slMP0Ab6naEvJXOacPomYGr18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgEpnqc6pfC1foiCPNA2zswpnZcKH0GBwDuDZYaEylw=;
 b=VSdfctGRaqjgTiXHkMTK9XnFUEGzlSxw6O0yygAVGa091CdLYBLbiv9dPhJJL0SV16aLOBkpZ4xVpOzPDNaAmbJRJYlPZRUSyRhbo0lIZDou4syNk7fLFPNqv4efU2sheFXcPxBnWFde8UMKVqOctwiRE9JAmwnBjBfc0DHze0nQ9GN4sCHgW2XLOPN+37l1bjNPnAvDzPYFVBxATHP4PEIRDHv7aFrk2V05W4GLjcRIGSiT+1mrG5rQzcpqRXItyJjIeDvEgNI4bm1+JlkNdyBdWXfhYYfKTuW6H2jLufOm+YJOJ2UjnYbotQVBrT+UK6n3LItqvCtnIF2QweWjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgEpnqc6pfC1foiCPNA2zswpnZcKH0GBwDuDZYaEylw=;
 b=AZzbZueX/3UNlHBkYR7SBcl219COXNgCmwyDN0DUfVeG+L+wMGcawKTiHtnUKpXr7PRfM5YNc/3Uz8437O9fc2s0hkgt+0uR2RLFrE0hHzjhaE8psyTdExTqhVyBQhuR/5lm6IdRpazj0FMWWLolR2/NNyiJkbcg+wdeZsyGW/jhoVFIotsptiWstKwtfVt5C+Sxel1bjt1l4RCLw4OBeK5D6cNWCgviad/3FFHMl+2TT7WgMRV6rV9RvA3UwKVXPDyV7biJg2lnTKtillWm7IHTEZwpJyKZNPVVQ4yG+Krh7AtgoBbKiEvmSwEgDa5dOXZ1Foe7YOA8GYKUT7i6Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBAPR04MB7383.eurprd04.prod.outlook.com (2603:10a6:10:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 12 Dec
 2022 13:27:48 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:27:48 +0000
Message-ID: <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
Date:   Mon, 12 Dec 2022 14:27:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBAPR04MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: f999afce-202d-4b6b-2587-08dadc44a97c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WRc1rEARCCk4MD3cxCdyfMnaQqwXfK0Jp2FCtO1C1tzKgKrTnHxwodl+WLt608MXDI7CZMWK35B+OjLTPc4IxKeM+/24R/4qbW2RkkgQa5dwSdBVzNvDRvMs88YszvpGT3rdmusWGNuWtAleJVsOd8qgCstQXVYd4QkwwqYMgefz01c1Oi683wV/MiZpbkknGkO2KvoYluQ69aMrnG5wbVuc8Z1PZSZB2wKPBFDbSBAcoX/+/IdEBmdEy7a3NaqLr3E15LbN6PpH+7+Y9Hg0I/TB96NP+JeA5/nVUyRCcGhl56KbS2qvmQCgxV8O73EEPrYylu+cXPWx1cwR5jEBDORGnohsrZzhzwKDy0rwLTApuNj1B0zWRavPOX/HTzfRm5plJ8biPooySi8u97VV82oqn9pjhIOC9hWJoq6vfGOsQFwlsyo+RQPaNa09EJ/dytKPL0HKEd/xK67H5SsXtMlVxbdYAtUidUQx74UcIU5yUc5l8DpJL/gaGZ0CMV8sIRXYU2oBHaKrH/Xrf2ChwCTYpFqSlPyp2WpSHMqQ4LFKbZ7fKyzB1RRDjj/sGKx+Ges44v4k/hDTEwsmWKBgLW1x1dLtGkpgWBX6torYWg+bHiPp6RwwRXUHnt9BWLXt/JMWPenjyup84AptGiKr6BktYO9pMZzJhTVEinFlY4Ak9vQ6oMoZlLp/ZZFaEjUR7DRlJRKcJld/ejqrRpXky1eNcG+q9cg7CHaIZnOIAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(39850400004)(396003)(451199015)(36756003)(8676002)(38100700002)(2906002)(110136005)(66946007)(54906003)(66556008)(316002)(66476007)(86362001)(31696002)(6506007)(6486002)(53546011)(66899015)(31686004)(478600001)(2616005)(8936002)(5660300002)(4326008)(6512007)(41300700001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REx1dFBGUDB1VDI2SlpKd3dlcjZVMTRLNkRwOTg2NitTQWFaQzY4clVnRXdN?=
 =?utf-8?B?Vk1FRWRtQ0ZicDNOVUhldVQ0MWdPMGZiM1M4ODhjQTd2V01Xa3phV2wxMzJP?=
 =?utf-8?B?cW5BNjFxLzAxWHBVL2JKRmx4WEIyOWxzVEVLMnpQcFdjY2pPMlBjYmRUT1ZT?=
 =?utf-8?B?NnRlb3RVU2ZJZ1E1bzlqYzBRWG1hdTQ3N3dOUk8wWUxhdFVBRm5pcG1OU0Vu?=
 =?utf-8?B?QmpmTGlSRGVFQWdtTUE2OXBmZ0poR0U5T2VaY2JzZUF6YzRqSXExNDc2RE94?=
 =?utf-8?B?VVVVRUxkNkVTQjlDeXZ3MXpBRHRURDhvTXFwYUJiamo2NU5JcDhvcW1JOE5w?=
 =?utf-8?B?ODc5KzlTRm9lek53bnlWNDN1N1BpMzJCdGYrWGVFT2hWcVF4UkRpSlV0K3Ji?=
 =?utf-8?B?RDR2V01hY2hwRWNoNVBwSU9oaE1KNnRLUnFEQlRMeU5abUZOcCsvZzVHSHF4?=
 =?utf-8?B?MVNoUU43ZW5iMlBXTGFxUGptSmdhdHd0U1M3SyswZEdURmdBc0l4MVpuei84?=
 =?utf-8?B?VTdZNEhhVmZkTCtObWxuK0ljWjZYQTRsOENkUCtwWGJMK3p3T053N0F0dmIz?=
 =?utf-8?B?Y2M3SHBBWlloakViVnZ0Rkhrcmt3T3dVdkNoVitKby9qRU5VWVdVcTN0eDZo?=
 =?utf-8?B?ekpvQjFMb2dEY3NTUW5zenZuejZSOXU5K2VCd0NNb1N2SmI5MWFMN3N2c2tt?=
 =?utf-8?B?UUhqYlJWb3BKRGNwYmdrVURUU1pWeHJKRnVkaFdTUUhqZ1pwTElWb0VBOEFI?=
 =?utf-8?B?T21QRm9uS3dUTWdtcDRtaGJYS2ovZzd3UW9FNi8wU25vMlkwMUk1SEM1L3ph?=
 =?utf-8?B?anUwemdTNjZtQVYvSWt6S3RuWTVSdTg4Y2RrR0F1Q3V6blNieXlVWWxZa1M2?=
 =?utf-8?B?U0VvcHpJZXMzcC9CMm95amRGeWxITE5YZFNGWmNoenRNQWJDL0RnSXpXbUtK?=
 =?utf-8?B?alRSOVlkQUlXa0xJYzhCZXlIcEYwTThPdW0xbEpPQ1Z6UWpmSUJlUnpRSS8v?=
 =?utf-8?B?Vk5ONzdtQkVzUkdtYmQ0OUUzRzZYdUtsaHhzaVZ0UDFKbzNUZzlEZ3U1Mi83?=
 =?utf-8?B?UVhBMWkyMzhZTEd5TDlML0V0NTNFNWphMldOS0VFRTN5QjRwNDJHWkxRVVJo?=
 =?utf-8?B?eGNwTUptanNpQ1gvVHFjN25BUXo4R1ZIZXBaOUJDS2IyWksrMVltVmFVR2Nk?=
 =?utf-8?B?WUpreHlrcDNVYlJmOTdQeHVoOG5udzI3SHJGU1p2UGptOHN3OHBBUjNZTUpi?=
 =?utf-8?B?U2xhTnFwc1gwRlYwVjkyandnVWxBOWxlOG53MjBVSEtaZTU0WUY0OWJhT09x?=
 =?utf-8?B?NTNyVk1KS2xBQjhhVmNZbmNSNTQxY1pkWGd6SzAvWHN2ZjQyK1l3RXVMbnlI?=
 =?utf-8?B?OFpXalZzMmQyMm9Da3RGUm8yS0Fvdks0dDJnaU84eXRDd2tidVoreVpTU1lZ?=
 =?utf-8?B?NktuVW1BVmZMSk03SGoxWWp4QytSRFllaWMvbFB1Sk5PQnFhdVNEV09zbDEz?=
 =?utf-8?B?MXVWRmZUTDVVeGEybFpuYkpXbFk4dHVqNGJCR0IxUXBiVlMyZm9BOGpFdmZa?=
 =?utf-8?B?dWQ2M2FqM0dJeFdYaFZ2QjFWaTRrMTFDUzN3SG56MFpxNjQ3ekoyNGxxN201?=
 =?utf-8?B?eW9qZTJ0eXJOdml0cmNlOFNvZlVzR0ozMkxYSm9tNllxREVDaEcvditldlN2?=
 =?utf-8?B?cG1EUDB3SGg3bzI1RkZGdkpidHB4VDdRMUJpK05US0VxY0hYbVFNOXJlaTlo?=
 =?utf-8?B?SWpYWnA5aXFkQjU5eEZiZTc5cWNjSmhwMjRyY1VWVnlTWit4eWVIdWN3ZHZT?=
 =?utf-8?B?MTJ5cDhsM0xleXY0TmhkSzZsZ2NVVmR2bVloRTh4L1hkcmEwT1VVdFkvbGI3?=
 =?utf-8?B?azFsakRaazZuTDFZS25xeGE0WUl4TCs3aDVwVjJ0aFBNd0UvZWRheW9uaVdJ?=
 =?utf-8?B?L1ZRT3d1dTNzWDdmdlF3RjNCYlY2M3BjMkRkcGRJbXUzYy9NbVZSRk04bG1p?=
 =?utf-8?B?R1dmQXNYc2FDNXp2b3plZ1JiVlM2c0V2TVI3UG41UkJieGI0cmRCWUhkQXN6?=
 =?utf-8?B?ZTlVYXdPdFJ3SWJlb2lXSk1kM2p1MGl2K2t1SVRJdFR1ZTBESU1PcHpqU01C?=
 =?utf-8?B?SVlpbDUrN2dlNWVFMkRpdzlMbTYreUhpT2IwOUZCQnJzTkkvSXBBd0xGcDlB?=
 =?utf-8?Q?LpCwp1+iCIxHdSfMxRVGDZt3/e56SvvyeucI/w5cvNXu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f999afce-202d-4b6b-2587-08dadc44a97c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:27:48.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0M80SFh2CqzYqJVnC7lup/Qu2HG/yuoiHNgODCXAG3gkLI2gVFcgY5XalNgjaPyQ312E4umGFdO/2l5xgeB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.22 14:14, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 12:13:54PM +0100, Oliver Neukum wrote:

>> 1. that the function exists and its purpose
> 
> That should be apparent from the function name (and implementation).
> 
>> 2. its parameters
> 
> Apparent from the prototype.
> 
> But sure, it would not show up in generated documentation (like many
> other functions).

purpose, yes. existence, no.

> it seems. Not sure how much value there is in that, though.

I am afraid there is no consensus answer to that question.
  
> And in this case there was also no kernel doc for usb_get_intfdata()
> which is equally self documenting. Why add redundant docs for only one
> of these functions?

Because knowing that one of them exists makes the other much more
obvious.

> I'd rather drop this particular documentation which was added due to a
> misunderstanding then go down the rabbit hole of adding mindless kernel
> doc to every helper we have.

Yes, but those are not the alternatives.
Removing the perfectly good part of the kerneldoc is a needless regression,
albeit a minor one.

> Yes. The (device group) attributes are removed by driver core before
> ->remove() is called, otherwise you'd have an even bigger issue with the
> driver data itself which is typically deallocated before the pointer is

So what happens if user space calls read() or write() on an existing fd?
Sorry, but this is an issue we need to be sure about.

	Regards
		Oliver

