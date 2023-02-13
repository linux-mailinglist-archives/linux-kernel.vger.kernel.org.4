Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27153694633
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBMMqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjBMMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:46:35 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D51ADF6;
        Mon, 13 Feb 2023 04:46:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fevNfN950iniE8fx5fb3WXkcQYCm3Zm8SGiaR0+Ao6R8TnCyCqyuJiyxCzdo9sdnICqr9Nz5PzL4hP64akn/ox7BaRxFQ/fvUQTCI0w0sZhxZ6FSoXuM2tiPuLnmspQtkERSj9D0GdFeWCKbF1i0rMXavUOxNINTaSflMQJ1I/YEBu7u0/ZvI8VHpBCvApF1MlCLOyXiIsGk28pyHgiG7KGEpygXVe6sqkcnCIgKhV0QseFyJ4p4dsgbNmRwJyI+YH61O1y1kBrQU5h2wdoj3DH89lIq/9pQw15y/1AvWjpJ54SBkIzxViGdkPqXHYcdKP4U2B6Io01xI5Q2igEj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I1kZKBrMrMYpoo3ezxW7uGO9/XiveGn85xl0KVFrb4=;
 b=U81J5Wp2jsTwsoMLBaeT90ACfX+77/6uS6LIiFs6b/Ya0zfIQYq/0I2bY9QOGAh1rEjfpm3JTUOSZlV/4Goqm+ZTmYFJSb3zQDIDSQETAcCiUSUQ4CJCILv0PCNhfp4pFUpw4ra2Rq6aS+GS+Yol++WwZ7fjWxtXERozlUY4T5ZSU16yq7IosKYDdKfb5gjpAW53YQxCLA6ay8K95TGBZvJXWQR3hbzF4vc0u7her9F1coeZ5jSJJXMvzUODWvU1Rzg5b7QmDNVdEFzpxeZ9RMIsup8nh+9zrRe68sZJxzg61B+Cx8F9hEHmVDtLTEdMoi12vbN5KCpN+TVEV0BbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I1kZKBrMrMYpoo3ezxW7uGO9/XiveGn85xl0KVFrb4=;
 b=X92zc/pyM7Rbzsv/lmRCPPTvWn5GYono6VgYTJIwp/ePoepQqwID118SlLAy+g6nzl8GG5B/++lLLSSQ/sT3natuzFC719qYI+jh05JrsK40tdDDYodjC3jDVdTeGYf8+Dyl34dS4DvFqWpYchOy7Mcm7d5FoYybE3DGCetwliY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 12:46:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6086.022; Mon, 13 Feb 2023
 12:46:14 +0000
