Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF30974FF60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGLGc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGLGcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:32:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0507C268C;
        Tue, 11 Jul 2023 23:31:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtoX9bL3grk4AUnz/dMNRXAkQihxOLK6ktHamwhj5Q/pxbP6ITdxWpVAqXzJEwndUruyyMHM2FZyAh8f2D0a3T5y/NwQD24vmLxPj/iYE+YH7gc+sg1CMHWIRypZxoRUt8C6voHeFzozgpUoz9MMxehJ4HgLoE81+icoa3MhD4iYPqIbKtRafwnocz/auWCUNX+FCINxF9N2+BWlTtD8/gLHKqhnzC6HLfCHF+x1epfheMlwkwQ/T3DDcROsf9i9quCmHN/awhd7PHGMi+TPZn1Pvw9gPKxKDzKY5Ag8SOEtq9AF7+b1cqSjIu0PeQceTkJDoOj0spgARn2IWMMmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKZcowGWkU6nw18hO0sNW75IfqhjK1fOjaTByF99/uo=;
 b=l8onTcwQ8K80bzPAWbWFE4dMnSGA39LCG0NSkwtqcE7gAeBng5boRz9X8aWHSQLK+JvcKf4LQBxW/ypbW4NehahjXTZTG87GI9+lULkCC+kfzZEICMgsJ0+bUbFYxXAbQgiujr1fJAqFmPhL1ZKL/70tHSCBGzXHLO45MNpKmghLZLQ4OXR6vKcDaGqOftBLcFhyEhKje1U6X8P1+i/yhOvUwsJFLq4Meev28fT++7kVqeaj1WzpsNTQxuBHLpKiKQwWXrXN9QVDtwd3VyCaCTTx3UQ+acX7v/ox9FzGZc/30TpktBPY8wX2xh0e5LnxAYA9ok1yBGo5CIZCp9N2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKZcowGWkU6nw18hO0sNW75IfqhjK1fOjaTByF99/uo=;
 b=UUtUHNbRfwlyQVSiOUGN2SCexqv3UczIT5bvmThObFmzjLBB/aENZnKgHtTN+dPOVfcLUVwML8YVO7RkWs9eFkChoiMwxhMvwZ8V3c+QmqW/6JiIU1iUBwBjv7vr2v2A06r1mwCmZNLpcchy49DCtcbeph1H7PAl/B5JsDMl1LDWFvrbR4/RVH6wlJ9PPWv2QHbHtVeNl+9f6rbBwsE9b9ceW+4vBawutvwjWZ8eVCTAQLLoQLvPnxtKdq1c27F7KmfCB9Zhp6WO7E2u5Z9HbjLbO9czeZrMFAwEs1awsmRKBQBDKMeuRqj21v9iqzrkJ9IwExWMYJgz5gkeNIxk2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] serial: st-asc: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:53 +0800
