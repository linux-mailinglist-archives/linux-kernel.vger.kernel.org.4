Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2E36F047D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbjD0Ku0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbjD0KuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:50:17 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2103.outbound.protection.outlook.com [40.107.114.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA14EDF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:50:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4A6VBggLbt3w+neEWtKr+/C3wSAVrtEWhVEE2YfnbTvze6AUaFYN9oIxKvTU392M/g+AHI14msh8zpr1YpRb5EvXXL2bItreHQgo6zTjSDpLxLoHKeFGRg54aO5b05MrZXIHhIinPU24bGGJ+roG6PBkHIcnVKePNq7pihH2y3Tba2QR/RdP3ZwxdDQBGBJJF453pcB5UfFCoTE4UlSkXM3E51QgAtf7ABcqy32uPF7/xjql40mbI54WjMqzH4ESnyYUXY26CivW1I3NTxxsDVqOENCv1RbqykOlf3F/yDq1mhziCKfKYAWlOCdLX0Ia/r25iWiDOv51c2jW3jGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLydLX38u0gOZ3adyOAG4NXLlAZiVOvywwj64IxnUMI=;
 b=C89VQHLNtPjRJoCC79KO0NGHrDfbBwxmPuUhTmgFUKkix/Lm9VxjfyjtWe2PBPfRhsoTMAUTql3xfCydFxZ1czKIb7qi728E1uiwVfjD7XQA6T0Y2KhIW2B0vTpHR1H+SlsgmcJ8X2xVu7BThdCaR0rQUhuiN+ZJV29BNIxIZHlwCnCMYzLq9orUZx0rqDg8VAp70b4zjhy2suOS2MUOdxJ+KFAAPOJ66prpXVq6v9fRiRC6brn5b1A1DBJnloRg4w6dmRsb1WNI0OOC5weDbpViLKPd06zIKrZOuS41U8qI7rqoLEPiM7QnTc+qFdnEE3RuV1iQe+kX4UO8IzrFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLydLX38u0gOZ3adyOAG4NXLlAZiVOvywwj64IxnUMI=;
 b=WPDn/xTavMLcWnRcVBuNIlV5uZuePZu4yoaZvNWHFJMoOKFMi58eaeHHH+Wus5mUIkVTbu4YBPlGho+WQt/yAo2+6CoRqytHZru2Llp3RVBP9WX8ss6tCvaaG0fwo6lbqH54qA1eXR5iVE9vIQw2DcsUqzBlGunX//qMQ8nxf0Q=
Received: from TYCPR01MB8471.jpnprd01.prod.outlook.com (2603:1096:400:15d::10)
 by OSZPR01MB8107.jpnprd01.prod.outlook.com (2603:1096:604:166::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 10:50:07 +0000
Received: from TYCPR01MB8471.jpnprd01.prod.outlook.com
 ([fe80::fe9f:453:892:6a79]) by TYCPR01MB8471.jpnprd01.prod.outlook.com
 ([fe80::fe9f:453:892:6a79%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 10:50:07 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZUm0IF1GSksUHy0Oy5/nCFvmu+68xu+CAgA2JkvA=
Date:   Thu, 27 Apr 2023 10:50:07 +0000
Message-ID: <TYCPR01MB847111D756F520761D720716C26A9@TYCPR01MB8471.jpnprd01.prod.outlook.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-3-cniedermaier@dh-electronics.com>
 <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
In-Reply-To: <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8471:EE_|OSZPR01MB8107:EE_
x-ms-office365-filtering-correlation-id: 437a9e57-40c2-4bc8-493d-08db470d2a4a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFCpo0P5w4D+XNp85E3p+sLBJIOz/6GzcYYYqPLa50oA7pFMJP32S/5B2ZaQ8yPzh5Mb58qMdC3Jzq3Trt0OwY0W03eCDPrBI6HvdcIRqkml35MpZhmmpxbvYiXA5d1qSM/fCFV2SQThWinqhNXof3l+xJD1Y+GLhXS2RFmldEwwA6A+MyC+HHYZQRDF6p9O480XtbgqDbQFdAfejTJ+nnF7TstMsrlTMp6RmPXCx8xGYnNZVcAkNRYvSyirmLqF/ykqYANQyEW57u4HdcSvfFg0OVtyt/hPbjYPBfZQ4EGtUf+72YvdEHo8YwP93Rg6r/UsmnwlQB0Vv/ImZA+hUgzeT+J5DyjXbeqVtnr/xwfY1xCEqBr0rUxXn6I8xdupe+XNo+fB0esxGYfamKzNe/vQiGsuTooF8dBq9HCp7AnhK/8iuD/i+6cbGxUVnGa9cAOxr67ueURDnSrZufZasAU658A1wpuRKYSe6wl4RiYP1vhEmgJRqf39ldwiwcHJfCVOYBkx/yKsFzkPx0+QWI5OH1qoWv6pOtVaMOvthvYXZQCZ347KV+YpsnC9LqAOVcTQGhweljFTPH8ijnzV6NBF7OA58Ju5Fd7CdlylswuCJ4LEmSy8Po1s8oymUvbO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8471.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(38100700002)(64756008)(478600001)(66476007)(76116006)(66446008)(66946007)(122000001)(66556008)(110136005)(54906003)(4744005)(86362001)(52536014)(5660300002)(2906002)(38070700005)(8676002)(8936002)(316002)(4326008)(55016003)(41300700001)(26005)(53546011)(9686003)(6506007)(83380400001)(186003)(33656002)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NMPqCsWg0m22Jpqa68tu23hy36cqPQJ4aQ0Dw0uXTHKajlsuaYqPVnevL6k2?=
 =?us-ascii?Q?gXEcOEMQr/7/0wj5WOTex7BF/DZtEZ5ZT+fCyEsntSIvwNPy1ghODbijOUsN?=
 =?us-ascii?Q?FSop7gNHCetMD3E4KGmLBc0NsOtImuKa0WrPSoAmzVgxKMNGa+jnG6UvS/6A?=
 =?us-ascii?Q?o/hfADtMjSKqyR37Nd3CJH5MRcd0RWkW5nVEKnG0HvBswb0MqcgELL932XrQ?=
 =?us-ascii?Q?OPDHqgtoA1YMq7Col4PAmIiQcB+gPMoyPJacs6xZkrHYGoE6ZCroNSKJI7Ps?=
 =?us-ascii?Q?weMU0St2G8oCGR7NMG1i6XRmOQIXBbgl+rSF9Maoq4uFYKlnkU6gb0OiPaxn?=
 =?us-ascii?Q?xyAnu6ZPORQWmdckL7boXiaArCo3PzaExn4O8vAqHqek6tEv2Vu6ZJtBHPzw?=
 =?us-ascii?Q?pC4y329ukrsQjIqJq3s5ndf2sWXAkkohlzoMz3HqAmudzFAj3ZusP0iR1C+b?=
 =?us-ascii?Q?Cdd4lG0sTHD5x7ggykbREHJhCUpct0e7WEJ0yJDuL7Shl9PWdGPk9JKzmV/m?=
 =?us-ascii?Q?F1hkyfC7wdiwLHyLAU99gXNQPzIV5cPwQcv3uigTRMYsIrC18aTUaW1fV6b2?=
 =?us-ascii?Q?/gAgeLcm0ERm6MnoEuIsnkB49QD2NEmxU1rflO0yW8e1rYd1rT+2ctKA2jl9?=
 =?us-ascii?Q?L5eBAlpVBgiTkrljAxULVdgxpnuhPETRO2I/lmgecOCyZks4wt7h8/WW1TQi?=
 =?us-ascii?Q?RObcAxi/fWdOmspouB24AexoV3ia2GeL8uJGm+MlVkzHJbLROO4bR28LFlE5?=
 =?us-ascii?Q?CA7geavYxJuBPLCB77pV7SzOTItx0gWqPR7iZ3Sym4i94T+GTGYlfzsA9Kys?=
 =?us-ascii?Q?OKF+4Gl5mJkYoErCKIAXkZncyOhkMMuKtheR4swgtAce5i2EYpfmntIuInGh?=
 =?us-ascii?Q?HXC8f+sWpBz6FOouEAHI8yFmx4ISjghtHv/uHo6JYuqEiq0SG9PTnirpAGMU?=
 =?us-ascii?Q?Ea9dzdcHCjHGKhEvyhF0VskPOJX1Sdil+iNfeuvwc+0qotggvm8esMBsVuQv?=
 =?us-ascii?Q?Hy8ZcuYdgWshvSswKbAyYE4Fai3dvFf8OaLdY5HZOURH3nO92FOjXuE0vY63?=
 =?us-ascii?Q?8l8Vbs1L837cAJUvguUHcDDdJOlxUT2bx4/OFQJz4EyLF+u65vbr4FOEYYb5?=
 =?us-ascii?Q?DVMsCkptg9//8UnOhN6XxyL4acn2aI9Vf1XUDBIT20QZEDn5RpZUlD/WczRN?=
 =?us-ascii?Q?qsJm5oiXHzn7LKzE+Ql9+Q0Fx0KDPSpNLC3x11RUxmmZ8PWd53jmBxqJvqk7?=
 =?us-ascii?Q?hXJW54Z5SUb/HFFL+WBNTNYzNWV4AjKU+bjEkaN2wkUoLdupjpaIVffjlfAU?=
 =?us-ascii?Q?wOkIcEfu8ulHNRbLg4oG9oj22GzXC9GuGTsOispeiBy11dDVQ2R1ZZQlTt+L?=
 =?us-ascii?Q?pUPRxB6a3NC1GbjqVhRiyP4/ITSPIc0E5qLk/1fnfUZLwI7gfBX/bLfLS6mJ?=
 =?us-ascii?Q?+zqRve14IiKh60wXMhMVTcX4QiNw0LdAO9pqdnrg32nmRmPJdw+gMbyHul11?=
 =?us-ascii?Q?sv1UGo3o38LsVtVZILHryy6CpEzC7KQrbwKp7rBD6GWP6ZTcGpUH6l8SFSha?=
 =?us-ascii?Q?4CTM+DjVDKtOijqmLjeaHWWokem21W6Ppmw9wWu/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8471.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437a9e57-40c2-4bc8-493d-08db470d2a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 10:50:07.2163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+md2vPucK35QerjvNmcd+Yc20XZnPP3PWw/f66ucvVHSZ13rNt6rsTEVzGf+PzajpJnRQbh1iZHSolSe6mgtS0ZPeluLHXMpyGuFgDDW9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 April 2023 21:00, Christoph Niedermaier wrote:
>In V3 of this patch the kernel test robot found an issue. A fix is importa=
nt, because otherwise the normal path with IRQ could have problems. So I fi=
xed it in V4. Any comments or is it OK how I fixed it?

Hi Christoph,

It looks fine now; sorry I didn't notice before.

Regards,
Adam
