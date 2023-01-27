Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8A67F004
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjA0U7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjA0U7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:59:15 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524F7B422;
        Fri, 27 Jan 2023 12:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMjYr/R3pATGWWTljO+Y3OJlJPOzo7bOP/ysppgNxZduvzFMv6MD2Jf1eNfnsmARKHrAR9hXNCOnHR/8D0bk6A9wFyzH4QYsGz4Q0KUw6BRAFfInW7piDa5qPLWDK6V5yOw6ixJ+qVO3At7skylGw2fUHymQ8O/lAAlXTfy1pKxHn1LuopX73SlY3Igr8aQa5mCWTdArbDPrgfRhjvIvwwRtiTJd22Xpu04szmMRi0Bk3+eCsNxLTxlLhl4QEyKI574KbmjZXNNhNpL1JJZLsx7XoFvH+ohkgIVlA+/aZ0HFJZIEQ6RVj4R8F19Xleb1B2u9x40u3XwoULRS8sH/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2/L5SA7pbHH1eJAZORlTGunDK/ti3B9MraHx7pWfaQ=;
 b=OqX+OXbZeXA0bA5OByGN9kmh7x65xU8IqbkalN3MfnGC6LDZ86MSsgxit9kEGLUxUATUy9YW/mEj8zX59TVNXfUoy5m9J/rbwJoVlUv3U+JCPhWQNzxGQIdEb8vCt6v17uufbjCGtbn8Zws5HS9TzibgxUu7te6bwBzABqF9lSFrkEb4bG9vIs4ZdGuOfu5FcKT9csn45TznEMPWUCv6OZlPHiHu3eQZ5glk5jMfCI5eGi7m4Tyj4K29Zqy2JZmgCh4S1SFVYiCDm6PDkUpYYuZP+3FZpKITOELT6uW4+lU/PVpUrNKSoFECEZwIRcvcfLvGZHxiCtNCEoy/FY8ZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2/L5SA7pbHH1eJAZORlTGunDK/ti3B9MraHx7pWfaQ=;
 b=XnqBtmmhG/4NYeOOwULmDPF+YPFqDt2ueewn5mqvO1PhCtanHefS1d12mIUlnkGeBpEqkpwoKXA9YVFLJOsdrPyd2qaf9Ks8MOhPHly+cOhkivRQSm/y+12Llxc31xAg8ZgiPOzgHHkZITYyEioECdY4Dd3PRHRIft9GAaVeP50=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Fri, 27 Jan
 2023 20:59:08 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f5) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 20:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Fri, 27 Jan 2023 20:59:08 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 14:59:05 -0600
Date:   Fri, 27 Jan 2023 21:59:02 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <Y9Q66azCa9wRuH7h@rric.localdomain>
References: <20230119094934.86067-1-rrichter@amd.com>
 <63d42aaaef012_3a36e52942f@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d42aaaef012_3a36e52942f@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbccaed-a31a-4a11-70e4-08db00a95550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vW1qVOS7+JY7D7FyRqyzkdQd6j/j9y0NIA/e/qF5ybQ20zk5+YSugbVYtZBc8lrGijrWxMeCKdk8YtoKIQsnC2q5XKX9DxI5Qz1l+X9DR/CIs64Rk8ju8V1RdXlO0IFKka+YVJ+lQCYqVgNyZ6/Of1qxmzXI3VPZA+/qwdziSR2Z42VIjOvtadrrGFA5CY1trTzAoCRVoaZZsFhBoiGmNcsa+Y1xSBQNj3N36hlJ+LgjtfAl/9xjSiGOt7CQXpvF6ZV4iOKSQoay6aqCUYrx4PADQRg8ZMOA7ysDe3+Ie+8cA8xuKMYRfk0utJFB0veBwyzhTWIXFWGUAL/hpUG6NKdgRpQ6u8dEugW97M4YlavQE0c7YIHIIfyTpF48Ct4wi7Z20vbUd+Ol6HaXZ09MZAtb/gNA3a14/wvnxyfytU8TtY5ILZa0QZIqY5qCnYarXcX4DvA5NAUb1zZWIvw/XrXQ5EH7BpcDachNBHJOe9//PPqpRLnOWW/Km157v9Cp9SKBLae0P3NuzOZXXyq/+sjtRrko8i6J8/QzG6oUPhaUYuMSbWU1qBCHA1MRtD6DUZCK4Erlxb/wmgVAzNiOqcInuJiCDOcbzLfcS2kKuzbwG39FPHMVWZrGWwXymwq/hfRFml89yvFlb2JVYlCMmE6W7XPX4WyVDJzAK67I7G5z5cxePi+vZ068IsM1pk+iVsxLt3Yw+S4BS8Af/nhgiKynkkSCA8rs1jhxRYfuoQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(34036004)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(336012)(426003)(8936002)(47076005)(356005)(83380400001)(2906002)(810100004)(5660300002)(53546011)(186003)(82310400005)(26005)(6666004)(9686003)(7696005)(41320700001)(508600001)(70586007)(55016003)(4326008)(70206006)(8676002)(81166007)(6916009)(16526019)(316002)(36860700001)(40460700003)(54906003)(40480700001)(36900700001);DIR:OUT;SFP:1501;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 20:59:08.2146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbccaed-a31a-4a11-70e4-08db00a95550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.23 11:48:59, Dan Williams wrote:
> Robert Richter wrote:
> > Commit 2aeaf663b85e introduced strict checking for variable length
> > payload size validation. The payload length of received data must
> > match the size of the requested data by the caller except for the case
> > where the min_out value is set.
> > 
> > The Get Log command does not have a header with a length field set.
> > The Log size is determined by the Get Supported Logs command (CXL 3.0,
> > 8.2.9.5.1). However, the actual size can be smaller and the number of
> > valid bytes in the payload output must be determined reading the
> > Payload Length field (CXL 3.0, Table 8-36, Note 2).
> > 
> > Two issues arise: The command can successfully complete with a payload
> > length of zero. And, the valid payload length must then also be
> > consumed by the caller.
> > 
> > Change cxl_xfer_log() to pass the number of payload bytes back to the
> > caller to determine the number of log entries. Implement the payload
> > handling as a special case where mbox_cmd->size_out is consulted when
> > cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
> > that -EIO is only returned in case of an unexpected output size.
> > 
> > Logs can be bigger than the maximum payload length and multiple Get
> > Log commands can be issued. If the received payload size is smaller
> > than the maximum payload size we can assume all valid bytes have been
> > fetched. Stop sending further Get Log commands then.
> > 
> > On that occasion, change debug messages to also report the opcodes of
> > supported commands.
> > 
> > The variable payload commands GET_LSA and SET_LSA are not affected by
> > this strict check: SET_LSA cannot be broken because SET_LSA does not
> > return an output payload, and GET_LSA never expects short reads.
> > 
> > Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> > v4:
> >  * Fixed a build issue.
> > v3:
> >  * Added comment to the WARN_ONCE(). (Jonathan)
> >  * Passing a size pointer to report the payload size back. (Jonathan)
> >  * Moved logging of supported opcodes out of this patch for a separate
> >    change. (Jonathan)
> > 
> >  drivers/cxl/core/mbox.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> Looks good Robert. Do you think this is v6.2-rc material or can it wait
> for v6.3? It sounds like you have a real device that needs, so I am
> inclined to add it to cxl/fixes for this cycle.

6.3 is ok to me.

Thanks,

-Robert
