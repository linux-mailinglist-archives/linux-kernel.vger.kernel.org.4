Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2655F498C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJDTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDTB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:01:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5096419025;
        Tue,  4 Oct 2022 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664910086; x=1696446086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/eknUNIydhSChasmFc8DvDEHr0kIEMM+AFdoYt3B/d8=;
  b=smFvIyIzvQJwcXlm4GbIVWZweYk8YN5a2wKgEFtJ6cNZSSPzX+fHfYYc
   R0hQt5jAqHfuzf1ZI4zwJg56StaSMefP/YWoVfkqBnVcL3JXquaA9eybb
   UOoobxEvDsz7tQeZpAFX0rDRxsBnX47SmpQpLIbFDOIcSlwsqVfoa3RE7
   GmBCG0FMih0kwTMOhOdSfHgXiD1hBEO5qbkaIw4yilHispZ83B5ZZTdye
   mhzinynvEh6hEJAIrNCS5sZpkssLO0boxZj4g6WBx7qy1pOPNxDN+wsMf
   qHYdhFPySU0rSWFAukI2EtDJ3zKhEPDHgNOSgPqizlMb25cKKHKtXzzjt
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="183299928"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 12:01:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 12:01:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 12:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSu+1k8cwmigbKJnbxF44VG8NnVo0fh9PyBqMphLgzc2tS/mLfBG4D5Huq7LoDDLTvwuLweXMt69uICGZl3dtpVYqiIm2zCkrY878ca36OJ3lERYDcjMotGYm02HkPIuuM6i6ke2lL+BKko9o+2jXs6FCj6D0REDVJEyfbZMoDuP/kRWYhY3+bIkQBfvF8v0Qw1fLWRHz8LYu5DIDmLv3zP9XdClvTCJ8ax4Bg/NnRsBpuGFZDlEh3dkdqycIDNEXN694tJJdXv4P1kiyd0RgbxZXg/PE/2+qgdJniV3xSDBgQcDA+gupIWmb14tU5YdNli13ReIAK4H5LaV9Cmv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfy2k2HzSuwDbGuCvDLidWYhjn6SHVfdghhYRrPS8Us=;
 b=nUM9JdlDVvc8rNtjzbTVWoHfgkPv/5VWUD1XAWYzMVOtuwtPOzRP3Ub3wXMBXIMg9+MWailcHEuIan2CLAYMFbNFS+1Bwcsqu+cbNAXHByIZL/CV6gz9GBRF0lRuh9yiyozYo0IASdBaHU+4rN23+NWUIYKia2PwWlLUWN+ycjLEGcdE28skIySBFZBD3MYy++uK2+sYANUTlAjixHqniS7kl8z121OXxt+tv8Y87dr2olAMOq6HEdXwu3x/SVRVjCMc1NLrsY4q1PZkVl4poO13FHltCS2OE9sLSrfloHytG3ISSQk7lQxhc5PfVhXrhYNTgNiSC7mfY2G6RbLMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfy2k2HzSuwDbGuCvDLidWYhjn6SHVfdghhYRrPS8Us=;
 b=AViNyNlN+B4iqpvpkl+cMkVJBfkYYHixuSnOnW3yrjvT/NFvpMvUUTE/sXk6QqZs+Pm/D/lbxbiZb/A8XFKjesXOtjOnP+FiW+RIIh9nM7s1xgey53C2tXlkYYcYRa5hQpL6DefqFMpD5rVLdbDzHmjVlJGjhGhWl9JWL5FwDZs=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 19:01:19 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::6c5b:82e0:522d:6a2c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::6c5b:82e0:522d:6a2c%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:01:19 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andy.shevchenko@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Index: AQHY1V0267YcXgrzdEqBqc2LceMdk638cKmAgAImnGA=
Date:   Tue, 4 Oct 2022 19:01:19 +0000
Message-ID: <BN8PR11MB3668A5B77A0514EAD23800BCE95A9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
 <7892467b-c2de-c62-e977-62761dc5cbb@linux.intel.com>
