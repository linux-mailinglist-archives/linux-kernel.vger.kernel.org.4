Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29A69A7A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjBQJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBQJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:00:09 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62825604FE;
        Fri, 17 Feb 2023 01:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCebx+VrSGi5H4828SjrhW9UkwvsBAWBup55rpOQx+rautYG18PneOZQWZPuZvHCk/sPZG5vrKcJWv7yziDNSDbLUX6Tp7wSDnwBEY7nDumxD1H2Nq9OYlRHFbA63Ca5rlGQNNtpHHBjY6iK4KazjtNfQTKKC50wcasMGO0+2UUW8B6UoqfUSK3hMsXwF+E49XsZz4Y1az9vtHC5LChU4TVDEKRCgSsEfpMsgdQpXccOb07J4G20HHM+zEBtESHPDCPAKcA7165tnRI/faaiiqGPXGg7ArrSpQQzjdC+0PmdzwAqb9TSj1sTrtc9FyUx7vYM9LdZy2yBXd6KIFkUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG+kUVBkE1Is+LDXPdrLcA4FrdpPdy0ChNmPtIFUlj8=;
 b=Voh82WdkjDQr/aixtkk2B94lYc3TUnY6hqhGnmd0iFLkjpBoUyQLbtDAxGf5MeDTP+trE4pd/iY9sNXjtjKGBN/w1P9FmLSWbORQlFBOw8pc4oJckKziPbE9yFWmgZovrg4HAR6MtiJInxbBHroNeQt1Cb3HYcb+wCetXYNauL425hqTpox66iWKMpnmpm6bHdTSM0ZzHwwJkkaUA5AA2ayASLjzKxJfRMAMyYqmV1VE/rubdtQ3I4D9lp6KP1eLYzUjsfv48XOXnxiQd91fMzTJcxHCkfctsXy0G8ZvKp56dnN/SbbeH9uJOLb8PREXHRXcBx1MSkF5Tg9enNHgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG+kUVBkE1Is+LDXPdrLcA4FrdpPdy0ChNmPtIFUlj8=;
 b=HyuuyYTiImG4Twxnjen5iNgU2zJxQfpqBLVyvQTNa8pQpZ6oIKQUH/L6m5xcXl+pal61khMvZHZGomEK7XTv2tOfJNWoFIjN8jgITQmkEm6u15KGNNeWF6MH7npCyXeVQsQ7ZjWgErMrx04ojIHLEikC3cZV+gqGnvRGNJDO/J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 09:00:04 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::5725:92ec:f43e:f5fc%9]) with mapi id 15.20.6111.014; Fri, 17 Feb 2023
 09:00:04 +0000
