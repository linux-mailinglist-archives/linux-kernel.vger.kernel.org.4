Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33C75EED57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiI2FqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiI2FqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:46:08 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1493D10B23A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664430365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=F8gFchajaQ5YdzVEnk1dHbeRfevPh2jfD4bXWuOvb7g=;
        b=ilQXi0vFXAWlW8CWkHd9HpeIvClMz7IkWDtm9AhSo3PyjBCp9a1NZvGjb5j4EEjAHnvA8z
        cpS5eCoNb+ezXNRbDkZspqKVj4duIGTsSDkhuNXupIGHCHDyhgLcZhQRhzqexXAd4QshHP
        lcPtDq0ihPbvzU1QrkRxn5snFwm6OvQdWN6TAQGKp8iCNZuf3f5LDt4NlZmxXV5BNvJNL6
        Q1+36Y06b2QiAXmFMjsDhQ1HEc4AQbfWeU3ohqWE3ufN/qkmSHyUDTLTuRMhErGSQYm+b/
        F7IT6InAnCNTyFHQ6gWVv0EEYm1heOrWQOvIe0xu7fn+MehrufYqIzbNgqLzvg==
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-aBsLrSN8MZiBNDOEcQ6HEw-1; Thu, 29 Sep 2022 01:46:01 -0400
X-MC-Unique: aBsLrSN8MZiBNDOEcQ6HEw-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by DM4PR19MB6173.namprd19.prod.outlook.com (2603:10b6:8:b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Thu, 29 Sep
 2022 05:45:59 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c%7]) with mapi id 15.20.5676.015; Thu, 29 Sep 2022
 05:45:59 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        Yi xin Zhu <yzhu@maxlinear.com>
Subject: Re: [PATCH RESEND v2 3/5] clk: mxl: Avoid disabling gate clocks from
 clk driver
Thread-Topic: [PATCH RESEND v2 3/5] clk: mxl: Avoid disabling gate clocks from
 clk driver
Thread-Index: AQHYzkwFrQSJjUImDUOzXbBrfYxegA==
Date:   Thu, 29 Sep 2022 05:45:59 +0000
Message-ID: <MN2PR19MB3693EEC08EAC5370F1D195FBB1579@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <5a88bd5a9e93cc6e794080e5cac821ae0c27ec56.1663827071.git.rtanwar@maxlinear.com>
 <20220929001745.A4F9FC433B5@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|DM4PR19MB6173:EE_
