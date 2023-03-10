Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837586B4BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCJQGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:05:41 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21962696
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyEOn7ZhQzgaDKOYJ0RlB6gjP1BzDf45ieQVFeuQ/0sRz5vMxjryVzEu2theVO6c/suLxKAUaZRN6BgNAXBZnSRLEXaBP9NoLpRl6EuRDDgkrYACWShiN4DJ8fnZMqYZ1yf/8mtko49G58QddNKXvn1mgl/cXSioXtTJR1P2+lZaWGj6m/Bx14fOHlxLWhNmRuoqKq7ojAwWBShJezJ+MpgpvlcP+Ne6OnMMyQ8yKHi30Z3cLK65MN+L4L1vd78/VN725SQBSlcLRVo7l/wfY/vaCzSJdFvx+SxOC7qAzJxHENlstA7M/hO3qjH/FPhfVMjqjehC1rjZ6N8xEp/rnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2CqbQe9FJZIGwPfYw5XRdElBo0LLtQ9aPIuNMBWjpw=;
 b=Ww4X7wP5N05TmAmMkAmztEweghy5BhGsnZvZME5kIofE3MTsdXZXT+XZLAzXLLDy9Tb8SLM89wnsYS5zm6DWeQLhBPYWGrS47u7e2L4Nm9HuZouiuLy/dvoKiUUrUr0pr+OWCiqWfTQV4m3WglcHXahmtNxz2u++LBIlBEmcgJN75y8hkuGBxF5vgFBucl4mEBv49R1cT26enV74ELrXbOkjcuvttEke68CAqvO4f/zvzhszxdD89qJSEuQZI2lTzBFk3yWKY4uyrzZZ2vzeGOHtNtMkhJXUyBFFwnpURYxdm9Dvp6ZlQUUqwETk5Rype2Gm015BeGhQOufl9LErHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2CqbQe9FJZIGwPfYw5XRdElBo0LLtQ9aPIuNMBWjpw=;
 b=E/Yq3iVqD8FETsv6oQgoaNq79ECbJFU6IbVIh/jmDikw8GFdPIbdbq9h0YquSUybwA6zlg6RMCNHsBdxwg+J/5/8GKqv2n7QCph3to78dFm3iVpdvllqplqVMqKEhmkd7iymrfnlH27xb7gT0HsUcSOxdP10xanG3snHURHrE7RiPn6RxKB4pEYKG5/VSc9es7g5/4CMkWGF1QaioVf8qf+JrNObV8SaXoWjrxkcTr9INeT1IUQa49mRSNp696vufPnkhDcCiWdJY3vq9llUWVoJNreDi2jJblAEoMdMFKnO1Kpu0/+0vTTZwO5AE5FjWfmv/IwWgwe/UP+NxqP2rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 16:03:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 16:03:23 +0000