Message-ID: <52b8025ee9b71dfb147127bd1cb2c532d222df3c.camel@nxp.com>
Subject: Re: [PATCH v4 0/6] drm: lcdif: Add i.MX93 LCDIF support
From:   Liu Ying <victor.liu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de
Date:   Fri, 17 Feb 2023 16:59:14 +0800
In-Reply-To: <13207614.uLZWGnKmhe@steina-w>
References: <20230217065407.2259731-1-victor.liu@nxp.com>
         <13207614.uLZWGnKmhe@steina-w>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfb225d-6e29-4134-e485-08db10c55bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bt4Hc0I0TvvTYk6/zJMKAyWTEclEpWrI9XJ9ltrsQYAEycgE5wJumpMbQCIQKyD7CUgkBsB5yOZA+NZc7T2xhPr3Y59NVN5AlEGSgYY/8+YHAyTKuPtv2HDbKbNL0pG+to8YCUQKYAUr+8nZ8b8Op/QO0jSADmGyMTxHgbonaf7PwaaX3F3rbexVbTSGQHZxIY0D0BrWGBdPFSD55oTaMWlobKFOG/a8kdyYbsYWE6FhSsLtf/ioyPm102bcnZ9uOp6TF0w6VuHK8G7Nt4aLEyh/BUChLMPdxp1A9GYSy+dNibUSPSB9dIlSQSxikA5AqQaHXIKaCJLL2esmrfHJ99395qz58hrcwb1jzQapWUIV8BlcBnPBP2npQNCoM7dN/BUhLGCdyIRAWQVyZIbKfYc4qaAe6m2tZtjn2GDQK0t3ypCNlvsmQuk3961sDZ5dxjvmpvdQmzh/X+Di6RoDBct0dk+mB0QF09smulvUtPaO+6xyOxkZ1ZLcAGu/HXPPrlGcxajh7dSmWd0QHGdbeyl+c5aENlUpeX3gEGA+UfdHjknfChkklQyiMHwMEBzfsXJGZowv1lgTwq8xBgFjDiRKI3nrSBcd0DgWjQsuqco+L55eIHzAtT2hQohePf8rGWIXBuSnyVo89XOq9wrADSTObPGp48gQe9gn4C0McHXMWsvcKrbfcTcVuBiFCLszBEpL8irmx/dwsOu5344Rxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199018)(36756003)(41300700001)(7416002)(5660300002)(83380400001)(8936002)(4326008)(2906002)(86362001)(38100700002)(38350700002)(66476007)(66556008)(6486002)(478600001)(6512007)(52116002)(8676002)(316002)(186003)(6666004)(19627235002)(6506007)(26005)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmRyeWt6d0xHVXZZVUduME5CbXY0dVlIdGlMamxzbVdNZG83dUdYaXdsR09n?=
 =?utf-8?B?NTUxU2FEeCtUeFFIK2RNUm5yT0taT3lYc2kvekxCblgxMGFnVmJqdk1Jd3l3?=
 =?utf-8?B?dURaZk93NHVxTEdsZUo5VmRFSHhaanRQUDN1VkUvd3U5ZHY0aC9Nc1A5c2V1?=
 =?utf-8?B?Y1pIZ3pNSXBMZnl3Z1FJZE5laXpBYWhhQmt1c3ZKSkE5Q2dKUStXWG5iMlF4?=
 =?utf-8?B?REpaZ1FsNEV5RElZVmtnMUtROXdCK1krZE9XcXhUSTJSQjZURDM4eTZ3SUFL?=
 =?utf-8?B?bksrc0ZidFZYZ0IxSU9sRGg3U1Q2RWN6bk1ELys1RUpHNkxhQ2o0WkViNnZQ?=
 =?utf-8?B?TDJ1RjhBTnVISDlQSTBjZU0waStzUWdKZlU4SlVUQVIzTzZMeG52aDBJdUZ2?=
 =?utf-8?B?RkdvbUUzTmhUd2hmYndZNExCZFlRWU1JaUhPUHRmZm9rU2NUbG85TVAxa0ht?=
 =?utf-8?B?Sk5PWXdqV2Vldm9xMGV5RCtPRlB4K1FVM2YzTXE2WlM5YllUalVSRG15OXBJ?=
 =?utf-8?B?RDZvWHVTU0RMc09QaEN1Umg5UmNLMGJORUFoelVxMTZUZ2VURnl3ZWF2Y0RM?=
 =?utf-8?B?S29HQ3h5cFVxZ09GMVB5TW16cFNCR2VLdzVXRDRFRzB4aWlON2szNk1pVFdT?=
 =?utf-8?B?ZWN6bzZyRWFtclZ0bXpQcVV6MVU5NEIzUGNJLzJ5UG96RHRVV1U1MFlXaDMv?=
 =?utf-8?B?NGZjSVNjNzlQRVJJejl1Zi8xeWk5RDg2bk9oMEl2a0xITnRvL01xK0Zja1JJ?=
 =?utf-8?B?ejUvRnhiZWdEY3lmVWxMR0g3TGtUYUJhTlh2V3pVN0tJaEtXU0dlM3d0TEoy?=
 =?utf-8?B?YWlKT3RWTTc3OEtPdzNrVGd2YzBCNHpNL0hmNHl6OUo0SUI1VHh3RHY2b3Qv?=
 =?utf-8?B?Y0wxRGxJTTZ5cG9JSmdKdUxHYW5KV0JFdW5nRDFVRDhIS0tVOXI5M0lQand6?=
 =?utf-8?B?dkRKZFRJQ2pxa1pJd3czSFRySkIrdW0yRGtXOUZyZmNINDk3MlpTSlF0YWt4?=
 =?utf-8?B?ajRRUG1oaDZjSFg2U2JFV0pMVmhrU25mUXR5MVRnVzRqaklud3NOMGdXL0tL?=
 =?utf-8?B?Qkl0bkpZWklQV3dRMisva3UvUGg4OHY4QVNzQlJGdUNGdllaZ3VMVkc5dlhs?=
 =?utf-8?B?MEoyZ3BpLzBlS1htVStMTkJGcmVhajlYb0xIcFlUNWRMSUl2TlF2UUs5WTBm?=
 =?utf-8?B?RlNQSlRrVmxKU3dtVkd1Y1dKRHMxK05pVFFqNTNXdk1oUGNLWU1Icld5amgy?=
 =?utf-8?B?SmVRNXRWMEJoeW8zb0FwTUlzK0VPY0lpeWJ5d1JuZ3k0cjY1eFI2SFVnYmRs?=
 =?utf-8?B?ZlVPTTZWNGYvWnI3SFhlblFyTVJjSVpyWVFRMVVyUkV5VnAycisyRzhqMTZp?=
 =?utf-8?B?SElwQ0hLUW5nUWI1TXo0N1RheEVOLzFrSjhjY2w4K3ZRQ0tQWkNKZ0lCSkRy?=
 =?utf-8?B?NFR6aC9KVHM1RDJBT3ZTMTQ0S2Nqb2xpRmdYK21FRkNOR2xES3ExdkR0SFR6?=
 =?utf-8?B?N2JwNHlyLzJYSWduMXA3Y2hlSmlWdytZUDdaVTJTdXhRMUR4eVdrd0l0Qlp2?=
 =?utf-8?B?SEpEWmcyazd4WklZS2pmSWd2ZmdsUlpXRlJWM0tkMnduTVpMSHNNblU1TXJz?=
 =?utf-8?B?TlJ6ZWpiUUNPR2Qvc0F3eXhyK3U2QjNPVUJGQWpoeG5kTUN1TFRXclhtS3ls?=
 =?utf-8?B?WGh6ZzlUcnBWRHdteTVDYzRsQTY2c0NySzV3K2Fva2pnSi9aS1ZhU1RmL1RC?=
 =?utf-8?B?TEM1MDlZc0ZJRkxQbFJOYjMyVDJncURZVW9OL2k0NTB6aWo0REE5OXB2NXBP?=
 =?utf-8?B?QVhUSVk3eXIzditkNS9rRWtFN0hUZDhxS0R0bFZ4MTV2REgxY3Qwa3VCQTk1?=
 =?utf-8?B?eFQ0S1ZGc3RsaHNKNmJqcUFzTmpTdDBKaUlFNGZoWEtVZjIzVW4vSXVmeDlV?=
 =?utf-8?B?U0libGN1bkowZWZMVWFyU2VVVlBBeEVzMmpkMVpLYmFrT21pMGFjQmFlVDBN?=
 =?utf-8?B?NlBuZU1ZU1ZsbTh4SnFVZG1nMmc2KzBEbWMvVEpCYm9Qc2l3eXVxbXZuUUpS?=
 =?utf-8?B?L1NzdWUwOG9GbjM3YUJWci9GY2hLbTl2c2M1T3lqbzgrL25MK0Q5ZUVMYjV2?=
 =?utf-8?Q?1r/85mJ94uWm1u8exjhb2QHoC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfb225d-6e29-4134-e485-08db10c55bed
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 09:00:04.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aa2R0RtXXCeCJufCXTKJ9F5/RjjwPW8ZIwAnNXVqbkhlpIkB+4NypSEWn9Vf+gkZH+iTwzDrUGmBI9LXAHJQvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-17 at 09:18 +0100, Alexander Stein wrote:
> Hi Liu,

