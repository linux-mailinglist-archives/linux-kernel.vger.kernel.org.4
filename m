Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7B7221DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFEJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFEJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:17:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E1DB;
        Mon,  5 Jun 2023 02:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqdRMoFtrKDtno0IUFHJSCEzfTRq0WvAKjyxFtf/01vQ/6ZFKjFDUSe2C/z6sId58qd+8C0lTl3+vmeGILnrU+cuxzyb1ZZUSxi36lXVDwziMIIOU2tG7UN8xaOAlSH0mLUXXGu8S+IL/NpLp3l+rsUv/AA2qKz4J12Ys4dp9LoAFcEcGZL6KOsgyF5UNupkxIdi/Jssls30g6ozf0IOqU/u1vwjeew062PI9Wt+PxoKGSGyYzEGk7oa1jww8nIGI6nC7yvvvSpQl3rSHY5d1Ze1z10RmQHKrIv4zMU9FZneRG8xTTQ3B2b+s6NakIrwxjGgVCdEMQX6GJsP9lZqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYEKfAqgrDFIAAO5mZ8bNhkyvNSRK08KfnmuglN+LAA=;
 b=RmIKLYkfcpujqI/mqWrxpI+vQgKY2jSgfocVwGLyOewtOnnQOEoVsGIUpvsxyV1Y/L7c+VN3iX241BDyjeeshHM9yfphBPYQjVYQyhXMU6B5E+4bQmGbgGSYZy0oaCf+4XJfuEByECD9/np+XQI+p6wV+Ca1rm3tUo3kuKst9kYBz0qt4IJzNxHcC352SVJjCHor1Ab1FtnvepNCFFJcIqpLkNSlnisCx4U8HfZFiEjVG3liLM8BNU43r5h06181QMvQNkxr4OIVTRG6IluqJ6Nzq6z/uJZ3C/NHs7WL4oh/eoDEa80KRiA4+185wcpxRBbPKVKdx8gSk1lU58+HiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYEKfAqgrDFIAAO5mZ8bNhkyvNSRK08KfnmuglN+LAA=;
 b=EXk3hjrAOQMDMBrBEs390wyzNKPHb15jHw9hr4xat1M0vA06zdpoOtzRpMCu7HLKobkk2tT9Fz/IlrnXVFdDVFc+lMxkPZhPaXcS/hAJuhrgKd5OCMz9e61VTBhuq/hVPN7FCAX9gqVzI3BTnwpnkr5Ns92XYldq13qUDLiif7w=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:16:51 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:16:51 +0000
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
Subject: RE: [PATCH 6.1 00/39] 6.1.32-rc2 review
Thread-Topic: [PATCH 6.1 00/39] 6.1.32-rc2 review
Thread-Index: AQHZlJZ+L4ZtpJsasUCPMekq0AWPM6978vyg
Date:   Mon, 5 Jun 2023 09:16:50 +0000
Message-ID: <TY2PR01MB3788252907425104BE825F0FB74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230601143327.479886832@linuxfoundation.org>
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB7996:EE_
x-ms-office365-filtering-correlation-id: 2871cfe4-f538-4ce0-08d4-08db65a598c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gg0qHFYifQzKbbjz8tu/md7NfG6lNiyj+7Wyr9tWQRFEIbfh2jFFYWhVRSJDBaewfNdbABVvU0P1Weg+XXL6MkBu6wzZBXcoRFFysW/o/yspGWmJYosDO6pXGl/38XimQAZdeELuHOZcl2u95yqXe5FzfPn5A76NiKVGTjhu8IXoNQQLfKt6ejroyA5R1ZwH7ToJ3pDjC2yPTFcISYAI2O52/O4/Y6vi49vZu9E4KuPahp9aoP34g2tJrg9zBjrG5f0kPe8ppnFWr8/ESgB1fF0O2xI0oZT1H17A8HNKKF8VtIeucZnurtcsiNG+yCeESlvgyRIGdCsanph0QABmvE5uucpLx1kYXzgMyFzSxIMl2jBsUadX5RKf2VLgrBKStY9q3l+WI7zIPj3nJMglpd4LzvbcUFnS73ZgZ0eRELCGqCHIgySWjkV7x4uLl1N3DLsB51Gr2sjuv2LZU5KXPX+vzVWH/fzTnk48LnAQj/WLWQZyOQFSs4RsEjMIAM12F2gSsB15WA7l8UaxNWtzFwPtsJjSqUFFQTeDoBSH9IYHz0mmGonpbfCSs03ylqkHp08Lt2VKy0MiCpQ1cDv6MKt7F5Mx+4xKu6h9+SiIZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(966005)(7416002)(110136005)(33656002)(478600001)(55016003)(8676002)(8936002)(38070700005)(316002)(41300700001)(66946007)(52536014)(76116006)(122000001)(4326008)(66556008)(66446008)(64756008)(86362001)(66476007)(5660300002)(38100700002)(54906003)(7696005)(71200400001)(2906002)(4744005)(186003)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+c7ikDRBV8R+RME7X42F0rQLehN7+eZWD9oiWJ5PGb53LHnYc/r4y8/2?=
 =?Windows-1252?Q?uwS/iVYQJhz9A1veFmQomrB29+s0Qb2lZJRDHvjwzNwj1nUHQCPZR8R7?=
 =?Windows-1252?Q?bfaKYATESAKfMx930wfsqBWba2leP3UrTLKrRdYTgnZW825MzqFW1RYR?=
 =?Windows-1252?Q?VmaBjjufWLNvrpMgEYYIV8Qi7XPteV1IisWYmhwRgbfJZNX5qO0KL0wD?=
 =?Windows-1252?Q?UmXamrygm2FvnJTjZ4WBYfp5E599tMh68AXRCf9R5m4+C07qlI95guWF?=
 =?Windows-1252?Q?wHPwXw9uT6zRFedmsm8N5qeXIYoKD4ySo6vBg6sH0ArslJwuWkNL0LHB?=
 =?Windows-1252?Q?3VSk3Xw6qkcER7XoDzVPBdgLBiBfNZQKckxdQXxw0R7uhJmCSMjJo62L?=
 =?Windows-1252?Q?mpOgUJ2wpO8LLvHhq2a/a78U7rHngVs0wYrcYr0iTQQpCGawTnn1QOdK?=
 =?Windows-1252?Q?Fh+mV11Xhow3Ns4hFG3Ws2SiTrs/Y93kC7KmnZhQQ7hRw1I1qBmEBcxT?=
 =?Windows-1252?Q?7rdtxqjRosvP9qEpDAGkKYU9gle7DnsAJrxWUFyp6IdZ9gUU44xVVGw5?=
 =?Windows-1252?Q?09fADb98JbBI3LoPPiWX/JBEEYkrVFtJB5DLuo54bwR/NkFop10MdKmn?=
 =?Windows-1252?Q?uHEibBqamV3VtxMQarcNzOmrw9YRjgj3i0N4Aif2QrOybqIln1su2uaN?=
 =?Windows-1252?Q?60fBlHy3jICn5cSyk1tzYGbFiE9obx91j69BBu3IRMc3axqsz6L26qFa?=
 =?Windows-1252?Q?Sokw3Ocbb9CFBoFT/og79qNHEOKUU4HHGqHHsxv9sqG9gyF/Dnaaojfm?=
 =?Windows-1252?Q?f8I2iFxlhJmlbM6jLZNJicp/tIENLdhlHWnKwhTa1go+y4nZ4zebtkhM?=
 =?Windows-1252?Q?7MLrajXp+5JG+fn2FzYHtRmVXTuctD84fXrRvkDG0qBzlRll4h+ru6Ks?=
 =?Windows-1252?Q?iMgnaSG1LChLwRMNpHCBKB3AsVoKe1z0jebFAk/489JMSiD0n2KE5Lfk?=
 =?Windows-1252?Q?roTEDK8TYEuyzivUjtK77mwaDVUNye6OQ/pK4guS62lHNqS99UMg5k42?=
 =?Windows-1252?Q?sNPQU3bIjbBGMeu/s4qDteP7SN4SNcSpynbIMEtjvD8p+Knd7/oQ433O?=
 =?Windows-1252?Q?3R1QTm4Bc+LZ9NhbQh8d2oSCXtjytdKL0sv3c5Jq5ue7dkOlmgXx05Lr?=
 =?Windows-1252?Q?8ovoqzVGiyiRb9hdj1THkZkvU0irjZEquuWUUFseQBzfhAeUz4+OCZRt?=
 =?Windows-1252?Q?91TnSJSBE7ww5cnNaekoutQmT7BL1dwJPMNEQevRyjCqhIyhMtDSPBah?=
 =?Windows-1252?Q?mRDWq03QiZAsDYivZuSJC1qDJXubZgMrCv5ekl3qYlsSQMfZcjYMwJ8v?=
 =?Windows-1252?Q?p/dGfEDiGuhXd1Moe40DupReMB94RPxfIHY6tAz6vfjZelvl7GgrLZdD?=
 =?Windows-1252?Q?4tG4Plvf+XWqH8nXC+GplDR3/XClKGNqLVTy2KN2XbxWSibJZBZSmMCl?=
 =?Windows-1252?Q?kLqwtHMKzFExUMuigIMLdT5vWLsAx6yi4O8QdaCpaL4c4PkdziRzxxKG?=
 =?Windows-1252?Q?BbD/5ilDLHY/5Vj5RpXpuOLyeah/mkreVCC6UyvCST2NhJJAza/MFAgA?=
 =?Windows-1252?Q?vFtXZQhtMdZT0Xoe9BayELlanllAPaJLnX3cXoLRBSKpXRZGh39SP6F5?=
 =?Windows-1252?Q?9mcmtWXqJcI3naFmbrd+C+C4i2B2BvdHH3UKHDXbLKmLOa5wqRp2Vw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2871cfe4-f538-4ce0-08d4-08db65a598c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:16:50.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Cm7Oz05Dd1o1w3aneg6eb65dRoCqBMoTcApaLu2DYUoMQ2s1DiKZsLMKzZ5QquFGChGGRmtEm4ulIfcEuAESeFEkZ7r0MMs/im/WjZuoi4=
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
> Sent: Thursday, June 1, 2023 3:36 PM
>=20
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.1.32-rc1 (91b86c5080c5):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
86202580
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
