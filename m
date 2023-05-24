Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45070EA53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjEXAge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjEXAgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:36:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B00C2;
        Tue, 23 May 2023 17:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhT7+oougquFur9mQFn67TQNkg5paCUgn/inz03eteUvRo6r8u6cboSMXJ+JYN3re/0jJLX7rs+hg9V9iBN2KJw2L/5WAlGutA0DW9mH+fdtAIa2skGbmNGCaCEBC+DOyWvI5cp3QH3Fz3TzqJXob4SUa+CJU400Ahs/OGOA5F45gs5NO7S540BB9kBTIQN68mUvGwhKfRid3uzXIrWy1KTohbuvlqCA1RazxL6EJ2DB/ARcW0gJmhK/7r4qcg2Y6AKUeWtYrpwGObciYnKDLy1cp8+xwURWACtzsb9drM2DS97sIOcFk1GYISpvgodxQCL/Hcvp1Ok99HSs4V8pVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOkPGl2ohvFRpsIlSNWQ/MFhkMNLDNRT2uyL43XAJ74=;
 b=nlcXT+VgdE5DFVvNwIG8tUqMznnLvYA1LnbiXOU9Z5XGa0q/cPXSKYwgMTyNZXVTwsAFEIIanGQ5d+maVsu15iQ7977toB48NqYGbvmRRmZXIyMzGcVV03xatHKSLpyNj5zy7NnSeMXX/UbG+GLsove722jKjZduGvFHxMeoQ+Q7xVW9hak55BlU7hBhEtBM3k6JyZb5H3qv4JLBigSdK2R8B1BjtLd7jYzVFdfMU40JzDWXinu6x5JjdoC4hnZoEgzVsOH2yadNp4y1n/Ut/Xrsd2Aqk96wIMrVG/Qu80toImdWtRj7fINmagijxBkQvI58+miRKk9ywDfNsz7wuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOkPGl2ohvFRpsIlSNWQ/MFhkMNLDNRT2uyL43XAJ74=;
 b=gScoRR5FCQdtcM0LWp1WX5qC9cM++WGLshCubsvHdTxFFgNECf+7XFc+6HZrXKUHPjgFX7FFZ0vg2NZs/M/qgR79s4GTwOIp+wpOwu/rdD2tRPyRiysnxMpOWQ1vVgDLs20/naRGIk75jRUHnXv5Qn2ZghzS/2/trawEHz5FNew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OS3PR01MB8665.jpnprd01.prod.outlook.com (2603:1096:604:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.23; Wed, 24 May
 2023 00:36:26 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::91e7:a94f:9f75:d840%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 00:36:26 +0000
Message-ID: <87lehe7egm.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
In-Reply-To: <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-10-herve.codina@bootlin.com>
        <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Wed, 24 May 2023 00:36:25 +0000
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OS3PR01MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd57c34-f333-4d26-10f3-08db5beee81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 577FhO4GQ/OuEuu2Ks9MKSJ7ypD1GGGEoVD7bFpMvO11JYPdIpZMM2O6AFTPNIv6mjUDHoNQzrNCx9oR8oFDgmGQra8RpxsnBxNOIYBA6i0A68lp+J9J6GqsozkHWeTDem+vBxSB8jh+NjD/zjhg9ce4QWBGEk60CgHm9W1HC6elXvoUWLoVIUz9LUoUTOpP6+xe26jQm8ObWlzPWVw1hlA7DpH8bFv4FnirJKWY/pSUF51co2hnmxmkb3xCd2DMIU10iTZJHZbRhCoA3gl+8boajJK+urjcZ6j/O9VPZ087Kig0F7t6N0NXpMQmU1llP3qgbM3deOwlTv6fw9ZNmTHtsmwnK/rE/ew0LtSYKouKfOtDoj112EvlI8Zq3se6bFUoRLY7z6hMm7bpklLIiKAgBwg52OqQQWGWW3vp6JRhLBs2knKiW5/375gBv/E8i/XS45bFGcg5wzlIyleI2gR1g4QQFeQB6W1gwwHsgvLd6oYgoO17VZ/PimGcmpC8WUvu2mTVi9cj55KBafPvHdiIns+8n9XSj3HUjeYr5qUeXgJcxXcyMcRCAtltJBr5qv7/8R033u9+giDceXeJGKXRNQzX1SBEZpg43AyJrCSY122a102WzWtkRr+SMj5a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(66946007)(66476007)(66556008)(4326008)(6916009)(54906003)(316002)(478600001)(52116002)(6486002)(41300700001)(186003)(2906002)(6512007)(26005)(6506007)(8676002)(8936002)(36756003)(7416002)(5660300002)(558084003)(38350700002)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGL07yLPrFzzsfIu2NX/i/08uBKqE2RhGA5qK5XGg44jgMy31As+4mgdR2Ue?=
 =?us-ascii?Q?UIePPmYTYuX2Jfe3abA22BGMjRK3L9gaNcV2PA7bjOm70zfs5UqTZnCZlH4c?=
 =?us-ascii?Q?TnubJbpAYSFVV/lMa8cZYRhSqJuWqgz3fZvxY9Xze5ixp+q6s7SThHFw3/dj?=
 =?us-ascii?Q?fZ64Am1tzh9EUqDOh9nv670kN74Tc1cUbmC2I00G6xayoV2/bqkb6nPyuAHK?=
 =?us-ascii?Q?iQ+sZeD5oEca4jYPw4isE0bD02Tc5FU8gwj60vsvt0+OE9Up86hiaxjD+98T?=
 =?us-ascii?Q?VCns1ZeMKUcT0Q4/rvN0OzJdo/91oMLpkpnvaE00+MXTpRCWk0ZDdlfu9rQs?=
 =?us-ascii?Q?PUHDBg4tOtatUGOj9MyG5n/2YsvXVztez5qGdwSbLkmvFKgOdsungt885hlc?=
 =?us-ascii?Q?kIVocmZ1DH2SjMr63nK/m1id//bB1cPgTEYAFgyfds71UTyis6sQByxmbGED?=
 =?us-ascii?Q?uDVDjvH21pboBtgAxA7DuOZbS97NsIVF+7HXypi+Ezu3nE0Bn1T6b6qGS1ah?=
 =?us-ascii?Q?69ekoynr02gEouint6L5YtV9jFj9HCrDEqbLhpFRyIkIQJcXxF3qzo4nQv0Y?=
 =?us-ascii?Q?ANLPch59IXb6RjZGlF9GLPxjADjKYSOy3mVDVYeq7BcIxHDhdJ/Pyb/92yh1?=
 =?us-ascii?Q?ZNDYo5HY3+EudKQduxy2COcTYwaVw/YD9J9Uanr34zliT4BeYcBv0H0gAkTE?=
 =?us-ascii?Q?St8h//jpDInt8GZLT2jn+FzxTXY6v1eZ2B1HYIAvhkJ5w17jPIxwSShLk3Bb?=
 =?us-ascii?Q?JxEapGhaU17kxMLdpyRUsiy4k5lyv8DeYjNTe2ycKgIzi18ysgH5dffIf+lV?=
 =?us-ascii?Q?+KT5Oh87utvtFuRCh0RLc/obt5fiz3gn4LUxV9Adsxt7atubd5WXdt+MK3p2?=
 =?us-ascii?Q?iw3/UZ97i+aOqUKplAoqBKOPxOVE33pPaOMM2qZ/bHrfNm65VS3iTuKF9rRR?=
 =?us-ascii?Q?AFhyH4iqAIRcQQ98i9nb+P09+zJNLKwibec1iBrQWJLdDgGMeFXg279A0Ys5?=
 =?us-ascii?Q?KZy9n76Ppq0w8PAlUQYeYBRxNvD9joohYjiPRpmTozBXoZimz2I3g8dVG0i8?=
 =?us-ascii?Q?+lVvFB1GnPtVc4GSPKtfockgDbeGNYf0U9pTsvZpQsaI5yNsN2Zm27w9GMBx?=
 =?us-ascii?Q?VnjbExIv4pmGdDfZDsvFi+e1fOGWTBQZkPWe+k4NndX2bySxQaLxCFI5raMg?=
 =?us-ascii?Q?6Jas+jP+oflhjmChZId+dVTa5GcI8P1S5/d3ekuBpBqjj7B8E5/UWdfSvHGc?=
 =?us-ascii?Q?oOvrMxSCHdvF/laAPOpEmhTfSWvEKvme8oUIw+DsS5VXOzX6pIUopkFO/oDs?=
 =?us-ascii?Q?8PDTWSGFsRUtLdzvALwxxVN4aX/28oR0+aGnnmSQf52lS5t4V5mleSbC8/e4?=
 =?us-ascii?Q?x7zR24fUMH7qD0bCMFmHQgH6eufLXI8ZnvYnkbpvIXXMyohGVQUAgTb2aih4?=
 =?us-ascii?Q?mLJRW1aFf3d4AAIM6/99DSB//HGx1E2cAMKoy0NgB8Q+WHcth5BNOyAf2D7f?=
 =?us-ascii?Q?86lVvV0ygNJpBBT528ECC8JtZN1HFpwKEhOVniqQCgrlMR6qoRyHieU7Gc+1?=
 =?us-ascii?Q?vpWy6dMu48RWcWq8IM1X0LuS7VIky0Ez+3Yc7GrMjJPbR83FA0GYnlGAsZaM?=
 =?us-ascii?Q?jk6L73ukMhJ7fD+2hDgafwo=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd57c34-f333-4d26-10f3-08db5beee81f
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 00:36:25.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2yiewbF8d+VPg5ZYqIIcLoFGTH3dur3FDxpDbdcHAvIFBW1DSjmO1NL6zvPMOzr3ESctKXX+uJuFdpRI6i8aZVFObtVymro6OksjTMpUitKCn4zLkk4tyFAYym1odWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8665
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again

> Is this "additional-devs" available only one per 1 Card ?

I could understand the point.
1 "additional-devs" per 1 Card is enough.

Thank you for your help !!

Best regards
---
Kuninori Morimoto
