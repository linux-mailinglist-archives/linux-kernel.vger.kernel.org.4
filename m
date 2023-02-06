Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2E68BA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBFKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjBFKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:38:42 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E394EE1;
        Mon,  6 Feb 2023 02:37:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjjoBZwwbuLWLWnpm8RSLkllQAuiw2sLWzxBJCsr/3sBek46/nX27j7xKBOj7+VDOnEw0GPWqCLK8D5kfuI3rZN9ogNmwi9liWjSdHswkVup1pim7CKc23MnrSpoeFjdfiPzg1xcR66143hJ1iBen+CYOr8QPlTXLAPlAj1XiVGYydWTHQQUINGG8dqB1YElfkP4AmSZIa9fKVqPO3EhGDEQIRzgSTFdJGApoBY4iF9lHelKcPNuXL5kk7qW90E/P2Wm2V55975AY4Kh5Hwepvyo8MZRgT2/Pld+V/twPV+U8+WscKA1H3JhVahKzLsFv2Y5KO/2XcWkiHbAU9LCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfBCuvw/JzdHGUTshhDzLh5Y1XtzvTLh57ukYqMrvBk=;
 b=IL8mYJXMbUI70vFeVtQV2JApd4vkY92Zx1jmZEE3k2pv246TOuv+lywnUFIye61iFxW3c495SMlIbzRuPnaJnGxkAfWqBND4yRQ0cAlovowPnUppMzqtjpHC5VuTWOTpAtS8qIyLY9A6vc0dfPQKe+cof8D9ObnUGmoBNkHx48VbVmNIngzbi9UgpXkiC9UzeZNw0vaPuw/RMLG8klAQs6siWgDpdiDu46E4Xz5lxUpAoacQWJuL+lwPWLGAJmMMS+6Q9LJptI7ReIc0Q6V9xe3BkmIl60/vYdvOFQ8cRFxwOwBomWD0zOE9S3gcwL2ojB+vvz/SyV+JDFj7Vnw3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfBCuvw/JzdHGUTshhDzLh5Y1XtzvTLh57ukYqMrvBk=;
 b=QXWtQhqbScy73K5/zNSmiYAg0z8gBmZiSOHLBNQx3LpJgRSe2eLuZFLpwSh7hqH8L9urekWnPyb0YyQeXUrIyUcFrwyIW13Com2m+3nyY9qLOug7IMdJVSxC0Bars5PDuuVCL65XVXyv+jLsEjaVGB/pfsoCYr9vHptCzASf/JLp73nE3Q1JMZDPdTmb10WabpGeCIqYsWB04m4naCKAwm+ZOLUUhcpeEe7IE85AMlmsFJ3SRxk7tQI3Wf75Kph+/LPRvP0Ya7hvC52lOSNmiStBm9rkBuinAmOv2uNely+hUeBiJlOcFiPvcipA338A2qtdnKeCo6ERdnIL4Ltxug==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM7PR10MB3287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 10:32:07 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6515:6f15:71b9:713c%3]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 10:32:06 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] tty: n_gsm: add keep alive support
Thread-Topic: [PATCH v3 2/4] tty: n_gsm: add keep alive support
Thread-Index: AQHZOhVfXHwi/lQ56UCRVZUPmitX+67BuFng
Date:   Mon, 6 Feb 2023 10:32:06 +0000
Message-ID: <DB9PR10MB5881A1920E49A1B03E64C5CBE0DA9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230203145023.6012-1-daniel.starke@siemens.com>
 <20230203145023.6012-2-daniel.starke@siemens.com>
 <Y+DVqtfBRytURnov@kroah.com>
