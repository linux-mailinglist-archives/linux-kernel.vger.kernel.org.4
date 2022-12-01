Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6D263E791
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiLACPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLACPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:15:11 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A9287C85
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:15:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv5AUAcUpHJOa6wvUoLq1UJ3ZERRxX1SRg0B+rtTvjtu0dacmWVJEV5ajY3qURRgKMpmFQSSdPU6r3BUD0LFNNGQvNFJmJRaeu2k6ORGkCzbYa/QwU+4gHOkVXr7XOkzClb52aqhe1bJGRjBpw/zLV3UD/0fd4Kgsym7ZH0t1E3eBo/RgIO2t3GJ2TF0hiKEYT1TpRhl7FyY9F1uhBXThYRjrz3s9pXPFUEbRECtGAOI8Hu2hzcJghm18xTnhwUJGVesHIPoI32sg4Tz6CttfTXapuhrpOFM1x+hzn20UStWDFnEwh2qi2A8ipQMNN5Ax7YbGi9FOsRXfsWLlCXm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kyf+3E5zhzdxxdDFoIOCauprh7+SW+0OJv6GsLJdFQ=;
 b=mrluid+uL1LE8XoMjl2NhVEr1W+z0q8iWroIUTt7xtW94AKaWn9uGbT+aSc+CF/esGqYT7PN1vR/8HiGSp767BzeH9NcFG2JVuRiuIbqzwVN/1F0wJCSDVnqCLbKGspeh4/DrLLqyQOLSCSy2uR+c3ucdouMfTDyXAQ1/K0ceQAJG5HN9og4a/7x5/j/6Kf+UnmnCAYZCMyJBAd4BYnK/bvKGPZMk6mFjYEeN5UpELR/0qNaDwJlR8AyzbRN47SyGtOwu+fZ0SyXifvIzJ51OZWe9Z+1pKjA/W2zvIduspSySPq0S1EAvwzzrC8Q5K/+7byiRNFEsaiC8ehOZDi5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kyf+3E5zhzdxxdDFoIOCauprh7+SW+0OJv6GsLJdFQ=;
 b=SvdvlYt/8R5xr4YArHLpE05LaDddQYzMcaW9gn3+AP5ub+Gwu/y5ck4p35sPjxcjXuTW8eKwLVFdITGnIbUeiyNAFNd4RplFjcv4RSVCbNh0ULPrqi4YCntMsojOmKD2JYHGsHrUN45hTDwM9zNt6L7FWNrn8SiK7pYKvo0V1UYYlLw9KZIrX0JwPgTjykfsAbnN3jNtPBGwSCpykuxMUlAc1aJhG04Z+JsRVeta/qbsC4hNyrZOJOyfjxMSkFU9+C/yVb7XH8fUY1kDQCgihrAKv0pmzCPnRtVJfJXD+2GDtLDKEUroRBVre4OEUJWM+kjO5f/ZdZWXUS2ejDkIPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI2PR06MB4539.apcprd06.prod.outlook.com (2603:1096:4:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 02:15:04 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::1a6b:94bb:3e8a:bdcc]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::1a6b:94bb:3e8a:bdcc%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 02:15:04 +0000