In-Reply-To: <7892467b-c2de-c62-e977-62761dc5cbb@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BL1PR11MB5302:EE_
x-ms-office365-filtering-correlation-id: c7349b5f-bbb2-4279-5475-08daa63ad260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAgkc1br4DwSEBk8lTkwplvA2ISK5mBqQ91f8zvfV8Dv007OIstb65gJgrxE3H3bq0jQMytHblPzWuz/3IIh4HkRA5ysu/agiuG4bmiFE3vpGU4pgNcuHqDavZ3/y+kIu4/7k8xRAvN922YyscHZyNzGRDX6l3//TylqytxmyY4ImUXlBwA3BLCfdnpDjO49CanFJg1HuYsG1VXw0TwKcrAgGIgepwhQaQim8tS1q0tvqQdfh7QuaTWTK8usA4TTFCboNJN05Hp00MKIz617tzKj3ybj6zVuzGxGcnLcNHOnywcv9TgkR8d9rA49US060jDjej+9BWS7ukR9hj7WOkk8WzaiDq6wKIFkM1iWkZpkXEAhY8ZvQ0yFld8NyOjvDnzOVTcAtcNpU1zwuGPm/QqwwKTU7Uwkxc+1saj242jdcTCg9/0n8NFTONZP81FHVtf7QydF3ZB45LSngaPkdIQqKQy2vwZ4YOnVj+bn6FiForwLCY+8I+7Q8TJhQbZK3NRJ7asnE9+u6rpoZXcKnQdoH/7ogpfLf7TS5tTAJTK82McReNrvik3HFw7ye1aBRNu4apMv+Z4O3Xkcgy1nXqX7DQ0RsGv93V687Xz5qBvWB8eQFEfv09J7/koF7x9gphvgCI+fYZOpe0qpmiXRcF/MW9Bat0hy4d/4qI6VtRHEIe9gEFXAa9oKg07mwutDU+IOec4pYJ4ZqpUbNv/lgKQYT8nhTvzDx5a2WfLh0j81H8RhsGoKRuCLK+X4/aF9I5lS79qwjr0P6Hjmr3TAsZTaRI2mTc1d/VvaOazbDfunXggMSgcYy27CYWWEVg2x6hIqDhEZRiv92OGaL8uZRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(66556008)(7696005)(66476007)(64756008)(66446008)(8676002)(4326008)(76116006)(53546011)(6506007)(26005)(66946007)(54906003)(9686003)(316002)(2906002)(186003)(33656002)(66574015)(38070700005)(5660300002)(122000001)(8936002)(38100700002)(41300700001)(86362001)(52536014)(55016003)(83380400001)(6916009)(7416002)(71200400001)(107886003)(478600001)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r703EHdYBPBklx8YFj0yqfqAWAlXiaqqy4I7Tfo/NWyCU+MJeC8tlNLD3m?=
 =?iso-8859-1?Q?WN+iy72hxOccFhk8yGzC2lFv/C/Uii9B7S2kYc1tGpfCZdphx6W9WE+mae?=
 =?iso-8859-1?Q?ccXVgYjb7qBgbasroFOAt2nSJUV7Sa2k0+VzTNUCU245CiMaMGVKxgFin6?=
 =?iso-8859-1?Q?GmoB7DHv1nO9fPDNNg9qPXzHataBN8VhUIZWO69yZEqEc69zbjeYVDxvB8?=
 =?iso-8859-1?Q?/rKM0ZWKXdV5N02yz83SnqN3W6kAcChpfBAvQzBIJPFIimInDPzMVNcBNE?=
 =?iso-8859-1?Q?y3fG8CUHg+xzka6ywTJmDMrPQH1b5PHUAv0HVODOf/uTXAMw6AW0+GwyXs?=
 =?iso-8859-1?Q?9qtMEPF3w4ul05orhJ3t/24fbip8rG3xcEUOA0GdwY44TZJ4gPB7mL3/El?=
 =?iso-8859-1?Q?MqzT7u8ElWEuQwnLhfkEzDGPfVWCHESmGsSJkc3hVUKZvYHPrBRjw0aU9c?=
 =?iso-8859-1?Q?X9/TlLTfLRMYviPwUqHgANKNHMwXjBVdxbqweyQvTzRMFwJQcnlomCD76K?=
 =?iso-8859-1?Q?Ye2Uxm3pSQ0Gv/W/PGNdrnSQyz9AI0kMh4wwotRL60l6T53Jz7x0cZnW6Y?=
 =?iso-8859-1?Q?bgbLedqrAOgnK2qkT6cZ8nmthE5MQo3ReiisTdUNBoTJNqfMHzaGG3uvX0?=
 =?iso-8859-1?Q?PvdYiwigOuWXy7k6xAEozB7exVNaQKg2qx64Pn1sBTUdhRFIDCPal7vUnf?=
 =?iso-8859-1?Q?BhXh0DvPwrdrfGqeRv7O6QYDnQfjfjRYs6Nl2qcalWjEsjj8ThW+DlqGF/?=
 =?iso-8859-1?Q?YydlY+TYCmg2a9w3ln4SotkK0oXZEvUlnSoqpklw0Q/7zmJ/MM1gDoZRXO?=
 =?iso-8859-1?Q?lluPRJKTwdVlKLkpFjIpu5wtn8kmyqKXaxhvBTsuPWmODbc6pDNgnjjbSK?=
 =?iso-8859-1?Q?U/nmBUH6fbNXX2ydagB6O/TQ+hK3vzEnUldLeeAhr1aOTJW+ulLUgZdMO8?=
 =?iso-8859-1?Q?xTLcidzjQbRQGFQLt9VSdldWgLpnKKtfKdguP7gY5d7ASgxhqqQATE5j0+?=
 =?iso-8859-1?Q?diemWcSL2y2PsD8Jp9P/iFfikPfVUsRQEcTIysnhxlE8rrsPPWZlhwhm3K?=
 =?iso-8859-1?Q?Ev3w5xVALAd+Hh12rVHpXrRSKbMIZ3z2w7vrDAhLcApdixuqjWhvufMVu9?=
 =?iso-8859-1?Q?A1ooFBTfU6jnwH6WZiRNvFwC243wvNCVvzzW8/HCQwnGhFu8z0iqoxe4+1?=
 =?iso-8859-1?Q?4ai7YZAnOJM3dC4e15rc2RPchURcUXH+5ZcaAZRTxPpYlXZi5vWMtm2IH5?=
 =?iso-8859-1?Q?H+NKFjWfEenu1po52N0o86GGn4egeEnpRFyxFVDSKf6t+kjSrx6VuJwgm9?=
 =?iso-8859-1?Q?US+FLT6tlV9bRn0pgqkXEBiEHq5ikaC8X8Po3HqXIbTwIwiLG3oOtdmaaD?=
 =?iso-8859-1?Q?vKkC/CHJISoo0hQAugXZFdcn/Fj9ZfUlZ+jdM+W2mXzsY/oQoNK9EWrAaw?=
 =?iso-8859-1?Q?FzxApHHbevlVIDTWJo8xneM5YeLrrXjkTErr/TZtOBObkqNK8PROd28cfA?=
 =?iso-8859-1?Q?6AF0QpraBtVpapid08eul3pipU6LHFpbY0tp19YVI/ao7PwOBmM4AkwutQ?=
 =?iso-8859-1?Q?mrAlyGEJg1gPcHwWXtla03ZLNUI/VcmA2ERksnbgsJ+3waBiq9a9DQyWsG?=
 =?iso-8859-1?Q?F6YmT8apLgcuhwPUjptObROln+6EhkRQKrp8cJYHyzcK2Ok02WynHBYW0P?=
 =?iso-8859-1?Q?vlc+Ng94NLiaP6rOtfs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7349b5f-bbb2-4279-5475-08daa63ad260
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 19:01:19.3876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOLjvAGHsamKTZs4oyY+1eCzJMzyPOUm7LyN9KDPU23J9mpOj9ebGWo8AWhIWfpqscugZ3ocA7ToF0UuDkzWp83D4hREftTqPZLk7G5Wq8uIgUXB3u9qarC7hA4L1nbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5302
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Monday, October 3, 2022 3:21 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Subject: Re: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
> management functions to quad-uart driver.
> =20
> On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:
>=20
> > pci1xxxx's quad-uart function has the capability to wake up the host
> > from suspend state. Enable wakeup before entering into suspend and
> > disable wakeup on resume.
> >
> > Signed-off-by: Kumaravel Thiagarajan
> > <kumaravel.thiagarajan@microchip.com>
> > ---
> > Changes in v2:
> > - Use DEFINE_SIMPLE_DEV_PM_OPS instead of SIMPLE_DEV_PM_OPS.
> > - Use pm_sleep_ptr instead of CONFIG_PM_SLEEP.
> > - Change the return data type of pci1xxxx_port_suspend to bool from int=
.
> > ---
> >  drivers/tty/serial/8250/8250_pci1xxxx.c | 112
> > ++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > index 999e5a284266..0a0459f66177 100644
> > --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> > +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> > @@ -352,6 +352,112 @@ static void pci1xxxx_irq_assign(struct
> pci1xxxx_8250 *priv,
> >       }
> >  }
> >
> > +static bool pci1xxxx_port_suspend(int line) {
> > +     struct uart_8250_port *up =3D serial8250_get_port(line);
> > +     struct uart_port *port =3D &up->port;
> > +     unsigned long flags;
> > +     u8 wakeup_mask;
> > +     bool ret =3D false;
> > +
> > +     if (port->suspended =3D=3D 0 && port->dev) {
> > +             wakeup_mask =3D readb(up->port.membase +
> > + UART_WAKE_MASK_REG);
> > +
> > +             spin_lock_irqsave(&port->lock, flags);
> > +             port->mctrl &=3D ~TIOCM_OUT2;
> > +             port->ops->set_mctrl(port, port->mctrl);
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +             if ((wakeup_mask & UART_WAKE_SRCS) !=3D UART_WAKE_SRCS)
> > +                     ret =3D true;
> > +     }
> > +
> > +     writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> > +
> > +     return ret;
> > +}
> > +
> > +static void pci1xxxx_port_resume(int line) {
> > +     struct uart_8250_port *up =3D serial8250_get_port(line);
> > +     struct uart_port *port =3D &up->port;
> > +     unsigned long flags;
> > +
> > +     writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
> > +
> > +     if (port->suspended =3D=3D 0) {
>=20
> Is this check the right way around?
Yes. I think port->suspended is not set for wake-up capable ports and the c=
ode in this if block gets executed for those ports.
I will check this again.
>=20
> > +             spin_lock_irqsave(&port->lock, flags);
> > +             port->mctrl |=3D TIOCM_OUT2;
> > +             port->ops->set_mctrl(port, port->mctrl);
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +     }
> > +}
> > +
> > +static int pci1xxxx_suspend(struct device *dev) {
> > +     struct pci1xxxx_8250 *priv =3D dev_get_drvdata(dev);
> > +     struct pci_dev *pcidev =3D to_pci_dev(dev);
> > +     unsigned int data;
> > +     void __iomem *p;
> > +     bool wakeup =3D false;
> > +     int i;
> > +
> > +     for (i =3D 0; i < priv->nr; i++) {
> > +             if (priv->line[i] >=3D 0) {
> > +                     serial8250_suspend_port(priv->line[i]);
> > +                     wakeup |=3D pci1xxxx_port_suspend(priv->line[i]);
>=20
> So first serial8250_suspend_port() calls into uart_suspend_port() that se=
ts
> port->suspended to 1, then pci1xxxx_port_suspend() checks if it's 0.
> Is this intentional?
Yes. I think port->suspended does not seem to be set for wake-up capable po=
rts and only=20
for those ports, inside pci1xxxx_port_suspend, TIOCM_OUT2 is cleared.
But I must check for the race condition as Andy had pointed out.
Please let me know if there are any questions.

Thank You.

Regards,
Kumar
