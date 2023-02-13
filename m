Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F769548E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBMXOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMXOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:14:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4681F4B2;
        Mon, 13 Feb 2023 15:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbfQMeS0W93Mx8pGKZhWppwO61KpyIsYIrhsl0V37YxktANKJVvqX0ZHMGL3rJZJ6mfUwHbR2dy0+AurGvVPyEQzTCErCIkHpVihr4R+ES/RTEKr7ZFXgAgzVwIH/jHP3fNfZvNe9Psv/RGlJ1gOExUoEv9AfNofKhVBpahms0yiCaADqwnjl0jL/Qkk2yc33+QbBG7xeJ5HOyOzUjx2d3LeecdvAyWw6SX0tOhsCN1Qa+cKeKNoZRRuLjdztbYl868bt22a37j9gDjI7uRhqffJtPhNx/JL9swlgWNuiRmbtjX+hpFbn8goO0qTFOcP0IVNmuGT0VCKJwJFYCvDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkW9Xr1iv4eOKdv6LFXCFdzJmgfrib4ABI6KokM6YLw=;
 b=Aw2zF9OR46BXAiaC7pfLvPGIvrxFXnew1yIkXi78wfgybJxqLhNz2CdasEerOT2eDeGZvDDPJ2jcoKK1ixzXwjMs3HK1rlcAGhuDB9T4l7CiMByrJYfJLUvVoz+SxI3biWjK5C5EO/Rb4+QLWVq1YWMFHGKQW3JoCyPrgrjkAH1PcVXTB4LQ0pAxq3THdtlSN9ovThD36G3bBFsle1+fO8lyjoL6tYhpJmmWko3eMmwod249oFlp60vMeepA4JJcJPqstExdw8eFajMgWNWhDlpJSu4Jm1OuFzFPyXHog9YB9M6eYN8rkhLXf8aD5PetOrRMvxc2LG8iuN9c6hRwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkW9Xr1iv4eOKdv6LFXCFdzJmgfrib4ABI6KokM6YLw=;
 b=iA4r9z+g15X7zJS/+VrRAgXAONVOkVHQsbwJa1OPNosV62Kli0QKP+uahDkDcp5Bnv3Yx27JDGbm9Mb34It2KlgvRuBRDtXMRPkHmID6j7bcmrsvt0Tlf0leNKEwjZvOfsSiUX3pU+F8b1StFkl/E0feRPeBJwwlyF9wyR7YP4kxF0b2Og7wf4bzY+dMmw9crZbwBvWoxZK0lXxNLnKkhsRY480fqmbavQPAhiedvaLjxr0C8lHGF3wRp8OGSH8qg7twv7OwvT2arVMLDWgA0wQ812XfwhauIykpslbBKkd+Sax/3kr21Glk7VNF13vGNqLDf3jWNv3zc9YsJfIToA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 23:14:06 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 23:14:06 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Thread-Topic: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Thread-Index: AQHZPWNgnp9EGxTKw0yj8uaPzkWZSa7Jo5cAgAN3lhA=
Date:   Mon, 13 Feb 2023 23:14:06 +0000
Message-ID: <CH2PR12MB389571F58AE1F8BF2196DC10D7DD9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
 <Y+eBRLB0Q38vGtjR@smile.fi.intel.com>
