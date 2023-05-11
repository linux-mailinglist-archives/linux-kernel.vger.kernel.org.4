Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05E6FEFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbjEKKcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjEKKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:32:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302610D5;
        Thu, 11 May 2023 03:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Asmddtcfovd8Dcr46Q5LmyOqcZ81zx5sORTzG4VrjnNSj/g4VoVvh04Snx/7bE0D48j8n14nPlK1xtbumAi3j/pmLiZveRji3TJTOzRzQ0OTqhuI0ePILyusKx8yEZ0KC4Di21giIDYR/YrY/UJK5FmX0DaqjoQdevBU9vjO0vJ+7rVZIdqmz2aBatsaZn2l2m3GUKb+w5rCDFFy2xGxx7msOqMVJnbNo+8NTMyab0CBhJM/ukdf+apoXw9clu3mpRz6atDDehxYN8UVVNme84f1l6Stsely1wo1yCfXB4Z7JcZC/DCqHg6XPGxRiUR5oI+qxAzn5qLNa3DcNhRjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wduxcE1BcjP7WBY3RTSDvV4maxZh0PoZ8WAdRRj4/N4=;
 b=SNLw3RIu7wlcE3iOAxsMVtanu3mSve1BGmf+sau38pIQt86ovWfapJ2F5GS4J0x8m7+Zb0DN0KrtlF1bM8d5z2AESYnzCmlTSSOc4SzgWC8hYkJjI5nWxpmev8YzX0IBC8ptOp1/8ziPhtmgWdauzF564k2V3IqPCEhUlJrjij9nAP5r6CzjCPB+6fQYN9BJ2ERG9RBINRIRUnJMgHyuIDbntR5OAph11kep/wm9nds+dqxcOudTLkt8ZFJFeLebafIHzUL28HQbQHqNaZfuqCXXAWlxfMkoZY7FYAOohzmNaSFhbQzlk7wNW50cLSY0G9jItNF1wQoxHoVBha330g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wduxcE1BcjP7WBY3RTSDvV4maxZh0PoZ8WAdRRj4/N4=;
 b=cMbbfXjM2Bt+DOB07ljzbVki7eQHf9Nw1Wz7PJq84CaLkpdky7d6NsZznA+eEyloVryOOX5Q4His6A/in3K9URPnPWsyRSFitTGb90XQFDw8guTSrORjVBJAbJinuCSUdVveC9o+9gaLaEYzDSfcLtcjyvk+l1ZKqGWJYKReQLiB8yXG6lePDFObAp2OEM2PlcWdtEX8WCdgz/SsNTWedm6i018gwAwrlzpqenISmD/h3SLJmSTJlfpsKYml5iWiW1Tp0Sx+a81w8nDE0b4CIWWXO6FLuy6/TSyKxMCUniYoij7FKOOcuGW9uhQ68Uyuk6/MHB3RI6ef27I8w/zBnw==
Received: from MW3PR06CA0009.namprd06.prod.outlook.com (2603:10b6:303:2a::14)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 10:32:04 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::79) by MW3PR06CA0009.outlook.office365.com
 (2603:10b6:303:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 10:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 10:32:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 03:31:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 03:31:51 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 11 May 2023
 03:31:50 -0700
Date:   Thu, 11 May 2023 13:31:49 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: memory-region property for
 tegra186-bpmp
Message-ID: <ZFzEFRBKMcUgrILn@44189d9-lcedt>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
 <20230510142248.183629-6-pdeschrijver@nvidia.com>
 <cdba4bb0-551b-a3b2-9329-139d6cda71be@linaro.org>
 <ZFyhqXhzOUKYUafA@44189d9-lcedt>
 <5d01e717-39f1-798b-dda8-022b8430dc7d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5d01e717-39f1-798b-dda8-022b8430dc7d@linaro.org>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 853d1941-2fee-43f7-c974-08db520af623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DS0pa7+Dc7L7QlMsVbc//GwSMPGaxzet3x9HXhGq8jDk7ksu8KiF5j6gO+I80s8E72+jE0UxAlQHLKIUm3BhZIDcVs5YC2udDxx0X8+L3VuOmouZJIDxn042EqrMZH/jANkE5XzUJ0j+KTEPBVNlZC0nXca7xZQ/AEr4+wOfSy+j8tyP286JyjfpOTN2MzBkvd/4M9U9v2+QnM8v0+TiFRY8q76oxct4jiBM3TV2WV18BiHs3EBGPYCE1/+AYgEvyl4fBeMP5hFAnswymCC/nNeJNhO8VaITnhLWQPMA5ImvZYc8rNgOy093rKQ5m/pyWcrEKOImskFV5C99ZrLlBK5VHLUySN8bXg/0uTcYh/hbRTU52bWfNmTGKXbzJ3I5Fx1h6kdYdK7q8pRHPFsg0Kbx5Ghs9swQnM8VXjFBo9Lk0SErwjE4GqZxpqdRosEe3w3HSb7pjm43BuaudzV7zLuk5mb7FpXVzmiCk3WzF8DGCDCMKEX8J1QZ/qgfn5zRyiQz7iHCGPv2QZx7Ksjovx+IZGUjuBGg7yvKn8aIONFtkiLd+ywUPXTmCnEckMKclmhtihgNRpfaXGC7ME40q8ekNDn1dLgyWmaHZf2doIqfb1mcn5u5q1bpswucFaZ3L27Zj987+UepA/crghs1PoERAv99PJj3f7sbjtbzGLi3zTzjGTyTI9Z/gbSyAf2irRt5mFicrs/YW6yEXF4U+twmSeT/ZyF8lFTq6bkYImzJASH7QWgRTHxGHrrV30xN
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(426003)(336012)(107886003)(41300700001)(53546011)(26005)(9686003)(36860700001)(47076005)(186003)(478600001)(54906003)(40460700003)(6916009)(82740400003)(4326008)(40480700001)(70206006)(70586007)(7636003)(356005)(316002)(5660300002)(33716001)(86362001)(4744005)(2906002)(82310400005)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 10:32:03.4185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853d1941-2fee-43f7-c974-08db520af623
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:03:24AM +0200, Krzysztof Kozlowski wrote:
> On 11/05/2023 10:04, Peter De Schrijver wrote:
> > On Wed, May 10, 2023 at 05:01:55PM +0200, Krzysztof Kozlowski wrote:
> >> On 10/05/2023 16:22, Peter De Schrijver wrote:
> >>> Add memory-region property to the tegra186-bpmp binding to support
> >>> DRAM MRQ GSCs.
> >>>
> >>> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>
> >>> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> >>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>> ---
> >>
> >> Also no changelog. Since I do not see improvements after Thierry
> >> comments I assume you send the same.
> >>
> > 
> > The changelog is in the cover letter. I will send it to you next
> > iteration.
> 
> I got only few patches, rest is missing including changelog. Thus it is
> the same as it did not exist.
> 

Do you want all of them? Some people seem to object to that so I didn't
send them to all people.

Peter.
