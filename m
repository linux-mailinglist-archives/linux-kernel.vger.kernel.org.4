Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7CA63703D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXCJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 21:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKXCJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:09:01 -0500
X-Greylist: delayed 2340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 18:08:57 PST
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1515.securemx.jp [210.130.202.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B97AF5C;
        Wed, 23 Nov 2022 18:08:57 -0800 (PST)
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1515) id 2AO1N4pR028312; Thu, 24 Nov 2022 10:23:04 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2AO1MZBF020720; Thu, 24 Nov 2022 10:22:36 +0900
X-Iguazu-Qid: 34trnOuRfgnbOB2eSz
X-Iguazu-QSIG: v=2; s=0; t=1669252955; q=34trnOuRfgnbOB2eSz; m=cM5GRjJ5y2RPdFnmn8XRabrDUKAkw4CAKnPmku6alY0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1512) id 2AO1MXoB007000
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Nov 2022 10:22:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eduZuk/70LNqdKLXW+NihDj6n7Va+aTxtUWu5WPjPaoUmNUYRkSgktcMoY08oOespjG2arylavnq9r+AkMKQuqKjj4KIdWcoRcSRZhfEHWPpW1CZkWJrh2CxRZaU9zwqWNCUO46bt2gV3Q1laW734owgpLFMNFHVyoxhu1g653JSZ/s+XtoQcCwiIdoZXYldY3x0L0kGLWRGCxjP+DHAsKGWx71FWHDDEYf7zUN5smz6vvwqCUexeV6i8B8pepAVouFfRHjAn9BdVIhctqfeejU/7HxfWuodxlNm1v/X1aNAh7lcqCk9wC8uZs1fvD3gjfpvvDetuB8NhYhEjcgrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41yFwUra3IJHWmGMNNGQX3xznprk3E3N+66SoFY+vSs=;
 b=X9uYqofi703vRehpJgUcvdpRIjIriIKb6tGrQrtJxrpCoEyh6BYPeoMdqoCsoqBA2f/tcd37PXpBr4HtN2zrNZIbJk8/A7uHdAINnxKT33NgPrHOh0YVP+Q7MO6K1LNrrRo3oxSKS9iX5IVID+d5fA3J3wxR2snhNNOxhewA4IbU7cxz6y2fIxdlLAOcWyB2mNbLj/PXa2On2eC62FNGlP9hFugu+eztxvchisu6u885bmpPTI1R+rwaA/H5cURWCti55rj5ZcQeDs0Z2aeOMo+w5dny08uzgbhOPGGARZ7WUi8cyne9QzSMfiYHTx8XL/YdJ7ImDXsPNEBytlDblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <xiujianfeng@huawei.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: visconti: Fix memory leak in visconti_register_pll()
Thread-Topic: [PATCH] clk: visconti: Fix memory leak in
 visconti_register_pll()