Date:   Fri, 10 Mar 2023 12:03:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAtUyMGIGsl64vM0@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica>
 <ZApJGwPjHhlDwTDV@nvidia.com>
 <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com>
 <ZAtL0Dx0QRbXOTfZ@nvidia.com>
 <029bb2f5-78d5-a3f2-1ae7-97fc7147611d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029bb2f5-78d5-a3f2-1ae7-97fc7147611d@arm.com>
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: cf01bc1c-671f-4ba8-f8d7-08db2180f9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7tfrf5Y29VOFt/Z/IaSD9HAJpvUrnC5ohj9Blx9sf8oVlQoVs20ZwGgmsSTe1TKlhOkVG7Xi7dd/i27xo/mYQOQ9lTOrDWRwzsecnxW0oE1QX42WAEG6zupM8/JGj9Hcv/QDvmraQjy6vLzAqGUe9OoEPo3MqJYV2ghnFNNz7D7w6HpsqtyQvkof0yk2aKQNGxmEsWGH7NT1Q9zZknzbJz/D82HlTcY1chRyniG67fneme/SbayTwtXPDktYwFc82Fn+ehNMDCCwtL6N/czVKDpoNTWj1wuWxqBAPVykU8H4tyNEVtmIFRHbqhf174fcAO9f8iTbae272i9+oqVfr0g6n61YyEm+qZ5SrG1tcWldZ5UNYd4O+ME7BUee+efz/DjFuNZfIl3QBHh2TS24vDZsTEbWmKpeVl7DZD0U4TZUKlp+DKjURdPFjMwOBX23SC0bombOfpmd6IFdVN4nklcO/Mp8Mk9958LycdHiwGxV/jeN3BPhVqwppGniHLiiq2ZBi/iBXM7L2SGDbTlpCe5y7aiamjOcQgcU7bXQB0druQr1UCDAwCvEw28mt9CNzquNbu3nhNavwnquSVy6JZUOUV5Un1s4uJK0hhRSE+vD5Gv3qg4FE52gEqmojC0x5wMXmtaW/9+nIcIJ2nb5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(83380400001)(36756003)(478600001)(54906003)(316002)(38100700002)(6486002)(2616005)(6512007)(6506007)(186003)(26005)(5660300002)(7416002)(2906002)(66476007)(66556008)(66946007)(8936002)(41300700001)(8676002)(4326008)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYip7CK20yHaW3LPCykSpDnoJdk/bFgvDxJcbZ0ouTSZEmV8Cl8stQk4xUR6?=
 =?us-ascii?Q?pkqqa+4dkJeWSh58Pr6ADdVxreBhpLFC+Xze7bnhN5MAgaUF5gRjqkJGsekl?=
 =?us-ascii?Q?Bjy5eWGwPljujNN9FXU3GUpzFknrabJ9sjCe1xOqqGAIMhtltjB+6MrLaWWA?=
 =?us-ascii?Q?3Ot3W+EpCUHVqAGne6kzIfUCNZ6/1i/kt/d4V+GgQe1k17i1BM+xJ9F+UGqZ?=
 =?us-ascii?Q?FGeq5czZmArGQD+G8FaoYuhXMDT3P68aTdwTOCjf7hllVqg+cdXRw6MQewN+?=
 =?us-ascii?Q?5XYp+u99PY36qWD41kYeLbH9E+bS52KdWGljdX2L+Jttl3imR1SRcos/FQYx?=
 =?us-ascii?Q?gQlOzj+bdUJKum45tMI254xHi1Yd8PAG8259hzARvchAqvMhlWpcJ0xgNiHt?=
 =?us-ascii?Q?tTPGxa8/gZ5L7PZb9fd+Aomt995YxZzSC3mCTiakkiyEF5Hot2TOGPq80PZz?=
 =?us-ascii?Q?HSuZYNOtpJV+j1BnoKM16DjClwEKPgE/99pCeuBSqBr8uAg8MSFAK+QShZad?=
 =?us-ascii?Q?m9cqsMiupFe+y1SwAq9XmzUmBnaSO4PIE/FDwkTCAcR6KOoHmY8OK+ucaCz/?=
 =?us-ascii?Q?L4YPF0VGUIuRFQ+Z3UXRfiHLQBIFPWmu0fvdmddY0dIzQ1qHgIZ+pUkILYd3?=
 =?us-ascii?Q?LeQqIGgethLWf4u23IA9EWm5z8kvToPLsfNMCv3U0wGNAtuPcJcG/LnPZDJ7?=
 =?us-ascii?Q?OZ4XpJR2RWjk/X0X7OJUCwAyx9R47lj5Ql0FoKdu8qk9vbFT3cWZI2TOIHQr?=
 =?us-ascii?Q?HAE6V4O381rCS+X6H9DNn8V3XYlRqlyf7K6JYYms1JCPazboy2Nao3TnTV9W?=
 =?us-ascii?Q?xBN5C6uhzXhKaOgLTc4tOiy0wxLPMnahEblZFw5StVgcppkvq0kakMDw3XdS?=
 =?us-ascii?Q?Vy9nafsbyIhtElNtpEp/5wYJnaU6aVBfgokQrO1s8LvmOxPfFZi3oFEUT+Ek?=
 =?us-ascii?Q?RHHqcEYXDrKIydWVn3Um/NfhmFaxYLqZrekzuCpC5wZJS8Bz9HfoF7zunDBv?=
 =?us-ascii?Q?gDhktaaXLDz0BlOGIdNIlkIgDBNNRWixwwmEPs70ZfVrL+s/iiNhHV0bDn2G?=
 =?us-ascii?Q?+kyueRLlZ0kc9PgFX2q7tYndJgJF4QhgrcmNG7PbpmdnOXwmnmV6Ru0yTHce?=
 =?us-ascii?Q?rWuLFmf0Bzzw7T2qPm6bqY7xKVe2KxSEo/8W6VefamQNOQ+OektnfiyDId7i?=
 =?us-ascii?Q?Sz9yFXosxT1+4sTMoKVhxqxSgK2CjqUzztxC4vE5PZyEBkyohzsmH3M75J3v?=
 =?us-ascii?Q?XH1HU/suGI8PiihmkJlErOpBDpRa0nxh036FBH5vfV4j/j29zxD8yYvomaPu?=
 =?us-ascii?Q?sha5vEstQk+LmQQ3tbfie7fgbxDod4Rd5+KNTE84MZxF/LyMpIV4ylJXWU6A?=
 =?us-ascii?Q?eRWB4UUZKhjwhjo+v4tzQG78S50t8CFSG34N/2FpzNVvTxRyFR8d4Tz7hL6R?=
 =?us-ascii?Q?CSeqjIuVHVSS/9BWVM41AVnVm5OCNTGJPYSF6DLulrRr5mAw4EfoCPCbpI23?=
 =?us-ascii?Q?up96VpjeCLDjCVDJNJSwBQ4uJHSettXInKqVM4wlA1spKsO07pRav/uiyaEl?=
 =?us-ascii?Q?liqivCBZW+wpn+NjvD7jbgug/vC7Q3RPJBcMfh51?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf01bc1c-671f-4ba8-f8d7-08db2180f9be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:03:23.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A07i/jdYGlcYlBybTN5bNeDtteBtUIKfvvIKWPHCbgBKvqgYKOKHk8FRqGzqJ1Jm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:57:27PM +0000, Robin Murphy wrote:

> about the nitty-gritty of all the IOMMU-specific moving parts around it. For
> guests that want to get into more advanced stuff like managing their own
> PASID tables, pushing them towards "native" nesting probably does make more
> sense.

IMHO with the simplified virtio model I would say the guest should
not have its own PASID table.

hyper trap to install a PASID and let the hypervisor driver handle
this abstractly. If abstractly is the whole point and benifit then
virtio should lean into that.

This also means virtio protocol doesn't do PASID invalidation. It
invalidates an ASID and the hypervisor takes care of whatever it is
connected to. Very simple and general for the VM.

Adding a S1 iommu_domain op for invalidate address range is perfectly
fine and the virtio kernel hypervisor driver can call it generically.

The primary reason to have guest-owned PASID tables is CC stuff, which
definitely won't be part of virtio-iommu.

Jason
