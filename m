Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A65ED9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiI1KDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiI1KC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857D9ADCF7;
        Wed, 28 Sep 2022 03:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtUqj5KU1B962AHmsr40aXoNdl39TsqWWnTgLH5ItibXp8rQsF5jmiGd0f6MST77fSouPJitnDXPRjXrhQBvSwrjns8woGqruJo9NwFUUrttrt5LTawpntP0xMJNyvy/iOdnGWuMNrjh5vwiTRwcbG1Lo1xuZLk1IP9f7zHbQfzP3Q7TFcN5XGm4jQQS2FJNuq6Sn3y1xcsv3Rzm7Q3IFP3Nun65H9DRGM+Rc3FBchTgr190R7R5MFDBo5CdpMXb9+xpW0ey1pdnWMaiZzDpTzt70xipCO0tOCpcTCavx4lqPpoRnDpEo4d8y7ApBB424Drjz2AswFRl72y1LlxY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qg4QrkZAS7SnTEJlwTu7IEj0IWGQUf7CViadMbdFUA=;
 b=dnOon4l+VJtMruMCY/PPcZ0kVTJnozYXBt64wAN/0krlz89fPmPgTgdGS2kpYkkj4dAtqFChBMQR4v8llV5n2Iv8YWOgZXRFvSxqPzHUro/Suc48vWzocCEqF4y30NdgjoxZpy8CIMLWGER9olOfi/9Yj0+EnJzAHn82gy/u07xlRpzwD8NC6qGZMk4IjQEcloApf/XZF+dYZWLd02ESg/zHGdV2dqn5Cb7O3Zp16J829WxYfgrOwYlqgmWQ+YZXvuo+uYKMw527c391qbtq8cm4uczL568UUsA8H0FhiJ8iewlqqJTVGsIvmSdhVsludOxQcCHKhBms6tGPmZ/Qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qg4QrkZAS7SnTEJlwTu7IEj0IWGQUf7CViadMbdFUA=;
 b=ODkf69EACg2Bj+zbSGCTyI2HoSVYLsUkpTwBQvgS5qvpJdo1rwOxFHen6v0Gm5azZN2RneDM88Ju9Gsnn4JyYJtqFtSrRjwd+ihVl/GQtggJMd3fVyJCQBvJ7+/3OgqeosGr5OEvUyi1uJysKzVM1u/ksqif9i67ugjqt185cPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 10:01:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 10:01:56 +0000
Message-ID: <65b7224d-d3eb-4513-d733-ec781864fb7b@oss.nxp.com>
Date:   Wed, 28 Sep 2022 18:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
 i.MX8QXP M4
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
 <20220824011023.1493050-4-peng.fan@oss.nxp.com>
 <20220926232127.GB2817947@p14s>
 <DU0PR04MB9417EABB1B0A9B550E94236288559@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220927175649.GB2883698@p14s>
 <64c6bdc2-583d-a2d0-f8b8-c4487f8a4d97@oss.nxp.com>
