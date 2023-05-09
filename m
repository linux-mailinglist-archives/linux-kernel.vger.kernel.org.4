Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71256FC226
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjEIIz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEIIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:55:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA713D;
        Tue,  9 May 2023 01:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgJZcfSJ1MSwLKXieJmdsAP9ExKeMbehLBz7viRcY8RYTCagkQDCHaTM+5j8/hz4eTql4Gwo2iGMCMVL1a05c/sb+QuM1SuwwnFdzQ+8I0mUqOQ8Jp77L7NdYD1IjZvclHqjTblnGXnna9dZpIBbRvHUNrD7SVjBLcalQvQ2bJ1x/RcdkIDMZHILlNgTHO1rz5bTxmVEaEN7+uEB+k36uisY03eWzG6Fb/AlFMdCiooXNueR4UR95f1f6sdEd1wHR5McnytbliLNQjvMmeirufHBX6spVKUMvc/PdOwG6NNf6ubqveM3uumbnm9wCAQ83j5EUIv29sXX/90Mad129Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD7USGjqoJj6dUo+lIg3O1HGgdgusOnF9wLXSNhGPmI=;
 b=G/O2snwSOCu2+BVbai2X16cYvbQL0R7JNdYIsL37arSJURkXn3jGqY5xWEWM0VQq+t0UDxgDMPMBSiDenCl3egVwzNciTOT8N2ipOa9qWCtq9qu57k18AERYCG3uMYnVB3Ez/Kae76HjkQ9ySffACA6aRzcszkz2rlaRkqFVXGN8wLXsNyC+8Y+6W2zi6MtfD3z3Nrp/qM1nozOtGhjzHp9tE5aR+nZ056SJXrQXsg+ZpZC7ez23ja98V+mcwMdU4e0i2gPA1zLKMWwTfZyhocFZ00euDxrcmxTYpJFuncsN+huWLpIbcMfSBoU4fXVb2859KFkoO9I221a+1j7lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD7USGjqoJj6dUo+lIg3O1HGgdgusOnF9wLXSNhGPmI=;
 b=sEj0DDVJEyCRePl8qjz099Os8apMptJgnE0bhf4dl0AOsr6/QqRGnBaMUbvylpap3V2uN2wffH1KeBpksQxcH5sE49I4n7sRS+dW9ssCgzID/B0SJZqEQ1mIpqVPO4uKJCZGI4ym0dzwPVLVL6033kJfOECVkEw2Pw4z3m/H74v1o/fHo6A54ad4UnHQhKSxusFxivBAnxE+TOTMQikbk83JwLfN69cB1Emmwbp/v+kysVUc8EAUoi/arp9X8z4wdZC/Aq7Pl5V+WswWt29Hl/1Iby4E2bJMOcFf9d73wiz1hjX1Cfdk24lF2hBtKmueb8+O0vFWHQsrUjON5alCzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 08:55:49 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 08:55:49 +0000
