Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A55B65F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIMDD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIMDDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:03:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67D248EA;
        Mon, 12 Sep 2022 20:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyJspoEHsHZk6s20M50KraYH+ccz/EHbxlwBSVDYDKik1nrfccwem5sbbxFDIgz/f45AzMEDaoP1/VO7XwRiFHcA45qo7/qRPuzMHEPbmW9XoN3U2n8Qk4jB84+1WW3OuNYsGmZpXcKXymbNkKbc+HEquKrs1rTuXZZ0ijmsTM4jFiSQwuudvWc2EjDl6j8yNH9IoVHVSTT+YjL2j1FNcFKDn054wmYxHFwPocKXtIn9Yf2FOMUn5udnPahujCNUiZ1n0/aYPj7HyGq8hIrXBT2dw80rq9SwdXVTQJiMxBdazzqqJb1JoSFfsV17tMZSHa/xHo+NyPujL98BV4zdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebdlyleyJgotq5NJQy2OXhGo0ikY0bGXofePyA3p2ZQ=;
 b=DBa94iYnEC0MKEh4Edo02P52aourw5nmiufpU7znCyMSjggs0sxBwDzov4ZvoAB36Iug9ZXMViGcHMhjQkUyWdwBZ+7gqL8AH3w1grvQfBB5R7O3WN5+mpiaFGPjCxQqvrdVdV2D5ZVtUfeKFfbmvUzhJxlj+KjZAby5Qt8qyrQi6rXaaVvxZ5YG/1Ld6Lax3oZ/UdWNArQi130N5UiYaNYdHJjV8ayWUcGSzrwwxqhBES+uqGuhUclFQToEC0sLuXmjsh835vuSfPq0rdILCXWdQnJNcpW9lMUS88PHPBrqxcR0w6PyioiWj1rc6gOUjwsEZ7oNIS3vqlLvQ8el5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebdlyleyJgotq5NJQy2OXhGo0ikY0bGXofePyA3p2ZQ=;
 b=YdpYAdYB5aCC3BTxFA3jSZ7TXWTqJjtHbM6sOgQtUrEack9KfYIFq05XidnYCzAOlMnfAZlIZtZPP4u/hRolHDFR2OvJfQdCXt4/aPRwok89SLznR8YOLbNkxq+bvXb3rmORHTJlsiUGM7wCgbrBWA5s5e4hb8ntspzIx4u0QFSveNzJnBm6aLYDZu6BUeglmjrUV607lK3xUA4lJbP1VhKtT7yT9KVkaO4sGz/yw214pWTNL9PmdfXfAASyQf8YK/eHb5q5cFLswbA3EX3dyfH495cfcjE8I+HdW0oDT10tJKo9fEa9atsNIp5CfYYLcnHBQDYU4P5jVZRiRm8qag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by PUZPR06MB5819.apcprd06.prod.outlook.com (2603:1096:301:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 03:03:19 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::f9ad:4efb:64f6:856b%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 03:03:18 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] misc: microchip: pci1xxxx: Remove duplicate include
