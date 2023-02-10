Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3A6922BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBJP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjBJP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:56:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331D4B749;
        Fri, 10 Feb 2023 07:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZujCjSjaHHVimVLIi1RIAJPhwRTWfhspGnl+0yU2ptgM+5vZn2EW+9oFOEtfsXrm1fNWadYeNBbsVqVM9NZnlG5Yt0tA8pN2kXmCj5pID2grN0ljTt9HTxoRGEActn8KAKK9P2d19dX4EAZm7lrxQWKpMvtW/eyvK5twnTeomdgjl8+cECGRjN8WQL1bdGooqFykwgxrYKH5VjVdNP8s6PxkTCf1eHdNcBijIw7VGli1BljuHotWG/2IMyMJxxWlen6POQdYDc/SnV0gx5e01mFZqipM7AkHqZ5d06fADXliovKO0w5szYRO6Z2zXZV78xncpU0ghCg28BWUUDhPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36yowuTDtO6SFWqx9rUyhdT5Js7eTSjgLjtfbXoX3oE=;
 b=Lg8xHqrf6XO65D9aawpLvRt5KIwKJpkLmEJB+DzlRBN59kfQo67qGEK0h5Ng8lsdmHPucOAM11p8/3tel14jl4wxULGlyk3gh7jk9IKY3Jtf0ekxbwtXX5sekmiWUlGgz+W1H8RVB6WRb6t5aS0y67STxQ0UKCl+Vwgui5g9J6Olka2FlZMFpHRLwzp+xTzVVPK/j3nnRxOTO+ApCvCFvMf0O2SSzE/xvUFixIs99L6l9F4TEEnEdV/Fmg0xnLqULZifWkqFFAC4xugiTpYnj0dqcNmeJooPX5H8HpgQZ9wPQjzX/+41Pd3IHFLSCV4p08pp06dyBD+T8LPvx8Vy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36yowuTDtO6SFWqx9rUyhdT5Js7eTSjgLjtfbXoX3oE=;
 b=hVH0L8OdhNnSi4wGmVjom+Ew+WzwT2shSinY85EXv3l8vKhKjvT4oBkcXiHVugSwoRqhIHlJJldN6P5nFnxTK9Itgo9XhqTD7CFQZ/pFVF/eOLjo6y/4JfBbplC+bshP2Jjl2ZGJVDldN3mEFmevwoQcokgxNCs2siK9mup6pjhUxaVPzH67TGXyhtZPl3sQosDXGIgA+uouRyZ38aYvOw+37mfnkQuTJ6Ef6A2R+e4Hmu82WO6fr+weq4RD6Vx689cRszFexxCnERwqxmS9vUiERe8EsFYvqCKxmBYBXUq+jYNOY23Ic/zE/N+tEp85WH3JUE8W/BYwsQn1V7wuOQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 15:56:02 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 15:56:02 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Thread-Topic: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Thread-Index: AQHZO+8y9re52UCT3U2Ebedf+tA4N67HM7AAgAACSaCAAMNLgIAABLSAgABaONA=
Date:   Fri, 10 Feb 2023 15:56:02 +0000
Message-ID: <CH2PR12MB3895CF2E89AE90B256BECF0BD7DE9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230208185714.27313-1-asmaa@nvidia.com>
 <CAHp75Vf7FcAvSwLPWj4OfnJ61iXy7TAFFzTAq_8b9VXeyCfBFg@mail.gmail.com>
 <CH2PR12MB3895C873B4381A88636A0EABD7D99@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfVJ8B1d+gSi6WJw9guJBUkaJwH1yU7N7FpJ-DtL_L6Rg@mail.gmail.com>
 <Y+YdJdkToTAcvCDt@smile.fi.intel.com>
