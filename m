Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085DF67C6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjAZJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbjAZJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:19:10 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E1D6DB0A;
        Thu, 26 Jan 2023 01:18:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5sgraiU8r22pIX3lE4GkQPRfwibaWXeedWX06LG23WcEGYPS0nnpKMe5FyJ1FsS6gxpxCt9tFqJS0Ne6TUEJ4A2SsXaQGyPqe8WhZyHO2o2eaamdyq1k48sGqmqlv2hhbuL1esf8aiV6xfbOtzA9erxwWuC6S7aK91/n1slpGKCakc9+dKYooitbC87E6X6zX4ACLj1ZHEJGSJ7xAwjiqELxqj0QQOZDHlPI4jGhcR+7LODRL4XlttEPwEe9Ysg7IVIq/6lWOCQDsT0JD0xnevcXx/RcrlDN9inbUjfKIiyQAfgoyy5nIYlUaksBeFz5RbEVwPN9XxR7K9+f+tqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNQQ4JlyEMifq4exMQKAozl+VAGJ569Fh7Ra1BcznpI=;
 b=gmbQm/dlqyQCZFTn5p+5735FjK3uxitkdeXJcgeGsM0g3pQqQTZGPmpYyTYgJNrducNGvUTw+TA1JONGdJ5nKfjkY/g+ppKrJtdd4xFM8EA2xTAwTuR/FHs8JiPW9rvQIGsowoe32zo1VU5IFrTCw4H5r2jXo+RLKvcuDJ8XTAJWPtsZzbKJA2jEZZfL8nrNZq+Adcyz22WVOANofrm4QB1atpYuVvemierWNz1CMu8elHfn+Rr3XTNPzyHUK7bVYWhPTTsnbovjtEQ2XNrvDvsBVTaxystLLgsO50XDIBXk+apxM22W3Wndfu4rQ2oqdzr+PTUYVnm1ZEkk6E5KsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNQQ4JlyEMifq4exMQKAozl+VAGJ569Fh7Ra1BcznpI=;
 b=CT1wl4gv7jt2lhZ9JcTlSsi1JfXHhC8LNyTQXy9tvg/HDw3djiCia5wyq0X79hETYgbVsVE3znoTelLKWdbSlQorFJW1uIhjM5p6jgl76OUvS9F+CWx4wkYryrWJexaCo2OWEZ0ro0ZmN/6YlIuomyiFrlyDw5nUT2I5x62XNoRQBMprYPeOTsLCJQquN6vP/L45XyTzLxqyBqJD0hEUr0lGwPfD72z5+z+t3cujocGkTHL71llBSY4aH43gljyzS5/OOI19hAGXX8gpdR+9uxT19Zhk3DDJDBPc34UOU5858iuCOQEkvoTvLPW+Nvn4NROgkRhmblBfKtONj05dXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS2PR03MB9516.eurprd03.prod.outlook.com (2603:10a6:20b:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:18:47 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 09:18:47 +0000
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Manuel Traut <manuel.traut@mt.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 0/5] input: pwm-beeper: add feature to set volume level
Date:   Thu, 26 Jan 2023 10:18:20 +0100
Message-Id: <20230126091825.220646-1-manuel.traut@mt.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS2PR03MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec10960-99c0-49b9-698b-08daff7e5486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bg9jTAlLsY52jw0j6rvWwZ11foQ8I3pARx9Mnwzh6u/TJ6incH9fNPBMBUcacaGav7GLMNM3VYc115ezSuFVraSCgNTQBH7YB1hK4yxClfrxOYlWorRf2dY98aaRI+37YXhl66K3no2jK7kGAwo/VuUurqSdKzGgURri1DXUI7q4IhcEH9wWBv2CVkXHZ7RO8RZZiglM8p9Z+Pgmh8R7A7sACVsnYbbObFTXozokbovnbB9XXAgpsrvKMwCCdJ0/cGArZeOup1NqeyPV0bG5HOQU+3jMGnky/3MNvd8WvnlIRpzR3h+2v0ptXsnPaqOJxnuB7+t//izloJjpwrzgejnaMYg77n6CigqTERVJRnfDge9Yuf55SUAVyCeGrWmH931PpmXSRSkzQO7K0fQGnH7OQE0iNo0Wnn+ztF6EmWQQs74DPJjMusUIuXER4p2pTlr2vd9kwCS80AGmlOiiZJl/7e9+BKvJ1LCg2ezb9rRzuE/hBq7DeL4qH9yfcj8AgkKhIaqPkj8Qat9nNYTMh+q6n3RnrNypqKO9WyzuBMHTuE4Q6yWhQF0QZ3Be9KDWdREKv8YawxlSaTSip0iUBgWES/jdKO6wpOyq/3LJvfOeqEawM0djmNfiHIDZAC8L7WuvC1ZLl95FN0crSUv/VqW+VGixVBTUeAEfsgZkHMb8yu4B391tddfv62J3wyXIO3HtpSztEIeXsOPpqiuaSOFXsUsnUDrWk/kEYjVzdJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(44832011)(2906002)(38350700002)(38100700002)(2616005)(1076003)(6666004)(6506007)(6512007)(186003)(26005)(86362001)(83380400001)(66556008)(66476007)(6916009)(66946007)(8676002)(4326008)(5660300002)(36756003)(41300700001)(8936002)(52116002)(6486002)(478600001)(316002)(966005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7jvp2w+S+QT4FqsPYPEreotwF9M+aCMOdmz8CaISZzzmD1eilvPjl/wqui1O?=
 =?us-ascii?Q?Atw9KV5EMaBpa/D1tihgRh+84diXVCWOMchFZEd1jF7Ql2zsucK48TG9Mc5W?=
 =?us-ascii?Q?7jbaJaPvLK/hLfQgBnVZpeezyN1RXsfruIrgTTRW00aSCkgF0xcVuX+vOefN?=
 =?us-ascii?Q?AEKzy45S5mqgqqF8P6tI2cP4560MXqQZRRl3bU9lKQcuEUxyb2vjwCPlBrdl?=
 =?us-ascii?Q?Xjds2ckGSIUK/Ba6XzcVhPEpD2RafdTsD4Cviv4exKMW3ngFJm+FeFIWbuLi?=
 =?us-ascii?Q?GNC5MHXS9gdyKGR5RM45TZMq0Gbpu1ekyfs/KYOsVXysbniRICvjNgvWoWfH?=
 =?us-ascii?Q?DGODKEpESDAYeuFDxruF7m/jTzPH4GrUEH3DOt1ceSS6y5o62frSnHTQ+rWT?=
 =?us-ascii?Q?+4bCPVsSg0LenMhJjROJJ9Ti6CtbGvSFIW5fLsDhGt++Es0YDWa7DT8qwEoz?=
 =?us-ascii?Q?b51uIebWOaBK4w9MkZ9Xxv68o5IvhJC9JrGMDHOaddxtW7Y3ZMacjxYhhM0b?=
 =?us-ascii?Q?ogUO2gCBJ9oArqXl46HcF2+QMNxQuMexWJb4d/Z/REYcvyGs8BJauclyeWqe?=
 =?us-ascii?Q?bWzv5BwVUKCPimDiK3uf6TkEPy8AvMa6+wQVU1RFPfXNxiK1i/5haqj7vkxX?=
 =?us-ascii?Q?2mwa3WAyJ3tTzER3Z8VYu2FOh7hISoGkNvcGQL36/y70n9uBX5NbdqxUCdHt?=
 =?us-ascii?Q?IOxi5S2Go286gLvRpqUPaE/KvEveqyfBlBE4somCM8LTc0smiXhrZCdrmH8V?=
 =?us-ascii?Q?TFwkCvhrYXdAX8gEtZEZ4rcggqSJ8qBtzF8tr0BlD+S1ub+iZsFbcA5Ddz4k?=
 =?us-ascii?Q?eniellT/G+S9l4JETllJilgBhdtOAJcGl52yVVM9QO5Vxz61LWDPUbpYjP4w?=
 =?us-ascii?Q?N2Vh5S0XruUKS/ZNi8l51GInOiQwHcuTN4CW9PHRrl7zfTb1AakRTirTQ/Ex?=
 =?us-ascii?Q?FsTNCvE11YycJkM6s8132Fe4MkytTdrUGRvDWFU7WrQSegBD8mpcucKD8zxS?=
 =?us-ascii?Q?pUVjQ2Ia7yqrFLgA+4eWFKIUM+0vsF+jEOFv5NX0jyRvioclHkTRpD6aVHEM?=
 =?us-ascii?Q?SEapQX0rNMVM2MAC20XMLzkk4DXro8syEdBhJ4+kUkqr0/uQe/9n1fNXQWt1?=
 =?us-ascii?Q?7wJKIye9KEaEzZKcgrs7m7rlrMz84oGTkAdS97tcnrTTBU7Et40WZlWOHJ3p?=
 =?us-ascii?Q?QkkFbzX2zFFmNJjnqmZiEufje6yyWYS3hhNllNk3RpkdX1HvTxT9Bzc4/6N0?=
 =?us-ascii?Q?UPOO1/al67pSbNm4DJrqr1yt1qHiMsewFAFbksWBOO80Dlg0l/9FacSLY+Lk?=
 =?us-ascii?Q?Yb4ARM0bbyEERmlAwt67zkhPNW9A/q+WovN7zu7TUkp/JYysi3GYwRttH3p8?=
 =?us-ascii?Q?ydzo6nKuDLSAjqZ3+HiWdI9d8wVAR4ySLlZ/jjetVQG7mixaENI/qHSjrRod?=
 =?us-ascii?Q?o8VrwS7TyVa95Y88CbEWTqdoeciLvk42jjKSr2O/Aj0ISDye0NtjB1mVAr0F?=
 =?us-ascii?Q?oPTFn0O1FfZmO3Uvao+Ki7iqbhviPqMO5c0Y29XXHSO8nJJgr87XdJQyYa7X?=
 =?us-ascii?Q?X9SufRRRt7ooPgmFOdQvvRQ5/5bgFDoVQLJV0WM+?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec10960-99c0-49b9-698b-08daff7e5486
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:18:47.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cnd5BrXogJ4ZLvr1yt93HDg1Qcopfb+LFplTvRIVU37gTSFkBVTQQsBMd/8/sRW09NnFvUuk3nabhzUdVx20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9516
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

