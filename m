Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C613A681504
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjA3PaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbjA3P36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:29:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE24C22A03;
        Mon, 30 Jan 2023 07:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8rpgnS4B3j5d/emUy2i4aYgIeNn9KQXXLzqCey1xE/O28/nmmx7uiGidYKpRvsX0pFuDEmZ+V3FnZfHSQWfDj8wFEb9TjQGRvgUWuy1a8bRpWJHGrxBl7Zw5zTWriuAOKNuobWpJgpNi9B7UxMMe4VXhcJ924s8nH5BDMU1rq7GMJH/im4ck42Mv5ErQvFaDl4UaNOLb8TLn5IlKfJQD0bto+NfKOkf7+ZpncKeXgS9P2buU3fgCnZezOWEo0AtTQJ5HLA6KVsrwMINwDl0MgECPGnv60sonclw7/xwNE7desAvPX3dfY0698vPpOOnfaqSPvqnSx73z6J52W98gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LuNC+FHxpAR1quUaVW5JbLdMX3X/wF+kITrzszLIRU=;
 b=ipQlxptVvoM8ocf3LDCF14W+9OwAqbAG7SVMjrOnaLGfFOc2fpT3viXqEp4AfX82B4BEzjZJg8TBlmaALI9A+MxuohciGkMZrysw5l0E305rSz1kxpk19+b3k3VAiEF8CqvfPAnolOP2nN3PHy6CTGuB2UgobCyuTxpAt/4RgtgcVlU3pl/6jBnd0YZoM/2uDqZZ245yxBYij3YjbYFw5vNm8dg4A7HGTVbksy3u9SSNjk4A38jRkJnNvwGANKgUpVMuHOR5Vpq8c7RkjzyKDytOgvG491k0Xu1p/wjiWCUM96TBFXQYl8p8VCtfeD9/Gwucy/40dy1LO/qyhA4eBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LuNC+FHxpAR1quUaVW5JbLdMX3X/wF+kITrzszLIRU=;
 b=tfkRBn9nCs978JA6ZfcTkvetXkw49/oRn3Goh4tpH+isNnLU9PucTwVyM2iazbU7wxTC8/2gu/7xg63pYS5QVpYAdmGw18pcvbaQ0ojrY05MDo1LnCLY1JYG/nAiORjHzbN5myKUDs9i6Oj/RUpHWhRrPeh/yzVdFXW8AUi7/6XX6XNZItBgkq2NP66Ottg65he6yUeGp+T3Mi2hPeRmNCI93QmpdxXinp55ApirCKhaWPZBn1qye8Oso2Tkm6D2QPamfy/dKdFtAdPBiWXir1gzMMhRSU03vaC6nP4ByoaHgCY6jpBHXDRH7KTwsR8rFebhinLHfT+9mohqMQZXUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Mon, 30 Jan
 2023 15:29:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 15:29:54 +0000
Date:   Mon, 30 Jan 2023 11:29:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v5 5/7] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
Message-ID: <Y9ficPosWtGqbDit@nvidia.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
 <20230124125037.3201345-6-schnelle@linux.ibm.com>
 <1e016926-b965-3b71-07e1-1f63bc45f1a0@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e016926-b965-3b71-07e1-1f63bc45f1a0@arm.com>