Message-ID: <8536273d-20a4-1993-1381-b50e44701835@suse.com>
Date:   Tue, 9 May 2023 10:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] Documentation: scsi: dc395x: Remove reference to 2.4
 driver
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Finn Thain <fthain@linux-m68k.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
 <20230505082704.16228-4-bagasdotme@gmail.com>
 <d919a2e1-5749-13f8-7867-1f17277190f4@linux-m68k.org>
 <87pm7enbpo.fsf@meer.lwn.net>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <87pm7enbpo.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: bd268aff-d8d8-480f-8869-08db506b2f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHJYwz4tof2jq3dptpPDt7YoUgxMi9G+xp/UnWX5w8PtE0+h6nKoNjFljr8jhfh8WgPCGcqZlA4tkUFD/cEd2o5l05+M1axWWBN8qZxZSb8SrrCANzD/Ng8E4XB4K4jWSVTkKoZxHSG6yGw6RW3UFfFONu4LCOZvmQay8e5ywtHHWkIpZrNzJgMT4GRTeiQoxmA9twPKFU0c7FnkR+Izjv+DYQnXy0AtkOqw3kiSgMlFV5jlMb2YliEbpzbr840c59y21j4x21LWIbV78UFIrCm4Y062gpflDuIKagmV3kDrvn22j/UtACMBKAWaSZkxbmEdDMeky4UHFHL+dOEcD5LRrl1bJPAiaeSruxcGDelOXGXsFsmPGjy5/IXZZ5HdQ/AIN3QsY1HYCqSn/KbKCqH/vAhiOjc+Nrk2uRyOdce2W/xZwfi0lP47/UodK3Lh99fwztCfPhgTcS0lA1GPJIadoCCBvxNaNTHbqVkZEGU5GxxPfip3W9UxGkcqP4BbcMhxLkvGNaTWBMoLPdQOAYiwrlgSLh/2sQMv1lT9OC7ggfrkTIWHgA8SKn7BkTY4swY+Q98jLEZ9tcHnXibvB0+E8D1DJYRX53cVjpOFnz5QHJHFct0pygCrY8BJElCdmTGrzm0eGPAQDjnW0Pn17w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(86362001)(36756003)(31696002)(6666004)(54906003)(316002)(4326008)(66556008)(66476007)(478600001)(66946007)(110136005)(6486002)(7416002)(8936002)(4744005)(8676002)(41300700001)(2906002)(5660300002)(186003)(38100700002)(53546011)(6506007)(6512007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVhraTRWeW5vTVBFeEowK1FtNktDckV0dHhRcXBrbE5NQWYrTEFJQzNKQzVC?=
 =?utf-8?B?RVpzaDVaM3ZocGVnMmdDNkFHQjdmS2Fwc1BzcFkrbnhqbDFMOGR6QThSRm5a?=
 =?utf-8?B?dXRSeHZvVXJwRU5vTmVTRnpHK3dkUUZqN0Z2aU5iZ24zUklqcG03bUh6bFlE?=
 =?utf-8?B?Y1BnT1BLTFNzNkZvSy9oYWgxYkJXNmR6OERPcWtyVDJOVzFseXVFcGRNTmlk?=
 =?utf-8?B?anF6QzhtZnNEU2Z4WXJmbUk3dWtJVzF3VGloNkJ5MEt3a2poakdGdnFSK1Jt?=
 =?utf-8?B?RkNTT09qVEJGZklJc1poQVpCR3Z3M05QUElCS2pmQittRHFTS2RvYlphdmNZ?=
 =?utf-8?B?TzlXVkdCU2xpRDZRLzE4MTZqM0YxeDVDbThMeUhXRzdETzc0bEhqajNzcFlM?=
 =?utf-8?B?N1pUam5hZ0psK2preDRvYVE1Wk5OWi9KK2RmTEQxSUhySDNCdTdMVDdreFdI?=
 =?utf-8?B?Nm1hL3F2Rzl3TW9udmxHTlIvdHY1Sk91T1A2NFVCWnpZbUtKS2Z5UFJscE4v?=
 =?utf-8?B?NUlEVmE0YW9CSFNlNkZLQmVFbGJMakNqazRjbVRGcjU2cW1tYmhoUUlOZUdD?=
 =?utf-8?B?WXZjaWxVbndKSXc4WGR1T2hhMUNOZjRBZFNkdkRWK2MxdzZ6SXFBOGkza3dZ?=
 =?utf-8?B?U1Z0Y2VNSkdJeml6RGNiTWE2SWtLRjlkK3ZBZGk3V3V4SGVRS1lIOVNIMWJZ?=
 =?utf-8?B?UjZXYU9oSHlqSTc5UzM0VXNzMmsxT0lFa0dSWHBBRTJONlAwZGhrOFpRQkR3?=
 =?utf-8?B?Uy81VTZydGF3NnppNVRLczdrbzJJWUpNdTVmK0duOU1lOURWNGlmZkJGaFFO?=
 =?utf-8?B?OTNYWk9MV3kzaUd1OWorOVFOQjU3T29EZWtsOWRJdUtMWExWMjVVMDEzL1RO?=
 =?utf-8?B?b0RUemVTTTBFenNEQmszNTNIZzY5VHZhcjZIaEFDeUZ2VTZNWitwcmpDb0hG?=
 =?utf-8?B?OFRpNk5XVzRpUjJISmozTTU3RGoxNGVGTVBIdnZXNEhRUnR1QlZycC9xTmxL?=
 =?utf-8?B?VGk3UUVXNUVFT1kxQzZyTUx6N2wyRHh0UVlGRDFyMXR2SHZ0NTlLL2M0QkhL?=
 =?utf-8?B?cjVCeWxMdDFaT3RYaGU0citnaWFGVjFYci9zb2Z6MWZmeFZKQk9NQ2w3RzdK?=
 =?utf-8?B?SVBqU01aSkhVeWlQZGM3TDR6cWU4aXRzMTdRV1F3aUZVNW4xd1V2N3gyVkZs?=
 =?utf-8?B?TmgrZGY0S3pCTmNYclJ6cjN5ak1yREE0L2ZxMGhyOXVhSjJOVjA0RFRxZnc1?=
 =?utf-8?B?Yzh0VnR5TVlBSlhKNElGUUFiYXEwU3VlNUhpK1g2VFdjREd5N0s0VTkzT3pL?=
 =?utf-8?B?R1FWM0ZEYVd5M1dFS1Ezb3E2VGJUM1NwUnQ5Q3hobExxNlVPMCtoK0tFK1F3?=
 =?utf-8?B?R1FaZEd4VHVoUFNWem5wNFFpalQrc0dtSGgrOHBiSkY0V2J0V3Y1cVZQeGl3?=
 =?utf-8?B?YjRFZnVNTHA0Z1VqdnNnalYvM1NqdllTa0wzQ1A3dHJIZnIrRnBUWDdzZC9Q?=
 =?utf-8?B?SmRRMis5a2psVGR5SWNndlNQcHJoNnNYaXM3eE5NUlF2amwyWkg5ODZ0bXRK?=
 =?utf-8?B?bGZHcDR0QnM2aElpSWlwd0prNnpuYzBwaUx3cklDeTVFaW1SVXJhTzRhT2Uz?=
 =?utf-8?B?N0xGNVNnMUxhUHVvdEwzbnhsb2hDRFdrbGQ0dFJqN3I2TlRhdjNpNnR1M3Jy?=
 =?utf-8?B?UlBCTnh5R290blBpa0d4YmFHeVRLR3FxMXNTTlFtYzRLaHcvMEpCZXhUTEE4?=
 =?utf-8?B?ZzErRWh1TUFYdjUwVmpJMnVQZkhMbTlUaEliYUIxa21iWGZPdURrdnNDMm5F?=
 =?utf-8?B?dE82dGEwTE9UNkQzb1RRS25GeVVMclJlU1BzTzF6MW5POWtrYnpTVHJLUFFV?=
 =?utf-8?B?cStzTEdKa2Nzc2M5YVJOVE94bUtnUVdMTkFXeDVpbFh1N2IveTdwaVhwWDBV?=
 =?utf-8?B?N284U0E2R0lmenhudGdNT3MydXYwVzdENDVYMEdsNmlBUU1OUGZQSnlSOFEy?=
 =?utf-8?B?U1Q0eXYrOFVtNVBmSm5UTC9kWGVUK2I3RldhK1RuRThuUFVubmcwb3RyQTM0?=
 =?utf-8?B?bm1HOUd0VFBFMFhuT28zV3dROWJuUUYxM24rSGJlY3FMVEo4R2pEZGZZZy9D?=
 =?utf-8?B?ajJFbStqV3owWW9zdTBFK1FkRE9JUDRUM0tqaEJ0eTJxMHlVdWp2cTJqcW9L?=
 =?utf-8?Q?a6Z5e9oaQTvGV7dC7NPSqEwMb0xDs9C4Zhtg05TiuFDk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd268aff-d8d8-480f-8869-08db506b2f1e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 08:55:48.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96/wMiLsAqFPByciuZpqzyAiVCGvtXw2bX1a32cnGGtSVL4eIglTL/x+4Uw+LsRC4UTpmCZWginM1HnLXJGeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.23 15:34, Jonathan Corbet wrote:
> Finn Thain <fthain@linux-m68k.org> writes:
> 
>> On Fri, 5 May 2023, Bagas Sanjaya wrote:

>> Would it make a difference if someone does run that? Were you planning to
>> delete the source code for the 2.4 kernel too?
> 
> Most of the 2.4 code has indeed been deleted *from current kernels*.
> It's not clear to me why 2.4 documentation should be immune to that same
> process.  If we keep every 20-year-old reference, our docs will be even
> cruftier and less useful than they are now.

Hi,

the documentation of a kernel should document that kernel.

Now, we have a perfectly fine tool named "git" which allows
for metadocumentation. May I suggest that you respin the patch
and include a link to the old stuff, which somebody has been
nice enough to find, in the change log?

	Regards
		Oliver