From:   Rui Zhang <zr.zhang@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Rui Zhang <zr.zhang@vivo.com>
Subject: [PATCH v2] regulator: core: fix use_count leakage when handling boot-on
Date:   Thu,  1 Dec 2022 10:14:48 +0800
Message-Id: <20221201021448.2371707-1-zr.zhang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI2PR06MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd7b1d0-9391-46dd-41a5-08dad341dc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2R39WeDoJjAaBM9MP7kYBOc16hjQJDUhwjs58qhh+DU8SA+eaVwBe5ILbhlUld3c6lUTG3bKayBz/CQuB7nWpLc3z1MPqbozp2P9riZ5DP2OzzSb0PGDBdmiCUqaJgb6I7wit0/rA5sN6DjIKsYlg8Zjny8uXIQcvtd1Kyp/O6Fv00mNdyNOl548/4i8cZ5fwqlR6Ow/g6x+Gjy6mL8eY4rDE0MrVMGRwz3C2zjGrcdJP7bOwTLPwbTXW+RcHysRn6/CgYDtZ6/LQmPChjgcTy9YHRXbXF59gGyOMIrzsht9TTA0bEAjSv0QL8wjf3z+PyvaDOU6YHDk5IaYRpSHuPePebxcNdm8yXEhpt5SyerBbnjV+Yii3JJ4U3i1aFXpHQqSht+vepK33EJAHiMRbSssVgKXHqZ/ufHSQpzJ9w2Te6IRi4VSVIGthMnx57GFAMXnRFXAes0wMywt/buQP8R0pD4OoS07i0PuW8xbTcpqXDHtTB9ptPy9NSzKMGreOwvkEjaQYaFIbodhOXIUZ5YwbR+W6Ja2bvbGUjgl94B/MCqVAaBumHPpl1ZC7IHGHPGzgmQMYE8lHlWM7sexYcBvQ4JGvjDghRQNjkZ6kmtL/AnsngN2oFXC0c+h+oDPQ8D5sczI0G/dZtJO17utyyWJi7kO8beg1CntDoDVITMB1+d8E12hmNKgldUWCKGuhlf1Qsja/4MVY/0E7lPRYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(83380400001)(38100700002)(6486002)(2906002)(86362001)(38350700002)(1076003)(41300700001)(5660300002)(186003)(4326008)(52116002)(6666004)(6506007)(26005)(6512007)(107886003)(478600001)(316002)(8936002)(110136005)(2616005)(36756003)(66946007)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWkzWjhTTUZ2aS91enNDazhTZkV5TWpFNE5oSmRjYXhwZnh2bk9RYmVYVmo0?=
 =?utf-8?B?UWE1UFY3ZksrTGpoYVpnUyszR3Z2aEpOQXROekQraFZicXhlVGZqUVJ0Y25Z?=
 =?utf-8?B?SFVHSGx6QjI4TkFMUjdiNVNZRWpkTWtYMktBZkIvVWlqcVRhQTUxMmpWVWcv?=
 =?utf-8?B?VW42eHE4NS9hdURtOFBFRGQyZHpGRHA3N2s5Znp4c050QlhBTkN5MUYxV3ho?=
 =?utf-8?B?d0ZsUVJSTVl6RlRWKzdjU2ZYbU9EUVFOaDZkL1VQSVRWUzY1amduUDIxaHZ1?=
 =?utf-8?B?aVVQckpiR0xqL0d1YmNlaHFlUCtjS1RnYTlnV090VGcyR0tEVjF4bHdGdHg4?=
 =?utf-8?B?TVpjOTd0aXJMOTIrd3JkaFhYckVlbSs5Zkl3cmx1cXpMTktzWFR6MEpFajFk?=
 =?utf-8?B?SWdXMjFYTWNSVnpORFNMbThwZjdOZTJ4clY4WmdtdnIwbkVlYzNzZHJHeWR4?=
 =?utf-8?B?REZ5RCtBTWdxd2Y0aXVGT1V0dzY2cVhvZ0lTZzZtaUV5cEhUa3lmTERUZU5j?=
 =?utf-8?B?YWZ6QTI5RVVrb3ZzL25JZEt6dlpaQ1ZDU2svTWh1MUdsYW5XbEZoSmx1WWMr?=
 =?utf-8?B?RDBHRmdYbFRNUUsyS3hHeVFiU0dmREl6emFOK2I2QWpzSWxjUTAyS3hYK0xZ?=
 =?utf-8?B?RWtsQnR4YkdncFU3RTJzTjg5ZnZGMHdxc1c3ZVJLT1E5aC80TmpEdGZac3JI?=
 =?utf-8?B?WHZVSDMvM3pxOUNMemowOC80VHJWR0JtZzg1SDlvdVY5d3M5ZHQrenFtKzcy?=
 =?utf-8?B?NWhoRHlvMHp5ajhWVG13Vk9PZTkrZEVHaFNOQmtLTCtwby9wVDJtUkFGR1Np?=
 =?utf-8?B?b1VLMnVoQkRTczlSRmV6bnNJY01oUm5Da2xZN2FaU2RaWDJiTloyQmQ2eG9r?=
 =?utf-8?B?OHg3TXk1Nk9vQVYwYXJPeVlTRjFxMjhkZXFENTFjYlpwa2Z2c3R1M3dPNk0x?=
 =?utf-8?B?NHQ4VmtDYTN2Q2d3bngrRGE3ejNRUDlIaERKMVIrcjhsNUZKckpyNWlrWGhZ?=
 =?utf-8?B?anQzUUk5VC84czJtWk9xdXNXYk5vWEFqTFpXMXdPeWNZSWtIZDZBZzY1dUZ5?=
 =?utf-8?B?YlNlNENOMjB5UzNHVFgzWjVRR2xGanVsakhOaDFzeEVIeHAxVE1OcXl3OUFC?=
 =?utf-8?B?L3F1SnI2WGxzekR1VHJ3cWxtZm1wQlc1YjFDQWpVQ0pqUzFkQXdBQVZrTkcr?=
 =?utf-8?B?L0o2U1hBeVo0OGlOVlVCRWdUbyt6SjFySkpvVkxZeXRoZTlPbnM5bG1QejMz?=
 =?utf-8?B?R21mWWxlNklwRTRUdUxXL3UrckV4VWZBNEVaelQyVU5WRDFHOWhSU1h6akRq?=
 =?utf-8?B?aVlKMGNEVEVFRWlUamsveitwRzUxOGttbkNZUWtjdFBVVUtzQ1pxa00zNDlP?=
 =?utf-8?B?ZnRlc3hKejBpV2N3SVhFZmxDbzNaR3FKSWQxVmF6RFA0cDM2enVNZXA5U1Vl?=
 =?utf-8?B?Rk5ncjlJT0F2UWxTTFNoOTNqSWZ3VHJUb2dmQnlCWWxiZDJ2OHVoK0t0YmlY?=
 =?utf-8?B?OVBJd1NGaytKN2ttMDlCTC9LYjR5VXNoQkZJUkFEeHFsUjZ2OTF4L3N0TFNO?=
 =?utf-8?B?SDNJdGgxZUh1SDhPMWk4TkdkQUhzZDVMbGVOMExRN003ODRaZC8xS1E2T1h0?=
 =?utf-8?B?cytrRmZGczZFVHk0L0srUGhrOUg2SzJ3eGFHZzJ0am5INlczMkx1SW5oemNa?=
 =?utf-8?B?bndaZUwwQ3IzWEtPMXhMSE5iME0xRVZzWnJZVTB4V09HeWpCa3BHc2RSMGZM?=
 =?utf-8?B?Wjg5RVRPYlpxT2lUdWZJNTNWK2pEZHdjcnVNYzU4MFUxVnMxWUl3b2w5ZU9C?=
 =?utf-8?B?Tk1UbytkbUVCS21Ec3lwWnp2Q0tGcWVYZUdtQ05BcnlwUkRaUUFNSzIrTmFi?=
 =?utf-8?B?dlhPLzZyQS9IVUdsQm54anVXTWxxTll6Q290NGZDK2xmdnlwTU16Q0w4eE1o?=
 =?utf-8?B?bHVyTStESFhyNnJJZVZyOFVLYnFNdUcybEhsRTB3Y0RGSXNlc2NhaERKSWRU?=
 =?utf-8?B?Y01YSEJ0Vzc3aUtCWXRzcHlldzExSERsSTRWSVdtQmhQaHhaNGFibkVCM0NY?=
 =?utf-8?B?THdPYjM4MVg2KysvMFpzb3RaQmtoK014bk1Va2p1OVVBU013blNWbmk0WU10?=
 =?utf-8?Q?kJY7Rvz2COUUpMCDuCajxhx+/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd7b1d0-9391-46dd-41a5-08dad341dc11
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 02:15:04.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNuXP5uaN+6vi5tQy4mX5cd9mSRbbkuYl+M4yUQwgJ+x6bRI4oCf+1gdS8YFz/I17wDu1hjv/mjaB60UogNfzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4539
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a use_count leakage towards supply regulator of rdev with
boot-on option.

