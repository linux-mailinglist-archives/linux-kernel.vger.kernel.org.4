Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D133C693147
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBKNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 08:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 08:43:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FF52684C;
        Sat, 11 Feb 2023 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676123023; x=1707659023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P7/PR+LGeHHHIrtb1kytlxGa5bQW4pRkpANnDlzEPi4=;
  b=wnEQhITouTQJ8dXlmdbc6K0iuJ77UsTSbtxT/OpWkywBw5dfsGFVnkEW
   nTA4kyUor4y9asS9nTJGVoir/AFHHlNLP7Acko18iMQmsys1DdNFfM4Cp
   zW3AhcL/7edsjT2+4qOcgzFo2V7wGqc95zvZPVvjpGDu/Rcoj3CqDUiZD
   2SkbjCcXncZYu/fGOCbfgGdL5k5tJSBxmokxhVavpnvaAqPooiKP4CtQ7
   2aE4aJia2YmmSyHCc+AKQNA894LVhIt+TQIWdCRDws9pH2W5yr5vY0xRo
   iVrqf/OzRedOS9bDrC6QtThZ1fBUsddIciztQN8oyUNDllV1zlPcDfCPk
   A==;
X-IronPort-AV: E=Sophos;i="5.97,289,1669100400"; 
   d="scan'208";a="200257151"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2023 06:43:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 11 Feb 2023 06:43:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 11 Feb 2023 06:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1jIG3siLf452ernvplUs+9tX0ueMoQ2vWOGtsyIVuFoACusABkby6038Pt+z6xLkskCQ9YUeLLz9q5OfLjXjlHVbKK7rwkQ5622Rr0DYtmCqCBwNYgpTzSJOrSkPQC5jaj0vJPKakyxFV8ZgWPod52hfGDuqzinagajTxmIkjUUP7n+PAoZGioJHtWlT7nR+LHPAsBt1GBbe/WxQbzn4g4sC2X0/MuQidlFj+Ou6QVAzQ0l6blGYLerjckE3aYbiXGIcWGWFXyGUMmWgSz7TAFsPJqfLHVaArJRYqV1qpsRIdXJIf8XSQ0fJ+QZO39kgkUoHvdc2NpgTY02VK+zUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7/PR+LGeHHHIrtb1kytlxGa5bQW4pRkpANnDlzEPi4=;
 b=UlHmA4duY1A3JRsdcFguEWys1g40QfFY8UAfLHpCXPEj13WaoeDx62UoK6MEAZFLXaTqvRxQXxOCdxAGFFk8xZSKkg01EM/b98FmBnm6DrW/ev6K358arZwrfjzd0q/EkoxxX3gT5zhSh8cc9KL9CNmW8pyLMfsq0k05fchE/t46Csofcl6aIcI9uPrahG4hWENK7PxfEd2oPoXmYlDIB0lSydmhrYQPb0yuxl2pip6maGJ5c3qRC1blBKsEP1KSvlOTw5f7nvhTyJMDWeq7YYofnw3fVexdctf42eC3+OfwUqrrUm7zWmSACfidRwI2kBDRxBRYtdTe2kNDK5cz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7/PR+LGeHHHIrtb1kytlxGa5bQW4pRkpANnDlzEPi4=;
 b=Un9669GWMj5K/AFJ2H3mqau1Axvvc9d5a0CtwmtF+S3tR5E4gmSWIAK+KZHU7GAyXnFRi1F9365fsYOerd2xWfeoswMP/8AWzFNQfaDujvigFXBUuosdMYZwm6zPdIg1deMwRo9JrRQQaxWRdR1zH+Z92leqjaaqS2jRyJdk2YU=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 13:43:39 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 13:43:38 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v4 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v4 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPED0IEC8iEmq9kS9Rw5j6ZWLp67GT+IAgALkDmCAAD23gIAAUgVQ
Date:   Sat, 11 Feb 2023 13:43:38 +0000
Message-ID: <PH7PR11MB595859EECE12B5E1F2A418149BDF9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230209044237.3927293-1-tharunkumar.pasumarthi@microchip.com>
 <Y+S05tQ5e5pE9/v0@kroah.com>
 <PH7PR11MB59588BF687D7D2EDAC36E4899BDF9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+dVeeSODu8w5ns9@kroah.com>
