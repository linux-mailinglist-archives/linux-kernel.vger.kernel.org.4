Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B511681750
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3RKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjA3RJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:09:59 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB53FF30
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNSy8qZC++QYHArRhuqlynKnjPhnSLS6WY4krRjzefOIl8B+kWzySKayPAN7y1ex9VPDD99lg90M5QN3/70y8o5WUbsvbh4DDxDOxWIg0ZtUUzQOaia2WfpxpOw/GFoXZbX1d7dP0X0QhGuSxaIuh5lXucjOCiFesCdH36YdY3/2jjNqdg4khhApyOaH+pwFyHeGaiiZfrzsrkpDJtL0RKC9PmkDUFNWqbdc3bMcDsEoI8zR0ixsu0KDuJ3nDQW/2y1+2RDOHQkB5nw6lIERgbkTPMIiIADP1u79dsZ5dj/7z9NBUH9qSZIY0r/HA9mVCwfMx8ccDS6YBRsLqMp4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FkWjl/dmg440naxgZm61HQWETpmRXXi7HirOH2MWFY=;
 b=Me4Gm3VhIK3AcZ6Vj6ZwhO2hXOapL1bed6XwZjCazNScVWpduVl8Xn3A03z4fWWIfB7Gpht9xz5qZw59QyjA/p5Z3ZYA1XUD8PywL8u/diBWfgUL9kHrhe1oY7lY7kZqwdsQHUIwqMDheyQSggJpTbqopvs71d2/hoDG6ka1YtPFLjs6AfIue2/jWkv7JCkEKxAR66i0VT/gzGpXdR0DvHOLX37U4VEGrmiN080qq8dOp7C9z8Wp05b0RHbEb5/DdPI1Y2vABSc/KQRFM8E+ivqzfSVYfleyO/MVtp7kqP+ERXEp7i5oegfZynXFepIFgIoW8+QawNfyXTyNxTIiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FkWjl/dmg440naxgZm61HQWETpmRXXi7HirOH2MWFY=;
 b=nwaqmnDpLmm3xCKqTD0K+//NtMrOB34l1qkt9sh2AYjQyS8V3Z5FuHUE56+2wEetf9lehS8jiB/ho/Ay0zf1Lku2aISDhKDfJyX5H/BAK0vF9qq8uDENZUdgXvcpemwFkFotMLh4XIBssGif+IcHfCiiGVFvomiX386mf28K6sNb3vLxl6suUXa5yu19g1mycrumXCsT7sHaVva3BNus5n2en7Pe7Dah4POq5Qy9gqWN9C5leCYizB3Ic3SecXNzBG/n/t2vwiGl1illUmrqcFj71LgS6FJs42eIVy2uzTgCkXOksLSPncH6mMRv5DGQmhOL6kLEACoBc6HTCsBRYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 17:09:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 17:09:56 +0000
