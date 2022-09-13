Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397A05B7A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiIMTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiIMTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:14:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0A4CA28;
        Tue, 13 Sep 2022 12:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHgFdaWOd88G5EcYvQxT3mafZ11F1mRnoWQP2G95EYjG00IWdI+bfCyd3+rs+kaP7ucsBdQ++F5Bpn6Hoiw14TBihRhqVvP2m0Wlv5bBmoe6dhDADgKoRXHItQYt3SyWdiYtXmpgMB4Cf9mqdQR33XZqPj4Ta6IzjZ+q570JFxGHwGKYBjpEA7NtxMdBYeckurN5iVdGyo2JfjWzMtqe+y7HclAgv4D61Fy+4VCqgZ6+haCkrwHgv2MWC/1B0DBQe6h0Rq1+dKMyhtupe+Aur995lOHR+ay6UL5mG3Co+EEC8irzfS/fr0TNUbcdcbfApXs6BOffwuqB5LyJBn7N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NroS/gZXARrfaor//s0p7SuqF1wBz6BykcYAyVV9C5E=;
 b=RS6+Q04dYxfCT+jjQq3frDJDP6ASLezyBtOM6nme3vk9xYOyKSRP366q5TI6GH7N2jFNFI3pK4S+NB0gk7K6jpeKcmI3TDIFsA0FZGCyKrb7XVHeclaDtElhtc/YmQL+bRhTT8sQm80UfQ2Cv0dRy9iKTkgnt26dihwfgrERl6h0uvpRulx7PiIOFJoUPYCsfe71/JB97xdhJcsEzch1yVa3Gvsz0RPBLPu4frI2q38qe9DlQqxS7XdnaoJMKgcPCIfDJS54Q/GZh+g0sGY/OkpcYEXAbTC9Jklu/R8ZLSl3R7glN63I4DMoDRnzE6p92a3XyIIX5L+ameH8XFIrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NroS/gZXARrfaor//s0p7SuqF1wBz6BykcYAyVV9C5E=;
 b=OPes52rqXcqxtqMZyrl0C+0JFd58HJYtjL/ye53v7T2zrVIEisb/+4dcUbXKiRQK27IJ4PeGdpM3tco4rRaUoWxqe6dc1+nTBpmNFbZ3zpZ98TKILTBmR9sqchS9DkELjDLT3Djot+vqS+6Z9Bbt5Kg6Kmq5A5vQRwK+KGlFO0E=
Received: from BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 19:14:49 +0000
Received: from BL1PR12MB5801.namprd12.prod.outlook.com
 ([fe80::b8c2:f515:8fad:d4ea]) by BL1PR12MB5801.namprd12.prod.outlook.com
 ([fe80::b8c2:f515:8fad:d4ea%3]) with mapi id 15.20.5612.014; Tue, 13 Sep 2022
 19:14:49 +0000
