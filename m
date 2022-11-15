Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4062AF85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKOXiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiKOXiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:38:12 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C32EF40;
        Tue, 15 Nov 2022 15:38:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6AZHfgQAY3BxwoZ14+/+oEnXNLPVe6LN4sQ24djcKHPl1Y6BIjFZef8dFhjTUx3ULGs7yIu/9NMMlh9UsB8a4kF1J2WWTD5WDUWxIJH3EIVs8w8wTa0aAL6b6tbgsFwlfGqaIPpDAGO5DS/aLZt9wH18H3Q93ve0H+JbbsgFNjOEsa0BVuWfUuXS0pkdWgRLatxqXSlOPpJHgB/vtK5hd7OJK57zOpWnqex2BKA+LbpqyIz3P9qGe++ZzHB67E0fPcmDIAE2F/aoU6ci6UV/Nep2xvrGr89bNfkmYXm5NsbiAreiRvlBQWi/Azkdo1+MnxEhsKteW+ABrjfhb/AXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=speoRZO1EgwX+8gJIoBOlg7ZvVOGztWNvz7lkcaFsO8=;
 b=haYnqaOV0OneQ3NcE0Zu+NYboz1vhD/o7Z9o70moZfXrSjX1pwExLtSQpfBxmVugECcG7y7CGhaBJGEoSout/ucUkWei0Ztj2cXTsa7cbcGDp6AyKLtjm5FXPuM5UZEONU1I2wDnHMMa0QQRVGlFNKzvei194bS5gcJmM3IyXzklx3wLC6xHkKJo1VLh11M/OvdjmCQ43O/AG4ipDmWcH7DQUyKwCkcDPMff37agapYDyhfhxtOniJgVACTFtdhc6oibE2XspJuNR8JmU8ymmPwhp0So1zzU1K/1n+Wlq/mK31GZmKoBrD66loH7Qd+K+fOHYcmvnVfNfiGK6xFRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=speoRZO1EgwX+8gJIoBOlg7ZvVOGztWNvz7lkcaFsO8=;
 b=akwCaWjhbGqwBO57zDNNao77Ty4gh6VEGCFz1oLx/9WmI4M80VHzcdIwNTWmjdLkBodlYS0efhnJNr+zjuOdfPX4oIK2oynxuK3a/AVX0PdT9UE4GnrBOFs/bEhi3a6ImDUiJpZKvHfOmA1cnBlkrsSrxr9iRnm0wAxoSPQL9Y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OS3PR01MB8842.jpnprd01.prod.outlook.com (2603:1096:604:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 23:38:05 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 23:38:05 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be,
        alexander.helms.jy@renesas.com
Subject: [PATCH v3 0/2] Add support for Renesas ProXO XP oscillator
Date:   Tue, 15 Nov 2022 16:37:47 -0700
Message-Id: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|OS3PR01MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2d8f8e-6da1-45f6-1dfb-08dac7627184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnLalM0ANWsLp1G0kFgp0FWcEisICSUvspSkIV29tGAwJE/8BK4di4tNIczOeqgsoDbtVhm/g93uCFduyrMIO29XpQjp8zWDBDv3yQjPbzp6COQyXSV7zTjHxoD46Sb03mJs7CFDP5ol5zB3meC1XRShdRWnb6KqGD8e1JB+DMamgMGq06WpHRT+l7es1AJ5mbkE9/S9LjQXv9GSln/OnF7/AZ/TRgUGKpj+jNB7TzhUCOTHmNgFgiUv7KAeA6wCHP3lAb7c2gy6lKIHFzakwxC/0Jj8bUgUO11RPPM+juYYtbUDVHY+yTQyrUGddqtSDI/mQzqPvHAK/hmW2mxQ910iJty7jA3OJQlS88Vn3pU+8DHoZ5J2nJdZEwFG7vJIMjS7/a23Us82jPJ1UUW952fA3+iW840aruy5NgAOEY6kVM/AgmpLQqWmic5CKM5soEFCIa2sXmjag17iPc6BFxq3/IRHhUWCN9GIYF9tfe0MMd6rVTEra3SwdXh6w6waLc5dMPxXe1NaZSHs49+Uha+E3OjAUH6vjizhlIty+rQu7uhpWTJp5bQeNya0iOWP8ipKP/iUQU3dTzK3UoAwz9wrL6wcnK6lIDiMLRUtRZoV10BgjJGejUcECRJFXqC5t/bVK/t7kTgPwuCGhrBlT29rY0dqZuYZ4vqPLVHhGkGYgrxZRB+bmF0K+cUeGj0FI9hww3HulBuu5teMlEHSjH+s1KVXCy4V9UugN1AyhlCiJlDEIKYt2+NjGJ2Sgu90
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(1076003)(186003)(36756003)(83380400001)(6486002)(478600001)(6512007)(2616005)(107886003)(6666004)(52116002)(6506007)(86362001)(103116003)(38350700002)(8936002)(38100700002)(41300700001)(2906002)(26005)(5660300002)(4744005)(316002)(8676002)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdgOrbok1bpm+uhGd2QfeqmsXx/XfepHQh1jlm+bJPHilNQonP8lYGxxEYcN?=
 =?us-ascii?Q?kq8b8xIfjVdQvABnw/voyZIhT673nJ9TqIyKHhopHVGA5oRb0hIJ3qOJ5sGl?=
 =?us-ascii?Q?AKS5Oe8vW5U4FohQK3KdRTsfl2Yue8VcSMEIHUNcH1hahmxJ0m5b3ZdoKm9f?=
 =?us-ascii?Q?O81gBeRShl2zuvWvQldx03iYBo485BYhrxe87EmyE7F9aIVUmheDqPPUEkxD?=
 =?us-ascii?Q?TWTCll2oggQVrkxnDEnsDj4QiMXYBCpKUd7Fa58v5wxFFpf8QP8S+/+rGzFj?=
 =?us-ascii?Q?SQR8Bs7jL3bwDsM5KZbAbg6uNWPxZ8zCMa1U7C97hDub9I5vUTtUdLPdOJga?=
 =?us-ascii?Q?6GKpjSe5QykCSgTf9RYoFJUoYMg9RTb/bTA8M83GeL0PpzwbTc8eblf7GDpJ?=
 =?us-ascii?Q?0lKdi9ixQqdx/zhIqLTsyTxQqzUss5+uPXbHzYz6fh022b8hDnET/K+XQnfO?=
 =?us-ascii?Q?6JL7lO2BBLTnF/ypqMhV8cBmrCVT5c7GBCVNFLT+xJYJfE5bnaHEl5GdoZV9?=
 =?us-ascii?Q?3DCgq0RPef7Z2dUDd/hDJFuzSpk+mJ8XM/t/SzincW3QmXBky6C864FgAjSn?=
 =?us-ascii?Q?Sy/CnOIob0PyM5COsLSKzxcHHI5h9ux/7eDhVSfAdNjOVhsgh3l8Zwum2ci/?=
 =?us-ascii?Q?+8yMCFkDt5HcfGKLvsMuE/0y01KHO6j4OK0uTfulQ9qf0sApjX4pVZ5epJhK?=
 =?us-ascii?Q?c5D3qKIggphz8aHvBMGi1snq4kZ2f4GljFIhlJ20Bf3ElNNjQxtvgmDytdpg?=
 =?us-ascii?Q?RzYQplw+fzJzoaXlKKFaLVVNabbGBKWqasb3BWr3ywGpRbb0+BcHG7XMVg/h?=
 =?us-ascii?Q?6APtwKVGjvtxGM38kzwvxJ96U+qPCRZNT6+OCOdo4KBPjE8Pq6rrzlhUe1Jf?=
 =?us-ascii?Q?8MgN2t4oKOKUNPaQo7KkkfdQnDvdxE84cIee7Q2D1JyeqEN28gCKqFHCozTU?=
 =?us-ascii?Q?8n24I90rT25sJ9uRoReVU+0d6KrQwBC6pNT+KcwkOffoBvwslhhOV3xzZChL?=
 =?us-ascii?Q?c8DoQ6BG86XMlE/1tJTv4VmdZ1p5uTvlsIT+cnCXqw66pY2DJvYgfYpRp3vh?=
 =?us-ascii?Q?x3bI9bjdo6J85go6ahNHiZq+3nDIBC+SlJcm0N/9pl1owcpxsGQ3Mx3QI8PX?=
 =?us-ascii?Q?wrduw0W6sPByRJ8xy7MGolbL8Gnf7w6dSEjVwWnNKUAMl6eFv/IwjVmR3djj?=
 =?us-ascii?Q?qgGMj22MTldNB8png+Xq9Ka0G8HraPLz2c11Xs7R3OzVW9tORRYDuIB7qnZC?=
 =?us-ascii?Q?mTCrCJG1NCPZFtqNl7cfu7V1Ic0PlUm9/G0bkBr3L7Eou/YWaRRyV4PNqgSl?=
 =?us-ascii?Q?iSNJlGLg2Xctc5cwtyjIMAN/4f0kxONlAH0uXX1QaIDefPfZ1XxdBvh3UHEx?=
 =?us-ascii?Q?IMYCtQ70xDPMH5Lake10jrC7t9ie6VDD43KNZdmSIsWG4oryWQtszu6b+rgp?=
 =?us-ascii?Q?++yHBRRebLR6NsJtzUYlQ+JXLypeHUuHiJ+hHA5IvjwSrFO/i6h+F/J7a6Yt?=
 =?us-ascii?Q?E+Xxl1rPOFpYkZHLt+Y2FTKgPlDDHY0MKNzMcV95dHuAt5ePydIaOCIm+O5w?=
 =?us-ascii?Q?Qp8P9Ao+NmMlImsIfqFK5zqV7yXKd0JE6IbFoqerwCj0xBgEBQ+C72/lBnJu?=
 =?us-ascii?Q?nE/8JZSv9sOmTtkBEeewReM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2d8f8e-6da1-45f6-1dfb-08dac7627184
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 23:38:05.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qzx7EsLatAv4Dv27fQ3dDQosqJ/MACLptOU+LjsNvDgnOf20bViKbFxb6tJsfvQvKOiDdAHc/Qh8EDnwTmyA+okEtc/qNDfZFZBj+IwJL4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8842
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings and a common clock framework device drivers
for the Renesas ProXO XP oscillator.

V3:
 - Add '-hz' suffix to dt property
V2:
 - Fix minor issues in dt bindings
 - Change renesas,xtal to renesas,crystal-frequency

Alex Helms (2):
  dt-bindings: clock: Add bindings for Renesas ProXO
  clk: Add support for Renesas ProXO oscillator

 .../bindings/clock/renesas,proxo.yaml         |  51 +++
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-proxo.c                       | 410 ++++++++++++++++++
 5 files changed, 475 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
 create mode 100644 drivers/clk/clk-proxo.c


base-commit: f64b5666e11dce481737208027d4af300c63842d
-- 
2.30.2