x-ms-office365-filtering-correlation-id: 12d9ff1a-3c3e-4c79-bb7e-08daa1dde338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Y2UK5M96wIoJMmyZO4nOe+P4eUCMXhhDfxaBzQSx04NDsQBLZQHKCXqGSCL12gna+AQ0vp/0BPcxo4YIhEQwHPjBfmFUG3MJj/x0ff6Cs6nALGCKK2FTJBKPBgcWv1r7hsFrqlDLTlhLjmPu6W2jc1dByRMEJDLgqDZtI+iHR+oVq0zQvSpnCMB8LyNYBgoaQV6OVcqF73EGme+fkEW15nWEESdUcwitZzKxxhg0IhN3hsJxloXLtGIxYOq5oz3sO7axFFO07dpOyZqRZ5goH7HS3ujku5nrQUB+y2h8xXeUmPZ58lcS25jMnJHWnRclzI2ec0hGr3qjQkWW7ybyt2kCvbFLagVOVpQPHS8am+Xsa+BhFUfQu1PPvN+5bfpf6OGcAMbje8FrsVN4rfk3t4cgGb0cAuFgQM6/9oxbitu29DC+zm7o3d+bj5JHnWXJMjqEJd0JezYA84mUYz4FN36gKcIMbQu1URqq5sztvLvH1gsWsMGMiFTeqcFEjnf6VhRlYh0FD0ScZRVC7GprmyAm6aHeRc3jpTxKturHvY2A9vj3sRAITY/0u3CklCKp508yrTGyDo16IkKBJiUMA1BR3jS168ikaKSdtvJXT97zebZ9lW2lFKoEcrQHvfqqKx8WeMIHWFa1abSi+HIguN8OIdPZSKoNw4Aq088Oz7fJKzdyVW5CFo4Eje2dBuV5Kob8/Pset6oxqmwuxwp3auT+DidNYDVREp08cxb96X6zeBzKP8ZfxMQmpm1NMj68wsk4pVRTOQBt0wv8d4Mm8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39850400004)(451199015)(83380400001)(71200400001)(54906003)(316002)(66446008)(66556008)(2906002)(55016003)(66476007)(41300700001)(64756008)(186003)(38070700005)(86362001)(110136005)(76116006)(52536014)(66946007)(107886003)(6506007)(4326008)(33656002)(26005)(7696005)(53546011)(5660300002)(38100700002)(122000001)(478600001)(91956017)(8676002)(8936002)(9686003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFXSCrxwwsy5bkQU2SvfI5SXuKMVGb1m3G0IRSA3AwxMaWZ8LAZ76HjgMZE2?=
 =?us-ascii?Q?jLtrq2Y23gC9C8qn043YqIWrm1M1aqR4tr5OMqNApCfiqBEDHghBsqtdQUGg?=
 =?us-ascii?Q?cVk1RaSAUGLA6KRtHcfbiwZ9YP29ti/SG1ytvjyAqWwZ4OqZ3AoReg8bjz1p?=
 =?us-ascii?Q?ObAZltvSWDNjK5QavNKjtsaWwM9rH5noOzeRuY7c2XFukvzBY4TO1T9jJJ5E?=
 =?us-ascii?Q?TNxOPMKtGo/P3qxHLA5fgfC4sz80j8C+hBmOd5Oj565HRazgNTyao1iu38My?=
 =?us-ascii?Q?VtXBq40OrGhGQDrR6ak+lZ+a0ACsIE/TktanRnMSIfU2OCR+WSCovUP9WnH4?=
 =?us-ascii?Q?MRVuz8eJi2TKMNtYmZMS0H6vwhpsH6b1v+2iKMQS3iA3u40kocgwQpJH0RuN?=
 =?us-ascii?Q?8C5QS0oXyxzsTa2NurCBkldei8YHOXJI1rGGwRtvGr1wGRFBffgtmme55n9E?=
 =?us-ascii?Q?+Xs6XQebhqaETkPhbcrg3Qy92iNG32Dpt3i6oTx4141P9n8WcTCFRreleEi0?=
 =?us-ascii?Q?0MEvyoVGJO0xFoMzv8RquhmyWD7SApSwsVIKU2Nm91fn+oTvSPpXmSE1hrnH?=
 =?us-ascii?Q?CH8KOQQqlIxm6NvWUWkIsgkXS1j8U+FZZN6CMECnXv3IvNknIHk/SkuSGwr/?=
 =?us-ascii?Q?+4xzTY8wkMzaAWrTy9p02r1GydKRTLV2ke3JMrSB6DspsER3NB3kLMZdTk+V?=
 =?us-ascii?Q?kY74PA5KYVHK24IzVXWgEhjTdwzLSjs40oObDMeVNX0WR66MEm2Al+92THVe?=
 =?us-ascii?Q?1h0hBg15hnsTyfyyvhqocjRAzZKzLXt40zcmuL4b6HOn9LLgmxSinuLFGMBH?=
 =?us-ascii?Q?dDhUnJdlTZVzitWFeBoLKfh3n1XF19ZRP3eX6xXGoa9HsOK0jWSQfMgyE03Y?=
 =?us-ascii?Q?vsw+P8TivcYUAzFSl/T4nhgVV7GBOQqMTr967r33WIyTiABWiNPuqXADItZE?=
 =?us-ascii?Q?lXheA/ytkDi3qTVyLDO4bpA0DYPpxxEYgYKHMqEnZ3Ub1nU7+WN7zx4ZGUR7?=
 =?us-ascii?Q?bHngoZMRahj6GDS++ectx7WvvhWs8ZCj/rWeNQpJQpz0cU8wpOKgsVT1JnLe?=
 =?us-ascii?Q?DpxFYPY4cOofX7fCTGpmjmjJbR/olSRIiVo2mq3Vpc6XzV8j8D+kM+8jelB1?=
 =?us-ascii?Q?u/nkdMcNBrAfwTqo0gewuWZsBPIlvtDTHzF+FjpLp9ROhf1R7FdD6a7Ij35J?=
 =?us-ascii?Q?X3pJVLtZ6W4aoosN5D7hC7roMCDJvl+7Wqi/50eeVWIDmnR3vTRZr4MjQf4B?=
 =?us-ascii?Q?9V1pxRal54p81V8UDk0DgHOjHNPurTH8+QRRxQpw/sMtvT5I3quI2UJspWzw?=
 =?us-ascii?Q?1oF0XyLZxxZpJygEJKCYRNrq1GY0I0OHeQTWz9fO6yJoiCuG5L0/rZ3UDRAY?=
 =?us-ascii?Q?ro4XyBp+3MTrbd9KOqz6Hg9kdjo4Gh/Iwie7vSGmAMvRgIwKpFgGuxK4REc5?=
 =?us-ascii?Q?zM24ucpGuEAnytZsS1rhBqDJdzcxGVaDevp24WZ0RiaEh9k/gSVaQO8GsqSp?=
 =?us-ascii?Q?SVzpn3v13A2vpiCz0oDEC/2VUmuzN/Fcmj4VvLxiKHzjSgkvDluOYB3ylFq1?=
 =?us-ascii?Q?l/VSdhAX+UcGWgxaqDmBAehUuBAJubckSKlSJbolvE6gJI+rWluH5ffdCaMh?=
 =?us-ascii?Q?LQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d9ff1a-3c3e-4c79-bb7e-08daa1dde338
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 05:45:59.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHpaAUaO9Ju6iZ+aJ8LeyQxXYlW6h7kCxu4wX//7D7Ewb/MTszquhxuu7Gd3olZpW69PJVLAzj2vgrw3h4Qwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6173
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/9/2022 8:17 am, Stephen Boyd wrote:=0A> This email was sent from outs=
ide of MaxLinear.=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-21 23:24:=
26)=0A>> In MxL's LGM SoC, gate clocks are supposed to be enabled or disabl=
ed=0A>> from EPU (power management IP) in certain power saving modes. If ga=
te=0A>> clocks are allowed to be enabled/disabled from CGU clk driver, then=
=0A>> there arises a conflict where in case clk driver disables a gate clk,=
=0A>> and then EPU tries to disable the same gate clk, then it will hang=0A=
>> polling for the clk gated successful status.=0A>=20=0A> Is there any poi=
nt in registering these clks when they're not supposed=0A> to be controlled=
 from Linux?=0A=0A=0AAs mentioned in the full commit log, only reason to re=
gister these clks=20=0Ais to be backward compatible with older versions of =
similar SoC's which=20=0Areuse the same clk CGU IP but do not use same powe=
r management IP. Such=20=0Aolder SoCs also use the same clk driver and for =
them these clks are=20=0Arequired to be controlled by clk ops from Linux.=
=0A=0AThanks,=0ARahul=0A=0A=0A>=20=0A>=20=0A=0A

