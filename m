Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7D644C39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiLFTJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:09:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1C9FD3C;
        Tue,  6 Dec 2022 11:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670353773; x=1701889773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zzJiJy+YrZFZDDebjMRoyIVpKbGT+2ZiQWsr7FkTNg8=;
  b=TR/HzZcQg0fGOGU+nVEMClMD8x17mhCOOLhgwSxQjCzBjabcCCVrROIY
   DpyKUdbZsoKqSj1VMNxBfbtXnS0hijVb0eghfvLCa8aac8vxlFOJKuEzO
   r9ZDnyIQ/y7g5f0YtFxSaV1TD6odp7vmdg7C9uAuSbi/z/mRgOLwIfNxA
   G2qp6et/4MAdWC+pZ9PcK4aQAh8RdWPc+MEdZ2JcybEzDH1SpvuonP4TC
   v5v5EDiMqFE6g+axmC5LIg84vbiY6iMLuca34y6m8Q2lD4hqX+J07q9ET
   oY8G20LkzHt7nkaSGkRZR7Kk3CjlOK8uX9KWbAWowLHpjkioe8zSlAVLM
   g==;
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="191967372"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Dec 2022 12:09:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Dec 2022 12:09:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Dec 2022 12:09:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg1KRWO1zBXCvlXs1M4aqGrA9cKDtm6A2vqqe6/B3WOeDDNNXhtHCETZs5S72YrJ5X5GJEhqPaYJzIfezN4135H6y4TJA6R9YYu9/+CUoV7XuW/daebh/67cYRgPFMzttadAjXAlkUmJliFyLmt0EumsfBhZENtUa8xfxHvJXr8mAzgWMXmrvDLcI6BPDqfqa92oz2g0cCKpwfguAB9mj5EjhisLqRNy2M5pcEq0xdVHcXang15A3AqK0HSTE9GH9q53eLUKE25MgA4ZKPyoqz1v4BMHrWxXbZybTTjiJ/QCdtL+Q5MzTaoqd201tkNogidUcqEQs5sdb14nF1qKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzJiJy+YrZFZDDebjMRoyIVpKbGT+2ZiQWsr7FkTNg8=;
 b=j7tia1EspFg4eYuEoeshyIguUCFNiBtXWQGXmZ5Po4CwfCSx0EBdVUndtt2XEn9lzXIOKKZIW5uyAmQq7lxrfOLtj5jvwUVm7H0QF2ORDN8lCcDS533K8y4/s9vyvFEuyonMZ0kPWMU0ZCmnTKym54SHrEh4Sb6unsJcI9eNaQKG7C4wSGMVR9GrVNzW8DlNahGtZ4GXiWYLyCi0UPoeuia5EDnVuDd4H3q5aQtKCcMvBcl0Bf8nkhtj3WoZlPzgglze8LjyhAv2Z18mXUTNgWYgC3XQx22xDi/UUTqmKrEdvwn75sHtk33D1F7EcXZ3FJXDM3VzxZNI+AfHm8q6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzJiJy+YrZFZDDebjMRoyIVpKbGT+2ZiQWsr7FkTNg8=;
 b=PBypg59yQq2nG6AyE0VnTigNUNR954Fgp9NE/8eawSWF0xy7hqflQOMJEFrI0Q+ieiD0liywVeImyBzYn82sDIG0Lvonxr+nPSJgBL8SF23cZt+0cxAdNULqHvni+MIDAvdQijB1hLA8pgrCR77j843P/B3WAM3YFcTEC3FF968=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 19:09:29 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 19:09:29 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <macro@orcam.me.uk>, <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>
Subject: RE: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Thread-Topic: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Thread-Index: AQHZBUCMGKO5aoAXuUK/qHrN6icBR65YvgCAgAAzs4CACE3LwA==
Date:   Tue, 6 Dec 2022 19:09:29 +0000
Message-ID: <PH7PR11MB5958A77F93BB2ABE244123909B1B9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
 <1189f5af-aaac-f4c8-b928-cda183e7f90@linux.intel.com>
 <Y4iaC7rRkBhyOIsI@smile.fi.intel.com>
