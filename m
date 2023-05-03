Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1E6F5730
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjECLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:32:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77019268B;
        Wed,  3 May 2023 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683113578; x=1714649578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vmKxOo0m2xv5gWlgLy2TSv1ysvi7drgoSQF3VwaIp08=;
  b=mR67s7XLuD1Hqiska1Ijj0FO39W/gwTMLPgkLgt5wSq+eao+VJHNHc3t
   OcU1pDYTg2zeade4SYVKMz4GeWfh65cN1KCqeTqakkKRWNT0bpDQbjGzl
   r17aOL1+ETFV3vzJa+IHNmAzT5E5VMS5Uq0qTuGCM4L0qVBQWroXGhSkA
   mQ7to6Fagan8w5+YSEVqzL227HJuEel1w3koQrLXL1r06wLBs8hYx9RiZ
   aUYkp2ZRGJF/35ppBXmISc+Db1c9Hn0u0rgJyjyf9C3cT8P5lPWugV7dU
   +CH8huplLDh3zYpKtWuvBunrYI/wxYvOlmz8/i6r/SY2MipPSXcj5/b1j
   w==;
X-IronPort-AV: E=Sophos;i="5.99,247,1677513600"; 
   d="scan'208";a="341833143"
Received: from mail-bn8nam04lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2023 19:32:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAiG3pd0dt0xm12hbU5KHI6uW9e7GcHEOo6oxX0P0IDWmtbwZuz4UQnstBbwpZoCPjlQghBU36EZH8poLncEn0Ha8BmPvUC7+iBMyuvCQ2p9A+t5tqUS/HW6/bHD2mSKRQr+su+V5AS/nfTtVoaD4eWqtlYdUTdkjzkKUKXDYDeu8GjAfabJ0amElvskrQqvraFkS7iaGIoopM/Ix/IS1iQNPqca9ZduwqRSULkkKMY7RvimmbhdnftHUluDRjDUnSU9y2DitddS5MZXMPHm1ZJovvHaVYPX+A5sbF/Sk5j8OkwDXQwRouH340EIqaCWsjofSDG+WE6FYlsmwDgQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmKxOo0m2xv5gWlgLy2TSv1ysvi7drgoSQF3VwaIp08=;
 b=DF1mHnXE9wZ2yBPdqINMohSjAHiQI/P7JPvzKmQYcAZS6dc1clc9ntTTkpFgpXwCk5yGwpHuWoimcX8ESUs8UNdWYGdPYvroj8FIQWDapdBWw5kU/wQQzHLs5Jd82klFCgfY4HIb2UbgpBCTzMT1WNBTzgyrMdhrsipPnyR7tZ45LR1/GzAPNy9zTMAmBKVzoOs0Ipe/swnI4EFYxm48BJKWvvnERhmAIawUf0ZLBdAHr6jDTeHk8ao6A7VWqEY6edOGHI4bXSXsrTRhbWabi1mKuBeQfQmKzdYp7vEbJvS6GzUO1TvcSOL/6mUC5lZ4sFYXRcbnbeRVzT+xM+KbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmKxOo0m2xv5gWlgLy2TSv1ysvi7drgoSQF3VwaIp08=;
 b=ynABOkISuYlTr7GUdV0BlPJG1RD4+h4PXJtydqiaxcc7TF6FF108ok9uJrkqiIodPgqRkIhigdEVEx4Q05e2+AnA1Te7cwhyvL/Uz+oYYjCK9SPO92GxelBWivP501VDW7SqefrfkXVyCgWN3gWKN2l0WwQy83wSFE0cfZ8lpxo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CO6PR04MB7635.namprd04.prod.outlook.com (2603:10b6:303:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 11:32:50 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 11:32:45 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Thread-Topic: [RFC PATCH 00/11] Rust null block driver
Thread-Index: AQHZfbL6Xhz5/nlop0GOn95gYQsxBg==
Date:   Wed, 3 May 2023 11:32:44 +0000
Message-ID: <ZFJGWwlRbSS3zFnc@x1-carbon>
References: <20230503090708.2524310-1-nmi@metaspace.dk>
In-Reply-To: <20230503090708.2524310-1-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CO6PR04MB7635:EE_
x-ms-office365-filtering-correlation-id: 0866aa84-fea2-4dbc-9de8-08db4bca1d4e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWBu1AjAKMuh7PXg1QpO2n2G3Zy9MTnw0kNilgz4PabFwRfEhcGOqWuoeEP+4WRYc9X8pi65OOV47iOwss0wjnxMPjaOcTttL2dwxb+hQ3T8zuCTn6zgjg7KSrlv60HqkrcoQevPBEROTrKk3h5ZKc4cjwsvbSHJZ3qQJAIykhPLI/issP6jvqVq9TStOHzztxoncxlVJcCP/Cd5N/bblSj8pM23Ts+HseWRCvLyJXY1is5T20MaRTff2ZRpHIpLSJV66bHKEDImKNi1pyR2YzgW/eTSWw+XFbi/8Wnwz9dC5s6jOn4S4NHtlXr13uiVtMLveMdaGh+ZjSmfI3Xz5LcEUvi/O4yIXeH7qjaOkU5Ah9KxJAREmwZptbiBUlJWsE3PhD+zcU60YbUe6QMjHzSuYdacJeZdnQIOceEGpomuG0+sORsJaabWOKRh++aysbhWMM0mIdFBtmZ0sVwGbiSM6PwTHREw6/C7FAg2jtHxf1H0NgQEJfI5hh6bhjrPX6mPXxJQk2cLnUiKXbrOKFL+bmNd1egXRPMXhfDL3FxLybBPOtVq2g7NwDYpzZKZePhJyX6d815/WsepEmoCmpOtDme9oVPjK1I0PMqXKGU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(54906003)(478600001)(83380400001)(6486002)(71200400001)(6512007)(26005)(9686003)(6506007)(966005)(66476007)(64756008)(6916009)(76116006)(4326008)(82960400001)(316002)(66446008)(66556008)(66946007)(91956017)(186003)(41300700001)(7416002)(2906002)(122000001)(8676002)(5660300002)(38070700005)(8936002)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gTbDkUWlBUeDmf9VchwbPmNwqkOHVet+pam0gX8xKdy3pJ2DYVcnxaVCwQ?=
 =?iso-8859-1?Q?y7z6+sgqF23E5sdETYTvTOHKoyAnvPiew1TYFlcDctNYvAxzg+ecFVB/p6?=
 =?iso-8859-1?Q?dbXQ/W6ZqV9ryFH0I9xN3VGDTbwExLDFzHshLsjLlgaT6eMZ+hz8KGohj5?=
 =?iso-8859-1?Q?2v3fzTa3jNbB2MYlv40m6BN2uSURw7uIhjUPubnRrBE+3MN/sRNbMuxnEE?=
 =?iso-8859-1?Q?xRFfwTzgbdgNgTQDToM9gIj3/ROGTtU0iL086TAYVg1KESZm5hC91HwAk8?=
 =?iso-8859-1?Q?8u3WMoDFPtXhq9TJFjA1YTzJp7fa0OrXurNsbGngh0ZxIO0dhHwYn+kc0p?=
 =?iso-8859-1?Q?9F2FPrXestvC3KaCgfUzqE3uPqnyLG2XdVErtWStCDJGPOumPXxtsbU4g7?=
 =?iso-8859-1?Q?PkBX3BcdylpIwidGucGpmuw36FwgTpP9vnwuGv2APiGNHT/2iKppKfE3o1?=
 =?iso-8859-1?Q?naaY72fv/cSHtRAYYCdjwj11y/ducz2APrkCDERoJaYOuIOElVMUe5Pz+t?=
 =?iso-8859-1?Q?eLStWfUrwCA2nxb+Hu49hnL/c06nBTHAAb3zUWQP3Qr4JgCILfd4VHEnJ5?=
 =?iso-8859-1?Q?EJ67OddzTjq/INKBT3RDAiBtKzzBrPmCnBoWY70kFHUQQkuS4RlCSsXiKu?=
 =?iso-8859-1?Q?M0YlCjkX42ca9JLPN8XDD5dN/ePgwlZaopToU2Q8X+YShLVean34wo6PvB?=
 =?iso-8859-1?Q?7kcdpjlCH4WyKVGk8a/V7CKm4u8trrfr+6yvrcUqjH8cr3Y7S2XlwBzYr2?=
 =?iso-8859-1?Q?CDFOLkDSuvQHNrpyVBS/EK/ZMGf0ltLGFkMnkzWvTi8bNJ+C+xqrK8+zjr?=
 =?iso-8859-1?Q?hYDHKPHH2FKHv4U7pS/67jQhizSj3sMRam3pvq9oWJWz1WkxU9SSkIIbmR?=
 =?iso-8859-1?Q?bI2In6hN+Dk+hMw/amQHxeP1s0Ugf3Y4+oeExmRuGSuXd+uuMNfjVWLsCo?=
 =?iso-8859-1?Q?LPtI94l/6HMCgrkmnpIY8vCV7DK1AZfgz+YBK801JvLDxOq95GJ3hJTjDn?=
 =?iso-8859-1?Q?jnezxX+jqmF/SIXowLA8cFyicYKinA+6naHLd/daikghczsdgsymoyLF7O?=
 =?iso-8859-1?Q?N305VcNNnfgyRu3w9QBmFngOojb8PIeF434yd1r78ST7PYxsw9stiVejMV?=
 =?iso-8859-1?Q?C66JP76HYcR+UgwXvz8DDpOmHVKbbJdNCBZZqGAKbRAXGp8JfZH8mcT8d8?=
 =?iso-8859-1?Q?JmDZRdrLl5J+bKnPnK7t9IZPEIVtqlRAxelhmfGx8zYWBSxVo0CL8m9dFr?=
 =?iso-8859-1?Q?r3oeXNasXMelTbdK4ZgKUFD816WZI7MqfuTJ/L95WrufXITgg7TtxYuupV?=
 =?iso-8859-1?Q?Yf0gk+qZFbVQVHuPT3aQx1+OTMDNtx1vEQN6NBe2TGIK1QFq3Z6h7qD12f?=
 =?iso-8859-1?Q?vSgEKkTZNWrY5v22rEz+/H9e4vv+vJRCyvBI0TxLAX42OUkhjwuY41qVpU?=
 =?iso-8859-1?Q?Nn3yPI5uWYLlND1AzipFrnQg9pyXn2bjC00GTZNMNS9Vb3iB2GgWJeq8Db?=
 =?iso-8859-1?Q?/i3tnmXxkW7Yd8vb6B60oEIw6EX1U+h79rDPUnHv1ufjnK1ttK/XYg9gVk?=
 =?iso-8859-1?Q?war3PkbPSgpkx0YCgQvcIWG2mMWb2JsHyNCcG+ZhkiHegu78U+EWTveH3I?=
 =?iso-8859-1?Q?5e4OYxA9ZRFEnq+6dWfjUSwr3hCc8JPDyoROJC5Mch8VGozY3e4PoBrA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8F324F0731079E4CB5C4F759138173B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?kPkuPU17y06GjJ8HthIFj3LPHw/H1145IfXtcHk+P5vd+EdfaP3huMt51h?=
 =?iso-8859-1?Q?dYICBy2qaZg9DzdS4A3qPRaD84H33yGlMIDPuLfg2LigGmshBUEhjejoBc?=
 =?iso-8859-1?Q?l9aQELkVorGNphl4iq1tsxii36nfhpf+X7iDzYMDqXcO6R4NNQ4LkofNPZ?=
 =?iso-8859-1?Q?8H8ddbPH2RCrwbItCzzymL6DXZfFaAvw210M3mbEDoNAgbvOxr8F4LZsHk?=
 =?iso-8859-1?Q?4yNGqR2ZEfuZsm9RK8QkiXijf143r9AL6Fbp5TFSEt0H3kK6G9bGorQ+xo?=
 =?iso-8859-1?Q?8IESJXONmr0JczBPeZYduB//4zRlgbC32MtV9murnff5avLcUD6o5/Z7G9?=
 =?iso-8859-1?Q?++S5iFksWNYwwPduBrkQS9hG/kyMQIuXRxAiCl5yGgs0KsHlhB83vWTukP?=
 =?iso-8859-1?Q?61EGdaa2krZ0pSfB/oNkRoAoEwewblNM0N6C0RTBgidcJ8M3Z6jIm5wRlW?=
 =?iso-8859-1?Q?chKaFbNNCd9S39D99EkCWfEKg8Akj9wSn8AEX2Bri8t0WDIaOQu5qgtq5g?=
 =?iso-8859-1?Q?dw7b77mfFOyfrijfAGtxJsFuhH/zfLFnqsn/WyzA0yE42tm/HJ/ARLFHJo?=
 =?iso-8859-1?Q?NOCKMixC9hQ4AY/uWwlvVImxNQm9sW/Zi/RsTtRntMY5j2EsA8q0VHhpjT?=
 =?iso-8859-1?Q?y7wAKqHgoGT5PpGVcIc0rrS/Ww+QfyVnPiIheK9ni9Tt0VTh0YBsnaXhd/?=
 =?iso-8859-1?Q?2cnrS8zRtX2Nn5SZdmkxdV/WmWEcNO4ox1lhqw8bOrLtNAqCkieWfs1INF?=
 =?iso-8859-1?Q?y684vkYlhkw6mzCiShAO6aQ00LQasVQWOla/QILat+44y9g1mhHwnOZ17Q?=
 =?iso-8859-1?Q?hEdmZL1sxKcvKFfSjjREP2XWRk4wdzpaSj8wKIv+BDEOhjNhHk1LtwsMwc?=
 =?iso-8859-1?Q?ITBKpVmYtO51cxySxcwdwiH4CSazoOphx+YThvhuk1e0KH5OQs+dM87PbV?=
 =?iso-8859-1?Q?42zHRFqIAzlpRVGEWmBwi0pcavzMftlWHWbpzgWsScbH0cjAqHKQIoV7Ro?=
 =?iso-8859-1?Q?uVGAj0iMxFwe2rMJcp20HOA+vH0uZUKQ6AFJRd1akty7HyZFhwSGGIhvN/?=
 =?iso-8859-1?Q?+VmZbT+ToL8wAbRuG1dubEDa9GJ3Jy0869lGqinFMyz5GU6waZoG1zSdFN?=
 =?iso-8859-1?Q?O4gSHF8uRppWIvDkO6YWy74IdHq5o31MJUoIlGVygKkKed1e86FOK7FQA1?=
 =?iso-8859-1?Q?T99qXW6JLSDI2+5hDFWNWWyCbCN/GcOQPo8=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0866aa84-fea2-4dbc-9de8-08db4bca1d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 11:32:44.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3IBgO1AhwQVgdpKFkWm9QuLNoqk3H5bM8wBVTwYuKsMWrhqT1OUUW6ASYA/JZWEEDDJsKe0GHRHbjHbw/G4SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7635
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 11:06:57AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20

(cut)

>=20
> For each measurement the drivers are loaded, a drive is configured with m=
emory
> backing and a size of 4 GiB. C null_blk is configured to match the implem=
ented
> modes of the Rust driver: `blocksize` is set to 4 KiB, `completion_nsec` =
to 0,
> `irqmode` to 0 (IRQ_NONE), `queue_mode` to 2 (MQ), `hw_queue_depth` to 25=
6 and
> `memory_backed` to 1. For both the drivers, the queue scheduler is set to
> `none`. These measurements are made using 30 second runs of `fio` with th=
e
> `PSYNC` IO engine with workers pinned to separate CPU cores. The measurem=
ents
> are done inside a virtual machine (qemu/kvm) on an Intel Alder Lake works=
tation
> (i5-12600).

Hello Andreas,

I'm curious why you used psync ioengine for the benchmarks.

As psync is a sync ioengine, it means queue depth =3D=3D 1.

Wouldn't it have been more interesting to see an async ioengine,
together with different queue depths?


You might want to explain your table a bit more.
It might be nice to see IOPS and average latencies.

As an example of a table that I find easier to interpret,
see e.g. the table on page 29 in the SPDK performance report:
https://ci.spdk.io/download/performance-reports/SPDK_nvme_bdev_perf_report_=
2301.pdf


Kind regards,
Niklas=