Message-ID: <01a7da03-a3eb-8334-8630-01e282b0113e@oss.nxp.com>
Date:   Mon, 13 Feb 2023 20:45:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230206153432.1017282-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f8f211-9cb2-4d8b-a932-08db0dc04a6c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6qD6RrWoFcvY/VRQj1x8+sOHW2IwSpT0mEOtmdp3ibzbnDOrfHwE+aQd5o9rh1cItiwIJjKj4e1GHC9q36GUQU8hK/u8epMM+Wikz7VLSzJZ4L2VWwKQpbjVTXEZnQQMwx5EdftjVlK8vdbk4GXZKV/bHV2pNyQtLFUwwF2n2MHi9GaiMv7kQwwnX0x0zPlOStdHNiyq2LN9B3MYF/tlFvQPp+miAowidFTa3P+68mJyyO9zd2AUr9qQW8n8TLDew9/ZJ5b/OiB/Y2VMBc997qZOzCK+NryeEKOKtoB5thS0Be5oUg/xSh+NP77GgFotoP/85+6fBq0JOo0OppC+gD8KHCRCYTKhZfFcfhEwE6JoQIhlhwUTlaADPWYcXDO5XkHMEHFaAP7BW+TPrZvdkd6uyNnBnBHNzl+D0ak0/A15RFuU/hxEqcmi+jvcgw4ynJJT1nIlfC9uzQXWqmISc4jD2WZmzF2K6oE+GFNpIKwDNpfUyMXiRG2DUfHHWkl/CE8svKGRYHRfwIZo0yU+LszAOhojrvVnpHuzwzEENQxWyavhPqAhdLjGBmve1wfrOhV441d52o0RjkA0ntxlBBJEH8vu50buhllR6Ig5/fZEuNzYOMCv6k+Ums4WzISrR+VfHyyeleF59SWFUOWGc+IXL9JRm6T4ZzIrmmE6p4xK/QxPYAKgtw41q3qySoH3VbcBz93UQaBXenB5ph3O78Rb32oF3OT37NL+N5RSrXBdDq0hMpIa7SBspo/sYoDgGNHCAPlIFrKWIMJRilvRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199018)(66946007)(86362001)(8676002)(54906003)(66556008)(478600001)(316002)(52116002)(4326008)(2906002)(6486002)(8936002)(7416002)(41300700001)(7406005)(44832011)(5660300002)(38100700002)(83380400001)(6512007)(186003)(53546011)(38350700002)(26005)(6666004)(6506007)(66476007)(31696002)(2616005)(31686004)(66899018)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhQa28rNHd4WjlWdWdleFBUQVV1Vmw0bEs3WW5kSm10N2VzTDJ3ZGh5dXF4?=
 =?utf-8?B?T1BzbmNxbkV5ODkrVS9ubFgrK1B1cnVIQjNwcWdmTmpiWDdPOW9jaTNta2Q1?=
 =?utf-8?B?QzNkRUhxdmhmbDlmemlEdExEZDJCcVhPKzYzTkFVY1RObkRBMVVxZWdKOC9t?=
 =?utf-8?B?NzJBYW9iTktsb1lUc0p5em1sZjRPY2hKa2I3bmJncFRsY3lqS1hod3loQUxw?=
 =?utf-8?B?ZFFWMkllaG9meEtkL0ZHckNseWxROEIyMk1vcmhjelNmL2taNlZQMk9qQ3Rv?=
 =?utf-8?B?ci9GRHptYUFqL3FnMmZMR0N1UFJMMUhYOFNEWEhXL1FRU1FyWkZoVlhodUhk?=
 =?utf-8?B?QUxrMmx2dktWMlM3Qk5GRGNZQzZTQkFOWEtUMVNHUm5QL0tWYjVRa3JhZ3Rj?=
 =?utf-8?B?dVBBRUo3RWFHSjg4UzFGU3o5MCtCZTVEejRrODBoY1JoYW4rak8rR28rM1o1?=
 =?utf-8?B?c2tHSGFqWGFMR0h1b24xckZUTWp3VFBjbDJOOCs0OWF1RGRZS0NMVUw5a1VI?=
 =?utf-8?B?NFI1UzVxRzZpdFkzc0dPRVRDR0NIYUhlVzhUY05TZWFVOS9hWldSS0hFUzFl?=
 =?utf-8?B?RHhJck53dlRVMUwzNVNubFVMRVlNbUIycmxsWXBmRHRIWmRjbmJRU2gyRlU3?=
 =?utf-8?B?WmVtTjdEZkpORmI0ZFR0MWZOU3pWN01jM01ETTd4anhPYWh4ME1ZbHljU2cy?=
 =?utf-8?B?RUtlaEE0YkZOenpzZ1FTZXNNYW1EQXpUSFRTeDJhcEU3MUNZVXQ5aFIvVkg5?=
 =?utf-8?B?SHA3K2tVajNHQ0tOcDBBNVdLdnNKbHN1UU1qaXBRRWZVa2RpYzltdVcySitn?=
 =?utf-8?B?S2dtSVZYYXR0Q2czMDJUVU84ZWhVSWVxbCtiY1gxZzF6dmdBbXJBWTFEQ2x6?=
 =?utf-8?B?endqS3Z0ZkZOalZ0UlpQTHdZUy84V0c0WVlWcEp3d01udFU1SXBjeStPMDlE?=
 =?utf-8?B?c1ZGRGVjcE1aMDl3dFgwUmFUK2FzSjJmVFZtNWF4L2RPbk9TL2w4c1QrUzA4?=
 =?utf-8?B?eXJmK3pwVXErUGZpS0hybE9kZDg4MzllWVZyWUNwODFvWHJvZmlWMGVjaWsx?=
 =?utf-8?B?MTMyUUJScks4Rm1yMFIzeE9ZUHZPWVBRU3hSbzlmaGh5OFhkYTFXbG00aEVI?=
 =?utf-8?B?VnM4SGk2ajVJK3p1ZFBZUDRJMzgvMlJMUTFYaER5UkdJRFE1d1hMbjV6blhw?=
 =?utf-8?B?QUY0SWJNZHF1NFhiNmNTL3FaSmtYRFpqR04zcWNHMXlSVWFPeEczWGhnQlIx?=
 =?utf-8?B?bXhNZXU0NzRyMnc0THErQ21MTWdxVzAvUDFKWW80cDAwaDBXZ1QvZzcrU2lG?=
 =?utf-8?B?MDl6dlFMelphMXBFT1pYQ0ZtNVdEVEtuWHI0QW9sa2Y2dFZ0TElFMEVRYVFy?=
 =?utf-8?B?NHRDakJPV2lpaUNSRjVYc0JZZUFkc3ZRdzcrZVZnK3VKRTJqVXh5ZmtKd2ow?=
 =?utf-8?B?SWZCSnplWTh3SjlhZm1MZDhjUFQyS08xS1NRUDMwWEN5aFdkQUxHcWJwM1pC?=
 =?utf-8?B?RTBYLzZ4SGZqWUllZ2czeEtBSFRDNTIvYkl2M09KenZZZW9rT0g5QjVvU2ky?=
 =?utf-8?B?SzhXa2VzM1YybmprVjFwUFcwdnBqSkNVRXVpckcvdU5oUEJKdVk2bVZSak5V?=
 =?utf-8?B?alE1ZkpmQXNVNnlxUUJlaURpYUc0OHA0c2Vxb3NTYllMY1N1cE1OZzBlOTJQ?=
 =?utf-8?B?czB1STZvZFAyV0YycEZmN1FQWnJxSzNRRDdldytiN3BydDJnWE9NdCt6ZnNQ?=
 =?utf-8?B?dmJobFQ4NHZ2OHlyVUcyYVF1SE9QTjUrM1Z2R0hCZG5RU3V3ZzAyUHJ1RHZr?=
 =?utf-8?B?bkFvc2swdjE4K2k5b1l3bEt3b3JLSGFudmJqSThCUmxsWWREdVc5L3NHTmd6?=
 =?utf-8?B?Yk1TY2NndlZ4ek9NNER2NHlMT1Z5ZmR5MCtCemdjMFE4QXd1MHY2WExlaWgz?=
 =?utf-8?B?RzNkV2xTZndBOWU4aW43K25jejZQaHFMVlVzaUx6WkNidk1pWUNZT3pBbFho?=
 =?utf-8?B?YU5ERFJRK21seVQ0NmpvS3ZNbXVmck9Oa3lxeHVkbW51cXk5YmVQRmNoOFIx?=
 =?utf-8?B?OTlFdnZrZzB5WkFPR0JQQWltRGY3SUo4Rmw4ckNzK1Zxa0cxeWFQSmRJMHVN?=
 =?utf-8?Q?epcVAEAQS6gbufgB18m4gaQud?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f8f211-9cb2-4d8b-a932-08db0dc04a6c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 12:46:14.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BFp9+zstu+Vr6xFRLKtHPuG7KCEnctaTXiQXYjGfkVensuLEbLl2K44/+DxT5gpQZjtELTB0nXeDK4d9ip0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 11:34 PM, Daniel Lezcano wrote:
