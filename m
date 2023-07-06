Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E7749AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjGFLkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjGFLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:40:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6A1992;
        Thu,  6 Jul 2023 04:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEMYPYz863/C0LSyaBXhqJKLNasXPCsz5afuJKu8+1iCXusSV7P+O0CM04JMGRrsbWYzXDXMSpxNWm3Wl/0HvIzeRSR6JI1L/MizTw6QPlfIstRYrRKbMTV4WFMeIUvwGG0lU7xV1YzeDzq8Umlz5ms/h9S/krhHxKlYjzQ8s5TBxpj0DrxwFUklkN9w0NBfvskHQk2WmWdc5bQQXj8Uv2T6CidsCgEiSmeCpBc03dFRQSkzKfExN2uIL6EBIBBf8cbM53Pn+sT2mu9U9XIl2+CKXyHN7i3vx5tw0MHxvke73zEvSPxSOjfVnpUGUVKRO0MPAsQoJ38FWvcrneQHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThPm5jzEawEJeAbP+7o5YKLL9542oOzZ+0WLNtEnRNE=;
 b=GMikXTNlxbT4HBxpaJGYCFIf19OGFPfynDKDTZBwoBMofmmNdk6KIAemzTTox/0qycVlFKvo1T3zKjbC4v8Pi0vyYgO14ygLHKOj+rPcb5fsDE5G6ihYZUq6s5T50ea8wMilzZp8ZkSKci3h1bj1lJFgptSyAg+kfUWKX2nWnIdMbdn++mec7NlJ6teICxZaG7gXiriXnC/9uM9YSPiQWhbbsgznI+g3FQJJ3JlCvK9gQp36WTz9df0GRpQeLilAwkuL69ionTvhqoaOOlKejJu5AzOlwscf9CGmvhytMVqs1LM1PNvo/FZOCm1W1WvyfRvSyaxwIb++b2jfjoSSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThPm5jzEawEJeAbP+7o5YKLL9542oOzZ+0WLNtEnRNE=;
 b=RpgDqAPJ6LlkME81QV8FwqqJlfBuYy8KpMtpsJhLRn9YH4GMk1LWRYI3WwPtKwGKfjKcxDcK44uX+OnASdKWgMldJYVKEtwSwsSh83mqtXf7ekZIFxVF5JpRZnUCwTAQfOJQAXxdKukssw9Ff3qlRCLRE9hwbqfCs0+jbDppzr2CiFFxa6/yNoYBafDYtTJZZ6gj0jSb8/d3GAjLbsEUeNh6GI189qtOrS8VqxDbkAfHkEzjKddiNIZBFxy0jd/REkCLTOHFhLF9Qhf0NBXIVXMpBfIBXdox6XMJyYcso7yOPcLVNLE2IAtWwEQckgepAMA3PVDx3nkw3zcCAMvGWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:39:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:39:56 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mfd: omap-usb-host: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:37 +0800
