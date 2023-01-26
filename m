Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE467CE79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjAZOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAZOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:41:42 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E36AF46
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:41:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auD8MwDZ7xlZiZIgBCI5SjFrVgS6fJN1RkYJbvnQIwWeFt/Tq0nipvAErkwXuOChbNeXDORGg1pizZ46IZPkCTAQ86WpCUMIy6LCfslnujZ4T/l94JpG+cPDKXOvtcUvoXOlOz/MsCCJZbrtjZHwkg3Fs7JpCiC3yQSIT6wn5ZgQWhLTkgDOVxEAj59TuxD5nkNTufn7PLJ7din3m2htsHtyo/8l//a1eUUy59KGr3TKPnOKvyYuNcOj+6ILmuEkYAAes1EVCcUwGwv/MG7BRtWMP+dpzNEJ4qmDMNyKvYRTHlQqUi6ykno7uT/oJtpVcndgq9tqIe+CzqWGpkun8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mAAVp0BOZRP3udEsBeTmTePAA6Ius7jLWpWHfC2AjE=;
 b=CqF+plAC2ZxzZGb3A/SNEQ9jMkYi91ItIryHQ1N7MlHYy9Up78czsUPj7XDxBZy0jVbwQkZ9yopXvgWKnY9NfSKQH1AtsWck2T8aA7F5c+ZXHHjd7/FsADYPYA9iYtDkCyV0PYrR+GWEGpnMj2gSqPY7NO3xbXLcVOAwIio9iRRef8eeHiBhIV7i2mtU41GknUWxZNPyBqh8Zph1hSmCny4Og8w3DC0/CeJy0ExZStMafhNUEGfCGe5lhhV1d76CfM5pVpLIMJ8aTIkonNfywM0dXRYpjbNUZcIf+dzeGM2h0z1g17XJmO2+TGsyg/XEiisv+YWfF6pi1eD8faMt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mAAVp0BOZRP3udEsBeTmTePAA6Ius7jLWpWHfC2AjE=;
 b=LY8OmMuF0YYvIE8xDurTeUkI5NX/CKcN7l+ScMqE1VzSw/F5DrH1wALxzE8GX6K15ds155BOdzd4cxTt/Aj82DeeZT6zXQFDnk5FT8YOo51mXN7DAp3BDg12f+9NVe8PbBdzvLeOXXIrEfeskSuX+QqPM+7TWHpNRtTKSglOF1AnqN7LySzCnpil+6hy0x1RZ35gun3zm+GODMTtl3egEeBO6t7b33nnK8Oh26tphYVCHcmJL7tFVNKojlMgExJFEqf3WteT2F+p2kHTWRGsVbrFwd5QzCVerYW+sVFhn9GN8IbmW7NyuFIoOj0aMiRjhleTgeCLA4QJszWZ9zC+5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 14:41:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 14:41:10 +0000