Thread-Index: AQHY/obtzQiD5+mlMUS8/8mSIDapEK5NSRrA
Date:   Thu, 24 Nov 2022 01:22:28 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420832555EFC60126BE0909920F9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20221122152353.204132-1-xiujianfeng@huawei.com>
In-Reply-To: <20221122152353.204132-1-xiujianfeng@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY1PR01MB10802:EE_
x-ms-office365-filtering-correlation-id: dfa5e23a-2679-41bc-305a-08dacdba5a21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykvwCa/c1FpgcvhOL16rll/dU/6c3a9EKFctspw3Q6iwaWB6pgi1uRcma6Dabo33lVFLBdRIz4+GVYBnu4CCgFBkZW8ygbwhX1krREsjZ+C3GWSvTfHL/moJpwqyfisrcMSh30ZvxSF7kK/Eb/4hedWQ55zRgUzZ9Bi4i00JrFwCc2sOEQJRzhztACmFqA3QZ3H/I/cCJwqbm4toCd2LodDXwoS+dR4UQnf1uN05A2O2SMzYAxZnS83Tmx13nciDlorkzjLmrgxF0L5kgKRqr3WLi1wn4MfO/1XxlDKvo82IG+o2Fqvp+wx9Eub/Lun6J7KUtGeWLinxtesXKBqy11lCOq6p1iFwb0SXoh0iqhLwPnaQXYQ6aGsH9RrY+LDSmcOFr77qDrhuL154hj/WmsAPH4CQzzsS0C8EvQfVkZQwNHZwiQGdlu5GkwvD8HK+B4ejyfLGhNGko6ifBJgmnv0I9t4Z9U8PPMVm0finzbZrJM2gZp93o2mQSxe4RFuMs6a3F7qpW3WuXRsrVV/8BFPOcYBz5DhXIp9A2A2k2Jy1zDqNgiiX9G2gYMK4sOJ3d2FBrGyQA0vk2SV8LpLf8Ixj5cysqF+MvU/DkE7jjxZmd0sNln7Zee2ZIZiTBAzzvRng6ITZGUMvV5OtQKKn8YoyUT0FqSXIV/73dEGiM2MtAClynFuaCZKRnATfLkGLr+GGAe8aQCMZCu/uCYI+Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(66556008)(66476007)(66446008)(64756008)(55016003)(66946007)(76116006)(8676002)(33656002)(478600001)(122000001)(38100700002)(52536014)(110136005)(6506007)(186003)(8936002)(54906003)(9686003)(71200400001)(7696005)(41300700001)(316002)(4326008)(86362001)(2906002)(38070700005)(83380400001)(55236004)(53546011)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eDlTd0x0ZVhlN0k1NVBvck9sNy9qaHZ4dmYyV1pTTHVESnhTU092bWht?=
 =?iso-2022-jp?B?OXhTSlRqRlR4WVBFTFJidmNsc09HS1BvWDBUanNTM1NQUVdhQnI5YVdS?=
 =?iso-2022-jp?B?K3dzbmtWZnZNQnlQdkJaZ3IvbVU4UHo0bDFkTU85OG1mcG5OSzZGTWtJ?=
 =?iso-2022-jp?B?VjYyL1J6SWhKMDdEcEVvNUIydWZPQVFubTV5YXhHdlVBSTB2WGtGazNr?=
 =?iso-2022-jp?B?WjZyMkdYaU5VdGRvV3RjcVpZNnJWZmNYUlIyT3VuaWVWZDFXMEo0R2M4?=
 =?iso-2022-jp?B?Y1IyWHRhZVd4NTc5L2g5dzg5TXFtQlkyUG1aTHh3SHRYU0NCajlPOU9T?=
 =?iso-2022-jp?B?em5QWEhHNlBnd01aWGc0dW5OeFN1ajZzODNMNzdPUlhHWUU3SjZrZFl3?=
 =?iso-2022-jp?B?YnFVOVNucStJYjR2aTFJREVSY043UFlXOGlTczdHYTB4cXl3RmFSdVNq?=
 =?iso-2022-jp?B?alI0RjMvSFZIck9YV0VmdlR0UmlMSERtVjFlRE42WE5KaExwOC9WNUpi?=
 =?iso-2022-jp?B?NEdMa1ZLbDQrNGpza1JWTFJUaUdvZi9vcDJ4N3Y3cHlLYnJoeGY5dnJ6?=
 =?iso-2022-jp?B?aWNhVmpzZXBMbTRuenp4aXhIc2dSRnF4UmJubk92QUs1ajVBcHFwejF6?=
 =?iso-2022-jp?B?N2d1Y1hxdFJLdE9WSG1qK2ExRi9yL2d5Zk55aGM2akozeDVWeGx5VXlJ?=
 =?iso-2022-jp?B?SmtTWmJMcTJOUEVCT0Z2ek80OW1MdzRJaDRrc3lNcndNcXdXbW9kS20z?=
 =?iso-2022-jp?B?VHA3VnhDdjU2cm80ZWJCb3lwMUU1VnhnaWhzWWJ1aFp1UkZpUXpyaXRw?=
 =?iso-2022-jp?B?R2N2aHVuRlRLTE4xY1g5eENkeEF0Slk2MUlrQ0xNUzc4TEV3OXN2Skly?=
 =?iso-2022-jp?B?WU5wWHV6L25kUG5xa00yWWw2Y1Z0dnpNbmQrZ3VCVFJlN1VMRnBtdm8y?=
 =?iso-2022-jp?B?dlFhcG5OYUdIMXBBT0hiZHZJaWlKRGFpV0VtblcvZ3NHMXlCRmhXWHBl?=
 =?iso-2022-jp?B?TXJLY3Fyak93TWVidzFyMml6cjNTQWVDUXQ3dFRLQ0hYOFR4ZGVCcDRt?=
 =?iso-2022-jp?B?eWxDY1hGN1YwU3JsZ2p2cDZZTS8xZkxKUkFiVk1mSEZLbWJmRUxlVzdo?=
 =?iso-2022-jp?B?OWYrUDRnSEt4MTI4dy9MUFo3anNQSnpFc3FqQ1lBVUhjNGs3Y1pmQUtY?=
 =?iso-2022-jp?B?T1R3WXo0Y3lvWE5mQXFPT002T2dxcnJJYlJ3d1JRK1ZYbWQxSTlIeDRj?=
 =?iso-2022-jp?B?VEgrMDhhZ3g0TmcyYUFncFhObG5xL1N1MGlUL2lQWWRqallPQzVHSmdM?=
 =?iso-2022-jp?B?RWtFbXY5b09mM0ZWblhiU1NCTy9NaDhOQjlZQkQ3K1V6ZGdsQmdEb0RT?=
 =?iso-2022-jp?B?NnlFNXBITXRwLzhyVTVxLzdwK25GZUx5TWFpckw4ekhOY0ptUTdNRTcy?=
 =?iso-2022-jp?B?cnpNMjMzMFJUVGlHRHpIeW9hcW9CVFF1ZXhybVUxUmdLQ0RsandEZGZq?=
 =?iso-2022-jp?B?UWUzemcvSDRVdS9wL0EvTWEzd0hIN2pVeEd0TitJZ1BVOWFIZ2w5RkRh?=
 =?iso-2022-jp?B?RUx4REQyRWs1ejE1Unp0aE5JREs0aVJrSnJDRVVVblc5ekR0WEhtWTc2?=
 =?iso-2022-jp?B?R1RvOTFpYmxzMDZ2UTdGeGIvWnlPNVJHSWFqWndYRmQzbTlVQ3ZWNnRE?=
 =?iso-2022-jp?B?dXhiZXpMdGZ4UExKYktxdlgrR0pXY3M3T3BiV3ZvUVdSS0xpclZvdUNL?=
 =?iso-2022-jp?B?SDFZdkNHL2VNZ01IOTgxdDhBaHo4b1FYdFVLbE1xcDR3Tmo5bnRRTTVv?=
 =?iso-2022-jp?B?cmpjV0xTczlBYlNHeXZVbUVhUGpsNDFsR2VzOWpic0J4dk1kNnhUdmNy?=
 =?iso-2022-jp?B?QTdpbGU5ZFgvN1lNS2pPajlHM3RGSEtCcGgvRENyNElKdkRLbUZpRFFI?=
 =?iso-2022-jp?B?Q2pVUlNnWUo4ZmhYVkJyaUl0MXMxaHpMeDBzWDVaZTZIOEFEZGJyZHAz?=
 =?iso-2022-jp?B?RU16NzhmYkdzeXJNT3RXeFdtMUFYc3RGM0M2ZHJGdjFHOXRYRUt4TUtK?=
 =?iso-2022-jp?B?ZjdKRENWU01GYzZmREd2ZEJrdkR6TG51aU9pTlByUDBFNC9wVTFJSEFt?=
 =?iso-2022-jp?B?NGZ2UnNhaUV4U2JHaWZwWmZaQ01RQWtvY0JmR2krd3JVRy8vTlJKOWhn?=
 =?iso-2022-jp?B?cENiSUVPMnVWZkR4T0pQeWllM1BxaGNWcFRWWVFUTnA4eTVmendvTUVL?=
 =?iso-2022-jp?B?Q21uK2liY3NaN2R4dWpCcnArVXZIaGhDTDVwRGV4LzNEb3BUZ2RWTWZD?=
 =?iso-2022-jp?B?d0xQUm1aOEhhT2tkeHU1NmJPVHp5RHhETEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa5e23a-2679-41bc-305a-08dacdba5a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:22:28.5925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B43yzPfzGv5CfuKX8TD2lijLz9Xb5HARD0Wy6T4y+7/FQLr7EJPMhjx3chVy91ck/KRAT4HIUbenP7CG+0H7Rqn0zt/Hb5d4xs342I0AuwnRCaKX5SzWhMBRyGsa64b4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10802
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiu,

