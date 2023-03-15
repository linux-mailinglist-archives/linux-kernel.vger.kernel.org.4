Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851A06BBAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjCORcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCORcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:32:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606762303;
        Wed, 15 Mar 2023 10:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6Jzjb+AXNg3hv3tdZ/8wlpxohMVzDy3FMS70F0XyuMW2puNf6JghEDdHDZxTsvCnS+QO2gT6fSVJqCON/vsZ/+wmVb9WAIAtk8FmveJumEajDHJXE2paUHsS7DzEN1embU6EVf9Igf8+m9axBP9KUoqpIP9fHEfOeaUg2a3aR0hmbFDr+d0xvLqQXwf3/vQQikuXQMCHWNrMDzRtvxUJLVlq1YlOV0G0raTwcBoo38PWdEM8EK0mD88Pp8F+qEoUz3VKyhxw2559+kBJAw8mC32d+O0RipM43wE+Bpp5ZOHlvfvZ8QMQvyEHF0wvuTGKMunJ2aLNNrNN9d6hmM7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68JLfB+grcV1BQAcMzWudCnD8ISmO7LXptrqa8aM8i8=;
 b=QUC3VzMpVvElZJT22xucNfNYOfSNyU1mrIuO4KLcJsHvrm1VjrWUiNDmAxp1AuVKQFIRDzXAQBC9bDuCYfeDDngsdQx7SmKL+35Bowa0brz2x3Svy7DBnl95h8SZahZv/l5ZGNgRwurpPwMYpH4M8j7vdq5It2+vRrSwNv2gXPcoj7K0QLU2WRYlm4CIqDzlLOyJeSOb1trTe2lrD/wCeEjPn3fwUUf5dHh1eaLUksp3t4cVJHHBWv42e+AP7/Bgu0IsbXywlYOdvEFbZwgxe0od33lGbegdYgkWyvpdXOSPgAB0k6tHYcOHnJenMan7qWGSMxZRWasWKqnCGBOoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68JLfB+grcV1BQAcMzWudCnD8ISmO7LXptrqa8aM8i8=;
 b=FNfs9uQEz9xe154SOdne2A+f09y0WEwXdfdPtWv6bcPDrUxyBC+w+vyrkJdNZnqYB4YF8h2dYDLZfl+hur7n9FnlVk/MqaAjv9fREi8exffFtuPhw3U9VOTKdHPsr+RLKw01ubnrhFoV1Iuj9iWR4FHyrksu/f3XHJdy6oM0BfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 OS3P286MB2312.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:19b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30; Wed, 15 Mar 2023 17:32:05 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e93a:aa12:729d:f2da]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e93a:aa12:729d:f2da%9]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 17:32:05 +0000