In-Reply-To: <Y+YdJdkToTAcvCDt@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BY5PR12MB4033:EE_
x-ms-office365-filtering-correlation-id: f0d846d1-04d2-41b2-db8b-08db0b7f4f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVSzFA+X1T7dpf2WrI7+1EEX89fJOr2bNzkAUJM1W5oXNBj9t8NAWMIIwCP+t8Q9F0DRCpiTzfTrdCvVSm/ZOliZg/9jiX2fRz6Z20wt8/qqKtkPe2Hug6WTmiVkc5B1QhYfuL1HbNK7A6CVFYaPSGTU2NwCWtsZKXJVFCUZn2iaZq0aILqVIOvdGwTDsYdLQHwESvno1qmRL5myRJ/ab2t4LXJXdD8Yq/TEJ8Snz4BlhGJ5owZPtTkvYITKak+jz/d8V7zFK0K0qzMGNzlfSCbNWI8YawqQbQdvDFw+/FOYkrRQ3UGmhmNTsfz8ygKsdYpMWCs+Ew9neK8bN9IICPgFQgq6YEf8IMxxQEOxXQdWKsqwbGCli2338og2gVj5L1sAx48WVZV46YwZp1IQRbet+ag9uUnOOTckyY8ukr10qzKd5mlaVUSYShaReaRS5sjpgmJdckfWpmukipqZrK4lGJKH7CdEXTiLcjn3QEubhiB6+4qLMr98ewyWf4LIF15KAoaDIgw7Iofh1ias4ENMXSc1t9/iLPVYc/6HT6GaO/fm2AWOexZPfxiEpTyt+QYUCGti8sTCuJgs1lHLYBy9YnxlmZ9yTPaVlWktiaay0xyhYjjmB1QXHtsea69RJGjhvMN/aMFNv8dW9hllrwWJSK+uRYSmv6At4/Ry/uQZqzmpc/jSDcDlPka00PpvXNzxCfawzCBG3qwodZ6HsnHEOd8d/R+h3k3Ox8xq4YiaDOkXVjL5CguHnGptgsQG5tj1Rk7nk36BinF/4D2Hmw7Bxr4vN5YznsgDlbtfov+LwaZgomqupxTOxubSuxlV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199018)(2906002)(41300700001)(66946007)(76116006)(66446008)(66556008)(4326008)(66476007)(64756008)(6916009)(52536014)(8676002)(38070700005)(6506007)(38100700002)(478600001)(9686003)(186003)(122000001)(26005)(558084003)(33656002)(55016003)(54906003)(71200400001)(86362001)(966005)(7696005)(316002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bod2c8zmoYt/8vMx7r8mOXLNDjayMA2GzdzU+NmmVqkWB8zE/g3GVeQhdg7c?=
 =?us-ascii?Q?1mK8UU/rBlv2q4qRVO+da0OGBSUDsyBwkw8g0+XOpHghIjyBOfGGCW4TXb47?=
 =?us-ascii?Q?/HEIFH2t8+KLftZqPr9TYPVkRQ3kH2wJM7qcxVOrUX8EDafJhP6kESbNMcB+?=
 =?us-ascii?Q?eI3hsTVao8UnKebiyYGeuNTVW+KCBIaJW4BloNWU43MauDIYyLMLZ33ESabj?=
 =?us-ascii?Q?Wy+uGc/P7HR0Oh/9DXhCh9Pt3nxkXYkZ7UChm5zan+7AbWoVTzNTAAl4q+ta?=
 =?us-ascii?Q?43WjIBQXHgXh6UG8Ni1zfIIdcMa/yW3oyEHfD2SY1BsM+GseLQnkdkrtHsoO?=
 =?us-ascii?Q?xnCXWJylCiP51ZMhZVUWZXYb3NmSYJnSELaHAH9xXt0dFuWtcy0/oAFdtcOZ?=
 =?us-ascii?Q?Cegb3CpSn24tLN02YW6U93DsdQczyqtdeDusLsqDVLKfw6hS3yLu/Nsu+HkJ?=
 =?us-ascii?Q?LatNU0dV2HvBwub7mTqvRjYXbCyGalMS9I2lCzZ1wyXOOpnJCPPEn7/GRrI7?=
 =?us-ascii?Q?cOfqBXS6oPTYGkQRmr/okPZe2FZ20Qg6vn/30poHpAZJPrwvWWYsJKJ/7PwL?=
 =?us-ascii?Q?mH2phz2jab72HoIoIKV0Ji4+C2LTp4cqY1rtpDsXoss+hpGKFLOe31s38Yco?=
 =?us-ascii?Q?xhBmE+pR6NLEXa6BHBmYglLEEf7TsNmgailFw8wJkxV/07yhKzziGsCjTZvt?=
 =?us-ascii?Q?/mTswzcG6sgOc1eqckMtsS/1MJcEK1IkFXk578lyI0MhaP9yJWQX9ihbxoYL?=
 =?us-ascii?Q?+D9S+8diiBvhSLPO8oyK6qhOOAqi9gBPMf9piPimCSOfDQ+6rdD0/v/ozuw2?=
 =?us-ascii?Q?JIEtG3wHsbVYQ/lNIOcBVW937MIppoByr3/9B1ZqxgzpSVg7zEC2Rxs2297J?=
 =?us-ascii?Q?J7p31mSnvLs6fRB8J04nQFz5TRU2eP3jTl0xXryEWFyige1BgwsXeku9EV57?=
 =?us-ascii?Q?emB04LjGwLckF1/c7LmgUgRD1vuiT8UB92oFS5I8kSoV2myIwXKUL9fKnc5A?=
 =?us-ascii?Q?lJQOqMqh6OnDHVldS6vqwo56nabJ957KFI4RtyYEmizoSodhbdyA8yo4eFR+?=
 =?us-ascii?Q?LX/RaHoieEwIrpG/HrNDYedI3rst9khPSZJESkW6N8WAZLSGTUWTj/Ev9x7N?=
 =?us-ascii?Q?ZgESJKiVr1cx0BjHxwFWZmZ6OwtSvdqbPfOOMBXVjcrC/MpgLSjzSlDpiiQh?=
 =?us-ascii?Q?FN5YG5s3ZQtP8J/AS6pdXOtLs31UUbeL2AxTpiBiJoJ5WLoeBiaMLv5vDB4T?=
 =?us-ascii?Q?VaZsx7eQkx7VXY2W3PHBV7Yh71W1MG9i1HVMKjIXiJHh922yM62TuW6JRrWZ?=
 =?us-ascii?Q?mmVs8tqAyhaoj5UBCKLG6VNBR1eOSRIFKlyZsxB49ZfiuYK2V+PrEJ554SC8?=
 =?us-ascii?Q?at76TX+HNolZJmNFLdHbBNYCzivOyRLuGeZ6EXIKVJp7+MVAem67pOTnF6h3?=
 =?us-ascii?Q?dgNnPWl2dAzpYI3PlzSD/Mn6JGxx+xzhZ4uEaCZBIbIsyv9k8C++BEJZrYsh?=
 =?us-ascii?Q?ZRehxMhBk5H//I5zw4hw7lwn1jpnKQJpUyFYF5dZzOtZh6upy/afUytF/QFS?=
 =?us-ascii?Q?HN8dIk+/F1GlvUW1k6g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d846d1-04d2-41b2-db8b-08db0b7f4f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 15:56:02.6077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/C0AO0on3D96sQ/VJXeZaElMKEFkA6eij7WqjLLs5s1ChrDpb3HZk9uUVFmQRrftLRjiO8wmn8NBUUvHIGbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


To illustrate what I'm talking about:

https://lore.kernel.org/linux-gpio/CACRpkdZ_sPCa+Q6MWUKj1ytCe5AxTp--bMmbRTU=
fsNO0kZTMpQ@mail.gmail.com/T/#t

Thanks for your help! Here is the v3 patch:=20
https://lore.kernel.org/lkml/cover.1676042188.git.asmaa@nvidia.com/

Best,
Asmaa

