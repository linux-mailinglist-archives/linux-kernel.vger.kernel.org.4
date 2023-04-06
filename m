Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE76D8EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjDFF5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDFF5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:57:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5756A7A;
        Wed,  5 Apr 2023 22:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfUBph02VXuVPblt62Bqmb5nrAqxURXVMh9HE4ozr7VjXxmMfJOctYJ+/6+QdrpHUXc8naGVZ4YJtSMJb9JmkpndzRASTCE/GfJcrOggk30ltAt+Q6iby/u8CNQEOJM2zA00LBcl06oSZodR0nJSd5Uj5R3LIy3DklmgIhby3Z+BvT4v4GoIDaevIR88vexfheV6vjstqffJ+Np7qw6rCpLLFz8Qqz6SPAP0ibcXvr7enr/NeYIFZ6IhnwDJK5/NGzDkNVyRorBqdRy4wf9PDBXfMdF5V0SgPhf9Asii7WFIEf5wi+y9w7gGOaFn3j/TsdPZyqbkI6J9rY9ad5cpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfYog9SxKaA/2jVfl4AGdqCLx3x4uYJgQFQoKdozP4o=;
 b=kKBIpW9Bj/Ec6GXBdIkcp+XnxBOPHrFNFgJbpbr1NX1GsS2eQvlRS9bXxbfTvo+VWLSvGpK2m4cpc8dW9X2Xtsa5l7OgPxQ96UpmqbQrwZzmTvZVPm5sxUrMUVmgv1sfhmgIxw5lc5Prz51MpzBLHMdbQpaJAtKdOkExKVoiLczDKsjNoHlFPVuN7ASe4ZdCM+CIfH13iBgjefC0e5y4tWgrjCsbz2e6pIZBmle77Xhhdfkz3NYHiFYWVpYnflLlYXQtvrS8msHJyrXgvoEXMPTqwX99xUSYH3czL6HhS2UfJbeldOLVyCLTUGx2P5Fnpvw7dN4JUOpqPeEHfQMgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfYog9SxKaA/2jVfl4AGdqCLx3x4uYJgQFQoKdozP4o=;
 b=DgCYU5D3Od4Vk0uYjln43eVxr6pYEArDskBRgc6ArVDf+AOAmdrYhE2vO20iddvp7Bu+X/Hjd+vStu8LVrHEMg1lSsP5gqXQtU928kPO8AzBCEiTa0UwIDsI5NkBxVRErCB9flNZFUT5n1XAPAi4qbfarJKEwyf3ADD61cFTfQqUS55g58PKYj0yf3MGl/Zylrmr/qsKzCTDcCaqxu2Gw7bsPROnBKHDx7QVHtZ/wBcF+01aiUdjO0idZA3sga1hydY9LkhIzx5Q+VbIQ4GykvaTpgiMIj8vt4U3t+/cHBsIih5/ZycrZxomXhioWp9dcpxVwBI/dFv+0QipTkb4tg==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by DB9PR10MB7338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:462::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 05:57:05 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 05:57:05 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/9] tty: n_gsm: increase gsm_mux unsupported counted
 where appropriate
Thread-Topic: [PATCH 7/9] tty: n_gsm: increase gsm_mux unsupported counted
 where appropriate
Thread-Index: AQHZZ50YrBvKHFhKGkmk90GV2Hw/XK8dyf/Q
Date:   Thu, 6 Apr 2023 05:57:05 +0000
Message-ID: <AS4PR10MB58955AB89CC251446B7509CBE0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-7-daniel.starke@siemens.com>
 <fe8c6288-1df-bdb0-34d-68e6cb983a7a@linux.intel.com>