In-Reply-To: <Y4iaC7rRkBhyOIsI@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|DS0PR11MB7682:EE_
x-ms-office365-filtering-correlation-id: 24ac85b9-480c-4835-6a68-08dad7bd66a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBr3PIQ0fiGdx0uSOpseT4WpzFm7i+6vzkdwCVe4PTFCIxMmi2nH8SPNjJHI6d/qT/e9qWk3NLWTTMLaAXDNf4T4Mck2OOiN9nWlT0oNZiAfutLx1B8pLffRSvKwYSUq097+xK39u4XID6myerGxeH+SiRRwjNzV2rTFh0OPOBL/H2ZYLE3ShqExbXjPnp+n+xD4vimGj+r5Fr81Y8wUeRE/rPCe8n7vugg+WjAWXJKtqZYTg0d5+Qxc/LvM6+63snwmkEiKZbbITOwPek7/vCxi2L9SnZCQUiHTXOzZIx/vQTmhdraoSVh9rt663KfuQHIBH7SrmObTBgbGnzAaClypbqeDNcQwl73Lv+lN0xF0Om1+ruY7XaUdA0+yRua/IVmNNwjyuiBkEV3yXZkzchYOCPXpW28fTDD/Bao4BaozlbCId0bUqV0VY2p4Ks0xiy2ltidG28YOUqkAE9eE59v/uOH9BL1aepp89c/WcvmnTD6zkMFWILlKeG7d2lCx7UP6op3v9+QdmyDC6eI6+T4zHABZ3iDi5ahnJCzi4kO27c8/bef6sox0+DLSw1bzpcyjCjwZ+Z4eqabdppDrkVsHHtOHr54mQStEvix4fNPHqasS1i6q4NBkfVbwf3r/jxI0hWZ/yWXabYTAmmfrUpipjq45mIl/xkWFfSm7MfEm0u0d18/ri2VoqzNMbHIUNhy5sL6XwUQat47DSedUXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(122000001)(33656002)(86362001)(5660300002)(38100700002)(7416002)(4326008)(8936002)(38070700005)(4744005)(2906002)(41300700001)(52536014)(8676002)(55016003)(55236004)(26005)(186003)(53546011)(7696005)(9686003)(6506007)(64756008)(110136005)(66556008)(316002)(54906003)(478600001)(66446008)(76116006)(66946007)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xjXYvySSqcTwP3hfODQGJwIwGnYTgG1qP/1pSOAvdYZpXKNeUsiLI89N8I?=
 =?iso-8859-1?Q?u6DyG8mnUQV2FUa/3CWhydurzpm32Pugzu21+xriAOeL9xEyLYpFq24b7Q?=
 =?iso-8859-1?Q?FCN2Ay1OLR0Bj7UYbxi0Yfp5MmbqtipoASnzYg8Wal+poySk6zJFrDRNjW?=
 =?iso-8859-1?Q?AXA00crdltykD0aPZf2cjY3WOeU3dSFD1TESHENk8PCUL8k8D/jvCYXaQv?=
 =?iso-8859-1?Q?vBtFGMhUY1TxZBEcpZI74d1iU/D+MjJGJcgwOh/DFOucNgX37iCcWTdva5?=
 =?iso-8859-1?Q?8oZwjDONkx35+fnRWKo81fYneYA4g/p4n4uSdenVEV/+yQyh57si06E9L+?=
 =?iso-8859-1?Q?3v5B+pjy54LTsHzpQim91FhDl/WUN99OBIaWK0VhCE0vpRAw+wv8dob2FR?=
 =?iso-8859-1?Q?Ww500u1v6i4ez8fdDvXejYG+f53jdFjQQ0AliGSmJwcG+pDNqLHzr8P0eC?=
 =?iso-8859-1?Q?h6m5hhc9PZZuKghDxgcl29uNf0RZFsy1PAUx05oIxM0lIrNiY3RHoG3Dqq?=
 =?iso-8859-1?Q?Qj85l8Xb+hQlzSDJMNZwd0ex+SYOC0pHE2c5mYBuWot5MU/fgYcDNjvYdx?=
 =?iso-8859-1?Q?FAtEsKjU1i/jk7BJ33RV54FQmmRrlBNgYdetz9PXa8dD5XGehWqr4z9MQj?=
 =?iso-8859-1?Q?no5Jv6Jy/VVrduPp+NQhUIc5UUie9Bg6vTOo2PZGKV1V7brBZ+q8i8ozSW?=
 =?iso-8859-1?Q?X+1hiT51hx55bzfM2IBBJX9lqQXClOOIlm73xPno9aR7fcXJHThFq8v6g+?=
 =?iso-8859-1?Q?eaYsOowR358NurJuGKEEOOfB3dYeb0K2//8en9pYMPw0jLzAnMdYS4jBtm?=
 =?iso-8859-1?Q?UyT33owg4vlVsegG21DTT8yqj5hvULhMl6COhOaN30Ttm4CM5oJqnBxoZs?=
 =?iso-8859-1?Q?mBpqrXasTeK/MofJJ9r/gA6BfEhM0mbiSk4yTGI//Qtk2nUU6laQpqXpQX?=
 =?iso-8859-1?Q?hV7C8Wt6CN0W6CDjEc9qAr8DJ18ff0bDI3fMAX9U3vso6nz61i7uUSJXor?=
 =?iso-8859-1?Q?tcWZpbixo6PYiLtLzD/OEQwFYgrvGozXcKY4GzLwiWZFY2vc7lzzgMawK3?=
 =?iso-8859-1?Q?tcpJUG7vPmDi+mZ5hYY+2SJOSeWtWmesaxSuafm8XmZyno2jvtB2YKFIpa?=
 =?iso-8859-1?Q?t1FFjFpS6eo5m0p6w5mwwCqWW8UC9jcrbf89JQMq+daf37XBjAARngD6rk?=
 =?iso-8859-1?Q?fFYkYi+UxJbxzN+Xs3zices/6rrU9E0XwVB2j/tNv5RMsA1q8cQqIZaQu0?=
 =?iso-8859-1?Q?HZCEWVU3Aq6qLZCCg5ZYyWC8gWCRi5x5+ug1Z0j2gxbt9VjK8mZyQYx0hz?=
 =?iso-8859-1?Q?5h0KRakoRmlYkmu4Om/DsxB7qs2R0/MWfYOvghNgqfoj6aBE9/mMHu2Z93?=
 =?iso-8859-1?Q?CV2v5YSiMUYDbXGEBC+fOjoMlGwStHAnTTLJB0vbdqbKd1K4jI/KtlS8n7?=
 =?iso-8859-1?Q?ZuS8NW7Y+iQFjpompkZuCAGhwUjDLOEdSH0jtKX+5mMX8RSmpN9fUtiVgm?=
 =?iso-8859-1?Q?4hrYIZRe7EwoovR4KwUy6XzwNXgejUWs5zPrixyHzW/pEApa7npA6avXcG?=
 =?iso-8859-1?Q?1TKXRw94wR3dTw9IWVNLDpdkkCYqO2LpLjSife3J+iTtIsgMiBDto9me4p?=
 =?iso-8859-1?Q?wLbkZV5WJK+n1WMEZfo1ngiba8fMTEUw62aGJNlDlRNiRjZSG2CLdZjkjF?=
 =?iso-8859-1?Q?XWWTdfUYyaoKCAJn6QU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ac85b9-480c-4835-6a68-08dad7bd66a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 19:09:29.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Br+NCRyhGvO9U+sUlufmHAsfJmr0d13c/3AbphTEgkhfrZVYwvD5IMSTzETh7KhNspoi9cBeU7ThGXQtFTT1X2nl+AjrNKeN64YmRHWTbivi2Bal+/O7cfSR5SZ1ozCH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
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
> Sent: Thursday, December 1, 2022 5:42 PM
> To: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Subject: Re: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add
> serial8250_pci_setup_port definition in 8250_pcilib.c
>=20
> > struct pci_dev;
>=20
> + blank line
>=20
> struct uart_8250_port;

Hi Andy,
Is the blank line required here?

Thanks,
Tharun Kumar P
