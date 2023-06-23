Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566B73BEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjFWTWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFWTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:22:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2111.outbound.protection.outlook.com [40.107.212.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C1E7D;
        Fri, 23 Jun 2023 12:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExAXZoVxxvOw/tzxIA6OGp5auqD/a4xaLlklRCMJVzKfBv+dtfnnJb6gzHge3r6x8P/QbIe49AvOA4JI68FlDyATN1LPSoO6OwaRHBpxk8CCt2FPIfEeTQSZZ41B/VbMMXqhH+d14qwmXfn6/OCH4rPEIKKoR9d5ra46LSgcHOSR5jyNgtcROTEDltYxnHVgW7BAJlh+NBLoxjLVUPSzKWwHD0q01TIiLwmgr+o2VQ+zAN1Vq1rhT9iunu5Fb8lSnudfyWLgQ6oMXCiv+Kv4qm+KKJn9ONc5fwGPRDqcF3EYGVBOcTt5ciHGVmKQqSLrCDRzsKaZo4Y7SrQikwHN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLW1TbjQUc18vSqBNwDwmmfAdKfBrbJZnpru1IaPfss=;
 b=fq6wHjqe/BQohOo0KwlvLRxewjNssFJLRucr1aeNXP+ATPyRcEbuNcfD89gDstxzbMEV5xn110tcDPgbTpNfFJd3YtiVTosV50CB0BX3Z71HUasogNJ79n3a3+6TmMH9jYLvipFyN6obL9OBOfGwSFgWra0PW9/6OrNawbTMiiJ9oUdx9hgYo/aNQh3ldINRBudDGwf+gcUsQmXVHKe2oPKxwXGK2eI9a4ENc5j6ZVPXvG+gc4skEbq1Lg1SkoWovYlOzQheG8BfKnvdN0e+SiK1BbMv38Bxo5b7Es7g5ZPwySzRhRD5YYbbytyQdCUhgu9+07ca58P5ZZb7sREKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLW1TbjQUc18vSqBNwDwmmfAdKfBrbJZnpru1IaPfss=;
 b=KuVohS0LIaeavRX6/EoKH1yxZjaxgTPltxsvENjeqq7LWU0tsrgyJrfWZO6KeZIx8KzFpyDAjCxVXEiVwOikailYP+qtCgt8wteixRrJqGPtjq+LPN0scxg5MCd88Ki4pimNjjutAq+LDC7hQ/taj6CbTpP5w5HhWEBerVEGHBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4156.namprd13.prod.outlook.com (2603:10b6:303:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 19:22:47 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 19:22:47 +0000
Date:   Fri, 23 Jun 2023 21:22:35 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2 02/12] net: stmmac: replace the sph_disable
 field with a flag
Message-ID: <ZJXw+92ee7CGtnCS@corigine.com>
References: <20230623100845.114085-1-brgl@bgdev.pl>
 <20230623100845.114085-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623100845.114085-3-brgl@bgdev.pl>
X-ClientProxiedBy: AS4P192CA0018.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: e28ae0a0-0620-4eb3-f253-08db741f39ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RZpdNPRR05VeAMJGK8kfJbeGW8gXueylMggL5NKj+R7791cw5p4HT9Ui/JhfYgX/7kIl8Pfk0wFefAFavJIDPzcR0oJsUjlmXm7t5rNrTGY956VpuKjPeLm3ETejgK0qTdwlGQyRQ2ft0f2RQteeOH/fe/R4gV3YbGlJZm9gYIJDAFP8EZLi7GpAxAsrdw+DvR9Kl350zZLBXxALHwiX9L6wFbUL9x6SFIQEARcvdmk9cOgwy4ZTQYAT7gA+gqB2wOurzwf4TSdfgvlYqKVGVsd5+Q26/gK1pH9vpqfY1FmBtu1OVwbMZxCMhOCLXg8FcE/YHlf+xKc2WKlRf8TfCSMuG3lQvr/g8Hiqin0RA79PJGuCL4f2ak5kSpiZtRCD5oJU4K+3piVQv4OJfN/a7BZGfyzndnci4d3wK9jktSgqa2Erqg9jmT1mzUMdhMSmTliWomXYatTQXBWYZAcWqXyeXEoIebDnr438eVZ6YV39TCW5lMx7fawMSI4aFCkyvEV2smuCq881ysSy1ukG7kagBke6Q6k62KRY7GgkLamMXfH9CvF1DXLObrZU4gSlx7gQq68mjKP1R8DP1KkD4AzBqB3xRCfnh9XsH/Ro1uvjrs8gOXLtwSZW1lSXIBN9lvA9mbqu67G+sD/IWDS4eHUhf4yetuHShuphZHpmwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39840400004)(451199021)(478600001)(6486002)(36756003)(6666004)(5660300002)(44832011)(7416002)(86362001)(2906002)(4744005)(54906003)(4326008)(6506007)(8676002)(8936002)(41300700001)(6916009)(66946007)(66556008)(66476007)(83380400001)(2616005)(316002)(38100700002)(186003)(6512007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FH3j0TiZoG4pSkE2A/vc7RLgg75IoKzU3g1YUai/rktFRh/LqDfG/Tx+8FyN?=
 =?us-ascii?Q?xwAvSAWOvl8hwBRJZ74iJsVreZ0Vn+rA1j8gv0nlUPMffqls2ECmyp+9YyU6?=
 =?us-ascii?Q?BfA/agCLNicTuTSVmpohSG2DgDz22zmz1jZ5uUuZGnuIkUzWebzxOsct5k9p?=
 =?us-ascii?Q?XGqMvpqDbLtz/Yd73sov2PVhUisZDiirhzlmc4LAAVfQY0MV/bY22hFq1yAs?=
 =?us-ascii?Q?hcZp6AfGVxOryU5gcqN4AsVT5CGz9C6zAQpa4eLxlU8LaOATtmaw86nn+BvZ?=
 =?us-ascii?Q?h4A6pRBhP28K8viNnj5cjomAk1NCMYGCw6pVm3A/QEtbBBcAFvlwATIEjG2N?=
 =?us-ascii?Q?hSf9mozizegC+0PUwO2N5QVgjS+NHv3pUB4tgm8MPHkTab6/iHiY2sISUXY4?=
 =?us-ascii?Q?Uh/opOj3BrkSJpvLWKRg7PTgAUA8v1y/unuxHaWKI15DdZeKiKabd8C9XWYf?=
 =?us-ascii?Q?Or1tP2obmfhr9436jLyvtwfivx0Azieu+0Ihbry1+zxtgupVFmCYfoEz6l0I?=
 =?us-ascii?Q?UjiT/BU2umx4NyoWoOBcNhEDZFCMph9U2gILWX4yEgxCJIzGZwftboIJ0d7j?=
 =?us-ascii?Q?FIGjE8M5son6vX3a3RRnqfqS9YKn3hvZuNzxufYatJDbODn9xTHYkzXhy36E?=
 =?us-ascii?Q?mYU71HRgNgqVk6ZUxuA00O4ChSlzN5Am5eT+EIVuXNtMLAfwScEFETmn2jij?=
 =?us-ascii?Q?eiDDd8Et/bT0HfPizuGSe/11foZeX17atwT1/xtI2z7TOd3rAhN9CGp/NzEV?=
 =?us-ascii?Q?rAyUQGjwEFWlQRMpdjJEHGB2KNVcStlRY3j6AimTnuFzMgbWgKBJhTt/2pvU?=
 =?us-ascii?Q?Z49l3ifIH7f73ZrTVNnZQ0B5juvwOG7nIX3HJWf+OaL1BvmssWvLzKllnx96?=
 =?us-ascii?Q?uwTkN0rnyRafaEkMrc5j/sqmf9ZNZEMgEuxjMiTZDtzjrtGDOkI3vNBn3mbv?=
 =?us-ascii?Q?gFMXE+A8Ok9OXYB9hzkTcLj/0Hwnw2rDGhf4/BThbzfUji5CB83xQOkaMYxQ?=
 =?us-ascii?Q?DxRGdZ500nMMSxBC0uT3VITgeEsdhcv3Vk14Yd049/lhKF32FyMv/oUIu6mA?=
 =?us-ascii?Q?svGCv8T3t4eZRT1OgnWUEYSrwBoW59N4UmwQkqLuxGMSn1X9hhmdUvveF8rR?=
 =?us-ascii?Q?0PhFU1goofgvAG3mRbvTgnIWgLfUPhtzIN8gbDXG8nTO8giwrfAVjNO1j72S?=
 =?us-ascii?Q?nGHcGK+l02yC/AYbo3gJeufZChvXK0p0A+B+rRxzzjOST24K2GHPUVHv4QIW?=
 =?us-ascii?Q?k6tsZd+qetbfjXyq41/fiBlJyYeeusztana5sd8Y7Pn3TiRrFnoCzYfVED+8?=
 =?us-ascii?Q?++WkhHMPzymKpUGbHEJSydB64GTyuHashWAOHKShMsCetHUn/wlDU0TkpD/X?=
 =?us-ascii?Q?yp8SfzVZlBEJfqVMi93XRPyY0Mr46+L6efn1vO2y/J83T82Sn3baGYC19cEK?=
 =?us-ascii?Q?yTDDlIa3T9sPO4DFzE+WxR9h6CdRmDsn2q1EhIUKyf2Q30b4KnRWb7C2H4Po?=
 =?us-ascii?Q?61z5HKRsaQXiSKmiR8US4MIKihi/buaYIAXHDkM4dX5s6moFNfwGZcFot3Q5?=
 =?us-ascii?Q?A5Vm00UgzuqJhhrjIwwnxxHMDhhdpxkWZHWfBN2ovoEoeOz75c+lFqYTu3Rr?=
 =?us-ascii?Q?F0Ir5L+i+ke+QX6R2K0tFabHJR2DJWoBb9drHPij3r88RLQ/QPeY1iHvb/VZ?=
 =?us-ascii?Q?U71oEQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28ae0a0-0620-4eb3-f253-08db741f39ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:22:47.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DbZEKjAy+Dl5iITmZZnJwpcUuAyefMpzVoLbF3ab1hyyp3eqknukdRhy/x8f63MhAPHVW3+fQ/7RQUKBNnHJiHToW3xKhpNO0e/KoMjdK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4156
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 12:08:35PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Drop the boolean field of the plat_stmmacenet_data structure in favor of a
> simple bitfield flag.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index ab9f876b6df7..70e91bbef2a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -459,7 +459,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
>  	plat->has_gmac4 = 1;
>  	plat->force_sf_dma_mode = 0;
>  	plat->tso_en = 1;
> -	plat->sph_disable = 1;
> +	data->flags |= STMMAC_FLAG_SPH_DISABLE;

Hi Bartosz,

I think something must have got mixed-up here.
An x86_64 allmodconfig reports that data is undeclared here.

...

-- 
pw-bot: changes-requested