Thanks for your patch!

> -----Original Message-----
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> Sent: Wednesday, November 23, 2022 12:24 AM
> To: mturquette@baylibre.com; sboyd@kernel.org; iwamatsu nobuhiro(岩松 信
> 洋 □ＳＷＣ◯ＡＣＴ) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: linux-clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] clk: visconti: Fix memory leak in visconti_register_pll()
> 
> @pll->rate_table has allocated memory by kmemdup(), if clk_hw_register()
> fails, it should be freed, otherwise it will cause memory leak issue, this patch
> fixes it.
> 
> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and
> reset driver")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro
> ---
>  drivers/clk/visconti/pll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/visconti/pll.c b/drivers/clk/visconti/pll.c index
> a484cb945d67..1f3234f22667 100644
> --- a/drivers/clk/visconti/pll.c
> +++ b/drivers/clk/visconti/pll.c
> @@ -277,6 +277,7 @@ static struct clk_hw *visconti_register_pll(struct
> visconti_pll_provider *ctx,
>  	ret = clk_hw_register(NULL, &pll->hw);
>  	if (ret) {
>  		pr_err("failed to register pll clock %s : %d\n", name, ret);
> +		kfree(pll->rate_table);
>  		kfree(pll);
>  		pll_hw_clk = ERR_PTR(ret);
>  	}
> --
> 2.17.1

