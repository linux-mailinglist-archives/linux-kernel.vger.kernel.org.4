Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837B96545EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLVSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLVSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:23:24 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2102.outbound.protection.outlook.com [40.107.101.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCD193C7;
        Thu, 22 Dec 2022 10:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6iNPTXeswL76sUbFoCODU+9GS/LHKVxMrV98T60R6KhUbAkjEp+CWAvGYQUPK2wp7q1JM/dADUl5fFsR143rY7K7jiTvUmsGQKMU2HwYExNakhS8VPyoiYcd/186iWLA/Rp/NKhyPfrZai7y/lwC396EYzeAG4iv9xgUXLATZc0UJLXVpsolihCJmMjkiMcWy8wKnYaqRRmv1iY7cQyQqegdgdDaKVXV2Q0fAAwfKVJxnirHERdTrd4ju+1bewWw2+zMBwmEZQ/u0uVr3arR13kzf5X2Sa9H5/B+wpA4EpMLDkZOU7dmy34PYIzzU+mhIq4Yokr+D+zWQaJpklQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2juTCE+0WmWvJW5b6XXj+iTXcwkfmjNbIQzfXR/1fgQ=;
 b=V+Pcevml6a4wZ/j2VFyR5nLx2UCK6gjQqJ2Ncz8kOgH7FpqZZrXAwzsvIzlTbOboCdIcqYN98nFtxQEqAqRIiv8JTJIZBXzEfj9XInzrL8qT/J7FTCXGu8bQ8krqTipdyIVzYTesTQUfwhsp8D/Qfk/2W6J7a0+kBHP4942wfifAYeZxzDp9jHY4hNjJLu8yb5cZ1xxpiu54RqXVAyGv8+6XHmEQ/Rxf7s71ui/YeFIAm396DMIJX5I+eqC/1HzZLz2m2RqNfUIy3oqBU+P5IapdjVEEYZhIxherYZUq2P9qoes/IHsIzwm8Zn0L+LBrGm+HsIkYfhKdvwcRbcCq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2juTCE+0WmWvJW5b6XXj+iTXcwkfmjNbIQzfXR/1fgQ=;
 b=PjtrWlYIpSUupIVjHyEwykDRRMmr2U1bzBRpcL9bsLbcawoytViA4VOqU8PNASpxq0iNSqaMjitJUg4qKAYZiNcKsHFuJnA/Bh9m5ivWeiv5Xu+ctQV0Zc1h5Y96KoogXlcUSc+CnN3OFWPxaCyhwCC76SffSd3wO0BwyH9R1JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY8PR10MB6659.namprd10.prod.outlook.com
 (2603:10b6:930:53::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 18:23:21 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 18:23:21 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1] dt-bindings: memory-controllers: ti,gpmc: fix typo in description
Date:   Thu, 22 Dec 2022 10:23:09 -0800
Message-Id: <20221222182309.575069-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CY8PR10MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: b642804c-27aa-4ebc-13af-08dae4499b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lw2aMZXVeL9OUAAtjo2v/Eh+snhX7AnnOwHHS7wwjCsrusQhSkZ6DRPiXcAkjxRDO3A50u0mecLdLh/BhO9u6zHlFOgYQ4xwX7R2g3SV4RqF7FP8F+w87qvtfe63k4fvke1BwWqPP7K23v3pJxPwnkDS+DIipsWl2hY2UBzcJk8vstIkUpR0rUgIxLWBFiDzY9zOqXrNRhlZyYdl7WthdVMskREjV98oBUQDC1U7pp9FGwHKH74WI69zUb5LRIFERGL1IGQnTqDcVQQ3eVe5YDk5vwd5FiewjlcW7rCS3Z4cX+M2zKctBsq+eG61E6Z47osDlQrH+fQVTCtHSONHpzJaR5gtEwGnFEPdNWY+JBAwQ47Vn75uH0fPRpVKtJrfbBCu5krY/SmkDf5xgkXj0Mme74QQ+S+SXgE+eyGdczyWoV380bETbPKVXj38skcwbD7nhQ+GxPXo1WtZCRqq+DdusqPsECUfpM0RjThBTJCcKhNImSDgFz01xDEVB33Zmgf5hdm6aP9kg1ZaO1D87Qt9FQLHvqViIraSIpWkPagaP99zwEmbgGiNRssrKIyWDzE4i8hOj6ilXzhAnTu7T2I3sWKYn2jtu5YSCpqG+eIH9MFVdmja+Qw49VH5fwQXwDx3wb5K4STa508+hzqxnmhhyPY9fZNXwM98IDS1Z8Xl9sLVxsqngtEFCeLA/37jKx9ADUSNmt0QhMEWZ5eDnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(346002)(39830400003)(451199015)(4744005)(41300700001)(44832011)(2906002)(5660300002)(8936002)(86362001)(38100700002)(38350700002)(36756003)(83380400001)(6486002)(54906003)(52116002)(186003)(26005)(316002)(6512007)(478600001)(6666004)(66556008)(6506007)(8676002)(4326008)(66946007)(66476007)(1076003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FEHLH55asiKRGwfvyk8QQEypcsJ0yEBG2g6fAQvUf/WPAPmTR/GLhZ91oqYC?=
 =?us-ascii?Q?yFZhjwLV7YAIvS9xefTa4qz8iXgB3vHhWJhW75T8W97MIQHswyx7e2QbC9ww?=
 =?us-ascii?Q?+v02m0hTxHkGNof2l6jFUACcDcRWYsJNuLA/6ga6Nk10blQb9LuLfTdIXK6J?=
 =?us-ascii?Q?tSGf8407jRN/2cINrI5XV0rtftgtH+QHn6s9fMG+JvDMHq0VR3IR51rIivlX?=
 =?us-ascii?Q?/J+AoR1VyTeLA4UtAOyBYtf/mlPjG+9XyRiDPig5PMELDqis80vlWltxxcWH?=
 =?us-ascii?Q?SFEEhZE4C+4iWK6fHMwX2MGvWBFD7xUCErNw7ImTp/n6wW70YaAabNjh7j0M?=
 =?us-ascii?Q?A223PcUAlSUklnLSVvTN6HVQzz8IwABrI1O0e5Wx6LeEJ/+NARk+Vm00fFCc?=
 =?us-ascii?Q?PmSKWAh0f+tV5dn1CzXZWirBkH3NxdpTjiXHMKw1wDeVFoHkl/ouBMYnvd0b?=
 =?us-ascii?Q?xGaiKi0gsVvRni6JXD3fJh4vdQ1XQOxKP0/uiTzLhWteKAswy14HT5a1CUKr?=
 =?us-ascii?Q?trTMmsSn/W48HVBVDpIY2CRjMU+wdJ7dk1swoWSJvC85+P4qQd+7G50bMaR+?=
 =?us-ascii?Q?NQIqvD7Mu3uqCXcDzbWRwqxQNRZAXUjCamy245I4SZFeJFpzU6WJOFCql/WL?=
 =?us-ascii?Q?W98f3N4oertjLEPNacpCofHOU8das3764df2+NUFpuhb3WRIyHgPObHRNHO/?=
 =?us-ascii?Q?hJ72A+dHBOPxQ6XA3w0TYrRtKJug3tSBQI//WkBSaBrMSFrjf4LRkdQSUCs/?=
 =?us-ascii?Q?ZJ5t8vNOhBJcGVTho+gVubhoXRTYly7wqis3iKaXod6Tk4gB+hePd3pPqe3b?=
 =?us-ascii?Q?jN5PeYVWDs193bZyFp1YzTKogHTjmlYG9u5uG0d+7dfXZsXvaoEiBfMODJhe?=
 =?us-ascii?Q?EwIaUI9JKA8TPbMw8nGH2DOI7wPjghQqycyKJcZv4H8m+xI7mIbRcRIpjLAI?=
 =?us-ascii?Q?qQYUqBFvkNqTJ2A1jURbdtlWFnuizDsHwULFrWa0Ky1hH7s8c1+2QMdQ7XMR?=
 =?us-ascii?Q?l255cJ2rcpzTUEzrOOXHVGm/7EvxS/JP2FsAfSkrAsa1NdP7H0Iy9vRCMazy?=
 =?us-ascii?Q?5GkviGWvANSLFBa7GMPYvifEbRa75QxsQJfrWbgCy9pFxW1I6tjntUG8lX0K?=
 =?us-ascii?Q?2G+2aYDanieET/O4ufiEiTY4TumPLs0BA14C+FRZzrt47l2r/bRpVkGdosTR?=
 =?us-ascii?Q?ofuimSFTIf6ETgGHtDFpF1MJStDPKISF1qwIR6C9wrpK4WrZJTpQzzzjqbO1?=
 =?us-ascii?Q?sU8AGm85MkmjCzWcQtdIEU2U46vpA6YwnbliWSVwObcQGgRP+npqodFuDetZ?=
 =?us-ascii?Q?IShnfp6a6Iq06rgWLdgolrwMUj7BFQ0VPfybwNpibDIqKr6FmXc6UUMUUL/Y?=
 =?us-ascii?Q?3/O8FKlgApCiEC2DQ3bjagASh9HxHqWn9VR5qLeEC//mmQPBqXGzGH8DAIxX?=
 =?us-ascii?Q?IgB+ZdHggBo5oP7W+Mtf3MRQgjpHDO5IVlaM9z6RdRw2wkMj5sHX0kIy5Pfk?=
 =?us-ascii?Q?DBL6964Ih7K6TSKKERXuM4F0ghUAEWWAcWuI+Q7JWB/aNiFw33X0n3j8Q+Wt?=
 =?us-ascii?Q?bAMjji8vOD3nD2u250nl4Y39KBVeGjaPP/NudhvXVprQl4SLsBMEXvTriQEY?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b642804c-27aa-4ebc-13af-08dae4499b14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 18:23:21.3594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0PS9+lK8EDvcnBVBJFTtDxZ/zPlGuM+uuo1xZkQOEQ5m4Pn0r/XrdBrjZ4+rgJH6bY8+5dF8CInB7MJaNZ5sYC/bTW4POGzCdNUiI2eaag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6659
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo where 'GPMC driver implements an interrupt controller' instead of
'and interrupt controller'

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 .../devicetree/bindings/memory-controllers/ti,gpmc.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
index e188a4bf755c..b3a991f1fc78 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
@@ -90,7 +90,7 @@ properties:
 
   interrupt-controller:
     description: |
-      The GPMC driver implements and interrupt controller for
+      The GPMC driver implements an interrupt controller for
       the NAND events "fifoevent" and "termcount" plus the
       rising/falling edges on the GPMC_WAIT pins.
       The interrupt number mapping is as follows
-- 
2.25.1