In-Reply-To: <Y+dVeeSODu8w5ns9@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|CY5PR11MB6257:EE_
x-ms-office365-filtering-correlation-id: 3c84d118-d100-4c77-3436-08db0c35fafd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyD0bb1n7YIhGUlZhoCodMIlJr+vxTM4fFItQEf6nsx/9jo1xj5WwASIBpEdtiZETJ4KFjcRZIhd6s+/hTe4hKyM+VuyxNr+RLYMdiKnbwPtgrQ3GAgHT5BvAmSnmm1tr+uCA18ont5QNDKdyTz8cQRcn7+LVvtZQrZCqsD2vQhNLsc2Z4FC1CQCo7hxxb/+N1Ljp3nOvbkU+GGWfrC8AEWDXVFBqKjlldfyOrbEx50Azo4yB27QM+4mrHd+mPHH+d8GUKto0fq/4Y/EmEh+GjJzw4zDqZNsdxY8zg/j9mKtnyz7WxflwTleVZgxE2vCeEa+qTmWf4WVqt7Ah2AoFBRGwSuYJ7zF2T9A51/TiwiMqTbADkBVtNPEZ9w3jgaKm65yvBg7Nv921J3VZknCP2fla9xA5peXkiU/nI17dBuGyTXMKrKbjv+OVJUrfrf4Hq73Bj3h8ZBhCTIg++iI9QDIfgNd85zqF6mQBimKVswSHn+TfeORohqsrUNeDMzp3Y99QINCxzeJsQNWpfI3L4oTttEX1oXLe0O68b/5+Op3++leUTx6MGDZeEtGpoxL6baQyeLii/gpIeFkUfDcAITQeaqlDWU/miIH6vN7URctGfzqpnxtdBQfKxXMpf9RdnIGI9zgOk4OLOFEMnOEpPxQume/fYCvvTCZ1EO5BeOsNLuoO8YOWe/bgFZAyOk719ZIQCnP7boZk/PHvuXLXw4EUVSDCkqCuXzb9OYRK5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(66476007)(66556008)(6506007)(186003)(107886003)(9686003)(86362001)(53546011)(26005)(38070700005)(66946007)(8676002)(33656002)(316002)(76116006)(38100700002)(7696005)(66446008)(54906003)(71200400001)(55016003)(64756008)(478600001)(6916009)(4326008)(2906002)(41300700001)(4744005)(122000001)(5660300002)(8936002)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vt2JYEuxntMA+nxamse/ozUfnys4Sr03yKiq63cXm/PJuYbykbm5Nhivlvh7?=
 =?us-ascii?Q?9RlnXhpXDTs2h4w6tRaEHP9ZTWi4CPXBV+GwWc4zBif+GduZCDJyBjvt73+D?=
 =?us-ascii?Q?sfSzSF28TxmBBH++8XSn4RXru6UjWWM8SrbfbdthVvavXCvMnpjCWowgjdk3?=
 =?us-ascii?Q?3ILaniQLT+ldfvqlWdzGTb3dGqzDLRwM1MK895uZxLlmjY9U/TFUrDmf7O2w?=
 =?us-ascii?Q?VdbriqpfchhOS8IOj/+M3t89vmHWPRq9PXU0CbSF59WWtkV9p0IdFdujfivZ?=
 =?us-ascii?Q?7KqMJqTfvrzIRQZCSTv8fAl4aBoWTgQEhm1b4W0MsCDa7jZpIdY0kvxNNiyf?=
 =?us-ascii?Q?rA4LXXNGY3bA0c1dAhnlqzhou7i6k6KpBa678pGSnYjR2fXhl5d7E1xKRjzY?=
 =?us-ascii?Q?LwLr8bEQZYNC0PEphgj/85R0YLgFyLsFeEzTHk0PO9KR+tHhtEWJAE1l8bS+?=
 =?us-ascii?Q?E7UEAAh9yVHv8BKN1EN3VPslo8m/13OQPggnQ5t+vFR6pgddDDH2vPC841XL?=
 =?us-ascii?Q?jaynPGtu+naTbOs7l0zj9b04dhD/rtiV3RCjnzSGscSBK75I3DlFN+bg98l8?=
 =?us-ascii?Q?9ls2aXX5Eeuc055LbCHlH3VN7acIU7uZQJAhoNrElt9MtdN/DRude61r0S6x?=
 =?us-ascii?Q?OWAJb7s+Ej++OxND6uuT+YOvU9xYm03bP6KDT1NZmHm7vFd8pD/xJ+Hh9es7?=
 =?us-ascii?Q?mh7vxR9pTrIdHK/5GsSBkw/TGUIim2DeZjc7/fBt0xOAIqJuCu111v5a6ZS8?=
 =?us-ascii?Q?72409GX46+t5ptyBgsZaNXYVFJIvjNqLQZ+WgbNY7hOhWKEvT7q5rSpLo7VA?=
 =?us-ascii?Q?NKgEISIUXaVuje1HW1L6+GewY7W6ScF/naLwgLn1Lgza5271x5cSCmYcRHui?=
 =?us-ascii?Q?/I/QyeG6+dCnh3GoL7UfSfik6ri3+aEgHXO3sBKseSSgjc2OD+ZJT4PCkKqG?=
 =?us-ascii?Q?OIK2ecWhYXsKuKJYWkelAhVy2Z7TYYA+oXh68tFlkTD/moQq3aPgubdbi7el?=
 =?us-ascii?Q?uGu/XKSfToFYlQaGWJ/3iaebpZuDSG6pyEBPWkNmTFm/iCmIW7Hgi/xNzIZQ?=
 =?us-ascii?Q?7r1LRewiAecwvhamUO5i7Wi1Rj5MrvYHCUQ+htVh7hu8KS9mgMYABQF1VNAD?=
 =?us-ascii?Q?p3i3MN+3X7snIKZfBWd0Qgs5M3Gv3UR9uAHG8sQ581vu23wyvRglmG30dB48?=
 =?us-ascii?Q?ZHvFBj44J4jjv9c16HqLG04ufWS7Vyp+8W7SQhYu7WWNzDukhXoYIXlQu+dv?=
 =?us-ascii?Q?jUJ/c/F+zmpNmtKrSEkmdGsItEFqeQIIrk2MXZ6rvMZKSLFl2jOj1Cxnl7RS?=
 =?us-ascii?Q?Kbc3ggU158PHrXeoA7nvAOjA6M15vKMXPJBesl8RNVBeeRzqfidqkgUiVS3G?=
 =?us-ascii?Q?qotEdDVKYUfdSDVQiUCMJJUq1y5MdnO1XSgVijntxh2MkND4zJ2+vsEUp9es?=
 =?us-ascii?Q?xNq3UL8CAPzyxAKLapO2j+yo1RC7jjRLeT8rYQtfApZLe5HufRjtPA9RusSG?=
 =?us-ascii?Q?32pOJlVB3R1khXN3CPK/1m50KHgoTDd/Kv53CBAn4oj8/tJwOgPj2DWLD+qu?=
 =?us-ascii?Q?wj8U2rlxvk8Z8+WMT9waPV/2wE5Tkuk/Gx/us7Xc3WDIbh6q6Hevatn354xD?=
 =?us-ascii?Q?XxuNFrp+bV5w5R1Tpk6QbL0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c84d118-d100-4c77-3436-08db0c35fafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 13:43:38.6599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9/XScGdb7qLW63qtOm2W/MfFtoNRWzuWfkBOilkEpqapGB+YXH4DDm9B8+6eoQeJPyHcPH7tUYlHaCRBZofutYkMNPRvDOzwoEpsdr++DJjn9mpgVjE13ZQJVj7fmAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, February 11, 2023 2:15 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Ok, if the bit being set will notify userspace of the issue, then why als=
o spam
> the kernel error log?

Yes Greg, It's not required. I will remove these prints in upcoming patch.

Thanks,
Tharun Kumar P