> As the name states "thermal_core.h" is the header file for the core
> components of the thermal framework.
> 
> Too many drivers are including it. Hopefully the recent cleanups
> helped to self encapsulate the code a bit more and prevented the
> drivers to need this header.
> 
> Remove this inclusion in every place where it is possible.
> 
> Some other drivers did a confusion with the core header and the one
> exported in linux/thermal.h. They include the former instead of the
> latter. The changes also fix this.
> 
> The tegra/soctherm driver still remains as it uses an internal
> function which need to be replaced.
> 
> The Intel HFI driver uses the netlink internal framework core and
> should be changed to prevent to deal with the internals.
> 
> No functional changes
> 
> [ Applies to thermal/linux-next or linux-pm/linux-next ]
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com> for i.MX

> ---
>   drivers/thermal/amlogic_thermal.c           | 1 -
>   drivers/thermal/armada_thermal.c            | 2 --
>   drivers/thermal/broadcom/bcm2835_thermal.c  | 1 -
>   drivers/thermal/hisi_thermal.c              | 3 +--
>   drivers/thermal/imx8mm_thermal.c            | 1 -
>   drivers/thermal/imx_sc_thermal.c            | 1 -
>   drivers/thermal/intel/intel_hfi.c           | 3 ++-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
>   drivers/thermal/qoriq_thermal.c             | 1 -
>   drivers/thermal/rcar_gen3_thermal.c         | 1 -
>   drivers/thermal/samsung/exynos_tmu.c        | 3 +--
>   drivers/thermal/st/stm_thermal.c            | 1 -
>   drivers/thermal/tegra/tegra30-tsensor.c     | 1 -
>   drivers/thermal/uniphier_thermal.c          | 2 --
>   14 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index d30cb791e63c..9235fda4ec1e 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -28,7 +28,6 @@
>   #include <linux/regmap.h>
>   #include <linux/thermal.h>
>   
> -#include "thermal_core.h"
>   #include "thermal_hwmon.h"
>   
>   #define TSENSOR_CFG_REG1			0x4
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 83a4080bffc7..36653f692c80 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -19,8 +19,6 @@
>   #include <linux/regmap.h>
>   #include <linux/interrupt.h>
>   
> -#include "thermal_core.h"
> -
>   /* Thermal Manager Control and Status Register */
>   #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
>   #define PMU_TM_DISABLE_OFFS		0
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index 3d0710c6e004..23918bb76ae6 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -18,7 +18,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/thermal.h>
>   
> -#include "../thermal_core.h"
>   #include "../thermal_hwmon.h"
>   
>   #define BCM2835_TS_TSENSCTL			0x00
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 45226cab466e..62c67942293e 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -16,8 +16,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/io.h>
>   #include <linux/of_device.h>
> -
> -#include "thermal_core.h"
> +#include <linux/thermal.h>
>   
>   #define HI6220_TEMP0_LAG			(0x0)
>   #define HI6220_TEMP0_TH				(0x4)
> diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
> index d247b48696cb..72b5d6f319c1 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -17,7 +17,6 @@
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> -#include "thermal_core.h"
>   #include "thermal_hwmon.h"
>   
>   #define TER			0x0	/* TMU enable */
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index 378f574607f7..f32e59e74623 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -13,7 +13,6 @@
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> -#include "thermal_core.h"
>   #include "thermal_hwmon.h"
>   
>   #define IMX_SC_MISC_FUNC_GET_TEMP	13
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 6e604bda2b93..c69db6c90869 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -40,10 +40,11 @@
>   
>   #include <asm/msr.h>
>   
> -#include "../thermal_core.h"
>   #include "intel_hfi.h"
>   #include "thermal_interrupt.h"
>   
> +#include "../thermal_netlink.h"
> +
>   /* Hardware Feedback Interface MSR configuration bits */
>   #define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
>   #define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index e2429676d0d2..101c75d0e13f 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -15,7 +15,6 @@
>   #include <linux/regmap.h>
>   #include <linux/thermal.h>
>   
> -#include "../thermal_core.h"
>   #include "../thermal_hwmon.h"
>   
>   #define QPNP_TM_REG_DIG_MAJOR		0x01
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index d111e218f362..431c29c0898a 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -13,7 +13,6 @@
>   #include <linux/thermal.h>
>   #include <linux/units.h>
>   
> -#include "thermal_core.h"
>   #include "thermal_hwmon.h"
>   
>   #define SITES_MAX		16
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 4ef927437842..0fd2fd077638 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -17,7 +17,6 @@
>   #include <linux/sys_soc.h>
>   #include <linux/thermal.h>
>   
> -#include "thermal_core.h"
>   #include "thermal_hwmon.h"
>   
>   /* Register offsets */
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 37465af59262..527d1eb0663a 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -20,11 +20,10 @@
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/thermal.h>
>   
>   #include <dt-bindings/thermal/thermal_exynos.h>
>   
> -#include "../thermal_core.h"
> -
>   /* Exynos generic registers */
>   #define EXYNOS_TMU_REG_TRIMINFO		0x0
>   #define EXYNOS_TMU_REG_CONTROL		0x20
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index e7834ccc7976..735401958f01 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -19,7 +19,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/thermal.h>
>   
> -#include "../thermal_core.h"
>   #include "../thermal_hwmon.h"
>   
>   /* DTS register offsets */
> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
> index 0ffe37ce7df7..b3218b71b6d9 100644
> --- a/drivers/thermal/tegra/tegra30-tsensor.c
> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> @@ -28,7 +28,6 @@
>   
>   #include <soc/tegra/fuse.h>
>   
> -#include "../thermal_core.h"
>   #include "../thermal_hwmon.h"
>   
>   #define TSENSOR_SENSOR0_CONFIG0				0x0
> diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
> index f8ab2ca76184..47801841b3f5 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -17,8 +17,6 @@
>   #include <linux/regmap.h>
>   #include <linux/thermal.h>
>   
> -#include "thermal_core.h"
> -
>   /*
>    * block registers
>    * addresses are the offset from .block_base
