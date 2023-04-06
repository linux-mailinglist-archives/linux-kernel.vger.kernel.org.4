Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92476D9245
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjDFJIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjDFJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:08:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564D83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9YyCxr4m8wvaNz2aMqzg164bWqcxVUmJUrt56gw+zH2g9DCVR0se7bhTo1woVboiG+buqCPjm+kWi+D4PoMjcrbY1SUBJqSEo2mHa8FjB6eW/hUvKew+xEpmegQpGWZGvBuzIVEPVTvYOdtwaH0HqFC1S6DJXSSJANeW2BO51+LuDPVJ9tbE/QyB7zbpR1rVOm1Kwed902vZm1+7FINlKiL6tOd3p71e1PZjgTpJhy390SZJ02vEBLtJFy+pZpbXF4HvMI4LHp6As/+zmMkrlMoalwo3X/yb/B4Dvit21HHo1ka6rtmQCftGg4RYwCBZ+SXhdWwnxC1k0qw9G2QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gNkgn5Dhn7nDeVCPPldJ99/DwNjrqWATiDop0xHxys=;
 b=cuT6yrFhCX7l8kASxCEFbY8ZpmZm1umKONvQwweYH9Xe2OXboSHskj+hnewoXFq14a2gZy4puvw070/l+QjfiqHNBTmKZrHuOtO52p0FLaZD6rDuifVzhc6E/ptqafEtwch9a7A+9fttF6qu+ebP6A6IkEuBvp5ASuP5Eh4dnE7gr9IgwDsmdDeSM5OetZvs3VFIKW2Y+W6aTrd8JVkAErhlV9DNdpBFixhGCEEaMAEjQdGD81DMhwmkMURlCR+gXgYp3URbwoZMQ3Do7APX2jQLcoIoRFc4mllmpAKFrCp3vLDgjbfu1XK8SKWpC1es6L54QNLpv+zQOX8IV469FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gNkgn5Dhn7nDeVCPPldJ99/DwNjrqWATiDop0xHxys=;
 b=evLyFQiRLvL4RMjh54MV/g0Nby27FNXQ+yWK0BUxjQqYmxBEaw8CyMHZ85EHfTIGYOn85d/WG9WDyuRCPGQGg6QCSeJQMekB1+tIQXp0w4s//zkj0LTYscQS5erQseJfJV7ZVpUomaZlR9Q9mybsU6WAs5OgpaIyL0N28jfexdSWPRRWwT64v41g6pWwCLZ2d8/jwyE0ukcqw7+penFLOAcIGQSe4soeni64tqhzt+k1EbvDG2W6ELwm7AtT+HwNkymW3ZZHAwzduc6fjmIldSrbsSuE5zeGkI9Jbf7TQxo4bbawC1m2vKERCQ0VgOmkubeV8Q/BKvYfx3+phQ1kiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SEYPR06MB5086.apcprd06.prod.outlook.com (2603:1096:101:56::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 09:08:23 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb%5]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:08:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     frank.li@vivo.com, chengzhihao1@huawei.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        richard@nod.at
