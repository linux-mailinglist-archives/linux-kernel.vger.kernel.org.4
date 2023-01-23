Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05051677B02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjAWMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjAWMdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:33:17 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0D23862;
        Mon, 23 Jan 2023 04:33:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDPR7SaXqoPJTJ7djLFFIBGVFpjmJZis1d8Z9m+hC62lw/wnDeKVh4pSJoCHkz0TZA2RRTGwj5IrhskdV/AnuVgrKxZuEIraB3/L2bIXIsy+qKZRH/wjCfvqmy6RDmE9nSL3XHPObNv+Vlt6a50Wl5jYCNSjnOWh2REDFnBcTDXnaiLCuVN6KJlaotHbKlIQ3DsTso5BVCEkbK4PwFzJ1f+yMItqjmzt9AMUydwBbIRbOxuUrBHrE0xM86EgivBQugi2mBKWOx7kH1kA8WVn1FlXwtGEeMYilp/iGnogIVAznwT1/jhTqeJGJNTZL5ER2Od8caiqWQ2xbgFBjEuQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kBoiJ1SbNe3SAQS85fwtU30WQOEsBMz3I5JZWyfjYA=;
 b=CK1TFXABOBpZyPYVj38I5tlTWZtJJpeLDaqzZW7yvL0Ezvj2puNiDh6PRTbI2ZwN5THXIs/BntCvG+LvpKyqr4EFO/K3lxI2ptCFt37Z8odJt2XIvHeZjkRQtAg9nd9fKx/Qw26Rg3rN6q6v+mdA/JSeZXY2XDqLINyV133y5GrctMBOj0cF/a6l1KRGZG+0x+GuLy8EwXDitOsGpa+rAUiEdTvNb5QEa6Eryb3NnOG8SOcmvSUo5AL/04Y4I4l9wUOiXnWaFTgxmErsa59bGN+BW4nbxiLbn/jJr+/Ev9qj1tKp6QbaXKnSOJlqT151D0tvXS7AIQ2CAM2vY/OQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kBoiJ1SbNe3SAQS85fwtU30WQOEsBMz3I5JZWyfjYA=;
 b=Jf9oBbwLrzDQ3VURstxrzxWMyaGncsg45ksVs2Pgbo/lbJm/4x5Vpf8KmOcypYnnJLBaVM0HuLMr25cwP9gGAd1DsPnszC7eCvsDfVHqtNp+QTCtbXHteEmZAqVvRfg7cIE0S/gkfI72tZXUpe4nyTHRc63rEYHY51CSAKyyJU4=
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 12:33:01 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::86) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Mon, 23 Jan 2023 12:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Mon, 23 Jan 2023 12:33:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 06:32:58 -0600
Date:   Mon, 23 Jan 2023 13:32:55 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Add debug messages for supported mailbox
 commands
Message-ID: <Y85+dwjO9JjtFtGa@rric.localdomain>
References: <20230119130450.107519-1-rrichter@amd.com>
 <Y84dleBbsQhE0Dic@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y84dleBbsQhE0Dic@aschofie-mobl2>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 210aa652-839e-4901-8666-08dafd3df733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5XBKZ9GiRBSiy2KxEdFLjasZQahaPUwEn1UvF6l7LVWb6bjbPOyeUHrfT/xu96ZvICLyZxt0kOXbEVlgH6vXdPEcquE0BOygvutvsXf9C+9/x4tEBLeeJdFGgrD3BPObOWFida/LblllSgdwq50nUd421es2BHtBtnVUwJJBhvED4Z8UJosVwgtDt49sUksF2+J52d/kOhb/qDSFJFrba5y0m3yx4NCQo7H/T3Xt9If6LzdQGQDKgertXhU7CQKcKJcXEfwALfMz0eL5Js8m/Fzd9ehHoY+TKWeOnfEOVpfxj22chAd+wI0UCkrDsPkVh0yyY8lBHfBRM9+KCgIhPuCT2qxsZnipwD++7lqHEwNCXila9SEkOhD0XxlNv7j2X3niKNUk59DJqx6Xtxep4M94iLvsRZEaANMVqGTyDRA9bJkChceQXFgEAQta2y1GrPCqraS7u+rRgo7asBzijBS4ISMbVuA7kuLPhF/l0WlBVdfBNz9MUsH4unYhXy9o6coIDDXFq6e+o69HlTwUDOSUc2EXDu04ei7l1neL99QBxR+BWNFjT35xY4aCTsa7zU8KnpommCLxBVX6rH0beRVuYMl20awSVBdWapkDY6x96lN6mWVK93LUjS+50Mf0Uh0jS2W3mJHzFWK31ComyE8hHP8py8WDYpNobYQHOQxfA8QQhK6uum5Filr5IjfucD3pqUqpg3nd63cdDKr2u/cZcKdrrWoly+9/dAH+ne2JmQLRSicHXM/EtkXYoUhmOhubWclhwB2gy87ICC9+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(336012)(2906002)(82740400003)(426003)(41300700001)(82310400005)(15650500001)(5660300002)(4744005)(40460700003)(8936002)(47076005)(4326008)(316002)(70206006)(54906003)(26005)(55016003)(16526019)(9686003)(186003)(8676002)(6916009)(36860700001)(70586007)(7696005)(356005)(478600001)(83380400001)(40480700001)(6666004)(53546011)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 12:33:00.8059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210aa652-839e-4901-8666-08dafd3df733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alison,

On 22.01.23 21:39:33, Alison Schofield wrote:
> On Thu, Jan 19, 2023 at 02:04:50PM +0100, Robert Richter wrote:
> > Only unsupported mailbox commands are reported in debug messages. A
> > list of supported commands is useful too. Change debug messages to
> > also report the opcodes of supported commands.
> 
> Hi Robert,
> I wonder if you can get this info another way. When I try this 
> loading cxl_test today, I get 99 new messages. Is this going to
> create too much noise with debug kernels?

There are 26 commands supported by the driver, so I assume there are
at least 4 cards in your system? To me the number of messages looks ok
for a debug kernel. And, most kernels have dyndbg enabled allowing to
enable only messages of interest? Esp. if card initialization fails
there is no way to get this information from userland. The list of
unsupported commands is of less use than the one for supported. That
is the intention for the change.

Thanks,

-Robert
