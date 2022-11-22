Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E13633A41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiKVKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:37:30 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1C22284
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMMmqydOLsiMO8S9FYJIh7oCzSIiTipAfNHY41S9T90iuN1+gHrTFSMw6Ft7nLVfYBOOpqo4von6pfjRzruc6UnHegVVMuPRg+bhzL18t/mAV716uA7jZTs66u6RlJ14/9Gu7kLIqTTaE2+5oye3xjro99lSXgcj3nrs2li5H6YaRc0xYBcpANlaAP7bjwvgjUsa0gHl+MBd+IZAnluB1GcyPHr2mTnxBY9jGOF0I0ChA+aT9FVgJhr+bNjqHd0CF6xe3NN5XByyF0D8pq6yNQnnyrASIcinAYusBn+kCMB3M4o6thmW/PJLi5os+/TL0Fio/3ZwIc/eeV6bb15EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B5Rhk60ufhQEaaktVf7qc3Gy7vU8rH4GMlQ0Ex7tPE=;
 b=AIjtudtUxY9yg03nn4KZW3cLp2Mn4QnIzd8e+g5HMl4Bq50Trt7kL2gxSYvLfFJk4usnrfCX2KcNhtvNPPTVroUpgZtfeCijt6fmvQmN1Bdpt6B9CS7JQ5krulQc2xD1FE1Qkyfcz8WM/8OW+dRmiiW+G/pO9wqDngtj1jBmy4TQJC7shX8us3D14wu1XnCXM6TK6dPOT4Gh3JnsOTAwxSpJwa5JB6yaCsk0gO3lL02szwCm1dI0TxIWT3DksmZVW23NSdsOMudJrPPSk8jaHjPNc1ZSduqZU6jBuhGgvGZLkMX561eIbu1MMmCRoG8x+Rf3JI5GrCE/xYGn/ufJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B5Rhk60ufhQEaaktVf7qc3Gy7vU8rH4GMlQ0Ex7tPE=;
 b=lR1BR3bN6OiXsxsuihdi8YkaSC9X3951DixO/ke31C6pLlThIk7IuPMWpJwr9JfFhmWHVVAUCty7MQf6yLX9r65rUaV2yfn/LC1ucMR7oUf4QFkwDpSwaicPNOjNJJzZRYToHpTMdT2VOzKVY11U5UiVZodWGOO5InL7Fr3QV+fI26/mjJlYtIeSV6zCyJ25js24Seip5KPcsqfwWo4DxyETPyRV8xIxmhTAn5gPVcRTHcyy0zUL/PL9VDHj+mZlwOjs7s1LVj0HwLuLaG0qG22EjL6SgMqkVB9cvmaGwpk5qeaaQlX5j4lR+HzUUiuI09J7EwvZRwGn7tRI+Hs6nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB5917.apcprd06.prod.outlook.com (2603:1096:101:ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 10:33:04 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::74e9:fcb5:b763:4a61]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::74e9:fcb5:b763:4a61%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:33:04 +0000
