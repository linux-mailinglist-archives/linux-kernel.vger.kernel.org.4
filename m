Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17021715DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjE3Lys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjE3Lyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:54:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0286F10E;
        Tue, 30 May 2023 04:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chr044/+mwWl0yaFh57UtnJSOyMJJvtVgSdYu/cctIGgqQe4F19KvcMURkbYYFHzBlVM0Hqom5LP7KggOBIAs332C0VnPbqY8NIvVQcpRoZozWDac6HSpa7fwu6t4WtWpe5KfyFYDmxXE/3AqywostkS/bFos+lVjgaz4D5Sqz/aWFhSt/Lf2TWTDLrYG0t+PxbrNWVlvmf9N1tBU5W447ZLGeV1VWdXUENF8ViBgQq/MAhnqDpF14tmjAW7e+EQP6wpzC3i9fKAIj4/YRPnhC/tFG+TM8EmPD/De5zB6hGF2ovn5NtKcC42+GjoypgxdibJBpHfPEWMIhk+wk9M/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzlSp6MV6lsQuNY9L9CbyWhvB11pAojpDRqhb4pJoDk=;
 b=InC2u2G1c8I73OghpoYeq5ujDkQVr7qJRM1QmY+1eTCxBJp2oi9bO46EXsBfrAIrY7TgI8SVhR2CsyFrjUHLdYRkvZGbTU3r7h/UyygL/2yZzJBwPWWrUqlCii3VHx2R1Bac+gfVTjec/KtkFS/1qJQQpa13j2P5kniViXz+lz+/Syf/ShGnWPVWfhViHUeQKa2J6kG5JbCLvwyD1cE8hcrt14d3Qr5+CUzW4MPiRv3z8+bXTRWrkAWF1h//6pjZXqqOD4Px4SHw2QMOEqPjE4u2P3rn3+eyn4/5IXGN3WIHRqEpdfsfQUf7BsmxWAeCyQVds9lfUJJ/emPkyNUOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzlSp6MV6lsQuNY9L9CbyWhvB11pAojpDRqhb4pJoDk=;
 b=E3V07H7a3l7gWdBvnzkAutFrbyUIt/YcPEzNOWALfdWB7WJe99dJM++5Zplu3TqUcNgd1wCpsI6ktCIwGgm0KmdTbFKnOtlPHNH+yu/ZwQKxuCjkNo+MSrfEyzKanpkfmym06jpqRhcm9G431VzZUzUWl6UCNl/vH7qI8rg1jsE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:53:40 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:53:40 +0000
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
Subject: RE: [PATCH 5.4 000/161] 5.4.244-rc1 review
Thread-Topic: [PATCH 5.4 000/161] 5.4.244-rc1 review
Thread-Index: AQHZkZm1zy6o4ZyOT0SsN9gGUh+Fnq9ytXzw
Date:   Tue, 30 May 2023 11:53:40 +0000
Message-ID: <TY2PR01MB37884577534C6897A4379A25B74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230528190837.051205996@linuxfoundation.org>
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: 572db26a-c2ee-40e2-4b92-08db610482db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q95JQlWh2+94HIX/kHo8GZsx70br2M/qm9nEg+lx8Q5YXsy07BTDb66svPtQohZsRJ+mJ5rH8fwcBVFaWaIWI6yqaQ9zRiHSgju+Ff5/SyA2Fv92Em5R8N0/ec3IlCBULfCZeoN/Ap0tlif5u7J/iSaMQ9FwDnVRjjSXnS0oB5GFIqdGyhzFwoVGGsE69Ox6HukIdSGQ2mnpzwhTkOLwqjJsdyQMesGOTNBurzhzefLXGLx+k65wE7BJCk46ElYyrH0eiDpL7xJyQszCq2wCRDKz2a/WJ7cL22FQrfLI3Qo1wbfdPH7wSsmy7WzZ4UZvwrGDE3XnTq+FgkxqImKrkHqd2rFJN8PUCTGi6uheeByr/E4XNp5h17JWV272xjW6aZbhbYoz9N0HEqSJfZJu3ux4K6YQ/PPWbr5H3Wc3WsTTM6/aAfg9YL+5NlxNFUc+ATpIM0+dC5FIMTLxjLDJsJmw0cEt5S3yTYwzZC20I2pYXmuh8ZtJEyEUy/7S+2bYp70cWsISMLUvxL5drMZZGu2tih3TJvivYEVq3+m/Iac/HECNIlXJyArCYdougRwc8E6GIeVL9Ir4cUWX81ihjQOnXOIT6W3v66DvatZaKYuI0FQ2vpMcUEtB0TNkW94XPEg3hmNJWRvNBeu8lSgzvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?/IFi2Ro+rq++Jfcr0FDHLrmVLVnFMC2rHibjq8/ZAATpKqpOW4/DGCOB?=
 =?Windows-1252?Q?PKZZq06GH1m7fvbP6e51JtUQ+eAOgaCgLGpq216gs0AgTU9hL7jRwMjw?=
 =?Windows-1252?Q?omNDI2rJoPKYgN3+nWsFlwJuY5mpO2WKYh2I4Tcu3MtkQys49582qx0s?=
 =?Windows-1252?Q?fyGqbdc8fzVhDyS3hqNkjvNhe7CQSIBQYmFze7rdCMB/2WiqMLEi3H4h?=
 =?Windows-1252?Q?ddIRJU7s0myjxEofjsY7+lU45ptj/gpge7pW2QAMYuQSunDlki68ubI7?=
 =?Windows-1252?Q?Sq4eUivnGVYAKQHJVe8HG68k/Sc+3rgR+66GwYf0mMquiqyjpehyC/ye?=
 =?Windows-1252?Q?tHxyUdQ1VN+04JuBKi1IuGJ8ztV1uD/f5NJDqOI29/tfND4vfrxL86cq?=
 =?Windows-1252?Q?H1+sb5d43E5a5GwwmRGknQNUp6jv+TJDHwlUihpEkDDC6tPFmEwMkRz6?=
 =?Windows-1252?Q?oeyFeIti1Jgb3A78YXDymC1OAEfdTradDNpC8oRtKRedkq8IBk/haZza?=
 =?Windows-1252?Q?Oq2TjXu24CkAANOB7bhYQMPbl0SBHVQEjJYTtDR4jVyZwsJKxync8/mx?=
 =?Windows-1252?Q?1MOI6P+/8ysJgx4NJOq86aFKydl0eU69qv2hvoF/2TyD4wnQFaoxSve+?=
 =?Windows-1252?Q?iranCoJCKoksWcHQmpcIjbtS0WekqMyeuK65IWI5LAwjvj/N1NwvF1nm?=
 =?Windows-1252?Q?UK0gY3sDracob0FEY14I8vo+g4MI7CQDedvw29XUfFQwtvEWqJG33lhV?=
 =?Windows-1252?Q?Z2UXv6UuYkWX/TWnxW2i7cj0+10itIcG2Ic5e/bUB6VgJSgGUuA4lKnq?=
 =?Windows-1252?Q?3oekONEg6xkeBhdVcRb0wVWgDQDIeNHjYsOORXhTlUQQWqR+0WTuYb+E?=
 =?Windows-1252?Q?jXsNPOy0SV1hJTBy4/YrVxmA686o90LNrVf/zIJRLIrp2dPtPEmBHaMJ?=
 =?Windows-1252?Q?yf2ZCeOz+14HmDvxYfADr69dAwWgeNYRbHQAPKtst69mqJaoodaAfOQI?=
 =?Windows-1252?Q?ziNfs3H/V8X/AtnBNWjg1M6rX/wQj6HGc2bqdkm+13lKSlwtK6J80DKQ?=
 =?Windows-1252?Q?lCRrqgDzKyUyi2cRua4Kj/WzT7eatz8MvF7OGDAfUwzNsG+erCHAjYW5?=
 =?Windows-1252?Q?8mo/+DE0F+flPjJ06Ps2DIx1nsbW2WATBTej9v9AMgHRCbp+HGaYIWDS?=
 =?Windows-1252?Q?BcINUgYXPQT/4CPV0A5EAngCKLeUjddBYOxOdEPd5LRZonh7aokxAkc5?=
 =?Windows-1252?Q?MT8ltnpRedu0IRFlru5Gweul6SlJ3qj2VhE5zd5bjAHH6sXxF4iVyZYi?=
 =?Windows-1252?Q?HcRMWuvRWrU7xT9K8K5bpb3RaB7++h8ATv9pJWC3eplijbSb0DhqUZoK?=
 =?Windows-1252?Q?6fePGui2Yy65x+W13ZPNi7nFK1suCRCyZqevFQqyy3M5E8xxYM+zjlJf?=
 =?Windows-1252?Q?mt9hYzI8tgcNXVDUwx3rIMBdkw+rWGLvpgQQfdouRQOnACrk/McVaeAR?=
 =?Windows-1252?Q?May+ZXE0ojgO3qoOFKcn//ZvgiJKv8T42PGBr7GIKv8LGhMGvry/Dym3?=
 =?Windows-1252?Q?ScJ3hinslcl7ZFEdNa1nI5/8yNAKXxCHKdXMB1GCbFPuJxFfznmB1Dsr?=
 =?Windows-1252?Q?I5qHONwNt9MpzWHHVY6WwAjKGn8BwwKsV/qSK+72WadEuX+k9Fzqa/OJ?=
 =?Windows-1252?Q?X6Z4otR8dpbZ6H30WKXNrQ9LMS2I2WR1F2k5SsyNOUjMuttX5nvlzw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572db26a-c2ee-40e2-4b92-08db610482db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:53:40.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4ivIEYvW7nOt04RTfQywQgVlhB+Yshk1xSGSq2z9HgqrGA652Ic3zjbeAi+qD50JJ2q/EsSX37VujCYsoomKM8Y2I6EQdy8sgkzsWFxChg=
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
> Sent: Sunday, May 28, 2023 8:09 PM
>=20
> This is the start of the stable review cycle for the 5.4.244 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.4.244-rc1 (99ecfa2a4afc):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
81425010
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
