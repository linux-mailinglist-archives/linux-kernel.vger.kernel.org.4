Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749EF6B1D41
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCIIBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCIIAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:00:10 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2027.outbound.protection.outlook.com [40.92.74.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD1DF716
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnqSXUNQHaab1a6G0AiW1wMz3geC5s4+ApOX2IAx6YRTEIHINMg14PJdHZMHekQO5Fky1E1pXQEDP+cyjHGs/b5LiQNHK6BuV8GcQ9qe9uOIM8SeEUSCd3bnObTuv3UPwhLRg7rMEh7tgOlNak2g0tiKTftRU23ZtvTmsFWko6tB9PV3k2e6fb8hlAru03oPTaEHb6kneUEIenPL6tqJqpGTVTM+nNbJr/4bOMUmrJEaXW5symBTOiVPzJYKaeHlV7sZv7PDzOfKM/FjGgL4cFkOyxvrli34VYEcBv90VeMjcXk+EQu/Ym26spUNFmNlLwXEy9gGj6ZnKjGuvyc2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8b7SxGseP+5wQHkldzYve7cq5e4a9ngQSM3Zv9ahzk=;
 b=C9/kSmFg63ggFNGfagMu7OAu62CjzM7TA6Ufz7v83KUeCDjnw7RHd4yDyoDRcZfohLILM1HDBTw5kkcT3uyTTeYgcDXMQ6xaUVoVztYTr75Nrs/ju/4RFxX/fQlP5r0AidX1u3uB2di2E1jJL9kD2qE9IwNq//hW2YXxpKfS3WBC5kejRn/C6F8zyXl0VtdPj4A38/SoweMGxLkKNA3Oc8xG17IIQykr3+J5gfIusf63NQs+E3BQfWjMaZHNLyziZn/0MCn7wKVun+A7YhI+o28Gc6kGQAlQtsYJuIWwmIbYO+pq1YzQoM88+eWOVVpDCPHe6qqh75hckjG4hGNFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8b7SxGseP+5wQHkldzYve7cq5e4a9ngQSM3Zv9ahzk=;
 b=dkhV3q/FIoZ5O0prW6nPzxDqBV4IbBKv7udsrsWm/BF+8ZMDCrB/wfHIn7cQl12DNrtcuF9fe/2oK1U1d9O7Pya8XpZEIoZBNFIUJXAkOLb3N632u3zi0SOzz+Tk9qK9OIHIUHuB/AqwxRvTR87xrvMIVESlzKApt7x3wBPrryk7N4XdAy0v2ZxVsyjp3JhxrLz4aBYIC/EdSKLqgWZxI6v/HGHVrrnmGWqw6A7xUbYe6edQSJRTVJ7G3RBGGHLqzb5Qn5L3cDhUyeapRsR1wbdWASQLHBvN/1QKbWNfl0NUNm7jM1K2AYt8Tmajw1amnutjFdUHZ0KMUB1pt4CVLQ==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 DU0P189MB2042.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3be::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Thu, 9 Mar 2023 07:59:34 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::325a:fba5:af4e:4484]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::325a:fba5:af4e:4484%7]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 07:59:34 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "rfoss@kernel.org" <rfoss@kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/gpu/drm/bridge/fsl-ldb.c:101: possible loss of
 information.
Thread-Topic: drivers/gpu/drm/bridge/fsl-ldb.c:101: possible loss of
 information.
Thread-Index: AQHZUROWy83Z6Qqx6EKYMWjImUxUIK7xh4YAgACLKmI=
Date:   Thu, 9 Mar 2023 07:59:34 +0000
Message-ID: <DB6P189MB056810B266B656706ECF7EAB9CB59@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
References: <DB6P189MB0568FCA97758B820EAC036989CB79@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
 <20230308232224.GG31765@pendragon.ideasonboard.com>
