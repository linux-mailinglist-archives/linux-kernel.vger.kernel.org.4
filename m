Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77661642714
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiLELA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiLELAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:00:00 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2118.outbound.protection.outlook.com [40.107.241.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF719C39;
        Mon,  5 Dec 2022 02:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXz5fv1yq64cWR7aCabADQ6UcktW6k4qKBAKB1Eoj2+2AMXnBVLMzNc3OfRt1kmMCLwL/IBTS3AzAxejgudt+8JUkb6mXRT0CHPzMbdvOQmaVmEqewXGdat0BJue4g5HbKr3GNGnZSU7Z5CqRul2OSt2O6S5Kq/2u/RpcI536pEgmLuYV9DKSpJ6X5oQeNPkOsVEVyK783qCrnfR9bw93UqQDk89R/l/VqVLsYDKWxy2+vIGy4H1Ev4MdxdCpttzTBzNMqIirFH86mZJAqPhalxr/5cT/V2f/98Ox4Y5U5NyZs+ZeQNzQqeb+Z/rnfRfDseYc8UjiyFz0vNBPFSepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpcaWWF4JSn6Ob5VZ6amkREguT+yRCr5wQ13O4HQulg=;
 b=RHybSP6cKlmzIQ/8BJp24QaRUH+jUCZgSoLjN8gsU0q3kUDo2Zqt4z4LkDWIQl0062NhzB4fNRTMf8Qv58LzqEAyb56OciLMKOQ3x3IV2eelbjqQBkJHj6RJTDtWLMuhgz/gkIlUQnFydITLpTbiHbLlDHmS/RRLTUbX4da2nPWWX+8oUkFWx7qLtJGWb4jHDebrahktGy7xTtWazlIfpbpslPDN0y7VaKKZQEdcRpIlACV2NUj3plOsuqK4f+6/bHnQ5dRJozWhrp4+hti5oWejpdxDU7sYWR096YqSdwnCKOth3GK8qagVsETbeNpA1i3vvKkyEcMsIzcTUsh+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpcaWWF4JSn6Ob5VZ6amkREguT+yRCr5wQ13O4HQulg=;
 b=iTi6YW8fGOSHSMCox39NHkJ6XLiNpPZxHIYvN7In2zFzNDaYF/g3fJNAEC1RiLErg9FxprkmMwxkBuOOCK8IfGyzfKEa3lP0bJDFZ2pGWcVKLRh3JmXxpD2erwpK5VjAOVriOGC//hPz3fbZB+0ighkyOyLkaoghyA+Nb8MKSIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM8P190MB0980.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 10:59:48 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 10:59:48 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v3 1/3] dt-bindings: mmc: xenon: Add compatible string for AC5 SoC
Date:   Mon,  5 Dec 2022 12:59:28 +0200
Message-Id: <20221205105931.410686-2-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205105931.410686-1-vadym.kochan@plvision.eu>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM8P190MB0980:EE_
X-MS-Office365-Filtering-Correlation-Id: 852ebbc4-ae17-4dd8-4610-08dad6afd34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USlIwbz5A6p3UdSmywmNB/+0kARMin87bekI2LkDbTo+TEl55Sn+5tk3ljh8RD0uxEfmWStXDYFjl+AID2utQkUs8+lrd11TT6l+/EzLIiyqPUYd1RLqMpKlt+zEpJyQ5lS8nc8Nk6r4A6mp85O1Sif2/z+rH36c8Gay51B24GVpfm6mPcQPzkapLBtmYrxp8YV0wskcnfsJhHl50n68FA9V5ABPwavUCSOAl9/74rMKahgcY5hR+ha+HG4CnygqSF7OkivkhSDkCUpwcuF70E5lUsNY8ygnBwTexyVeiVUWbDnJ/hMzitvwBwf08lEGnkeyzkWmE59TKs2m8+tj/W0E7hMbxjscujklv/4pxYXGhdxhgIj7si1X5dNnKyFcO44hyTa/VWgbakBAVHjq0VJDKJB4ARX71djYeNWYjQ30ifkUwyQxLqkYuUqIRs+1Bcp1wx3TGoX9VqWB6pnpbqIfyqKA2sPK4rD+ub3YQlECjn4p+qPrEaZ6KmGnGxnuD//tfJezR3Jlelm8SFRG3Xt4WLh2qM4RF+XdvRESQ6K0jm3bvBt9q7zCQsygKLaau0hQs8cLGam2bBdBmVSmn4NtdktKYB+9XoW8K2fwppGX6fTliQ+p67f+IlnFRUSNu2+mzQuQJbxR8PRYeVy67tELhi6cA1jg6jbDKyk7IrB3L2D87jChLzdrxtWtY7El
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39830400003)(366004)(451199015)(36756003)(38100700002)(86362001)(38350700002)(2906002)(41300700001)(8936002)(4326008)(44832011)(4744005)(5660300002)(7416002)(83380400001)(66946007)(478600001)(6486002)(66476007)(66556008)(316002)(54906003)(2616005)(110136005)(8676002)(107886003)(1076003)(6666004)(52116002)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBMub0BGKwWRJobGJQL8SVYCY4/yOnjz7pU7udmaddjZNbRb9J9wxXDQVjRx?=
 =?us-ascii?Q?ylvc+FHS9DLEhV0rUoiYF3+JHMwTzN+glyQhk39VtDopm5AR2K1jiNCoQkGL?=
 =?us-ascii?Q?+4bcz6Bp8n1kFQOwD5TZBhL5RbOOQjuUz0djduIMd8X5NJqaoRpJXdW7qBc2?=
 =?us-ascii?Q?TG759NYEVK6ljeEsVZo8gQZb6xt/RONuOIvmO9UU6MC5eVmCDl6xsjqobqFL?=
 =?us-ascii?Q?WIUDZcx4CrH4e0XK/fThcig21tJTOjSnX6yFuvzSCb5O//YRZpDWKi47+LmM?=
 =?us-ascii?Q?seMaqBfaYnkHhmIB0Bks2so76KustYS7EGy9X/DhcymAaEnjyyRPj6Yfy6JI?=
 =?us-ascii?Q?cB6710nm7Remx+45ROtysKNsYCGD7vrTde9S+em+sHGWzj0D8Y2b9ewFduRE?=
 =?us-ascii?Q?z+inpnqiWvn+yS69HZxsaXeSGa670tXWIfOGNkkDyq8siT9woStUCoR2Gici?=
 =?us-ascii?Q?DOrzdX3WZ+o854m/A+MkdZTiK+wTgrsQlOV2+FQnP0yjxcCsw1rEBBLFP8PM?=
 =?us-ascii?Q?G8l5HwHDgqzRF8Q6QkyQhUb3qSlV5v3VVCcpXfSbC6R+hjsY8O8l7Dhn2Sl2?=
 =?us-ascii?Q?o3Zt7ZF4xycxVo0h+oEwdCmTSsyt/krIfV8q5vBkL39rbGV4pFjruCmM2ipm?=
 =?us-ascii?Q?8mnwcFHj5oX/qkB7xxRVBx3N50j0umSNYbpvYq1Aq86Te3jvbktAQJCZAary?=
 =?us-ascii?Q?fgtybwl92NtmW2idiTfRltJKVzmOBZRCtM3WtKb61Z1GibUMaUEdg6v7ZNfe?=
 =?us-ascii?Q?9aB3+be4SDkCTZy9zczRGt1aPI330ZZanc6m6qf2zlvLp54p78bmUNv+vSNd?=
 =?us-ascii?Q?Ney5AD5+AXbDR59OuFMILibVXxvOkbIWA9kjwP23PB2k22xBD4RMlZMTHs0T?=
 =?us-ascii?Q?nIKtLGAbHlko8lNtgzeIrlstr75m/O5svMPV8uyZIWexfbQ6g3BzBtomQLsW?=
 =?us-ascii?Q?hHp6J3fK3NwZmGXHEEQK5zwcTA96MSOjzcyOqbXAypCjrq+mheuDUVZctaF8?=
 =?us-ascii?Q?5pY0wTK6m0Y8c0R/UCq9uyzJOCUCopARQ9MpNfFLIDCHToXTAAUzt9ZVfoZ0?=
 =?us-ascii?Q?1wY9CDvVUspYsyc40pR4AMQYNQ5pzgDPPcyolSocvFD7vQSMRkFE5GibWZ6i?=
 =?us-ascii?Q?vC1COaOZnon8o9WhBzByL/XuSKYUdmiXl900Vdi+yTV8RFyKuklvDTASawo5?=
 =?us-ascii?Q?lEVpIzTQ0l7VxAKgbWjNCsgfiEDEeuh/l3ajHDDK2JSSte58fLtYgzRLPoij?=
 =?us-ascii?Q?nZlN4Np65udSzLV1xX9eoNL+CWrXRFbC2NwVm/PmmOLHyRkua6xCzlPvi6z/?=
 =?us-ascii?Q?vET5nE/kYQkVP6FhUv8w1Ej2sL2FIBHuqKEnzUwMfVsg3duQBY1Ob7lOgYJg?=
 =?us-ascii?Q?pKAp3O0OjCnwzolFPtLPYEUABXJkGAFg7gFw4/Kmm1imtHEfzPEJwvT1tqWK?=
 =?us-ascii?Q?9+Bw7XNOLhXK0j0nm9b2ffy64mgrvE6o+CdlIcz2qi4taOe0dLaYqDFnEHRJ?=
 =?us-ascii?Q?JuftZwG1MhMPGe5LbHH7+O0btoKz+ZxYRd3du9xfUeKg9nE7fX/maRH0oVXG?=
 =?us-ascii?Q?RPAYyHUpc6XNh44+pH8A/XtqfOoY9ZM62VDLA2+KNXTB6eCcDV9LrxpdfdYS?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ebbc4-ae17-4dd8-4610-08dad6afd34d
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 10:59:48.0902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhDqO5o/q02WKKLvqrUYBq4qqF9FNAIHcUDVHcoO6zTL0s88x5bLPWfF+v2nGLZP0oej2gU3RvCUBkEsredU8jU3kP3sBYPSHRG7FChAMFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0980
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AC5 SoC has Xenon SDHCI IP, but with a limitation of maximum
2G DMA address range.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v3:
   #1 Put compatible string in alphabetical order in the yaml file

 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 3ee758886558..3546de114d7c 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - marvell,ac5-sdhci
           - marvell,armada-cp110-sdhci
           - marvell,armada-ap806-sdhci
 
-- 
2.25.1