X-ClientProxiedBy: BL1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: b82e132c-f321-4193-96d3-08db02d6d614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGyvfns5XpMjsjuti7Hy6h6rTux+xEuhcV7JE9l9AKPfRqeJeObMZYGMM2/SHDlTGToS9a1TbKnoGbdlrG2BwlJNnHmZs0o3eQRpiTK8C5h854+jm89CDwYZJ88IsF6mh/QeMwiLGeTll+iYwWS4EpbQkiIgRsh8V7Arlzj9OYwOMEnGorPyMhY0fJ2oGlCH702EyC4WkZ33ItqTjF5kjf+o7cePjub8IpwEsAMIRQr86aDPMxas8vJjf4iouiEbR9CFSLU0R5TfdbuC45xro0YZ/4EtZxXL/NQEizwQdkU6RE/sIZ+eeVXIUnFiqVRaZfzbbr6QIZN4tIte83eqCJL9r887//8hgNNcvecWQL8w3kVoCpIMBRH/kLjE6u2v0/JlGtwBTxN81Qd4zPFsawfqqXvuEbRLQ+WwJ5zOXWpRaB4pLnQnJ9/hTaDNh/tHNTvFpRalgzmL5GV/Cf2FT/675rSKr9RdUcqr9QdxHmzljOG3Fwd9RTrxthezHLPKT9FLYSzEuvx9TqHFKxUNiEIjize2uBPaoNM1eFK0i7yqQK4T+ihMCEnFDDcuFzLx6aKL69PL/1yVrVvcQr5DeMtZVQ7yLpzwkm+N42A2+kGgf/mKx9BDxBLTgRTs9fD9I9yr4QQnjoCNn272U0tTlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(2616005)(7416002)(36756003)(6506007)(4744005)(186003)(26005)(6512007)(38100700002)(2906002)(6486002)(86362001)(478600001)(316002)(54906003)(5660300002)(66946007)(6916009)(66476007)(41300700001)(66556008)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMg+BPUPRlkSRv4/QQ+2082KRShyi6NsGsMGTZwIdLNes76XozZQNc/TotCt?=
 =?us-ascii?Q?C4M2tfJ2FdmefsprrHbfbZn5N1f4j4DHM08mrmCAL00bVsdQEmN6LRPDXft3?=
 =?us-ascii?Q?I33VMIZLWZS7KY7VtLmZACIULLquRfDwyGMIQLnbMIyJP1GqawhZOd8ALAGs?=
 =?us-ascii?Q?vLTZjpkWJejgKtJik9pUjZb74rfcBlDNtxdS5pGiqPhHcK4RIXvyhuF5Tae2?=
 =?us-ascii?Q?mlUQsShvKMe8moEIuLvC7bHbxSY2r5US77rsvNYySGTqr/HXUdG9PFUdnC2A?=
 =?us-ascii?Q?/NbDynRGmJfKA6Vqc3zSZqiTVwPtHzGyI4DCn+kcFQt0pyAKC9Yr89uMuMSK?=
 =?us-ascii?Q?htw64lj3JrtS2naBsEUhEha2xvC5PntrioP+e6GNMSsHq2/dCtWhjRrm8jMv?=
 =?us-ascii?Q?j+XOIRwNvofDrWwWWW7UNop05nEn7FO3lilx+HkNFESApeHeDKf6A0EQn1hh?=
 =?us-ascii?Q?uS5s077hy0PZGgNTr3aASt4E0lVnHnpwo5m5De1wehLij3HYBh+lW5SIhxtu?=
 =?us-ascii?Q?3u+4Ja9Is3rfFezbp6dk5PE3NBxcNOVUNXTY3nQns3Y/D2aD6ZgCzDowj+R8?=
 =?us-ascii?Q?vz4ZK84O9Y0N9ZsW7MhBlI4mG40NNS0oMDjNHiD6nbgYmZD208GamdUtqrO/?=
 =?us-ascii?Q?AYt74IHsz9LgD3q2DTNNHiHNcsYCAnK8vyZ8ojOipyy/CJj1eTD/9nrSNky0?=
 =?us-ascii?Q?5BYMWO0FlOim87qK1OoKWMSBO+lfOA3zIhH3gxd3QWdJRKHDcLL/h+f9Q/AI?=
 =?us-ascii?Q?Xo7w0JAPMFwga/5HJdOiakzbzK1rgdYyFKBAcaqopU7AS2uhf+vBzrs+EO8g?=
 =?us-ascii?Q?dBryX7J27E7Wo+iGv0wHsNv7BZHnLd5P5hW+/Y+phUNnFJkDKXeA1NBay64P?=
 =?us-ascii?Q?d/RUR2CYxk4jUg4RMKcmqVZ5Qyi5lmc/9kLt6FA+s0Ji/nFWXMxod7KiDKs0?=
 =?us-ascii?Q?SaTAeRgpd9JVi3/GjyvlGGSzQSa7oyIYYSQm0zo6s5MSKmd+7McmBkUYQezg?=
 =?us-ascii?Q?OpMD5U/LnukDg9G1OLcMfMpVYfk/ljYM/w4VWuv0D7a7g8BpJdr+Y1aqESyl?=
 =?us-ascii?Q?ltV3gCFcw5Y8KV2cnG/UFJL6m6VtjIc92l77zuJUzBgfTckXrgKhsEIepuYn?=
 =?us-ascii?Q?RHqNiqnDFbiQSBu6hgPZ/PVtR1IyPGPSxeO4t91211VMQegpOD5ZEeNWyEDT?=
 =?us-ascii?Q?4S7TfkbxJcteGkmkf8wMszcMKpH3trPtBWA7n9Q/KDTftgIMsWh8jQNA6KPS?=
 =?us-ascii?Q?5DItOkzGwwrOLg7iqYE3Zz1suvrUobet8WGtuUla60DXUKrKBvmRQ1KDW9uT?=
 =?us-ascii?Q?9a6ElHQsNmxqRxeSKM+YDh+uyXaRaWL+eadw2cXHMscNG4ObQd1YZuSTphp3?=
 =?us-ascii?Q?EbtdvlNu3jXgNzWbSdBMCM006O/LNPMsn93j338DmdQYIBH4HM0wm+vJREjn?=
 =?us-ascii?Q?Cs6ZxL18Skx6mgraLIzUp5NWeauoricTbuyCf7xJpVkyvaILLNBsgAayVOhM?=
 =?us-ascii?Q?LPOO2OiuDc8UvAQA+ihq0dyX0F2Ceu9ux0PRW/WRw/CFvwe/aVpmggyReIDG?=
 =?us-ascii?Q?5TGNCW9chgwY8EQcZTsfR/1FpjSwCzN+SAKYirNj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82e132c-f321-4193-96d3-08db02d6d614
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 15:29:54.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+S2NvtnKp39Rrs8BmaHANX6cFsxh/NSBm9Q/SmDzaC4Pb96YJ1t+fu7dF1y0Gg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:13:22PM +0000, Robin Murphy wrote:

> Either way, the more I think about this the more I'm starting to agree that
> adding more domain types for iommu-dma policy is a step in the wrong
> direction. If I may, I'd like to fall back on the "or at least some definite
> internal flag" part of my original suggestion :)

Yes please, lets try to remove IOMMU_DOMAIN_DMA, not add more :)

At this point we should probably just sort of hackily add a ops flag
to indicate single queue and when we fixup the policy logic we can
make it a user selectable policy as well.

Jason
