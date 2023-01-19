Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0073E673423
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjASJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjASJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:04:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956C67975;
        Thu, 19 Jan 2023 01:04:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIY/vV/QO6azI2V+5Wc0ydqvlL5sj3Wy5ALX1/ZJg5yBBWmolv3HHpWEjL6q84qmNKFS3QEJ6CSuX9d5gmVlN0492+bglh5xc4yzUMEN0yIBAMisGuLfJejNySjcyEx4gBoSJe5V4wy3lSFsYtanVO4D5CDU++coaWk8tHwj63/1wxDbAcTnYbFghFaDDqJwIfcI3ucxjZYlKDy5GKqmiBz1vRHQ68HlEZpCjThVVyARaYSg7WjiriOIHdyd42ZTliHukn2Ec5buxVXXKX0uufCIw37eIh3S6ZXyZR44ZkDUBaTP4x/spxm/u7HrI7VMmyh6CRj5Pz3k9q7k7LFywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLgkp6vOeQacTjMenXXft2G87GTvLfDlDLGQU43shig=;
 b=CojAM3iehHl1ubjY5ICjY+mrVRZH04dlkgnSqZip68N8AsXwrHYkOHGzikpn/PXGYFkDKkqdJPUeECjyf8C2O+vv9wQec2KC6EWwjGQkPXcq2AvvmUhTBEmca5kxKkrNmmYqgF1IE13KTm0AlBlHBTU6FG54o3SkbvetDoeCtr5X6sADtEoYe9k+Ef5glDI7Re+ZpntE2rqSSOIQjG1W5ArJp7gIkj+v9jiPXzMrO2WFrROWLCqmv7goh38VlZYMUi3ujv6devYOBDMon0/dSO2kQf7jS/gbqNnvNmOG6nnIcq0n3rIcGC9IAbET2x99AOmfdHJC01Ol54xB1HSJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLgkp6vOeQacTjMenXXft2G87GTvLfDlDLGQU43shig=;
 b=1qUqvS3k7yZlAn1FbqFuU+qc/NAEpyqZDxP+QtF1uS4j8bC7WR7BqoCnYuc/0nIcuXcSUoXRgydneeOoqIIbY7UvEvGeYN5mwtQkFUDw9q1sdfp5+XuKH1v93Vot0jX+5sxr5H/GkgH3rzbOJOE9GYG3aiM8sHVKX10LfQS8J+k=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 09:04:44 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::da) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 09:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 09:04:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 03:04:41 -0600
Date:   Thu, 19 Jan 2023 10:04:38 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <Y8kHps1w9SVM/kg+@rric.localdomain>
References: <20230119082054.80550-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230119082054.80550-1-rrichter@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef1a8dd-2fac-4d9d-0c43-08daf9fc34f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7uvXQg/6X0B/s0UFTad9i7t9sRAwI7HRVmPHHSCrOlWBAszn3YdGgz78yu+qAjn4F4/JI2BUVju6ACSDPqtnJ/O0644sMYAl/XmnopV0Zkp6evJ20Y6cBHNp3dVGLuGBRVunQmUOGYW0o0rZhaf25VLrkAOq4MNurQqKHNolX4EIMtw/Y0AsCUuA+zA5ffHzChCdnwcBzJoAhTo7IYaZZvqVs68yi/gTBeMEH/Kgeh76LE1XUC88fj26MJJWydWnRTcPWDSmAvtVg97s9V+4EaQlcq42RKsZXp1Mg8s91stMGCjo7EGe5cAuhdheUe/GuU95Dx/YzlxZH/89Kef4gFpDVvQg/z1qR+Qc3lBS1KMeNWlgKS1e7/XAVkv994tpXyjD7YRk5L9OzapjDK1ZGmSGwNlQ7pa08tD1prZ5CcMcTrcc1vU0oTlpLrYfk+JlDQH94e5fc5ghNtQOJGSoiQkmk5RUW8qfRnM8wfS1bCzcia7dAdFgpxkcE9m5CAR2UwPGK1PQ1uo+ou/B+1FCTfdz8GwE1142YdmVVvfBlGY23cIqx7s0JpbnpJrgtt+7B8A294LE+i1mDs85N3Mjwmu44TAPRKRSg0MjfJZ2UhIuUg6AH91cKUVPnmcaLQICJjLljBggWiTjtlNPqyuq2+guh4lxcKve4nf/RiM6nTzkniGL9zEOaZJSVgy0Ez7xDx25+DPercVMTDmumN2ShsR6YX6ktLRcHcXiWw7j4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(356005)(8676002)(70586007)(55016003)(8936002)(70206006)(4326008)(83380400001)(81166007)(82740400003)(5660300002)(36860700001)(110136005)(7696005)(40460700003)(316002)(54906003)(6666004)(41300700001)(40480700001)(478600001)(82310400005)(2906002)(426003)(336012)(53546011)(47076005)(9686003)(26005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 09:04:44.0489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef1a8dd-2fac-4d9d-0c43-08daf9fc34f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.23 09:20:53, Robert Richter wrote:
> Commit 2aeaf663b85e introduced strict checking for variable length
> payload size validation. The payload length of received data must
> match the size of the requested data by the caller except for the case
> where the min_out value is set.
> 
> The Get Log command does not have a header with a length field set.
> The Log size is determined by the Get Supported Logs command (CXL 3.0,
> 8.2.9.5.1). However, the actual size can be smaller and the number of
> valid bytes in the payload output must be determined reading the
> Payload Length field (CXL 3.0, Table 8-36, Note 2).
> 
> Two issues arise: The command can successfully complete with a payload
> length of zero. And, the valid payload length must then also be
> consumed by the caller.
> 
> Change cxl_xfer_log() to pass the number of payload bytes back to the
> caller to determine the number of log entries. Implement the payload
> handling as a special case where mbox_cmd->size_out is consulted when
> cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
> that -EIO is only returned in case of an unexpected output size.
> 
> Logs can be bigger than the maximum payload length and multiple Get
> Log commands can be issued. If the received payload size is smaller
> than the maximum payload size we can assume all valid bytes have been
> fetched. Stop sending further Get Log commands then.
> 
> On that occasion, change debug messages to also report the opcodes of
> supported commands.
> 
> The variable payload commands GET_LSA and SET_LSA are not affected by
> this strict check: SET_LSA cannot be broken because SET_LSA does not
> return an output payload, and GET_LSA never expects short reads.
> 
> Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v3:
>  * Added comment to the WARN_ONCE(). (Jonathan)
>  * Passing a size pointer to report the payload size back. (Jonathan)
>  * Moved logging of supported opcodes out of this patch for a separate
>    change. (Jonathan)

Please ignore that version, I accidentally sent it out untested. Sorry
for that. I will send a v4 instead.

-Robert