In-Reply-To: <Y+DVqtfBRytURnov@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-02-06T10:32:05Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2e8398c2-9cf0-4058-bda9-452c64917d1b;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AM7PR10MB3287:EE_
x-ms-office365-filtering-correlation-id: 56713918-010f-4935-d3c4-08db082d6541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsYpLsavt7RxWJl5w6zHbAklvprPPPh3G1Jp7O8NUUQ1r4m+sebzGCvogc+eN1jK876xp8a3ouPwnzXFRfYUjnbgxyvypjuEppAyQuBhOFPCbLgWwAGCA7Ei8+3yCinZ2CSY31Y6r0uxCmG1iIdw4TQe/vwbRYBPC2Do815CVpUHmAwJNpKeGHsjg5jUS5cfeFoubJkMimDz7MPkIZc44umJAdJHazcG0v8grLCSSV8jIJ/OUP3ePy+iPKTJxqt9uCt3RlWtbz92L+/iRtwoKnkWcoP8CJhX1QaFLFC+OdK3CEqSCw7IfOIwSuguApjSfJ5K7FjIMfaPI7Z4JHGDqeAWDRA7dfKeSFEjq/OooT+0Bs6Kj0J3GrFXVYcaFgztgjqAJAZRTRc2TzbYrGL1e2Fc/epOvHqDpxtUsPwxkx7sZih7pfyLtmzTV/wyDPTxQKFLxH2s+aYBKwEme+tpCfBg9JYQs0prYKGHgyOPN/QXNop16LzGtSsrJ+faqqWcsbp7d8PhAh36pqiPle28jL9y7TGZXgTYS5HJs+mqoZgWAquwWeD7s8xJRZVABmOq3O2gtxAFQjZLGfAB8bB0aT08owrYZeMfQR8ANB+da1e8PRRynrwZS+3SPtWzESUlxwfc0DO9Vf4AYjhNDV31O6904fN8ZkVlJGIWEDKRj3ylYdaGItUW+62Za1hknuZ8hc6vi5dLmy4wS3IXfxwJbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(478600001)(6506007)(26005)(186003)(54906003)(9686003)(4326008)(64756008)(8676002)(6916009)(316002)(71200400001)(7696005)(33656002)(66556008)(76116006)(66946007)(66476007)(66446008)(41300700001)(86362001)(5660300002)(52536014)(8936002)(2906002)(4744005)(122000001)(38100700002)(82960400001)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pdachOAo2hvjZIOlFeNPN9lbDvneqNc+uNZn8kI7hLqoOC2MDX1TCTW55FiO?=
 =?us-ascii?Q?YjpQL+fRLCtZesK7/OFWV+vcu6NI82GgaUWd9tZfPPMNY/vpV0FAT9T5Ik0Q?=
 =?us-ascii?Q?uTNCtI641PRBleBtu+lCj7DLgkpR8eG8P7pg9lpgKnkgteW4cpdz8IHkkd6R?=
 =?us-ascii?Q?G9oaa7L/YV/LJ31A9v8PDQawmtlFPVE4ryqyoh9h/Cfa8LiXj5iji/UE0qLC?=
 =?us-ascii?Q?sPIOvQ49bt5u3yiB93M9LcF1teZZmiYc1hfXhlhNSYd92vXgHkJD3M10RSRb?=
 =?us-ascii?Q?A0l3znW6w1tWjG+ucSZfdV+QLozVmkPbDfbB7ps05XZ1tevDZXG1P65LBjsT?=
 =?us-ascii?Q?2GEo/Bowv6CehrW5h6DniJicsoAfg/UMV3cWkuCEzHAwTQuC6DjgJvgaYZCI?=
 =?us-ascii?Q?VE15EUJOZXoaYFdD+ggGEVZloEM7iCshRAsBJFHjLzZOShOVKtX0D6focvfw?=
 =?us-ascii?Q?Q/Zv2r10rypuajAehwu+87s8/7zdgDZSGsixlK4AunWshCtitXIr2q2emRQR?=
 =?us-ascii?Q?0xVp1cS+/2rXTD3/uVojHsH0rv05MnqIDo9ViMlKErL2kT2m0My96X41dpxw?=
 =?us-ascii?Q?+AIi4zUH59EfYSVcO2GqjPe6Xgd4Xk+5mbJWJGlJdd4LTkgBm3G3Kqev2XYG?=
 =?us-ascii?Q?Kgds0bR34mkB9vhrbda1CQJnSnd7dG4h+O5BLnZ39F8tl62LcUXhBmzdz+nl?=
 =?us-ascii?Q?o+AAaV4tUFSB7RuKzGUYmBLEsOaRDJlL7/umIp2ysNDnaGOjwG7VniOqji5B?=
 =?us-ascii?Q?Bk1Df4i6uQCHDxuEwWNS780LnYcfx9H5zevisugMQFhK2ZuwBkGdzXYSZmzK?=
 =?us-ascii?Q?vHnWdU9no7k3YHyVOhGNMEsMLRk7530aIsXqnqXLw+hyQ7pKu3oNkSfQeE3r?=
 =?us-ascii?Q?n8LzZeZKaxsks+paDqaEzCCCb4CP51UYh2ooHD5sDTmoH0l8Nhjj+lqTx/aI?=
 =?us-ascii?Q?mh+eLI6VBjs9QFolEgaPqt1Dx2LkO0a/EL1eGm6VGcMc5lkvBxXizHkWqPQL?=
 =?us-ascii?Q?229GZkH/4lJ71xK8Fpy8Ni6NRWYcuGl+UbFaQFAO8TISUh71kkxEMxJnUkI3?=
 =?us-ascii?Q?3BBx2BrAaGspl1Sx4pyzDlnbVzD7T+K6r1F5NR6rzKkqu6a6uFHXY3R6tdBz?=
 =?us-ascii?Q?KcDua3aFb3lJnYpUf1BwVpjQgmrjJ9iVkNjoAtLX/X/muxXIQ46wDUbk1UX4?=
 =?us-ascii?Q?25h0c0OuI80vN0GAI46A43PJDzs5G95tsFoPu2kCOsGgVMFarFIbVDshYnxg?=
 =?us-ascii?Q?y81RIygN79zJb3ZpCT9UMkK8vY2D6iZSrdluEBLxfJoAxoWtC88Yki0OCgSz?=
 =?us-ascii?Q?ZZD3WSaaK2o/LfjYMiuhYfB5lwfFo51ePbofletbl8hqHJTsVO7W4ts0jUn3?=
 =?us-ascii?Q?P+mG36VcDqlBgkfoDEDmqqhD/Qn4UEG1Ri4pvl8gmaba93Gh8XPW3NbiwVw4?=
 =?us-ascii?Q?m35KDWDDDwe4V/WskCTZ4/TI1c7brtxqZ7jw2g6pizsa5MQZv0ZOZvxyUFGM?=
 =?us-ascii?Q?hX1yygJLRtAzlDsMJcyr21MO6qip2for1A7pXuJTi8WOqfSUckL1i5OAfdcR?=
 =?us-ascii?Q?V9eHH/ky1Ltx/zs1BqaBaG+GgTqAOcZpgPRKIu1D05EVRgsVYhq0VVfgTlAl?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 56713918-010f-4935-d3c4-08db082d6541
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 10:32:06.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no2F6WD1GgvY0bzgpHYK9m2TDPP9mHd/CF7anS+q5hOEkpJLVbi6mYaqqbhCWMQYnw7DDR6W86JCm6ISGTJ0t0GSdMHn8X4BcyzaMwE+2Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *=
ce)
> > +{
> > +	unsigned int i;
> > +
> > +	gsm->keep_alive =3D ce->keep_alive;
> > +	/*
> > +	 * Check that userspace doesn't put stuff in here to prevent breakage=
s
> > +	 * in the future.
> > +	 */
> > +	for (i =3D 0; i < ARRAY_SIZE(ce->reserved); i++)
> > +		if (ce->reserved[i])
> > +			return -EINVAL;
>=20
> Do the check before you save off the keep_alive variable?

Thank you for this hint!
I will change this and send a new version of this patch series.

Best regards,
Daniel Starke
