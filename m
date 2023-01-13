Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978A669D32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjAMQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjAMQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:07:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C92CD0;
        Fri, 13 Jan 2023 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673625568; x=1705161568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nsnTd5Mb5SeJwtYcj509q6UelpHSIjU6Jl7GbxnOlzU=;
  b=fW3lHOTebjzn3/o1K5cp1PPlvTdqeFMFu53sooL2V6eXKaRqwHem/6+N
   mdo73Y4vLDTxx3jvwX1prGmbfMKjOm7dEjNFvL7SpXtzpE9nGVpsou0hA
   Kwmm8s3xWLfbvbFzwOQpjJuFNjvfe8qLBcztV9n40VOa3JwwCeed7YWlM
   UbycQZYojXoti3sa2uoNcB6JfjRvGT3LIOfh0ogR/pwyc6Tesf2uEW8gI
   jADbEq7FCKbTyI68hnAgYXZzfSVN17JQ3CDNaxYDbqSn3pHWwdQzllwCT
   JvsbtQ5lux5O/2++0NejelAPNbvOR3mYS/5QJKyTZoaBebg7pRazFEPLn
   w==;
X-IronPort-AV: E=Sophos;i="5.97,214,1669046400"; 
   d="scan'208";a="220850390"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 23:59:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzgumCUPTehDPhAHc2zUyB2wIkHeiPr7jnoGdXncG2/AiFAyD2dPI2UGjhGifTYalS3Scff6omU6PRcRhq/kuHPulBJ6S5KopAyvOLiidgE6DjsadLGOL6r06QXNP42ZZYpBBHq9zwZgwrb3c9gLRJomyoDbzFiNMTcu7ZwQ1gVkvgkMQ1ItPYj+NJyEhL98I2HMfUCTiCPst1jxPrrLSs4dzE+idewwbyP1jg6oEUBIC4wwqZJUEIxkwlGU+WY8lA63RPRJr231f8XT5DY/jORsAiCPfjfw8+929C46091UkMwqBW9Kjr/6ejVbRZXWlDpSYBgD4PS4YVof01sOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFy9iZI2lrIkfgqwX25yLA9aD6emh/IhXiDS1gpoW8U=;
 b=e8+5moi99A2DZArqXmDI/Q4RmGpRb4E/5u54DX4RwQ9m5MV/jJapzChihGFBl+0vgTDblumG/QOm3KFCDJECtV+GfNBR3eAksXNFRi9J7NkNOdQr71RQvHmvw+eAn4kRJ3SZm/SWJR8wniv78kLc7kPwe6j88EN4bxTdQ5ZegtTr3yve+nkoqz2VOs5Y/eiXjgHuTD17BM3PAAarLnyhN6TZ1YpZ3dhrYCRYHZr59bD0GsOANlboGuMFzxX4SKYYNGH8ygbFpOCqUwl2x/PbtYOPA+6BtooOeupibnL11eCyOb4LiY+lgFeHtEVY/uTKRkLdtsqtEo/n3Q4bbVNN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFy9iZI2lrIkfgqwX25yLA9aD6emh/IhXiDS1gpoW8U=;
 b=Vom9fYFwGzAnYWYq5AlyegKonnDWzupeBXTlJoLpYzxf5mNLf462nXaAmExuc+XW0F4ht6gro9qdp+WAVs6SojvxFGHU/IfM4bTdgLg7atiw3kRIK8fKNg28jeSh8CJbM9UDVlVI2+JEPRtP1xQzNhfzuUcu+RC6TLMmte/NAd4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB8196.namprd04.prod.outlook.com (2603:10b6:610:f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:59:22 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 15:59:22 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: linux-next - bxnt buffer overflow in strnlen
Thread-Topic: linux-next - bxnt buffer overflow in strnlen
Thread-Index: AQHZJ2f/gKNU+8M62UeB3Fw1KFx0nQ==
Date:   Fri, 13 Jan 2023 15:59:21 +0000
Message-ID: <Y8F/1w1AZTvLglFX@x1-carbon>
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
In-Reply-To: <20220920192202.190793-5-keescook@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB8196:EE_
x-ms-office365-filtering-correlation-id: 3d6e4bd7-47a9-48e5-810f-08daf57f22af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrHZJoRM+Xi5EBNz8V6LyXd4+8dWRoEF1fPl842Qn3M4Qc9o3MLaBQYPxhvfB9ND4H4PiQN2j+BImNt7sGku06iSK58lJ5uaV9+tKpviAty2SsTC5sw7ffM7uqIxImBFVBpaJLSVxWf0K8uiZp3o6NgDXEDXcFCglX1o+jhGy/ReUI6fgaX4OgY2f7efSc2UthkUZnwIitocnKeaVFPN9CxIvW8xoQdXmSo326Ud252Qo3HUKno7n61YXZBFJNzMtRkQkxyuV623usyywPfkIahKru0fL8nRf/IryKsFWT/XB7WNUsC/rjXwiaZyEZZlMxtJAY8A52GuDwBu7IHg8nalWSELNoLNlUTUc9nRsTm+RQ9GTV7+Z3mGUOLpeXY0NnKwa4kzpRhJ4x8y0AVuSaT2G1SjsE1ZPGeZeAd12JMjJOOmfT5qLOfXwpQJya0LkfGhQcwK1jR2o+B4B5PsXp9o8rX6Lzqzg5ATGKzsX2PYXquIWfAVo1QkpTYvO6/ydf5eOVPlb7Dm2sEvWSl/dzz5LW6Vv2zGHCoSDElCWis7a1egb7PCcl7tMjkjBIb0bWUGrZNR4oYt31q5sBCue7PRo2UbcMMMZFqweHwrdbhnQ+Q2t5EHavswxdPI308DoHuX9jvNN56XSJv5KVWFcAmd/VBzszFSCiqgxSIwJo0CXQmCxg0n7r0TN2lrboIHeCMwYu7ZjdjqOhZ/7BIkZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(6506007)(6486002)(26005)(9686003)(186003)(66476007)(4326008)(6512007)(316002)(45080400002)(6916009)(64756008)(91956017)(76116006)(478600001)(54906003)(71200400001)(66556008)(122000001)(38070700005)(82960400001)(86362001)(38100700002)(33716001)(83380400001)(66446008)(41300700001)(7416002)(8676002)(66946007)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bAjnbjF8uC+1QIcTh14KwxOkQ2GwjrXDI5yLWNz9YUGQUismNAMe66mNI/GU?=
 =?us-ascii?Q?RII2HnVX61Ppz5PXctIcfcB6CNpLqpcXEx32rCFlo1CQr6XKEKanDzACrxnQ?=
 =?us-ascii?Q?YEDkwMb1BkTxha8E+RIpmH+q9aUyWEIvC9gPv+Md2fyu/XCwd5fs6qxvS/RM?=
 =?us-ascii?Q?pZHH0tX085rpkDQwyPhwKYUsnuJsnKqDFWyb8Yk171C2G/4yjaWWiNanoo7p?=
 =?us-ascii?Q?tcg8DAk+o8zdTHg8VrSA2ZAM/j+u711Inr6r6uK7PddIbW/jDEkIJ8Aabm1m?=
 =?us-ascii?Q?+Oy9qNuoUR33Kae+T2vO2hQM7O3mfTDunMDeBU2ivxJBbCcYU1s6nslnTV7L?=
 =?us-ascii?Q?pQIViCls/M320jfPuK4GcLHo2/MbHBXHSyHrt95j00dbxuXKqTCrNaBbUXmA?=
 =?us-ascii?Q?o/SJxPrFCTMQWviKHoFYgUww5DwI3LwxEgwe4Pa0YmUqvGII8ewVKwP8/u7G?=
 =?us-ascii?Q?OpcZOxc9vr2S+WVGe2UixQuJ+W6x6H7JRA0j1aOtNmTGcgvjpkK2Vu1xDyTk?=
 =?us-ascii?Q?GavCL4CdBBgSOD1PVU/MhqKjG1WkEoEIH6vxEzvc9zqJb+oqSKtnypMTjscj?=
 =?us-ascii?Q?aeYkkuIbxS/ITPyKVCXyscMYUHZrQzi8WzYYOIMNmqjeaZyZUrSoNYERZM/5?=
 =?us-ascii?Q?w/w4NdmlkFjrWE8jyx3+UTFNHSoqQ8Atdn7aN+knsbLaT+7b1T0t2S3TEmrz?=
 =?us-ascii?Q?R3t7yWtffMuKV2UO69F+lBLlJHlKhNIs9tOgYGwRLt6726To76k6ovVQ34Rx?=
 =?us-ascii?Q?2efnP5N2lwipsoYVxfxGMCiT7cwSNkjj/Ia97WSftlzIdgYOFhqd770ws71I?=
 =?us-ascii?Q?7J15aQSmdtLHjgD8vtw0qROYTYAJMUyKBRiifkJ4yihZvWgGI2v97UodHMOa?=
 =?us-ascii?Q?FvxgRfoaZmmJF/9baiEfVLr5b7QP6w456cCltx2Mz6Cm2oFYQf0K0LFSUnnS?=
 =?us-ascii?Q?HCPE+qRVOeOSEQI/A452puv5SBK8KAUhi94sh/lm/V9wnkeB7e4hXTto6BMT?=
 =?us-ascii?Q?rFXjBredFMt7tW80vhWqnpYBVSIM0td5ntPkHv32HtN7yy5Ov+UnEH/te5Oe?=
 =?us-ascii?Q?e6G3aeciuVQu325irWLFACOnt7aVGVQrWPcfNScYfovdzIxl+dK8m1X6wAzj?=
 =?us-ascii?Q?ujIuQjn36cAX0Xfjx2pc45NU9rScQiDmOsxYETfwUgeQKpUiKDNa3z6LDL+9?=
 =?us-ascii?Q?IHR4XMWOGvJ8ne6RkR+vg1Z6yIGldTe8BsqT1/XVVf0w1P3QEa/ykqLPGNig?=
 =?us-ascii?Q?TnuIQRt01Sz7YUgruqBeC/xmdnKlzBSChOiJ9gD1vAzTWOvpFX0Ratpkg4pG?=
 =?us-ascii?Q?MVo2JPDoRGciz2J3O8IfLI74JzkRzJdvNRiEGLD6NgAy4GsMukewEuEDZAfh?=
 =?us-ascii?Q?BBcCDkFA6UeS0+gwevVijXNnPgKrBDt8NK6yOdPjA2yYHhWrqrv/hWXkevjV?=
 =?us-ascii?Q?myOLR7yIgd8+72tQBOTg3C8gEotW87Wv2sYm+m6lMdXJwl8krpvAKkrCNKP8?=
 =?us-ascii?Q?5gM879pZwlDqlJI0DOs2ZOtcn644815i/2ZN53jvvAd2r+/2RE3UFyWuT2lF?=
 =?us-ascii?Q?N12pP2T5WVdxDEFoyevUZxblPkore60zrY8wafrEpJp2PHhy5vMt9V4a8zXA?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E31EB9F3E7E645459B4664915B599725@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?kdIRrbjXpXuVCWL/zVx1W13u+KsYNBxAirQZJ+7Xa+m/lamnSPIdN4cE0nvm?=
 =?us-ascii?Q?lF0IcI7Gw7dUIrwOijmMulQyB/jI7A2SA0s9Q9skvP8aj35rFM7LoHafbQHS?=
 =?us-ascii?Q?zHKGjlgwvypBWTVQk87ejxcsVNMRwRBYP5JOd95nWtsrujmjh/DfV7AqEZ5K?=
 =?us-ascii?Q?yN/uW8ODiRYruKsH+Em9Smcu/43uZx3+siEVd3TZfypMtgYH4mQqzuFRlC+e?=
 =?us-ascii?Q?VaFSWASb24JMtj8x7005IIas12De6B+CMfPYCOz/3/PAsEQhycEyMWnhYHcr?=
 =?us-ascii?Q?ODb+TWIqsXM4ehEelEXSc7SewzcYSMI/B1gvEIaJJAiJ1tcR85YQ5aQUN5dd?=
 =?us-ascii?Q?tY84D8efL9B038RnggGrnErC9vSozMZ2lK6LljCZIpWdneObDpAHwnPMeabH?=
 =?us-ascii?Q?owtp8x7I/zBj/DK9nA+xWPCyinddf8vwSy3/+X6RAL5hhPl1rp4pii74dXW+?=
 =?us-ascii?Q?jag4qfZvyIQZTt5ueu4E9HVQYx0hYkwKXDLW86XtFi5HnTtAPRb5vLxiz8P+?=
 =?us-ascii?Q?PWDQ8GT8qYThxr7J4KRoyOLoUC4D3fFbo9sUPLPzeV7mT9oW9Bj6H88F7wr1?=
 =?us-ascii?Q?CnoQi935WNf8tewA9L5/C26MivlSJEDR0fIEirl+kUOO2boEC50g/dCO/gzT?=
 =?us-ascii?Q?j/nM/PKxCz1Up9raxfFFCimnLgJbetWfaRGBsMo/QD00uDQvw1JyhjkIldB8?=
 =?us-ascii?Q?AzGfJ5f99OvpLVtwd60iHScBupvNW1YiHsevqPayaDr54RfNDAP2YDnh10rK?=
 =?us-ascii?Q?jZpIZIDHqyk7Gq0D2cCVVpPxd+T+ErwI2clVp88uI8o6NXtA9Mtm8iOWeG2y?=
 =?us-ascii?Q?LZHS+vzPax6wsQJr3zBy3WzCl9Z1PjniosmmtsA4S6h4qD7rHKbg+DeODqaz?=
 =?us-ascii?Q?TSW2a5pk/jb8asDPpKc7jap7DwRHX07lp0KVQhRtCieVoLwp5XPwJHYbsdvw?=
 =?us-ascii?Q?31InQk+M1nV9T4jBL+SZDjFFrTzhXaYbNg4n9kBjoNCy/AdJbUJhSeLqaMy5?=
 =?us-ascii?Q?YHkAU1e/J3FaCfZW8+OIbBngxI8uha4WWgO5RcFG14M60E0=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6e4bd7-47a9-48e5-810f-08daf57f22af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 15:59:21.7300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ToNCJF0pE/giLIq6OlQzNiT7DYgukXtqjC4yZJAXikLNZ8HH18SeH6KvpNAR63jZJ3MqI0qMo7wlBqxFPa6jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8196
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:22:02PM -0700, Kees Cook wrote:
> Since the commits starting with c37495d6254c ("slab: add __alloc_size
> attributes for better bounds checking"), the compilers have runtime
> allocation size hints available in some places. This was immediately
> available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
> updating to explicitly make use the hints via the associated
> __builtin_dynamic_object_size() helper. Detect and use the builtin when
> it is available, increasing the accuracy of the mitigation. When runtime
> sizes are not available, __builtin_dynamic_object_size() falls back to
> __builtin_object_size(), leaving the existing bounds checking unchanged.
>=20
> Additionally update the VMALLOC_LINEAR_OVERFLOW LKDTM test to make the
> hint invisible, otherwise the architectural defense is not exercised
> (the buffer overflow is detected in the memset() rather than when it
> crosses the edge of the allocation).
>=20
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Hello Kees,

Unfortunately, this commit introduces a crash in the bxnt
ethernet driver when booting linux-next.

I haven't looked at the code in the bxnt ethernet driver,
I simply know that machine boots fine on v6.2.0-rc3,
but fails to boot with linux-next.

So I started an automatic git bisect, which returned:
439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when available"=
)

$ grep CC_VERSION .config
CONFIG_CC_VERSION_TEXT=3D"gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)"
CONFIG_GCC_VERSION=3D120201

$ grep FORTIFY .config
CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
CONFIG_FORTIFY_SOURCE=3Dy


dmesg output:

<0>[   10.805253] detected buffer overflow in strnlen
<4>[   10.810683] ------------[ cut here ]------------
<2>[   10.816035] kernel BUG at lib/string_helpers.c:1027!
<4>[   10.821753] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
<4>[   10.822737] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3-next-=
20230112+ #4
<4>[   10.834787] Hardware name: Supermicro Super Server/H12SSL-NT, BIOS 2.=
4 04/14/2022
<4>[   10.839875] RIP: 0010:fortify_panic+0xf/0x11
<4>[   10.844962] Code: e0 e8 da 83 0a ff e9 31 45 6d ff 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 48 89 fe 48 c7 c7 78 69 d6 9f e8 01 ea fc ff =
<0f> 0b 48 8b 4c 24 18 48 8b 54 24 10 4c 8d 44 24 25 48 c7 c7 b6 69
<4>[   10.865321] RSP: 0018:ffffb547c005bb98 EFLAGS: 00010246
<4>[   10.870406] RAX: 0000000000000023 RBX: ffff94f0582bc400 RCX: 00000000=
00000000
<4>[   10.880584] RDX: 0000000000000001 RSI: 00000000ffffdfff RDI: 00000000=
ffffffff
<4>[   10.885672] RBP: ffff94f0582bc424 R08: 0000000000000000 R09: ffffb547=
c005ba60
<4>[   10.895849] R10: 0000000000000003 R11: ffffffffa0182448 R12: 696c6666=
6f282074
<4>[   10.900937] R13: 736574206b636162 R14: 0000000000000001 R15: ffff94f0=
545f8b40
<4>[   10.911113] FS:  0000000000000000(0000) GS:ffff950f07380000(0000) knl=
GS:0000000000000000
<4>[   10.916201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   10.926382] CR2: 0000000000000000 CR3: 000000204c05a000 CR4: 00000000=
00350ee0
<4>[   10.931470] Call Trace:
<6>[   10.936317] ata9: SATA link down (SStatus 0 SControl 300)
<4>[   10.936745]  <TASK>
<4>[   10.936745]  bnxt_ethtool_init.cold+0x18/0x18
<4>[   10.936745]  ? dma_pool_free+0x14d/0x160
<6>[   10.942591] ata10: SATA link down (SStatus 0 SControl 300)
<4>[   10.942663]  bnxt_fw_init_one_p2+0x18d/0x5e0
<6>[   10.949046] ata4: SATA link down (SStatus 0 SControl 300)
<4>[   10.949841]  bnxt_init_one+0x401/0xf10
<6>[   10.958451] ata6: SATA link down (SStatus 0 SControl 300)
<4>[   10.958854]  local_pci_probe+0x41/0x80
<6>[   10.968114] ata3: SATA link down (SStatus 0 SControl 300)
<4>[   10.968892]  pci_device_probe+0x1e2/0x210
<6>[   10.977259] ata8: SATA link down (SStatus 0 SControl 300)
<4>[   10.977657]  really_probe+0xde/0x380
<6>[   10.986406] ata5: SATA link down (SStatus 0 SControl 300)
<4>[   10.986817]  ? pm_runtime_barrier+0x50/0x90
<4>[   10.986817]  __driver_probe_device+0x78/0x170
<6>[   10.996042] ata7: SATA link down (SStatus 0 SControl 300)
<4>[   10.996978]  driver_probe_device+0x1f/0x90
<4>[   10.996978]  __driver_attach+0xd2/0x1c0
<4>[   10.996978]  ? __pfx___driver_attach+0x10/0x10
<4>[   10.996978]  bus_for_each_dev+0x65/0x90
<4>[   11.047368]  bus_add_driver+0x1b1/0x200
<4>[   11.052640]  driver_register+0x89/0xe0
<4>[   11.057487]  ? __pfx_bnxt_init+0x10/0x10
<4>[   11.061634]  bnxt_init+0x20/0x33
<4>[   11.065015]  do_one_initcall+0x5b/0x340
<4>[   11.070105]  ? rcu_read_lock_sched_held+0x3f/0x80
<4>[   11.075198]  kernel_init_freeable+0x29e/0x2ee
<4>[   11.080635]  ? __pfx_kernel_init+0x10/0x10
<4>[   11.085379]  kernel_init+0x16/0x140
<6>[   11.087743] ata16: SATA link down (SStatus 0 SControl 300)
<4>[   11.086528]  ret_from_fork+0x2c/0x50
<4>[   11.086528]  </TASK>
<6>[   11.094437] ata17: SATA link down (SStatus 0 SControl 300)
<4>[   11.094645] Modules linked in:
<4>[   11.097999] ---[ end trace 0000000000000000 ]---
<6>[   11.100194] ata18: SATA link down (SStatus 0 SControl 300)


Kind regards,
Niklas=
