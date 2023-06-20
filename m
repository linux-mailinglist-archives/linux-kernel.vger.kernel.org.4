Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947E737101
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjFTPzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjFTPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:54:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F0183;
        Tue, 20 Jun 2023 08:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfxJzh3ko5R275fUhH4jBzxLVQ37ZWz9Poyi3XIbtZKMWPRx8l+K8nz2PE3ODosb0sLWrviTTO0WoTGtFeTRqo9rOWVCuKQe6LpkfwWcFp6duPz8UJbzRDFKfz5P+sebY7aqpeDzkAqOdu24/0V++54iUHC8iuINdyfjffy1BxajQmvR34I3gIXc3BsckhdFje4bPG+XqjDZjdDuBFKk4sk/gUzsmaAd6aASmg8jCykwhE4no9yfCYrPLVQb7FqI59GyI2bpKt8hrDv/H2/KZktMyO9P+BWzuN9/8/LrMwEjvnyFNmXc2RqwlURCwyts3sA1yi78CmyDH85gQhdpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OqOjIAIMy8h1nI4zqfu5B1pQS+4YHegKRPgLTRd7HA=;
 b=Irirn8a57TJNFiKOUMjm95F7DFpb/Q/Sso6G+0GzWdWzAO7mE26+a9rBgrD5SMHyiCVlwD2Z1lYry1Rx+egZSoSVPJI3+yuxbnMQWwGuNA1IcSyU0/c1IFaq2AMp9vvwZ5G2eqK3shvc8Dnf1c9go9ysNtz7C8mG57qMAbaB9NRDUMozl9ydVw7X8RIDy4Zm4EXWOgrKGb7JRyTeyuCyFCoK5RHGYx/Wu9eJNbqWdTEdAGqEGZBp/0iPemURE7Bsb8cE6AVSDjqrnWBFgyK0h5sXmMKibn/yDDRgg7H3gDEfJL20LeE9hbU3hKinnkcSXfzbIeoDbnxmpOrvwr4SKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OqOjIAIMy8h1nI4zqfu5B1pQS+4YHegKRPgLTRd7HA=;
 b=JYGufSkUlLi/YTRmlchrHqfDnHktn5KI9o7vk35ORomv5E95zXEGOuGYssT3U1Z27D5A/cuV6mziJ53N4U1+Oaiytv5oB7tIdDKDcO0KileVYEVTNmWwFraMsyOt2OoaeW4a6c33xXW2pCg9Akwj4WQsFn5O3rg7luieYTqoUYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3866.namprd13.prod.outlook.com (2603:10b6:5:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:54:52 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 15:54:52 +0000
Date:   Tue, 20 Jun 2023 17:54:44 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
Message-ID: <ZJHLxK04YDA2lAxi@corigine.com>
References: <20230620144855.288443-1-ivecera@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620144855.288443-1-ivecera@redhat.com>
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3866:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e96622-0856-4f03-bfe9-08db71a6af15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcpXH0n93ieuwDJdAf++WHlp51WXeZe7jcWMe/tQizJSkrtmQCWwNZcjftIFiOvdrqfpLKQJRjGroClle1MzZ66K7cC3BV75ON+YoCn7M1VAgasV+eGo4CJVfBuWnlwHBiiIvTO5Bn2wnWW1howw6h/M33MyIZLqIv8VCDdYVxUQEGuxTkL1AyFJxrDPPipKTdjhX3SoHk4KiUulOPZcXdthMDI8x/HOJyasTBqwM61KBxUWTOMJLA3O3tQfLduHJuXmaUEVmtr76rt0dACREAiZ683M3bx301545MSgfeWO1wbGP/bIiNrYSYGJ8aaSBuifKVdE/YreevY+/DZ6yrX1yJ6At0e3mdOz/p8nUczOu195c8gIOhBrmgNjeIP5ZvnQhS47zNJuBhs7c6Gs0W3XAWasmoOZWG/DlN9NqHUE1SMP0j6fQH/VRo+TH8cggsvSYcT+4iDiwjPV1ZdP625pyp5yXwFmNXYBlWCG9PostH1mf2szfHjpbacrVEvv5NLnamlYBKQonE3I+GmWZ0Q420JQZr+H6p4eTLYDIaieuvPQz5qfTdAjYtggg4ahGlKFOFCamx1CWCbD0vbwGdeRX656V0GvS1DN7ukiwu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(451199021)(8936002)(41300700001)(8676002)(478600001)(38100700002)(6506007)(2616005)(6666004)(6512007)(186003)(6486002)(54906003)(86362001)(36756003)(316002)(6916009)(4326008)(66556008)(66946007)(66476007)(4744005)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELURExT8/oKxbOMfxaXfd3z4gzd10/Md5c0koDYwGQ0cjdThCF2YFusJi9Ok?=
 =?us-ascii?Q?4/B4pQZsPTzOhOjWxRze0bgkJVP83GM9BBAECHEjuRt3RGXepFxeFWLpE8Ad?=
 =?us-ascii?Q?YzB3HYkFjvVfGDFasUAl5zoXKYFv+Hka3EC0Z3NNnyMf7m4WAamFofZ3zfqx?=
 =?us-ascii?Q?f7+cvRGBck9yivGtvFis3h150d9VzYhQHDSON4x+udy49mGff+yH2qJnfs0V?=
 =?us-ascii?Q?YgIs3neWwZ63anuMZIOsW9j9Iz8YJjcMSyAeYa4+blUGtZy2qgyau3295W9q?=
 =?us-ascii?Q?p7NO2DuZg12XGBn/5ipEkphbsnm6RUFe28Nn9CPlRn4hWNxwCSFXtGu4Jw3E?=
 =?us-ascii?Q?nTyuOCgzIs8pKuOa4Tk6W4h5w7dXSh+6GF3mq1FdPnAFoCj4eVpoy4G9o2oH?=
 =?us-ascii?Q?5avIdmTa66IUNbhPRun2CXQokZ+K/1MBP9+HAZctF247Drct+wYXB19zCabV?=
 =?us-ascii?Q?STql8mfcKpiT6s59x4A52T3dyolkk3qwAfn+pdUdcmMd72ln1S23i+9lle9+?=
 =?us-ascii?Q?mQ3FIkFHEXsXHQ9jdpZZwy21pRROtpaowZ7MYCNO4WOOhuGFOvjrRFacvpnC?=
 =?us-ascii?Q?PDw6xUh9RmAdRGnDckqRUJR6jVC14qrORxo/jGYqbwuKSzvHynBaRXML59m8?=
 =?us-ascii?Q?QPe2b1dLJhn45US4vSk/qeKH8X8woWKA6qB/xXJ99UZeCw6Ajy6w4gId1VSX?=
 =?us-ascii?Q?nepWoILQvNdwH25oRByYyFwRHqMLTcUIPowlHMyUenjrNUSqEQHxFASw54zs?=
 =?us-ascii?Q?6bB7QeYaLwyXqTpkBKImb13mNApDTZEsqfXLsodJVF1bhkFl+vdw80utVDQq?=
 =?us-ascii?Q?0Wvprw4hmTeYoMayq/PdY4spF9CN6dO/RyE3s7f4qUfs8ePZo6BIb8h2BuGa?=
 =?us-ascii?Q?7gfer3smm+ieHKNQEyg1m6emEMc2f8tZ3oRyojmHmt9kM/2AOTyzHRAobfnH?=
 =?us-ascii?Q?ushYXHeGHcpEjKQmkfE0AlsCv7fcy90N1fr6jQt1oDcgbm5up4GCMICOqOIg?=
 =?us-ascii?Q?FBvZuTgUz/hu9zhgfWRY6YAup3qDsSkTAHcUKkWkoymHNAVmLnkkPJGqQJ5l?=
 =?us-ascii?Q?Wj3nAYQ+PcfWVpKTgWiRtTeeYn3V+I1+m7agZ7Qx9rAkltjtFREvijczkvxT?=
 =?us-ascii?Q?BIP+op183v4m6WvlVaKMyD9JhJimXD0Dg5iv3Wskf/ysXbuS6dVW9LY6rdYn?=
 =?us-ascii?Q?x8P0NlMKe5hniM0St4DIgAXOaAuZQm8JzOwt9UBssHZeBrYI3UnmEYgPpsDV?=
 =?us-ascii?Q?pTWD8ndHOSHl1/xTonMYpuXGOu44ATtDwEQo/+hajy+/pWM4caVUSoUvWsjN?=
 =?us-ascii?Q?tFDMx+PoNEPYqfa6UyC11j0B/SwHrKD8/mx4558wSKVTNQI33qQfFifwgGkl?=
 =?us-ascii?Q?QVZgvrOGnuON1Bex0on4b65hCQDjbJN5XiAvc2pXbvS5UhqFLa0Ud2mPdjfg?=
 =?us-ascii?Q?blc1jZVGplSmkA6EAPJcLMnm7G2nm5Tg8pC1ofaxv+nEX+la6u4sOMbigAJF?=
 =?us-ascii?Q?tb/Mf/9kX6L5XO+uuI9/OD9n79WK6p+pnbpwXEJche6mWpfTeYfCND29LUVo?=
 =?us-ascii?Q?Q3Slifp/34DoyB2ESVddtIc0EA6phdPNb4k7waLKOLEk2HkofyTY7ebtPIZd?=
 =?us-ascii?Q?i/+jecBnisg/Zfeg8mshc/Y/oBIk1NPszS8bJpoMPyXvkDf9g4ygguoNM/WK?=
 =?us-ascii?Q?7ecN5Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e96622-0856-4f03-bfe9-08db71a6af15
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:54:52.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7zyDBfi6kWBYDk4a7CtXZuUffl9EGD44MoI6L56ehy5srXW9nwh0EY+Rt5nOCtuaFsrlMrB3ZTaCNfh3a0POpz5xaikOj2N/2yvNax6bP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:48:55PM +0200, Ivan Vecera wrote:
> Link VF representors to parent PCI device to benefit from
> systemd defined naming scheme.
> 
> Without this change the representor is visible as ethN.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
