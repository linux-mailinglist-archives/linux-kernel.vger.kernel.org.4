Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8567FDDC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjA2Jbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Jbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:31:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D97A95
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:31:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOGRp7tAH5B/T5FdB/dtgggTknAryGBYNMzgB27KXQOSqNkyFsXbfFhzMtt8IElaCOCyFObmWQGqKWscb7KsVyYOBET6Lst5CS03PSWdEQIF3AOTNMeEykPlo7aJNRL30YV0wHRG0zj0RcFoMAwkYj/dtx02crT1wdpOcGJSXt7vzYCuGVm0rxx52alSA8OLBI09Ksy347pehqGct/aqdrKQavvmq1BTSb5muquzpFFDIXKlkcGyEEUntv76fbxjnulgIbl8DFSKPpQT/oI1qlGbRqZh7jmfFzDmbeaXnOTZ/JWFf5hhyV2I0IbZYJskkG6iB6a8FWZw/SyfbkQilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pywJ/yLCAsAM4p+NpGpWlKiLljQ/ACFVRhxpj2ALPj0=;
 b=e/PeOU36TKnJQXRrNzJoKpPn1H5lPwllWhPZdndwXiAfqBAcpieBPiRlMeAJUtgQO0ONiBeOzVfuFTLVz3UjZJbBa52wswLWVzy1s2oS2K2UGrLjhupM7qaLxO50OOhYhucMun7kSEzFmNtcREM8sCVaz83HU7K6s4ngwKZxbu9uZFqHFuTxpgBWn+5rcctY5lNxCqYZeC06exZr+rTP1uyyY22FNrm7ijZbs7UnGT9TgGvSaUZmHyIGtNPicwAtjn+RdvVfarp6jx1EBzSVNLR+ak//vMNe9YAmQkj0CmKz3o78N60QYbYrNVa5jHV1yTK9NqC36R0OiPsRzlucGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pywJ/yLCAsAM4p+NpGpWlKiLljQ/ACFVRhxpj2ALPj0=;
 b=Y1q2gf/FEjKMy23vsl3MBtDPqfE/DuYYqO3DkuDi2W9wYQ1W5w9rAfhB5ecnXFZiMioVSFE10kAn7IO0qghbOaJx3LLQLagP6X8jq1zXunFk5om3ZmgiZoVFGUnALvNSRsdA7PMI562Jsv1BBXBwnKa5fPl8LhraJ5l55TFHQQAJojM7W2bEwPnf5dQD96TOql0gpgF/IIBYFK7zV6arVAJ07JJXXoCPEEDnpHKV1XwZ4d8e+ftSDg9rGMWU2mTaCHF35LmSSdJaj8RsKLtkgbAGtPzxTJUyngT6Qvq+V9KRbi2fZK64sexNK0ctlbIe8FGntvT8I+GVrGD7E9R5BQ==
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Sun, 29 Jan
 2023 09:31:37 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::3c) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33 via Frontend
 Transport; Sun, 29 Jan 2023 09:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Sun, 29 Jan 2023 09:31:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 01:31:35 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 01:31:34 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 01:31:34 -0800
Date:   Sun, 29 Jan 2023 01:31:33 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y9Y89ZQGNLwuyHc9@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB52765A5EBB875ADF56ECB51B8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765A5EBB875ADF56ECB51B8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8250399c-a0a3-4cb6-7d37-08db01db9e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1gbWvFp8j6qyFCPi2d5ujMt4mJTp6RV8qurK1nwUUZGxzl1Q6ThgiOir9oTe43r+FLzGcYQ8rNwuS1ZtuXV9M3YSPXw8yJbbhH31E5JLmwvVQjbpuQRt6uGFmzWd9Y+yrCur3j5dzSHsMYayieLsM4IAGse2V8fnUToRDepeVH7D8oLwE5urcUVINcEk2cyv6njOSnTOelfNP/afw3hektXsBy+S5+rC6R2zSgYgHDBsMcAzDggDSXA7hJC3VChWvLmVSv75rW4Su/x8SVZDin0MebU8VLW0dG7gf8bOtfSE0R/pgzVhYLmVFAxKGT9KZJbQvKYiZxNMCsP2Vzn3O77cWw621qPTg1mNIj3RBfWT5LLVu92wevbdEehrPqPzYHhCrCzvqpw61lo6zI8kgAZLE6nh92HS8OjBlqLgGedWLU/ZlYeiHgw0IZCcpShkNwiR7JPVFl2/bEkI9QYKVRGyj9MjnLQvwBTIZyf9OpX+vabdKhA71evU55Ifttc6jXnuDdEX0x7EsKWB3OFksVnO7DCSinYNH+fysSMMGjdjqk1xW11ipqTroBdHSBILzaT3jqMNDv+t7cFU0jWO9ORhyh161xg9w7TU8Gwtt/9OBI+IC0VpX+N0R0DwlvgdYnMDugi4elS2T5McjeTIWNJ5ceXKkaRLpe8fMV7dEg=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(2906002)(356005)(82740400003)(5660300002)(7636003)(55016003)(8936002)(40480700001)(36860700001)(86362001)(82310400005)(54906003)(83380400001)(41300700001)(4326008)(47076005)(70586007)(70206006)(6916009)(8676002)(426003)(186003)(26005)(478600001)(336012)(316002)(33716001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 09:31:36.6929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8250399c-a0a3-4cb6-7d37-08db01db9e4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 09:24:38AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, January 29, 2023 5:18 AM
> >
> > Since the list_del() of hwpt_item is done in iommufd_device_detach(), move
> > its list_add_tail() to a similar place in iommufd_device_do_attach().
> 
> It's clearer to say that because list_del() is together with
> iopt_table_remove_domain() then it makes sense to have list_add_tail()
> together with iopt_table_add_domain().

OK. Will change that.

> >
> > Also move and place the mutex outside the
> > iommufd_device_auto_get_domain()
> > and iommufd_device_do_attach() calls, to serialize attach/detach routines.
> > This adds an additional locking protection so that the following patch can
> > safely remove devices_lock.
> >
> > Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

And add this too. Thanks!

Nicolin
