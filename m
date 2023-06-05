Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE57221D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFEJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFEJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:16:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB61EE;
        Mon,  5 Jun 2023 02:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8AXASQJaBRWA8s2iOgZwV/2ScS0nZT3DJ+Q7Z/zPOvx7k3rOBMraji4/eTrwY3KT1QgKDgo1BWfn3xKQHwpVrVTHZzPQhRUMu2Q2chcdrotgaSxx2YdRCLSpFYcDeUxYnQHkxlzMTb1J3Bl5Oo7zX7qTA3mq6NOCNpEk7VY4rL+J/u6GqnBjtAp96Dc9wZcnZ1dbwzjFt0WYHrfdOJWaYuQGy0fBR7uHBmeWE20Z/hWlfnDMQmlJmPYags2wVJWsSF0jsotsHwQ/iFA+zeO0iFNeSeW3D0hGNEwQplbloe00FVVuswXmTg9JcB2MTYkd+fUwpQbxeOLy46NWRUTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw1pJs9UogkSIZ56EZZaXbtrLU7dljtUS6xKJCMpP54=;
 b=aUZdsjlkRu8OVdwVHF579PQPwvceEJvT8Vvul5ihTiZf0yfqx+roRamRpTAgywzWYH/dzuxHNk9HEGW5BcOEcrn4qBJS6UOQF5IPHEezS/gXnxy7EHNWN/s7uIu2LneDvF363HmukHNMYde/drTgdbW23T2T9usjNA1SQlb/Dr9uPNkUsOtQnZ7ys74VbFPcpAOM5+bY9pYxRDcoenNC7PTHmGp7th6hvYPBjcVHZ99v0jxiPCPQpohzEDdgt0kMEjH4cz0dX00lcGaGbExnHCVe3bvGVXdJlbpyxOrkBd8SS1O7ef7ELRe9Bbk2hBLHF4jZLTj+FIdhU7OA0G0jKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw1pJs9UogkSIZ56EZZaXbtrLU7dljtUS6xKJCMpP54=;
 b=fWSdcXKWEOPFjTYYy/uPu5nBWA7zxjKSWuObKQNWp1QhkHbShh13MOVfQrqQSOkl7FFgOCOCL1l+nTPyzVk9oqJZO52MKrfzW6ACtmCwfnciahOj/yrpuv2r4uJjltkuHsIyLT+ssz5YE8YO2jXC/LGTnz+6ujgEWy7z7TCc3Jo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:16:24 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:16:24 +0000
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
Subject: RE: [PATCH 5.10 00/22] 5.10.182-rc1 review
Thread-Topic: [PATCH 5.10 00/22] 5.10.182-rc1 review
Thread-Index: AQHZlIww2lPX5ndHSUK6Cp/8/eO4eK978y4w
Date:   Mon, 5 Jun 2023 09:16:24 +0000
Message-ID: <TY2PR01MB37883146ED0A4B80A2769D68B74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230601131933.727832920@linuxfoundation.org>
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB7996:EE_
x-ms-office365-filtering-correlation-id: 691e5b7a-11ee-4292-8a89-08db65a588d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuSpS5umuGA6S/ERMpX+zotAQ3sqRtO+SIdkQU16QJVAXZIRZmfu7KpezvSlTldoAnsqNJwpkA31B3Irs252IM5kKLi70Gy1gA5Gz3ge0dyHtLvgkJKzi6yywgsNbZV2mmk6sT0Ke0rr47KK4YoJpkQ2LEB4TJsIit8C8QWcWAClauMnv7AZkrh8VUx49Uvt0V2J80xMhlfPpRUjbaoz3dsM58nuA5TLqRo2X68/7Xs54wgEIDSjkY9YqJcUrGjP+v//o5L2tznA5TigLmNlfJWQmY6VeS54qHb73gy7qwz+pluSRgF5Yk0WIQqWHN19J9te2bvcK4MX9WhE6U6aICi3Ykk+wwMklaxTr4uNX3XMi/F6285ZbRPtnKMluWMC4IhTuyhtMmS2NwTGa/A2Xpc12cBzH3KcipLxj2d6MXCy4geMXQcBDTFKNnzufwaoeubUyN0bAu+UmsAhNhQ6rwinTSymcdVH375Va0DOrQwUq/Eu5YWso7SRFVmSW7gLfynPFf6Re7uWzBThnEuMm6NS/6TOhR5oSyTTrdqhWmEcvhvNxk9aRnNQoNC4lIMYijepuxkjtUoZk1XYH+jTsanHb+N/8e/ogvtddZiFuGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(966005)(7416002)(110136005)(33656002)(478600001)(55016003)(8676002)(8936002)(38070700005)(316002)(41300700001)(66946007)(52536014)(76116006)(122000001)(4326008)(66556008)(66446008)(64756008)(86362001)(66476007)(5660300002)(38100700002)(54906003)(7696005)(71200400001)(2906002)(4744005)(186003)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?5lZr6eX0dldYgJEDJ7rt7KDlf1ATcYxhgBA9TMLVxzgP3ddnA7Lm3QXs?=
 =?Windows-1252?Q?Fo3L2GFzP0vncBWDkkhcBOaxXNb0NauiXzSjaSCfWfNxXsKiaEhczyHg?=
 =?Windows-1252?Q?t4W0YGL27PFGdTSstNLjA68mQnSgcOcvPkh0RP9Lz+sGyXNC5hHaTS/y?=
 =?Windows-1252?Q?oY8AugYpfV7Mob8jcv3UE/0ZUPrq4uzRReLEyJePS6F3rFtBwkwrCFEd?=
 =?Windows-1252?Q?vMoKhzNwFrWbX6G33w+zmq32jU61Ot7b6VZkEFsoYcTJL8INcaPkPDKH?=
 =?Windows-1252?Q?v1+kj8u1D4B4/5A87aiBtfWqpB6LKYvV6eEc55hxt1DEXUi7AlOY7g/V?=
 =?Windows-1252?Q?wMdB+jOZT2FvZG5R/BsUmj/PtufdFi6cFGK8SSj+Rsve/OzWju5PAnoH?=
 =?Windows-1252?Q?2hv6E5HOHPvz3SlK/2dPk/FJoNC9wpbWlz+TRugSKDneBspxnPeHZxvl?=
 =?Windows-1252?Q?Ako8opmHVy5bXzZEOJRw5ccsL2Qpma2cS7c626crF3D/xHVWnTe9oxYK?=
 =?Windows-1252?Q?/H2al9Y/wX1LsAjc88pZ5QIWKaeuQYdx5kLr1q1IN2etofcREwZ0ylAe?=
 =?Windows-1252?Q?69aow5rIKLTUt2NohSLx0FBS0eybrBG6StawTq/dGgBzPMGqA9JRwyk/?=
 =?Windows-1252?Q?Ge43xobNCIy77zNdGQplBQ9H6ipbM0GfvhxfEbWPyFCWGxDfaB1QhRmi?=
 =?Windows-1252?Q?qxipoopDPTKgNSNQgtntQEZXZco5FML9bZlea8E/F8suBFbBNZXSWGxo?=
 =?Windows-1252?Q?CKcmp7hEq8mA+V7Cx2DDGtGbt9VHNe22J7+2WZeHiK5RpYwPFRM1eWPQ?=
 =?Windows-1252?Q?YpFCPzJPs16jzx6tWDzwXn6NYz/pvIRhT2Ku5PVNVQiiQWEOzMGZ+zBO?=
 =?Windows-1252?Q?7AylGtCDhynIwNSke5EQzE83fZDEI56kmPtj0ZWGGImfJSqlquLae/Pv?=
 =?Windows-1252?Q?EXOmC4VfXzSC3ooHsF9fD54IrV5W856xzYFX3/rnloAsXfAfvIiEuar/?=
 =?Windows-1252?Q?nRYSnSjXAolXXoy2E0+iTrpMBqPuo70jVKah/onubz40FJpVThsTx2z0?=
 =?Windows-1252?Q?VLnoLAOgIrqg+1Bb3qehb3hVAkBtDmDh/cL+L7oIqYknAI3YfqXet1Kd?=
 =?Windows-1252?Q?7c2nJF9LIFvIJiKGE4e3xdyO+gAwjLZpi9l4s6ml+LOlXS08/C3X5DQ8?=
 =?Windows-1252?Q?ZMU2rV9u8POYmkBaE8flxJMqJmhoTLU80VHOWLcLJGVqkosZ13zqNenX?=
 =?Windows-1252?Q?7UchDfCUoBj3Za0a/cTaaso32nWsZpFZByqvFPDPPWGJz6WiDcgqIOay?=
 =?Windows-1252?Q?b4w+iWFQQxM6wpSMoYnGt7ffawnWEt9SMqotOPVQuQM9ot9lEgJ72w8N?=
 =?Windows-1252?Q?PrSjMe2buRmnA1mtCkoiF3R8pmZATnpNcCrjguM7COxxr+KLbuOG8LEw?=
 =?Windows-1252?Q?KXBcjc0Dhj11UAlFbShbizyj8qiD6LLFmrS81YiAEXjPMIr6w15LKXZR?=
 =?Windows-1252?Q?CNxToAyWs3hQOqwkUNlFcoekXCIrpRtqB4MKN4pQFykBvYNNTPIsI18w?=
 =?Windows-1252?Q?TC/yO/0tQJU+hpLVXvIzDj9LvuOi13Q3cs55I3513LgJ8v0JARCWQAb3?=
 =?Windows-1252?Q?oOJVp4w2PZoLzWtKJsroSCdqVb30sCaAUJ5jyLeXG3Wlt6jEM30JK6NW?=
 =?Windows-1252?Q?tfeqmamSDwfM5l2eOtfpdmQ8ev6p/qQQnQD3kv21/SkHRhY8SeNikg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691e5b7a-11ee-4292-8a89-08db65a588d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:16:24.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WgqzTLwFP/f4aKfaTHeMeaptKU5grqm7mVVkXtugEMgZgOn+mls63ojXhfmdOx/uL8xzGWKXt74nSkpJlhyjNJmOH9FiPXN8SVGYVuk+yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, June 1, 2023 2:21 PM
>=20
> This is the start of the stable review cycle for the 5.10.182 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.10.182-rc1 (f2a19702506c):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
86202472
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.10.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