Hi Alexander,

> 
> Am Freitag, 17. Februar 2023, 07:54:01 CET schrieb Liu Ying:
> > Hi,
> > 
> > This patch set aims to add i.MX93 LCDIF display controller support
> > in the existing LCDIF DRM driver.  The LCDIF embedded in i.MX93 SoC
> > is essentially the same to those embedded in i.MX8mp SoC.  Through
> > internal bridges, i.MX93 LCDIF may drive a MIPI DSI display or a LVDS
> > display or a parallel display.
> > 
> > Patch 1/6 adds device tree binding support for i.MX93 LCDIF in the
> > existing fsl,lcdif.yaml.
> > 
> > Patch 2/6 drops lcdif->bridge NULL pointer check as a cleanup patch.
> > 
> > Patch 3/6~5/6 prepare for adding i.MX93 LCDIF support step by step.
> > 
> > Patch 6/6 adds i.MX93 LCDIF compatible string as the last step of
> > adding i.MX93 LCDIF support.
> 
> Thanks for the series. I could test this on my TQMa93xxLA/MBa93xxCA with a 
> single LVDS display attached, so no DSI or parallel display. Hence I could not 
> test the bus format and flags checks, but they look okay.
> So you can add
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> to the whole series as well.

Thanks for your test.

> 
> One thing I noticed is that, sometimes it seems that before probing lcdif my 
> system completely freezes. Adding some debug output it seems that's during 
> powering up the IMX93_MEDIABLK_PD_LCDIF power domain there is some race 
> condition. But adding more more detailed output made the problem go away.
> Did you notice something similar? It might be a red hering though.

