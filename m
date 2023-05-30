Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C6715E34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjE3L6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjE3L6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:58:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A6311C;
        Tue, 30 May 2023 04:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8E2DJBGr1GZRIOsB3M8sDtOOzP/fOoAPeHlgmJ/jp2ZBVlMsSJxP07dY+NlbqeYAz3iAOzA7T+6ArF5tfphmBllCnD4jTxkau8f9qxECRyHZjIw8dLd/4JnxRBBC4vxNrqfR9suyavxdSQIBNUUaUMbS2lpJUC5Wa6RL13mV41Nwrvrj++fpHimoAV68+AVpraenJsdvauvzS+aouI1VNBjHvoPxZAFja740DdTB9uCsOHsq3YznodbDPtSPiITuD0Zw51tLm5wrSAnmTzyKEVc36pA+1yiXHI5ciCjbWdMvIf9wPV0xuScXfkjkDe14SXRtDmxf9e2OBpZn5bDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNwqOgx+vFt+AofvAB5244/2YNgTW3MUaUJ+Cfazm04=;
 b=mUKDPqgOMGKTi+1OzFsQUsAM1s0X4LV4RGUtwh091nWwYWweZ9P4nzBYsFXEy8Az4fBkRSUH3inIOB6puBtIarISAw5eEGFSOTpQ/gUIKjoxxEGONCBMubVptVJy3ZKH2p61a3EvqWqBjbOabSju6aZsfmzs+YVE9hQwVY6EMb86yQvo6by13NYNspdiAS39/yGdn0KhRI7/Lu8Kp0lIautGUshz265wIONS0MY/rS9cXhzGVspOBU9czRvbgqXoeuq/RgMPXdJm3BpR56RmRtAmiAFqt63iRt7i5Fu4t9pPY53S8wb/qTxSpin+rhTtJ4tZmhM4Tkns7Eb3p9XHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNwqOgx+vFt+AofvAB5244/2YNgTW3MUaUJ+Cfazm04=;
 b=hymQUaDoE96sB9w5ItlR/koNYJ6gtHup9BWzX6qArkn3K0tqvMwOuuDj3uYqjdnd4yIpzj4ugKOYOs5oXMhjThAlBqP/rmi6xXSmhFXDVSB+V1oEsTpk8ruhh8ytd2Z1QjZUEnNtRorLv5hym8VfY+yByUV/2uT3TyNwTZbZ4WY=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:56:19 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:56:19 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 5.15 00/69] 5.15.114-rc1 review