In-Reply-To: <64c6bdc2-583d-a2d0-f8b8-c4487f8a4d97@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: f0878ada-13bc-4cde-9f20-08daa13879e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVqdl7oiVF7el8K6+GLOr7xE3B6omhwDfqAIuaAaclioOClbNRsZsICFsP3j0BMccucBxrCp1h7vfIbZgCbulzU2xlisoBI6ecnJ6ifJDjWphPVCtsG4SfzRltEavR0VXS83csu1e5QWPLBs7ZtL5tqKABJzoPitm7TafH6JG71dO3D/h4vrPViQ1Ix6f7V9beNp7XlMJn1+6kxToNw1hSES4Z0vxOnrxylwDhFBvK41HIXiKK5u9ov9yWmZkpgBgpdkVcn1dVThGAQBL+B/3lqOR2yNonm7piXuLuIQWgD10rLbB135ZaqoejEPWMt5z+hz0KJ9dQsxdIS0NL2orly9TOrDN6eXBc3wPEDPCF9mVtslFuTLdUn0I7GUMsHd/Yyg9XAJEohzRO83NNHWDGx+tpzDn1mebpfRIcU7SZuLxBSw0Yp+NhYrZ2IiILyjgsyOnbPHj60/nN/3csgVHAOST10lZOau2+Si5EYEZWm2NXlNR0t9HzFYk45AC4ozdnhn1/y/Jc1ygx2CkOsRSQjCs5LFhst7vzvnFPVMR058hDZAimu3RtWierFeQdZq6fng53YFasJrARuP0yTLKQV/sgkQFxVny4yCLP8tcUNEskaH4gJ1+JaL6eYWhtgslLk2599wZFtJJ9ZjcYvJRbum69ZexputQUCQ7TxUoJ/WV4XqwARrtPGis+ddGQt6RTHZ35zQQS3N+rYFvjstWtCmJ2kYXdEHdqU31nioVKCHBwnqx/NKYNmPexQ5/tHbulkq4nTn9o0F+nnryhzsQRKKuc8svpld8aJBrVr1yvvfwUnOa26xmynZvMgeZrvbtbTp2B0kEx6xIbJjcbamq4WmCT1ytz7Oxb4qEVh4iyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(44832011)(966005)(31686004)(45080400002)(30864003)(6512007)(53546011)(38350700002)(6486002)(8936002)(110136005)(38100700002)(6506007)(8676002)(4326008)(2906002)(2616005)(41300700001)(31696002)(86362001)(83380400001)(52116002)(6666004)(7416002)(66946007)(54906003)(478600001)(316002)(26005)(66556008)(186003)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFhbWdpRUdTTlg0cGkzRkpDUWNSZis1L3V6UnhibXR2aW1XWTZkQmlubzMz?=
 =?utf-8?B?RlRzOXJ0U2ovNU5ja3BLTkNtdEpjbnlMODlMbDhLOVlQQ3FrNENTRzloak9k?=
 =?utf-8?B?d2VVYURoK2xYeng3d3VZWXhNK0xTdzlXcUpUbXdNZ01PNkxHMFZkalc3QjhK?=
 =?utf-8?B?bHMvZ2VwZmdoL2dDcjIzSkIzMURqRlVXSVIvZEZrU2dUM0F1eFNscmdLRGNV?=
 =?utf-8?B?NzhqSVRRWjZNZXh2MmZNQUk1N2hyMjhHTkkvcEVGN29IRmVhcmxYc1lGaWw0?=
 =?utf-8?B?S1lYL1YyVjJzeTU4NGhZQnE5UG1xdnk3Y0cwaVFtS1FCckduUHY2ZEVhWFdB?=
 =?utf-8?B?QzZFbVFjc3RTV3lGSEgwelJzUlQzZW44VzMxMnprT3hhS0d2U3dPdkFvWS9U?=
 =?utf-8?B?UWg1aXFFMzZpZjAvVG9XUXRsaDdLN0tCSDVhMllmM3BnR1BkMWFQUWtkYVFz?=
 =?utf-8?B?aW5UQVhCSjhFc09uTFRJTlkydnlLcGRZbE0rajJVS1lrOWQ3Z096Qnd4dWlV?=
 =?utf-8?B?UmdLZUlZa1ZvSHFRWmIxT3lBc0JKeG1jZFJEdVd4VEJaMXNnMTg4S0VQS3JM?=
 =?utf-8?B?L3p4UHlNaFJKbm1UZWZrSENFZnFOcWNVc1VBclZkeEU3SmFOdWZSd2xQNDk3?=
 =?utf-8?B?d25xMkxsVE1vQXorTkJkNW8wMXlFOXFQb1E5bVVpeDl3S0VHQ2lwRG0zUGVr?=
 =?utf-8?B?bkw2eW5MWnpzZWVtK2F1dzhXeEZVaS8rdk5FWTVZUVI3NkdQUHV4QURhY2lZ?=
 =?utf-8?B?ZFNxTmxnWGNTSHVnYVpyUVE4MzlSUUpBK0JCY1N2cEdhWVFrQ3VBcHE2VTBi?=
 =?utf-8?B?c0JSbHNHckgvMXJGRVhHMUVxUnNndlk3QmgxWEYwZmtEKzI3NW1UNnVmWGd6?=
 =?utf-8?B?ZXlqQmxZQ1NjNmthVWhSdFlPcmtIQzhSbHRER0hnL2ZQeUpFV0ZUTzJSdVlS?=
 =?utf-8?B?ODhFU2NvNzVXM0J3VWlRazJLSE5PUDFaRk9ES3o1UU9pZXhMS0hvSUtTVE1a?=
 =?utf-8?B?YUtGbGlUcGZ4Q0Z5KzU0ank4VnVmdzIyaVpjVUNhMDB3WVVLNmNLL0U5VmFO?=
 =?utf-8?B?cUpvUUloWlVZbUJCZWtjZUtOczlTbzE1cGVaTVVHS1lCUjA5K3ovYkdyMHJ4?=
 =?utf-8?B?K0hidEpsbDdhUjhTS25sRXZSd1QwbW03U0ZYc3VMN29FNUd0eC9zZlVEMVlu?=
 =?utf-8?B?RVJDdS8va0llMnBLbmJjSHY2bkNBalNqaXpJV1dIMlg5VVJraHdKMnRkWjV3?=
 =?utf-8?B?L0NzS1VPWHdUQkxUb3NkZExVdlhQY3EyM3A5cVRWNVA3djdTQnZ4RisyK1lJ?=
 =?utf-8?B?cCtYZndoalp1Qlg2bXlxdG1JM2tDMHROeFhvaWExMzI3OXl2S3hIRGJFRjhN?=
 =?utf-8?B?bHkrWkhtcExnWFZFR3kwdFdjbS9EQ1FhRTYvL3BlWTdIOVFqeHl6Z2xreWFv?=
 =?utf-8?B?bE5tVks2Q004WVRoUW8rTVUwMDVWSUNVZUtUbVJqZG9QM1dtMmtzWXNQZ3BK?=
 =?utf-8?B?Smt1clFtNEszeWpIY0toc1lYU0hzS2pXQlN2RFlqVEFabCtTZ2pNS3lwekpx?=
 =?utf-8?B?bmMybHg1dDEzSk54di9DZktiOGd6dU1xWXcrTUdPU05LTHNsamdmYUtYUDBY?=
 =?utf-8?B?UkdwNEwrR1B6VjZlR0NHWHlpeThQNzhqdjFPenZTblgvRENFb0ZmeFh0alcr?=
 =?utf-8?B?QXpmVFlZd0NkbEVnV1NNZy9Fc05iRmFFZ3B2UnFwalF1T1dEc3JjNXc3MWIz?=
 =?utf-8?B?N2Y0OWM5UmtpM1dCWmR6WkZDd3RUWnNpNFdtdUE1c1NRcGJNQVRMSXE0NE1B?=
 =?utf-8?B?OFpKK1hOdkZQTmdhS0xnZHNqWkp2R3JZS3V5ZVhIczdPdzk5MmpwN3V3QTBq?=
 =?utf-8?B?TzkxYmJ2a3ZBcHFITlN1bE9SWmhka0NqSmhVODFqMU52Z2krQWpKSnhWbFRN?=
 =?utf-8?B?T29TZ0huK2ZTNnRoQW9kMlAyYVdiRnI0TjUxQkxIVXU1L0ZsVVcvamdrRW44?=
 =?utf-8?B?TGxhbWxncnZEamlaOUpQM202QWJOL1VLeERxUGJsbzFBM0Jub3pWSytxWHdF?=
 =?utf-8?B?NjVKc1QyUVhBbW5aTHpmcFdKNWdFOFNRR09lcTZOTTl4TkxySkpjVmpwUWkx?=
 =?utf-8?Q?7Nv1iaAXWDBLdd2tsu/VWIKD2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0878ada-13bc-4cde-9f20-08daa13879e2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:01:56.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HqAJ5F7AjsVN1bWeKEY601vJ0aYJA7K826vJLLVVThDTtE86LQ7v36OF9rIr81XCshIPfwU2ZlS/gjDhG7WHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 9/28/2022 3:39 PM, Peng Fan wrote:
> 
> 
> On 9/28/2022 1:56 AM, Mathieu Poirier wrote:
>> On Tue, Sep 27, 2022 at 02:48:02AM +0000, Peng Fan wrote:
>>> Hi Mathieu,
>>>
>>> Thanks for reviewing this patchset.
>>>> Subject: Re: [PATCH V5 3/6] remoteproc: imx_rproc: support attaching to
>>>> i.MX8QXP M4
>>>>
>>>> On Wed, Aug 24, 2022 at 09:10:20AM +0800, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> When M4 is kicked by SCFW, M4 runs in its own hardware partition,
>>>>> Linux could only do IPC with M4, it could not start, stop, update 
>>>>> image.
>>>>>
>>>>> We disable recovery reboot when M4 is managed by SCFW, because
>>>>> remoteproc core still not support M4 auto-recovery without loading
>>>>> image.
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>   drivers/remoteproc/imx_rproc.c | 108
>>>>> ++++++++++++++++++++++++++++++++-
>>>>>   1 file changed, 107 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/imx_rproc.c
>>>>> b/drivers/remoteproc/imx_rproc.c index 7cc4fd207e2d..bcba74e90020
>>>>> 100644
>>>>> --- a/drivers/remoteproc/imx_rproc.c
>>>>> +++ b/drivers/remoteproc/imx_rproc.c
>>>>> @@ -6,6 +6,7 @@
>>>>>   #include <linux/arm-smccc.h>
>>>>>   #include <linux/clk.h>
>>>>>   #include <linux/err.h>
>>>>> +#include <linux/firmware/imx/sci.h>
>>>>>   #include <linux/interrupt.h>
>>>>>   #include <linux/kernel.h>
>>>>>   #include <linux/mailbox_client.h>
>>>>> @@ -59,6 +60,8 @@
>>>>>   #define IMX_SIP_RPROC_STARTED        0x01
>>>>>   #define IMX_SIP_RPROC_STOP        0x02
>>>>>
>>>>> +#define IMX_SC_IRQ_GROUP_REBOOTED    5
>>>>> +
>>>>>   /**
>>>>>    * struct imx_rproc_mem - slim internal memory structure
>>>>>    * @cpu_addr: MPU virtual address of the memory region @@ -89,6
>>>>> +92,10 @@ struct imx_rproc {
>>>>>       struct work_struct        rproc_work;
>>>>>       struct workqueue_struct        *workqueue;
>>>>>       void __iomem            *rsc_table;
>>>>> +    struct imx_sc_ipc        *ipc_handle;
>>>>> +    struct notifier_block        rproc_nb;
>>>>> +    u32                rproc_pt;    /* partition id */
>>>>> +    u32                rsrc_id;    /* resource id */
>>>>>   };
>>>>>
>>>>>   static const struct imx_rproc_att imx_rproc_att_imx93[] = { @@ 
>>>>> -117,6
>>>>> +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>>>>>       { 0xD0000000, 0xa0000000, 0x10000000, 0 },  };
>>>>>
>>>>> +static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
>>>>> +    { 0x08000000, 0x08000000, 0x10000000, 0 },
>>>>> +    /* TCML/U */
>>>>> +    { 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
>>>>> +    /* OCRAM(Low 96KB) */
>>>>> +    { 0x21000000, 0x00100000, 0x00018000, 0 },
>>>>> +    /* OCRAM */
>>>>> +    { 0x21100000, 0x00100000, 0x00040000, 0 },
>>>>> +    /* DDR (Data) */
>>>>> +    { 0x80000000, 0x80000000, 0x60000000, 0 }, };
>>>>> +
>>>>>   static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
>>>>>       /* dev addr , sys addr  , size        , flags */
>>>>>       /* ITCM   */
>>>>> @@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg
>>>> imx_rproc_cfg_imx8mq = {
>>>>>       .method        = IMX_RPROC_MMIO,
>>>>>   };
>>>>>
>>>>> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
>>>>> +    .att        = imx_rproc_att_imx8qxp,
>>>>> +    .att_size    = ARRAY_SIZE(imx_rproc_att_imx8qxp),
>>>>> +    .method        = IMX_RPROC_SCU_API,
>>>>> +};
>>>>> +
>>>>>   static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>>>>>       .att        = imx_rproc_att_imx8ulp,
>>>>>       .att_size    = ARRAY_SIZE(imx_rproc_att_imx8ulp),
>>>>> @@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc
>>>> *rproc)
>>>>>       mbox_free_channel(priv->rx_ch);
>>>>>   }
>>>>>
>>>>> +static void imx_rproc_put_scu(struct rproc *rproc) {
>>>>> +    struct imx_rproc *priv = rproc->priv;
>>>>> +    const struct imx_rproc_dcfg *dcfg = priv->dcfg;
>>>>> +
>>>>> +    if (dcfg->method != IMX_RPROC_SCU_API)
>>>>> +        return;
>>>>> +
>>>>> +    if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, 
>>>>> priv->rsrc_id))
>>>>> +        return;
>>>>> +
>>>>> +    imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED,
>>>> BIT(priv->rproc_pt), false);
>>>>> +    imx_scu_irq_unregister_notifier(&priv->rproc_nb);
>>>>> +}
>>>>> +
>>>>> +static int imx_rproc_partition_notify(struct notifier_block *nb,
>>>>> +                      unsigned long event, void *group) {
>>>>> +    struct imx_rproc *priv = container_of(nb, struct imx_rproc,
>>>>> +rproc_nb);
>>>>> +
>>>>> +    /* Ignore other irqs */
>>>>> +    if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group ==
>>>> IMX_SC_IRQ_GROUP_REBOOTED)))
>>>>> +        return 0;
>>>>> +
>>>>> +    rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
>>>>> +
>>>>> +    pr_info("Partition%d reset!\n", priv->rproc_pt);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   static int imx_rproc_detect_mode(struct imx_rproc *priv)  {
>>>>>       struct regmap_config config = { .name = "imx-rproc" }; @@ -689,6
>>>>> +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>>>>>       struct arm_smccc_res res;
>>>>>       int ret;
>>>>>       u32 val;
>>>>> +    u8 pt;
>>>>>
>>>>>       switch (dcfg->method) {
>>>>>       case IMX_RPROC_NONE:
>>>>> @@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct
>>>> imx_rproc *priv)
>>>>>           if (res.a0)
>>>>>               priv->rproc->state = RPROC_DETACHED;
>>>>>           return 0;
>>>>> +    case IMX_RPROC_SCU_API:
>>>>> +        ret = imx_scu_get_handle(&priv->ipc_handle);
>>>>> +        if (ret)
>>>>> +            return ret;
>>>>> +        ret = of_property_read_u32(dev->of_node, "fsl,resource-id",
>>>> &priv->rsrc_id);
>>>>> +        if (ret) {
>>>>> +            dev_err(dev, "No fsl,resource-id property\n");
>>>>> +            return ret;
>>>>> +        }
>>>>> +
>>>>> +        /*
>>>>> +         * If Mcore resource is not owned by Acore partition, It is
>>>> kicked by ROM,
>>>>> +         * and Linux could only do IPC with Mcore and nothing else.
>>>>> +         */
>>>>> +        if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv-
>>>>> rsrc_id))
>>>>> +            return 0;
>>>>
>>>> If imx_sc_rm_is_resource_owned() return '1' than the remote 
>>>> processor is
>>>> under Linux's control and what follows below is not needed.  That is 
>>>> also
>>>> coherent with the comment in [1].
>>>
>>> Case 1: If M4 is owned by Linux, here directly return 0.
>>> Case 2: If M4 is not owned by Linux, the following code after this 
>>> line will set
>>> state as RPROC_DETACHED.
>>
>> I understand that part.
>>
>>>
>>> Patch 3/6(this patch) is only to support case 2.
>>> Patch 4/6 is to support case 1.
>>>
>>
>> Let's leave the subsequent patches alone for now.
>>
>>>>
>>>> That is in contrast with what is happening in imx_rproc_put_scu().  
>>>> There, if
>>>> the remote processor is _not_ owned by Linux than the condition returns
>>>> without calling imx_scu_irq_group_enable() and
>>>> imx_scu_irq_unregister_notifier().  That seems to be a bug.
>>>
>>> No. The two functions only needed when M4 is in a separate hardware 
>>> partition.
>>>
>>> The scu irq is only needed when M4 is out of linux control and need some
>>> notification such as M4 is reset by SCU(System Control Unit). That 
>>> linux got
>>> notification that M4 is reset by SCU.
>>
>> I also understand that part.
>>
>> What I am underlining here is that when the M4 is independent, function
>> imx_scu_irq_register_notifier() and imx_scu_irq_group_enable() are 
>> called but
>> their cleanup equivalent are not called in imx_rproc_put_scu() because 
>> of the '!'
>> in the if() statement.
> 
> you are right, this is bug in my side. It should be as below based on 
> patch 3/6.
> 
> diff --git a/drivers/remoteproc/imx_rproc.c 
> b/drivers/remoteproc/imx_rproc.c
> index bcba74e90020..a56aecae00c6 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -713,7 +713,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
>          if (dcfg->method != IMX_RPROC_SCU_API)
>                  return;
> 
> -       if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +       if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
>                  return;
> 
> Thanks for detailed reviewing.