I don't see system freezing with my i.MX93 11x11 EVK when probing
lcdif. I did try to boot the system several times. All look ok. This is
a snippet of dmesg when lcdif probes:

--------------------------8<------------------------------------------
[    0.753083] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.761669] SuperH (H)SCI(F) driver initialized
[    0.766523] msm_serial: driver initialized
[    0.780523] printk: console [ttyLP0] enabled0x44380010 (irq = 16,
base_baud = 1500000) is a FSL_LPUART
[    0.780523] printk: console [ttyLP0] enabled
[    0.788928] printk: bootconsole [lpuart32] disabled
[    0.788928] printk: bootconsole [lpuart32] disabled
[    0.804632] panel-simple lvds_panel: supply power not found, using
dummy regulator
[    0.814741] [drm] Initialized imx-lcdif 1.0.0 20220417 for
4ae30000.lcd-controller on minor 0
[    1.195930] Console: switching to colour frame buffer device 160x50
[    1.218385] imx-lcdif 4ae30000.lcd-controller: [drm] fb0: imx-
lcdifdrmfb frame buffer device
[    1.227099] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    1.236725] loop: module loaded
--------------------------8<------------------------------------------

~300 milliseconds are consumed by the enablement delay required by the
"boe,ev121wxm-n10-1850" LVDS panel I use.

Regards,
Liu Ying

> 
> Best regards,
> Alexander
> 
> > v3->v4:
> > * Improve warning message when ignoring invalid LCDIF OF endpoint ids in
> >   patch 5/6. (Alexander)
> > * Use 'new_{c,p}state' instead of 'new_{crtc,plane}_state' in patch 3/6.
> >   (Alexander)
> > * Simplify lcdif_crtc_reset() by calling lcdif_crtc_atomic_destroy_state()
> >   in patch 3/6. (Alexander)
> > * Add '!crtc->state' check in lcdif_crtc_atomic_duplicate_state() in patch
> > 3/6. (Alexander)
> > * Collect Alexander's R-b tags on patch 1/6, 2/6 and 6/6.
> > 
> > v2->v3:
> > * Fix a trivial typo in patch 6/6's commit message.
> > 
> > v1->v2:
> > * Add Krzysztof's A-b and Marek's R-b tags on patch 1/6.
> > * Split patch 2/2 in v1 into patch 2/6~6/6 in v2. (Marek, Alexander)
> > * Drop '!remote ||' from lcdif_attach_bridge(). (Lothar)
> > * Add comment on the 'base' member of lcdif_crtc_state structure to
> >   note it should always be the first member. (Lothar)
> > * Drop unneeded 'bridges' member from lcdif_drm_private structure.
> > * Drop a comment about bridge input bus format from
> > lcdif_crtc_atomic_check().
> > 
> > Liu Ying (6):
> >   dt-bindings: lcdif: Add i.MX93 LCDIF support
> >   drm: lcdif: Drop unnecessary NULL pointer check on lcdif->bridge
> >   drm: lcdif: Determine bus format and flags in ->atomic_check()
> >   drm: lcdif: Check consistent bus format and flags across first bridges
> >   drm: lcdif: Add multiple encoders and first bridges support
> >   drm: lcdif: Add i.MX93 LCDIF compatible string
> > 
> >  .../bindings/display/fsl,lcdif.yaml           |   7 +-
> >  drivers/gpu/drm/mxsfb/lcdif_drv.c             |  71 ++++++-
> >  drivers/gpu/drm/mxsfb/lcdif_drv.h             |   5 +-
> >  drivers/gpu/drm/mxsfb/lcdif_kms.c             | 198 ++++++++++++------
> >  4 files changed, 206 insertions(+), 75 deletions(-)
> 
> 

