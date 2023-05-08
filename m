Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8D6FB20C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjEHNxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEHNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:53:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB90C36550;
        Mon,  8 May 2023 06:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vop/bXEulVpw/HsnvrjrHENAvAATMpwoXAcgolb/bG6M5UeCGNwfIA1+vXFTHdn+G8Jb2xW9muIgTFVvBfactWVTWl38kjqWorLaULobgQBVKxzgeIodkjr4w0OMJbCcqX7a9cSpBzDU1stHCoMUtPnU4EmGzOC9sVSJZ89Cdvor6hwaOyGVFu6+Xtnb2j8ggMKiPgi5eB185Y7JZIm/oqP/HcBRrHJ5IrMBYORu61vjf8pFN3Yyc37TKaIHItzTDH5lX0FMXILCDmh2NiIWf9UijkptafdU6iAM+53g16I63Hq4IBJz0ICkVTPwNX+h+/dvRPDi/cnJkAKk0MynKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0uXhPBVHNxE4QBJ2z2CAtznhWOM26H+sDv1cmpg47g=;
 b=fO/jTbOUkOlrrc76KXSqZerFxi2UeggCw8zT4SEWrHEB4SzJXZ3v2ZWV3hTuqwmRUe79/eToa/rsg98W63vOn0vUHES8xXVC5peBJBftwZzySQf7hwKkOVR/d5jhrtEwFP/NYuJ3uQZsnN2MhwhIdo1nTsmkGZskit4VOGX+vr0KCj3WaEPlth4NPXUhWBdRYsuFPOdN8Qvt5K0wZOT77OzF/tlT2Mmk13CnEuYt1mMEil9OHKBWt4ixYYuYq37eXuf4dg/US5L8vay56YqvOnQLQrhxRStmAtXUQHVy01u6k8tVc/4q5/fcZVemQR8c3DtG5q/ie16FQvDoVZv0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0uXhPBVHNxE4QBJ2z2CAtznhWOM26H+sDv1cmpg47g=;
 b=FJK2L1fYcv3IhdQc0DbL9gYQZ5Py4Q4txoh8WE9O7YxiKOnPtoDLY4gK6S4PNhwkjXjg/4miN+hfMB96I1pHmcDaA7eCyWoqgMeV+OKi2m5vwuWgnECVlGvkY9ZjswV8Sz01VEX5k66KS0850V6y2Q6hafkhkItfWhVT9Hhf3bKGgfeqMsHsKJIxgqmk7jO/wkyFMUGSww+xnM83NkI7UruGaYcW1nzmjjeAjqBmCHy3wYJbLh4XSWDBdEMyA6Z2RwaeEYLwmMeLqIDGKv2jSQVMZGoypNeowjXqftgF5cJlqtqY/e0uw0+fJldFOxsly7O+/6ME4/2ktqVO2x5EJA==
