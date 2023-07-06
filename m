Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A2749951
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGFKXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGFKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:23:34 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568F7DD;
        Thu,  6 Jul 2023 03:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAXSppO3dxQlhk9m7QfPb67diAEN+aDtwuP+vDIDugf7PAVqqWS8MNoYQ7DqO1Gr9QqqFhcTebzMzU6AJoJUQ8N/IJyhKH+Vo5D6xnpA6UH139ookK8faFwb03PBzRKzieuP7g4xB2vrJTwWxm/V71UmSD5Zap5qPeIg30zA9DLl7CBadC2QfJBUrdYV7/3WGFcXY2fPSwLP4AqZdWxryekDGny52D/yZdJmNnx0rYcSRNLx4pYtl06P+qf8JNCFCIuUTj5UZZ2Y/toRNIoeH3JXKT7rQ8eXF8zFkYsShSshS/R6rU9rqBNLTNZpBoH93d/lA/5DU8xhfmvUEIOsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN1Vl++RsYxG0NSxwk1AFGLj82Bc3ZpJdT9mM7T0d7Q=;
 b=XY7h8FvaRVCqVrZblV1xbKgPDcWZGjPkqio2uNrAxKg2PHP8XFHZzWXNRkQPNLvrg5gV7AAVTyqqpr8YvLD92h6X8GR7FMyOiiIulk3i3SuwMRdTNyhOOcU3hjPcofAzz+I4WBgZZheCUacuxI+l0fr0DbKUEOk4Iyw86zwG2Gjteu2jCbnLYkjn3oV9PBcixw4R8x1v87MxU+2fyahRutMjy7vLRAwwrenP+4ZvE14L21OFXLLgqKTVbpBviQmZMCvuyFmCMV8oBWj7sgY7cSr+zGbxITGHndyd6yYs2x0WOTel6aPO6D12tdDNNGtHbmnEqJLbPUgVSvcNiNcC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN1Vl++RsYxG0NSxwk1AFGLj82Bc3ZpJdT9mM7T0d7Q=;
 b=SRTi5Pvidn3e15QtilaUmngQCfHKlTT7bNhVgAJgxdeIDDHUSoYUyf57QdAeqETP8Y0RZtQKRfF+YEJG948hnfrREvcxUQZTiIf3q28eY2/QJkxXkc1tn7jmC3WJmTgO+T5P5c26liltUQfQeTcdrvE8C/gYGVHAI+wtsyxx3Vc=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TY3PR01MB9666.jpnprd01.prod.outlook.com (2603:1096:400:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:23:29 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:23:29 +0000
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
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 6.1 00/13] 6.1.38-rc2 review
Thread-Topic: [PATCH 6.1 00/13] 6.1.38-rc2 review
Thread-Index: AQHZrlR0USJQIMIQ7EG7/lTlgTa4sK+sirFA
Date:   Thu, 6 Jul 2023 10:23:29 +0000
Message-ID: <TY2PR01MB3788927D0CAB0079D89FC9C4B72CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230704084611.071971014@linuxfoundation.org>
In-Reply-To: <20230704084611.071971014@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TY3PR01MB9666:EE_
x-ms-office365-filtering-correlation-id: ce7ffc8b-5cb2-4704-ffa1-08db7e0b0ad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /U8S9PpBll9LMSmPI8hMZF+f1C8jHwT9BtuIotMr6b1Hi7CImUYyccwj47ATmv9cWMulF5iVsVdW94Yu12qE89M9XfrwajGiPV9WiyLytINU8NDM2aWuR37lY5h+ruWkCqcuN4LWfULfbPuu7w34nPQJe4z91XCtuJ/Vcx79A5qdLQNYT2s4o51yCfG5dTdwwdazD9A78fFbPlN4SBVx1qemTyq4hNiiXdJg8OpOtpAYvauBSMew7MKSY+MpLLtDQE0l0QZv03B5UQbJiBKviaSMyA0ipRoofMp5hS5B7CnmXF4pT1hHmyvyFWsqnM6GH3DCvgWCdYxj17LUK2E1sxzSLzYZvzrcQcIIOZDBSggTnHK7TLik3wo3+sDoZJeWrGiFmIjsgdcbxM0n2xWSVhwezGV29sGzwGoOrxUoHvjRrVuG1ACb8ytduvAH0N7WyADZu+z68VdZwDookEwxHzZ/ME3wOH8aPD4ZEdqY9sNP+jQ3Y1H2akQuJtPRuGg7yoLgo+q4TWWARJXG0LimQBvqC1P6/tn5UALODECOQ3YU2cOJtuKQSxFFJ0vOjplvthrvgfzXZ2X8yq6B4K5kykmaGWCZhxb57FkIiuxYmfQfhEZNSjNI5hL+oUaFbE0+rnaN5iiNKsc38tPJ23ABcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(5660300002)(4744005)(8936002)(8676002)(41300700001)(316002)(7416002)(2906002)(52536014)(66476007)(122000001)(55016003)(64756008)(66446008)(4326008)(66946007)(76116006)(66556008)(86362001)(38100700002)(186003)(9686003)(110136005)(478600001)(26005)(54906003)(6506007)(7696005)(33656002)(966005)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+fLH457RiewH3TSD6tj5uoy1sBJhbVxFg5ST1x0fjAZkQulednaUEEhv?=
 =?Windows-1252?Q?GPZN8HaxrXZah1PCiFcI6v3897s4v8sreY01rJQY03zM07HWlyei01ua?=
 =?Windows-1252?Q?eKHmamSXHx6QrDIWktp3/OZU4fBlHlQV73QpvmSQBbJsV6T1G3bPfBGB?=
 =?Windows-1252?Q?zMBcB5uGOoD1pCrL3CrkJGdtzLujiOVv5LLoxahmde0MMGxkeS7yJeeH?=
 =?Windows-1252?Q?+6EVlUJbTXErJG4fiLRlr1P/wWhrcuUoTe57Db94RCernzvbpF7+oRfw?=
 =?Windows-1252?Q?wUvl7rr6jQHZVjI066J72ggx74wfug6e7hYgP4RjNrGwJRnwgQGinGRz?=
 =?Windows-1252?Q?kUVky9oQ/diciZ8cZJbeHS+pb7/nfa97XhfbKXenXu6bC0xMeIgrxkWh?=
 =?Windows-1252?Q?NVUp6hW57349/nhvOw+OgYL3ovVKePs16tjXQkNZXdN4SqZ3htsRfU4d?=
 =?Windows-1252?Q?hkPMbQWSdgJy3tTt550KrMbP11tlPNP52+xRPKST4cKtZjYZzX3W1SYs?=
 =?Windows-1252?Q?miHfqtNk2wRwqF5n/NC8wkMUIoL0Ze60bd5FtcL5TWen+ywibDmBxcmC?=
 =?Windows-1252?Q?TtrrMGSHqeOot9xzZjdE8Jp39dkTturOli6AuzjOm7rE4fxhlDtcrUqT?=
 =?Windows-1252?Q?ePEy0ON9dK6x8mmjt0T3keNohUk5np1A2h+iWjoFt5aZCu/XXLpeHbMO?=
 =?Windows-1252?Q?IK227y/36LuDCJewoHdHXk52/5edb4yPjOJPupPktRjkRpf6PATOJ2rM?=
 =?Windows-1252?Q?G2wfTWwVPrx7GrYM/wYsTUsXbPEJUTYY315U3EHg9iISEeqLFZwQsy3J?=
 =?Windows-1252?Q?ubZLbTsrRneoLGtsKZbN4JvpGGUl+4Q5mKc4PDo/AP604f/lw5rcmiP5?=
 =?Windows-1252?Q?TKx6i0JrsxymoCarP84/nM2o6eDz+uUuS9qeem7P/7zQ5Dz5++Eybr4N?=
 =?Windows-1252?Q?4zVrRuMh8C+fKuTlfqd1Q46XLxZTCiFSo3TpGghgsHTXhj1VsK4GmKEN?=
 =?Windows-1252?Q?Zxd7g1b1dRkwO4X4eSU/GSIRuhPl0Goh5rdrGoJG7pBkIxdLqOYsjXFr?=
 =?Windows-1252?Q?ddJuscuJ+yjfDFIc4UXrWZvuGdRoqKdd5lwQW/Cianhmkl5ygiY2/T+D?=
 =?Windows-1252?Q?OOvwlbwAQl0Jub/N0Zu228O0D8BRW5/gGanFg49yoHnwm2Egtcw7QSri?=
 =?Windows-1252?Q?Av82qlXfC02Q7eQ1ZOdRZ0LK45mOd0TYPIBW/jBJ5whwsXfr3SW5UUQ+?=
 =?Windows-1252?Q?nVk4QrySflbtxf7YXe5SU/QWCexpIz/PLKBpv7pULnHia+SObZ5Lvhyh?=
 =?Windows-1252?Q?CDsxRRT4K8AdpIy71JRji893iKi9pLP38WNxHfWoVRQCIPtAFk8HLAuC?=
 =?Windows-1252?Q?uRVChbj12KRZif0ladbvw4WXz1jA45Jpdv+7brgEc4htkzOyhPiv6NZx?=
 =?Windows-1252?Q?s7C6Ot9y9yvUPSWIauDY9Gs9TnkRH4bC2utiXEzxP3qI4c86fB9DA/ym?=
 =?Windows-1252?Q?aLhUSKAoMP2EHoMaZE+o+0q7Vgb/20WKEOMMGo6cyQGSLbwiZrobdBj2?=
 =?Windows-1252?Q?Bkff69E11P/kqjsZlmXVWTy2uymLMawE/87brswOOKtAf2B29MA7ilSw?=
 =?Windows-1252?Q?G/NVVQFUstBkmdzwMQsxXkI13qdyDRl8xYqVgvTCsQ05Qsv5ApkLK7uc?=
 =?Windows-1252?Q?Ljk8nFpoTMr4E1RlOwM6eS22uHiuPAMCPmLpqcdmABjhTCsR7WxBJg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7ffc8b-5cb2-4704-ffa1-08db7e0b0ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 10:23:29.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3F/F+duUL3Gcp/A6s8y+7r413DHzX+rCHEBTY6CcK/UfnbF+q8/dc0CxekyHsaKscvPtYGtOIaI+JM8gYBATs2NlAXByDFxxuqOSOLIDRqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9666
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
> Sent: Tuesday, July 4, 2023 9:49 AM
>=20
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.1.38-rc2 (185484ee4c4=
f):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
20271897/
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
