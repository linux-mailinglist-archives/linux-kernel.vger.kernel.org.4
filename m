Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B660492E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJSO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJSO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:26:34 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D3159960;
        Wed, 19 Oct 2022 07:11:16 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WR2NCsaypdQab/OrqnEv+VKQBNxkKlQUyz7iEWixDpiMlJ8336p2fmVu9+Gp6yobDYjaqLkX5QR9uJN7fQmIidN9utEUcuT4K0krXfA6Pw2/2m17j5vd41F0zVxg7ks9L48BeyvHcNDmjdFudv0mllxiWtwCM0JM/FnT8r0UMfdNIEk/iW4DfkY9ZV8mFTOtjnrJ0HibLfGt2pH8KlNVAMkjIg8knq7IuEuoV3yIgOsaDUNAPskiry+LJVffMY8ATQVUX9IusFpSt2KibXzaEPGCcKp2AayTl/HFJ02f3+GWVRnE4iOzabN8VS7eD+ksIgdP4kfIH6s4fGhme6xOWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbSp7wFx/BIPzwZW7Ro6UGg//I9VkJLoxukLL3DZJg4=;
 b=UyrFAiuXfyC5q0XrF1TUCCvxUWP1jiW+imvwiqw6jkZ7RQmQQbJ7wayrKQzDyUjItrDLwpnlN7ORD3cYneuw/xL2EuyphJk7vp8TKUp38QHwQyl9ZPpa1HB8bLQNcEixI40OOsM67Chu22ll5/FKKDFZuNa8r0+wyJFtafbSH2qcV4SIL9sdsHQ0guLZQFDesLdgzUdKudINk6WswdFlpsyuki/7OFoGnthIH2qOBgbOXNODMzqPBeXHcXQjabP3MPFel4x5H8IeuWuhrU5Lpy+bF4n+rAKCaF5FSrO2ReAbFFP3rrkh6JMTzo7oio3hjUENQM/EgvA/d2tRSicM+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbSp7wFx/BIPzwZW7Ro6UGg//I9VkJLoxukLL3DZJg4=;
 b=aI9WtaCQU9RVMIyhX9kHFml2ZWxi4i+22cbzhinK7eoMgZgUt5AnXWli9556m5lTgpPn1uCPYkjtLSZOsd/YESWjaGye2AFEV5LruhpBd6ks185uDxRQoReou2G0Su2/QPCs7oRWTWY/j55xKVa2x/Pmls+SZ8EWI7oRw7F8Yhk=
