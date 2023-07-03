Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA97453F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 04:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGCCty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 22:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGCCtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 22:49:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1BF18F;
        Sun,  2 Jul 2023 19:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqL0nRLENhKew+H2pXNhRpvaLnrnQlJGzXZlf3YmMwAPeD99wSXttiAIV4GHLvISbdcI3YlrmGB7s1HsfpA76XHwYhhsQXNpLkXjWwmLxVXlJ22a2rtn12I1yhaFRXR2nTjCGEVmISxh/JT3jzfyknx4fCfn4NEWNCy9+uMYk/bZ1UT3fdJEAx/lIp9EJGAtJLfN+ddjkPtgIt2UgcOzAtvqzd74bC0Yk6AfQSIKd7zjXetcYV/4zuXlWpNQyl7n1Y8FADWq0o4i3NC8pTLuipRBJ4rQUZX1WdRsXb1duAUOhx34fxcPjPeOGPAENl0ji4vtiYSVeLKGBwafngs4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGRJ+608GSDGttNDWfg1WcSB7ghGsm59d9tc3SrHv7I=;
 b=oA3gqZDV91IAsuX/OByOSPDyMSD5u7wM16q86amD3crmsurjcohDUBEDGO+tGBv9Gd5i0i09SsKULYlzBP07Yiz2VDnOasEmPiVt4R+WsxgWGnu8wqRHIc+iW1PpHIkSCHCVGhMgcag8SuOM6Rl1OfXC9+mnQX8R8F1s5j1xvzxB4RezsMCpy3zGvuJl9mmIYIHjqOgGmG7g4KxPrtabHOsGkf5lr5Wd8OzeGCeBx03ad3Mnz3v0ea2038auqI39hJ3Pyp5x5M5Rz5DfjNO/5AVj/zFLunPqwxh6BJ6XrMnyCn7b1H5qd3ATkX/7CE8Y4LET8eMvNZT9lkenaBPGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tw.synaptics.com; dmarc=pass action=none
 header.from=tw.synaptics.com; dkim=pass header.d=tw.synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGRJ+608GSDGttNDWfg1WcSB7ghGsm59d9tc3SrHv7I=;
 b=BQeO8vrGQx99Kpnz50F48Fe69CsYuKudolDJF1irfm91SliHHtJXSlFurrXAFDJ6CpOiAZfQ1zVp++plrypgCKRzrla+zNUqv6NPXwaiM/f6+R4kRlte52Lo7BCn4WBDTh0cB0/qC44MW194jMYtdcRJvnu+NxAUKtlSOULBZbY=