The original author of this is Frieder Schrempf.
I picked them from this [0] LKML thread from 2017. Since it looks like
his email address changed in the meantime I changed it in the Author
and Signed-off-by, as well as in the copyright statements.
I did some minor changes on the patches that they apply and work with
the current kernel.

The last patch was added to fix loading/unloading of the driver.


checkpatch still reports warnings regarding the changes:
  * from txt to yaml of the devicetree documentation:
      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
      WARNING: DT binding docs and includes should be a separate patch.
  * and the introduction of Documentation/ABI/testing/sysfs-devices-pwm-beeper:
      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  I am not sure how to fix these warnings. So any suggestion would be helpful.


Changes since v7 [1]:

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

Changes since v6 [2]:

 * Convert devicetree binding documentation from txt to yaml
 * Use DEVICE_ATTR_[RO|RW] properly
 * Change Frieders Mail address
 * Added Signed-off and Tested-by statements
 * Fix module unloading


Frieder Schrempf (2):
  input: pwm-beeper: add feature to set volume via sysfs
  input: pwm-beeper: set volume levels by devicetree

Manuel Traut (3):
  dt-bindings: input: pwm-beeper: Convert txt bindings to yaml
  dt-bindings: input: pwm-beeper: add volume
  input: pwm-beeper: handle module unloading properly

 .../ABI/testing/sysfs-devices-pwm-beeper      |  17 +++
 .../devicetree/bindings/input/pwm-beeper.txt  |  24 ----
 .../devicetree/bindings/input/pwm-beeper.yaml |  68 ++++++++++
 drivers/input/misc/pwm-beeper.c               | 122 +++++++++++++++++-
 4 files changed, 205 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.yaml


Regards
Manuel

[0] https://lore.kernel.org/all/cover.1487323753.git.frieder.schrempf@exceet.de/
[1] https://lore.kernel.org/all/Y9AIq3cSNzI9T%2FdU@mt.com/
[2] https://lkml.org/lkml/2023/1/24/379

-- 
2.39.0