Message-Id: <20230706113939.1178-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6452dac8-ea58-4309-2b3c-08db7e15b8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjDyeR1NN3PJJ3NHVY5h1T3glGDbQVZKGGAzVGvIQsOSHRPblmkUWzP8CoZTza+qDKMxtLUj11QVSKuXyhx2jBrhoLyqIfQFnDt862IhogLhZJt2CX6ErflB6Z9zYeOK9BYoGrg+UC4SJXxGGPIeHj/m9JU9PKUHNzfixuWH8a6O30lHZ0dSwrp+x5ud254KaCzuI+4uJ0NWR2oj1mqdFmg6DQSkvhD9PWiTYs2C0wzCgtiLyuXh9CbkwbznfanihdgUxQlr0xX7Gwdpr9ITpEoL/FVKZqkuRo8cmfpJCC+e/ZJ5NVKttjNQnetgeuCdR9Jkf7IYpf5D8Qen7FWhGmgcC0y/ycp+Md2yoIZUxo+GgqQHYbnrPJFApr+TTHq4xjMS3mJMp+JzlCvJtFwDTxyxTeDia6gRJlkWOeUKyG1tDvk+4E/2dsdfQyJiOn8+I8U60537Dcan5o3iHXlovOyOC+hwaK3e5SPlF/pn9Zu5shjoRMLuTg7T7sOW85k+ai/vjale5mXonzxAV8V6vt0STzXe0kWSEQrnk276FcxjuofV9jmMWLiKxvRQfKctVP7+yLxFJPQPBCVBd3jTIfNj6r8dS6r1XzNGStRTOoVLzAXXAnE8aXwoFL6iVwJN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(4744005)(6512007)(6666004)(52116002)(478600001)(110136005)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFjUeBH7GccWJr3UZQ5Ci71f2iDATNY/S6rnM2kQ51PMIvE3GRjdkNoufnL4?=
 =?us-ascii?Q?YHf878EiSze0gh/cHHwVt/jRg9yWyqUDTQUNgSyXDrxMoAX2V7i5mcJekEWr?=
 =?us-ascii?Q?bdfxIXUh0HYo7JD1UclB0EKsp7nwmyy080E+2LYekMJrGsutSdU0sGLAmbL1?=
 =?us-ascii?Q?fhf7LfoQNIyNebHsjiOkR0EE1Qln0r+7CCcsHlHLCDRqmn5/FgBXbsqVB/CF?=
 =?us-ascii?Q?9LznL65GpytSYI2cruXcKlWquNeQ9DPXOa3/S4I6RFqJMTAjMONF93Z/8Okr?=
 =?us-ascii?Q?etnHbLoWpQfUmHI3Xwg1W9vZJgCKP9/kxYiBkYV3ikRHRjvIAKgNI4UVzhTe?=
 =?us-ascii?Q?1NovGi9GJW5YzY0oJk68d11kNk1UqRqRotcXY37ICuQvzA5NwkL1xelsZv/z?=
 =?us-ascii?Q?ox8EN03/LTm7/C2cKs1rTltVFdAZTjVDWDpwGXsORdzhaJzLOYkIfGq5K1vl?=
 =?us-ascii?Q?iizGjhgELfzaHgf5ZiFpzrSmxaFyMn2NjgorCByiAWeqtS0kWnohMNJw+nKS?=
 =?us-ascii?Q?h2193pTMiYU7VpFHxf1IRGuHLsKAnKeQGkSbD1zaUhDBgTEqTwwi9KsHNhc6?=
 =?us-ascii?Q?wmlq28nwU50lTkySOh2I/LPfHnBYtHP0ZFsHFY8eMRqd/aUTXIdC8xUKory2?=
 =?us-ascii?Q?5C/3WMYArCBPzts5lIQl+NLNXQe9nu3/h6TuHCaN8FWDCHDbfEQCmRfcw2Vl?=
 =?us-ascii?Q?kP0SAQCtYNVoGzACeeOPQwV5oQt2skA32amQmOAuULuWbST1o3LsCkPSbvPq?=
 =?us-ascii?Q?ktafTgiczHk3WzK1+ZoSp6JIqVwuhVhl/yCrgYzHqIUa9UoKZ7nWzxPy316c?=
 =?us-ascii?Q?Jp54+/Iv7QZQ8hNxoZjWnGAk7TIhpf/qZyq2AiT9Tq5G8LEJ9y1nMHFhIQg4?=
 =?us-ascii?Q?Y9s2lRSDMhiTnAwIROCYBkCNnYMr/8r8tzqZMwf6kcoAeJ1yAN4WBjAvHWOW?=
 =?us-ascii?Q?MgOCn+PHnmfYyWoRE+81eHvpHXDqvU9tShu/j7tkdXEDlZEwPGv91ojvkyOi?=
 =?us-ascii?Q?EXjLRDj4VLAkrmmOJW47iZ/gHcXIWr+81rKMKQZmZnwDDjFmFF5I7pvecbnk?=
 =?us-ascii?Q?ra84Ougd9dWwhv2KXBcrQPivRO9ZunOnyQBMdhWzGg0DHq6O8rrjINFjAQTA?=
 =?us-ascii?Q?3aBxwU7TXCnlKvBX2bnlTshI0xZkSECGJLx274TOIpvUpA7C1PK0K8hCrjit?=
 =?us-ascii?Q?nB6dfgbl0SZUnm3M/B3Xcq+wMt+JFpGiwcmzj/1GSqy/45ER3oB5pLXpOOZS?=
 =?us-ascii?Q?5qIIwbmpGb5vQhg/Q+68Fgv+7e3pdJgGZ7eviM9yDprH2S6/MkRNMchfMfJW?=
 =?us-ascii?Q?N6VzUJ4lBJ+sTDFQMlT4fxBByD1+LhghFrwuHEb2u2mQVhRZmluza5Zn7K1X?=
 =?us-ascii?Q?Zv7gmTyO7cH4LPxvXvmHN7GYSVFaL9JkZ/Ux6VMhVCUI3hr7Wb8DAcxudgYa?=
 =?us-ascii?Q?E6e1gTRYjPLooyyF21KBW2b4nkQE+lXhaBb0q+W1vpgroQKWfA9Ll3EQN8SX?=
 =?us-ascii?Q?/SQsEnCbaeBUF4B/2JPQItV41mu2bYw8tphs89yF6Jq5WqF81F8FFDmb8UHB?=
 =?us-ascii?Q?imNHLjUSpP/lQNfPm4R89L3Si3b6yWPmIdXJHWlW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6452dac8-ea58-4309-2b3c-08db7e15b8d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:39:56.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCXDTjfpXF81v0WyQDWnOb+7S3c7FyvMqQT0xWCYmUDlqc8uG6WyMj7mxhiyOojG6pLjr2yCHwvJmxq8vIHnJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mfd/omap-usb-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7f5775109593..78f1bb55dbc0 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -534,7 +534,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	struct device			*dev =  &pdev->dev;
 	struct usbhs_omap_platform_data	*pdata = dev_get_platdata(dev);
 	struct usbhs_hcd_omap		*omap;
-	struct resource			*res;
 	int				ret = 0;
 	int				i;
 	bool				need_logic_fck;
@@ -569,8 +568,7 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	omap->uhh_base = devm_ioremap_resource(dev, res);
+	omap->uhh_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(omap->uhh_base))
 		return PTR_ERR(omap->uhh_base);
 
-- 
2.39.0

