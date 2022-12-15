Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B964DE30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLOQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLOQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:07:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2125.outbound.protection.outlook.com [40.107.244.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215113135C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN2118Zas79QcDnzZ26NDFqZuQfc/nLwssPgscD4MJ8Li1bInR1XnjStDWcUF8o7UDjcZn2bP9YqEh2S8r0QVVwv2UJudXGtvW6wSA1Lwdo2vyzjXugnQNeeni7T93+5IU5VXr9JcKHZ+XXDlEzJX9+hi1LIIlztyOgo6klfFYhEzTtCAXj9OLNGm8sbmHUY6Kq3j9wslsbIJf1iP++Rv3EKNDYJrxYAFRbwQStHSieElRxJcw5CRc0w7vHdKBJ0xNSPjcjI/WmnL1GIRa416l+wHAIn18868uOeZeap8gIqU7ilH54YJszl63DQKNfndThR9JsvniqYld/xSPh4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmaaExN+98wx84MlxTV5KfSpFdzmFTLKLNcPaza5tkU=;
 b=UfB08WFFhmklCxe49LReR5B5+NVgjuH+MaEKSSfjZtyjq6uZB5bN61l2rLx+zLtd0r0XzKfWsk9yISN+TEx3S6QH7XOiGBhAG8yzRYLsMTedepAGJQ1w6H3AqqwDD+1OraxtaX4FOBg1/LOeNs7fkC9XIptEzmTMNYo48vCQkBjg0QyiMkyDDCHxaOjnLKcQPwg1TI5W7lQXg0xdIEXkLX+lfHR5PDPLyCKXMW7WWTJSZVGXNGHVXUwL1iGfsM+DTq3tYSh/J7MMmB0iJgmurZgoQyxEKFHrONqWpo0IfyZe/iMyDMuX/WnnzZKlWIBPENhHsugYMwV5+jylnshDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=designlinxhs.com; dmarc=pass action=none
 header.from=designlinxhs.com; dkim=pass header.d=designlinxhs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=designlinxhs.onmicrosoft.com; s=selector2-designlinxhs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmaaExN+98wx84MlxTV5KfSpFdzmFTLKLNcPaza5tkU=;
 b=TfRNriO8B9SR5EO+0mOZBGW+HsBv8I6hHy+imYK1EK893HcT1vW3KXZk2nVDxLFhw4q1aZjE4Yr84sH2dmFP6kBV0vhxzGmu3huvVDnfK7dbzhrp7b4k+Gvk1XgvFeos57XxT01ofAc2sw/Mkd9+ctfkO8tLFbqAt7XszGS4lpY=
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:a03:3f3::10)
 by SA1P222MB0359.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:1fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 16:07:15 +0000
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731]) by SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 16:07:15 +0000
From:   Kenneth Sloat <ksloat@designlinxhs.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kenneth Sloat <ksloat@designlinxhs.com>
Subject: [v2] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM mode.
Thread-Topic: [v2] pwm: xilinx: Fix u32 overflow issue in 32-bit width PWM
 mode.
