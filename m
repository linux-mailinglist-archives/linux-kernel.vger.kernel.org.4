Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2645FAE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJKILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJKILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:11:12 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 01:11:07 PDT
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E6855BF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1665475866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TEVqN7LH5UNHe+CL3lJ7h6goGAQTlF7P4mM/r9FqHy8=;
        b=K45jJeuB7gYd6SgRdRhUoIrPktyE1WojCeZSmv4CDNZoroiagCdWUclz8eUrjhF9eLTJTW
        t3b3w1r0CHnQnaqIIxjvQZx4GW/mnOXt6YfDY6u777S7G6vFxf7h9/CL20qHBHQAyzOkGS
        nsIrqbV99trd/J9fOhx4yunMWUouoIIQ4TXzpTDiLs7v12WXyleLFZGVtY1G2Fng3XyHv6
        OugWVOVXGt1u99K9oOaUN8YXDPkYgISzYLbT3Piq1PZBV7EFv8NqQJj3q/f2FIKN6bkVpA
        m/z6mMw8qkhDHjNCEg3i2RttzvU67MuoxXw3JK6Hfj3euTC6rhgzq5bz0Ll5eg==
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-0RkaduPiN-OaT9ZSNzJ_DA-1; Tue, 11 Oct 2022 04:04:20 -0400
X-MC-Unique: 0RkaduPiN-OaT9ZSNzJ_DA-1
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by SJ0PR19MB4810.namprd19.prod.outlook.com (2603:10b6:a03:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 08:04:17 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::9e9f:b560:8eab:cb1]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::9e9f:b560:8eab:cb1%6]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 08:04:17 +0000
From:   Yi xin Zhu <yzhu@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 0/4] Modify MxL's CGU clk driver to make it secure boot
 compatible
Thread-Topic: [PATCH v3 0/4] Modify MxL's CGU clk driver to make it secure
 boot compatible