If you are fine with this change, I could send out V6. Anyway, I'll wait
to see if you have other comments in this patchset.

Thanks,
Peng.

> 
> Thanks,
> Peng.
> 
>>
>>>
>>>>
>>>> There is also a problem in patch 4/6 associated to that.
>>>
>>> If the upper explanation eliminate your concern, "a problem in patch 
>>> 4/6" should
>>> not be a problem.
>>>
>>> When M4 is owned by Linux, Linux need handle the power domain. If M4 
>>> is not owned
>>> by Linux, SCU firmware will handle the power domain, and Linux has no 
>>> permission to
>>> touch that.
>>>
>>> Thanks
>>> Peng
>>>
>>>>
>>>> Thanks,
>>>> Mathieu
>>>>
>>>>
>>>> [1].
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir
>>>> .bootlin.com%2Flinux%2Fv6.0-
>>>> rc7%2Fsource%2Fdrivers%2Ffirmware%2Fimx%2Frm.c%23L24&amp;data=0
>>>> 5%7C01%7Cpeng.fan%40nxp.com%7Cbe679e9a409a48b834b908daa015d92
>>>> c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637998312946913
>>>> 710%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
>>>> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
>>>> JDRvoDGGgEiSmbhj3410V2DNxamZbDmMS0U2GvBnI74%3D&amp;reserved
>>>> =0
>>>>
>>>>> +
>>>>> +        priv->rproc->state = RPROC_DETACHED;
>>>>> +        priv->rproc->recovery_disabled = true;
>>>>> +
>>>>> +        /* Get partition id and enable irq in SCFW */
>>>>> +        ret = imx_sc_rm_get_resource_owner(priv->ipc_handle,
>>>> priv->rsrc_id, &pt);
>>>>> +        if (ret) {
>>>>> +            dev_err(dev, "not able to get resource owner\n");
>>>>> +            return ret;
>>>>> +        }
>>>>> +
>>>>> +        priv->rproc_pt = pt;
>>>>> +        priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
>>>>> +
>>>>> +        ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
>>>>> +        if (ret) {
>>>>> +            dev_warn(dev, "register scu notifier failed.\n");
>>>>> +            return ret;
>>>>> +        }
>>>>> +
>>>>> +        ret =
>>>> imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv-
>>>>> rproc_pt),
>>>>> +                           true);
>>>>> +        if (ret) {
>>>>> +            imx_scu_irq_unregister_notifier(&priv->rproc_nb);
>>>>> +            dev_warn(dev, "Enable irq failed.\n");
>>>>> +            return ret;
>>>>> +        }
>>>>> +
>>>>> +        return 0;
>>>>>       default:
>>>>>           break;
>>>>>       }
>>>>> @@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device
>>>>> *pdev)
>>>>>
>>>>>       ret = imx_rproc_clk_enable(priv);
>>>>>       if (ret)
>>>>> -        goto err_put_mbox;
>>>>> +        goto err_put_scu;
>>>>>
>>>>>       INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
>>>>>
>>>>> @@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device
>>>>> *pdev)
>>>>>
>>>>>   err_put_clk:
>>>>>       clk_disable_unprepare(priv->clk);
>>>>> +err_put_scu:
>>>>> +    imx_rproc_put_scu(rproc);
>>>>>   err_put_mbox:
>>>>>       imx_rproc_free_mbox(rproc);
>>>>>   err_put_wkq:
>>>>> @@ -837,6 +941,7 @@ static int imx_rproc_remove(struct
>>>> platform_device
>>>>> *pdev)
>>>>>
>>>>>       clk_disable_unprepare(priv->clk);
>>>>>       rproc_del(rproc);
>>>>> +    imx_rproc_put_scu(rproc);
>>>>>       imx_rproc_free_mbox(rproc);
>>>>>       destroy_workqueue(priv->workqueue);
>>>>>       rproc_free(rproc);
>>>>> @@ -852,6 +957,7 @@ static const struct of_device_id
>>>> imx_rproc_of_match[] = {
>>>>>       { .compatible = "fsl,imx8mm-cm4", .data =
>>>> &imx_rproc_cfg_imx8mq },
>>>>>       { .compatible = "fsl,imx8mn-cm7", .data =
>>>> &imx_rproc_cfg_imx8mn },
>>>>>       { .compatible = "fsl,imx8mp-cm7", .data =
>>>> &imx_rproc_cfg_imx8mn },
>>>>> +    { .compatible = "fsl,imx8qxp-cm4", .data =
>>>> &imx_rproc_cfg_imx8qxp },
>>>>>       { .compatible = "fsl,imx8ulp-cm33", .data =
>>>> &imx_rproc_cfg_imx8ulp },
>>>>>       { .compatible = "fsl,imx93-cm33", .data = 
>>>>> &imx_rproc_cfg_imx93 },
>>>>>       {},
>>>>> -- 
>>>>> 2.37.1
>>>>>
