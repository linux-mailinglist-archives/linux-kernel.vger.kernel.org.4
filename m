Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A4694C98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBMQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBMQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:25:19 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97411E064
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvDL1M/wiIiF5a1WMFUAVvUPjhNIW/gzr7mqkSMZ5zkD+KKbFBUAsolJuaXkFDYYFJj1FsxSjGRf+YpJqiNHD4sX79V3DTBN0aG/kH3WXsaDgA1FNZIoN+V00IZpvX0gLaAgZyP+isleq679WDDqhTIASMgTurmdzzMVqEQol+3J9UjK0zcmVKKsYBZjx8/GedjKfIaesvosmA00kD6qyDhPUl++xrnoJ4TYBBjLh3+mctVq0XaI+rPQSiiOuskZRhnzIB9FpaRdjxaoNwPlJ/9Dg2QzMn54+AK/mJUvN+HDYEvm6as9s2TKzEnPkhDEXCdXxKsKAck6K7aGeJjmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca33ST9f0dV0ZfZqzYw+0H4nWCk/IKrvDiQq4eaFKlI=;
 b=Y+eLHePUH/C5Q4bTiymW7MI7SaTxDDJdaJC9uqD2ySiuTwJF67mumWgCFpyk8NU5HLqhwRKPcCthpj13tiJr9PuLKyjjwkhdZ+/AI0uas9795c0LNpLQ9tPItII5wuqHwloetPaIoD4QnxvjqUAJ2xgopV/ZjB4rUVp4Gsu1sJsyRZfemjuKQQ9OmGa9t1B0Jtrjl2pLIUJg2GPPed1a1t/Hhxspt9s3rAMOdFwJBejLwkBieY7hYghTwuadmHsnRUrZGVjws44+i9gZ2T9zurhnOlS0mCb2THJB2zrY0bZV2FUqEwZOlCqSrFgFFMPh/kJQ2rBK5nyDbhWV+NC4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca33ST9f0dV0ZfZqzYw+0H4nWCk/IKrvDiQq4eaFKlI=;
 b=NGC5UCDhdJZFNLPQYBHEM6Fk5dCiuGk8UzaKD2M9nJgbw+U6Xh2msNH16298oApubd/F0YUdVT/9GwgA6BPE5iRwVsGc36HM7Q+3Zy/JefqEl/OD1kaizyLZ5w6KnyF7UtcYzGoqp0yeuHkxPqhqvZh3IeKeSOfV6G0qoN6cAm56MsBFyz7JAnOc3ySBNNv7dgGzMq6UAi+ivBbfzeiK14CUN1kG7FvyHMw2qJE2kJGmrAY72knbmk3mpHKSqixifc5QdZcvNVCWo8a6g8+oRK37lE5uB7A5stvcfI0iJPNRYHj3efT0esud0621z1dh/TCvNPykPDq8KZrbadVLHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 16:24:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 16:24:16 +0000
