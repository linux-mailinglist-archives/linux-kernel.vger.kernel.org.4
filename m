Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891AF73FA25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjF0KY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjF0KX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:23:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6C173C;
        Tue, 27 Jun 2023 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687861377; x=1719397377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AsehjMW9c885cWve08vhOywiXh9nyOASpBspoG9bHV4=;
  b=dnm0WpPKPMD1EXxoiJdEOxzI3LEIDBdhkbCqMs4TOlWO5u0itPcGBbbz
   pfrYZuukp8u9pGwpoisZq8QUtRJIDeoGs9+NHh/47Z3m9NBNRUSTgY4N/
   Kq+7mWuzfQX+nWC77Ppbsptx07FmZyJZsYe2LkLC2Nk9L90VKr+bAP6uZ
   S1/PPtN1ooIm/mCWb69DRaKLX/BhaOOtkjUFQ2KHVzH8TECDEE5RsFcNI
   dpNHFKxzo/bXIOGGRakgbP94kjCzwL74GPsOnO4K798y345Xn15H1BwVz
   T5AcNelPN+VUMUwBBf8G4yOZwV6ruwAf1l1qxwbzQ82a61ou2X2d3kTgs
   w==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="236973506"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 18:22:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5pcX6xIe7znRVH9tcjkF9YF98wR7YUppgEorN99IxzaxvEEYsTtkOXswjpwtlJsbVBKd2JPs7XgbrEm8NtnMo9/NkxtEJoe0AWxdE78R/5BcbiILkUtAnig0SM8ECtWdclPzP2U3ESKTYJ7AUxk68eq1PqhIbAEQawXH2Zv+CBTocisIPATPfZodo/uBuiwQ4G1PBMGYa0Iq2vyUoE/iKiB8J/D+6h/Ue6C5YUk3CPfJhYxpJV3L6JQTvgy67W+3zpg59pR9n6qaRmwtpm3iYJLbnw968cpGiTmgvA45BWBOKjbQHdg7jWS3fHa/iB0ZAcGQLwHxTCD2+15/m6pOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gSho+aQ2PvGIWLc846f9OkmZ1V1WumuIz2j3QU17s4=;
 b=f4sdDyp+sIbcfcnziDaY23i1eAbv2ET7oN6UNA7IIJtmbJdv1/eg1dWCajWh7L9FgUFVK/3kpXLwS/bsV0FcbB8kkNC16igBRSQl1JA7+427dQ3I7868wd3FVyCFCG0r8Ej1IRC5q+X4fpUcSDJIAnKlN4J+Sdyvnz3asvmHCz7BkWb3RXilJr7mU0LoWphcRJRHJn66RwlfQmiiWdzuqi4WPT2Or6Sad/BNAnIE8WYdfqPg8dsTUWH9YsLiEWJGk+akiJNFvqsFv9z0S4YSryiT43C3XbzHcNc61EuVvp7gXBaM1xLpjvgAWQFZJBTj5tFtt12A41Gp7xfMYJ8P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gSho+aQ2PvGIWLc846f9OkmZ1V1WumuIz2j3QU17s4=;
 b=Mj644OgjPThqkS922BWu/AigtFRyFf02WH4hqXQSxiIIIxGgX/da062DIRfuf+VoZcuMWBudnUxd0ELj0Jqxs0JNF7KEptyJlkOWZUajnzPgcSNiqNregIoV4h/UINUHTcMay8vdV/4Gs5u4ZuO0+viJnfKXz+hZDFZzAwFCrZI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6568.namprd04.prod.outlook.com (2603:10b6:a03:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 10:22:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 10:22:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Thread-Topic: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Thread-Index: AQHZqOFVgY2Gv0FVkEOFz0D9X2tsfg==
Date:   Tue, 27 Jun 2023 10:22:53 +0000
Message-ID: <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
In-Reply-To: <20230620132703.20648-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6568:EE_
x-ms-office365-filtering-correlation-id: fe67b527-4eec-4e12-421b-08db76f877e9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCbszyToCrPMxuS6+fckLqx7vo0gaO1v4ROJZTq9ARE7rmhVnu9+CrZCBkyPaqNZ3XjN9z63CkV9m7ql4UIRZQeIisB5IB7rcXOFM1uPM1ed+MxKFb5PHw0DG1fVrxsUUNKvIcxOMe7bMMvUY3L5rCCtNOyiCqGou+Jphkhs7j4oQtbCT1u6EueB9GYCNwOFLrzO4M5HZW1p0Bvsu0sMYvTEm2dQl1KcNsfRN9VYaty8YjI2lrM/S9nIo6jgIwE9JSzAmPX+4HZ6rSNatUeA152OZAv0n1R6VXdkVUBmEr66Yxm2FxQluS+m7jSHbSmlQ710hK5tHJ5pIDcRdxNxRy/4TPDV3FLJfGZRkZtHhhyV2iEPr1H3Osuws2t5mvr0HRtJZU36e+K8L6tEMrVNJNrbElm1BR7LJ1eLzVGkhF0v1BN88ABj6CPBUU4TrSeghdlmFplL9mRGK3bFUMbRHeSzo6McSkeWkTGlow63rnD3bYILlhvtGZWgYbYtsCPd28YTEBgbyyeRsUPsHGc1seV1ki0hwaWtae7sgRAT3006V+Sc7zBhHdfggGA9HXoDfFEAjzscFl+SMVJuC0GQw6xeyb6kx37NbksKNKUbepcfeOZUcNY4fGehqVI1ZYEi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(4326008)(66556008)(66476007)(66446008)(64756008)(6916009)(316002)(54906003)(66946007)(82960400001)(91956017)(122000001)(76116006)(7416002)(71200400001)(83380400001)(44832011)(6506007)(2906002)(86362001)(6486002)(5660300002)(38100700002)(41300700001)(9686003)(26005)(186003)(6512007)(8936002)(8676002)(33716001)(478600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lrRNtgf+SaNSkh51GLs8p1weeqzuKxTSVuzYPaSn9iR0ZfPoI0SnY7+vmDB2?=
 =?us-ascii?Q?oFQgMwBcHXmKptCpe8EhzatVjleJ1L+x1o3hoffGkKUayMgemfnOQWYjhwVl?=
 =?us-ascii?Q?VWeZb291zaWOcS6ttny7N+P7AdbMMqsNBdZ7/clgzfkrWF78hXg942NvAGuZ?=
 =?us-ascii?Q?BMtMtGZVPJCRMmkrSdpxBXLnoF6DZ4nEXiBWM2tf2W3qTwcg6vLzHMskgjKw?=
 =?us-ascii?Q?x0e5jXQIK/n5m2Bpw252c076qG2IZ09DnfigptfFyQM53Gd7BwalzO+fpGc0?=
 =?us-ascii?Q?ks4ZR6qFe4ELJWMTo9ZnQwjzW6Lke4Q0JvV4DCNMBtouJVKtk2Bce/R6weZa?=
 =?us-ascii?Q?rh6or4xZNOIf+zQ6tnCDAukZhAODNGtk3UbQcjUYWDd6XSjCRjkClgEfcRFV?=
 =?us-ascii?Q?01+f3NXb50M4i8bMQ0bZsTPDo1HCjp1mG5/Ca6tu5IyzDRNl7im/DL6GnPIw?=
 =?us-ascii?Q?IDh2mYpK/buVeHyGP1V4XMpVoa7wy2uToIum+gXJxXV/smxQUToe8KzmRDw5?=
 =?us-ascii?Q?gFnJ4rVnzERmL7A4umR0cWicjMp1g66l/eJwuIDMVUqbzLDvznyVol+yZ3iy?=
 =?us-ascii?Q?sPNW1Z4ZJbzqukULVJp4vBxWfKUa5+7r4Gz63alXvpDUiwBjxGoZSb9WGMf4?=
 =?us-ascii?Q?0xUccHO859iPIWjH+1n6NJSRbNUotRkACzmwQ2S6U4ltR+Fhbhko3y5g4gJ2?=
 =?us-ascii?Q?QH52iWvPuQWDG/p0+xcOsAm2IDRStxGjdCmj8cYBe/9cMOtwqyRps+erjr/q?=
 =?us-ascii?Q?Q1d8O5n074YGyGxB6SmHa86kG5OIFE5LXR4BmeO0e6FTZkOfbsleBmbWiff7?=
 =?us-ascii?Q?jo9gn1tLFKgiTlQas0IMQSa5Cf4DbdAl/GT9j7CtiMC95O7kOE/Lr2n9urko?=
 =?us-ascii?Q?6jE/6aZMbL8zTzB5nJyJSFS+eOyf5cOkYRx1oQ9096kjhynBmtlML8YhLQ+h?=
 =?us-ascii?Q?mtV4o2w8YKxzcyFZOAakS6jfr67eB0d62jHRgaTtA+oOZ8Iu3le11XeDHV+J?=
 =?us-ascii?Q?Ss3mUq3sg1xESk0kG0kY90wbW4fd6n88X9BEdLnl7wvyVXjFGITXgu7jVms+?=
 =?us-ascii?Q?+fk5pDcK9tTpbTjxKwDqA2uAOr2heR7K5OVL8urduU9ts5QWKN6kXeVXRcp4?=
 =?us-ascii?Q?0gUNb95HXsMY49VowPeKu9OSazoKemwWpkxacT73lLF2UgPvgq0eWIG0gc8h?=
 =?us-ascii?Q?YZ+qsMpjfvrt/PatsCFch/li0MMGhVdFgT2j9w6nST0tp0Xu9g1S6XQK4MKZ?=
 =?us-ascii?Q?pPBGDiBOU2a2NMttRYYyPGoz3hTWh2S/lY/mpC5jduZ6VDPEg8H98dpDbtTM?=
 =?us-ascii?Q?MPB3PyBo99AoZrvHBLsOuwwRXntua5XA79NH22E73dyzrdeXQr000rblQqGG?=
 =?us-ascii?Q?rAwSmemp+2PJqu/ORV93cBQ2kdvm/oteZz3dsu0rTPZU5NEkqJj/PD8u2awm?=
 =?us-ascii?Q?mRU+LVPTCfYEhsxXN+bwWYCo6gjsOaHdniKggi9Clh+fltk1nD/btYnGBuDR?=
 =?us-ascii?Q?o86dXx2mUu7FgOm2Tb8uFnajNUK9Dx4AJ3yOUk6IPbswNIec/J7Fh/oKRZWE?=
 =?us-ascii?Q?kdN1P58NaP585uozw2nVJBaLdvgAILpQqslLtamq7GYP5zku3MNg7p4Z5+O1?=
 =?us-ascii?Q?PiQWKTsx0jBPsqkK3tp/3zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E73EA0AE8552DE458E6BD3368ED2A79B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Z2CKWTi9LMbEtMb+k+Q4sNGCFoGLr1SDLqNu2iSvBPOS9io8E+IADbrrg1cS?=
 =?us-ascii?Q?tG/JLDfss2kJ0Yc9Q2eQaYFUyS3O/cT3rm2n5p4x0h23MFS67qTzk1wkBfMG?=
 =?us-ascii?Q?UUT/uBD0J7C4NvYIo5NTaETf/msISdgIqx0a58nWgY09xfYaAdKNg0QhGYE7?=
 =?us-ascii?Q?x0eaeBpTx/EUf0cgNTv1ANrJpnDBt/YYU5R+BDvRaepYXU+m08nWUTUe1kOr?=
 =?us-ascii?Q?fjMJY6f7ZVOYxSotuYOrwSLFub54BFG294RW9fconXxwG47rcy6nVyEe85tq?=
 =?us-ascii?Q?NV5zCapthx/dHZxfFkoYTjcSw43EYRli5WwXv2u4QKb+HK9Jtjg4z6ZPmkxe?=
 =?us-ascii?Q?i9o7keIN7yovE3SxIPZ1e+6sEHJ4Ejl547szQLlKv2xG/mDWOzs5m3c49ZS9?=
 =?us-ascii?Q?jpaucq5vMd8fi1rGY6o1qix6t4OVC8RyAwLJ/xr17ze82EFs40+4Ie29Pk8B?=
 =?us-ascii?Q?oYfMxYCC802UhSTbkdhzFEr/mdAhr166RFjET8CMXs1yFq1zbUmseJk6x2Hp?=
 =?us-ascii?Q?m6TaHmikd+BVaRkAuZiepnrq99q2ssPEgUUF55tpx9cOS74JX5trsQFws/5w?=
 =?us-ascii?Q?VNujJGbJ97etXkslbRXZgznHEvrzFQ7O/H0KcTzGWHV+FjURxJktlORS6vVf?=
 =?us-ascii?Q?pWvN/nrh50bcIeYhOdoZackXAPuTCJtEgPKXGbj3zKvERV6ScLcz+B8xA7Dt?=
 =?us-ascii?Q?O9Ud3b0lx7ylyjEiIY2ER5XCCytc8GfvozCedpJ3yZ95L8N63ZGsvMU2a97i?=
 =?us-ascii?Q?AYFd7IFPMznYSgnLnpOT5KYXdejv+uDcPOcZtgC7hz8tcN9q2hhZuO0V7spk?=
 =?us-ascii?Q?74KKyyK9bhLSxt0GlhR24xDUMmGHQ9LV0OTDXCH+fWSYqpyEHXZJB5BASPQ7?=
 =?us-ascii?Q?EEqUjiQDsb/1tw1Dx/jlkXlcrUXluCQSD1VUanNpe38talQtzbvgaYuyo2YV?=
 =?us-ascii?Q?8Q0aG33ynrf0R0THiYzy/zJN+I5DEfW8Y9cqIp4Yg39Lp17OdJyYJv6XD6hF?=
 =?us-ascii?Q?PWEg?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe67b527-4eec-4e12-421b-08db76f877e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 10:22:53.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noSCbdIEl17AP3N/FvRZr/aFw87LM+cPWAqzSLrZbg6lJ1fTB0DFNCB/q8+1pcc9oby5YM2mP+CgDoYfuuePoOYIkKs09cb0VJVeiRctrTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6568
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20, 2023 / 15:27, Daniel Wagner wrote:
> When the host has enabled the udev/systemd autoconnect services for the
> fc transport it interacts with blktests and make tests break.
>=20
> nvme-cli learned to ignore connects attemps when using the
> --context command line option paired with a volatile configuration. Thus
> we can mark all the resources created by blktests and avoid any
> interaction with the systemd autoconnect scripts.

This sounds a good idea. Question, is "--context" option of the nvme comman=
d
mandatory to run nvme test with nvme_trtype=3Dfc? Or is it nice-to-have fea=
ture
depending on the test system OS? If it is mandatory, it's the better to che=
ck
in _nvme_requires.

>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 63 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2e0c43..00117d314a38 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,8 @@ def_remote_wwnn=3D"0x10001100aa000001"
>  def_remote_wwpn=3D"0x20001100aa000001"
>  def_local_wwnn=3D"0x10001100aa000002"
>  def_local_wwpn=3D"0x20001100aa000002"
> -def_hostnqn=3D"$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid=3D"$(cat /etc/nvme/hostid 2> /dev/null)"
> +def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d=
0169409c5e8"
> +def_hostid=3D"242d4a24-2484-4a80-8234-d0169409c5e8"
>  nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"1G"}
>  nvme_num_iter=3D${nvme_num_iter:-"1000"}
> @@ -161,6 +161,50 @@ _nvme_calc_rand_io_size() {
>  	echo "${io_size_kb}k"
>  }
> =20
> +_nvme_cli_supports_context() {
> +	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
> +		    return 1
> +	fi
> +	return 0
> +}
> +
> +_setup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	mkdir -p /run/nvme
> +	cat >> /run/nvme/blktests.json <<-EOF
> +	[
> +	  {
> +	    "hostnqn": "${def_hostnqn}",
> +	    "hostid": "${def_hostid}",
> +	    "subsystems": [
> +	      {
> +	        "application": "blktests",
> +	        "nqn": "blktests-subsystem-1",
> +	        "ports": [
> +	          {
> +	            "transport": "fc",
> +	            "traddr": "nn-${def_remote_wwnn}:pn-${def_remote_wwpn}",
> +	            "host_traddr": "nn-${def_local_wwnn}:pn-${def_local_wwpn}"
> +	          }
> +	        ]
> +	      }
> +	    ]
> +	  }
> +	]
> +	EOF
> +}
> +
> +_cleanup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	rm -f /run/nvme/blktests.json
> +}
> +
>  _nvme_fcloop_add_rport() {
>  	local local_wwnn=3D"$1"
>  	local local_wwpn=3D"$2"
> @@ -235,6 +279,8 @@ _cleanup_fcloop() {
>  	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>  	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>  			       "${remote_wwnn}" "${remote_wwpn}"
> +
> +	_cleanup_nvme_cli
>  }
> =20
>  _cleanup_nvmet() {
> @@ -337,6 +383,8 @@ _setup_nvmet() {
>  		def_host_traddr=3D$(printf "nn-%s:pn-%s" \
>  					 "${def_local_wwnn}" \
>  					 "${def_local_wwpn}")
> +
> +		_setup_nvme_cli

Can we move this _setup_nvme_cli call from _setup_nvmet to _setup_fcloop?
_cleanup_nvme_cli is called in _cleanup_fcloop. I think it is a bit cleaner
since those setup/cleanup functions are called at at same level.

>  	fi
>  }
> =20
> @@ -436,18 +484,18 @@ _nvme_connect_subsys() {
>  	trtype=3D"$1"
>  	subsysnqn=3D"$2"
> =20
> -	ARGS=3D(-t "${trtype}" -n "${subsysnqn}")
> +	ARGS=3D(-t "${trtype}"
> +	      -n "${subsysnqn}"
> +	      --hostnqn=3D"${hostnqn}"
> +	      --hostid=3D"${hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=3D(--context=3D"blktests")
> +	fi
>  	if [[ "${trtype}" =3D=3D "fc" ]] ; then
>  		ARGS+=3D(-a "${traddr}" -w "${host_traddr}")
>  	elif [[ "${trtype}" !=3D "loop" ]]; then
>  		ARGS+=3D(-a "${traddr}" -s "${trsvcid}")
>  	fi
> -	if [[ "${hostnqn}" !=3D "$def_hostnqn" ]]; then
> -		ARGS+=3D(--hostnqn=3D"${hostnqn}")
> -	fi
> -	if [[ "${hostid}" !=3D "$def_hostid" ]]; then
> -		ARGS+=3D(--hostid=3D"${hostid}")
> -	fi
>  	if [[ -n "${hostkey}" ]]; then
>  		ARGS+=3D(--dhchap-secret=3D"${hostkey}")
>  	fi
> @@ -482,7 +530,12 @@ _nvme_discover() {
>  	local host_traddr=3D"${3:-$def_host_traddr}"
>  	local trsvcid=3D"${3:-$def_trsvcid}"
> =20
> -	ARGS=3D(-t "${trtype}")
> +	ARGS=3D(-t "${trtype}"
> +	      --hostnqn=3D"${def_hostnqn}"
> +	      --hostid=3D"${def_hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=3D(--context=3D"blktests")
> +	fi
>  	if [[ "${trtype}" =3D "fc" ]]; then
>  		ARGS+=3D(-a "${traddr}" -w "${host_traddr}")
>  	elif [[ "${trtype}" !=3D "loop" ]]; then
> --=20
> 2.41.0
> =