Subject: Re: [PATCH] ubifs: remove unnecessary kobject_del()
Date:   Thu,  6 Apr 2023 17:08:13 +0800
Message-Id: <20230406090813.24111-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230405130747.66006-1-frank.li@vivo.com>
References: <20230405130747.66006-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SEYPR06MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 29561f3c-c3ea-4f55-9b4c-08db367e791f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOkRkxB5XqRAhPVr7YMZuV7woj8S5CMzJ4clY1ZRuTHu91LpnBj1eGMbjkxS7nVn+Vc47O8kTvu7FIzlBYNqwWsnU1Ya17ekp3Ia6QH54z1VgtdaD7mMU84qJjSG428Q9pDTKvYCOJNPjl5Pzs3gAfQ2ARTYlgin2nO7iRvSgFNpGHiRvnK9BVl8rVbxf/DoZcFVpb7Mw5b35a3JdFeY9PUROhooqB+ZW4u2lwi9FRxgjqq6VoE9/VsUKwilvuY8G+j+Uyeud1gZKhah7p/3syZN2+865tuwRrcn2jMgt3yuGFX8+PgEQ5X+KXJ2ailbEKcjyU5jxIuWBScW/JoKJ0dM8pKdmKON99R7UyVDvAt0bHy0JOjF/QW1/Ds8eFNPoeZQMsgJl8/2zsNnmfBcEdm/zDl8yQzoM0BkSPiVxCmeGBISIBPFXgxcjH8JVFEtnCVD8PjQ4Xk+jmSzA4+5Qy9ZLwFzZe8Q9q9e0FgRuxlICFHTLkwKe7K/j9D/GKuxo4rkkAYl6TbdvrtKHTK6PRntC1tM6GpAhjXjR1S+Kmk2+uQy9vwXORzbFFSuaTTv29uw1j2fWHpe5LbwhMYuijwZeLD2CY+01KZAEaAh2LsYRljjMfrxVG9Je+cTZQPU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(52116002)(26005)(6666004)(66946007)(36756003)(6506007)(2616005)(316002)(1076003)(4326008)(41300700001)(478600001)(8676002)(38100700002)(6486002)(66556008)(66476007)(38350700002)(6512007)(558084003)(2906002)(86362001)(5660300002)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I50nUcYcR3uomZdTsop5yG8/PdVvs1Qz1CbGjw5VGH5dioqZl5sEpZ81ds2X?=
 =?us-ascii?Q?IaUzb/BTEF8Mr/P6UGi03ZVzjkYMzPZtwKEhBjDbCHXrmac42F8w+j433l4K?=
 =?us-ascii?Q?5dEKltSc3gMvwv+4uwX/Ubkjbvjmax3/3X73RDptBvWVvycURrRfRQdL3H0v?=
 =?us-ascii?Q?a9UGJzmDkc1g1PD7Mf1lTggFRP6Zsz+hnRUmhxlFJI4MEoEHQkNJbF3NUpdc?=
 =?us-ascii?Q?dMHhgU/ItUic1OwegAbdn6Ru4gUPW0xBjqoW1TSOd863KgoFw1E0g4IAjC6B?=
 =?us-ascii?Q?lOLkny6hF9YRCGyUQEXSQu32GjKybsEs1HmN9JVjrDsTkjr/LZjjREMtU/Z9?=
 =?us-ascii?Q?RrC9IM8viPk5MuPmzsUiSF4o4q21uHjVs/QFB64d0NAWGqeRx63mn8d1vEo7?=
 =?us-ascii?Q?/yZGeZFl+nVXiw59MqwLkMCIUcPmxhLsymYt4mFFNVMEJNDQhgTpFA4gUUjl?=
 =?us-ascii?Q?mL4rm28H+OVdhXMwWgyo83+9kcjzHa4Cc9cZQcGTotiEbeAqI0dU5wpKp04f?=
 =?us-ascii?Q?sH7yGYlyXK0EQQBnLrzJpNOgVOw6FLFTsHmnr6BM5DUGXtp5NCDt7rvDbgHR?=
 =?us-ascii?Q?aXLTRiET7ZGV6xK2gQwA7/kuATZOR2rylz2o37OG3cPkGdYg7fmL/5m2MnJQ?=
 =?us-ascii?Q?YGbLxpJdSzjEwYGcDqW68O+HqATi966mXTeQdObtH2LeG6USdXVUSrGAVWJC?=
 =?us-ascii?Q?lWZFzL2SsSX4P0ArXrQsbTA3nhIoiFgfIVlDWvh58GcJAjaVmIWKJYU7UHsw?=
 =?us-ascii?Q?IG/WEGHLESAo2KwApFvUX3guh1xuTnMxMDjnKa4E5utNa0u1z4HUwuXXBXdB?=
 =?us-ascii?Q?FpXxQWAbaWYbwDIrctKsLGWuS+fg7PtWn5nhaxsBVu4hS8+D7cXz71zSK1Cc?=
 =?us-ascii?Q?JCsZ9n1KGgC7+Nj3YkvROu75qMt1JDdvAy/kluVemkORYpkAy90miZFq+fYU?=
 =?us-ascii?Q?5F577QrQ1FhEc52J0MA3tf10zqw0kHk64q6Dm6ebDrI7N13bPyr9nAhSjPHh?=
 =?us-ascii?Q?FwXqLM0vsbBKzyNoQN/PwK9MtpnMa8NSpWADlj0wdbYskFLubfIbs4LE5AuG?=
 =?us-ascii?Q?SH9pYAH5avr1As/qKiJanlEHM6PEMNrx1B9kuRiyv3lIQPXhDU2UPQV7VTaV?=
 =?us-ascii?Q?jpjMEnL83Hhcu1AMCST5gRy/CPpd2bQDx/Z0I3BTxnMVBR4txgFtNPtxEHBn?=
 =?us-ascii?Q?WH4iZHoF2TGMbJ/LUzrBIdtzFMVRtI62DyosmQjt/QoD9cNm61o6abjzffnT?=
 =?us-ascii?Q?jNjkM97mYwVo6y4ohbNF5K2qIsNX8QTxyn8nZGnjYn85UYpDcJmk3+iNRFGv?=
 =?us-ascii?Q?UId0KGxYN9+0R9GAer3o7ecYrrC1GSVeBpt1XGzMNfT9pKmsteW4B70BJKRk?=
 =?us-ascii?Q?jVRh3AWWS9vZ4X5MKQ55d6ohjna39EN831eYpxaPGPRpqZgQ5IandTOjSINx?=
 =?us-ascii?Q?yko+zg4focpv900Idr3y/BMCc/tBv5mUHCqzmgfLzHrpjVt+ij3Z6yTeq6zD?=
 =?us-ascii?Q?5esZiVNaBCrg12DCicHUFsXgm6c1GY4K3C9zJawmFb/xnmpOPZm9Wglqcvv8?=
 =?us-ascii?Q?Ge7HU0zy87At4Jg15PDfPe/UdTK8gIJxLCoAL+bY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29561f3c-c3ea-4f55-9b4c-08db367e791f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:08:23.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj5fkt9bMB2z9423ukN4/NQtOkCeCy69bcGabkFvsi3JRkxbWtvLdHxgBC/5UtS6HjcQ7UblIPWC+DufTCgQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5086
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we should still reserve the 'redundant' kobject_del(),
> removing it won't bring any performance improvement.

Since it's redundant, why not to remove it.

Thx,
Yangtao