From:   Rui Zhang <zr.zhang@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Rui Zhang <zr.zhang@vivo.com>
Subject: [PATCH] regulator: core: fix use_count leakage when handling boot-on
Date:   Tue, 22 Nov 2022 18:32:51 +0800
Message-Id: <20221122103251.13064-1-zr.zhang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1a039e-3884-4e11-c386-08dacc74f010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLdZlwpYjXCNsEp2GL6l6rDr9dp7MbtF+6w3XmjrT85qtLXQfpINVAw9x36S3Cdm9IrmzX29XBmBnJ7Ozq19PTY9LydVhfn9zHZLQAbIvkxN4ILT8UUmY6QZIKyAtlI3YEFXlIa4ZtPwSVNebudDEcdWh+eRb/mQKAZiKCQer6bFWdd5doU/CNI8UevTKGicPfCnSKGkhckILxy6NI8SpLhSENGBgwngt3w2ckVyh5KJiHnh+BeXqZHIae4A2vbvLWTkweoo6U4YfcZVO6y7+233Kh7Eba4xMP6kQNjQPA//I1D7JS8wGwggwDqmiZyeWrq9A6r+iC66H1X6PQq2TX07XOE/VHNKZc6zYdTEaS8SzZL843rdBYuZOilsrzQMUQIFp97ROpiTqhs0A6/6z5047YY0iUZtHGJGQnTuQrsfL4Njm/NZGX68o484OhxnKCZWYXzu71zIrXZGx9nNuRF286VkHM3MXQmFYkRXBK+ZrfrrcQXfUJtzcNW0rj1cfmyde+deWxNTiB589G4Fj0P+u0Lu7+J7YFQ0U0sRG5yP016y5U9/wZND1nrIk8h3IUWzcl5fUGcrw6N6gbtnVQ1OwrOYgSIc+Ag28noXhcfPdW/8XmhP3vwRpwoZUs9MFAotNByYHnJrLpn9jeEZQ/6z+wPulvi1ieczEQQ4iRKL0/JvwFFvrKx8V3gJmoVn6r0UEqKvaJbZ2lk/ESnPDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(2906002)(1076003)(26005)(83380400001)(110136005)(316002)(86362001)(2616005)(36756003)(8936002)(186003)(4326008)(8676002)(66556008)(66946007)(66476007)(41300700001)(38100700002)(38350700002)(5660300002)(478600001)(6512007)(6486002)(52116002)(6506007)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVk2SmtTWlNEQzlqRTJza1pteEN4TFV5WVJwNkpkc29kWlE4Q3EyaFRZQVd5?=
 =?utf-8?B?TXJQNnZaVG8zYnZnSEJzMlpha0lFVzNXZmZZTmV5U21vMUpXakROeXlWZTNt?=
 =?utf-8?B?eXJvUy9jV3Uwb1Z3UUw1OFlHdlRvQzE1encySE85NGhPSHN4T3FrOWZqZ3Rv?=
 =?utf-8?B?K3BFcHduTUNvVFhzMytGV21jekVRVmRSUVFITG1vWnhBRFRhY0Y3VC9LeC9w?=
 =?utf-8?B?dW5wVXIvU0pkdlVYOCthb21nRGZXQTZrMDlCU1NnNE1sZWpZK2VNTi91UUhQ?=
 =?utf-8?B?OFhSczd0NDExWlNDVGY0OE16SVRUVnh0VFptSGpxWU5WRjQ3TCthaWIrNzhS?=
 =?utf-8?B?a3BvWjczVURRb3UralQrMlFUdCtEL1ExeTM2QzE4dlRoVHdBUkxDM3FheXVY?=
 =?utf-8?B?YTJuSnRVK291QVdBSVFLWHo0K2N6L3IyQ3RreWlhdUFFQWx2bi9RL08yWW5E?=
 =?utf-8?B?WTV2S2s2STU5QzcvRzJNSTk1Um12Y013ZFlTZ3BhNHlXcUVyUmdZVDF1ckRl?=
 =?utf-8?B?YmJxVk5XUU52bDJWekFzYUJaZ0JTcjl4dmZsZ0JCYS9iNlJ3NzV4bXV3amxr?=
 =?utf-8?B?RSs5QXQ3NFNyMnQyV1lvZDIrbUFhaEt6YlhkSWUrUi9YT3ZNd2dTaThld3NV?=
 =?utf-8?B?eHMxdFVHdlp2UjVyYmxhcXV3VjBGTVJ1WDhEaWs5eEoxbHZOZENJSURKRFVR?=
 =?utf-8?B?SmIxbHBvYnc4Wk1sZldoMzFPUVNmR01qREZJNkVGaDZYVUpBRnJxUk5OdDFL?=
 =?utf-8?B?dWwwMTdzM3lpUXdqUC9xYm1QdHhvVVpxTUlncEczc0VIbzc4OGk3VGlWQnRm?=
 =?utf-8?B?ZmYxT1VteGwxRHQrVUN0MGRPTHBDR3ZSZWhqeURYemdYSlBLZE5XdDFBNVh2?=
 =?utf-8?B?L1ZWL3M5bUxSOVdzME9EZWh5SmQwejZtMHc4TzdGeVZxMEQ0QkNUY2FTYTdU?=
 =?utf-8?B?T21acklmUXQvRmM2b05ZcnFJYzg0UndrU21oZTA5MWE5M1FyeTluZEtGaVVG?=
 =?utf-8?B?QlZDOStJNXB5cVRuRGRBdm42RExpT3ArelFCOG5ySmNLbWxpN1lyRVdOQ3hi?=
 =?utf-8?B?ejgvWGNoKzNXVkxBWVVVTEo5QklaSkpKVU1IMnBlVDlKOTlORFVNdUlSWEVx?=
 =?utf-8?B?VWowYW1BMTh2Tm8vc1lYb0trREJTQ1kyejgxY3U3by9jU09yeHhaakluTVZT?=
 =?utf-8?B?SWpKcmtqd3cxdldMbHJKRVFkNUk2Z1F5Vk1pQWhFRVVuNTRVT2sxKy9EeCtP?=
 =?utf-8?B?MWpTa1k0L3NETTc5ZTlaT2R2RUZYZFdxcldHSzV3d3RqRjFwbkZHdkU3WExS?=
 =?utf-8?B?Tjl6d2xHSTVVRGNMRWN5OWEva0dua2RXY1ZKTnBsRzZmUUkyYUpWdVVBUHU0?=
 =?utf-8?B?czBIVE1MaUpVeWFtN2VLVUZUMlZESzZvWDNkN0hxZW9CRHF2aVFmQ3lWWXNK?=
 =?utf-8?B?aFZ0Yksxbm00eWtaTjFzdDhDZytGNFYyQ25pMG1VUmFNSkNXR2tJVXJIL1hx?=
 =?utf-8?B?a2dIcTUwdGtPQlZTU2FiM2dkVEJXNW5BQzh3RWR1WjYvcGRpa0o1ZXpmWGc5?=
 =?utf-8?B?dy84RzlZdzIwalFOQ2ZTZGVOTlp0V3FEa2FTaVljZnd0NFQvd2oyYnZzY2N4?=
 =?utf-8?B?cXF0a0JzOGpzRmN0cEdQZHFPWXVXN1ZWR2tvTU9iTSthVkcwcWdJczhWNjRX?=
 =?utf-8?B?d0tDMDBCZ1hpVnkxMmdoR0NUN0pwMFk1SnVFNHZPYzZydGs0N0FxbWVZU2xL?=
 =?utf-8?B?TG1XditVMVRNcEpaMXVKY3FYNlhwRFM5UFZjcTBEcVJTQ2FLdkwvYm8rZmNi?=
 =?utf-8?B?ODRCU1NFSXNnQzlCeGw0OVYwbEtvUEpPNmkvaFJpbFFkczZsSGFUOHFpZndJ?=
 =?utf-8?B?Tk1iT1RMVjZxNlEvc0pWcnYxOXB1MnNNblZ2dXpmUnk0TUduSmdLdzJ5QUYv?=
 =?utf-8?B?WEppcG4rejZJY1B5bHpoMUhKZHUzeEZzbkhDMUFkcFFZK2EwUlBEMDZJMHQ1?=
 =?utf-8?B?QmYxem10QXhkZVpyaHI5N21iVTNQTktUclowMXpXcGk2SktpRHpWQ2gxa0xX?=
 =?utf-8?B?TWVCS0ZvSFRCL0poUnQ2MDloZit3Z3NtTUxicEpKMThIRStMYURBU0k0Tk9U?=
 =?utf-8?Q?FLghsekRpiJAbEHZPuP4seZ8x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a039e-3884-4e11-c386-08dacc74f010
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 10:33:04.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnzXnfa2Z0yuldkuIXSK4f36YDIVKRE/jhRfTCK8a3aJnh1BrtxopYZ7Ny6NZr/AO0hmjg61+4d8uYDiP22SAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5917
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
