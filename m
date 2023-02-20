Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6969C42C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBTCeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBTCeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:34:16 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA83A261;
        Sun, 19 Feb 2023 18:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSY4ZEfVb7ro9vKKqa18RNenjIFBrf5BHAmxwKJ66oMV/1lrTJLSFs4guRhGFZAhU+3g2BSE8g/i65I9VlAExwbJztTxt5fu5MP1N4DrZ5Ffd5uV9JeaycQvzkwVQskpeTZDOX4M/rnjNUVN42iBsxJCWS87FOFBuL4jJK9yP0G0e5pua5mGKHjkmP0Ohwr0JH3g6esoUx0E2PvhuhknxNfNTs2+fT9Wicg5J1BnC1qPqmVyqkDk+mgudCVh+CZNKxOPYDOZfrkN6X9hD2M8vYNSN0ztVUgIAWS8MpD2gnrxtr1AHuGCwuTilkUrH/RGmoByRA6m6MNHhpSIGfHEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7MzeN5HFMP/fYPg7oTqELus5Hg6zqXj8B1pXg3Bjv8=;
 b=dT1FRVgx2xd1LyPyxsauwhlWdrNgSwvMSf9N9Kzl0Hze/+QHjfyro+9THLJ9kck6pnE/WZcnWr7mz024tY0oROTCKI+SFiqFDDd3/UAg7ziOxOlQRSKdd+3LV7Hj29mtshzH31OXE8To+RsNS5JoH+6/4HcPeHySLdxebUEIloF2TUGBe8l2jM+vpC2xvqjc/IU5f6kJtyrs/B6LzhFRPSJLXerAG+3gymPTtKOlFYrHyklbr0dFd43Rp0uFozoWAvFwXJzPitAOc2XyjkkcdVyBfjAu79tmTPvHrr5hbSDhwQHnI1C1PwYdkbNLiPIVGhCT4l12HvjOCX9eqO+j5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7MzeN5HFMP/fYPg7oTqELus5Hg6zqXj8B1pXg3Bjv8=;
 b=FUTYIreRgDfw3mrbsg5OqiVpFAGyC6ER0NMqKN4rmvMhhrXapzdhaULdDCjtSwoWhv6SwywB3sgAd6hylmu4MA0t0MdNvvub+JYBf2TarhsOtR9x/AkFY2+M8Xp8Unt0LGxSJ5MKo+JZuxnqWWyto0rthVLIsNkMV7cn0NE3frS+k1VEVqWvos6i18FNmaw/EXFhhhTOaNP5noeIYx8gSHQ9XhVshHEOpjr3dLwFsSGB4zfrB64vcz+/x/ZdsGiz6qpf/uZx37Rs7bfhQWB4ghbybciR72p32ETSlzsbBD90Q6s8nthrernSnef1JihkC4UhkcykqXjsmunllyuLfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AM8PR04MB7762.eurprd04.prod.outlook.com
 (2603:10a6:20b:241::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 02:33:58 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::4157:bcf7:8f05:fab3]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::4157:bcf7:8f05:fab3%6]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 02:33:58 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 3/3] MAINTAINERS: Add NXP S32 pinctrl maintainer and reviewer