Date:   Mon, 12 Sep 2022 20:02:57 -0700
Message-Id: <20220913030257.22352-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4173:EE_|PUZPR06MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 732c0612-e79f-4123-6ad8-08da9534828c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilYqRNYPegl+7nsamtGrdIU4MhDu/hbCogW42XkmQjp08LfLXKt+wnlvDXxNOYUm8m45TK5urpDuvHR3iYOdKVKdsYbhlXdcpA5ObYn/wI46l1AqmfY60k37b+tde9PWboyEHWIYbv7On1uiWjbP/flid1Y1mW+93EQRfoiqjOBm1i6Ne8QsURfEZAd0/RUk6SaZHdq6R4vz3H44GYgd2FfQWWakKGo26X2EWVYeE4OY6BNDohdYr2egoMQaaCR4MYWP386hafYGY0s5Wse1EqMIxS9hE2xOGiHlWgWe2O4jb7nvLqjhJM04793Jgwfsn7dxU+1iXhxcRcYM01scwysPuFk3MX1V284thO84S/s7qMgrXpSjBThtr27mn8BVAq/1EBQBl/OfpQ+MME/v5ioX1Ef5AvwsvU4gea/QUXu6SA6tgqP7NaAzVzeJPhhhmgQc8cJHzZKzG/ejKtdX5zn/MdBFGFJt93sHdZy5SVVrCqQTpn70CPOlWLOT1u5lbsAgcFVRr+7VcKJVjo3w2jaFSifVX7Y3G07N4SXtBSLSmsWqQozaZjeZlvq7S2WyBVgOSFFyqiEhPNqJspguvRxYeJ2UjzuzE4tA5h0oLWbk2rHRFttDF83jloObjhslActsyqn4uP2aMtBFtiN8++VsydVh7HK8cdU1EIuVZVtzpO3IeyXIj3zk7ajuJrsXEsK8wcGL2LW3JhvjOK+doO3gWFy7jKElaTMyzrE43UBQxTwhIf0v1Tbm9T8YlHgCLc8id0qlKcz2dLLqfJpCI0KeFyiMdBp94eGwd5TKTBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(66476007)(66946007)(86362001)(66556008)(26005)(6506007)(2616005)(6512007)(6666004)(186003)(107886003)(110136005)(478600001)(5660300002)(2906002)(316002)(8936002)(8676002)(1076003)(83380400001)(52116002)(41300700001)(36756003)(6486002)(4326008)(38350700002)(38100700002)(4744005)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xv1CRDNVB4f3NpXTzXy5JCSyEFVjcWOT1Fs6418/JXuukOsyXmR8Kz1ourEd?=
 =?us-ascii?Q?JGWNdJKC6YrKB9LiCjsLj5iVcp8mCzVoLdPM9iqu2Tnvi+pNMfVj3NP81o6q?=
 =?us-ascii?Q?mLFMS3SdneLY40946quRc9B+iDOc6A+v/0cw1GaI7YMrCS6owwImeTc8FizJ?=
 =?us-ascii?Q?Vmivhw3ptCR+yzZ4vqRXUYo1cTFxi61VhxJXpiKfKWW3TlhjmbM+6DUJaJqX?=
 =?us-ascii?Q?daFbbQeRkL+Ee02/BVmJqiHhYDb4KiN3uLY/eCvoUT5E2F9rr5Hl1xIxTjiu?=
 =?us-ascii?Q?wxFNLWf2Z+LJMgV+gzDxqBXhIaEvaakJcjSnYRxiFeXGcqF2988Ztj9X2reI?=
 =?us-ascii?Q?tsQurRbg0cIJVfYMYbFOc4qV8CNeFr0a0+2uQRGCb8yxmB4OXQivb663ZSFd?=
 =?us-ascii?Q?4TJ/syA3eZlfdrIeVLuq8ge3OBpGXNsNw/jHgtFB/Uz4w+CR8PKt0mSvTklR?=
 =?us-ascii?Q?t6l94JLEQ5gb0PF1qmS91KQxrab1pIZYaf68d+f25E1ytS+YoMFl/TpSzswX?=
 =?us-ascii?Q?VUkf5MvVHrGuzyd6G/1v5QPeqG7ZKzApaLq9C7ET0wPz56TBv/ErO7Bv9dBB?=
 =?us-ascii?Q?8YtGzdcVCR3FBgiEDnNFF3v4jlipBlZ3AL/L9iGGxRlNwtv85M98zHL79QNL?=
 =?us-ascii?Q?1SMV/HuGLNlSg+oUF02gyDu0KA70Ye+3Ey6hLgGYF19p+zOXfA0hJO8+Pyp5?=
 =?us-ascii?Q?qE2M7FNF2in8pIjbBdub/1wPFir8/CGBgCw4I7oON2KB7vE65yW2l2TxGMaG?=
 =?us-ascii?Q?vu7ey8uHilAF3+lGrIUwsx8rZBbwHM/YCLQId5CLCV0VSrcCrcmTPfM7ujBl?=
 =?us-ascii?Q?Y1d8RKVIWky/itkUQf5vH1fWu0CRNAifqfDExYHeOHCdbFLwAzWobmTnb9EF?=
 =?us-ascii?Q?NW52qxVEMn5ERDEfTKba/i7pxOtZpVKsbYnpdCThvY6iP3xptgVLct/2arPF?=
 =?us-ascii?Q?sKQDyP4gJF5kbOY3k93okJzcyziDWol9fGoqLCpbkX0SvkaY5xb7o6nEU1YB?=
 =?us-ascii?Q?S9ewTK2kafZzVobrC0rM7mdOxAFF0eB6OL5+EEfzsgIgh8A70dg3taIdbPeT?=
 =?us-ascii?Q?ra/l3IsL6RRAnY4MXZpO+rjJcdPOrpYz5ocVJqw5PCl9uSSoON9C3rjw3NCx?=
 =?us-ascii?Q?6b0N9SXWPe3O1d6q5m4FHnX5d6i8KdI0lM+yYWt3WjPi+vivVYNmbcqykr1Y?=
 =?us-ascii?Q?49++Ajm5oGSTwa9N6GHO2FshnpIx2wvONqfd5HmUj7+41tsL/ayFYIG5KfCY?=
 =?us-ascii?Q?eR2baLBC8ykdY5B743JOrX1JUVuCTjU65HWSFd+qYbyim4d85kUtsD4l4RMA?=
 =?us-ascii?Q?SHXUmYVE2d46DaYL4OJWilmgfozkNfWWCGYV+Of3xfYLYmsLv15d/XBBkq9h?=
 =?us-ascii?Q?gQepMQ4kYUbUH4IEpotd/3coezm64jzrewmcYDxAKngiXbw/pdwtNzWTqzXq?=
 =?us-ascii?Q?UdAM+6DPn3JAkXJp3CeZTHt+S7hqKmPK5j1e9scptyt9vipWG8xN2j19cWwZ?=
 =?us-ascii?Q?ORicVw2OsHkYvuaR9B0RcgwkH2KWrzfkAQsnvqeT46Um0i/jrhE26+rho48J?=
 =?us-ascii?Q?o6GmKHTI8GKkNOhsROF5avYqiBaTwenMU/ErxSBm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732c0612-e79f-4123-6ad8-08da9534828c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 03:03:18.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5yRnhkOIaZdm9rtbF/NG7OLNjB2jvudfRc3AQzRSWHnillzWaSToUzq8p87OsTRjL6+sChMPbYYbF9OCDi8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate include in mchp_pci1xxxx_gpio.c

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 9cc771c604ed..3cda6e679cc7 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -6,7 +6,6 @@
 #include <linux/spinlock.h>
 #include <linux/gpio/driver.h>
 #include <linux/bio.h>
-#include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
-- 
2.17.1

