Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F467396D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjASNF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjASNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:05:25 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE037D651;
        Thu, 19 Jan 2023 05:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkAOrY3azCHSTA+98uAnUIiKwA1m+VIKYvGO+fQ5hRCOX11Ph6OjPwPfK+2UGFPNZG2iU08II/UowNm2AlUEjFXq2yxhccPwCpBi6JCvULBKsbc0tu4FAhCceFTnmBKGYDy7un59ZYdnffOoCSbDxm8syVnNMzEzZ7sZPkfaCV+WKmh+1556G9pXPy6DHabSE/HMZADaLrTqAAcH5v72L4Ino7d2aDPfMWs+lhJfH5XCVZ1VJSg1c44QRmlsQ/lLj1cywheqdkfvCh9PXoL+Obmg5+XdG0jTMiArrIpM7Pz2s6AkeU2ADcqCIGcEd5fKZuZbR6F8K3XeNmWqisRMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HTzjscca3rGZFa7TdyXdrfAwEIHdef2gLJkdhqBBlk=;
 b=fDbcp6lg9SpBMsDDdC6CYr/uGe5oh5wNs3P6OSAiYxMU3BPkTvZ14o24SxJ3Lx3NBYWKWXrOkxUt1P5yl2weJvmWlIzd1bY8YXBuMGLhwGE2LwGF61rL6lKQTtqJRom2KWPxTDMGk8k1c5ldhsRb+klSvrpXbLZOwMPXnJGoWXUN8cUzJE00+LSGS7scE2tgAAnsGqRpzQi/mQZHSfz69UyJl0wPWox28Fq7tz/s/6jYnEywEqJBkYLssQflAiqmGvDOgc7Rv8FyvGTKo8qeCD4tnUCY0qLIIG0p7m2yu5wYjYA/oFZTm6DUbtdUcVAJF1q+C+l1QPpgZaVcmKeelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HTzjscca3rGZFa7TdyXdrfAwEIHdef2gLJkdhqBBlk=;
 b=G0WdgQrO/6OCGuD/9hlOQ0vGi6b6ZC42cT6UAzmuTeNhQTbf6RFl96/TQ/ndnuruSzmaZq/OFb4kADjr2wgk33hjqJk0i8L8r+yuRc/8oTErXqA05jeDcMNcGrm6/gYHLiIq2A+MqyT+gtZCus9LieAlMTCO7QKfvvPKvN0mvV4=
Received: from DM6PR11CA0023.namprd11.prod.outlook.com (2603:10b6:5:190::36)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 13:03:55 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::d6) by DM6PR11CA0023.outlook.office365.com
 (2603:10b6:5:190::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 13:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 13:03:55 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 07:03:50 -0600
Message-ID: <a226d15a-0dd7-6541-85e9-b46c6c2b989b@amd.com>
Date:   Thu, 19 Jan 2023 14:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] arm64: dts: zynqmp: Add xlnx prefix to GEM compatible
 string
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <578a4fcbb4143888af954996a45f5e1110e0ee50.1672909426.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <578a4fcbb4143888af954996a45f5e1110e0ee50.1672909426.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: abf3b78c-dd72-4559-e9fb-08dafa1d9f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGjfNYY8mm15iaYTusct8Fn6OtXGeLdMaEhf38RLS61r+XfBxJcXYN6ct0qvI1KJn3gYn7bNefiViIYlB1feNHiRTTMEa2pppFCah+BUDS02Io6lCQren2JFZ1fzIV4gT/cB0NjJMiNSCG1dabzNfq1OA047ZlNmBf6Xk5MVeOZLEQae/c5ukZAH/Euty23odgdvBDlipME1KAOvAiNRybYYwzasQzYKB/HdQVS1C2SBxV83TZBOuBs2xgqcO6QwfstQPsqWADi2QpsWjUFSBOTOmZLQ3o7exDVYJA6eq4YMrTrAQMuc2DzT5/5pPqTTcCTYT7ZV6sBOkjNg3DCv9GaT0OGJFmmv/Zn8DREL9GzR/kFVJSjDEvlK2suMUJ/X8tp3khy191CAPOkbRUBEjwnDNEQWHhdy6pDTBwrBQwXx2GzRVhtrYVcAvgQmGl9/V87f1PK7V9IraH9PYNuvlmffX5RVhicnk9fupzV1BIdxVLOBlofemp9I0l0uLov9VttZbkkQ1gphGN4svVY9x24W8rexrDgtcDgt2moxRB+3WdqD9L2AuC53W5C0okoN/Yo9BMC70kcGBlbZukVu2bY2iEKm5mtK/rH6yV9/yMuNM4noO+uOjefCPSTkEsM5BrUImNjpNWP6P/NJ9XD9ObTqNUeYgiVErEnvKDppsVVTKish3Ch3rHAyUhB5E0lop8nDECfpqwuhcT7h9aOyR0A0OjXTWI12ptd2+wrE+OmuO+kR3qyhg8pl/qTH5arVAvebDZLCkAtnPZO423ry1HFhtsIlWv340Ft3EKRz4Ho=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(31686004)(4326008)(36860700001)(8676002)(426003)(26005)(47076005)(186003)(70206006)(2616005)(41300700001)(16526019)(53546011)(70586007)(82310400005)(36756003)(31696002)(83380400001)(86362001)(336012)(82740400003)(5660300002)(40480700001)(8936002)(316002)(110136005)(16576012)(2906002)(478600001)(6666004)(81166007)(54906003)(7416002)(356005)(44832011)(40460700003)(36900700001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:03:55.6975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf3b78c-dd72-4559-e9fb-08dafa1d9f28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 10:03, Michal Simek wrote:
> From: Harini Katakam <harini.katakam@amd.com>
> 
> cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
> favour of xlnx prefix. Add this new compatible string and remove
> the existing cdns,zynqmp-gem compatible string.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Remove deprecated compatible string
> - Update commit message
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 2ff4b788e094..153db59dc4b3 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -540,7 +540,7 @@ nand0: nand-controller@ff100000 {
>   		};
>   
>   		gem0: ethernet@ff0b0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 57 4>, <0 57 4>;
> @@ -555,7 +555,7 @@ gem0: ethernet@ff0b0000 {
>   		};
>   
>   		gem1: ethernet@ff0c0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 59 4>, <0 59 4>;
> @@ -570,7 +570,7 @@ gem1: ethernet@ff0c0000 {
>   		};
>   
>   		gem2: ethernet@ff0d0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 61 4>, <0 61 4>;
> @@ -585,7 +585,7 @@ gem2: ethernet@ff0d0000 {
>   		};
>   
>   		gem3: ethernet@ff0e0000 {
> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
> +			compatible = "xlnx,zynqmp-gem", "cdns,gem";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 63 4>, <0 63 4>;


Applied.
M
