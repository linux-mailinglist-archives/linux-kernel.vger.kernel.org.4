Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238296F3F01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjEBISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjEBISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:18:44 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3358527C;
        Tue,  2 May 2023 01:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPInOPtJzXT1YtCpYBKNuersz2liK5TvWTj2/tbCC4MLXV1wscGV74l0RcOsY3OW3svcJDJ5VyIX1GdMDJDfElh1zSx3Rr5CytgQ9iQRAuZoUzU0gMtm2QVV5mFsPiv4rwtnjxXW0qgVfspXebocjF41tVBuyOQT1Jof1UYRYVzcFevzzy9F6x+Cfv7oSUzF0Vwh2RbSusPC3Ce+YYYM9+PYjD8RVzLn+5l9sioEHP1+q+vDR6gMy6pNBm2r87xxejbjkM1f6zKLjO+xgGcIEJ2RCGjUVJLkPulVqEF9QuIbTQtx2Bh2ybRApyLq424Q7VKtyYNUkvF0jTw1anEwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD/hOXs/YQBMYlcm5KW6nGYh2Lb/9+RRE3iHP5IVNcM=;
 b=Z0qM2tKBKA2kiLKJgm0UhFghuXhZWzt2uDoEg2fgIipEgD1g7QKBpISFQltGBUvY/PalTVu0c3OOPT9Qyg91QE85r5oVSHwFiRs0rUMCoGTdzYHSWr6V3g7ks6Q/eEqphQwfWE44ujkS5zLwM86zDAbPsq+1W75LleDDK5ZZIcwBx03s1JYyBkSCJEW8m68HLti2LdXPCryrpF37PSCKn7sIHIojQqT/zZCtbWarotvZpRVQM33TBaVp02/VCEaSdKOAILD3y55LmKz/6cFinYG+o+oI3r/vl4aMZyKhcLEojJ/61C0lhVQIVd/+Tw3km+zY3quSQJ+EOaQf0/sKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD/hOXs/YQBMYlcm5KW6nGYh2Lb/9+RRE3iHP5IVNcM=;
 b=CQ8PwqDL0Fyykew9hy1sz1eTEN6zQfchXCVF3NXKEoADNZfaEFrcwFZhWLQylimxjhAdYo0qqZO+5QUey2OPM++DuD1/SI77BddeDI/n1eHHAQ2fqIyM1otV/HtbAOevJsrMIB2bK51r0BSCqQxxT9C5veFVNYSirMtuWZFj+Mk=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5908.jpnprd01.prod.outlook.com (2603:1096:604:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 08:17:23 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 08:17:22 +0000
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
Subject: RE: [PATCH 6.3 00/11] 6.3.1-rc1 review
Thread-Topic: [PATCH 6.3 00/11] 6.3.1-rc1 review
Thread-Index: AQHZecSAhY/A+/BXt06nX6tf+CFVy69GfCjA
Date:   Tue, 2 May 2023 08:17:22 +0000
Message-ID: <TY2PR01MB3788F80BD4C36EB891F69F34B76F9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230428112039.886496777@linuxfoundation.org>
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5908:EE_
x-ms-office365-filtering-correlation-id: 4eabb216-4baa-4a80-b1a2-08db4ae5a7ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlZCWbjSXBGrO1NXCuCSOZgV1fo/fl0t7sRqIJS5xLs/bbqlns36gRFf62heNjfO129eiQc2H3rIMZ5GDOsAuI82VQzMZ+PiKzhCSMaNRWyNDHTVkhQpPUMOr0nd9M+83OCX55A/Agm+UXTW6VR77SHzFyg5wEMsv84vKtCg6j8NcAb5AjzdKiHoTxMxrKMPLchYHbQGHhzeDkDySOIsfCyFYRR2NwUNpO/TjCPxG1CKdWkxTKZ8Gc+a+SCfRLMlIOlr+dkgxQ4+IerIhOy18nTUQutEa+5PUi3h9GscdFzjXCCQChcj4MhMrB5n33aCuYpfPs1cjco18p7E7xcLAlUQFTtZmNjUEiMTFDRI6X8YhY+JuNW/ZRq0w9k8/yjdXtsmpR4phLrJIDn+xPRW37T2BRKf757XmUnKfLBAsuDueGVmwvKuI6KDGpaweB2+sV9ubyubo/0QGfeCvkX1XEQhRhfGBuECj26RJzlaZJ2GxQUPS4r6YqBCQ45QGMQapy4/LwaoW4cHK+3brPgr9QmDTcrImuJ/jWiM6uLPg7ssIJ5XTFERVUrkzZX6gqFUV1IA0L7iJ+Ab2esRHuqqax2/eT2hySu/0Aktm3OVvpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(966005)(7696005)(9686003)(478600001)(71200400001)(110136005)(6506007)(54906003)(186003)(26005)(7416002)(4744005)(2906002)(33656002)(38100700002)(316002)(4326008)(76116006)(8936002)(66476007)(66946007)(66446008)(122000001)(38070700005)(41300700001)(8676002)(64756008)(5660300002)(66556008)(52536014)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?gCGJI85jlTq0Ggqj2kDvHmrRUblRLFxhnUQfuGyCi2oi1SRculmmmMI3Yq?=
 =?iso-8859-3?Q?SMRDZQK7LftFFmt8V15gj4hqifnM2KaCUoaWvPd2peavv+j3KUeGleVskk?=
 =?iso-8859-3?Q?7NR77spvz+uwZppVwqDoDKo+JsnLJhIwL7KSio9LuahFDtBaFz58Ct8Smn?=
 =?iso-8859-3?Q?+ZOrIvnSx89U3lXVVXEMkpD6Wmpsnl7eUqT8l1E5c4M5UjdeEVGQaYJJRy?=
 =?iso-8859-3?Q?tPAK6HgaH3VL2p6m9EtY7u+1TEowK5WPtldIMWNyeLKDfAn9NUJLYxi78K?=
 =?iso-8859-3?Q?FWseCBMWTC5ipsAs4K0cq2W+dJhYiD8w1x9u729V8X94j1Hg8xOOlyvN3W?=
 =?iso-8859-3?Q?rZtWVkL0dkG4mZ3/IAQhcpSS1KRfVApxSxCwBg9IlSuusjGuVVZ25ZbWFX?=
 =?iso-8859-3?Q?lTye1rMT+rSAgoGAgvLnau8ktu1TkZDlsEkGaauVIKc40cLZ23QtKN4Md2?=
 =?iso-8859-3?Q?NvjTfG5YvePZb/ksJfwoJ43G+saFiXhqt4uaV+pCdpKgRTwhrHVS1I4aQD?=
 =?iso-8859-3?Q?zMcfqIY4LHO5jNsdYnLZeD87SPivbMm375pUUZZGOlo2h3tnZ1OKO/6o6N?=
 =?iso-8859-3?Q?IVFykeX9SBWR9vV3DdoYqt5i6zomo1L5dabeqP0aEqhdexvVYKiDwxQZkv?=
 =?iso-8859-3?Q?4vY0V6D9fdk+j/QQWJSABvm0MYqYJqXu4PSZJFtXo8yETKKL3JXFKtp0DD?=
 =?iso-8859-3?Q?Y466rWKh3WBUzbGCuJCH0wCM6Pp991n4fBqMnt8tv6cQAAb94DRTr0gak7?=
 =?iso-8859-3?Q?m3bKoszmRS+fpFwn3Iy6JKm1uVtqHCUUJW0QMbX7uSQCfOAGCoZkrIKwnh?=
 =?iso-8859-3?Q?ef95ZzjMNZxjrJocO9dT5Y8eG1MKHonCG9k4p+XXqK4+wI7abFnoCgXUno?=
 =?iso-8859-3?Q?wR6Fl5CT44u/82jZpRcBFacdOW6FIRi7n0gHHI71czDHtG3sDMdntfEy02?=
 =?iso-8859-3?Q?+Ql0uHf26BH/jngZgGuU1H3rrIV5iTWqCEH2dllKusNb7qk5j+c7MWSYI6?=
 =?iso-8859-3?Q?3ogZkkiUmT/BYAc7TRUt0426kY7i3Gdxcclh0bGdvsDBZMcmCP0FZjrmql?=
 =?iso-8859-3?Q?5HigMzPqZR0gMAR8gHOSsuPL4z9egFO1QE1ZR07Z9cr+cRpjC4+irwlebt?=
 =?iso-8859-3?Q?EiDMDHW/HcpxdvXwER/0ZdgRtaDA7X7So1rGu1J9i09LTAqfPT+8UfVgKA?=
 =?iso-8859-3?Q?znLtvJhPs+Vu1VevYlMcPMzHRim5X8QCYt5K2l5RS/2oPP1zt5wDXPyuXK?=
 =?iso-8859-3?Q?E1kWfNdKeYdumAkmEGzySRLOK1qGa7zxOsh0dRXnX3sJqfZpS9MmNVo3k1?=
 =?iso-8859-3?Q?bdvO7lQgpUl+l5AN/X4E1VsPHr1c60vqRU3rPa54ldLBCA0lD5WlI7MIlT?=
 =?iso-8859-3?Q?AjSvMVg9+XTEAJHXVeXn7yTP6A2PT/8OxlGP9JURtEv1jk1vYOV1b/GM3E?=
 =?iso-8859-3?Q?VYBlsgdAC0jQ7vXWWuFzf7sv9tbRcSNsbSi0t3uYDgpz9dc1EBwl0DXOEA?=
 =?iso-8859-3?Q?e7bCpG3UDFnXCo04MmTowcD0tpEaGeNfVqfwj+C4q77H0Xl7xT0QIruEhw?=
 =?iso-8859-3?Q?aL60uITWFlSZztcCv+dhtO6sNI0h6daB9p2p/5YqYQ4ZovFO3bFd/yyh2H?=
 =?iso-8859-3?Q?vxq/NcBr1UsopK8JGNmdmEohN6qZ1wnkvQ5PFHzxApjZ5n9O93Z6COxA?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eabb216-4baa-4a80-b1a2-08db4ae5a7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 08:17:22.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBQNjnFyZJL4sNX+qswsZxTaGj2qFF5/61Y2xsSnHPsDrUUH2WG/SGkS2x7/jR44WBlobUDBJ+98bAgHV3s46klCxF8vaq7fMqDOyE+J4WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5908
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
> Sent: Friday, April 28, 2023 12:28 PM
>=20
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.

Sorry it's late. Weekend & national holidays in the UK etc...

CIP configurations built and booted with Linux 6.3.1-rc1 (f45bb34ed520):
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/854248852/

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