Message-Id: <20230712062853.11007-15-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3b8244-ed3b-4495-8186-08db82a15df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yxGNQcfkzdzh5/RqTOXdkNvSrSDNbxJ6ML3+aJk1CSq8sexB9i3RHQ29iP58vvHRHjFPnf/fxnsyFOOo8qD25vzg2+HS2OjwWOO8vAbWS/LfG+H6x7vvzrNG58zxLBJR7UmVaysJQWqcMAWWtjfE62ch3lw9GLD3UoF+2AXSzt38ekl6Em234ByYLRfbvs3apc7hTn8uV2HL7vbGPLBrfiRNBOCDQ2pzb+H+/45vIQwI40da2IzSkdUOhJDAsZRKGdOMFfH5MY6a9Col6t5WUqa8FmhgA6cGXyYoLmG/ySATIwlsOVkmhtPQTdcoZBOLDkrg0tqV9YPcO0PMwdYKhtW4ck/18VQGYyINfmXK5GMZrK9CyZtJlHcmwRzsiyVRxqtmppoSLaEiryX0BLXTl79nL4SZSvuXrpoqrurGQohu7ehE8MwIMjgP0g35vnIyydktuo7ePuyysqo1NdllOSxCReKPsrnhVHZFCv7GkZw1SxQPSvjHZD6wvzodsqBh0nAaCgB8Hee74Sd9rUy4b3HsU66ybFrUiOgXzdRhsHt/pqOWCQwqFYc1Ct/mWsTP+Ncz8wXPw8ilEQzUAzT/kq2tcd4GgZaYJ70LZKdqUrDvayxWCjD+8nFM0YrCXtYT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5WHCByYiaD0HH/Rmzc631joEWzVtmwuQBFC4Mduz6tFxt6o1a8Kv1aJVZY+?=
 =?us-ascii?Q?5Y5GUDtuT3zw50108pK3JshIvhcNujDbTr1sit0VqYcRBiHr4bMdlbraBKsV?=
 =?us-ascii?Q?+TiAn5dMcPXXCNu+m/tAaGPLgE/wLXqfyfzLwwQm//C7b0bTEo0EJFdHRV6f?=
 =?us-ascii?Q?6O9f2coNG2ZTDPFcqY7LUMEMEn4JC/K7uRvZr5ifJZmR00NBT4+igUatl/JY?=
 =?us-ascii?Q?Cf3KQzhKYrYuXgGyvNVZOBEo1xyMB+RjQfFndU2p4vdxytMFSzwMAMzuHb0g?=
 =?us-ascii?Q?YTn9rC24+cnKLsLwIaPFAszyI7q5ukFOXKQ78+bGMKW7r6IQ58nlGmeHdrSz?=
 =?us-ascii?Q?WQpdG5+Wx50o5a3XVdlj7v4tFqEr/eQkHWEiY8O0Gdxk5nQGj+Zzu3SHATki?=
 =?us-ascii?Q?PVajAMphcxFHXcB/Rvb8WhcN4pEzC4cqFWFdq2x3uVeOGSjmnAIhqwIcnn0s?=
 =?us-ascii?Q?kSRxd29XUNBp8mVSUyW61Wkje4LxSuWbGzcbLwqC3BkbvT7a6Y+6JiuUZUPj?=
 =?us-ascii?Q?YcHPEYs/yBGj9+s2rdobE19fuP9WS8eXPzjWYTB3cj+/THoENmPYC5Zdgjqo?=
 =?us-ascii?Q?jO67GZb1u5kpvZXmpcbsaqDuFWFWv1lDNNeQvlhbc/+eSYMnoxXpa134LVu4?=
 =?us-ascii?Q?DQPzfWWVyDmX5s5mbmsiJIUq6x0td9cIIMLNzjb8pAf8LjVKLAkcfcUeG0ug?=
 =?us-ascii?Q?OxCpaCobO+URkLkEkQZNSe58DKV9bZ2IJl6LKfgL7blxmG/DRHuGpwnD6DuR?=
 =?us-ascii?Q?KmcfA3v+yn+XBk0wdg8uHSPGM/U8tfkU1Qtipqpmw7X0rtddBSLGaxTk+gFk?=
 =?us-ascii?Q?gW1f9WPz6HkpQOc0VbhefyyPMbb2zH5tQAzsAbh4e46ojjq4Un+q7DQawiYW?=
 =?us-ascii?Q?os/An7F4pD2fR/XmAKVUhhpHELEzEUuiBEx8+BBJQtCWV7Np18nH9OAkjBcN?=
 =?us-ascii?Q?csEe6yQkYFzXNxoHidXQxDRZHc3KMN2ThLJyocu4QjngOSJM37To6UrlyGqN?=
 =?us-ascii?Q?RXgSIGx7vtMOvG2cnm0fFqpdxdKpbPAW+j6QCdSD9rakocoTSJeiq8Pf6QB5?=
 =?us-ascii?Q?afk5BU0TuPTikjU7SXcT+VPhGf89hBSyq463ME5SNSG5RSTFch8VeoT4mH5c?=
 =?us-ascii?Q?3RxC6+0PZuE01MFVKLCSw4qGyohTfb3ixSxhjQES+uf8retVkoAIdaVttxrv?=
 =?us-ascii?Q?V3f5duYiG6nHJBaI2A4uL4rQKY+Hv+4DmTY3lLgqMuZ0810fYayrjITBvSI+?=
 =?us-ascii?Q?xOEvNySuvCgQeSD/5431qqzmqW99nDuUxBzCqt98O7Z2k7ii80qewO7TXpaZ?=
 =?us-ascii?Q?/jTp2/ru7RofC0H3U4O3GJKPn8qivjUinyFKj7lt+fbzwmWSSHFr9vhH/Cpr?=
 =?us-ascii?Q?vEBwzyf7ezkoHxqsv06knxDfbbGxS2rQbNBtLb0CZSii4vQkTmELPGrjrwl6?=
 =?us-ascii?Q?7JmLJE+c7uKQl9XutIq77etv2tC2vB0gmVqGYFVtA6ZbmSq/Pz4RU1gFmyRU?=
 =?us-ascii?Q?2kf5xeyGFmZBRWIwNJsC4vFNxvJsH2RzU3ETGYlOBN5c+SDFiNiIrZotl8iv?=
 =?us-ascii?Q?p9q3QOUcarUo7OFldjgmdRlLdYnaYpZ7YUP0VZ7l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3b8244-ed3b-4495-8186-08db82a15df5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:38.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVOvTlKsY532beJT3bhfMXZBIYqA2jWcIdgmYXWGZbH0zMb6FnBZG/7T9xjZQx00lwNCLgeLEQJihDte1QW7YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/tty/serial/st-asc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index aa471c9c24d9..4d3b74e48546 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -691,8 +691,7 @@ static int asc_init_port(struct asc_port *ascport,
 	port->irq	= platform_get_irq(pdev, 0);
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ST_ASC_CONSOLE);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 	port->mapbase = res->start;
-- 
2.39.0