Date:   Thu, 16 Mar 2023 01:31:53 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: make me a reviewer of USB/IP
Message-ID: <ZBIBCRiFGSqQcOon@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|OS3P286MB2312:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ceed98-7bd7-45d9-b844-08db257b3211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1cb7kVHBNa/KEE0lmLG5qIPHgYrXBstz09HDZaVapxUQRF3AMOWhXAVWzHZUXbf7VoXS8Z3VGKr/AgtJsRR9rox+QhSmTCJN/bJzw7mdaYO1JvQovgirOwHtufFCEyIVnrYpiOmafUysc2yJdb/zftbBKj8Q4+WZc1GPFLg+spd+ANxAoqB85K9F+eVZhSsyFENWbI/tOynLP94nDLYy5uazvwthpjlqmRLPuo+1W4psMZ4dMQAnxK3KXjMlB2zByIj9WgMr9nZTuLSkGsaJSVoh0KIEeY45KBK5GWiKbVRzDY6hp9tRhZFbhy7kv26ocLArsy+oWDxMOFKsUx4UaKPCfwPVysttB044nSRAzFVdhzdBbcpKhvUka1pZ3RtiDppgUBv723Or9j2uzIPT4k2NYq2G4wxUjD83rhVP/Z5BJJYelUIABWKAjjf9Rk5B/NIedhfwv/IAYAoP006ycGyNcH75sdof10W4KzG/fot5VL2VfAtKxMTVSYyu4XfaXDx1rVLDhs4knKnOxyf7euwKWPDpe6H2mogz5+labhYvQJn2gFcugJbOb/vvml+xNA8WJW2r57yeOGglyOvnjeRPCK+TEZf4uUifgC3KxbOcX6ifnRoKoqyNXbFFtDqobCQOhWz9DINPeKyIeM2LNUCQeREYeX2NRE5etviBtvBr/9bpGjzuX5zsRj4ErZF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(346002)(396003)(376002)(39830400003)(136003)(451199018)(5660300002)(2906002)(186003)(478600001)(33716001)(110136005)(9686003)(6666004)(6486002)(6512007)(6506007)(66476007)(66556008)(66946007)(41300700001)(4326008)(8936002)(86362001)(8676002)(41320700001)(966005)(786003)(38100700002)(316002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3guUoE0XceKCXKXmi/xgqzqRoTRLPLiplCPOZraEKelml6Fe0r5t38ogHeHh?=
 =?us-ascii?Q?E/gxfOl8I8WSGtrZBdpjKTlS0LxFyFvbaqrUK7GP+MTvbAKoZ1j5doBEwtn1?=
 =?us-ascii?Q?cPw+HMDfOKEzkxXE96LoQ+oDw3U0Dspzb9cLUxw2CYn5U53ok6HEIVAcBQwv?=
 =?us-ascii?Q?SjYC9+fQlTlchnXbD/Jd6VNvzeSUmFenax+OlXm2wGFD1dN2KM8MqOEQRGU5?=
 =?us-ascii?Q?GYcYfSxAP/lve9DCNBk/n6AazkMU//PRNc5xJA/r3ANPdaErhMxVWJvGeJCq?=
 =?us-ascii?Q?6Oj3BcUCqZUV9g18Yx1vopCoeGPaS70G9W6RLR2bNe6I1zFnsAibOWXPG+vF?=
 =?us-ascii?Q?6XVXA4Ti0WP0tGagLLPfD0vp+YIQ6W6K4TcrXTEH1JDjjY2G+pGG9CijNFq2?=
 =?us-ascii?Q?KlgCJZoqDKWKQzqTytgsz1y1MP6/D8/fp7heTYxef1Ei6vCNllBoNN4tKvRS?=
 =?us-ascii?Q?N759cfMTHQ2oJIiPeX9IaWHC9lnjdnK6SlJ/Dhkmj7gqSAV4Y5UBGEEL1Ynb?=
 =?us-ascii?Q?RAFWZr89xOJivQ8qCUDT6NVqz0Nk2mB6r+VdoZGDRX8JXiSvb9hBBFDwpaQd?=
 =?us-ascii?Q?DPnN+VGoQNxQRWqNBTXKqXDx4g04CdM8niiDGXIHkREqZN5lRWuPJse1exrH?=
 =?us-ascii?Q?fAK8YY1BZXkpXuc+n26JP3/dVRohntPEKJ9UytY591VfI7/1o18Wmf/TaY2V?=
 =?us-ascii?Q?JWgyodGIQcETxxLROVGlx6MFutHMNFZW6G25AjXxp5IRFf99OCorz7IT3lMp?=
 =?us-ascii?Q?IVySt+TQbndOL6dkzfNO1KA1VInLh4o1lsMQak1lknkN8MYANYD4ok5qS41P?=
 =?us-ascii?Q?tKM7Jxnbh9q+vyJJNu3hzrYPG769xDtgSpF2NJrtEisTQEJUl6yiEt8uLiTJ?=
 =?us-ascii?Q?mD6HVYxPCJ0YIkvoXlETbnYc0beXZUfTtpIHXryLmKTIxG5M1GPRWOAPHwtk?=
 =?us-ascii?Q?oqjVSNVgnyHL33BXl62D6kmnBLe5uA+zIDK1P6/u3ZMWWWsyWqceV5E3AAge?=
 =?us-ascii?Q?++EaVwd1CjaZw7YZc2nKbQAfjKAlvnCLEN/o6ysdPnH4WYTRUwWCpd03R7+D?=
 =?us-ascii?Q?s/WA+uMlDUbLzKfA7klxEKfKN8ob4fiXVXF7pYE37RcIxwxtxTwlJBkWMWn0?=
 =?us-ascii?Q?bUghuUYbo//h+uj8QfEKwHOkDfmCPDnlVR9pqs/nix5lc3f0CidgYF/fNRyf?=
 =?us-ascii?Q?8TBpY/HSWRj/IX3T4K+drzJ3VoIsfwossy6PNOAbQbWiXmQ3llDH73nplNPc?=
 =?us-ascii?Q?vaiiLuAfdSHpYCLA7u/20En2wafRhHh1w1QOQRZzRN9LWx4PwSogb5fHMfdf?=
 =?us-ascii?Q?ddu+9DQ1N4B9pEPQ131aIUzv8VWn3lu/Pwnr4a0LYrhPEne+Ay1F9FCayyNe?=
 =?us-ascii?Q?P0b8eEmFE6TK5bRJmkcTWomFTiKL7QPOsvC445IPhFnMYC0xmhALeiXBnz9i?=
 =?us-ascii?Q?qKIYccllJ5F2Z8RnKmgDID8+pjOcqESCT9IIJYxiiZMit/+sXhec/a9F2SB8?=
 =?us-ascii?Q?Q9uZxThJZypQccKXj//E2etqsyl0e8r0Ms7YsQmRrxs//adCYC8xcjenM8uR?=
 =?us-ascii?Q?KWJGqND5pT2/bRT4fTLFIF+ZWbM86zwa+KLU2pSI?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ceed98-7bd7-45d9-b844-08db257b3211
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 17:32:05.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsCech+gTxEFRMrcfocPPYZ8Pdl2j6qVSWd2eOeAARVN9CxZgUciyTWLr8y6UGye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I am familiar enough with USB/IP and is adequate as a reviewer.

Every time there is some patch/bug, I wish I can get pinged
and I will feedback on that.

I had some contributions to USBIP and some support for it.

Contribution:
Commit 17af79321 ("docs: usbip: Fix major fields and
    descriptions in protocol")
Commit b737eecd4 ("usbip: tools: add options and examples
    in man page related to device mode")
Commit a58977b2f ("usbip: tools: add usage of device mode in
    usbip_list.c")

Support:
Commit 8f36b3b4e1 ("usbip: add USBIP_URB_* URB transfer flags")
Bug report: https://lore.kernel.org/lkml/ZBHxfUX60EyCMw5l@Sun/

I also have implemented a userspace usbip server in
https://github.com/canokeys/canokey-usbip
and maintain a list of usbip implementations
https://github.com/usbip/implementations

Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3b14ec33830..45f4fd92126b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21645,6 +21645,7 @@ USB OVER IP DRIVER
 M:	Valentina Manea <valentina.manea.m@gmail.com>
 M:	Shuah Khan <shuah@kernel.org>
 M:	Shuah Khan <skhan@linuxfoundation.org>
+R:	Hongren Zheng <i@zenithal.me>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/usb/usbip_protocol.rst
-- 
2.37.2

