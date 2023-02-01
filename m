Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE0686A17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjBAPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:21:52 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2132.outbound.protection.outlook.com [40.107.247.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30337721F9;
        Wed,  1 Feb 2023 07:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEUH+QVSZAiA4OyvgIistZr7KA+ydK4mr+dg1YlFxiLfXZ1e6r8M+D8P8jXQNzZW0hWoH1gYLoxyyyhf8oKCBaGCZ9vfNwUP4c4oIDHN1vUzpNIkUGUFaShWkpbt+iDGyb2rg/T8lXk29Ms2ZWtg3zHW+dE0PV/9gyhtrXxJIV1oKe10DuOVKn1QmCBoqn6hsimAez/+ACpNKfgPwMAH/a+wlUVpe9r1/h4QjqiCtALWzdCzjPieyx3PtTdx/sPzQC7HwdswmV8o1zLzkwCQDZh+gPv6krZgIv+da8ScNcYX7R5E+UuGvNIPbM7XILEh1jDZ8H27pbmw6SDowotFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hUO/r+Zlw6ZUR/WAUpLL1gEerzwf5W8dlyaNJ2FnQI=;
 b=SLb/yZUOiqUqR5jfYhexksHJQs9AI3eFqQdoZ6+bQXrV+g/vYKfslvlYsBjGaYxB0RYqKbbAcEbmszAyruCutSVoommLRIqjmIEXwc8+pwpWdydd2S3krsK+VmGVIcHVCBwIb3MVIbD1VlaZZJ/0ceNMm+RTg3HziWO54CdkPPA8tL/7JG94h8Ke2XVkQ37pThYjYZYc61LQOt5rjzfJ8Z7BAMZ1kY5uuoOuo25wP2O1WLIdfFko1Hf2ZPoN0fEcmRs/ob9X7tzrpRBMM3XgJV17Pmt52CJEunRsO6N1hSt+g4X/RL+QeG7mbtRj9U94nJ3juLt6AerGFjGo3Mc7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hUO/r+Zlw6ZUR/WAUpLL1gEerzwf5W8dlyaNJ2FnQI=;
 b=SqXQEAO1QgoHfsJbEVNRFizZ4GUwA4pwsTb0qPAiQpW6WObF6kBsnXqgNwRfO5UGHHiMJ+eW3Nvxs30MjT1NAUE0AEjUQZQqqxr0u0SgSx5jsqEgo2q+dS2ddUY/OSSafai4l0m5irtl81jXPThWW0R/eo+2nNpSnrZQOgyuyPMs6saIFlve1Oa72CB/kN7y/BbgxX9xRf0tt/ukRoeFY0AvbA6B5FY+oQsFOEarodxUOeC+6+VmCg24CjfU5E5Xh6Njrh7wmYRufJucvp+nCfCzNyFT221bC3P48QCNNR/AgbFMpoq9bh3lUH8nJ5XQcXETmWcmU/71yNYPSAQ5fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM9PR03MB7380.eurprd03.prod.outlook.com (2603:10a6:20b:26b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:21:31 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:21:31 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v10 0/4] input: pwm-beeper: add feature to set volume level 
Date:   Wed,  1 Feb 2023 16:21:24 +0100
Message-Id: <20230201152128.614439-1-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM9PR03MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: b97e3f3e-7ccf-47fe-23ea-08db0467fefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeP3gfGgkqAT8dYwsNawasfvy0qBweHEzMpuHSno2ST23LTiD6Zuu1nm3Vs4nVaI3r3aCdUMsWdNAXAk+x7lnPhodayYriiFfBiWxtxevduqcRh0w+GaL6BgXz2/1KiyjnSgvYBy+0qGE/S8neyQ7zChoZp9M4YrhTj52J8XNDzNApjgjyYIH4aYg0PBhNKDOBhWA2b4E2uyYFo92C6M8vi4vuzbPJhyr/DmCeUFjR6WapVRmVe3BqMwZLIhyH9lqE3GA2Ok8K5FPUNuZBw7OUUDiBEl0F8vNrKOATJs9GpMEx/rTfypgMNDRBmSWrrbv3y+7UgZEzLr23WBIlXY8u5HVMWglMm6FzrFGDFcBJBy01WKslXidV0Iu9HnxPkNZhpONSOk6c+z1K+Hveo1G9vHtLdKKTfAJS0+XLUCPkO7y96akUQD3NRW7isgkJQDHjKV/9guUVE1PSKOu/iXb72FmhDvefpRZ1WRFsIzJtz1vSeFcwvxjr2qyUAlLJ8z2keHJ0m4+tRbRhhhyViohXG6Nn50r97TaOXdWye7OMsuPpfhWQFZvbfRlOIi9+Y/WR81Jv50X6qv2llhnkatp9Pgoy/xqx+shKXn6U5+sCqbXM6Y7s+gEHkVvXq3X/NMvH2od0WgO/m29rCiNVQDoTnAX/eZ9VtxBtJhWnA/RxwYiTiRymT7zRZs2OAPgcLV9LiIwhbnmQEvzmS3zV/GoJsvAphDhEtFfpIi6RO61Iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(38350700002)(38100700002)(54906003)(36756003)(86362001)(5660300002)(4326008)(6916009)(8676002)(8936002)(316002)(66476007)(66946007)(41300700001)(66556008)(44832011)(2616005)(83380400001)(2906002)(966005)(6486002)(4743002)(52116002)(478600001)(186003)(26005)(6512007)(1076003)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9A574wDGZKilVSjtTMq6vKxj/aQClcLSQMxNdKTmsiRX29vu8aCuGO+aCXsl?=
 =?us-ascii?Q?ZFZI/CD8omolIsCdIbwhriFvwjeE5Xy4X+0wlTkaU+kjDr6g2oI2DClLl2uN?=
 =?us-ascii?Q?aQMVQNT+DYBclaAIQ1ZlMbCwDT2gppGQ3pmMkPkXhsfXHboEL5P3S6keic5V?=
 =?us-ascii?Q?FPmcuVMS79vLnnwQ6DGztDnbfh70658n5N3OjH0Xpjg1tZ4fNoLUpecZ7Ewx?=
 =?us-ascii?Q?/fTwfiAR2dgpv3SFyhAK59FHBOTBWLgUEyavLNpX4se66rpqgK6h81wq4NfM?=
 =?us-ascii?Q?igexFZNmDGJyYYR2TO6/6lpNqZSDUCm1XWCOKIgbk9t+7iX5Kc8TtwXTK1FC?=
 =?us-ascii?Q?uhZLjRax5dFuLd4hWewXTcRcpL4qyJ32N0IGqMxCydgzk3SPdYDRHeVtZOz6?=
 =?us-ascii?Q?859JEwWjzKg9AakYDnDWHRJPVTTQGuQIqNDt2cmvtbB58fqWguUpkoQP+s2T?=
 =?us-ascii?Q?a82M6jPlT60mHTwLqdILM4yjaS8ikUtixlVn+HK/1mpW4UaStzEKicuycyVr?=
 =?us-ascii?Q?kqjtbtbH7rU6NdpNKF8OsY24uggQdimX/C3N8MYl4N5XNy64uV9Xvp1P1uFe?=
 =?us-ascii?Q?7TKE21NN8uPEtBNdAP4VFhWOo5H63nJ2fOBpWnxXSpHVZajAfa6Ft3FB1xbs?=
 =?us-ascii?Q?fVt54krNpfY/rGLV7BdgNK3eE8Q9ORIj6dxHfMEmkZmwqQi+28iJ3FJ2t4hv?=
 =?us-ascii?Q?OcnoHCFl5Hd3nsrcPm8boipWNvNIZFmy9+diawm5z0yImomrqcV940UDm6tN?=
 =?us-ascii?Q?9uUmbH5Vp+KLG6TMOnb4j+A3tfG0kb/27wMq/aVKTv4LMYvSjOrCiizZH4NK?=
 =?us-ascii?Q?hkbrKE/fFFK1S8kUti1YAHz58nI7htLIBL96VS8JMKxhlg3zZAqjxTpAOEmd?=
 =?us-ascii?Q?/94aGp0A3iIfFgwz6D2jgLMbJS8EWob9DWuhbPXx/YUSdx+g2zDW2fhuhzRV?=
 =?us-ascii?Q?mNKyqLgiSmyrF00agBpFTeA6w3Y4lNiAVC8KR3wX1Io7WGxYNDlDwfGnj8p+?=
 =?us-ascii?Q?Fok7ROtOm4sZCO1cCkR5sgrtkOYEZdS5calYdTHLaJeSKLJpymqsz+8pDe8o?=
 =?us-ascii?Q?P3kz94OCq1ltyUTSzRbQ8xyOTgLP/wmLBgIvDz8GBit1y0ONXOgvvo8wIU0R?=
 =?us-ascii?Q?D+wdG3Sq2A4GKQweKWlUaYsBHLr6IdJ69aqokT4No9+4KSR6Lljljky1EEHj?=
 =?us-ascii?Q?uwydyX0YV3sm6bTKLw/x0D7anrlp/FX+HXuDRSKSZ22/KDi6oH+HmIFIcN7o?=
 =?us-ascii?Q?58mvT3BHwu9hsGjW+p68JjrmvQUdh2OKdCOyUMCG8zSkyRrDOZbhHbUCmC6r?=
 =?us-ascii?Q?FAJckP90aI+UWN81P/vXJ8GT0QHO2h/mPUNqZ5Kx3O8fmSiTEuiTBjVbIf/T?=
 =?us-ascii?Q?VcTv9s06TQOXogdsmHyWXa+nEvrub8kPSjWMVyG31iWELFlXfzPuwvT9+jkI?=
 =?us-ascii?Q?QqEnN1VzgRxwSnBSU/HlORLCeElvHPmWNuehWKpYhC72qKKZP47VMBsOax+H?=
 =?us-ascii?Q?AgRXJhf8Dcd4l6h5LcG1h3CmHOnxjrQIEN+oVkBzVjShnquM66fTCjExtZHV?=
 =?us-ascii?Q?iTTU7NTNMbB+eP3+wNX8WunxnCOj0Z5BeIqtCcQz?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97e3f3e-7ccf-47fe-23ea-08db0467fefe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:21:31.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/apf7oGi5Lk60D5arAIgIvTSbIbouqfejYh0wEm7CNV5hwzmOpeD+r9eCVQljX0UcxglySjTbPTFVpnfV1Fdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements volume control for the pwm-beeper via sysfs.

The first patch changes the devicetree documentation from txt to yaml.

The original author of the volume support patches is Frieder Schrempf.
I picked them from this [0] LKML thread from 2017. Since it looks like
his email address changed in the meantime I changed it in the Author
and Signed-off-by, as well as in the copyright statements.
I did some minor changes on the patches that they apply and work with
the current kernel.

checkpatch still reports warnings regarding the changes:
  * from txt to yaml of the devicetree documentation:
      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
      WARNING: DT binding docs and includes should be a separate patch.
  * and the introduction of Documentation/ABI/testing/sysfs-devices-pwm-beeper:
      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  I am not sure how to fix these warnings. So any suggestion would be helpful.

Changes since v9 [1]:
 * [1/4] dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
    * added Reviewed-by tag from Rob Herring
 * [3/4] dt-bindings: input: pwm-beeper: add volume
    * Added missing unit specifier in examples

Changes since v8 [2]:
 * yaml devicetree doc:
    * reordered patches to introduce dt-bindings before usage
    * drop quotes from $id and $schema references
    * amp-supply: simplify description
    * examples: remove unneeded amp device node
    * use -bp suffix for volume-levels and default-volume
    * specify default-volume as value instead of pointer into volume-array

  * fixup to work with new dt-binding specification
  * squash patches as suggested by Frieder

Changes since v7 [3]:
 * yaml devicetree doc:
    * Use shorter subject
    * Fix indent
    * Use units
    * 'make dt_binding_check' succeeds
    * 'make dtbs_check' does not report new errors

 * Reworded commit messages avoiding 'this patch' phrase
 * Fix wrong indent in [PATCH 5/5 v7] input: pwm-beeper: handle module unloading properly
 * Use current date in Documentation/ABI/testing/sysfs-devices-pwm-beeper

 * Hopefully fixed my setup that
   * mails are CC'ed correctly
   * patches are sent as replies to the cover letter

Changes since v6 [4]:
 * Convert devicetree binding documentation from txt to yaml
 * Use DEVICE_ATTR_[RO|RW] properly
 * Change Frieders Mail address
 * Added Signed-off and Tested-by statements
 * Fix module unloading


Frieder Schrempf (2):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: set volume levels by devicetree

Manuel Traut (2):
  dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
  dt-bindings: input: pwm-beeper: add volume

 .../ABI/testing/sysfs-devices-pwm-beeper      |  17 +++
 .../devicetree/bindings/input/pwm-beeper.txt  |  24 ----
 .../devicetree/bindings/input/pwm-beeper.yaml |  56 ++++++++
 drivers/input/misc/pwm-beeper.c               | 135 +++++++++++++++++-
 4 files changed, 206 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml


[0] https://lore.kernel.org/all/cover.1487323753.git.frieder.schrempf@exceet.de/
[1] https://lore.kernel.org/lkml/20230130135650.1407156-1-manuel.traut@mt.com/
[2] https://lore.kernel.org/lkml/20230126091825.220646-1-manuel.traut@mt.com/
[3] https://lore.kernel.org/all/Y9AIq3cSNzI9T%2FdU@mt.com/
[4] https://lkml.org/lkml/2023/1/24/379

-- 
2.39.1