Thread-Index: AQHZEJ7bv2gKFs5+xEGDSHiKdkn4og==
Date:   Thu, 15 Dec 2022 16:07:15 +0000
Message-ID: <SJ0P222MB0107490C5371B848EF04351CA1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=designlinxhs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P222MB0107:EE_|SA1P222MB0359:EE_
x-ms-office365-filtering-correlation-id: 23d6cb3f-520e-4fb6-260e-08dadeb66f36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELJWvuQXJtwmin4G6Su/PGc2KfCw+zXhIdW6TbOGEpw6eKDHqnOLH0FhXzczK8yGJNcybY01z2RCxUwJ/oHtX8l9RssZV57yt+t50zCkW5I9EwG/xDMWjSF9Vr6wOwCXj4NUV6Qx5lMvlRnFss/avzh9GNCySUv7OT1GFd9GMzSFBcJhJRouPvRrwohZGtjSTdm9dOs/3+PjxndgdxN5DkzjSTeQLNTJCxQEMGe3pvowQd8v4pF6zFIa75zAGYiT8Tyjd6hGCzltwTaTuqN5IdEsgdSK9gAQECmbeAeWuAZcpVZpz8BlfrNuX5umdnuoHkA3RvcloymFJEgkAmnsuhfFMEADaG9PdmwLA2Sz6PgHjMcpkmzTgrvaMZ6TPEpuGkcMjF2Pu2joTgA6ehPpSc7jvt0DMjeR8H9yDThA1nY68eFxxb4iUM2MKy2wGcuZPBUbHX8cPA4zqBW6CbkprVZ+ZI/YY2QmViUIafDxv3plI6vvMqgDA32i5fwyH2HLeZiYfJCFLtKSoXhumwuopTIWoKGcbYA1Sy7mo41r2viLDLsGzKXDBSMj+DlD0x2cVXluVBUQ8a63AlB+15sji6dLiZrLoKcZ/ljrOylLtQaKAXMpfAlijY6Ob4Pje+egaDX6VbmSzz22b2MYxG+ZpWSqs+v4PQ4l3QNwefUM55uuZ6VgufSXb2cF9pJwsXABIVXqLEA1N5eEllV0LcOBTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39830400003)(136003)(346002)(451199015)(2906002)(5660300002)(8936002)(52536014)(38070700005)(316002)(41300700001)(8676002)(91956017)(66946007)(66446008)(76116006)(66556008)(66476007)(64756008)(55016003)(110136005)(33656002)(71200400001)(9686003)(478600001)(26005)(6506007)(122000001)(186003)(7696005)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cdM/1wk/x/x36tRU3Ee99LKPSE0T7AV/qySzQrVc3JZmyOMmcE3nPn0HqK?=
 =?iso-8859-1?Q?0SzH+Mg/BHyjwgV9hDXrN4ppZQiKPfajNPCUyz/cfTEz7IYJMS6TYBpPLO?=
 =?iso-8859-1?Q?fMw2v00WWFUPRx5eY9VYVJERaYq6xCBv4emhDrollBv4z80UjIm1QDXf3f?=
 =?iso-8859-1?Q?los2XJmdln+JkgS7UsMTpHIpvLmQgRCpd4PeSdgbC+avTrU03Ru2SKiEQF?=
 =?iso-8859-1?Q?UpEHcttXYJcMlhR24pta7U2cD97Cb989F6BW3ut+LK/4LDu+yiaQNiYOL3?=
 =?iso-8859-1?Q?CTRs7Npq621GxDY0fL1oTSCmuQKfzvgXxgdhwYfHAsCKH9m3iNKzavQSSv?=
 =?iso-8859-1?Q?vAyFw8d0t5woTbLhdnR3jgQg+FDht83FeTO1l/KjL2FAXnZ4QUKWsnqxeL?=
 =?iso-8859-1?Q?moy7KprnFrDeufH3FpQVfQ8NxaioUkvFjIN+//OSFK+k90C4uyzUf6GvtI?=
 =?iso-8859-1?Q?QknbUMA4h/EfC5KUzBFw2Y6qMdsZOGR7KR9e0woYJ037CRtxc0fAbdnTbi?=
 =?iso-8859-1?Q?Eu64q+BewkTS5qmIPknLqaEtWdec7n81dO1WNTn8fD8U3Y9jNsG5CbtzMK?=
 =?iso-8859-1?Q?77opzhREf4dzrlAi51WZA0VwdMkEGS2VIpp55i1Zo0x8U6VD4PUHCzWH+A?=
 =?iso-8859-1?Q?20mFpCXZCsXBwciVjnUkmxVghuhOvzaVWcWVBCsN3T4nloRJIsQ6P6kGNc?=
 =?iso-8859-1?Q?AM1rFnEthdyEb82u1p30r9P6KiVWxDqgESNoi/siQ2OCZPrlHA/MEzoJ7r?=
 =?iso-8859-1?Q?8d7IAREPNHZ0OqbsYsWI9lS3XjncDGlI6W0e4fZbrwlb/psGZcmKZ3ucW+?=
 =?iso-8859-1?Q?xsHJn4+v3zrFBsYXoeb8jW4YAZDcPXTJ8744QyGHSrJzsJpXbnbyRT6TPa?=
 =?iso-8859-1?Q?POXZ/RrsA7d/qVevjpzTTAo3ca/jwZqbQDseKsy51UTJh/BWomeUEeV6cq?=
 =?iso-8859-1?Q?M0NFkhlb5hjNdIGWkcoBoBbJCciuH0mAsBomQCbRRMyCAN0R6oAIocAjfg?=
 =?iso-8859-1?Q?woaGYhocLOqEJ6ihCnFpyo8idDq+D7gQUvSByBu3IBR+kCM+4gOYx1EDms?=
 =?iso-8859-1?Q?Nylr174QU+RmYmhxNDclEv4f0u/ZGdbFtpD3jeOyfMtA5sDI1yOoL62Fqp?=
 =?iso-8859-1?Q?ZzRq/7797aa8UQm3fLq4ew5L/qqg18eygZNz1hKQ+OK3iFMEGQJg0+96/x?=
 =?iso-8859-1?Q?GLHMZaOnUiIwzqT+PnxP8DG31rEC876w6xnVRHqZHuAhrUqq4JF4/SIgk6?=
 =?iso-8859-1?Q?2FjyZjUR9Vcs8jhlqDNADo7RDSzHrqkrl6qsOuLN5CDdAqN31fgz0y2Emd?=
 =?iso-8859-1?Q?FnynaqcuKNwhAJjU/kyjiKV3YaBtc7oSeUnrKe6HiS4hz+V9HW8FCFWP2T?=
 =?iso-8859-1?Q?5la05jyB48uOdAnD3hy1y/juzzcaswjlW9BiAI52Gi1kt5VPgkBF41bTKV?=
 =?iso-8859-1?Q?8HBmyILDShrPc9AD3V/M5Ue9WpyGZJBtlceYTQKQOHCf3hsiXgg1gzisC/?=
 =?iso-8859-1?Q?xde6YbuBKot3EuvMAtxb4AqD/E7jKO5WTMuDBhJ946y4ac4w1imrhgJs+6?=
 =?iso-8859-1?Q?uVxXNNDeJ5CutmWWyC4PwcXAhxtYB56JNjxTDzDl7RMN4mS2SnPAc/ow1n?=
 =?iso-8859-1?Q?/434XTLIczLK1FnY51PLNpsJ1JHmBjInx6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: designlinxhs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d6cb3f-520e-4fb6-260e-08dadeb66f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 16:07:15.7267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 21db78a4-85a8-43a2-9030-593b170ddfa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOAink/fv6odIvebhA1EWEX/CwE40amNCwDlI7T2gAMtPvjlq/FDRGULo0vy+9wJiVKy7YaonXlo/6T5V86Mfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P222MB0359
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ken Sloat <ksloat@designlinxhs.com>=0A=
=0A=
This timer HW supports 8, 16 and 32-bit timer widths. This=0A=
driver currently uses a u32 to store the max possible value=0A=
of the timer. However, statements perform addition of 2 in=0A=
xilinx_pwm_apply() when calculating the period_cycles and=0A=
duty_cycles values. Since priv->max is a u32, this will=0A=
result in an overflow to 1 which will not only be incorrect=0A=
but fail on range comparison. This results in making it=0A=
impossible to set the PWM in this timer mode.=0A=
=0A=
There are two obvious solutions to the current problem:=0A=
1. Cast each instance where overflow occurs to u64.=0A=
2. Change priv->max from a u32 to a u64.=0A=
=0A=
Solution #1 requires more code modifications, and leaves=0A=
opportunity to introduce similar overflows if other math=0A=
statements are added in the future. These may also go=0A=
undetected if running in non 32-bit timer modes.=0A=
=0A=
Solution #2 is the much smaller and cleaner approach and=0A=
thus the chosen method in this patch.=0A=
=0A=
This was tested on a Zynq UltraScale+ with multiple=0A=
instances of the PWM IP.=0A=
=0A=
Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>=0A=
---=0A=
Changes in v2:=0A=
	-Update commit comments to explain specifically where this=0A=
 	problem occurs as well as compare solutions.=0A=
=0A=
---=0A=
 include/clocksource/timer-xilinx.h | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer=
-xilinx.h=0A=
index c0f56fe6d22a..d116f18de899 100644=0A=
--- a/include/clocksource/timer-xilinx.h=0A=
+++ b/include/clocksource/timer-xilinx.h=0A=
@@ -41,7 +41,7 @@ struct regmap;=0A=
 struct xilinx_timer_priv {=0A=
 	struct regmap *map;=0A=
 	struct clk *clk;=0A=
-	u32 max;=0A=
+	u64 max;=0A=
 };=0A=
 =0A=
 /**=0A=
-- =0A=
2.17.1=0A=