Date:   Thu, 26 Jan 2023 10:41:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Message-ID: <Y9KRBRKdwSIRrvQw@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: bc99f0d1-1902-41c6-f74c-08daffab5dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd80SWhjC0CBuIEsX3qJ6Smtk6K8VT8VLCuDaskpSwss+Ib1tMtFBmGWZgxZD/GzbFjPMNbdRAcj+M3oJ6/JzXxVwj4NXNMyDr8B1UwyyQ6aTPKGraJTpjBa65F6B7fQ9T6RptifOabbbMgcPXAr3R17eLNUewJRBOB7zt3zdyatxYcDPBPHz1aHU8eDSA+GWKiVrfYqvsTWwoyaB1oWM12YsTJDLN6s2+21yNSNddWj3koNIgMPO2NhKbQaX2UhH23bUT9wW40s8avbzwdN/MsSKFTZksX4GTXPet5Tx+GigkrxILLxOPfgczmKjYs/fbdpcmy3HKS4inMK6WTlylkRL6oLmLMmw8QEKrDX/g4xSfxze2DWXZcPRrQAs7X5fZZe4ndDfcB0U30p9dspCDjHXRK8UOf1HJELcewQfgiLwxJwlYZ34d3/8m2r2ISFzHRWcbV8r9bBgXOgZIfjTi04q5TFSMYGF54pSkNHGgrzOC6at84eslG+pXX0A6mkwVSNXA2cMqkPum67PjGkpB4HaCJ3+N9AZi0/lxeBdWNpZczJlB7+/567nH0lR3yLCPueBP3cRYU3SbZa5Dt/iz178QFrculkmrcl6KpCO3cQKRLfJMb5+uoqoQ/WkkyKSRQ28eHWKPRpb5fFh4j2HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(2616005)(6512007)(26005)(186003)(36756003)(38100700002)(66946007)(66476007)(66556008)(86362001)(4326008)(6916009)(8676002)(316002)(4744005)(41300700001)(5660300002)(8936002)(2906002)(478600001)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFpbvMlO9fyJUH4mljhBcpTkP77Q8l3HpWfNpn+KjhUEl52HAVCWhGM/VCI8?=
 =?us-ascii?Q?8rZhMgczWCkIfRbu1nHzpgvKS9icTe/qDeIL17AowqhxiLpxYmI4aGuwN+Yh?=
 =?us-ascii?Q?swWLDGuiHV7f43qTztzt6Wt839Uh45sFUlq8efP7TbZ0YnY9W1cX7KRJkF0v?=
 =?us-ascii?Q?yEkSqU7GiDPsrEYteby/v1pd8Kg1qWEusR5yYyoi1Z4O+9Lz9lbS339mIkz3?=
 =?us-ascii?Q?2nWf7y0E0/i391nBaztWU55cmPEhvz21X0s/hy9i3ijO7IPgjUe56moc1pUw?=
 =?us-ascii?Q?CxF+1OJ7bpNYJloqjnRWYXy/oN4C+T4Dh6gr6BD90oRppZm5QxZQ12z7PYAM?=
 =?us-ascii?Q?p9zdy56ndz62egeHBP5skEaea3roCWOhvaBIZKPE6ntz15Vi2e88h5cZmANt?=
 =?us-ascii?Q?280XeN3JeFKyMPXM0Aebqcc+Bv3vbDbkHA3K/iyUuICWcpdCk8g/7asB1X3c?=
 =?us-ascii?Q?TKTM5KaS7sAsUeFjCaRYSfULJj0TBM0yE0ZR7SWpTtL0l+kTbpz1w57z8AKe?=
 =?us-ascii?Q?nZ0B38oCv/7JgoNrYnasPWGgXCjyCDLTPh5pCK5UxsKemMWkQOUjWV26y1mw?=
 =?us-ascii?Q?l9LuK29ZTsSdmG5Tf/jA+VTQ5DFKfYpi5pyulst5Mlb7HE1xCq4WWYeky9gi?=
 =?us-ascii?Q?mCLN8JUAVADAM9zrOUaQLQ/0p+U7Ltm441VQxYK3OTMvHhXspFJr2SSOpx2V?=
 =?us-ascii?Q?VWW+S4Nj4xfRMsarbavRozRVsG8eEcSNNFib8Y3KO/rAiI0gTK8zOhLupf2u?=
 =?us-ascii?Q?ANl8LkDlQogCLztkq8n5qxBOtMRyJEZkmSJIf+IgGVECV12TWVQEI+AZQXCN?=
 =?us-ascii?Q?Y+1o0UuuUeclmbTznSaEtugAdPgW71LW6XFohjCrcVa95BrXaeLAdcY6ALB3?=
 =?us-ascii?Q?Jf56cATPG4DnpIhaC6DOaF+SkKkpSh2/UiTiOW5+Lbpb5eBpDAhmY74fx28I?=
 =?us-ascii?Q?RoNakmNW5k+1Kg/fS7jxi9JhnsjwbFAGL2/T8vYywLyBgS0TIie5TV93pE2x?=
 =?us-ascii?Q?dygmywbDpsPjC7oOJ5QA51FPo/xh2dGHPG3iY+k0QHr7f3IJkA66v1iWV1oF?=
 =?us-ascii?Q?/Y/Yaxnunoa14vFhK6PaDRsdNPOkfVNfgTg8j0KbFpUiCcfeI26E+gycNlC+?=
 =?us-ascii?Q?ff+a+cZ4PX3kT8grRR7boQWZ6EVAgAKj4p6x3XCzttXJJjBMkktOyduaPV/Q?=
 =?us-ascii?Q?FOoj0+XX7REAlFmh+KHFIlMKaUuMJrFuINGNqJbTMxBUWEGX0LkPaiObn2oQ?=
 =?us-ascii?Q?0vMFykGzJe+cX1t5BJlsGEvpelz2DXWINiyLvwKCZfLNflZZoqsJu6NPvpGl?=
 =?us-ascii?Q?7YZa4aN2GmwdVfslY3XJzYx2AocVgWbWlhVsdi2/zePWdS9hty77pBKIMG1N?=
 =?us-ascii?Q?sywwBJ4k0f/ZeKlIsow+H+jaeABUDibY3rqm8nTtRnxfP8FOLBARW4H2o9x3?=
 =?us-ascii?Q?YQMFcv9+VbBABtUnoHQKqijsYloYjvMoLN9NRjiTVebyI5g6NnFvZi/AZbZx?=
 =?us-ascii?Q?1V4wluSQNUh96vbqzNYH8kn6hnamTic/aKNWMsWKOp4ib0Z0ukix6yQndN8g?=
 =?us-ascii?Q?a4wj1oljibqR6yfoHBg8qxKmqslZZU8GGkBqEU+r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc99f0d1-1902-41c6-f74c-08daffab5dc8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 14:41:10.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kRZsodtlsJTxH7UyQDWOOH3bnVdzbFyGUPxP+21RXI145K/mV0Eo53LKmQ5BxLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:21:29PM +0000, Robin Murphy wrote:

> The "check" is inherent in the fact that it's been called at all. VFIO
> noiommu *is* an IOMMU driver in the sense that it provides a bare minimum of
> IOMMU API functionality (i.e. creating groups), sufficient to support
> (careful) usage by VFIO drivers. There would not seem to be a legitimate
> reason for some *other* driver to be specifically querying a device while it
> is already bound to a VFIO driver (and thus may have a noiommu group).

Yes, the devices that VFIO assigns to its internal groups never leak
outside VFIO's control during their assignment - ie they are
continuously bound to VFIO never another driver.

So no other driver can ever see the internal groups unless it is
messing around with devices it is not bound to :)

Jason