Date:   Mon, 30 Jan 2023 13:09:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 7/8] iommu: Retire bus ops
Message-ID: <Y9f541COTlI4zZ/L@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:208:d4::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd7744b-aedd-4395-3a74-08db02e4cfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcBwIQacnwuh8uHaQT+d1KMQPfDWplHue6bp2D743WUdoD9jYlctkJvP2Qds4PcXoCbWdyhD634FdLA2aEtqKT1LnK5e7995tmoE1KHqYWU8l75WRoyPXoKfzFPP4bywe8Eamgd/hASpbn8aRQDwGqyqthczdMjBLNTC0V2cX8VHOj6L37d4jCHu5mUv+Qbt21WPwROIaRpbHXJseWOcGV7aTYE07H+2IBDp/ShA+qbzkHJMw6xapeG68xHBpqnG+EgK6hSrxYaNwLCnHkvKSDKMxTqT+GT1Rhl0/a91hdzRAwOnUGleYP7PEj7q3tylYZ36IT4Fq+iD2O5lMJM0C+MGUbtAZ7OSF64QKCHvd3ruthsyWyuuwJJueC87MqBsc6QCup0K8GsJdIW73v5RIQwOP7Mh5V2YpzVNE5OtxqhNvpL0Ywl96AeHLrGiUssOmLCFpA9uIq2+N+krKX+PoT02TeDSws6VbxX3FpEmLnily9unBk2DcPWkf7c7KoBPeubHLvQDp1aOC9s2FOitCBZ/Ozv/lfobsTIjjlt+JkPY/9Mxp4QiD6eK6IwwLjckTgGNqLtrIIiIKXvjNGrdtaU8SImn2SKKIJK4mpdmDANt+zWlKgVlZCx12OMxlBPvDllrIktjyTk3zPgSnd/OIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(4744005)(6486002)(83380400001)(2616005)(86362001)(38100700002)(2906002)(36756003)(6506007)(26005)(186003)(6512007)(478600001)(8676002)(66556008)(66476007)(8936002)(6916009)(4326008)(41300700001)(66946007)(54906003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bR6BEiFDRKFK+W0PJ452m+0nAqk/e9HKhzBnoGhVjb0yZAKx7wJSH4VCXtMf?=
 =?us-ascii?Q?q3jQFlmHALUuOAkD+FfdhE7X4bR5Lnz7TrHIT3uxvYAuXs4OksFJaGfpK0Bm?=
 =?us-ascii?Q?Rv8Z4b/HJ8/AAjthrDPxeylgwqmZ1Za9zqsYJegDpuKvu8PP6nw4VaI0Jgxk?=
 =?us-ascii?Q?3kY+nPbNtawG3c74TefeldmepJnKoX+b5+vxWmpSnzguwX8RHZ1ORgdDH5xN?=
 =?us-ascii?Q?G8EG6BYnVvl0n9ZxXBcWQyFv4zgJeN5QUrAX3ekDmXrRHBYeJSy0LMA1m22t?=
 =?us-ascii?Q?yFMZBxe0RmfMA5hWWeRSfkkI6mx5LKR51i2FSqVK/zKTSOJvdHHeFl2CrYwM?=
 =?us-ascii?Q?ymklrv39gGs+nOwPB6CGXeLrlC9Pm9A5IHSPxfF8YWL1OLylh2VubKshTLO0?=
 =?us-ascii?Q?2CLXBUiFR9YIHd2Xqdhsh3kz6uJNf6pTdeChIRSWGmrr+LZzthZPs5OqMSPX?=
 =?us-ascii?Q?QfhajdYOWFIBRFxzqBLk2MQyO7cYSUcYAQAN5vj4U53RzikrPo+nZ+oExMZ8?=
 =?us-ascii?Q?95X8VJOSIUgutg+sTPVkBlAFm15dzLamy/0wriW5UOqS/5n+PUgn3nTZ/GlN?=
 =?us-ascii?Q?JOP13Wo1MOIVg8Dr8YiMOW/umtq+EobR3b2mD7TkDgqIDuvojPUSoXMVpPSw?=
 =?us-ascii?Q?obnW1NyXhBS09KNVJ79QO3z1StmBehZa+BjNR/5JZl3t5kePmD4Cf/JFzKAr?=
 =?us-ascii?Q?zh4UNe2ZFB3XRsfHp4K1mnIL+XOkE4vNpqqjx1AjADvWsWNzubniwDDvayzh?=
 =?us-ascii?Q?5DJkOlIEADb74ZvtmevSlhS57uA41/AjqBORSEll18OpvOzdbmh4+mnh4Y6E?=
 =?us-ascii?Q?Adn2/ZjtdNlY0RkEDVeU5PIODBu+IQ3x6NyywxxGxVkbKtTi8wYKvh/5M+Wy?=
 =?us-ascii?Q?zmGtVHj0Hd+Mbhpj0Fp8O3ZNKSSQ8Rf2nsyUAnldvafKk9qPiOMJalpKRFDv?=
 =?us-ascii?Q?vmje3TqxsaTBhHPndRDxx8oN4GqbvrC0JvEdLiQsc2WD8rgajmAOCdxa3ony?=
 =?us-ascii?Q?hYN3qNYBW0PdObHedPLeko/pzBIldRlFEf+DUU54tzdRNo4pdQ3rXL+yQWnk?=
 =?us-ascii?Q?WD+gnbtkVblzkqdMnpFg5jzfRDo3wJNhVmbMSk/4FewuaPFM2GEZuYGLHhYO?=
 =?us-ascii?Q?NDLyJjA18ivn1umPjG0bTk7OUOqgVjg4rg8oZBWVSxWDXBQU0M9W6BLJfuqz?=
 =?us-ascii?Q?7mm+sFXVRTgfGKDiYrSg/b95Ib/o5v/VcZUPnmxxtwyS80vDmXtn0nQgicF/?=
 =?us-ascii?Q?a+oaYvFH3OSPaV7WZU0m3XmV5eQM3cek1drbPP/YFzABv6v5lMyZMszwmq5L?=
 =?us-ascii?Q?vbRn8Q4qwFynRBWbW/tAS8hZjjansf358koqLjKN48G7y9Vs/ELjOtATfRRh?=
 =?us-ascii?Q?bSSmlzfqlcLDM9o6/IwFIarDLvjismYcpjyH9q5T2mkHRNOTv0DxocLlx9A3?=
 =?us-ascii?Q?4Db+tDPQNoqpdb5k5W/JOg4UqbSjUVjlkud+nmNOzyPja9nubdNLrZyBHNvv?=
 =?us-ascii?Q?4sFDcm+yiT5KRA3gguX9hXKE8RzU/BpX7W0gIZUf6qNOBwA7qiTDLay2XJma?=
 =?us-ascii?Q?QykT920XLBzSDQ8h5jImoMJAlevIqXRH1T1qWdhQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd7744b-aedd-4395-3a74-08db02e4cfcd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:09:56.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWklATBJc002d0bH6zZqTnhbC/eYQ1n1P4qLUtw/nw/1B2OtTR84/g7Glt1uQKDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:22PM +0000, Robin Murphy wrote:
> With the rest of the API internals converted, it's time to finally
> tackle probe_device and how we bootstrap the per-device ops association
> to begin with. This ends up being disappointingly straightforward, since
> fwspec users are already doing it in order to find their of_xlate
> callback, and it works out that we can easily do the equivalent for
> other drivers too. Then shuffle the remaining awareness of iommu_ops
> into the couple of core headers that still need it, and breathe a sigh
> of relief.
> 
> Ding dong the bus ops are gone!
> 
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