In-Reply-To: <Y+eBRLB0Q38vGtjR@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BN9PR12MB5081:EE_
x-ms-office365-filtering-correlation-id: 72215102-ae93-49c8-9877-08db0e180128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yinPupMxnpFgmp46D5rJN42gr6InGfo5wszFGdSTSb2WOJyDp4AkaNnphlc9WJ5kA5BeP23MuVLl5Yzrzp6f1QW9ZQGLgkFKjnDQ0FZhivaHNjOUiLX3VuQLn7jU0BV1aD2R7PVJiB+hoN/Bba/WZfOjaucMgirtDwQOq9y3GcecCvsoaQO9w1uTdobvQjO5/t7u3PsJLKUqccu4TwP1QyFAq6ZI7wU/tOSgnoYWocdIPaZ6mw5x2X3NULfZrnxOjyCHQrstfd/vg5w3NI+RuG1/c7jJZy7zL+z38l5E16tnwJbXTUEKoWh7hC2zT22zYQu1Q+EvOiJ0SF9BZiat1QzFYux31yPxAUAqPLFZUWrUF03ChvWgesrB9HPKCEcJfTbNroToLQ6/f9/vsnkT0kCHWDU9PRhvs0P7Z6uHpDp04BMtnxEGoFbSbkajKQ5FLeTpgvcSvBI8FyytSm4m+GD++jb+cDUvRrF6twP4FGiyT5RWe+tplo8DvF83IJYJwlu4QEF1jeOTLWIhZAMwtnkR88VdUEiN/itWIrQEGY8H2SJwJGvGK5m1GjkxFP+NYWkoOQdClS6egDans1+cGcmcUj5b0BUXp8r1LBJ2bqvivUsSFqod/fdquX8tWUMjEdqHiejwbDq+MIkkszWTy1hIbfJ17hqwQJTZCtpgAirzFoGQBKg507sUXv1NTrX8ygVySq04h9FYgvBHLejOzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(186003)(26005)(316002)(9686003)(7696005)(66476007)(66946007)(66446008)(8676002)(76116006)(4326008)(478600001)(64756008)(66556008)(71200400001)(54906003)(6506007)(110136005)(83380400001)(41300700001)(2906002)(52536014)(8936002)(4744005)(5660300002)(122000001)(38100700002)(86362001)(38070700005)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nPizLL1aNfc1DjFGlTyXRxd0LYg/bKrloofTxh4ySqNqENJ+LA8WjMz7K4lS?=
 =?us-ascii?Q?xuEs0yiWMrpsWUmBd7bvgeDuWG+kezeD9SuFxRhITpKmeedMluiDp2dn0Io5?=
 =?us-ascii?Q?0g5mvvhsNvaDYOouv1vUz6GYrbahLzgxq8IuJhcCYr7X2qV5IHLd6SIs4h6y?=
 =?us-ascii?Q?AIqRcHPAD1NqQ8W+7dvtaeKJ8MltPl0Y+BJC0w5P2cZ5KAco1S5FPyba28+m?=
 =?us-ascii?Q?eSUlfXG2DsPZgyOuxFLcHGhF4zf0DiJOiNjgLIPwIu32AqNhFYr4OSfiRVsc?=
 =?us-ascii?Q?3DE0cjtEtPPF20CRKNWhPT+0M/w5FMS6ur8rcCKgP9f3rQ6Qn6g8DkBeUFvS?=
 =?us-ascii?Q?L3geOQeIyUreQJ07Wg/rUSMEiz3CEx3XJbG7UKBKy5SGVnDxCdojty5rgNQn?=
 =?us-ascii?Q?tTBg4w8Hodrk7TRRG19G1HKBm4nOGmH4e4MNtO/Ahih9OMY41EwtVq8/zoBv?=
 =?us-ascii?Q?spD5PptuSO71GwZ227lWVWeFBiE0+XwqTtVnI3qJuWydd4zkOecuDmwy6lq3?=
 =?us-ascii?Q?p7kD7nOs5LgbyQcT8MlXWpMJETnRwo2Rl2+bM2lX9RVpa4GUnB+PM7VIRaDA?=
 =?us-ascii?Q?R55cPGyjPdoFD04V17dCjV8PM/lk5FF1w2igM2RBY7efhNJ+evaiW6/cRnFD?=
 =?us-ascii?Q?LnJOW6sjoZYlVlb7BcsCWroXnAyfWqPe6qS5S32tKpuzxjSymLMPKI75hP0Q?=
 =?us-ascii?Q?8StvH592fAUFJ2gMseZWdL0derhw6YmFkkQKfLDUw09DuzMg+mVgSabB7Twq?=
 =?us-ascii?Q?z79TFhl5e82LiIhBRcy4PZjI3fjxkPpGg2wVhK9ugzZFVtETtOGc036ShrIv?=
 =?us-ascii?Q?GwF3ApObrRy3z/xQ53ezT6EKlBNLxEwf4w/Ymo0ewy2HaCEFQQ0NEpb2olcj?=
 =?us-ascii?Q?lcyLGII5fBhlrfkVrwO144BoCA5MFoj7Zay3twT9Q1TtBBy++CwSxCy1Hs0L?=
 =?us-ascii?Q?19HAINMT6xbwgIAamaAp4I6yS4XC5M1Q2zw2h2PoIXptuRHDSee0lYNpSthV?=
 =?us-ascii?Q?/Mn3VQOOEmmNaz5WB3BmjABNQZkbyASWi91Qb68H8JfT8wq741Gll3nk9/Vg?=
 =?us-ascii?Q?mDv2ch7sWp7xHpY8xGVlou5KlyLTuQGg2CQ+k0Kl9TuPQjZsDDrnrD18S8ZC?=
 =?us-ascii?Q?M7406Xme+dcMTY8dl19yTvgdY5Q7qNzj8vXkFKqvSwXjz783TVJ5Fgee7JEN?=
 =?us-ascii?Q?2hh25QhOqPSv1GbHMAKtvxH/rkT0z6+MIyXInDZmrCyUyzmkkc7UEdg9Lblv?=
 =?us-ascii?Q?+yHSQnbru+16VsH8TuK3khrV9HS1mVcmpd1cmzUUE4XR3e/lbc8/iUyQNUQA?=
 =?us-ascii?Q?rlx3EMwgJrpIdBAr7m8SKKm9kOoMLvMV36GwsD+uh+hRLqvKfQAiHCthT4AM?=
 =?us-ascii?Q?6JaejoTPNU5fbeFPznDjv1zipCz9yQ07e9zCV3JZjwK3Ezgda1tP2oEfydAH?=
 =?us-ascii?Q?gJbZNYmjtDcsQ1WXDU0dz3f6aPPn+uYbXkLsEqs2Cp/qglTVo9rKBbM20zKk?=
 =?us-ascii?Q?aMLVsVzdL5hnmRMnEvz6RBOKLFyMKq0OmU2FICyaxD9sMcRXo+Mq9B04s8tI?=
 =?us-ascii?Q?20dHMuIeud46jT4op7A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72215102-ae93-49c8-9877-08db0e180128
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 23:14:06.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLweDbZOsv3BbUuu4gKBxqWujycdZytbY5G1NwcuO0CU0g7kiYLDUOxoFcjIGf0K4/78xi2etISkOF9oIIQRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy for the feedback! Will address your comment in v4.

> +		generic_handle_irq(irq_find_mapping(gc->irq.domain, level));

There is a helper that unites these two calls together.

I didn't find any helper in v6.2. Could you please point me to it?

> +static int mlxbf3_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	struct mlxbf3_gpio_context *gs =3D gpiochip_get_data(gc);
> +
> +	*valid_mask =3D gs->valid_mask;
> +
> +	return 0;
> +}

Why do you need this?

Since we only use ACPI tables and we want user space (libgpiod tool) or pos=
sibly (in the future)
other kernel drivers to have access to certain GPIO pins, we use this valid=
_mask to do so.
Linus previously explained that if we ask for a GPIO then it will be muxed =
in using .gpio_request_enable().
And so we would use .valid_mask to restrict the use of certain gpios.


