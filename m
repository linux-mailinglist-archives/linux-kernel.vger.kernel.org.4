Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38BD64E97B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLPKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLPKbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:31:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4958A209AC;
        Fri, 16 Dec 2022 02:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671186703; x=1702722703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IWwizQx6y2utuzOymxyVJ/RyycE6PgT5xrcq/hpOycU=;
  b=jop1T+mA37Dj2ehJU28zdQP/ICjSncTfhR8u1qyACAts8YiVBx7fJFrJ
   uwOkGes1sH8XDn/DWSWdAJe1O4cyybNdxaf6X09cNJwViH8LSJG4kzoJV
   M+D0XVDQMvX69igGhRUXWIG58wGJkuVGkYrJzMH5GJEJT5OdimEAJ4IKL
   AijnH36pan6aT8FNEdJXilLLY9geQSw0xLVw96kEVeb1Qzq3+D1kmUZfY
   vlsUeXXC0fTErHiwSNKqD38S+c7+Tm0slmC2VTnxt9JRQhsGlJfX0TZzf
   qvZ7UlYA6qxnszTS4m1ZpWHufOy9fO0DRnUASyMkIVQPBZR9UPkOqJRhL
   A==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="188487999"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 03:31:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 03:31:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 03:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqMIzEuK2aq2mOBQzS1RXlvuRHo0Vs0pe/rYos8hK1l2met4mJCW3DpRTmXF12/gohfEDFtUon5SObUl8+2M0SnJMpVWeeqEKy9jcD5e+LGaN4aQD5rO4iHQNVxXzCtN6e5L+Clsv2hWfSyUlxgb2EoVX7X6NJSVxZTcAVYGGIe20RyChfBEnFxH8zXavKQkAVjEfV/XCMBT7BXQJy/Z8XT8agIHGG5a3tvxhxjO4GANq6WplLds9vTKOj9rBIAQr0Afg6V483cNp+uOv3HqYEyCkYtN2bIqDZwTdO/CgBMbuge5gdmM4VTodcbHEWtmI10t8Dv/cJoFQaAY/9u4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWwizQx6y2utuzOymxyVJ/RyycE6PgT5xrcq/hpOycU=;
 b=Xz/KOTRhETLWzWcR6kYijNgOmvfMcRjpyw6WTf70k93rLP+zOESbiy2ky35AvkCS3SDEVGizplFXPRGOF3P6L+iB7sf+D/JuxLHXFQoZkM4n6ykBHpUrCmCrh1fMZ25ods8wXbJDnr0U6aOO7xhxmguQQtOmyyrvpKbbQmdorOyoVgf4xAlVx9TCKlSlmsANtGyIy/GVwsQSz9ROvDruVwI9aUrkwDMYwoZx4glG8FlwwUzH3zY5+B+UX/tkLWtU7mDNGhKzxUer3kJYUA70XvcIPUyH06YJaeQAGyqoBAOMDaWF6/M/g2vB8C0raV0kj0LowRdWSyJi+pUysXQpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWwizQx6y2utuzOymxyVJ/RyycE6PgT5xrcq/hpOycU=;
 b=gb7SJ5V00FSoQx8m71r35vLABDcbiFy4bJIjGBrQgqHYAhB7YSbJ0pj9WbkcU/nCt0CtF0xSRkY1+nnui1Rl/Lf4h/c9P/GE8XvQ7Swf5KNlMdF4okSJGN5Iuycn4zuGA+UwgTJBlbXbtlvz/w1LOi3xST0hT293AOPxfZWv5Lc=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by DS0PR11MB7787.namprd11.prod.outlook.com (2603:10b6:8:de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 10:31:38 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 10:31:38 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZEKWxJyYrAeLM7kuV3hibr7zg+q5vN+wAgADGUpCAADCNgIAAEWGggAAC54CAAA3ukA==
Date:   Fri, 16 Dec 2022 10:31:38 +0000
Message-ID: <PH7PR11MB595883AB9234881B2CF362549BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
 <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y5wrnzLMv5SCWPkn@smile.fi.intel.com>
 <PH7PR11MB5958956CB3DFD8E9B4A122379BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y5w8o0vK7wuoX+yh@smile.fi.intel.com>
In-Reply-To: <Y5w8o0vK7wuoX+yh@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|DS0PR11MB7787:EE_
x-ms-office365-filtering-correlation-id: c07726a1-7544-4781-ae19-08dadf50b6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OftP5dQSwEdjCPPCRNotjXr1tGJVGXpFUVgA5OutfjKSaIqNWH56zDV3/G0mUVsOeViGdUepgpjzQbkWWq7hAMMcWXQRY1Q0Sqh9TivaWOPRPUX2FfPwqtwu9lKk3lZb/Q2bLHCjz/0lyYgkzd60ECZ4qYSjMvyEAI4htaDjvF3UfJ2bDf/103ltDXidbHen51dX5JoTmOvKFPn2uSWNx8VDY+n09W/WNeOp1AUUeKkzKv43tOWJparGUVicqzMUO2tkxRiWrxUvWf2CPdN7ZlyfByz7lOQdjygE96oOXJsJXvXTgL+lIkftbG4m7RfVxRsnvN7nLeohB90e8I2AqvhIjC2w3YoOhDLZilYmUFh0R1JkcQx4lgEQ9dpEluGoDcdUhsY1iGqi6W2qCod+BBUCpC8psQ76nPS8UJSPRUP3SxaMsi+ZYlzWTwu3O/DJ4VqPuy2SQjgBszaLVraeKFto8KC1ZqoyzE0et0XMMk8MayIgGIrn8vlzC3W8CejllCQFnLDs0AtHDqWICtIG6gEDhp04sYg2xdcGFevTX89XuJ7iLOudDvbuKMUfrs+6zG6XxOE8LrfLzIl9U+VZwVLwo/3btB61YVf3FL/cImL3AzDZdIzi8IhGysboNF4NITzmaj5hML46yp5vgUcyGp0rsnrCteCY1SsefYvrnoTbToF6qWyRWYtO+qXRIBeX0yqhU2ssnedJ8fktcrOTmFplAwoQ8dKb4pdAVsvDATQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(66476007)(8676002)(2906002)(9686003)(66446008)(186003)(26005)(66946007)(66556008)(76116006)(55016003)(478600001)(966005)(52536014)(41300700001)(71200400001)(33656002)(4326008)(64756008)(5660300002)(107886003)(4744005)(8936002)(86362001)(7416002)(6916009)(122000001)(7696005)(54906003)(53546011)(316002)(6506007)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ByA9Lp97jLWTLpM1OWlems4KhEq1AeWkK37R5t7UcgaY1DUDilHcTkZdmXrB?=
 =?us-ascii?Q?c7ErEqfdfMMNP4duRbSkyD/F+i3p5TGq/u06xmGVJgGo2ZpHEqoVFKnqRgui?=
 =?us-ascii?Q?g3s+SopFb5Pvolq2V1pFNrmT+Rl+MuSGZ+lHbzV7GAyF0ICgmZ9NnCKMqb7D?=
 =?us-ascii?Q?JX48lPKuB33yEXXVddqBVadgZ5IdYtz22Ms6t/ysp9p6Pdni3uhwYmkz9Gkw?=
 =?us-ascii?Q?i+HgbyYFDmN3awOPTkdPNaIBtwHMTFZB0e7Rd/LAUHyFspIBMCJwGZNTPodh?=
 =?us-ascii?Q?tAbWCvYYPTQSOAnh51CpXm+4oEP5FUN4THBQcLXxBsdJ47CLUm1YQ17Iqk5o?=
 =?us-ascii?Q?+ZX5pbXNpvVGEa6FWmaaDSe48CmhH5Vb33d62Flt5vkh7rbSKm7A+4rGkrqN?=
 =?us-ascii?Q?riB7P2xiMVsSuf8MkqcdA5nOpsrKUxgn0douB76/uG/WLuZV7Ukc9YSkO31d?=
 =?us-ascii?Q?fQI6ER+Z4tLPMYwInIDpBJ0cU1uQwzLuW/4EY2kdS2pjegEs6jAM2b1Yq+vm?=
 =?us-ascii?Q?0AA7CF6TjW+tGR/SXS/rFSwTTK8+Eq0EAsFXge+G2gIu+FVfLcCanMtRDles?=
 =?us-ascii?Q?oZ/RsVdY9FWhC/lFEesn5rJ3D/Z7VtWpIMcdjJfNo3T5gcByT7l7LH9U8rlL?=
 =?us-ascii?Q?Vfi5wzh/8MYlNm+zjilTOLDCnJI6bMMK6ewVPDCBuXBwYqtQQyJxmT7L9zFt?=
 =?us-ascii?Q?uT4PzzW+vDM8Hp9NT5NgdL4nKZSVLD+/XGVgLpivmmggWjAvK1966qySWJHJ?=
 =?us-ascii?Q?CjK71m5axSuOQM4JKyEoD5zzeRpqXhauZZEN5kCSB1qUJSjalMwW5lwa7rC0?=
 =?us-ascii?Q?fWt5RtgHqQhn567Q8Jk5faHe6bj1GWehqrvpUpFDltDXrcl5HN7zOGyVPIeX?=
 =?us-ascii?Q?BrvFGCg+LUz2n1/I57Wf3NRmOazCPtkvR+jMh0xYmysd+6HjtSVKDdH01CQ5?=
 =?us-ascii?Q?uHoc3El4pwMPniYE8yA1+gv+V0eKjIqQV0xuSduKN96CGR9KtWpc/XesSX9v?=
 =?us-ascii?Q?k8m8yLFoomZ9/89hPUCV+6Q47+dTrgPaBdoF1lSlnQcG6roCgyFz0Qno8WyZ?=
 =?us-ascii?Q?KQ9zKZqOqBbvK2RBfph56rIsuTd9vRbE7+mYwuCVQ8cl6zeEnOcRSR0C7vkN?=
 =?us-ascii?Q?V3AHmxKNDGFT6sxmdd5/u58YjhekWC/foipDpkDFDGu7kF3Nv5421BtwDBHm?=
 =?us-ascii?Q?j07p0BsnBx4xADUpZjjQvXsEhxJT1l4/19s0CxrFvFv34ZL5PPukioXZf4h3?=
 =?us-ascii?Q?s4uYokOvdnzrRCdRNjS++tk0kb4X2y0lPZSfP1Mp8cdHQ7aQM6GAma0Q6N3N?=
 =?us-ascii?Q?KJ95p+beX2lHLuFYkNi0L+ttgq6+ym8GSUNLGecz5ikAhTv/hKQ7BC1u32w/?=
 =?us-ascii?Q?LQvXQ5Rfu1+YZnVgrTY+vZbAyd0107wZasRQMaBnW/KHpTweXf9vCggizscH?=
 =?us-ascii?Q?II8Gi6KMaNQ/lsooJE0GWhkTHy87t4GDHJ24W2I09nX7Z3TYzrso4gSvroRY?=
 =?us-ascii?Q?Fm9E3mJbLTF/5gZPSyp1l0Ls5I4qbstpJMHSc550u73mvNXHlxcigftBj3VZ?=
 =?us-ascii?Q?FmMkeKUZMj7tE1PYuO2jBrAc32ud+haDcSmr48CthoRPwQMw+ky73b2SnbDH?=
 =?us-ascii?Q?Vv5Q39yFuSYmy3OU9+Su/Z4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07726a1-7544-4781-ae19-08dadf50b6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 10:31:38.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NReoC5g4/xW9L50XVq8psF4xpzdSjtgcLNVfnN9y4ZfPWIt5O8l80A5BAMx5sNIPcPrMMTpoCU+5iUGSvY6NSOcOLcYS9QRVUhkkZrjknzBtGjeqTbaCwOgXhu63i4cq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7787
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, December 16, 2022 3:09 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver fo=
r
> quad-uart support
>=20
> > From this sequence, it seemed like, kernel takes care of freeing irq
> > and calling pci_free_irq_vectors is not required.
>=20
> Technically you are correct, but... read this discussion, and pay attenti=
on to
> what Christoph said there:
>=20
> https://lore.kernel.org/linux-serial/0250c46e-da6c-71f3-50ae-
> b7c17fd0bd2c@siemens.com/

Okay, got it. Will use pci_free_irq_vectors.=20
Also, do you suggest using pci_enable_device instead of pcim_enable_device =
(to maintain consistency
of using non managed APIs throughout driver)?

Thanks,
Tharun Kumar P