Date:   Mon, 20 Feb 2023 10:33:20 +0800
Message-Id: <20230220023320.3499-4-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230220023320.3499-1-clin@suse.com>
References: <20230220023320.3499-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::19) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: dacfc1a4-13c1-4148-7599-08db12eaeae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwS2LwZpUKjYb7B+MMsjW5FzFYoDTvWWjUwwImidkABWNbtD1ub4V2uKJCH7OGok1Nf+VLCM9oIDMvGDVZZ5ESTh5Kxpe69ERJe3AL7g4Hfkj2LbXA5faiMhb4d+c4kisZDb9QViGDZ7aCC+GrQ+ce18A5SeR3Q9ADUIenLjiM1gONJclRi4TjUd1n0tv7mecmbku+8ItpY7Ha1pJqhlgk0YiEIfWtLAVxdR1bB6Eqw9qcvIsMr0qVEmCRka8YSvM29tNTd5aDEszlgUVEQtNqa5irj2sC/UfA1PUf7XKNFgspV02JODhhoAEP9khzC1pINrFHtoKvaTNUhUMSTg++0FwrNfIO8olxJX7IARutfPwc4xv18IwWRMoxG5zXaR3QPucD+mwnewkAB0g2ZQ8oqHF3u7oQHKq+Ch8BRzo3gwzUl4pPB9uEEO+NG8//tili/WHCKO3AHhsdN2VIM174Dd3TMhsfuaSVPlI5HdR868mgc30/XJgZAky1CmEIX2LB3KJ6RxcvvZvTi/VgL/pqfdXDLbJJe00G+A5iNR1fMa2RB0085ClDyeC+AkRbKQm8EIAuM7fy74lG1ZqxR1/pe+gZInJTEpwSo4EybALGRhYTscuZj8E1yKL9dvDvm0Ib6oHWNxSFxGtG9dPY2glg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(6486002)(186003)(26005)(107886003)(6512007)(66556008)(4326008)(8676002)(66476007)(6916009)(5660300002)(6666004)(8936002)(2616005)(66946007)(6506007)(1076003)(36756003)(316002)(478600001)(41300700001)(54906003)(38100700002)(86362001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Q+xr++AR+AfRAT0zJM68bYek70DUNTYacUBYIWZBKWnW4ofsGo667diYIWj?=
 =?us-ascii?Q?WDCXBw4MDiXCJlQCCnuF9Gd0G2HNdXtgPl2Rtkp8/hc9yh/fVL0wOxDlZNAY?=
 =?us-ascii?Q?OvvvcFUmQzNn6ab37ZBHVIQcUDV88EHQpCn7+H0jThV0vvLN60izjMKsMk8X?=
 =?us-ascii?Q?H3MC+w5o7GoFMOV45h8eeo0zE6KRbvyz6Hqd19q5oH9X/oefl9/nmk9OO3G9?=
 =?us-ascii?Q?DjM8NrsOFtId8YiLbTnNzJeXP8gWqUm1r1KHUWszQAJz45HO3j0fGYVP9C5c?=
 =?us-ascii?Q?wAKbOoI+sD/BahbTuFC3Ts3grC51uZVl8ifBYkHXXxmOdVEc0xjDFNMev335?=
 =?us-ascii?Q?pMAgRpMGinRkY2Opz5kbbdbCXKF2I731BvDbHm7XHcuJeAbBxN46wgaSMvou?=
 =?us-ascii?Q?n07sqKM/TigB4APsb07/8xHCgg111fZiUYpqAQWln1JkvYqZNjvcF2uIOo1k?=
 =?us-ascii?Q?QKCBmNDcDY1QxxLZZh9JXD60V8XyAeNU6fENA5ekjluhUdJFmEOM0Gsd3q4v?=
 =?us-ascii?Q?wgPyX4K1kFShmDg9RR5ttSaLDjX0BFn7cc7EIzATzAdnHDV3bYF1GTjVTvFg?=
 =?us-ascii?Q?6sRXYcdJE3Je2fJQpxO3+Mph0sdb9C9XrXfMS96zoguW9CJJAVVnr4fHAwyf?=
 =?us-ascii?Q?6d6XfEsxvoN3xdEJCIoVlU12GFY0FTTEHy/vwkr/iEYxslaCSPkeARUCJDyX?=
 =?us-ascii?Q?nCyQVzDZhbzFGLZcotzfBkWo1eY8CUSQjHtHnDACAXTPuBTlAx68PDyx5J3N?=
 =?us-ascii?Q?nLEyN0ZKLiynWHZ6Z0nohAi3Na/8/FbYjo/lpIGi20bf69UDSF0IENr87IHE?=
 =?us-ascii?Q?ikGfuqUulRxRW7Cy5fY7ByZxx69ryTBRXDEg64A14PcCwVsEKAOntx4OqPeC?=
 =?us-ascii?Q?8rRLJ5lc8SOAxlITSGZsar0L9bZ3nNvJJ13rCcXYWMJrsVH9pEbxfI1iadA4?=
 =?us-ascii?Q?9CIoOia9BDBKm3NDQ/iUTht/znv6vEo8CHsBSfB4f0vNbvmPJUmSIk4GRDbW?=
 =?us-ascii?Q?nrI4jLOT09RWrSeclsF3cZ19zEGqhQOS5WvYbindUFbuOvAMIhDpdruGnagp?=
 =?us-ascii?Q?VTlEH0VYiOP+je8YY57uDUWvdM6344FjIq9/Aem18E9BRY8rWyU0moDNrpfl?=
 =?us-ascii?Q?pHHztSei5b6NUJ2w5tkaRKck+QvnDhzftZ6eOYVmRAe9SGZmbInklfiHDw4N?=
 =?us-ascii?Q?ofXsB4dUdc0+vCDgIFxWzjbKYjCx/TSy5v/LHpwvDKUJbq9MA6gN7ltglHKQ?=
 =?us-ascii?Q?wKodJbLLD1Xr7sjWxACn9eV5WvKFtFFGCct1YQTKi4sqPpDWGBek3RyGLWmS?=
 =?us-ascii?Q?j5jcGVkAtK7BqR9H0M9+YJjNBBP9+IMRuNslKox8CeN/VOnJfDBqY48CuXZQ?=
 =?us-ascii?Q?jr/HFiWRU+jX9Ikp+00aJS30q126Y1VRj2UwOJFC3fu5lmVvbPiXERsLWmx3?=
 =?us-ascii?Q?ksP4v5o4RoG7ME3oeYkoVHjk97uxH+W2eDR4rudbsT7e2uR5uMUtEu7UcC8h?=
 =?us-ascii?Q?3pBKfTal1d/+n6tNpTOMhUWjwY8Phkiwms4mltDhyY3Pv/HsAmzGK+CNl1rK?=
 =?us-ascii?Q?jd2ERTFLJpKFh0RyJxE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacfc1a4-13c1-4148-7599-08db12eaeae7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 02:33:57.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pP5M3BF2KZKFQpBRG8GuNSAk5syJ9Zpek+vJrLU8NBX+RDEkqtwdgM/vYBGWND1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer and add NXP S32 Linux Team as a review group for
S32 pinctrl patches.

Signed-off-by: Chester Lin <clin@suse.com>
---

(No change in v5)

Changes in v4:
- The initial version in this series.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39ff1a717625..e427d7af88fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16562,6 +16562,14 @@ S:	Supported
 F:	drivers/gpio/gpio-sama5d2-piobu.c
 F:	drivers/pinctrl/pinctrl-at91*
 
+PIN CONTROLLER - NXP S32
+M:	Chester Lin <clin@suse.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/nxp,s32*
+F:	drivers/pinctrl/nxp/
+
 PIN CONTROLLER - QUALCOMM
 M:	Bjorn Andersson <andersson@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.37.3