Thread-Topic: [PATCH 5.15 00/69] 5.15.114-rc1 review
Thread-Index: AQHZkZ1NOXM/oLvbpkizB9HFrytbB69ytLxg
Date:   Tue, 30 May 2023 11:56:19 +0000
Message-ID: <TY2PR01MB37889F6EF314617888EFC3A8B74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230528190828.358612414@linuxfoundation.org>
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: 5276a970-78c5-42ab-f086-08db6104e1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XBlo9UgPkF6RPl+0cQC8f9XtbrfIcnfl9zxe6W8v8rZ3gD6HgAqPutB3QjASC2NH4BLeroVBv41BtQzlksnAOdAZvIZZa80XKr8iAldKXnZEfrYqc4fcoyl9eQHpFxmcRjhkkeoK+ufissPOUh+hNqTKaKRhEChvTgxy3ZtRf3HEfdTyHwPKWeaFQ78tCuMB7vld9MDw6Dc0epoAoOdCUdUqp7PWXRWIUQIC1iLdh+sKgIdaXtKCwHbqxjLelOeGw6jKBqtMAdgMUgH5AXOS0QsS7Ho6T9ugBMB3+6XWd4gDJX0hL2vA9yXvxOX+tVqjdFBlyB8YpZY/E56SJZXSjqCXlzwNSCIcdUHnZnKzTERP5ACcxxpJDxHOLmMgKAwuQvJmtq3To0S2DR/gykjrz071QVnHy4p2fUeBI7Onv+HOSl84GTSWU2vUbB0BZpXpkWa1DN/QT9k5DUqMCouW8PLN/djYYDCyQUv38JeZhQmB0vfvChWaz2Ho0GzTbYFa9DRpFnHqrget1crUn/XAcOY23HWXuPrqlOmPUgGiF6kDktPRC8HYx8oebUqkgFQG4ORxq0CBAAfhA8yBm1hfNqVTKVAvt+CoOCU1RBV61t8Oap6gxhrpw9PvoyCN7WkiZ4rzTVJWf7DZG2cHLLS8fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?fcAF/qWIv7dMuUFtk2UoEKMi6q5njg0M3eDb3aweU58ojOMEbG9X642Z?=
 =?Windows-1252?Q?jxpzVxpEXi8smlhRTz7aA2vGcucusRm1OdsnfVUg+iGlPPaptiAX+IFe?=
 =?Windows-1252?Q?ldNHM6Natdq9Kb5oxnFb7g4+zRnLAZpOkJSKQN05MUZMN+mom2tsvGmI?=
 =?Windows-1252?Q?Gg+Fyqa+00X8crI3CUpZXS55tr9joe2CWqm8aNcbidUMVcGrzleOD4su?=
 =?Windows-1252?Q?DU1++RaopfFrgXpEbunU2sCHTHgU5DEWJI1oA33tWisCEAVn0uwNzrnh?=
 =?Windows-1252?Q?sLS6BahZsSX8ZsNIyTH+qymztArOKFYsN2MxNi+3aAdONUvwwBk4S0xa?=
 =?Windows-1252?Q?bplO2Fk9Vk3vcvmLvs2YprKG+LS5oSwyteRChydB4EtaEUJuPt9A0T9I?=
 =?Windows-1252?Q?JS7rDWJlELJaiyZ4u8uqvp13iu4R2cPuk7UY5WuyCaru5yvAvAjWQpyJ?=
 =?Windows-1252?Q?u26X6QiUBg7fH5OUd8WAgXV7XL28terryD0MOXlPmHbYw1Hzn7SSwhvH?=
 =?Windows-1252?Q?K/Rd1FIGoqvkN0dOfCGtKKj7R58zMMefuAwYu/Fw4xwC7HIpuDd/n9Ty?=
 =?Windows-1252?Q?VYvmVJBe4yHtQBnIjr+orZu1Z0pBuVWzjavxylzZX8EHj6HRbXL5wfVC?=
 =?Windows-1252?Q?qNMRFe0EK12InY7t4dVtPIq3VBocWlXJIFlLXmhV6pEyDB3AGimnRgBb?=
 =?Windows-1252?Q?pE7YF9+lU8ltdH3mnjvm3ojgb1NnxzX4fxK1Aq/pjDI6v9+/V1AJm5yN?=
 =?Windows-1252?Q?0IkrJtD46GtSgxm7ad8TpMj4vyyB0qOpNOc1hqE+m/rXmg6Ie7ZZM43H?=
 =?Windows-1252?Q?NaVnyTqmTZZGQe/e3stjbbzLwQcF/NWCQqeSeB4CFaULzHOG5es6s5N5?=
 =?Windows-1252?Q?BFv+GjF1LcOgKXKPw26eE9oSPhyR+gyzVt1mc5VjynUxZg7iBBcf3wNg?=
 =?Windows-1252?Q?eYd9VYiNkdDNXVLIWFkuW174HuHL+bIogh2zdYn2VIle9DOg+lexWt2r?=
 =?Windows-1252?Q?lSefyf2FAn2B2MWyRDvCTZKs8u78s0oMydIeAAWrpKT+5hmjhmkkd7C/?=
 =?Windows-1252?Q?V41heiELE6z0LxBt1ieDmOxGDVUs7+1SNtQroo2T4vHaehank8iE9hTm?=
 =?Windows-1252?Q?W0flgtzlFMF57dtDjruCQRm71lqad09zaQA/DVpICbo6dg+dYoKDCbCp?=
 =?Windows-1252?Q?xAOINnM+zq1D+Ua94U4sgOl09H2LjTcQQ20jM5TKaRBEAzNOY+LQ07Is?=
 =?Windows-1252?Q?xMvRfEAUDEDllsAiJEPa3iB02MLEwkRQJyaT2Pyfbr5TdIQXeBnrJ8XM?=
 =?Windows-1252?Q?XvBtBHxddIEgbYYE5a2nQOrrZIyv/7hWjj+m8iBcbpi0yf4Vk7uz938J?=
 =?Windows-1252?Q?SMuXPIk0ONErJFOUqmPzVrZcvaFsYdZihtnCYNkJXDGzwY5rRzwY7x2H?=
 =?Windows-1252?Q?uMERRSFm37Zr9TPHiXdcWvyTDWmG2OJfQp7sw+j7SP/bnNLcS7IYPDRK?=
 =?Windows-1252?Q?qmlUvVX9rZQFBSD2kIWxiRSnY5CWJ+hghvYXN/5dSNF7WLDyvyNkOXEq?=
 =?Windows-1252?Q?JW6nCcQfQzD77LLsCu+W2XXOGj2zinloZCIl+N8DcoAVNGW/0nlCmIPA?=
 =?Windows-1252?Q?IWBwmo0HT6TwGEgbizhqut1Wy5YTnsK3qM7OGi2KVsrW9Iv44KtxXlHY?=
 =?Windows-1252?Q?yluqo1sLG6E8goWQC+EG7jjKKe9jT+FoJCzpav3yKixBT1qXKzsJ/Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5276a970-78c5-42ab-f086-08db6104e1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:56:19.7177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iT+SBYV18kVWh4i7Azclp6i3PJTLnYSDQSPiZH2cECtqaFzJJ6tToL7e5ngUf7zKleJCRVN14DabOUFW8CnMckLRlWU+QuGzt17Ec/J6uRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Sunday, May 28, 2023 8:11 PM
>=20
> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.15.114-rc1 (cd3aaa9c7395):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
81425029
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