From:   "Nowshadi, Saeed" <saeed.nowshadi@amd.com>
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Subject: RE: [PATCH v2 0/2] Renesas Versaclock7 Bindings and Clock Driver
Thread-Topic: [PATCH v2 0/2] Renesas Versaclock7 Bindings and Clock Driver
Thread-Index: AQHYxtaZi0roluRgsUaIU5KqND8v1q3duyxg
Date:   Tue, 13 Sep 2022 19:14:49 +0000
Message-ID: <BL1PR12MB5801030CBB94899D9F1D297484479@BL1PR12MB5801.namprd12.prod.outlook.com>
References: <20220912183613.22213-1-alexander.helms.jy@renesas.com>
In-Reply-To: <20220912183613.22213-1-alexander.helms.jy@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5801:EE_|PH7PR12MB5925:EE_
x-ms-office365-filtering-correlation-id: d95bc34a-53d0-49fa-749b-08da95bc3a5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beQy8fKyCi0qFKk2cmlJ1GZFES0mJe3V7I8RmuA99dLeMnisijz6n2sAuTrjwviamIXgCv6IHGqQ5axcHRMZ+LHo9j9mfx2mwYKElS6xueGsumbcEIXworJrk3LlXfRyRb4bNLo5UUlQakRCNN10iVOFtKmIVt0T9s1QQ5z0wYnTXq+oWlcM+M2K1xEspJWTToxfstesWVPXzyWl2e0zcXa1GOGF2m23VWOlVPr7fCNbJ4g2CIEEkMYRPwSk/UIfbpaA1IdfzsiAm0EJQ3SX9PyC1AUf41NDbrn36h8GsmBiILW0iLO9qhKrCtcgijte+iMIIOqm5HIDaV20kAudSnVR7sLlKm7IqGfCkdKmse0BnVSXqCR5klSmPv0urzK/RLfUkgOycNL7Ukv4DxKu8ERr46wWFaR1qnT3mKQh8fs63HeceTrRbnt8djru3gXIi7yoKEBHcECtPHHrvB3630gLKdpF821qQ7geP8ED1lH4CE78nqQumv7MmZJK34p8f97kSGxAYLgPuajjLESlZ9aV34yuXVzdDELUsC+LMrPrjO2BYipcJaV9uBiG9eqm6YuBPyglbKi7bj1VkEEePY1ogc4tggRbAmk4FpUSUp0GRzgoQJWWE4o07SIoiH8/1L9XqhvQG3OeqAc9d6tJ4ErFfmYhRH8e5MSSI90+JN1LomRu1CPeSymBDLHR6BGNrpBAtp0IcuYaU5B7W1W3mEfT8ykME1dxEB9oBuvxrpY0KTkRDCtZOHMvAjXWB+Go
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5801.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(2906002)(66556008)(107886003)(33656002)(5660300002)(86362001)(66446008)(8676002)(122000001)(478600001)(66946007)(38070700005)(316002)(52536014)(26005)(4326008)(55016003)(110136005)(54906003)(76116006)(71200400001)(186003)(8936002)(41300700001)(9686003)(83380400001)(53546011)(38100700002)(66476007)(7696005)(64756008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G1kBX311vQMmvkiHSwIIdm2HIt0/QKtXtyD3eKqcQCuosboPYwIA3MRlWrOw?=
 =?us-ascii?Q?KgiomcEvDvGMoYCqllIObFFUVZYjG8/+bl+nrNAohhNxul8Cg0IGJCe/sW4Z?=
 =?us-ascii?Q?WAy+V9I4bMnq5yK7gm5GtKxLbAyAyRU2ke+Irt15e921eGKxEr7t3524OLyK?=
 =?us-ascii?Q?RA5AIFEA32ovbc9lIZEaay4szr5r34DBFPlLOyUgatjjlQ5KRTv9G7pBSTPw?=
 =?us-ascii?Q?GDZRCper2dpb6oIO+BoKGcmh1wSp3ZX7MQX2Bm0vdhMapfp6U/3ZiWFzdHYx?=
 =?us-ascii?Q?/gVS+in0OIcrhDMkvg9T7CFA6K+1IYiUe2rC+J9Z0sg8sqBTJaA9b+kjYUhD?=
 =?us-ascii?Q?pbtxOIkr2/egZV+vTopruMaqchE+0e1glxYbJ/6/nX6R5JAmHS9Nuph/ASFy?=
 =?us-ascii?Q?5vmAuRQb5XI1EDKyHgl64+DplL1bKSirnDjgGzxrkGVlw4KnJSfjgOZRqc5f?=
 =?us-ascii?Q?ewf9YUjNpTVgyBA7CgIj3y3TsjuEAW5mnP5DnGDUOdaHejavmZenLM84+yw3?=
 =?us-ascii?Q?SDoURpTPWU49utgGK8+UdTDXl7BBIarUNzHNppvhvAcd0fJBAVSK2vz2pILC?=
 =?us-ascii?Q?eDWO9OZHg1yM5eUUMPNI6IvGoTf/Y4zPCDJTjQEwAsBCT39ICAwhwZfYtdDm?=
 =?us-ascii?Q?epK6OUA993UA13lad7WyUurRXcKrofaVtO9nZrfe38ErYM8pBTTPPaqupl5O?=
 =?us-ascii?Q?cgU/2kVJ8omSz+wpWUUr/G+mVWSIMpgpR8casQw5sk2nC4X2hJuwE/1RcGxO?=
 =?us-ascii?Q?RGdOwSKItmUwEGdWRPsX0cKSisCG++zsWRLcSdaOMxltSpaX/zg4K/PxhobU?=
 =?us-ascii?Q?nMFYOsEQN44Tge1weX4IN7t44SvBvxsR4n7IdgOHLL4T0/H1tuw0Al7COmYI?=
 =?us-ascii?Q?7fENSaOLr1X0wEyy1644dvvj7uEGLesv93sniYxwlsMAFHg/fmPwGn8FFjNi?=
 =?us-ascii?Q?aU+XWXEJ1i+Xtxbe3JdfYZe1Y2sNsNzBZaUlQMkheMbl3I880tiRcX+e8xZv?=
 =?us-ascii?Q?v+3LGVEI8sMgFMuwggLV33P4U+GR6HrjiOEUQuFNNG+L4Yo5vPFPdJNeUazR?=
 =?us-ascii?Q?BQqIbLyOiS6yELxJkXaVA1+NQXerkkHK+KTha2lolWiFOJa2LgQAGGkwa8OV?=
 =?us-ascii?Q?iLFffDE/5C5BJc+4iXNBkxNhYHO7rbNE1dJLuBv/0xmJ+qPlzGCVD3OH9Ko7?=
 =?us-ascii?Q?Oakg3HK9/v6dF5Fkm1OH4xwX7K+JDQDRfvfPP/jnrByZnmRh07NaPzNJQclk?=
 =?us-ascii?Q?rJ54Gvfezu7NssYEQ9xteDAUfIXdoXVJxKDdh88suvROpEgKCZiIOwk2TZjZ?=
 =?us-ascii?Q?g7zbm3R3lTzgVbl3BDsQI8/4gyI/kp9L+Vep+uNjQrliBfHFfRUZ0wqEjRp3?=
 =?us-ascii?Q?baBy3xjofa23gpjA2l6ver6i8fEHqKT2oY7rEYSmJ3Ae0mb2onw+c0+eLhZu?=
 =?us-ascii?Q?By07CnfKNuSVApiqx7K6G936bgSZt0cI83PrwtnkUnnCHZNR/F766XPNr374?=
 =?us-ascii?Q?t73hvN4rhp2JUKucIx6kHz4/2jNmbU/fVw6JfxDoOHy3y52iLXla6xvFc9Ml?=
 =?us-ascii?Q?6k8bJj6cX8g+H4Yu4wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5801.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95bc34a-53d0-49fa-749b-08da95bc3a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 19:14:49.1758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smOfBBV2GS7OP9WFHqbKw2HNkSZVpNDbZHGcIY8eTGQQt3ZpjdLvLS+SKF9nB3BR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Saeed Nowshadi <saeed.nowshadi@amd.com>

Thanks,
Saeed.

 > -----Original Message-----
 > From: Alex Helms <alexander.helms.jy@renesas.com>
 > Sent: Monday, September 12, 2022 11:36 AM
 > To: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
 > clk@vger.kernel.org
 > Cc: robh+dt@kernel.org; sboyd@kernel.org; mturquette@baylibre.com;
 > alexander.helms.jy@renesas.com; michal.simek@xilinx.com; Nowshadi,
 > Saeed <saeed.nowshadi@amd.com>
 > Subject: [PATCH v2 0/2] Renesas Versaclock7 Bindings and Clock Driver
 >=20
 > Device tree bindings and a common clock framework device driver for the
 > Renesas VersaClock7 clock generator family.
 > ---
 > Changelog v2:
 > - Index to output number varies based on which VC7 chip model is used.
 >   Correct bank to output reference requires converting index to output
 > number
 >   based on chip model.
 > - Differentiate between multiple instance of clock nodes by using
 >   the value of 'clock-output-names' property.
 >=20
 > Alex Helms (2):
 >   dt-bindings: Renesas versaclock7 device tree bindings
 >   clk: Renesas versaclock7 ccf device driver
 >=20
 >  .../bindings/clock/renesas,versaclock7.yaml   |   64 +
 >  MAINTAINERS                                   |    6 +
 >  drivers/clk/Kconfig                           |    9 +
 >  drivers/clk/Makefile                          |    1 +
 >  drivers/clk/clk-versaclock7.c                 | 1292 +++++++++++++++++
 >  5 files changed, 1372 insertions(+)
 >  create mode 100644
 > Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
 >  create mode 100755 drivers/clk/clk-versaclock7.c
 >=20
 >=20
 > base-commit: f443e374ae131c168a065ea1748feac6b2e76613
 > --
 > 2.30.2

