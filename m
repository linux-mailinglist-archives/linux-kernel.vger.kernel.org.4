Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E983679834
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjAXMke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjAXMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:40:32 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39F2BEF8;
        Tue, 24 Jan 2023 04:40:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jC04i1Zu9XaZ6W7JdBwiM9voUwwR4W04Ge/TEM9K7GlkllAf/CKPhfw1nmvtNskbXLIsHHmmcr2R4RFVXRIM8htntNjuYxc4fosAI+l4yVjdSvEgttTpnSZqR5iB76EtOdNXnfyRhbn1F04KBe0HUSoUXLlTgH8O0UCmeH1zDR9MRyHl4yRnOBZ02OWnNPc/AE3N9GY6S+Xpxu6i+oRgHJAPYFWIOeGpWVgEjhT9boxK6Err0OqnM4HBhG17JF52iREEUpWqIdFH/SNn6i05rgYCUCRMJJMtRLqn6ZHqbqjcTP2WIdTnLAH8EiWpEp7xymV/XZ1Y3Ss+tpHOexxPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3sDErdvY8VCPFQi6UyZRjZqrr3bln57UNwSa9gkqfo=;
 b=TcwsY6UWNxX4p+ty9n+n1xbqVJZ8Q9gKpCka34JUoBYIK8T0rhy1tdDZ3bc8F1qgz1cevJ2K0w38nmfFvnub+5PEM3qau/LUH4UBQlS/tlJo7AB/0Kv6ePNKfJHROuR6bR8m1lF41YHAbHvg9NZnZ2r/1qfrMxe9RVxKkP9swvLQdYsqDpR+fsZeaV7xZsVBzvzKomGgxcnTv5l8YYdDtJKPRaemFa0+m4P557iSxVhn0vbYQg4seSj2XAeS3JbluCM0yycw3Re7rAk5f8bF5WNEf4IqSRcibjjzXaJMryAN5ZPl7n/thO2Jz1PbG7bbVDfLbJj2rMy6az4J/MbmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3sDErdvY8VCPFQi6UyZRjZqrr3bln57UNwSa9gkqfo=;
 b=s0U7wSVLWSZrntzWy7ZVfdUNmwoKb96hSOwNp8TpZ2STFKkN5hGWvgBP4ovxMJcUEL64UkEuluU2xvoBHm6BF9DGk1wYhea3bUovJSxbGdByW6q/xYeSGGodZzUACd6tIKsJ9JsdIrnbyKT1jgbhQArOCjLdOUm4mYMHUYCpcLE=
Received: from BN9PR03CA0701.namprd03.prod.outlook.com (2603:10b6:408:ef::16)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 12:40:29 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::a9) by BN9PR03CA0701.outlook.office365.com
 (2603:10b6:408:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 12:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 12:40:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 06:40:26 -0600
Date:   Tue, 24 Jan 2023 13:40:24 +0100
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
Message-ID: <Y8/RuADVoRiC4d0+@rric.localdomain>
References: <20230119130450.107519-1-rrichter@amd.com>
 <Y84dleBbsQhE0Dic@aschofie-mobl2>
 <Y85+dwjO9JjtFtGa@rric.localdomain>
 <Y87ff+zqVKf4oOJ/@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y87ff+zqVKf4oOJ/@aschofie-mobl2>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 03eabfea-8190-48b5-1eb2-08dafe082cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucPEGXVsJi+L44uyOEILrSZsxMSH0Y9inla8OC3+6XJ8GyqgW9ZsJ6FwP1ymRG763lrzvG8f1xAdySLtU0G3b50HX7LE0iKayDrEMr9KqShmrdbP9hiNDDPgcv6M1OhHaB/B3ZDS9dUaRHbiPhBI7KVkSpPFYJpCuTsJC6juGheBzfpUanndCuKcaO7TelicGWjUooXaYw0xX1Ym2xAMRTekyIcO75ptbjyJ1Ns1jMZEQFqKV9jSJgeRbdFa+5TrsRQMVPSM7/mAvW2+8hIq6fnC5d2YzQZ7OEpAfgH0hpF2zK6jlE5x79hxZnRIwawZOJl0lDTnAoRbzI8RWrcE0e6cK64xtjfkROXSBHG65YdIyXFv7QasH2NS4tu1PBpIlsJ8vDwaGInw82srb2eDR9lblNWCadE2mfhS6aNnFZ3wzKMMtohQGsAuepgFHtJbavmECy+gQd+6jZa60ILcPh/cG+u6Xs4Tw4StNZjg17QtH1P/g0PqKYMoyt0MLfCR3r/mymkGRUm02se6dCnebFdFp/1kkUVqpNrziANVX/JfNCuUdyhthrid0YWDr3mcuxllAFw99YRHN+Y64p0oBFwtw8N0xz+4JHNYtpYlJ+osz9E9wsJC6T6NhQnfNLfkmlCuLadjEIWQ3ZvX9SwxtrCPs1ZxJpuFDFBo8PYF4Vsj2cRLEAAeNnwoa6qbcVdx1plMzYRQQ/qxH2tHorWUHqLaBM0Kp09VaR3YgpFJXHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(70206006)(426003)(47076005)(4326008)(6916009)(40460700003)(8676002)(316002)(336012)(54906003)(82740400003)(36860700001)(82310400005)(8936002)(40480700001)(83380400001)(55016003)(41300700001)(2906002)(81166007)(15650500001)(5660300002)(478600001)(186003)(26005)(356005)(16526019)(9686003)(53546011)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 12:40:28.9859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eabfea-8190-48b5-1eb2-08dafe082cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.23 11:26:55, Alison Schofield wrote:
> On Mon, Jan 23, 2023 at 01:32:55PM +0100, Robert Richter wrote:
> > Hi Alison,
> > 
> > On 22.01.23 21:39:33, Alison Schofield wrote:
> > > On Thu, Jan 19, 2023 at 02:04:50PM +0100, Robert Richter wrote:
> > > > Only unsupported mailbox commands are reported in debug messages. A
> > > > list of supported commands is useful too. Change debug messages to
> > > > also report the opcodes of supported commands.
> > > 
> > > Hi Robert,
> > > I wonder if you can get this info another way. When I try this 
> > > loading cxl_test today, I get 99 new messages. Is this going to
> > > create too much noise with debug kernels?
> > 
> > There are 26 commands supported by the driver, so I assume there are
> > at least 4 cards in your system? To me the number of messages looks ok
> > for a debug kernel. And, most kernels have dyndbg enabled allowing to
> > enable only messages of interest? Esp. if card initialization fails
> > there is no way to get this information from userland. The list of
> > unsupported commands is of less use than the one for supported. That
> > is the intention for the change.
> 
> cxl_walk_cel() job is to create the enabled_cmds list for the device.
> How about we use that language in the message, like:
> 
> 		set_bit(cmd->info.id, cxlds->enabled_cmds);
> -               dev_dbg(cxlds->dev, "Opcode 0x%04x supported by driver\n", opcode);
> +               dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
> 
> Because when we say, "Opcode 0x%04x supported by driver\n", that comes
> with the assumption that the device supported it too. By saying
> 'enabled', it's clear device and driver are aligned.

Yes, that message is more meaningful.

Thanks,

-Robert
