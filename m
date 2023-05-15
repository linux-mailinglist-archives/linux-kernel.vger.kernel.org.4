Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C1703E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbjEOUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjEOUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:09:45 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964A11543;
        Mon, 15 May 2023 13:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJi/eWqEdpU3k+2UVgzEwt+D29lPWuQDZLG4SfLAzZ/W4vZH/UR96Qui1yuBZMfLMyIdyEtdNnfT+mQbjnDtrv+I6/di0hZFmjnrFLP/Gu9E3nmJhkRnMTtimwp0csOopA2TgMsiFRbLQ0C64UT4DYhH3CI+6rIK6BMNkiYFiNduUxuUqiZ0xqVEAMqb9CT+TTwxbHEdKHypBvEFYPao0HL1aad4CZ/MihfChF851Ia/kthyuE9L8VFczSG9z5S3NcavTdo5Y+FgAm7qc+6b79aN192ipaEe8RiAxYsanMI06zTe0r6S5COJOTfXr5+lytfD7KrK18UaTzz6XVzcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku1hAI9figubudWvEIqmyEzD4vbNH3Guz2QFzt9sgTs=;
 b=dUknppuykpFT43lDi8zqKi6pbmZ3hIOiXEh206e2LX0mUj+D1eRHSO/Z5Rkh3W4F0Hshu/dnFTZHHl7ufQEzvlFELXi0BCePJ6YuX5/chdr/S+jxYAPeBP7JDRFukMF2RLUaiyCUCzgASCM4Bsr1zFK1gmNjYHH2L7HTHsCpsTmFS2KMdKkWf7hKaD2CpWhyrZMsHDiUYlOpsF1ERwlolfcEsynRs78X9q0zWkeXBgNmK4k6VIr/ClwwaaIBtowU5vnQDcnupvOxihee6i012nXICKsI07chkf89BroJu+MCV/nyIGLWV88MMthhJaeM8oDOrujaorm/c60lEmteeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku1hAI9figubudWvEIqmyEzD4vbNH3Guz2QFzt9sgTs=;
 b=dzvXl6IafXCikmYUktMt3djSx7vIkBb1SWWGO97RPUO26Xju1MKxwNgfSalQ58AdjIP5qgsvRPjxnOg0FaEVKeZVx697lE52kmU2ixmtIalIAIKdimczyvx07vCWChLyrr+5DV+Yy4kSMpCKT8RFYmimZvENTUuwEbdmy9JCHVw=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:09:42 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:09:41 +0000
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
Subject: RE: [PATCH 5.4 000/282] 5.4.243-rc1 review
Thread-Topic: [PATCH 5.4 000/282] 5.4.243-rc1 review
Thread-Index: AQHZh1aSiqSnBD9nGU6D0HONq4evD69bwxzw
Date:   Mon, 15 May 2023 20:09:41 +0000
Message-ID: <TY2PR01MB3788C5D30C6099BAB6F10CD4B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161722.146344674@linuxfoundation.org>
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: a6cc7971-53b5-458e-9142-08db558051c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHkbPLa21InsVklVPnFuae3EF+SOi9bcgsyShUfaz3olJKLajyURt1QxC+7k9aljdxHNmwWI1OYgm5J09aaqSGQKdYXdyxjx4Ys10POIbpLzVjI5flhtFE61c0rQIHLLU/BRAFVAN9D/fD8mipzMVvaPnzuxzxMmME7vxo8a42SrwVb9dxDHfc7lIatW91LrpJKFfiA+P351KYE9rCiIsCxH6wiV20KswUdi+CzmlpxJI+j5tMmdzlh8mqiqhY5h3rUfX8hpKRvENyd5saCFcd3ayNNZz/mLnRWF7AhP5fE2siV/24X0l3HqeS/chGY7Kb9i9EPyfE3f74MAiGQINZXLO5rtPyTyNJExCexA1nT+nfvRx9XmPiVnDCVpgy3i71fI6TQvh6U0oo2D/FqqL35jB3hVnpPjyt7sO8OGW7mHa6nwJ+zx+Sh+mwPtDIUHwkCktVem9Xnqk8T3nqA4hec8GqXTSar8SKF68nbYhygduxEaxoenVjB+yWpsx+Bk+RDq6/mm7d6kfWhASgjJDWhhR2x1zU8qgPuafMnv/yEASyonQ7v42OxiGMRbGuWxcRwUqNcLNS7lm/XIDHBiON74JV3TBX3VJd95dBMHKJK8PcDQYVr1cyZSJ4Cjt1YlzZyKaBLf1TN1mwbcv6nSyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?3cgyI+E5bat/MVz5/ZXdyF+Lj/YfA0yFVpunhGFtMOzjJkCqC6cEygydrt?=
 =?iso-8859-3?Q?AVSrzr3NV4dPWo8OUfUTWTC3slRdD/qDYHPYkW27Er9r2lR+LDv1no14nh?=
 =?iso-8859-3?Q?twhu2uGZ3bqgJBpem/+dIvqUxqjqcwPBrueoetMGW/r+vVERjtAEbK3fQF?=
 =?iso-8859-3?Q?GvktQbYFzdrRYjS/DEAToQ1VnWeq0j0hNbwjVRgUPDCakozXhQZ10fFg/f?=
 =?iso-8859-3?Q?H9CvwcAWaMvXJ4xN/L+WfB3m++gpnyuBmM6NKCay1KRL5UoE5UMpbc5QAe?=
 =?iso-8859-3?Q?0pbV2LoYU3yqNhrIxGpeplrFGOoTOTGglwVPH0IH0o7ooME66lA4imvBal?=
 =?iso-8859-3?Q?hsjwe8knxRhQUu2p7oFbtPBBHD925ihv3rAkvXoFdjabTd36BqIZWBIcpZ?=
 =?iso-8859-3?Q?3QuXP43TJYwxkuAmrLQkqQWZCWDAyr9L9sXQldj3iDNn6BFz06BgvyZOFp?=
 =?iso-8859-3?Q?+lpjthMLEbi0/ZybPN7y3sGgqq85BPe2rN38WJf+36bEgZOBpk3rrSN2C8?=
 =?iso-8859-3?Q?W44P+4sndYw+a/wAiRL+nE4MKMKTIfJjk91scdaGyCn1x7UtVJtNAre/IT?=
 =?iso-8859-3?Q?GWGG6myyD45W5FhLbWEL7ZbJXGrSSgi/5C1npPETPCG7nmPrKlD/vt7itL?=
 =?iso-8859-3?Q?mSapEmDu0nQqi9Gsj5J2bZ+NZPh7ni4J1PC9QtZw8CxCaG9fSHn2mePnb9?=
 =?iso-8859-3?Q?cBX6oDI+rxIlDekznE0UKXo+oMDMN7d+ebMCPjmc4mXrFINxOfRjJYZOIw?=
 =?iso-8859-3?Q?dC58K/x5CX1QamlOR1REK/DDhAU8ObgbuU+fDE7UMRVpFX7roV4vePMRUV?=
 =?iso-8859-3?Q?9EERhO6kdghFSUNN+hTNIKrMm+PG1EqrCRa/2dhggAzEsuHRiQoAFSax7E?=
 =?iso-8859-3?Q?HN6HBEYfEdSahKG6806cJQoQ4mER5WQzlV+kKQAwGqn1RZFSvQubzeHY7I?=
 =?iso-8859-3?Q?ISE0zaiOr3iz33Rw2gYn3b7pREgGG1AkITlbjSsrpS+x7wqLjnuyiPvIad?=
 =?iso-8859-3?Q?M9FOFFKrapkuPJqJ0tIxu/jBXLj8Cj96ATWqk29GmfJ6OZkpCXBbppAQZb?=
 =?iso-8859-3?Q?PVayJPaZcunU7+250qjZrXcIR314uwkO+U/nAc50Dyx4yDkETzQyLpMOJl?=
 =?iso-8859-3?Q?w19AcUbgFxl51wlY4npiqHr6TIVOAuQOsIAVlwl4ukAtuKZrV/js847Z3X?=
 =?iso-8859-3?Q?G8SfFWeEXrOEAHH8ffBqbuxApBHiVRBpMgN1b+ykYaEYRBhUV4QUtcQKnU?=
 =?iso-8859-3?Q?HMiVqaVAmEVFGtTcGm01RzTAnz79XqDfWSf5rkcuY/lG72uIudw4+gP6Pl?=
 =?iso-8859-3?Q?Vw6wZ9EiIZRrvlk/8PAfXZ0NKtGPwURsKxp6r0Hx68FrpQekzwTgXBcYyO?=
 =?iso-8859-3?Q?8ul9uxnGpiqAIB2H1kdwkGKqPrsyBmLbSusvzlPN/oFIMbkQ5LVXEObzUW?=
 =?iso-8859-3?Q?LwwTCnvmpHiHNnzazIrz8WastrOcfMgY3WQMMhF38JQAzTOzD9jBlgZcRP?=
 =?iso-8859-3?Q?G2OI3ZPtKfDQYq63zW6ktyr0piZ2RDb1yNvXWMq3TzSj+dgZA44LQefIZe?=
 =?iso-8859-3?Q?2M3dIcwVwZNd/gb5n+OFfy2qgNFCPsV+R1p4SmbVD7ZUY3u3nuT4oe0eRT?=
 =?iso-8859-3?Q?4JnrXJlW9mLu613DAHpAKez2kiBhPkphPdeyfY6krKZscbqcdgeWoPtg?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cc7971-53b5-458e-9142-08db558051c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:09:41.8881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BygzDNZzhVVpH6imVufIK5GnyvnVFd6ecNSXVWBSaduqU+dn37K+KBMyaQsfg/8UrKPlukHN8kyJ3OcxbLc2iS+jPCIDHOHulPtTdLp6hII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5459
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
> Sent: Monday, May 15, 2023 5:26 PM
>=20
> This is the start of the stable review cycle for the 5.4.243 release.
> There are 282 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.4.243-rc1 (b6ac0ac1f533):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957639
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