Received: from MW4PR03MB6651.namprd03.prod.outlook.com (2603:10b6:303:12e::17)
 by DS7PR03MB5477.namprd03.prod.outlook.com (2603:10b6:5:2c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 02:49:50 +0000
Received: from MW4PR03MB6651.namprd03.prod.outlook.com
 ([fe80::e4a1:f780:c618:4081]) by MW4PR03MB6651.namprd03.prod.outlook.com
 ([fe80::e4a1:f780:c618:4081%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 02:49:50 +0000
From:   Marge Yang <Marge.Yang@tw.synaptics.com>
To:     Andi Shyti <andi.shyti@kernel.org>,
        Marge Yang <Marge.Yang@tw.synaptics.com>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Chiu <David.Chiu@tw.synaptics.com>,
        Derek Cheng <derek.cheng@tw.synaptics.com>,
        Sam Tsai <Sam.Tsai@synaptics.com>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: RE: [PATCH V2] Input: synaptics-rmi4- Add a new feature for Forepad.
Thread-Topic: [PATCH V2] Input: synaptics-rmi4- Add a new feature for Forepad.
Thread-Index: AQHZnNVd24wMbjxTzEiZuXJ/Dr71X6+JN0SAgB5A3tA=
Date:   Mon, 3 Jul 2023 02:49:50 +0000
Message-ID: <MW4PR03MB6651FF948B63B6FB209DA2C6A329A@MW4PR03MB6651.namprd03.prod.outlook.com>
References: <20230612022607.315149-1-marge.yang@tw.synaptics.com>
 <20230613204855.bm4wxneamkd76heq@intel.intel>
In-Reply-To: <20230613204855.bm4wxneamkd76heq@intel.intel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXlhbmdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00NTY3YTg4YS0xOTRjLTExZWUtODMwMS1mODU5NzE0OTljZGNcYW1lLXRlc3RcNDU2N2E4OGMtMTk0Yy0xMWVlLTgzMDEtZjg1OTcxNDk5Y2RjYm9keS50eHQiIHN6PSIzNDUyIiB0PSIxMzMzMjgyNjE4Nzc4NzEzOTQiIGg9Imp1QTZrSEQ5WkpWWTRsSDYzOVRZTUlQT21pST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tw.synaptics.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR03MB6651:EE_|DS7PR03MB5477:EE_
x-ms-office365-filtering-correlation-id: 49a00f08-3344-4937-5eac-08db7b702ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5mnJGrFCYNIZEDuvo/KIa+oAXn9q+L3zJrm79hVWcSYSKKKxCgV5p1nzi6H0Bdv5vk4F5iCRqL/pCMjWvxx/QtOiCJ4vhMFtUDj8SgXD9yt/X8USE3Rwb62Jkfk1RB9kFju+keX7GoYaDZoL6jXb2gyt0z1LHd61cwSFULL97SbaQbFW4XaWPx/jk5I7nuC1hsGVAvuplE8JAz4pKR7L5kLyHMasLITg2QBaKnEBM7UpztLho5X3i7MM6bhrNQcdDzb+W58j42G4j+EDaf0kOlm/Qplxpl05M/lyVyC/Ii0BHZbrLuVyn8oz+GvJZA49MkfJAtj+Iz58RLF8UuBUQ7YcTg7zq0iOYvWeeMfkPXnLuTATs7Hz0UtN4rbaxrWupqFAiJt7LP3WYry8AzupqdnzLdb4tEXVEvcbVmZwac84BvLy0cUp5f/0KMyEabmQuZsNErm8lLUC5IchiOyrnV+E6EKKg1SNTQAHvPwVKAx7s21OO9bOrDUFjHETYHll8lwCzmBn86HfKJy9FtT2hDuy9u1meSSnaLrlE/hihB4ZntwunHUZ81dEI5fQn5J05D4jM35TKhuFuzHn+qzl1vdYj1HjoZArC1zCPV1zawodxwqxpdM1MzLkNVOueX+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6651.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(53546011)(76116006)(316002)(38070700005)(122000001)(66556008)(66476007)(66446008)(64756008)(38100700002)(66946007)(55016003)(4326008)(107886003)(83380400001)(186003)(26005)(9686003)(478600001)(110136005)(54906003)(2906002)(8676002)(8936002)(52536014)(5660300002)(71200400001)(86362001)(33656002)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fNRT4KPmnyk/qoG4h97oEwO2+g9j8FwxRxPSy/ryRLcE2I/CjrLV6gBKR9II?=
 =?us-ascii?Q?8/YvjcheHJDMMrMm97PijVQCS/B7dUK1D91Ewx6K1cvtsQ6V3zhWWw5Vo1VV?=
 =?us-ascii?Q?TeA+x2waoq/YbiLtQpR/32xcKJIJ/mLRCOFcHf2UyPqG1ZO98BARVE+Ur9No?=
 =?us-ascii?Q?ysglB5alVjncXhbsZhId7V7zjk7L6Com0Z+LJs1w1rDOfJL83Bo8iLp0pQzr?=
 =?us-ascii?Q?X+kaT5gt7EpaayrLpnqZkoumCMHqxaI7/hxfrBXVOYPUioRcD7F48zKqm/x5?=
 =?us-ascii?Q?I7tzBWgT0Gun99DOBHfK/Ra5ONxaIKgbJIQuNtnCn7lCyl39pt6UYXi33iqz?=
 =?us-ascii?Q?MK6EjPzzUeWu7dKQ7ggW61IgTm4a+Ea6awshRpKUiB7IZ+kWRGwC9onZ7AiU?=
 =?us-ascii?Q?e9ecUHZdmscbHw96mv68KheioGMFtdGXVnVPYZ++6JC5jBouMhO7MjrumZYG?=
 =?us-ascii?Q?aDIlVUf8tNzoY6CclPlkn6LZsa1KHDS0lqQ6POuKwOIZMvfjb1ujieFcIZVC?=
 =?us-ascii?Q?GJger7Szcp9f1LN15j8rmufwBQ2GOE2jYrOdvCbISP1775cZZi5kZNI3VrWc?=
 =?us-ascii?Q?oA8SokFDuxXWeeP2K6FUF4VLZOQVL9se4hI8lU1v5tCnbFxol3j/9phrfv0B?=
 =?us-ascii?Q?VD7XbAf4m84Tr84Vb2uuqXuvCCvCGKoMxayy9RsneAF5reLUJ4wqUQlfaiPd?=
 =?us-ascii?Q?Oz17ue4F3G+5qmHkaaw9dG7XbV+LxI+Bbv+u/AJF3ui01QxXrJ1tMZx+yez6?=
 =?us-ascii?Q?n5so7U3tFIFAb3ak4ascBiMBYCVjRQ2N50vkPS90EJpfi6J9/AqTF6sCLaXO?=
 =?us-ascii?Q?q/DRBU6vddnUump/Zl1Jnl5jaGfAeX6alDb/XTqLC53OR44ZzuBwb9LnV4e2?=
 =?us-ascii?Q?ADxysEQ7wdYvEBMReK/4TQkcLIidqCaOgcBT2ZzfvNPsLqruAieb0iCwQ8aB?=
 =?us-ascii?Q?tmCrezGsh0PiP7N3aQUZR6xY2i16nqNT6RN6lstoJkUErdQsdawbRXa2HMMU?=
 =?us-ascii?Q?/qSIPBnXE9zQEtn9oqxXhaENQCJuXBB021RnNPnEwIXALZG0D3vxoomB0TV5?=
 =?us-ascii?Q?4DWydP7+qsCEbbn+njFn6qsZ0pTaSg7q4yebld+cpdLZ8H714aLnmwRYfg2H?=
 =?us-ascii?Q?LV9N0jb6sGu+h5/xdN2lLY5YYmMm6HIR+U1GgXyRD7/MUq933AO780r2Aptv?=
 =?us-ascii?Q?bny2Ws5+hFGi82mHQsxhG6bpBrTGBRJ3RKzjtPaRlcVDRJ05HBQL7QhZYv7Z?=
 =?us-ascii?Q?tyr5HWkDpYfqzC1xrVIu3pod3DmBckrb1yDY4PvUyO8lwfpAPRsdMndb1SZU?=
 =?us-ascii?Q?BYfx4TIaMsOZKUL2qfMpyK0FvSyg1t4X5cdkKOIVNhhwdrw+Rc29jyDj/jW0?=
 =?us-ascii?Q?pnVDzSQqt0I7Ud4Sz/XUplg3zgIs/2sdvFnB8OdU1WzYTR82nwIGKjnjt1B2?=
 =?us-ascii?Q?zqH8wxAG7s8mqO7UbY/WOdZ7EcxreRPkvD+kAgZBbwMi/S9XXh6UsJrMUBOZ?=
 =?us-ascii?Q?EEyorovC9uCBqAnzUojTPDA7cmbAs9hjoiI0+3uOcESWW9DKAnBCYQ+WDzjW?=
 =?us-ascii?Q?Y7Qtc316ktHWBkWfSLs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tw.synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6651.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a00f08-3344-4937-5eac-08db7b702ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 02:49:50.1311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AIR/RCO+CawE/zc3xXvsrUZ/Z0g6tJrYJAqBM2K6vX1FPP85jBV+FhKviYzEHZOF9um8v24smLv2/OnuUG6nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5477
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,
	I have modified it and send PATCH V3.
Thanks
Marge Yang

-----Original Message-----
From: Andi Shyti <andi.shyti@kernel.org>=20
Sent: Wednesday, June 14, 2023 4:49 AM
To: Marge Yang <Marge.Yang@tw.synaptics.com>
Cc: dmitry.torokhov@gmail.com; linux-input@vger.kernel.org; linux-kernel@vg=
er.kernel.org; David Chiu <David.Chiu@tw.synaptics.com>; Derek Cheng <derek=
.cheng@tw.synaptics.com>; Sam Tsai <Sam.Tsai@synaptics.com>; Vincent Huang =
<Vincent.huang@tw.synaptics.com>
Subject: Re: [PATCH V2] Input: synaptics-rmi4- Add a new feature for Forepa=
d.

CAUTION: Email originated externally, do not click links or open attachment=
s unless you recognize the sender and know the content is safe.


Hi Marge,

[...]

> +static irqreturn_t rmi_f21_attention(int irq, void *ctx) {
> +     struct rmi_function *fn =3D ctx;
> +     struct f21_data *f21 =3D dev_get_drvdata(&fn->dev);
> +     int error;
> +
> +     error =3D rmi_read_block(fn->rmi_dev,
> +                             fn->fd.data_base_addr+RMI_F21_FORCE_CLICK_O=
FFSET,
> +                             f21->data_regs, 1);
> +     if (error) {
> +             dev_err(&fn->dev,
> +                     "%s: Failed to read f21 data registers: %d\n",
> +                     __func__, error);
> +             return IRQ_RETVAL(error);
> +     }
> +
> +     if (!!(f21->data_regs[0] & RMI_f21_FORCE_CLICK))

no need for double negation here.

Andi

> +             input_report_key(f21->input, f21->key_code, true);
> +     else
> +             input_report_key(f21->input, f21->key_code, false);
> +     return IRQ_HANDLED;
> +}