Date:   Mon, 13 Feb 2023 12:24:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+pkL5b6mGv40nZy@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+pjTR80bnl9rMK1@myrica>
X-ClientProxiedBy: BL0PR1501CA0020.namprd15.prod.outlook.com
 (2603:10b6:207:17::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8abf81-372b-4b87-c289-08db0ddec04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko1rTybnVt4cmkqhzbRmAVXxLmhfw6Pwk9td21xqrqzvB3z54y9bqRooGjFARuTWOGpp1aoPonMEFIGz/JH3SgqJUTpj3r/YWcOlsEjC3fJWPJ24+Tp0u/IwIfhYZf6bIoQ0yhIb4EHfqdFsUAF4GN4/ev+Y1HHA/l/vWLDWDS6cgQYSBXkMXxZ/DRN29dW3Yf7NL+sDTvjFUXqKLKpDY3593r6BgEsbywsf0YUO63Q7W7B86ycekreg217GnMNzo+RNBk48HDPArXAUuLet/mfSuxp3+z0eY13kPZNOZWhhjnPR/Bsv479bfFpgaK63eprG0NhxKV6oR+7KC7whMq0Zna4o9htliafEM43+ayiBfvuVGaYM+Uz2jgqNnXwbLT8il/KLMCfeROfvV35mYsDKGgh7diQbN1+OOdnB7sJU8c5fWcP6q1k19RWfkjfhg7BmpgxS9e+/btJniSLrW3A4Zi69MWXMF1RY3+mVsb4nDYuJDpRYN/oMFoN1FfZftykwHhXB2ARvYalod2AzviAp/uD/1KRJ1AeDWBW1w/zzCOKi0JYGyAdHJv/A5a8f7I0z0+V32zdxXkuWPxpwtg2RuJAtMxR+PzTAAt/D8b9fcQlh86cs8RXhfWI0DwIDLv4trS0d7dOW9bvk0OkkNGeqzieDklHNzBJQfsrijpBe6HCF1ofjQB77biYpcXju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199018)(6512007)(7416002)(26005)(66556008)(6486002)(66946007)(66476007)(4326008)(6916009)(8676002)(41300700001)(478600001)(86362001)(316002)(54906003)(36756003)(38100700002)(5660300002)(6506007)(8936002)(186003)(2906002)(83380400001)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pCtfiRjHGOj6KbtMKGLK/6LPgqNdhjmQGQWlSSQE3K1rjQx7mNEFaUAzvzBr?=
 =?us-ascii?Q?Zew9HdGyyD/x0ZQ2s4uKtkvtHhEA4J33KMxzyDmj4vMMlygPZZK/7P/LmdRy?=
 =?us-ascii?Q?xFIe0hHOP6DIM9CK7qUKXMJ1dKuqJ9611WhiWDFyL4RZ3il5AAYEGiNrv6u+?=
 =?us-ascii?Q?MtoXnijb/IuQgswsahbmEOcWAcI8JKxcXfj4ZPNnCpTfelSju57Sg68uIpU2?=
 =?us-ascii?Q?KDYo7+1O1+HlqybKYPG0N1yLxqAWFJSTqCpgm9ns7oyzkL0RWdIf3wN/vsXI?=
 =?us-ascii?Q?cMyzQwJZSWh0FGx6suWm5CAH4Y8G3mapgmd3/I7pgvYG3KghQORRysdews5e?=
 =?us-ascii?Q?CKr0S9dNnTxagZiBv99ZjxbGfr/WTvMiHbeu3HJzsY6h1onenG2XdjJC3Unx?=
 =?us-ascii?Q?M+z/0eHIRXE7e27C4nDth/AZ3bYv5LzoKrxuOXlUUqZhA2xiX69Jktl0XTGB?=
 =?us-ascii?Q?zxda1TmLKx18jfto3iop4mUjE1cUnmbgQ2JtR5l84hPEe9v+ULHPoA5e8wAX?=
 =?us-ascii?Q?q+hSC6b2ZjQH2XXzhQ6TA+gSc/uBLeCR0N5cWrpFh8eGxtAkgaEaJ75T7mIj?=
 =?us-ascii?Q?4ZtfMAdSdr24SwlADYtDWk6OqxbYcapaEkoU4d6bk43+/NdJMOewtBECDvg7?=
 =?us-ascii?Q?79IhDdotsHOMPtbq0fCh1xm8JVK4aeEHzfR/lg7ReoFwsFOvCp5/t/idtL2E?=
 =?us-ascii?Q?7ID67mSyn4Zgm+qj7lRxc/2/6Yq2p0TZqXOeFg8TIbuBMaH1d6zBzlK3MrOl?=
 =?us-ascii?Q?ftX1d0oRfBC2OuKqXVvdRtDShDHtsI0G1+T/InVMubJQ9/P73YbqOjnUhCoP?=
 =?us-ascii?Q?sH/AFQpHarPXYE3H8ewetYtiK5jk3+gOaZe7FVhKPOz/OtTpbInq3U3csLcz?=
 =?us-ascii?Q?bTHPY1A/VR+2OQzRpTCZV7aTCQqC0lHQJ3NCVA4ada8H676z08qMomQTlu+8?=
 =?us-ascii?Q?mQPilgvKAmdix7Hv85DiXCzA1KrBDLMC5UjlvQAM7BCFKX/w5kF/ecZ6Wq/Q?=
 =?us-ascii?Q?gG2CmC1wYFekRhoe2uGCecq7KMjLotfKKrPeEWYsDQtOhMp1IhlEZ4U18qEq?=
 =?us-ascii?Q?5M0JHtYht4RrzbP+Y153BC+XPBLSYGxyIbnRgnJ1vrGA1j+sARAsR6/EybbV?=
 =?us-ascii?Q?/Fs8i4vmTUriaKFnRkY3qx14tcwJf4fH+KzjxNSNZGPndYPJHoV12bi9rdGb?=
 =?us-ascii?Q?YTN3xhM3MwRtfq1HYb4ujvIEKTF8XyPCWdxKtKb+V3jnls8RiuwKGDecEVAr?=
 =?us-ascii?Q?Ni5MrWcjnNJkFi8eaSeKgTE7Lj6U0aMdHjN85BPCADstjDdkmwrMgobNYD2E?=
 =?us-ascii?Q?kz1gscJiruF9jyvFewxpEKyAy+lsT0OfFJMO4ybfV6vCrlNlSkBFuZq80wsO?=
 =?us-ascii?Q?jpQ/8sUcng8MHKeoxDEfveURPoH5o1CMHM4Us4FT3+LSzUjN+AuEQQoQxugt?=
 =?us-ascii?Q?W2QL0w4jBtiFK+sZ27U7xRKLMHsoglOuhkpsM6XzF/LNscj1SMlxHZKhlcd+?=
 =?us-ascii?Q?oyY7KaEhtYO9nz7/+9zXbS1IDrVfLnQyIF+3tU3eJnaoc/VOfIjzGqCmG4/n?=
 =?us-ascii?Q?hZ1A0vRGFNJ6WUmwrpq5dQ+tgBGwwhBMLCtOFfoR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8abf81-372b-4b87-c289-08db0ddec04a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:24:16.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 072hLAkTpX7fU0mekVC4MAf1cfkCCvek2v95hO6N1HfpUVvtzjxMT9v9GkYTRLKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 04:20:29PM +0000, Jean-Philippe Brucker wrote:
> On Fri, Feb 10, 2023 at 03:02:06PM -0800, Jacob Pan wrote:
> > Custom allocator feature was introduced to support VT-d's virtual
> > command, an enlightened interface designed for VMs to allocate PASIDs
> > from the host.
> > 
> > As we remove/withdraw the VT-d virtual command feature, the sole user
> > of custom allocator, we can safely remove the custom allocator as well.
> > Effectively, this will return IOASID core to the original simple global
> > namespace allocator.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> You can also drop the spinlock.h include. With that:
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> private data helpers") removed the last user of ioasid_set_data(). I guess
> that could be dropped too, unless you plan to still use it?
> 
> We could also merge ioasid.c into iommu-sva.c at this point, since I
> haven't seen any interest for having multiple IOASID sets on Arm, but I'm
> not sure what the current plan is for vSVA on x86.

Once the customer allocator is removed this is bascially a thin
wrapper around xarray

So anything that needs multiple pasid spaces should just create it on
its own directly with xarray

This is bascially a shared xarray for a global pasid space.

Jason
