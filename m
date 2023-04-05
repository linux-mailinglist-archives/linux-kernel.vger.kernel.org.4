Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5786D7428
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjDEGIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjDEGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:08:44 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427E212A;
        Tue,  4 Apr 2023 23:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWCIqn9FAWvQyh2Xdsa7wPZyE3hzlRsT3Cmq71n2Foplnw3XU9/dgeVw6OMyJ0CRnaS0a8hGBphtglx9IbhBzDZvsN7+QO/ZeSPLpwrI6EePuLOSvnUZ7f/inojoefpIVdNF2gXw4EWH+YCKfqV72AFAiArO0e6FThw2J93/DTQIibQ9VWf8VAjyzKVUbgyHxOZOADD3MsJ2ILWv0YLyl0VERgQR2abVZVaEQiQdwh5Z3DWzToCm6Xb6fb7Jf+2rqwUj4Ks1y/zFzuEPv01Dw7Rj7uhp2qXcmGKS+3tXrXdfUaDHTLt7J8hZG8ckVAn7Jivn4Hs0hbu3GZwzQR15tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn1R5+IUfWJh6oiwJsqZlehate+V2x6IliHUGAQrfdY=;
 b=k32MYBMCf9WgRtvu5IthYQg9pDKz9ZvgQ2cWN79Uz4kS+a0DZMfjfrDh3hrrG0eLgDLHCsun/DHY3LOkPJ/SpFCCVbCcNQZaeZyv5rC04+qU8VACgnmsn+ro4V2yR8coVivixiMPSyAghtS6geRe3Wo8F1FGax9jFwbRakoUnU5ULMpm8gHs0GsQBnsWQ8G/ZQZp5nD6HnHG2nIvd2OmG9pSKpIN9rs+N7zdTnFUxsmTqG22K2jsz6bfnlVCbV8QJbWnk6f3TiwSJnkgNbDlwDnJbW3oFnwgf9BPbDyebbJjlEQWaRfxfspy/HCjkrSA9QtL4PEUYeaULQ5vE98mEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn1R5+IUfWJh6oiwJsqZlehate+V2x6IliHUGAQrfdY=;
 b=HW5OxP6pCbxNt4nJqxwXoqMljkdc/IUuK2Slr7d3zw0YeEutju6zIY2FhF5R8QQzC9YwVqKjnx56IFg0nSnL/rQarxWAKJTYt+j0urW1mVuDe961hUB7OYXxNEK7Vciwpw41PUM5dJ0D2ckzU8O7IAk/qBWq4MJ0R038FnJ2UCU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8173.jpnprd01.prod.outlook.com (2603:1096:400:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Wed, 5 Apr
 2023 06:08:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 06:08:27 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: RE: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Thread-Topic: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Thread-Index: AQHZY0gufzzLDccxyUW8wSwyIaAovK8apkQAgAAN0RCAAJ1igIAA8IhA
Date:   Wed, 5 Apr 2023 06:08:27 +0000
Message-ID: <OS0PR01MB592238D5F77EC74D1EBFB78E86909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
 <OS0PR01MB59224C99770F84D8CE2D0DBA86939@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZCxFUb8+eQPzqBmo@infradead.org>
In-Reply-To: <ZCxFUb8+eQPzqBmo@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8173:EE_
x-ms-office365-filtering-correlation-id: 9ca00b90-0560-4563-2f00-08db359c2c1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3m882kjNpMN8LrCs1leljyD7hYGfzOGoNCtZVUCx1QyLBQ+jWfj8p2drjUiTdT9hgHPWUxLerAOcbxWDhFBCKC9zFsVfuyiPFDd/BlEjjIVPp9oTRw+3KwDLI+JBggHwvEOR7xG0wSCp+pJ/GXSj7Q2aa58RlncruQ6vfUQwPhcUmvpgIRmNuJ9uBuWYaRyDavxpOjcL8IXneQVpO0K7wr46IpSYPQiAIxYI0HqD6l8xUTUVY4Lf8E5sUymhw7K2UkwqsrpqAVvGKjqizo312d1KcOsQyBPJMrD1JqmKrG0Z4zfGDUcbMiQHuxzsI8C+OcDxT7nL0Re1ABGZgqr3zGgVgAbsq9Vrs+u5/4gdTOU+hO5mntC1hoD+5xskZS1gQPlOdCP3KJpOcDroRbICdhHw7OfmYUYc3XL7ntRTqdh6xlm8S4izhwZpqdWVBh+KMC3OLW/P95doiTJac5oMf9eva1mE2zQC8XyiMBLg1S/gOugNGfglT7/WPfXPMdqX2l2MkDPpZ9UuBkPTYkQ+YvgFZLMu89mgW6cJewx4CAuoSqz56C+YeCRZ2tRuqyfArPQTCtToVTKM4KQ3umT3SdCx9VyTzB3XxWDAwDXWOqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(66556008)(26005)(9686003)(6506007)(122000001)(38100700002)(41300700001)(7696005)(71200400001)(186003)(66476007)(66446008)(54906003)(316002)(66946007)(478600001)(7416002)(2906002)(4326008)(64756008)(4744005)(76116006)(6916009)(55016003)(86362001)(33656002)(8676002)(5660300002)(38070700005)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RX8GxbabGbg0SjuDlJclS/BRMmIakfG4MN540VnrJRIILfLZ33nbIfTCYVkS?=
 =?us-ascii?Q?3hN+8xjrP7MgoSoJ2ScRlDP41NDg799wI9vBsMyZ7NoT0BRsGoS2Z9oap7so?=
 =?us-ascii?Q?/TgMYZswzj/mvV3TCtorkg1+E83WHopZKIZLPTOZkMypamL9zE+g49XDQ05E?=
 =?us-ascii?Q?vPdZia7s42Rk3yNzAN1E9Slz5gC3eQ4x2X2Ym1ZjXP1B8g6WFuT0kk/OcN7P?=
 =?us-ascii?Q?t1fRABO8EFcThe3vgkmIwQYavniO6XWRn/JLQBVjLTimlI9qnomifUgcvh0j?=
 =?us-ascii?Q?GlPFVvk9ZazpQZD0oHWfGJTohpTGZn4d+z7ZQoXYeSThlJLNeemC27Jp6ZZO?=
 =?us-ascii?Q?VEs21o0M09JOd9Ua1xffLYVl3u2C7o/43E4R1LMk048JLQQ2e761JT/AaK0k?=
 =?us-ascii?Q?DzdegWE9A5XsXyi7ECBwrWL7W572O0+1+WLbKwqh+fL5dLNnPQocvVWz8j1U?=
 =?us-ascii?Q?mDhO1t0oDGB4hcthSOEgJRtdiSTGb8j4VpfwVu/cdFe0a71dCi3mWQOB3RCb?=
 =?us-ascii?Q?CNjq33+Uup4G8Zn8/7MqzNsXcmNXx2tp4V7ZkYeLh4THIxUxTgAKka7bpVIP?=
 =?us-ascii?Q?gpr/wR7Gt4kqNaT6loTTmi/WiOsXyNBJrP0rbXX+YQUYH0mBykPjyNUulGBv?=
 =?us-ascii?Q?Cwtkj36qLGSb7wFc9JG9jmzIiqkmzUv7k9RLlpVfUg5LS3Zp1eWqIOeqg3ii?=
 =?us-ascii?Q?fFyoPa3TCEPyuSebimeUbe5XmExhu88+D1FK9MYxGUiPMxsVYhB3JdNF0piZ?=
 =?us-ascii?Q?SXX9YAyeVSVyx1LWo0N6QhZcoak/zq7hmWpWtV4T1frtxA+reZrgZeMZ/dlc?=
 =?us-ascii?Q?SjJdsJuHoGCB4o85zSwaqBS2NhNhAERhL6jqyXkbLXmhG3fXUpHaXS88OXAp?=
 =?us-ascii?Q?GDwz8I9p3ox2c8e+StVz2+hFlvtAoaIijreOyLt9iEuNELobItKOzO7Yfb1a?=
 =?us-ascii?Q?+18v/Q0Kudwyv0QJcxG3nkGITukgwtFqs7D5ibLwHDPfYWWIQjSpDH+uZNOU?=
 =?us-ascii?Q?1uEoDF8f9hLI8HZEReGR67ne+ZhC2TNEDMX179Wtr7x+aBxASz4nB3oPaXTF?=
 =?us-ascii?Q?81ZrW7so08sZPc0A93RVlCRPIUi38aCt0FtHwrc46MGw43frXYAkvKnxefZZ?=
 =?us-ascii?Q?N+MIstmVYd7Fh4cCLnxiAMbImYio7xmxLSE7rqNrbGZCctomOrlPUEr1LIJy?=
 =?us-ascii?Q?W8PMnCWPj6pwRYS6YGZzjofdVUUrDiuJ8cP3aBKHULChRUfxIa7A3yuNAJUG?=
 =?us-ascii?Q?i+HwxKF1+VZipmS37dv6DTo5aD+bYs4mFFu4mQUwRJU1K6uUtIz69zmM8qbx?=
 =?us-ascii?Q?H8HbHMxx4GPhQfIMDlvvnxv2aWWoFzjuR5m0t/aPV1Ws9sLxP6HqO8V7JoiM?=
 =?us-ascii?Q?GPrsvIdxInnngmV+r9ndh0fFgdYEpZoDGgkSnq0dJ1bxGgH+mrQOFcF+jjHr?=
 =?us-ascii?Q?mZcHD7PQIWz1utowqD0jbDitTCZko6TSrwvpA/1kp2rF6cDmaC2+WfK6UJXv?=
 =?us-ascii?Q?XT0D63MR0MGoP3fMAO0CzoH6AK4UCap3NDrC84SJH2fkFtlHQyV3I99AliaW?=
 =?us-ascii?Q?qw8Oub4E9YF+lBZoYqUbl5O9N4QjM2EL67BTClqe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca00b90-0560-4563-2f00-08db359c2c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 06:08:27.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cH/0lqbHunSKPfykJ12YsVSv/v7wqWevVC8ttxdFIQj+jdHxp2LQf+1cwj2hyAU5kG7UKP+I7yCDdL7xyn2srtdltbGC/yLzEMRC+cL0HmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8173
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph Hellwig,

Thanks for the feedback.

> Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using
> function pointers for cache management
>=20
> On Tue, Apr 04, 2023 at 06:24:16AM +0000, Biju Das wrote:
> > Just a question, how does function pointer makes a performance
> > difference compared to
> > ALTERNATIVE_X() macros?
> >
> > On both cases, we are pushing function parameters to stack, jumping to
> > the actual routine And then on return pop the variables from stack. Am =
I
> missing something here?
>=20
> Indirect calls have always been more expensive, and with the hard- and
> software mitigations for spectre-like attacks they are becoming even more
> expensive.

Thanks for the info. I agree, it will be more expensive with software mitig=
ations
for spectre-like attacks.

Cheers,
Biju


