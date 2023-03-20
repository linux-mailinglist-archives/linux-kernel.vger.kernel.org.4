Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF836C231D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCTUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCTUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:47:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9FA8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jdmq11yKS8YsZapXKKC/lzX+Fn6Rcq1Hsw8EMcWUQV7eitmhw6nQF7IwpC6LnIolqQYMPSVaAh3deRSEY4jmqZu0XroG0aJ7GO95ac4XDAXPetmaHZuluknmxRtSNpPoR26sFxTsjyZD0OsCZtPftdF0tDRxBcNAeDI/L5LAddFqgX4hYThN5SA8TqlqCUSQBfBOuPiF+KGqNCPTIYLakQlohg4sqKhSzL75l0Gq9/6IiZYDUkEWdbyH+1mxhMj3qx185z7J3wGFi/CfMyp0J4k3yTaUZNyt/9bbV6hPeCFz7/Q1YEUlXXkX0ONT0HYT0XdI2wjPSen1lGPlJvMKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14Mva8e8qmEkbSikBO6n8yxgx97b3Bn+isFabfMXLoA=;
 b=KKv/EtC58RfgF6PBKpxgHIB+gHTJJO4A7klo/Kc/gcp7V5/nGxeJW1IFw4x2QPgWMyaZ3wQZ+mKmeB32omT1PwaY8S/gRJRHX2QnNbj2VhNodyKCFStlilUdLkd7yfD+c1WNeab4xomDWm4S2pd/Cvk1Yk/swIBOnx6731A0xVmJizyx72Dgb8McRoRAd5eH5IPaiB2xaiGCtqtqctrT867c0owfPBNUcQcsHJDDtmw0Ze8SUEr7ujp7jZMXCB84Nres3xJqOMXgmWM7cHJf2S+UnYYmwqWLn4lrxxtRZzA3WCuUpE7qmHCFQNvaXr5glhwL5F2XGWnFMJSZpv4ejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14Mva8e8qmEkbSikBO6n8yxgx97b3Bn+isFabfMXLoA=;
 b=rS44QuhANNXubaReeAGuPhyOBdXaNCTO53UbxxEyllnqvsRakYcahWrs8XSgyhPZasxtR+KLPeuIYq4z7+Blc/oxNuIWWrGOWu0E0piUOYaPMiBXyIIHMo5yyqKAFbWekDwO9H3LSyfBTw+O+q3NvVSK5TI94RO4K34ZZesaq9lhtq74erFkOj2VnW/1eSOlN7CmEqi7HBvXDrWZmLUZIm9poihU1BsInjOPGq59dy9W5DEGbZygc9G770pBNpV7AzARa86ur9Yu68fi+2IE7AYglDxG4Yuo+IxepeFHpvr2hwssy3bSpp7l3qNlOoJf4sMINMoHUKMLs0XQ4JOZ4g==
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 20:47:08 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::58) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 20:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 20:47:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 13:46:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 20 Mar
 2023 13:46:54 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 20 Mar 2023 13:46:53 -0700
Date:   Mon, 20 Mar 2023 13:46:52 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>,
        <eric.auger@redhat.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBjGPI29BE/puciv@Asurada-Nvidia>
References: <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
 <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
 <ZBiDcYwxL7eV1EmQ@nvidia.com>
 <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
 <ZBig0fN3l7LsUlQg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBig0fN3l7LsUlQg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: d818c371-cae9-4231-8a51-08db29844566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wP5m6YtOuq1kQzwFy7mYRVBE+PK6b7Z8SQN/EO1DC9LBwGr/yFwEIM7+BHHILqMPG1j2bWGYMSsxPneuR255GOkvwBFl6nsfrfCOc5P2RVPoz78A3sk6HOhWzDosYkqB65Q4TSb/Du6ytcrAPZ8fKkeupqwn1gBMyWHN97JvKTdkD3hJfTSIKAME4uRJaiTyhBQPrXNM+AKe/tUo6l3mWFj7W2qcHw4JowMTsenOm3QW7gRBUSYwPUScLSleyitMoqXBZ/gc53Bfd2KgWb386Yk/0WywoQVI1EBMO+2wAjc+AQCBLjrAdZ0WSS3fdZpv6gNzs09bw5uZuUqPvwDYiKFtUmvf/bri7ij2icFUn65oEzg/6yhLNR+s9zfURBDVCFIx3Qgjwtp12SX/lnfDWSaYOTJILqE5I56wxBdEDQiQ0N/g4JOm9+J9fKvqoH5AyVhiBt0ejXLOTNyGVfjwTspKhD/EEufcOxQLEnUkY8svQRnTsnFj9+5wHp5cXR3mFzfrCfLDO1SKjnuvfMzxK9zjcm2SRpMLAAx58pMMt93frucTDP5mjpnpCCcLlSe3j3okR+zJ2zg5l1f+V5jRGyYWQMBw0vvQ8W2heNSoqXHtkDRa6vwdcNX118lUX8L3gxk/b58CcTuKBeta43jGsfjBYA5KKKkrFdaGRYZWsdbVgYpKvYadCp+1aUmAvf2M+YwGicHg5yhc1mP+vxxikmOnaZvuFQtT2LY10qR/I/9ZQ24TERnOI/KGn8DCPLWX
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(47076005)(83380400001)(478600001)(6636002)(426003)(336012)(86362001)(356005)(36860700001)(7636003)(70586007)(40460700003)(55016003)(82740400003)(4326008)(8676002)(41300700001)(40480700001)(2906002)(8936002)(6862004)(70206006)(7416002)(5660300002)(9686003)(26005)(316002)(54906003)(186003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 20:47:07.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d818c371-cae9-4231-8a51-08db29844566
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:07:13PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 20, 2023 at 09:35:20AM -0700, Nicolin Chen wrote:
> 
> > > You need to know what devices the vSID is targetting ang issues
> > > invalidations only for those devices.
> > 
> > I agree with that, yet cannot think of a solution to achieve
> > that out of vSID. QEMU code by means of emulating a physical
> > SMMU only reads the commands from the queue, without knowing
> > which device (vSID) actually sent these commands.
> 
> Huh?
> 
> CMD_ATC_INV has the SID
> 
> Other commands have the ASID.
> 
> You never need to cross an ASID to a SID or vice versa.
> 
> If the guest is aware of ATS it will issue CMD_ATC_INV with vSIDs, and
> the hypervisor just needs to convert vSID to pSID.
> 
> Otherwise vSID doesn't matter because it isn't used in the invalidation
> API and you are just handling ASIDs that only need the VM_ID scope
> applied.

Yea, I was thinking of your point (at the top) how we could
ensure if an invalidation is targeting a correct vSID. So,
that narrative was only about CMD_ATC_INV...

Actually, we don't forward CMD_ATC_INV in QEMU. In another
thread, Kevin also remarked whether we need to support that
in the host or not. And I plan to drop CMD_ATC_INV from the
list of cache_invalidate_user(), following his comments and
the QEMU situation. Our uAPI, either forwarding the commands
or a package of queue info, should be able to cover this in
the future whenever we think it's required.

Combining the two parts above, we probably don't need to know
at this moment which vSID an invalidation is targeting, nor
to only allow it to execute for those devices, since the rest
of commands are all ASID based.

Thanks
Nic