Received: from MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 13:52:58 +0000
Received: from MW3PR12MB4346.namprd12.prod.outlook.com
 ([fe80::42f0:9bed:2b:32e8]) by MW3PR12MB4346.namprd12.prod.outlook.com
 ([fe80::42f0:9bed:2b:32e8%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 13:52:58 +0000
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefan Kristiansson <stefank@nvidia.com>
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Thread-Topic: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Thread-Index: AQHZgah4ktUTN2aU+EKhTdV7EHkSYK9QYAOAgAAEpUI=
Date:   Mon, 8 May 2023 13:52:58 +0000
Message-ID: <MW3PR12MB43461CD5FEAE22462283AE7CB1719@MW3PR12MB4346.namprd12.prod.outlook.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-5-pdeschrijver@nvidia.com>
 <20230508133325.xllmriwydkczk6lh@krzk-bin>
In-Reply-To: <20230508133325.xllmriwydkczk6lh@krzk-bin>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4346:EE_|PH7PR12MB7844:EE_
x-ms-office365-filtering-correlation-id: 86fdcbf2-b87d-42fa-46e2-08db4fcb87f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hQBJmWgmQaFgoy2oiOpVsF3/g2LPKr88TEwoMYOyAHIsNHCQLOo8p0/UieUBBuAn4CcMUPo3yxPQfADCHXJUwEP5QBJOFkIXdQTj/TDEV/2wm+h5A92tCPsICL+7GB2Kc1aUIB1er2NFk2W/6WlshA+ozKFGS5VBav0Sxu9M3gSIkFsB0ddSU0q/fJPomfJwzSfO2TVpwDkiblCJbByZm4siq+hfCuyTrql+PPk/OWWlBNELLoILaZeLZT7uetkvyWJoyLwplwYx+M9OsS8lXfyRTGsFbX95xhu5WRXcTTnO0sSKb6vp3W1DQNf2ii8O408Dzzn0DFfEs6T7VJELSMGInJBNvhqLTsGIqCi2drmI89p8p5hbYoWLQUhRtv/ybSZCYTd2oM2N94/wToQpXu3Yp3+KdjLxM9Djsg7KPHvXgwfcaOJvf+OyVN2tozBbI53z1USEGieE3eiOMmGe3K44tt4hj6MbNRgNfUkADHeeLFXkZvY5sJ2rC8uHXa1R+b6MKqqjBTeaK1Rl5mCXBYt5wiSqdrxHOB8Kis9YnSworxq+aliLKiQvtaYvKmITUltCO5M3pVs55E2mFwWY0ws54UYDv0N0hHUTgr4jZBtfkAwm8EqLApphmOEsczIAPVpeyWv0Q57KLSSsBedyhZRMtYsriRWvR+QfL5b2x8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(53546011)(86362001)(33656002)(66476007)(966005)(54906003)(91956017)(66446008)(64756008)(6916009)(4326008)(76116006)(66946007)(66556008)(7696005)(316002)(478600001)(55016003)(52536014)(5660300002)(71200400001)(41300700001)(8676002)(2906002)(8936002)(186003)(38070700005)(38100700002)(122000001)(9686003)(26005)(6506007)(107886003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zeQMNNbxRIQ5iDR2sQQaf7Z41ydB4kHdoLEdkDwLOlaVhBPrJFekQx8n1x?=
 =?iso-8859-1?Q?AS33O/nUTBcwzp3epOac0EqJRxy/Urpus+RbqhZyvFTD2vwbGGn8n0GCP/?=
 =?iso-8859-1?Q?ViDKn+0psjKC/paeD/Z1QGyxhJtzuKoCb8q8LcM+P+32x3/GymU88hf/n8?=
 =?iso-8859-1?Q?KnzCjFDcxMtg0X0n4BraUEC9pSsd0f0+dTO5pqTR2tNgQvWe/0ymUV8hyj?=
 =?iso-8859-1?Q?Zvr80XK6NGfOJurQXtrjX/w5hWbz0WrzbVvlbmvGQMRercgxVqgedN1WPA?=
 =?iso-8859-1?Q?FAtoI/b+NN6YUpGrDARNeRY8IK4dbTt/7JE7HmfttgfepQOtjC7p8vDfFp?=
 =?iso-8859-1?Q?WorF7rekz0MoFXrc1c4QssMuOr9FYbv9U0+SyHVF5M9/s3UsmPI9kCqL9d?=
 =?iso-8859-1?Q?QLUO8ZcDU11wMxy6X+e9Kki3EduWK6Ezt5M1rENrV+LKIAN2NX+Fbl4Dku?=
 =?iso-8859-1?Q?/Jk8t1mlxshSvJszJlfnNUX5BCYPIcE9VH3jNAnN7U4x3pK8tj6+h6l1i4?=
 =?iso-8859-1?Q?FcsZf5C1OF3Xn169H31piIZUVetvnE4pETPvHsYWiuQxGCPa4Wz9EJkcX9?=
 =?iso-8859-1?Q?rytYGUoHFWATJSs5SCBiGJZkaXnHeBf+aoBJt3GLkNwsTvr4tikRLt3CJM?=
 =?iso-8859-1?Q?Swh0HJPTg186ZE+nWXUAL/AbVcg977Y39DJhPw9+GN7dgiMNvn30pbd4yg?=
 =?iso-8859-1?Q?JtukLfF+5eDnf9DwxQk2prrGLJnIH3tlNpXayxxLscXd21lWtggHScijwi?=
 =?iso-8859-1?Q?vD7T2VN2xeyzi/bcrYLRtSxaVt232RQArUHaF/Y9NUOfXiVvLxxNQu+G5E?=
 =?iso-8859-1?Q?8xfALeFQnifBKWeVpj5rd/pNgjaYfF//tcO5/Yn5ZwEd7Qtlw1TY2D5y9q?=
 =?iso-8859-1?Q?n5iooEXo9PtXR/obrfPlMybmwoRdmgXkI1Ys8fqKzrltbh4KAyGrj8+jO3?=
 =?iso-8859-1?Q?rHJjTvDMZTcKwGPjfXjH4GDZfbTGic6RaaJGY7DnI0xPo92IiWmfBFvGtO?=
 =?iso-8859-1?Q?Mt3Jx84+DGJ4B6Pkw7aY3Qw99luJJAJkZ6A6VWjEw029lMchyTBs9zB0l+?=
 =?iso-8859-1?Q?xDje+7/ey+N5VxsV8JAM/zJUzG18TQNZn43ELbidO7nIz6KYDKh7afdyVW?=
 =?iso-8859-1?Q?TmGUD348Em2xSUI/w8lfoo1DTl3Z53X/9IoUWPzuwXlRWKU7khU0LOoZr+?=
 =?iso-8859-1?Q?3GQ4HtMDZBp80D/uprkWMXey7BbdXWxVW+GpQyL44PtHidOVKmcZmAO4RK?=
 =?iso-8859-1?Q?mu6DC87/UXQwif+qUHv3aIw7hqdL4GBlyXco4Vg08QswmsYh6TzWojjKCQ?=
 =?iso-8859-1?Q?+RBtMbMBEo9ISdZxq4uTzrj57cXRcXeDkeZXY5U0p4kgtG7tfWhyAxcNE+?=
 =?iso-8859-1?Q?rMpvcHt/16j01B2Hu75VjxvhQ/k+xhDJAiWYwu09xv04XvKIhtHoNYntPj?=
 =?iso-8859-1?Q?/d0pZmeSfeGNli0bL97QmNOFe13L8eu2dGsCCRCSScEBzL1PIKZpkgImz8?=
 =?iso-8859-1?Q?9zvENoUVvKepfdiM+v01MXRFSVXmRyRbGFn1MB0+dzCJN+ERkw2bM4HlpV?=
 =?iso-8859-1?Q?3cdu5b3bWgwZAZqILYQx1ErbwN/MPsXRZYlDZmm31/g+KcG8df9UiOeDQB?=
 =?iso-8859-1?Q?We/mDeM+UcW8BMPQgcD36LTtBTlvSj7uo0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fdcbf2-b87d-42fa-46e2-08db4fcb87f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 13:52:58.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KO5WjJwHxtnHbhY0/zeUjGFEJJdT3utobf7r4TNcNAKXenCzEDGQX4yujqahnMCqBNIlhR45yGostngTG6b3+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No idea what the second error is about. Documentation/devicetree/bindings/r=
eserved-memory/nvidia,tegra264-bpmp-shmem.yaml does not have a oneOf condit=
ional?=0A=
=0A=
Peter.=0A=
=0A=
________________________________________=0A=
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
Sent: 08 May 2023 16:33=0A=
To: Peter De Schrijver=0A=
Cc: thierry.reding@gmail.com; krzysztof.kozlowski+dt@linaro.org; conor+dt@k=
ernel.org; linux-kernel@vger.kernel.org; robh+dt@kernel.org; Jonathan Hunte=
r; linux-tegra@vger.kernel.org; devicetree@vger.kernel.org; Stefan Kristian=
sson=0A=
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs=
=0A=
=0A=
On Mon, 08 May 2023 15:20:52 +0300, Peter De Schrijver wrote:=0A=
> Add bindings for DRAM MRQ GSC support.=0A=
>=0A=
> Co-developed-by: Stefan Kristiansson <stefank@nvidia.com>=0A=
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>=0A=
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>=0A=
> ---=0A=
>  .../firmware/nvidia,tegra186-bpmp.yaml        | 69 ++++++++++++++++++-=
=0A=
>  .../nvidia,tegra264-bpmp-shmem.yaml           | 40 +++++++++++=0A=
>  2 files changed, 106 insertions(+), 3 deletions(-)=0A=
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/nvi=
dia,tegra264-bpmp-shmem.yaml=0A=
>=0A=
=0A=
My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'=
=0A=
on your patch (DT_CHECKER_FLAGS is new in v5.13):=0A=
=0A=
yamllint warnings/errors:=0A=
./Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-sh=
mem.yaml:10:2: [warning] wrong indentation: expected 2 but found 1 (indenta=
tion)=0A=
=0A=
dtschema/dtc warnings/errors:=0A=
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/res=
erved-memory/nvidia,tegra264-bpmp-shmem.yaml: 'oneOf' conditional failed, o=
ne must be fixed:=0A=
        'unevaluatedProperties' is a required property=0A=
        'additionalProperties' is a required property=0A=
        hint: Either unevaluatedProperties or additionalProperties must be =
present=0A=
        from schema $id: http://devicetree.org/meta-schemas/core.yaml#=0A=
Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.example.dts=
:110.31-116.11: ERROR (duplicate_label): /example-1/hsp@3c00000: Duplicate =
label 'hsp_top0' on /example-1/hsp@3c00000 and /example-0/hsp@3c00000=0A=
ERROR: Input tree has errors, aborting (use -f to force output)=0A=
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/f=
irmware/nvidia,tegra186-bpmp.example.dtb] Error 2=0A=
make[1]: *** Waiting for unfinished jobs....=0A=
make: *** [Makefile:1512: dt_binding_check] Error 2=0A=
=0A=
doc reference errors (make refcheckdocs):=0A=
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pix=
fmt-packed.yuv.rst=0A=
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml=0A=
=0A=
See https://patchwork.ozlabs.org/patch/1778345=0A=
=0A=
This check can fail if there are any dependencies. The base for a patch=0A=
series is generally the most recent rc1.=0A=
=0A=
If you already ran 'make dt_binding_check' and didn't see the above=0A=
error(s), then make sure 'yamllint' is installed and dt-schema is up to=0A=
date:=0A=
=0A=
pip3 install dtschema --upgrade=0A=
=0A=
Please check and re-submit.=0A=
=0A=
--=0A=
nvpublic=