=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90           =E2=94=8C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90
=E2=94=82  regulator_dev A  =E2=94=82           =E2=94=82  regulator_dev B =
 =E2=94=82
=E2=94=82     (boot-on)     =E2=94=82           =E2=94=82     (boot-on)    =
 =E2=94=82
=E2=94=82    use_count=3D0    =E2=94=82=E2=97=80=E2=94=80=E2=94=80supply=E2=
=94=80=E2=94=80=E2=94=82    use_count=3D1    =E2=94=82
=E2=94=82                   =E2=94=82           =E2=94=82                  =
 =E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98           =E2=94=94=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98

In case of rdev(A) configured with `regulator-boot-on', the use_count
of supplying regulator(B) will increment inside
regulator_enable(rdev->supply).

Thus, B will acts like always-on, and further balanced
regulator_enable/disable cannot actually disable it anymore.

However, B was also configured with `regulator-boot-on', we wish it
could be disabled afterwards.

Signed-off-by: Rui Zhang <zr.zhang@vivo.com>
---
 drivers/regulator/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e8c00a884f1f..1cfac32121c0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1596,7 +1596,13 @@ static int set_machine_constraints(struct regulator_=
dev *rdev)
                if (rdev->supply_name && !rdev->supply)
                        return -EPROBE_DEFER;

-               if (rdev->supply) {
+               /* If supplying regulator has already been enabled,
+                * it's not intended to have use_count increment
+                * when rdev is only boot-on.
+                */
+               if (rdev->supply &&
+                   (rdev->constraints->always_on ||
+                    !regulator_is_enabled(rdev->supply))) {
                        ret =3D regulator_enable(rdev->supply);
                        if (ret < 0) {
                                _regulator_put(rdev->supply);

base-commit: 01f856ae6d0ca5ad0505b79bf2d22d7ca439b2a1
--
2.34.1

________________________________

=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=E5=
=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=E6=
=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=8C=
=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=A8=
=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=E5=
=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=BA=
=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=AD=
=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=E4=
=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=99=
=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=E7=
=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=
=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=81=
=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=E5=
=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
The contents of this message and any attachments may contain confidential a=
nd/or privileged information and are intended exclusively for the addressee=
(s). If you are not the intended recipient of this message or their agent, =
please note that any use, dissemination, copying, or storage of this messag=
e or its attachments is not allowed. If you receive this message in error, =
please notify the sender by reply the message or phone and delete this mess=
age, any attachments and any copies immediately.
Thank you