Received: from AM6P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::33)
 by GVXPR08MB7848.eurprd08.prod.outlook.com (2603:10a6:150:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 14:02:36 +0000
Received: from AM7EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::8a) by AM6P191CA0020.outlook.office365.com
 (2603:10a6:209:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 14:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT059.mail.protection.outlook.com (100.127.140.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 19 Oct 2022 14:02:36 +0000
Received: ("Tessian outbound b4aebcc5bc64:v130"); Wed, 19 Oct 2022 14:02:36 +0000
X-CR-MTA-TID: 64aa7808
Received: from d8441345ee00.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E0605DEB-BAD3-4727-9C6F-D1309FC0A85F.1;
        Wed, 19 Oct 2022 14:02:25 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d8441345ee00.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 19 Oct 2022 14:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbLO/ateni9UU6EY0XQGmUxrevz+aKkZuNDUx6VJsQ4ZjXjAMxBUo5QlqW9Nsae4Yd9SihKA7kqN9jcKI8WpO9aSQtJxn/vhxRHpeMS3so/CcEIqJtQbFB+OEaNLfR2Y306NasV7lDqkcjiCoNz7rLwSGClA+e+gxVITGwL+mD4IFSB5oVXgdWFvfJ8uxHI+e+UCu05kBgxYVd8lN6mtqSG2QSPIEiE+iI6H5Mzkx/Ba1vg9ri66lmp8p5XC1Q1aIrAul3MWf53rj98gwmOfOBBkzOscPk7zQoH7jytKY12giPzCADaJI6cegWG1cl8u3JYmrjBwWtJNW3llTP5s7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbSp7wFx/BIPzwZW7Ro6UGg//I9VkJLoxukLL3DZJg4=;
 b=I4ikpzvWkjYEOc1fVZLv7iWP2vC+SJMK79/8h1POSGSkC2fT+OKqUpGFQ9Z6IfjaO2t4PwCmRaFWxqE52FAvE21lfzZJjZYKykqedEBpZb4XbTqptNZyJpmG6ODHQreTzUaRxikOWwINXkwQt+pwGrFyGAgHnDSkrRF7F4pZIgQgkUVRb9S4Hzafm576NRqyxfI2zKSn0W/uOytfbwMqGz1BpJFRrZ+SKU4Ge8wg91r4U557gpMGiXTG01q8dbCXDFbYXCG78ZC3SmqLEUhfqat9bcgQDN8nVJMg82MDJJYAaGO9rf2bcgB/7Fa8mHjXdAWVVM6zyMrEZfvKCorEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbSp7wFx/BIPzwZW7Ro6UGg//I9VkJLoxukLL3DZJg4=;
 b=aI9WtaCQU9RVMIyhX9kHFml2ZWxi4i+22cbzhinK7eoMgZgUt5AnXWli9556m5lTgpPn1uCPYkjtLSZOsd/YESWjaGye2AFEV5LruhpBd6ks185uDxRQoReou2G0Su2/QPCs7oRWTWY/j55xKVa2x/Pmls+SZ8EWI7oRw7F8Yhk=
Received: from AS2PR08MB8576.eurprd08.prod.outlook.com (2603:10a6:20b:55f::9)
 by AS8PR08MB5960.eurprd08.prod.outlook.com (2603:10a6:20b:29a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 14:02:22 +0000
Received: from AS2PR08MB8576.eurprd08.prod.outlook.com
 ([fe80::d74b:4ace:cd2:9ed2]) by AS2PR08MB8576.eurprd08.prod.outlook.com
 ([fe80::d74b:4ace:cd2:9ed2%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 14:02:22 +0000
From:   "Michael Williams (ATG)" <Michael.Williams@arm.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "vsethi@nvidia.com" <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU
 driver
Thread-Topic: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight
 PMU driver
Thread-Index: AQHY03egNnZo4Ke12k2QpGCWYGqgka4V3t+w
Date:   Wed, 19 Oct 2022 14:02:15 +0000
Deferred-Delivery: Wed, 19 Oct 2022 14:01:51 +0000
Message-ID: <AS2PR08MB85766C82C6032039EEC245908A2B9@AS2PR08MB8576.eurprd08.prod.outlook.com>
References: <20220928201830.45637-1-bwicaksono@nvidia.com>
 <20220928201830.45637-2-bwicaksono@nvidia.com>
In-Reply-To: <20220928201830.45637-2-bwicaksono@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E2E835A46E938D44810254FD69433633.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS2PR08MB8576:EE_|AS8PR08MB5960:EE_|AM7EUR03FT059:EE_|GVXPR08MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e0f417-1135-48d0-7617-08dab1da93be
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3W8fj7AgL3d/ANXUdM4SCneb8iJJm5WZj/KBkJNNqaDsZN9aHPBPykUZNKc+ra13UOhw/jwm+oVAuzWBxjRfdGCxFL/H7ynTELucFaPPFk/jh/2W5fH/RNoAsmh0bEGEi6yzjJc3AasUO40klOAfrYhOUaXc3WDkSCmVEULiFvjnPd+fknTJTTFLiXrPEkM/xZHLR8HGExMA7ecnnRtzjcfvzY0JL5Alhh+/4MMZBV9+/voGWXVOiexjJ8i8f+nEfeDlYhs746mALvggexPYehtfd3lQrjQWGGPVoFu5J31bvXEoz1iWXCqndNHxorsPQXVS0Prfd0ye3/xHFxIDpYPSgwLNCF8hP6zMjaBGj+ibKzvXMphMiRJcfGFSPdLxWlCqPzivl8Xe+7kRjc0trMyGfF1zK8eBV0RDUmb4gEenrLr8Ei4G5o+mSbplLgPN5Vhv/fwy5Pk0uE7huvoKtrqADCV0ewMsUb3M7vzdnVw6y0Rv/uANbbh+lXhmUKURcll5X+PKyFvLgi+mrNNFTxPlh9DvJFwBFINc24EgO5wf/h31rzbaAzT3PJuSD2e8ZcothqvL9R7Q3ZXfvqQIdHQv6Ia5p0OlBEc4xvrwaHswebjGYc+RwF4m7+OeP84ne5EAXqiaE+1/dHz5oFaFVO35Q1VemnX15ju5L28e0ZHn9G+VaHBKQIuZ/JN64PEnUzuwmzPTJyzo0v/dPHPcXdEB7qWPlltuEDHXG/ZM5/LiDcVlCTI0XEoGS36OL21Et0yMrrs6YXIO48nR65V+PuYm5wLoREZRJF6pbeRch2V0Mio/muJ8mAWPUB0yUFU/sAaFFehGrcTZPMeonGh8hQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8576.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(66946007)(6666004)(478600001)(33656002)(52536014)(8936002)(6506007)(41300700001)(8676002)(122000001)(4326008)(316002)(76116006)(6636002)(66556008)(54906003)(71200400001)(7696005)(55016003)(66476007)(38070700005)(186003)(110136005)(38100700002)(86362001)(83380400001)(9686003)(53546011)(2906002)(966005)(66446008)(5660300002)(64756008)(7416002)(30864003)(579004)(559001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5960
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c5d43f1-eed2-4670-4e1c-08dab1da8b51
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldNIG+SmPwfPWSnXR1QhNNEho7cv/vxFmYsyUCuMd3DQA7QFvDvq/lySOV85PY0yCiCd2bewV9PMu0HRSROAFqA/ZXDLTeRTTFAIfFGK8wLAvkMmd9jh0uuoPIQ1xG2c1PhnQDZdFq7ZlpCsngKsBtvZBr7BQeYZCjCmWbSpVg+IHkHxc4uyz7X7/DA0IRHXApFdeoGmB5vV9Xy/Tu2M1ZJWej5+KofNqelkMGuoWKLAciVIb3boHgQwq1Tru4NNDUOOn11RtZFg3vV1VwPj+fG1VTIhhX1jEgR8EUMCCUMI4CeADEqXe9wwu68RBKNlLNQSeQKJHC1rOTslHZG450/iEqrlarrzUEdJ9oblbXXlnA303R7H2omNZZAWUXdPMuB9vv2j68Qb8JukVJludL4flFk1/yHfW3XKm+GWlX9l47Esxqbrl+cyTkyuRZL+CtaHN8+zcNZQacqNKSs6adpkMZzvGMs/VjMRbpJvuOVHMQvNV/Hpon7ps1dutcEDlHeBFV2jbCdsqMAAnAbNsXcBi0dTd2hsV6NNO+DZtLB4R+s3hjawuXVCMgX/NQZELV8Dg1ruYW/FxQC9HGYoGbMin7HYBTYwjKqN39Y74tLeUe8+Ab3qQYWErhkqkcdLY9PWG9sB4DOG9/2qwcN97SQ6Ol2JlvSx6Lr0H9hvB5e9HWTWPuzsv6EK8YYSBI7Gd9pUbLuAm5JpqhDA9GGlvZDgaKece10TzdmqPgZEyUi4eOPAF1aSdoy1XirXW9aP93ExXNPwFhe1f+cqCZHxxc/RMRCHuzsl1y864FJxuugbQJPZUuMuMe+r+ACjJADO7OIo9GjuXjnz0EJ3MuQHtA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(81166007)(82310400005)(82740400003)(356005)(40460700003)(450100002)(55016003)(86362001)(40480700001)(70206006)(70586007)(6666004)(33656002)(83380400001)(107886003)(110136005)(316002)(6636002)(54906003)(30864003)(8676002)(5660300002)(966005)(336012)(2906002)(186003)(478600001)(8936002)(7696005)(4326008)(52536014)(9686003)(53546011)(41300700001)(26005)(6506007)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 14:02:36.4972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e0f417-1135-48d0-7617-08dab1da93be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7848
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an FYI to those reading this patch, the Arm CoreSight PMU architecture s=
pecification Besar refers to below has today been updated with the latest r=
evision (A.b). This adds some new functionality and a "64-bit only" variant=
 of the programmers' model.

Regards,

Mike.

> -----Original Message-----
> From: Besar Wicaksono <bwicaksono@nvidia.com>
> Sent: 28 September 2022 21:18
> To: Suzuki Poulose <Suzuki.Poulose@arm.com>; Robin Murphy
> <Robin.Murphy@arm.com>; Catalin Marinas <Catalin.Marinas@arm.com>;
> will@kernel.org; Mark Rutland <Mark.Rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-tegra@vger.kernel.org; Sudeep Holla <Sudeep.Holla@arm.com>; Thanu
> Rangarajan <Thanu.Rangarajan@arm.com>; Michael Williams (ATG)
> <Michael.Williams@arm.com>; treding@nvidia.com; jonathanh@nvidia.com;
> vsethi@nvidia.com; mathieu.poirier@linaro.org; mike.leach@linaro.org;
> leo.yan@linaro.org; Besar Wicaksono <bwicaksono@nvidia.com>
> Subject: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight PM=
U
> driver
>=20
> Add support for ARM CoreSight PMU driver framework and interfaces.
> The driver provides generic implementation to operate uncore PMU based on
> ARM CoreSight PMU architecture. The driver also provides interface to get
> vendor/implementation specific information, for example event attributes
> and formating.
>=20
> The specification used in this implementation can be found below:
>  * ACPI Arm Performance Monitoring Unit table:
>         https://developer.arm.com/documentation/den0117/latest
>  * ARM Coresight PMU architecture:
>         https://developer.arm.com/documentation/ihi0091/latest
>=20
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  arch/arm64/configs/defconfig       |    1 +
>  drivers/perf/Kconfig               |    2 +
>  drivers/perf/Makefile              |    1 +
>  drivers/perf/arm_cspmu/Kconfig     |   13 +
>  drivers/perf/arm_cspmu/Makefile    |    6 +
>  drivers/perf/arm_cspmu/arm_cspmu.c | 1276 ++++++++++++++++++++++++++++
> drivers/perf/arm_cspmu/arm_cspmu.h |  151 ++++
>  7 files changed, 1450 insertions(+)
>  create mode 100644 drivers/perf/arm_cspmu/Kconfig  create mode 100644
> drivers/perf/arm_cspmu/Makefile  create mode 100644
> drivers/perf/arm_cspmu/arm_cspmu.c
>  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..ee31c9159a5b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1212,6 +1212,7 @@ CONFIG_PHY_UNIPHIER_USB3=3Dy  CONFIG_PHY_TEGRA_XUSB=
=3Dy
> CONFIG_PHY_AM654_SERDES=3Dm  CONFIG_PHY_J721E_WIZ=3Dm
> +CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=3Dy
>  CONFIG_ARM_SMMU_V3_PMU=3Dm
>  CONFIG_FSL_IMX8_DDR_PMU=3Dm
>  CONFIG_QCOM_L2_PMU=3Dy
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig index
> 1e2d69453771..c94d3601eb48 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
>  	  Enable perf support for Marvell DDR Performance monitoring
>  	  event on CN10K platform.
>=20
> +source "drivers/perf/arm_cspmu/Kconfig"
> +
>  endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile index
> 57a279c61df5..3bc9323f0965 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) +=3D arm_dmc620_pmu.o
>  obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) +=3D marvell_cn10k_tad_pmu.o
>  obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) +=3D marvell_cn10k_ddr_pmu.o
>  obj-$(CONFIG_APPLE_M1_CPU_PMU) +=3D apple_m1_cpu_pmu.o
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D arm_cspmu/
> diff --git a/drivers/perf/arm_cspmu/Kconfig
> b/drivers/perf/arm_cspmu/Kconfig new file mode 100644 index
> 000000000000..c2c56ecafccb
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> +
> +config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	tristate "ARM Coresight Architecture PMU"
> +	depends on ACPI
> +	depends on ACPI_APMT || COMPILE_TEST
> +	help
> +	  Provides support for performance monitoring unit (PMU) devices
> +	  based on ARM CoreSight PMU architecture. Note that this PMU
> +	  architecture does not have relationship with the ARM CoreSight
> +	  Self-Hosted Tracing.
> diff --git a/drivers/perf/arm_cspmu/Makefile
> b/drivers/perf/arm_cspmu/Makefile new file mode 100644 index
> 000000000000..cdc3455f74d8
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -0,0 +1,6 @@
> +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> +#
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D \
> +	arm_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> new file mode 100644
> index 000000000000..0fa5f29bf1c6
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -0,0 +1,1276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM CoreSight Architecture PMU driver.
> + *
> + * This driver adds support for uncore PMU based on ARM CoreSight
> +Performance
> + * Monitoring Unit Architecture. The PMU is accessible via MMIO
> +registers and
> + * like other uncore PMUs, it does not support process specific events
> +and
> + * cannot be used in sampling mode.
> + *
> + * This code is based on other uncore PMUs like ARM DSU PMU. It
> +provides a
> + * generic implementation to operate the PMU according to CoreSight PMU
> + * architecture and ACPI ARM PMU table (APMT) documents below:
> + *   - ARM CoreSight PMU architecture document number: ARM IHI 0091 A.a-
> 00bet0.
> + *   - APMT document number: ARM DEN0117.
> + *
> + * The user should refer to the vendor technical documentation to get
> +details
> + * about the supported events.
> + *
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/ctype.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h> #include <linux/module.h>
> +#include <linux/perf_event.h> #include <linux/platform_device.h>
> +#include <acpi/processor.h>
> +
> +#include "arm_cspmu.h"
> +
> +#define PMUNAME "arm_cspmu"
> +#define DRVNAME "arm-cs-arch-pmu"
> +
> +#define ARM_CSPMU_CPUMASK_ATTR(_name, _config)			\
> +	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_cpumask_show,	\
> +				(unsigned long)_config)
> +
> +/*
> + * CoreSight PMU Arch register offsets.
> + */
> +#define PMEVCNTR_LO					0x0
> +#define PMEVCNTR_HI					0x4
> +#define PMEVTYPER					0x400
> +#define PMCCFILTR					0x47C
> +#define PMEVFILTR					0xA00
> +#define PMCNTENSET					0xC00
> +#define PMCNTENCLR					0xC20
> +#define PMINTENSET					0xC40
> +#define PMINTENCLR					0xC60
> +#define PMOVSCLR					0xC80
> +#define PMOVSSET					0xCC0
> +#define PMCFGR						0xE00
> +#define PMCR						0xE04
> +#define PMIIDR						0xE08
> +
> +/* PMCFGR register field */
> +#define PMCFGR_NCG					GENMASK(31, 28)
> +#define PMCFGR_HDBG					BIT(24)
> +#define PMCFGR_TRO					BIT(23)
> +#define PMCFGR_SS					BIT(22)
> +#define PMCFGR_FZO					BIT(21)
> +#define PMCFGR_MSI					BIT(20)
> +#define PMCFGR_UEN					BIT(19)
> +#define PMCFGR_NA					BIT(17)
> +#define PMCFGR_EX					BIT(16)
> +#define PMCFGR_CCD					BIT(15)
> +#define PMCFGR_CC					BIT(14)
> +#define PMCFGR_SIZE					GENMASK(13, 8)
> +#define PMCFGR_N					GENMASK(7, 0)
> +
> +/* PMCR register field */
> +#define PMCR_TRO					BIT(11)
> +#define PMCR_HDBG					BIT(10)
> +#define PMCR_FZO					BIT(9)
> +#define PMCR_NA						BIT(8)
> +#define PMCR_DP						BIT(5)
> +#define PMCR_X						BIT(4)
> +#define PMCR_D						BIT(3)
> +#define PMCR_C						BIT(2)
> +#define PMCR_P						BIT(1)
> +#define PMCR_E						BIT(0)
> +
> +/* Each SET/CLR register supports up to 32 counters. */
> +#define ARM_CSPMU_SET_CLR_COUNTER_SHIFT		5
> +#define ARM_CSPMU_SET_CLR_COUNTER_NUM		\
> +	(1 << ARM_CSPMU_SET_CLR_COUNTER_SHIFT)
> +
> +/* Convert counter idx into SET/CLR register number. */
> +#define COUNTER_TO_SET_CLR_ID(idx)			\
> +	(idx >> ARM_CSPMU_SET_CLR_COUNTER_SHIFT)
> +
> +/* Convert counter idx into SET/CLR register bit. */
> +#define COUNTER_TO_SET_CLR_BIT(idx)			\
> +	(idx & (ARM_CSPMU_SET_CLR_COUNTER_NUM - 1))
> +
> +#define ARM_CSPMU_ACTIVE_CPU_MASK		0x0
> +#define ARM_CSPMU_ASSOCIATED_CPU_MASK		0x1
> +
> +/* Check if field f in flags is set with value v */ #define
> +CHECK_APMT_FLAG(flags, f, v) \
> +	((flags & (ACPI_APMT_FLAGS_ ## f)) =3D=3D (ACPI_APMT_FLAGS_ ## f ## _ #=
#
> +v))
> +
> +/* Check and use default if implementer doesn't provide attribute
> callback */
> +#define CHECK_DEFAULT_IMPL_OPS(ops, callback)			\
> +	do {							\
> +		if (!ops->callback)				\
> +			ops->callback =3D arm_cspmu_ ## callback;	\
> +	} while (0)
> +
> +/*
> + * Maximum poll count for reading counter value using high-low-high
> sequence.
> + */
> +#define HILOHI_MAX_POLL	1000
> +
> +static unsigned long arm_cspmu_cpuhp_state;
> +
> +/*
> + * In CoreSight PMU architecture, all of the MMIO registers are 32-bit
> +except
> + * counter register. The counter register can be implemented as 32-bit
> +or 64-bit
> + * register depending on the value of PMCFGR.SIZE field. For 64-bit
> +access,
> + * single-copy 64-bit atomic support is implementation defined. APMT
> +node flag
> + * is used to identify if the PMU supports 64-bit single copy atomic.
> +If 64-bit
> + * single copy atomic is not supported, the driver treats the register
> +as a pair
> + * of 32-bit register.
> + */
> +
> +/*
> + * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi
> sequence.
> + */
> +static u64 read_reg64_hilohi(const void __iomem *addr, u32
> +max_poll_count) {
> +	u32 val_lo, val_hi;
> +	u64 val;
> +
> +	/* Use high-low-high sequence to avoid tearing */
> +	do {
> +		if (max_poll_count-- =3D=3D 0) {
> +			pr_err("ARM CSPMU: timeout hi-low-high sequence\n");
> +			return 0;
> +		}
> +
> +		val_hi =3D readl(addr + 4);
> +		val_lo =3D readl(addr);
> +	} while (val_hi !=3D readl(addr + 4));
> +
> +	val =3D (((u64)val_hi << 32) | val_lo);
> +
> +	return val;
> +}
> +
> +/* Check if PMU supports 64-bit single copy atomic. */ static inline
> +bool supports_64bit_atomics(const struct arm_cspmu *cspmu) {
> +	return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC, SUPP); }
> +
> +/* Check if cycle counter is supported. */ static inline bool
> +supports_cycle_counter(const struct arm_cspmu *cspmu) {
> +	return (cspmu->pmcfgr & PMCFGR_CC);
> +}
> +
> +/* Get counter size, which is (PMCFGR_SIZE + 1). */ static inline u32
> +counter_size(const struct arm_cspmu *cspmu) {
> +	return FIELD_GET(PMCFGR_SIZE, cspmu->pmcfgr) + 1; }
> +
> +/* Get counter mask. */
> +static inline u64 counter_mask(const struct arm_cspmu *cspmu) {
> +	return GENMASK_ULL(counter_size(cspmu) - 1, 0); }
> +
> +/* Check if counter is implemented as 64-bit register. */ static inline
> +bool use_64b_counter_reg(const struct arm_cspmu *cspmu) {
> +	return (counter_size(cspmu) > 32);
> +}
> +
> +ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
> +				struct device_attribute *attr, char *buf) {
> +	struct dev_ext_attribute *eattr =3D
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "event=3D0x%llx\n",
> +			  (unsigned long long)eattr->var);
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_event_show);
> +
> +/* Default event list. */
> +static struct attribute *arm_cspmu_event_attrs[] =3D {
> +	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute **
> +arm_cspmu_get_event_attrs(const struct arm_cspmu *cspmu) {
> +	return arm_cspmu_event_attrs;
> +}
> +
> +static umode_t
> +arm_cspmu_event_attr_is_visible(struct kobject *kobj,
> +				struct attribute *attr, int unused) {
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(dev_get_drvdata(dev));
> +	struct perf_pmu_events_attr *eattr;
> +
> +	eattr =3D container_of(attr, typeof(*eattr), attr.attr);
> +
> +	/* Hide cycle event if not supported */
> +	if (!supports_cycle_counter(cspmu) &&
> +	    eattr->id =3D=3D ARM_CSPMU_EVT_CYCLES_DEFAULT)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
> +ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct dev_ext_attribute *eattr =3D
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var); }
> +EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_format_show);
> +
> +static struct attribute *arm_cspmu_format_attrs[] =3D {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	ARM_CSPMU_FORMAT_FILTER_ATTR,
> +	NULL,
> +};
> +
> +static struct attribute **
> +arm_cspmu_get_format_attrs(const struct arm_cspmu *cspmu) {
> +	return arm_cspmu_format_attrs;
> +}
> +
> +static u32 arm_cspmu_event_type(const struct perf_event *event) {
> +	return event->attr.config & ARM_CSPMU_EVENT_MASK; }
> +
> +static bool arm_cspmu_is_cycle_counter_event(const struct perf_event
> +*event) {
> +	return (event->attr.config =3D=3D ARM_CSPMU_EVT_CYCLES_DEFAULT); }
> +
> +static u32 arm_cspmu_event_filter(const struct perf_event *event) {
> +	return event->attr.config1 & ARM_CSPMU_FILTER_MASK; }
> +
> +static ssize_t arm_cspmu_identifier_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *page)
> +{
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(page, "%s\n", cspmu->identifier); }
> +
> +static struct device_attribute arm_cspmu_identifier_attr =3D
> +	__ATTR(identifier, 0444, arm_cspmu_identifier_show, NULL);
> +
> +static struct attribute *arm_cspmu_identifier_attrs[] =3D {
> +	&arm_cspmu_identifier_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group arm_cspmu_identifier_attr_group =3D {
> +	.attrs =3D arm_cspmu_identifier_attrs,
> +};
> +
> +static const char *arm_cspmu_get_identifier(const struct arm_cspmu
> +*cspmu) {
> +	const char *identifier =3D
> +		devm_kasprintf(cspmu->dev, GFP_KERNEL, "%x",
> +			       cspmu->impl.pmiidr);
> +	return identifier;
> +}
> +
> +static const char *arm_cspmu_type_str[ACPI_APMT_NODE_TYPE_COUNT] =3D {
> +	"mc",
> +	"smmu",
> +	"pcie",
> +	"acpi",
> +	"cache",
> +};
> +
> +static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu) {
> +	struct device *dev;
> +	struct acpi_apmt_node *apmt_node;
> +	u8 pmu_type;
> +	char *name;
> +	char acpi_hid_string[ACPI_ID_LEN] =3D { 0 };
> +	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] =3D { 0 };
> +
> +	dev =3D cspmu->dev;
> +	apmt_node =3D cspmu->apmt_node;
> +	pmu_type =3D apmt_node->type;
> +
> +	if (pmu_type >=3D ACPI_APMT_NODE_TYPE_COUNT) {
> +		dev_err(dev, "unsupported PMU type-%u\n", pmu_type);
> +		return NULL;
> +	}
> +
> +	if (pmu_type =3D=3D ACPI_APMT_NODE_TYPE_ACPI) {
> +		memcpy(acpi_hid_string,
> +			&apmt_node->inst_primary,
> +			sizeof(apmt_node->inst_primary));
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
> +				      arm_cspmu_type_str[pmu_type],
> +				      acpi_hid_string,
> +				      apmt_node->inst_secondary);
> +	} else {
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%d", PMUNAME,
> +				      arm_cspmu_type_str[pmu_type],
> +				      atomic_fetch_inc(&pmu_idx[pmu_type]));
> +	}
> +
> +	return name;
> +}
> +
> +static ssize_t arm_cspmu_cpumask_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct pmu *pmu =3D dev_get_drvdata(dev);
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(pmu);
> +	struct dev_ext_attribute *eattr =3D
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	unsigned long mask_id =3D (unsigned long)eattr->var;
> +	const cpumask_t *cpumask;
> +
> +	switch (mask_id) {
> +	case ARM_CSPMU_ACTIVE_CPU_MASK:
> +		cpumask =3D &cspmu->active_cpu;
> +		break;
> +	case ARM_CSPMU_ASSOCIATED_CPU_MASK:
> +		cpumask =3D &cspmu->associated_cpus;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return cpumap_print_to_pagebuf(true, buf, cpumask); }
> +
> +static struct attribute *arm_cspmu_cpumask_attrs[] =3D {
> +	ARM_CSPMU_CPUMASK_ATTR(cpumask, ARM_CSPMU_ACTIVE_CPU_MASK),
> +	ARM_CSPMU_CPUMASK_ATTR(associated_cpus,
> ARM_CSPMU_ASSOCIATED_CPU_MASK),
> +	NULL,
> +};
> +
> +static struct attribute_group arm_cspmu_cpumask_attr_group =3D {
> +	.attrs =3D arm_cspmu_cpumask_attrs,
> +};
> +
> +struct impl_match {
> +	u32 pmiidr;
> +	u32 mask;
> +	int (*impl_init_ops)(struct arm_cspmu *cspmu); };
> +
> +static const struct impl_match impl_match[] =3D {
> +	{}
> +};
> +
> +static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu) {
> +	int ret;
> +	struct acpi_apmt_node *apmt_node =3D cspmu->apmt_node;
> +	struct arm_cspmu_impl_ops *impl_ops =3D &cspmu->impl.ops;
> +	const struct impl_match *match =3D impl_match;
> +
> +	/*
> +	 * Get PMU implementer and product id from APMT node.
> +	 * If APMT node doesn't have implementer/product id, try get it
> +	 * from PMIIDR.
> +	 */
> +	cspmu->impl.pmiidr =3D
> +		(apmt_node->impl_id) ? apmt_node->impl_id :
> +				       readl(cspmu->base0 + PMIIDR);
> +
> +	/* Find implementer specific attribute ops. */
> +	for (; match->pmiidr; match++) {
> +		const u32 mask =3D match->mask;
> +
> +		if ((match->pmiidr & mask) =3D=3D (cspmu->impl.pmiidr & mask)) {
> +			ret =3D match->impl_init_ops(cspmu);
> +			if (ret)
> +				return ret;
> +
> +			break;
> +		}
> +	}
> +
> +	/* Use default callbacks if implementer doesn't provide one. */
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_format_attrs);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_identifier);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_name);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, is_cycle_counter_event);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
> +
> +	return 0;
> +}
> +
> +static struct attribute_group *
> +arm_cspmu_alloc_event_attr_group(struct arm_cspmu *cspmu) {
> +	struct attribute_group *event_group;
> +	struct device *dev =3D cspmu->dev;
> +	const struct arm_cspmu_impl_ops *impl_ops =3D &cspmu->impl.ops;
> +
> +	event_group =3D
> +		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
> +	if (!event_group)
> +		return NULL;
> +
> +	event_group->name =3D "events";
> +	event_group->attrs =3D impl_ops->get_event_attrs(cspmu);
> +	event_group->is_visible =3D impl_ops->event_attr_is_visible;
> +
> +	return event_group;
> +}
> +
> +static struct attribute_group *
> +arm_cspmu_alloc_format_attr_group(struct arm_cspmu *cspmu) {
> +	struct attribute_group *format_group;
> +	struct device *dev =3D cspmu->dev;
> +
> +	format_group =3D
> +		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
> +	if (!format_group)
> +		return NULL;
> +
> +	format_group->name =3D "format";
> +	format_group->attrs =3D cspmu->impl.ops.get_format_attrs(cspmu);
> +
> +	return format_group;
> +}
> +
> +static struct attribute_group **
> +arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu) {
> +	struct attribute_group **attr_groups =3D NULL;
> +	struct device *dev =3D cspmu->dev;
> +	const struct arm_cspmu_impl_ops *impl_ops =3D &cspmu->impl.ops;
> +	int ret;
> +
> +	ret =3D arm_cspmu_init_impl_ops(cspmu);
> +	if (ret)
> +		return NULL;
> +
> +	cspmu->identifier =3D impl_ops->get_identifier(cspmu);
> +	cspmu->name =3D impl_ops->get_name(cspmu);
> +
> +	if (!cspmu->identifier || !cspmu->name)
> +		return NULL;
> +
> +	attr_groups =3D devm_kcalloc(dev, 5, sizeof(struct attribute_group *),
> +				   GFP_KERNEL);
> +	if (!attr_groups)
> +		return NULL;
> +
> +	attr_groups[0] =3D arm_cspmu_alloc_event_attr_group(cspmu);
> +	attr_groups[1] =3D arm_cspmu_alloc_format_attr_group(cspmu);
> +	attr_groups[2] =3D &arm_cspmu_identifier_attr_group;
> +	attr_groups[3] =3D &arm_cspmu_cpumask_attr_group;
> +
> +	if (!attr_groups[0] || !attr_groups[1])
> +		return NULL;
> +
> +	return attr_groups;
> +}
> +
> +static inline void arm_cspmu_reset_counters(struct arm_cspmu *cspmu) {
> +	u32 pmcr =3D 0;
> +
> +	pmcr |=3D PMCR_P;
> +	pmcr |=3D PMCR_C;
> +	writel(pmcr, cspmu->base0 + PMCR);
> +}
> +
> +static inline void arm_cspmu_start_counters(struct arm_cspmu *cspmu) {
> +	writel(PMCR_E, cspmu->base0 + PMCR);
> +}
> +
> +static inline void arm_cspmu_stop_counters(struct arm_cspmu *cspmu) {
> +	writel(0, cspmu->base0 + PMCR);
> +}
> +
> +static void arm_cspmu_enable(struct pmu *pmu) {
> +	bool disabled;
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(pmu);
> +
> +	disabled =3D bitmap_empty(cspmu->hw_events.used_ctrs,
> +				cspmu->num_logical_ctrs);
> +
> +	if (disabled)
> +		return;
> +
> +	arm_cspmu_start_counters(cspmu);
> +}
> +
> +static void arm_cspmu_disable(struct pmu *pmu) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(pmu);
> +
> +	arm_cspmu_stop_counters(cspmu);
> +}
> +
> +static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events=
,
> +				struct perf_event *event)
> +{
> +	int idx;
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +
> +	if (supports_cycle_counter(cspmu)) {
> +		if (cspmu->impl.ops.is_cycle_counter_event(event)) {
> +			/* Search for available cycle counter. */
> +			if (test_and_set_bit(cspmu->cycle_counter_logical_idx,
> +					     hw_events->used_ctrs))
> +				return -EAGAIN;
> +
> +			return cspmu->cycle_counter_logical_idx;
> +		}
> +
> +		/*
> +		 * Search a regular counter from the used counter bitmap.
> +		 * The cycle counter divides the bitmap into two parts. Search
> +		 * the first then second half to exclude the cycle counter
> bit.
> +		 */
> +		idx =3D find_first_zero_bit(hw_events->used_ctrs,
> +					  cspmu->cycle_counter_logical_idx);
> +		if (idx >=3D cspmu->cycle_counter_logical_idx) {
> +			idx =3D find_next_zero_bit(
> +				hw_events->used_ctrs,
> +				cspmu->num_logical_ctrs,
> +				cspmu->cycle_counter_logical_idx + 1);
> +		}
> +	} else {
> +		idx =3D find_first_zero_bit(hw_events->used_ctrs,
> +					  cspmu->num_logical_ctrs);
> +	}
> +
> +	if (idx >=3D cspmu->num_logical_ctrs)
> +		return -EAGAIN;
> +
> +	set_bit(idx, hw_events->used_ctrs);
> +
> +	return idx;
> +}
> +
> +static bool arm_cspmu_validate_event(struct pmu *pmu,
> +				 struct arm_cspmu_hw_events *hw_events,
> +				 struct perf_event *event)
> +{
> +	if (is_software_event(event))
> +		return true;
> +
> +	/* Reject groups spanning multiple HW PMUs. */
> +	if (event->pmu !=3D pmu)
> +		return false;
> +
> +	return (arm_cspmu_get_event_idx(hw_events, event) >=3D 0); }
> +
> +/*
> + * Make sure the group of events can be scheduled at once
> + * on the PMU.
> + */
> +static bool arm_cspmu_validate_group(struct perf_event *event) {
> +	struct perf_event *sibling, *leader =3D event->group_leader;
> +	struct arm_cspmu_hw_events fake_hw_events;
> +
> +	if (event->group_leader =3D=3D event)
> +		return true;
> +
> +	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
> +
> +	if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events, leader))
> +		return false;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events,
> +						  sibling))
> +			return false;
> +	}
> +
> +	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
> }
> +
> +static int arm_cspmu_event_init(struct perf_event *event) {
> +	struct arm_cspmu *cspmu;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	cspmu =3D to_arm_cspmu(event->pmu);
> +
> +	/*
> +	 * Following other "uncore" PMUs, we do not support sampling mode or
> +	 * attach to a task (per-process mode).
> +	 */
> +	if (is_sampling_event(event)) {
> +		dev_dbg(cspmu->pmu.dev,
> +			"Can't support sampling events\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
> +		dev_dbg(cspmu->pmu.dev,
> +			"Can't support per-task counters\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Make sure the CPU assignment is on one of the CPUs associated
> with
> +	 * this PMU.
> +	 */
> +	if (!cpumask_test_cpu(event->cpu, &cspmu->associated_cpus)) {
> +		dev_dbg(cspmu->pmu.dev,
> +			"Requested cpu is not associated with the PMU\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Enforce the current active CPU to handle the events in this PMU.
> */
> +	event->cpu =3D cpumask_first(&cspmu->active_cpu);
> +	if (event->cpu >=3D nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (!arm_cspmu_validate_group(event))
> +		return -EINVAL;
> +
> +	/*
> +	 * The logical counter id is tracked with
> hw_perf_event.extra_reg.idx.
> +	 * The physical counter id is tracked with hw_perf_event.idx.
> +	 * We don't assign an index until we actually place the event onto
> +	 * hardware. Use -1 to signify that we haven't decided where to put
> it
> +	 * yet.
> +	 */
> +	hwc->idx =3D -1;
> +	hwc->extra_reg.idx =3D -1;
> +	hwc->config =3D cspmu->impl.ops.event_type(event);
> +
> +	return 0;
> +}
> +
> +static inline u32 counter_offset(u32 reg_sz, u32 ctr_idx) {
> +	return (PMEVCNTR_LO + (reg_sz * ctr_idx)); }
> +
> +static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
> +{
> +	u32 offset;
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +
> +	if (use_64b_counter_reg(cspmu)) {
> +		offset =3D counter_offset(sizeof(u64), event->hw.idx);
> +
> +		writeq(val, cspmu->base1 + offset);
> +	} else {
> +		offset =3D counter_offset(sizeof(u32), event->hw.idx);
> +
> +		writel(lower_32_bits(val), cspmu->base1 + offset);
> +	}
> +}
> +
> +static u64 arm_cspmu_read_counter(struct perf_event *event) {
> +	u32 offset;
> +	const void __iomem *counter_addr;
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +
> +	if (use_64b_counter_reg(cspmu)) {
> +		offset =3D counter_offset(sizeof(u64), event->hw.idx);
> +		counter_addr =3D cspmu->base1 + offset;
> +
> +		return supports_64bit_atomics(cspmu) ?
> +			       readq(counter_addr) :
> +			       read_reg64_hilohi(counter_addr, HILOHI_MAX_POLL);
> +	}
> +
> +	offset =3D counter_offset(sizeof(u32), event->hw.idx);
> +	return readl(cspmu->base1 + offset);
> +}
> +
> +/*
> + * arm_cspmu_set_event_period: Set the period for the counter.
> + *
> + * To handle cases of extreme interrupt latency, we program
> + * the counter with half of the max count for the counters.
> + */
> +static void arm_cspmu_set_event_period(struct perf_event *event) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +	u64 val =3D counter_mask(cspmu) >> 1ULL;
> +
> +	local64_set(&event->hw.prev_count, val);
> +	arm_cspmu_write_counter(event, val);
> +}
> +
> +static void arm_cspmu_enable_counter(struct arm_cspmu *cspmu, int idx)
> +{
> +	u32 reg_id, reg_bit, inten_off, cnten_off;
> +
> +	reg_id =3D COUNTER_TO_SET_CLR_ID(idx);
> +	reg_bit =3D COUNTER_TO_SET_CLR_BIT(idx);
> +
> +	inten_off =3D PMINTENSET + (4 * reg_id);
> +	cnten_off =3D PMCNTENSET + (4 * reg_id);
> +
> +	writel(BIT(reg_bit), cspmu->base0 + inten_off);
> +	writel(BIT(reg_bit), cspmu->base0 + cnten_off); }
> +
> +static void arm_cspmu_disable_counter(struct arm_cspmu *cspmu, int idx)
> +{
> +	u32 reg_id, reg_bit, inten_off, cnten_off;
> +
> +	reg_id =3D COUNTER_TO_SET_CLR_ID(idx);
> +	reg_bit =3D COUNTER_TO_SET_CLR_BIT(idx);
> +
> +	inten_off =3D PMINTENCLR + (4 * reg_id);
> +	cnten_off =3D PMCNTENCLR + (4 * reg_id);
> +
> +	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
> +	writel(BIT(reg_bit), cspmu->base0 + inten_off); }
> +
> +static void arm_cspmu_event_update(struct perf_event *event) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 delta, prev, now;
> +
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		now =3D arm_cspmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);
> +
> +	delta =3D (now - prev) & counter_mask(cspmu);
> +	local64_add(delta, &event->count);
> +}
> +
> +static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
> +					struct hw_perf_event *hwc)
> +{
> +	u32 offset =3D PMEVTYPER + (4 * hwc->idx);
> +
> +	writel(hwc->config, cspmu->base0 + offset); }
> +
> +static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +					   struct hw_perf_event *hwc,
> +					   u32 filter)
> +{
> +	u32 offset =3D PMEVFILTR + (4 * hwc->idx);
> +
> +	writel(filter, cspmu->base0 + offset); }
> +
> +static inline void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu, u32
> +filter) {
> +	u32 offset =3D PMCCFILTR;
> +
> +	writel(filter, cspmu->base0 + offset); }
> +
> +static void arm_cspmu_start(struct perf_event *event, int pmu_flags) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 filter;
> +
> +	/* We always reprogram the counter */
> +	if (pmu_flags & PERF_EF_RELOAD)
> +		WARN_ON(!(hwc->state & PERF_HES_UPTODATE));
> +
> +	arm_cspmu_set_event_period(event);
> +
> +	filter =3D cspmu->impl.ops.event_filter(event);
> +
> +	if (event->hw.extra_reg.idx =3D=3D cspmu->cycle_counter_logical_idx) {
> +		arm_cspmu_set_cc_filter(cspmu, filter);
> +	} else {
> +		arm_cspmu_set_event(cspmu, hwc);
> +		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
> +	}
> +
> +	hwc->state =3D 0;
> +
> +	arm_cspmu_enable_counter(cspmu, hwc->idx); }
> +
> +static void arm_cspmu_stop(struct perf_event *event, int pmu_flags) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	arm_cspmu_disable_counter(cspmu, hwc->idx);
> +	arm_cspmu_event_update(event);
> +
> +	hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE; }
> +
> +static inline u32 to_phys_idx(struct arm_cspmu *cspmu, u32 idx) {
> +	return (idx =3D=3D cspmu->cycle_counter_logical_idx) ?
> +		ARM_CSPMU_CYCLE_CNTR_IDX : idx;
> +}
> +
> +static int arm_cspmu_add(struct perf_event *event, int flags) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +	struct arm_cspmu_hw_events *hw_events =3D &cspmu->hw_events;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx;
> +
> +	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> +					   &cspmu->associated_cpus)))
> +		return -ENOENT;
> +
> +	idx =3D arm_cspmu_get_event_idx(hw_events, event);
> +	if (idx < 0)
> +		return idx;
> +
> +	hw_events->events[idx] =3D event;
> +	hwc->idx =3D to_phys_idx(cspmu, idx);
> +	hwc->extra_reg.idx =3D idx;
> +	hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START)
> +		arm_cspmu_start(event, PERF_EF_RELOAD);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +
> +static void arm_cspmu_del(struct perf_event *event, int flags) {
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(event->pmu);
> +	struct arm_cspmu_hw_events *hw_events =3D &cspmu->hw_events;
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx =3D hwc->extra_reg.idx;
> +
> +	arm_cspmu_stop(event, PERF_EF_UPDATE);
> +
> +	hw_events->events[idx] =3D NULL;
> +
> +	clear_bit(idx, hw_events->used_ctrs);
> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void arm_cspmu_read(struct perf_event *event) {
> +	arm_cspmu_event_update(event);
> +}
> +
> +static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
> +{
> +	struct acpi_apmt_node *apmt_node;
> +	struct arm_cspmu *cspmu;
> +	struct device *dev;
> +
> +	dev =3D &pdev->dev;
> +	apmt_node =3D *(struct acpi_apmt_node **)dev_get_platdata(dev);
> +	if (!apmt_node) {
> +		dev_err(dev, "failed to get APMT node\n");
> +		return NULL;
> +	}
> +
> +	cspmu =3D devm_kzalloc(dev, sizeof(*cspmu), GFP_KERNEL);
> +	if (!cspmu)
> +		return NULL;
> +
> +	cspmu->dev =3D dev;
> +	cspmu->apmt_node =3D apmt_node;
> +
> +	platform_set_drvdata(pdev, cspmu);
> +
> +	return cspmu;
> +}
> +
> +static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu) {
> +	struct device *dev;
> +	struct platform_device *pdev;
> +	struct acpi_apmt_node *apmt_node;
> +
> +	dev =3D cspmu->dev;
> +	pdev =3D to_platform_device(dev);
> +	apmt_node =3D cspmu->apmt_node;
> +
> +	/* Base address for page 0. */
> +	cspmu->base0 =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cspmu->base0)) {
> +		dev_err(dev, "ioremap failed for page-0 resource\n");
> +		return PTR_ERR(cspmu->base0);
> +	}
> +
> +	/* Base address for page 1 if supported. Otherwise point to page 0.
> */
> +	cspmu->base1 =3D cspmu->base0;
> +	if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
> +		cspmu->base1 =3D devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(cspmu->base1)) {
> +			dev_err(dev, "ioremap failed for page-1 resource\n");
> +			return PTR_ERR(cspmu->base1);
> +		}
> +	}
> +
> +	cspmu->pmcfgr =3D readl(cspmu->base0 + PMCFGR);
> +
> +	cspmu->num_logical_ctrs =3D FIELD_GET(PMCFGR_N, cspmu->pmcfgr) + 1;
> +
> +	cspmu->cycle_counter_logical_idx =3D ARM_CSPMU_MAX_HW_CNTRS;
> +
> +	if (supports_cycle_counter(cspmu)) {
> +		/*
> +		 * The last logical counter is mapped to cycle counter if
> +		 * there is a gap between regular and cycle counter.
> Otherwise,
> +		 * logical and physical have 1-to-1 mapping.
> +		 */
> +		cspmu->cycle_counter_logical_idx =3D
> +			(cspmu->num_logical_ctrs <=3D ARM_CSPMU_CYCLE_CNTR_IDX) ?
> +				cspmu->num_logical_ctrs - 1 :
> +				ARM_CSPMU_CYCLE_CNTR_IDX;
> +	}
> +
> +	cspmu->num_set_clr_reg =3D
> +		DIV_ROUND_UP(cspmu->num_logical_ctrs,
> +				ARM_CSPMU_SET_CLR_COUNTER_NUM);
> +
> +	cspmu->hw_events.events =3D
> +		devm_kcalloc(dev, cspmu->num_logical_ctrs,
> +			     sizeof(*cspmu->hw_events.events), GFP_KERNEL);
> +
> +	if (!cspmu->hw_events.events)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline int arm_cspmu_get_reset_overflow(struct arm_cspmu *cspmu,
> +					       u32 *pmovs)
> +{
> +	int i;
> +	u32 pmovclr_offset =3D PMOVSCLR;
> +	u32 has_overflowed =3D 0;
> +
> +	for (i =3D 0; i < cspmu->num_set_clr_reg; ++i) {
> +		pmovs[i] =3D readl(cspmu->base1 + pmovclr_offset);
> +		has_overflowed |=3D pmovs[i];
> +		writel(pmovs[i], cspmu->base1 + pmovclr_offset);
> +		pmovclr_offset +=3D sizeof(u32);
> +	}
> +
> +	return has_overflowed !=3D 0;
> +}
> +
> +static irqreturn_t arm_cspmu_handle_irq(int irq_num, void *dev) {
> +	int idx, has_overflowed;
> +	struct perf_event *event;
> +	struct arm_cspmu *cspmu =3D dev;
> +	DECLARE_BITMAP(pmovs, ARM_CSPMU_MAX_HW_CNTRS);
> +	bool handled =3D false;
> +
> +	arm_cspmu_stop_counters(cspmu);
> +
> +	has_overflowed =3D arm_cspmu_get_reset_overflow(cspmu, (u32 *)pmovs);
> +	if (!has_overflowed)
> +		goto done;
> +
> +	for_each_set_bit(idx, cspmu->hw_events.used_ctrs,
> +			cspmu->num_logical_ctrs) {
> +		event =3D cspmu->hw_events.events[idx];
> +
> +		if (!event)
> +			continue;
> +
> +		if (!test_bit(event->hw.idx, pmovs))
> +			continue;
> +
> +		arm_cspmu_event_update(event);
> +		arm_cspmu_set_event_period(event);
> +
> +		handled =3D true;
> +	}
> +
> +done:
> +	arm_cspmu_start_counters(cspmu);
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static int arm_cspmu_request_irq(struct arm_cspmu *cspmu) {
> +	int irq, ret;
> +	struct device *dev;
> +	struct platform_device *pdev;
> +	struct acpi_apmt_node *apmt_node;
> +
> +	dev =3D cspmu->dev;
> +	pdev =3D to_platform_device(dev);
> +	apmt_node =3D cspmu->apmt_node;
> +
> +	/* Skip IRQ request if the PMU does not support overflow interrupt.
> */
> +	if (apmt_node->ovflw_irq =3D=3D 0)
> +		return 0;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, arm_cspmu_handle_irq,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
> +			       cspmu);
> +	if (ret) {
> +		dev_err(dev, "Could not request IRQ %d\n", irq);
> +		return ret;
> +	}
> +
> +	cspmu->irq =3D irq;
> +
> +	return 0;
> +}
> +
> +static inline int arm_cspmu_find_cpu_container(int cpu, u32
> +container_uid) {
> +	u32 acpi_uid;
> +	struct device *cpu_dev =3D get_cpu_device(cpu);
> +	struct acpi_device *acpi_dev =3D ACPI_COMPANION(cpu_dev);
> +
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	while (acpi_dev) {
> +		if (!strcmp(acpi_device_hid(acpi_dev),
> +			    ACPI_PROCESSOR_CONTAINER_HID) &&
> +		    !kstrtouint(acpi_device_uid(acpi_dev), 0, &acpi_uid) &&
> +		    acpi_uid =3D=3D container_uid)
> +			return 0;
> +
> +		acpi_dev =3D acpi_dev->parent;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu) {
> +	struct device *dev;
> +	struct acpi_apmt_node *apmt_node;
> +	int affinity_flag;
> +	int cpu;
> +
> +	dev =3D cspmu->pmu.dev;
> +	apmt_node =3D cspmu->apmt_node;
> +	affinity_flag =3D apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
> +
> +	if (affinity_flag =3D=3D ACPI_APMT_FLAGS_AFFINITY_PROC) {
> +		for_each_possible_cpu(cpu) {
> +			if (apmt_node->proc_affinity =3D=3D
> +			    get_acpi_id_for_cpu(cpu)) {
> +				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
> +				break;
> +			}
> +		}
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			if (arm_cspmu_find_cpu_container(
> +				    cpu, apmt_node->proc_affinity))
> +				continue;
> +
> +			cpumask_set_cpu(cpu, &cspmu->associated_cpus);
> +		}
> +	}
> +
> +	if (cpumask_empty(&cspmu->associated_cpus)) {
> +		dev_dbg(dev, "No cpu associated with the PMU\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu) {
> +	int ret, capabilities;
> +	struct attribute_group **attr_groups;
> +
> +	attr_groups =3D arm_cspmu_alloc_attr_group(cspmu);
> +	if (!attr_groups)
> +		return -ENOMEM;
> +
> +	ret =3D cpuhp_state_add_instance(arm_cspmu_cpuhp_state,
> +				       &cspmu->cpuhp_node);
> +	if (ret)
> +		return ret;
> +
> +	capabilities =3D PERF_PMU_CAP_NO_EXCLUDE;
> +	if (cspmu->irq =3D=3D 0)
> +		capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
> +
> +	cspmu->pmu =3D (struct pmu){
> +		.task_ctx_nr	=3D perf_invalid_context,
> +		.module		=3D THIS_MODULE,
> +		.pmu_enable	=3D arm_cspmu_enable,
> +		.pmu_disable	=3D arm_cspmu_disable,
> +		.event_init	=3D arm_cspmu_event_init,
> +		.add		=3D arm_cspmu_add,
> +		.del		=3D arm_cspmu_del,
> +		.start		=3D arm_cspmu_start,
> +		.stop		=3D arm_cspmu_stop,
> +		.read		=3D arm_cspmu_read,
> +		.attr_groups	=3D (const struct attribute_group
> **)attr_groups,
> +		.capabilities	=3D capabilities,
> +	};
> +
> +	/* Hardware counter init */
> +	arm_cspmu_stop_counters(cspmu);
> +	arm_cspmu_reset_counters(cspmu);
> +
> +	ret =3D perf_pmu_register(&cspmu->pmu, cspmu->name, -1);
> +	if (ret) {
> +		cpuhp_state_remove_instance(arm_cspmu_cpuhp_state,
> +					    &cspmu->cpuhp_node);
> +	}
> +
> +	return ret;
> +}
> +
> +static int arm_cspmu_device_probe(struct platform_device *pdev) {
> +	int ret;
> +	struct arm_cspmu *cspmu;
> +
> +	cspmu =3D arm_cspmu_alloc(pdev);
> +	if (!cspmu)
> +		return -ENOMEM;
> +
> +	ret =3D arm_cspmu_init_mmio(cspmu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D arm_cspmu_request_irq(cspmu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D arm_cspmu_get_cpus(cspmu);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D arm_cspmu_register_pmu(cspmu);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int arm_cspmu_device_remove(struct platform_device *pdev) {
> +	struct arm_cspmu *cspmu =3D platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&cspmu->pmu);
> +	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state,
> +&cspmu->cpuhp_node);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver arm_cspmu_driver =3D {
> +	.driver =3D {
> +			.name =3D DRVNAME,
> +			.suppress_bind_attrs =3D true,
> +		},
> +	.probe =3D arm_cspmu_device_probe,
> +	.remove =3D arm_cspmu_device_remove,
> +};
> +
> +static void arm_cspmu_set_active_cpu(int cpu, struct arm_cspmu *cspmu)
> +{
> +	cpumask_set_cpu(cpu, &cspmu->active_cpu);
> +	WARN_ON(irq_set_affinity(cspmu->irq, &cspmu->active_cpu)); }
> +
> +static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node
> +*node) {
> +	struct arm_cspmu *cspmu =3D
> +		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
> +
> +	if (!cpumask_test_cpu(cpu, &cspmu->associated_cpus))
> +		return 0;
> +
> +	/* If the PMU is already managed, there is nothing to do */
> +	if (!cpumask_empty(&cspmu->active_cpu))
> +		return 0;
> +
> +	/* Use this CPU for event counting */
> +	arm_cspmu_set_active_cpu(cpu, cspmu);
> +
> +	return 0;
> +}
> +
> +static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node
> +*node) {
> +	int dst;
> +	struct cpumask online_supported;
> +
> +	struct arm_cspmu *cspmu =3D
> +		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
> +
> +	/* Nothing to do if this CPU doesn't own the PMU */
> +	if (!cpumask_test_and_clear_cpu(cpu, &cspmu->active_cpu))
> +		return 0;
> +
> +	/* Choose a new CPU to migrate ownership of the PMU to */
> +	cpumask_and(&online_supported, &cspmu->associated_cpus,
> +		    cpu_online_mask);
> +	dst =3D cpumask_any_but(&online_supported, cpu);
> +	if (dst >=3D nr_cpu_ids)
> +		return 0;
> +
> +	/* Use this CPU for event counting */
> +	perf_pmu_migrate_context(&cspmu->pmu, cpu, dst);
> +	arm_cspmu_set_active_cpu(dst, cspmu);
> +
> +	return 0;
> +}
> +
> +static int __init arm_cspmu_init(void)
> +{
> +	int ret;
> +
> +	ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +					"perf/arm/cspmu:online",
> +					arm_cspmu_cpu_online,
> +					arm_cspmu_cpu_teardown);
> +	if (ret < 0)
> +		return ret;
> +	arm_cspmu_cpuhp_state =3D ret;
> +	return platform_driver_register(&arm_cspmu_driver);
> +}
> +
> +static void __exit arm_cspmu_exit(void) {
> +	platform_driver_unregister(&arm_cspmu_driver);
> +	cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
> +}
> +
> +module_init(arm_cspmu_init);
> +module_exit(arm_cspmu_exit);
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h
> b/drivers/perf/arm_cspmu/arm_cspmu.h
> new file mode 100644
> index 000000000000..f1d7b2c9ade3
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ARM CoreSight Architecture PMU driver.
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#ifndef __ARM_CSPMU_H__
> +#define __ARM_CSPMU_H__
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#define to_arm_cspmu(p) (container_of(p, struct arm_cspmu, pmu))
> +
> +#define ARM_CSPMU_EXT_ATTR(_name, _func, _config)			\
> +	(&((struct dev_ext_attribute[]){				\
> +		{							\
> +			.attr =3D __ATTR(_name, 0444, _func, NULL),	\
> +			.var =3D (void *)_config				\
> +		}							\
> +	})[0].attr.attr)
> +
> +#define ARM_CSPMU_FORMAT_ATTR(_name, _config)				\
> +	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_sysfs_format_show, (char
> +*)_config)
> +
> +#define ARM_CSPMU_EVENT_ATTR(_name, _config)				\
> +	PMU_EVENT_ATTR_ID(_name, arm_cspmu_sysfs_event_show, _config)
> +
> +
> +/* Default event id mask */
> +#define ARM_CSPMU_EVENT_MASK	GENMASK_ULL(63, 0)
> +
> +/* Default filter value mask */
> +#define ARM_CSPMU_FILTER_MASK	GENMASK_ULL(63, 0)
> +
> +/* Default event format */
> +#define ARM_CSPMU_FORMAT_EVENT_ATTR	\
> +	ARM_CSPMU_FORMAT_ATTR(event, "config:0-32")
> +
> +/* Default filter format */
> +#define ARM_CSPMU_FORMAT_FILTER_ATTR	\
> +	ARM_CSPMU_FORMAT_ATTR(filter, "config1:0-31")
> +
> +/*
> + * This is the default event number for cycle count, if supported,
> +since the
> + * ARM Coresight PMU specification does not define a standard event
> +code
> + * for cycle count.
> + */
> +#define ARM_CSPMU_EVT_CYCLES_DEFAULT	(0x1ULL << 32)
> +
> +/*
> + * The ARM Coresight PMU supports up to 256 event counters.
> + * If the counters are larger-than 32-bits, then the PMU includes at
> + * most 128 counters.
> + */
> +#define ARM_CSPMU_MAX_HW_CNTRS		256
> +
> +/* The cycle counter, if implemented, is located at counter[31]. */
> +#define ARM_CSPMU_CYCLE_CNTR_IDX	31
> +
> +/* PMIIDR register field */
> +#define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
> +#define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
> +
> +struct arm_cspmu;
> +
> +/* This tracks the events assigned to each counter in the PMU. */
> +struct arm_cspmu_hw_events {
> +	/* The events that are active on the PMU for a given logical index.
> */
> +	struct perf_event **events;
> +
> +	/*
> +	 * Each bit indicates a logical counter is being used (or not) for
> an
> +	 * event. If cycle counter is supported and there is a gap between
> +	 * regular and cycle counter, the last logical counter is mapped to
> +	 * cycle counter. Otherwise, logical and physical have 1-to-1
> mapping.
> +	 */
> +	DECLARE_BITMAP(used_ctrs, ARM_CSPMU_MAX_HW_CNTRS); };
> +
> +/* Contains ops to query vendor/implementer specific attribute. */
> +struct arm_cspmu_impl_ops {
> +	/* Get event attributes */
> +	struct attribute **(*get_event_attrs)(const struct arm_cspmu
> *cspmu);
> +	/* Get format attributes */
> +	struct attribute **(*get_format_attrs)(const struct arm_cspmu
> *cspmu);
> +	/* Get string identifier */
> +	const char *(*get_identifier)(const struct arm_cspmu *cspmu);
> +	/* Get PMU name to register to core perf */
> +	const char *(*get_name)(const struct arm_cspmu *cspmu);
> +	/* Check if the event corresponds to cycle count event */
> +	bool (*is_cycle_counter_event)(const struct perf_event *event);
> +	/* Decode event type/id from configs */
> +	u32 (*event_type)(const struct perf_event *event);
> +	/* Decode filter value from configs */
> +	u32 (*event_filter)(const struct perf_event *event);
> +	/* Hide/show unsupported events */
> +	umode_t (*event_attr_is_visible)(struct kobject *kobj,
> +					 struct attribute *attr, int unused); };
> +
> +/* Vendor/implementer descriptor. */
> +struct arm_cspmu_impl {
> +	u32 pmiidr;
> +	struct arm_cspmu_impl_ops ops;
> +	void *ctx;
> +};
> +
> +/* Coresight PMU descriptor. */
> +struct arm_cspmu {
> +	struct pmu pmu;
> +	struct device *dev;
> +	struct acpi_apmt_node *apmt_node;
> +	const char *name;
> +	const char *identifier;
> +	void __iomem *base0;
> +	void __iomem *base1;
> +	int irq;
> +	cpumask_t associated_cpus;
> +	cpumask_t active_cpu;
> +	struct hlist_node cpuhp_node;
> +
> +	u32 pmcfgr;
> +	u32 num_logical_ctrs;
> +	u32 num_set_clr_reg;
> +	int cycle_counter_logical_idx;
> +
> +	struct arm_cspmu_hw_events hw_events;
> +
> +	struct arm_cspmu_impl impl;
> +};
> +
> +/* Default function to show event attribute in sysfs. */ ssize_t
> +arm_cspmu_sysfs_event_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf);
> +
> +/* Default function to show format attribute in sysfs. */ ssize_t
> +arm_cspmu_sysfs_format_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf);
> +
> +#endif /* __ARM_CSPMU_H__ */
> --
> 2.17.1