In-Reply-To: <fe8c6288-1df-bdb0-34d-68e6cb983a7a@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T05:57:03Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bb144f43-765b-480b-b4ec-af8d8a2008f3;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|DB9PR10MB7338:EE_
x-ms-office365-filtering-correlation-id: c7a10b4f-e0ea-4b69-bfae-08db3663bfed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qrA7fgPo9UN3XYlQyzri5kAaaGqC39oi1un+u67Dm62RL0e9XTVYt8aoIyjXpZ7PFcReAMujsgZzQYGBaDBX8v7Unb+dkYBMsAkEJYwXeCsWApoagUpSlDmJHqEziRUzG35M/ILdzBf4c/JCvUAiLxo2qQOG5R/B9iGuNQEIv+pVVXJ/BJSBrJHziRveCVDYLma7coqUMFGGkLoud4J1USEvxZ3jKVfJ6N6tPfpyrAg6y9ey1hdroa/pwggKZ+T5swqjc8PDUgh0CqjLKTO6hj/GugDGe8gkNcXbyI1MtaNy2xXp86UPVkY+FLvJ0XgjD14l03f0d3LMWZkY38mM4+BgceBLdeia37PMvlmbG5b1WS1WJaVqnU81Er533dFg9PXSruRWYyQgewez4SmAaFUcotPXi0bpZ1Bpj2SuXg96rbyWLPoZNkUbzzZb4p8xjNE9o7jXvoSrtwMT/i6LivVCm0iIe65ioooGnOrz8nuH34L5OX87psnaNx+T+XrS0c7IjoVwLRhWVJTIrO+71YQWkk1udlDk3anPBjybFwQxMOVqX4GNlngVKu2WLr+cSeS9roaR2/NwggSDIwQ3G1uyjsPhcsertcELT+qyQ1sqliyKDNk1mlkuW/WyNCL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(2906002)(9686003)(83380400001)(186003)(478600001)(71200400001)(316002)(7696005)(54906003)(26005)(6506007)(5660300002)(33656002)(38100700002)(4326008)(55016003)(41300700001)(6916009)(66446008)(64756008)(66476007)(76116006)(122000001)(66556008)(8936002)(86362001)(82960400001)(8676002)(66946007)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BLRIAkXoVI1dVUvrHaowWnLvIjwirbrFM88Mzew30X34+AVmr2fh2ijuWQ?=
 =?iso-8859-1?Q?/yMoG0kSDJbYnToyBLejgoyGdUWzHk24O21080NkyQQspYaAG2puzjtike?=
 =?iso-8859-1?Q?zRfNcXmCiwHVvjhs/K1P75BJSqCjJNde0tJijZQSazUe9k0OvV/Ml+vkdu?=
 =?iso-8859-1?Q?2D+/q1k0ncinBzH0UESFicvQRhBgjpV5FvP351pvBhNzL7HBg5rr6sWpNl?=
 =?iso-8859-1?Q?GelJ86jft9UgeaWkaF1eSK8fPM0Cmv2eA6eJY+3J6vL6UUrJCHcCpeE3Kc?=
 =?iso-8859-1?Q?x3XBfGlgJWsVghhHof3Nl9126uxQhkg09uzHRDW5t5baC+k7eVx6+ru7FL?=
 =?iso-8859-1?Q?GXMULzVW1mGAevG+susPNDRzeNNHdktqHNMSgkNBXLDHsC7FPZufrnosAQ?=
 =?iso-8859-1?Q?Y478I2bRMdFAd28tlar8gtUV3M5CQsQNeCul7oX7hOZTHxCmBqiiZW2hJP?=
 =?iso-8859-1?Q?bCsqyRV1Ds8UZGbjhVjbJ/y9P2z84DQmqrask59us5idjCVohCN0LvJjLn?=
 =?iso-8859-1?Q?AZb6cylavw6NtR8bE4RiYRz6GE7K0tKGz7j4Y+PZIrtGh/oue873WVCVe5?=
 =?iso-8859-1?Q?ZWzErIkE6G9xXJFMwXiALGXyCeZ428HoO6nF00WBBX2DA2eYj/5ZZyJR3t?=
 =?iso-8859-1?Q?SLr73lxEtpAOchrWKgEnIkcL90ZQizbdtiOga05WhlUAFVk9UIOUeM2aqM?=
 =?iso-8859-1?Q?fwpsfWvtu3wcf58FE81I8haU0KIYPyDM5w+0SA5kV9Z8AewJtY9FTbJjI+?=
 =?iso-8859-1?Q?GQp8YLRzkuEtfA4ZEiSlCIoKKge0ODG4Sl32SAyPw6sjxL2Lt1do0Qzf2X?=
 =?iso-8859-1?Q?Cb0HfsVFxC1YEd2hxlymoTw/9NQyBxYRE2qlOgZZzTlHaoObUJQwoxTCp6?=
 =?iso-8859-1?Q?0ejv2khsjCO7XzmClKbE0OEJie9W5lYo3kyE8fw+DKgFPvVnQe4QgHL1q/?=
 =?iso-8859-1?Q?qjfrWAkedEWueuIieyf34dpMWs6y9bA8n/c5tKjxXh6dWunk4/x5soaBH+?=
 =?iso-8859-1?Q?SZ1UHeAt6mrlfJZ+DZeOvt/RRusdL4DvFJtZzbN/F9HlfmRWA37PwHCmEl?=
 =?iso-8859-1?Q?VI+b/i+kEc6DXFfymhhG9pNuMtomHZ3GODjIjf4FFEQvKbpGuD3DYMKW1E?=
 =?iso-8859-1?Q?DKwVd+fnhN56bKrBHdhmX4Be2xmttP9FJXnIQkIOB/wsPE0F8WLRu4Ju87?=
 =?iso-8859-1?Q?0Kb+QumbB/eaXQrKmAR5s9gyaC/FXaccpRp/Bme4381eOXyonHHqUv+25U?=
 =?iso-8859-1?Q?VkKENe2O9KSic5a37GVDXNJVP3j0f24enfBrEVLz+7HvK4E4LJdmwXpDja?=
 =?iso-8859-1?Q?djjr2JalEo+qi8eeh4Ztsxvnqh6PgFs/DXkK4+rPyBpCyjBTfsuA8sarRz?=
 =?iso-8859-1?Q?3C+VoNJTKXkpjreeJ+crbs4acXQM48/BNeZCztSWjQ/kEr9o9jaz4PRzmn?=
 =?iso-8859-1?Q?uikKX2xJEL6acgGfuGdIeQq3erGcX9BCZtcrLWbFAZZTMixhA6ooAKNiHJ?=
 =?iso-8859-1?Q?tUTcVvLQIgO2kUoj7xJETvLPP9uis10e9NX2LMadRd1RIwVkYsiaKhuzHn?=
 =?iso-8859-1?Q?DvUhACGUwvGXL+Jq0nKLX/2FnrfMyVQTZ1KedAyVFLewBVO0Q1k1scCroK?=
 =?iso-8859-1?Q?pKf5u1s+Ez23aPt8+LDTsH2o7UadrN/twt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a10b4f-e0ea-4b69-bfae-08db3663bfed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:57:05.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK7CBAIF7x4sX2lUiYaw04CmJH7dG1pnXuJFXRYtNcUpQAMBni6wqx7NTDBcZF6cSF7mdWO17TJx43RynqGlvA3f0Qm726WYrQjU4oUFVxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7338
X-Spam-Status: No, score=2.1 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Daniel Starke <daniel.starke@siemens.com>
> >=20
> > The structure gsm_mux contains the 'unsupported' field. However, there =
is
> > currently no place in the code which increases this counter.
> >=20
> > Increase the 'unsupported' statistics counter in the following case:
> > - an unsupported frame type has been requested by the peer via paramete=
r
> >   negotiation
> > - a control frame with an unsupported but known command has been receiv=
ed
>=20
> So inconsistent/unsupported adaptation doesn't fall under the second=20
> bullet?
>=20
> (Please excuse my ignorance, I'm trying to review your patches with=20
> somewhat limited knowledge about how things work).

A wrong adaption is nothing we can detect with sufficient accuracy as this
changes the structure of the UI/UIH frames. E.g. a one byte header is added
in case of convergence layer type 2 instead of 1 and contains the modem
signal octet with the state of the signal lines. There is no checksum or
other value which indicates of this field is correct or should be present.
Therefore, we can only assume protocol correctness here.
See also function 'gsm_dlci_data' where this is handled.

Best regards,
Daniel Starke
