Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E46074CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJUKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJUKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:15:39 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2078.outbound.protection.outlook.com [40.107.23.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A933A147;
        Fri, 21 Oct 2022 03:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJNd0zKUduqqR0pSo8/CVXOhpkaEXZhE8LafggUSxwB3pHC6S5VNSKAC012A5xG0XFZPmTSEPtRN36+1uWjNwdtpbe18HDWttPXVUR2Q50RsgeGAJD3EIKWv8BZI2FQJQmpphag2hIh3hhlQxaWigg0v2u2HOws6XQ9QCNuISjtmOzrMnjO8IyK8WLOqoFEhDWoHHU1NN7fbzp+dj/iImiz4S9opyx2wNDFT8Jw3jLRv1ChtXtaOOoVtM9GSFgbtkLNJk/5Txv/FTZ8BmyRXESQpfpTKTVWJrjvy7hlbXDHmxztReu9ssi5P/UVA41Iag+rWeOJfRchvp64JeXNgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAAh7r3KepuU3/XDuBww/og4UzR9nXKgQQxySTPmQBM=;
 b=d5VS+/7Y7h+MqC5BckikuggAqgQccbONVZf7A1KfNJOdcpn/pisStluoxQSoPl0guFo30z8wgqV7Jm+5avSlqLhPZ8KYGSxXtCqQ2IuxgWdXWLu5iPgYAY9w4cuP025quaaIk8doMKxyhSuNbziRFlajSZy45T0WC2xfnBDdtODljnoP0hhOwFbWT1c7Jmo/oDNDqIRBMFb027aJvO3+KwqesmqQv24jVD0I5ubo/53OGyJliIXQI9AFk++fBsbrHNdhhk6pds9BJwRZaF8HZWEtcxv//xH2QX+lrWY+NDQkX0kn9huFRUFCtiV1bEQGH5WZMM6FFiFDJ3wJKrMXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAAh7r3KepuU3/XDuBww/og4UzR9nXKgQQxySTPmQBM=;
 b=ZGS+M4ShtZ8mEOeihLrI6ymV0ChJjAIeZOYsIg9iCbIGRXKfq/osjB9QKw3B3rftSacUy2ZVPomiIxwmq+GCBpz+QGT+L2IQ+GCZsBfHp9CoNStnnEyv2CofsXw7R+8ql8BxlwRHmJEgZbZtXBDbqXlSK1xKIrHI7MFFi84EVCc=
Received: from DB6P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::14) by
 GVAP278MB0085.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.36; Fri, 21 Oct 2022 10:15:29 +0000
Received: from DB5EUR02FT038.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::a9) by DB6P195CA0004.outlook.office365.com
 (2603:10a6:4:cb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Fri, 21 Oct 2022 10:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch; pr=C
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 DB5EUR02FT038.mail.protection.outlook.com (10.13.58.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 10:15:28 +0000
Received: from cernfe02.cern.ch (188.184.36.47) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 21 Oct
 2022 12:15:17 +0200
Received: from cs-ccr-fecosdev.cern.ch (128.141.98.33) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 21 Oct
 2022 12:15:15 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RFC: Package Necessary Files To Build out-of-tree modules
Date:   Fri, 21 Oct 2022 12:14:51 +0200
Message-ID: <20221021101452.1367745-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.141.98.33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT038:EE_|GVAP278MB0085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4929e2-94a6-4c9c-222e-08dab34d2dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OC0ovxNCOHu2JK17YsLIu1vk5d39C40KtYb9pOt6EDvl6u8GnRdw+1Y4SEcixTBLuPDvTdDThKfyfJQ+SjwYIy+jcQcqEntTBzFOmXbbFG2QZBb3KvIjzAoUQed8jXJaislZlv4mpi4zX2E9Ra/ZHsLt8diouDKG6jrbt6HwqM4oeFchSDYWTze0szIA34iCRxQtV/DBXZITn5xf4ex3eYEzDcMB3riiKbJ4u/7UbIIrvRuLepBTjX4ninFXjQiNNl1pv7xEjQ5fchBJ1ja3RMuB+Ojq4dqGP5q+V+VFILtyzZGBhwNp7jZU4ifGAMsk+Uh3BML06ZhM6mZlY2bSeB3dRcS0SWx9twllFT2e9lp6qd/8FPbV71Pk/Yjh1INnNloCKDHnKXyaTbV+Dg9izCOA0iz2EVywzWl+e4NYClEz6/X9yqVm1674uFTjBLfY73qy8sqyIUWyp9sn0RgoH4L4bLk63z+HF5xSVxIhkOPa1GwVbj/uWRHG7KJPXi2lG7CR8dsuyZ7g/utB3Qn7RkylZb3dKn2mo9GT6UHxlB5oQy2nrsbBQu71ZXFDjTbSENdyLrT9qpxQNR/sItjpCSZmQmUiuL5UyON3fLUQayjlXqwPmyr+A96Ehi1I2V3CuVRka5hXUs1zS2L80o3BwNGjdPmOoMyNo3F+18QMwocKMh7omFS3mPMC/a/K5FLnuoKD+612bHvi/YYeTlJNOK429AaFRpf1oknuiLDyAwXmo92x+6NOFHNL+e6hUbUD9NlktshzEN2PMllaSuMqwg==
X-Forefront-Antispam-Report: CIP:188.184.36.50;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx11.cern.ch;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(186003)(1076003)(41300700001)(41320700001)(8936002)(26005)(5660300002)(40480700001)(40460700003)(7696005)(82310400005)(36756003)(47076005)(426003)(82740400003)(7636003)(356005)(956004)(4744005)(44832011)(336012)(2906002)(36860700001)(2616005)(16526019)(4326008)(786003)(478600001)(86362001)(54906003)(110136005)(316002)(6666004)(70586007)(70206006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 10:15:28.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4929e2-94a6-4c9c-222e-08dab34d2dd8
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT038.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did this little patch to do some experiments around the idea of having the
kernel building system being able to produce a tarball containing all the
required files for building out-of-tree modules. The direct advantage would be
mainly for distributions' packagers who do not need anymore to specify the list
of required files - for all distributions.

This is just a draft, to see if the idea has some value for the community. For
sure the list of files is incomplete, and in other cases it adds more than
necessary. I see `rsync` is already in use in other files, so I'm not
introducing a new dependency, but of course it can be easily replaced with
something else. I copied from `scripts/package/buildtar` the parts about
creating the tarball.

so, ready for comments :)