Thread-Index: AQHY2J37XmJGGcOb7UuL1GQdLj72uQ==
Date:   Tue, 11 Oct 2022 08:04:17 +0000
Message-ID: <SA1PR19MB4909F6711D45ADCCA6360A4FC2239@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <cover.1664958833.git.rtanwar@maxlinear.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|SJ0PR19MB4810:EE_
x-ms-office365-filtering-correlation-id: 43838cda-c651-4895-8eb1-08daab5f31e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: BK6Q5jWcXHe/GVFIzyafAQjbgO03gGlNN7dHNjroaUH/5DsoGHS5HuabprW2Rsfu6iSTK2uxZGJxvVvIAEsEJcPQENCf5sCwa4OqMQxavuynennN3MVleT8Bg+5MDnetXsiYqJVxiz0EbFOPim3yDSLSmIoQ7PIiA6eQoBkDDM7dUWTZggIPXMBOMR1Mae2+3F1zoaIzTVk9comVFRLKXOyodrDmhuYuKh4zla7KOtNqCkt74CWxxsCIE6afSE/9X7kwG0CxJlCLSDokSRMvgqqAaM8S2S6X3bCmLmggo7UgayLCRZ6Y5nIE78WQUAzMBH+Wdo/BZ2I+pDJOAp3vsy5A1fEF2Wx8TcMYDmbq8egiXQBkqNmAmNovWMad9abFn/xu3Y3GnI6PhqI9BE8jBd9LU1lpWZ41XesX/26G7wpasSUmK5/wjyxMu6QjFgU5v8ifEeCyJwYT0l4jERxwEZvBt1tnJoyBjC+zgbMh21bVIgweeiQQ0EIGE28TPFDKUt/+XcKBQObDpGl0xAKUt9yyDLERvF4IWtrQ+0JD+8YYHyvALyIDqQdlw3oSqQO2+HkI6H0gkwHKONuTJztn4Bh04wrHlsDZHHqY2LTffXWP1ve61VkgatTyboRyNo6SabGlQkLN73Roiu9DvvnSeqT4f6exSacMSe86/5LnGHGRw1pJPC9Ds8I8uUkYSK0lHaXhBwP6AjC940S4QGHpINecyTopAuHwpEy6zkJwHJF22lgNdr1o10jc5NycH9W11TDvAgGZRH14tipxHEgIrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(451199015)(86362001)(38070700005)(33656002)(122000001)(38100700002)(26005)(9686003)(2906002)(83380400001)(52536014)(5660300002)(7696005)(107886003)(186003)(6506007)(53546011)(66556008)(110136005)(64756008)(4326008)(91956017)(76116006)(66946007)(55016003)(316002)(41300700001)(66476007)(8676002)(66446008)(54906003)(8936002)(478600001)(71200400001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dTICZ1mr8QALAGUNwluuymfmTtNk0Quq2xLej6cN7KN8lcydY8PatOoObMq7?=
 =?us-ascii?Q?jknD/PcHEOJ3aWy2iZvwYQhQI2FMNhPKfW5D6DUvB6vNEK3hEJ9mCHN5CLOK?=
 =?us-ascii?Q?TGa2tMkCqzjgosMhTAIk1YLWhffXL123HReKyxsWshOnPyZ0dt3K1N2oSyte?=
 =?us-ascii?Q?2Mwjqxw1r6k+AOIFJJo9sGup9HWyqP/i1TnCGVnCUFYaRtSk/7zxvW+3Z6NW?=
 =?us-ascii?Q?S2NcKF0a3BdlvSqM1/LdaweAXjpso3X4b5Nij7MxBiVe95N2nWrZNPSrV6fL?=
 =?us-ascii?Q?bPo8hdNGmCqUlg9TJMj+e/GpVteKDKbYOUeuq+fU2bH38MNN+N33VSTz7liC?=
 =?us-ascii?Q?WyU7msD803jjIP2qd4dQCvcusVOFsses2Bc5yx7AZyTrFAEECS2wXtR7gCzw?=
 =?us-ascii?Q?J7g/LPAG0oSAZuzdrLmAEAit/xPjPWxZG2GjDyWI0A/7PkceFQvxq3zyfKYV?=
 =?us-ascii?Q?WhfVP19YtWNW9s9xi3TC4fNFUK41b+ZWBaq4fj8+cNS/gjrRwEWF2ArovNyz?=
 =?us-ascii?Q?KNSeMUlsTTS8XXPaIjxndniUqmsfT5pzMxQplq1oooj9+JmJZ0rcNRuio8n7?=
 =?us-ascii?Q?OJIK3H0k2mDvJAFfV2vvuZCsUKy6dI1juDiKt4yNY7+7Y25Hz3HVt+yPz8/C?=
 =?us-ascii?Q?R3N1pMRDMIwI+AA83U6u5khsDIPgFEXF9oNgey4jjd9bKCTMF22bPyeyp/sZ?=
 =?us-ascii?Q?Pp8mdsSCaWSLQ49lB7qwFo3pZTmk/jR5XS/Z/b/zK6pRy1dUQ2iwtlvXBz33?=
 =?us-ascii?Q?W5bzLng8Sx5hF6/G+akiBIsCMAkzhxGrzH2As1vlO4OwmfMQId2m8YzrMpFO?=
 =?us-ascii?Q?KWR7ajpg4IrYWsd/ohU15vkk8nUy5o8Kgo1pYjevIRMLhY+b33hdVQEQoRGI?=
 =?us-ascii?Q?X3z2fmfe6MimpLE7Uso7OLni6LnowaZrUajQJGenDX/lGkqG8wkZFG8Giknj?=
 =?us-ascii?Q?GqU+gUA0892i3CXduZHX9YspWFX4a4PC5TerubJlt54t/S7CDaNh7Z0IRb2i?=
 =?us-ascii?Q?jzKMoAyaOvmVp0KDYqCCqrMSTzlGP71YkJPF7x3M+bbv8qQrLcGWUslY1tk/?=
 =?us-ascii?Q?V4VuedSFM2VuBIc+5ZNWDg/pKjc7VmWMD65t1AgfKVQTfqWNcWBXUYDzFxE3?=
 =?us-ascii?Q?Rl+HFUTW7xZ6szgFVrCrahXLf5ImVvTR9z5hMAJkRBZgXe8OI5lqw2hsuGRg?=
 =?us-ascii?Q?3JEwBOf5rmvftWO10zpa8fkCO+3tk3FYBYdu7VlDY1qN9qcXAw/8+qKlZCNq?=
 =?us-ascii?Q?lBQO+gTgIvthI3eYVMPtNy1n3jucfCb7Q7wWKRFAenC7TYQga4FouWqQurCa?=
 =?us-ascii?Q?DaPNhTC4v/4mszwo9S7/jqoSy2fyNu6Bt8ooJfnNnUVbfcExGoJcNUre7qL+?=
 =?us-ascii?Q?kr9zsrfaxTAi+nIo3SLv0cdq1J6Zm2K1htHihs0JWqH/zGUgrQwdKudyj4so?=
 =?us-ascii?Q?0+FoE2fTKr0e4gu8u+QS/X6UdSRrsHBor4SGnsV7Qv+Sam8LoZpgPgvv1uLS?=
 =?us-ascii?Q?VpwcQ2+kahyai4aXteVbX92KziKtJkYSfv+U5WpRsyjz+utPgPMpUsQ1kZUr?=
 =?us-ascii?Q?UNS//0mrNJG3pdWE6GYQHv/XfPVLsCAZVUc1Ob/f0BthWScIW9EAy0HpaQPV?=
 =?us-ascii?Q?4g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43838cda-c651-4895-8eb1-08daab5f31e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 08:04:17.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6GOXZoht4FFkq/1X+A4IqxTJBR/MmaISY3TW6b12VI64H61JV+Cbo7rdy+3uv9fVzt7hj+aW6ky1AWdyd+Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4810
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/2022 5:36 pm, Rahul Tanwar wrote:=0A> MxL's CGU driver was found to=
 be lacking below required features. Add these=0A> required lacking feature=
s:=0A>=0A> 1. Since it is a core driver, it has to conform to secure boot &=
 secure=0A>    access architecture. In order for the register accesses to b=
e secure=0A>    access compliant, it needs regmap support as per our securi=
ty architecture.=0A>    Hence, replace direct read/writel with regmap based=
 IO. Also remove=0A>    redundant spinlocks from the driver as they are no =
longer necessary=0A>    because regmap uses its own lock.=0A>=0A> 2. In MxL=
's LGM SoC, gate clocks can be controlled either from CGU clk driver=0A>   =
 i.e. this driver or directly from power management driver/daemon. It is=0A=
>    dependent on the power policy/profile requirements of the end product.=
=0A>=0A>    To support such use cases, provide option to override gate clks=
 enable/disable=0A>    by adding a flag GATE_CLK_HW which controls if these=
 gate clks are controlled=0A>    by HW i.e. this driver or overridden in or=
der to allow it to be controlled=0A>    by power profiles instead.=0A>=0A> =
3. Fix a bug related to missing flags in one 'dcl' clk entry.=0A>=0A> This =
patch series is based on below git tree (linux-v6.0-rc1):=0A> git://git.ker=
nel.org/pub/scm/linux/kernel/git/clk/linux.git=0A>=0A>=0A> Rahul Tanwar (4)=
:=0A>   clk: mxl: Switch from direct readl/writel based IO to regmap based =
IO=0A>   clk: mxl: Remove redundant spinlocks=0A>   clk: mxl: Add option to=
 override gate clks enable/disable=0A>   clk: mxl: Fix a clk entry by addin=
g relevant flags=0A>=0A>  drivers/clk/x86/Kconfig       |   5 +-=0A>  drive=
rs/clk/x86/clk-cgu-pll.c |  23 ++-----=0A>  drivers/clk/x86/clk-cgu.c     |=
 122 +++++++++++-----------------------=0A>  drivers/clk/x86/clk-cgu.h     =
|  46 ++++++-------=0A>  drivers/clk/x86/clk-lgm.c     |  18 +++--=0A>  5 f=
iles changed, 82 insertions(+), 132 deletions(-)=0A>=0AReviewed-by: Yi xin =
Zhu <yzhu@maxlinear.com> for entire series.=0A=0A