In-Reply-To: <20230308232224.GG31765@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Fq7hAptDT/PK2UcbynpokWA1/h8EpR5s]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|DU0P189MB2042:EE_
x-ms-office365-filtering-correlation-id: b3638ad5-15e5-4777-1fd5-08db20743898
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i96XP+UZ0N4Ro7Ofmmq33cdBz4vDFtIpTuCAo+zmSOpqV4n98QQA7neS8E6VGpeV5Kcy5ZqyWqX329dZ1F+0G8cIVj1vdCib9IEV3A3wBs0Jn3OiVn81IWjL3kCKI+HGFLuL9JjkzKk14kCheoiCONtS31Jvp2x3620zruogDHqiX45nVFZO4c89Rup3gftwtMQmvaZ2cNJExKGSin3MBKJjhBlAOuKZf7sOHIvHqOJY0D2NNJ41BK/TNk0J3jbmkoXcbmizDXUcbZ21wvyxUBrUuRe5386C+embkdUEl8sJ0EkLvLe4AgODdjgIO+IBEnrk/lvgjZze9yXSdMgGirm0H7YEVkGwF91yVENdU/rKzCbwVilVr1C1ui2bfz5ywY1hSEz9WWWhI9Ivrb3q4FTcZxzj6c0p0sWC1ulHUfNEXoVq4GhkrrL+pRvxoRSUai8ULmnuktJnvS6cT0ea6XE+3K+Tl+AlMTi/4NZB+NR6NFUX0M43ubEQxs0fE26y5nAOAspqP+uU4hGmNb8r8gcwl6qIogdlIE70ESBDefgeCNTy6tP4pFbiXH2XbHhGHnmq3hKDmvDXy9H/ofP0qk28yrfZFmQWtQdEuA0SbZmXRqCq1eaXW3/6tJSuC/dRsnpp2/WVQqUlaWUt+u0UVQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9wkscA2rehL5DEyJa3jTl8wUpCFNAJcGX22xbEYAEIjIElWoncAjicvi7x?=
 =?iso-8859-1?Q?WGRVS7rV0MaUoUBzc3V6aHMI0++86o32x7nuLgDSvV7/w9KUSKDLu3FBui?=
 =?iso-8859-1?Q?nfFxPtucq+tCzn+aY2BPdv/G8f3b653RhTeNK2Zer4qShyx6uJncm35m8D?=
 =?iso-8859-1?Q?1x1uB8Z0s3p0O3hUG/9lgvUdRj2fG1qXXvWW/v4VOomoSBAbD56062ru2p?=
 =?iso-8859-1?Q?yY88dGxpendF4aQFiinpbPHEvRwHgaDNxpv5M2Wp4YHVUx1EogCwoGX30m?=
 =?iso-8859-1?Q?iArizNT3Wy5KcI5Xp3UPNLhL0oSzeuva+RFFNkNJsOb7kbHucwEuWkuopZ?=
 =?iso-8859-1?Q?lYBe5ZGVTKdkLR+ALBblzQgDkobGskWQQBuGvVao2avVyv2+TzH8HBsQnu?=
 =?iso-8859-1?Q?43HAdcPtvW/7UGq/fUyok5Uci5hApLJljUb59btiMeWcpcJE252FWmPB+H?=
 =?iso-8859-1?Q?Uaxm3V+Ogk121BMPPATDSLjGTfF4vqIYC+XVxxJVF0FbGaFA9OiLP7zflU?=
 =?iso-8859-1?Q?rWTXgtm9CnZYF2R87oAAfJpKXG+WAkORnFNQAsIFR8LUF2sQ71kVqXXb0M?=
 =?iso-8859-1?Q?BMl1Ug1OJxq6J/M7HWc4hnjiG02kk5y80m2op98zoaODULduvtA4TZdHc9?=
 =?iso-8859-1?Q?3HUJv/MC4Nz5CMaRgH4A61zPE0EzmAdGaKTDjqOIzV3jsJoRJxfZhHHool?=
 =?iso-8859-1?Q?lQtvWr0X3scbAlxWG9NAweeU7qmZcCcaDnzPmkvPZz/9Ch6jEmM3fk/nmm?=
 =?iso-8859-1?Q?FQUGI7EkD08ym01pSKAHsE1oEeKRkxCy8qKeQh7yULORoLbfXVtsHo+lkv?=
 =?iso-8859-1?Q?juEtHs7nJ9g3e2fctm041AdT7c5coT1GSpQR9YNpt7rc/MYfr/KBk/Od0O?=
 =?iso-8859-1?Q?W6Q8I6JX88SNKKZgRl67NMjoEATRiqywkM+B2u3nbJRPblul6sSYY1AOQo?=
 =?iso-8859-1?Q?GX5K8oeH7qsR0l1As3QYaADZTQOVQtlMd+b/+c06n1uox1Cb28/uYT4Jr5?=
 =?iso-8859-1?Q?nn71q+RooA4TFjQKwFtzY4FTK3d7Ob231kZ3GbcX1fGyQJZvjyT3guoNPA?=
 =?iso-8859-1?Q?g1Ho4MExVJ4cQLBYqpeBKv5rRX3ybmL/hOm6Xc4KA8RtQV6EJP4l1GhDhP?=
 =?iso-8859-1?Q?5p7pMHqR6wNyvUj+eVg8PDJIG6k3Zlz7MInd6cQwsYypjXCk/mya1zCOxz?=
 =?iso-8859-1?Q?emKzsM5hj5+yR+P5Ip56TEfVzt65S07/zhCfnKGaJlkEJNhOL9MjzHDeMC?=
 =?iso-8859-1?Q?NRihnShk88Fu3miNUb/YxvKqdSAfiSJ04suGZRT3v7d58p6fo0vQ4Hljws?=
 =?iso-8859-1?Q?qy5F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b3638ad5-15e5-4777-1fd5-08db20743898
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 07:59:34.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2042
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there Laurent,=0A=
=0A=
>We could, but I don't think it will make any difference in practice as=0A=
>the maximum pixel clock frequency supported by the SoC is 80MHz (per=0A=
>LVDS channel). That would result in a 560MHz frequency returned by this=0A=
>function, well below the 31 bits limit.=0A=
=0A=
Thanks for your explanation. I have a couple of suggestions for possible im=
provements:=0A=
=0A=
1. Your explanatory text in a comment nearby. This helps all readers of the=
 code.=0A=
=0A=
2. Might the frequency go up to 300 MHz anytime soon ? The code will stop w=
orking then. =0A=
In this case, I would suggest to put in a run time sanity check to make sur=
e no 31 bit overflow. =0A=
=0A=
Just a couple of ideas for the code.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
