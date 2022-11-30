Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422EA63DC87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiK3R57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiK3R5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:57:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74E11819;
        Wed, 30 Nov 2022 09:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq7sU9j7Z+cG8KuGibO113wUiyqvMquc6OCo2F8SuWyOhCfRz0BRKv04Gd4igN2ygDu1b1QiVBiiQQ8Q0B1o9YJv/GzJDOmQWSMFdEgXvpA+QcIMv6STt9uiLBIZ0zvrwKhH8sEhBld9SGlh6O8ddcF63vngOM6DwZQlGpt8Z2ev/WtQuQJia3+3XTwK9tn7IEoFi/ZlKVKMueQgBzAPNFANldHN7H3sp+MtHpjo8ouNbW3/fmYhdsY/DJSTPERjWGvE/Z8JHlFjdQ3WQJ0XUFhtOkDgXSqKOER83gRkS7IljM135oX4Jgfh4bvq6878SmTw1euaEkFqiIMmgURUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs4Iw5d9fBKrwN/4RSQkFY9FdK8fkljGfd9T8VNple0=;
 b=EXBCZFztv5eiY5NIurMexi84UWjCDrfjz9Eum4yx8eX+UqoF/9nlbspLJ9B+YFNtZvWLYb0pkZfoB20D7W9b8FjvPObumAEzDS1TOxzgfToQ5Lu84VroGE4Fv8OQqIqWTXF89VeEi+Ps7gislG+NNQmfTxb97I48/LdA3Iof6RWpFqRPI0W5WPdwykwN9I3ci0bNIkXfqgPPAdG5FmkE8Uj6WG7gMb2oaUwCoLezCRUAx9H9Dmf+4FeS34tOKnNLK1cYgb8UMbP+fVUWUSE8XTIjOvyBf1TSrkTvu0Isot+33zCyHH/M4pwvvF28lw2SChK6fF8GbQo8Ukbc/I+nWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs4Iw5d9fBKrwN/4RSQkFY9FdK8fkljGfd9T8VNple0=;
 b=sRUQPmlBOb8FsfxF8x/fcuw6yKxEmCrnvHHPS3U1Rbb8ryZNdjGah4bA+FTe9/0AdgI6y/KLjneo0E0gcbtjfCE74IWG3L3ZmsRNg8UPxRBfkbkYKuhVJKFG/8Qf7BY2Y6JJ4i+eH7nVXT8AtNxpHjDbU3e6ZfSfUwefzaRAewA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 17:57:45 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::7333:3eb0:58c5:54e9]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::7333:3eb0:58c5:54e9%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 17:57:44 +0000
Message-ID: <d95ee066-424c-1a0b-cffd-45e16bc7f8da@amd.com>
Date:   Wed, 30 Nov 2022 09:57:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] remoteproc: k3-r5: Use separate compatible string
 for TI AM62 SoC family
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        hnagalla@ti.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
        a-bhatia1@ti.com, j-luthra@ti.com
References: <20221130134052.7513-1-devarsht@ti.com>
 <20221130134052.7513-3-devarsht@ti.com>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20221130134052.7513-3-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: beb45266-b27f-4bfc-64d9-08dad2fc6211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUEN0bIlKhPQe9+jJXNu4IfYBcPa/t6agWQkBU7/F5y7BZQQ72IJdsBKrxB8+1AVzmfYmvFuXZIvIOy99vt+qfoq2CPmj+sayaRiv1oP3J74EUJvirE8w9QuzhmaIRRo3SSveClBjG8rM/NdDGDvnlh2/E1JUy8I4RYulpshAi3lPIDdEnP+5TmBAfxLKkGeAz41RvtgmgSb9DxKbxqpjI6ZqfJyUlPQ/2W4WJ6nXC5cOnYFe6d/2cMgpvyJUAWLIVDMQv8v3fDs7nNV6IqUdz62i84rNNszRcE0im5oLw2U0G2CfS+Ahu9q/kRzO+7CQaQWdXX6hRFMxjtJwigOF6G7NAizyE35xVxoGzljz9/MIwqpZWIQ0jEtyFwcgGBUfmyw5YHLmE4+Xe4Y1GmrL1sEaOE2vSoEZmG1oeQpv2nxVve5VzoIV8AmGRUumQC/TKUvuCdHMpENYUNcfVpC+xnWCTfw99L85iLclzq5Bw7Q3iXA263hrnHdDFTblibC7PiYz3tb3HOBrRz4V3RpQVpYJJeQdmXpdKTIQM7EggFa2cFdw6Af6WjL0l+0nZyzEYR9hMEUOmItpOYYesJ5JMndscaJJcHnVAYVfzN59lCcr2LfSRoMW45aclgE+SRcHySptcNsVoh2DCuArPIvvIFmkrcnWzSAa8XjlSbOBxKtpuBqCAAPDHOm4/TWS009Dmyk93qU2kph6zyqnL9wqITodw5y9IpRhR/cW6OaGV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(6506007)(31686004)(41300700001)(478600001)(6486002)(38100700002)(36756003)(53546011)(6666004)(316002)(186003)(8676002)(66946007)(66556008)(6512007)(66476007)(4326008)(8936002)(2906002)(2616005)(5660300002)(7416002)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9DWHllNHVVVHV5QXozOGxCTU1JdkozZ2lPWVNOVDAxTGdnMkMxQWhLTnpQ?=
 =?utf-8?B?K1ZnK1ZtOE5MNWxjVUFpU0ZDVXpBMnlKaTFkdDlrY1JJRWNpU3YyYVEzQVRU?=
 =?utf-8?B?cEdCem5hNlZWUGNLc3lVWHFuQUJqRk5QS0c3c05kQWIzQkxaVmhTT2dvbStT?=
 =?utf-8?B?TGRRNHNVN2JnTkdVL3FVeC9JUFdqaVg5Mnd6a1YvcE9SYlY3ZVJOUXR2MDZC?=
 =?utf-8?B?S1FKVDdQVlBUenJhdWpMVHRWVWJiR2V2bzc3Y1djRnMwTVl2d0p0Y1lDT3N1?=
 =?utf-8?B?VjdVeW1HYTdlQXFra1J6bHhIdzc3SFRVazZZRjNkVit0V2VnbCtSOERJY05L?=
 =?utf-8?B?VXBYbVN2MmhvSEpLOGo3eUxEN05PcXRacjl2SEJrd1Z0cGUxQmdjdDZET0Iz?=
 =?utf-8?B?NDdCR0xOV1gwclA3WHVsVDBXSi8xT293QUlvQzNOOHBzRWJnTUhCQktxamlU?=
 =?utf-8?B?Mi9wZitGQXhCelBuTzNZU0VsZFlzaW5Fc1EzQkxOWVVGMG1tVXBsaGgwMXpu?=
 =?utf-8?B?a0FkWngwV2tqNzhEVm85Y1Ztd3BPV2d1NUFWY2VxVHFHcjA0ZVMxWWxkV2RX?=
 =?utf-8?B?emhDdE45aXlSV2h0aHl5NzNPZDFxNEp4Q1ZxN0JOdy8xNHhsZWRqWnFidDBW?=
 =?utf-8?B?MEJxcW1pRnhydVlNUkJhVjU5bkVKTzdBVGpxTjJVYUN4ek5YRElxc0hta3h6?=
 =?utf-8?B?cUpIcERGNG0xVzdTejFWcTVwQWVmQnhZNGJOMUZndXFIb0tDdE9kNy9hWFRE?=
 =?utf-8?B?WWgrT3J6SktQbTArTW01TWEvSGZvTVAyZnhqZms1d3BoYmhlWFh0bmtmdzY5?=
 =?utf-8?B?V0tKcHNoNjVvL2wxSVZiQWNrUml0TXpuTlJTWWl1QUV5eGQwL2ljREtLS3Zr?=
 =?utf-8?B?MWV4d2lhTytKWnlCS2Z5NVNiZ0wzMW83RXFpNU5Rb3VZeDREbHpIakNnTTk5?=
 =?utf-8?B?Z29VM1VUM2xXT01RcWRTUTd4T3hQM0Q5cEZlNTgzSURoMkQwempPbTZHeVB3?=
 =?utf-8?B?bXI5Zk5WbzVwQ1RHdkk2ZWpvK0VxcmM4Q2dXeHZyS25sM3ZpQ21Zc3BHMzNo?=
 =?utf-8?B?VFdwa2JkWjI5YUY4Z2IzdXVkazlDZEtLd1B0bmFQaDI5RGZuTE5oZ3EzYk1N?=
 =?utf-8?B?K05vREJ0RkZWV1J0Umg4aEVoUTR6ckVJd3Y5R0NmQjVVSkE0a3dES2kxVk01?=
 =?utf-8?B?VGgrY3hHYzdSK1I2cFB4N3hVUzVweTBlYmJpVkV0ZHJEaHFkaGM1b3l4dFBw?=
 =?utf-8?B?SnlyTDFrb3dURUpBNzFQSG15T1dBVmNwK050bzNBN3ZoakVjOWx4eDlaUWZ2?=
 =?utf-8?B?Vm1oeXpjZFREUU5BUjJvdC8xTHhtRS9KWmMrQlBwa1BCN09lclF2Nld4YTln?=
 =?utf-8?B?d2ZYNDEwVFJCUXJoYVJqc3BJSGFRTjZSeHpocHZVUVVFb01KaGxZcVVHSUM3?=
 =?utf-8?B?bWplbjlrTldpNnBRUU1IYnoyS1o3bmpXSEIyc1NwQmhrU1I2YmEvZ1ZsUzE0?=
 =?utf-8?B?VHBRWTJUSDRocG4zSUE5cVBISWNXa0dWTFJsb1VQOEJXYWpkdmxUR3Q4QzBy?=
 =?utf-8?B?enVENWwvTGZGeWFiSUkyd05tcStRTUxISytRaXJyeHdKdVplM3FneFdsNGdF?=
 =?utf-8?B?b3FsalRUQVRoeXFOVC9iS252SEk2WXd3eTcrWVREc2F6d0Nzd1gvQzZiU0VB?=
 =?utf-8?B?ckFDZDRRWlMvVllJVHlKYkRkdW9FNnRhRXhLNDA0VjFyRHVwdkdjL2dyY2J3?=
 =?utf-8?B?cllpNGg1aVlYRWZOVGlRTjJwNFBraUtSTUJwRXpub0Q1aGVPdkIwUXJocFFn?=
 =?utf-8?B?cFB3VmdLV1RDY2ZCZnQrMTJtQUZHUk0rNlc5Z1UyS09Tb3FxV0hkUUFha0xv?=
 =?utf-8?B?Yng0Z0pwRDZqMFc4Y0tJQ21hbGw2MXRZZ2hjV3pOVHl5T0lyNnE3bFZDVUJ3?=
 =?utf-8?B?emlZVFdlcmllUmVjK2RRa2R5blJXWDJib2VaOW9iSjNlT2V6ZjFhYWwzWmRU?=
 =?utf-8?B?ajFPMDQ5RkY4R3FyZ3NMZ3BDSElxTUNFdldrWHA0QUUyYk43TTJiVHdpQVRN?=
 =?utf-8?B?SmNBUXJyV2hUSy9MczdmWERXck5pc21qa3hFc3VpbzlzelZwZkxOMzZzWWZ1?=
 =?utf-8?B?eklwd1Q4bEcwZjdQSVRQdnQwZjNjNDNOK2FGTCtCL2hVMGF2dFlsUWYwbWEr?=
 =?utf-8?Q?txg5eq7sqRfxk8VQ5WBLtWhmR0chkTdBAcqrj6pZ5p1T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb45266-b27f-4bfc-64d9-08dad2fc6211
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 17:57:44.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSUyvQNdgViEtNCOfkU+32soQrHnHjDocLrGQYT5BZk7kyWb+Z9/SS8rpSWqZGDu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devarsh,

Please find my comments below.

On 11/30/22 6:40 PM, Devarsh Thakkar wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> AM62 and AM62A SoCs use single core R5F which is a new scenario
> different than the one being used with CLUSTER_MODE_SINGLECPU
> which is for utilizing a single core from a set of cores available
> in R5F cluster present in the SoC.
>
> To support this single core scenario map it with
> newly defined CLUSTER_MODE_NONE and use it when
> compatible is set to ti,am62-r5fss.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: Fix indentation and ordering issues as per review comments
> ---
>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 55 ++++++++++++++++++------
>   1 file changed, 43 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 0481926c6975..9698b29a0b56 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -74,11 +74,13 @@ struct k3_r5_mem {
>    *   Split mode      : AM65x, J721E, J7200 and AM64x SoCs
>    *   LockStep mode   : AM65x, J721E and J7200 SoCs
>    *   Single-CPU mode : AM64x SoCs only
> + *   None            : AM62x, AM62A SoCs
>    */
>   enum cluster_mode {
>          CLUSTER_MODE_SPLIT = 0,
>          CLUSTER_MODE_LOCKSTEP,
>          CLUSTER_MODE_SINGLECPU,
> +       CLUSTER_MODE_NONE,
>   };
>
>   /**
> @@ -86,11 +88,13 @@ enum cluster_mode {
>    * @tcm_is_double: flag to denote the larger unified TCMs in certain modes
>    * @tcm_ecc_autoinit: flag to denote the auto-initialization of TCMs for ECC
>    * @single_cpu_mode: flag to denote if SoC/IP supports Single-CPU mode
> + * @is_single_core: flag to denote if SoC/IP has only single core R5
>    */
>   struct k3_r5_soc_data {
>          bool tcm_is_double;
>          bool tcm_ecc_autoinit;
>          bool single_cpu_mode;
> +       bool is_single_core;


If you are providing this data, then ignore parsing cluster-mode 
property. This will make change very simple.

I believe this would save you any modification in bindings as well as 
cluster-mode property is optional anyway.

Also, "enum cluster_mode" reflects cluster-mode values from bindings 
document except proper soc compatible. I don't see new value added in 
bindings document i.e. only

[0 -> split, 1 -> lockstep, 2 -> single cpu] are defined. If new enum is 
introduced in driver, it is expected to reflect in bindings i.e. [3 -> 
cluster-mode none] to avoid any confusion.

I believe it is duplicate logic if you are providing "is_single_core" 
information here and introduce CLUSTER_MODE_NONE as well.

May be I am missing something, but I don't see any use of providing 
extra value CLUSTER_MODE_NONE if "is_single_core" is set in the driver. 
So, simple solutions is just to avoid parsing cluster-mode property if 
is_single_core is set in the driver. Hope this helps.


Thanks,

Tanmay


>   };
>
>   /**
> @@ -838,7 +842,8 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>
>          core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
>          if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -           cluster->mode == CLUSTER_MODE_SINGLECPU) {
> +           cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +           cluster->mode == CLUSTER_MODE_NONE) {
>                  core = core0;
>          } else {
>                  core = kproc->core;
> @@ -853,7 +858,7 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>                  boot_vec, cfg, ctrl, stat);
>
>          /* check if only Single-CPU mode is supported on applicable SoCs */
> -       if (cluster->soc_data->single_cpu_mode) {
> +       if (cluster->soc_data->single_cpu_mode || cluster->soc_data->is_single_core) {
>                  single_cpu =
>                          !!(stat & PROC_BOOT_STATUS_FLAG_R5_SINGLECORE_ONLY);
>                  if (single_cpu && cluster->mode == CLUSTER_MODE_SPLIT) {
> @@ -1074,6 +1079,7 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
>
>          if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
>              cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +           cluster->mode == CLUSTER_MODE_NONE ||
>              !cluster->soc_data->tcm_is_double)
>                  return;
>
> @@ -1147,7 +1153,9 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>          atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
>          btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
>          loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
> -       if (cluster->soc_data->single_cpu_mode) {
> +       if (cluster->soc_data->is_single_core) {
> +               mode = CLUSTER_MODE_NONE;
> +       } else if (cluster->soc_data->single_cpu_mode) {
>                  mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
>                                  CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
>          } else {
> @@ -1271,7 +1279,8 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>
>                  /* create only one rproc in lockstep mode or single-cpu mode */
>                  if (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> -                   cluster->mode == CLUSTER_MODE_SINGLECPU)
> +                   cluster->mode == CLUSTER_MODE_SINGLECPU ||
> +                   cluster->mode == CLUSTER_MODE_NONE)
>                          break;
>          }
>
> @@ -1704,21 +1713,32 @@ static int k3_r5_probe(struct platform_device *pdev)
>           * default to most common efuse configurations - Split-mode on AM64x
>           * and LockStep-mode on all others
>           */
> -       cluster->mode = data->single_cpu_mode ?
> +       if (!data->is_single_core)
> +               cluster->mode = data->single_cpu_mode ?
>                                  CLUSTER_MODE_SPLIT : CLUSTER_MODE_LOCKSTEP;
> +       else
> +               cluster->mode = CLUSTER_MODE_NONE;
> +
>          cluster->soc_data = data;
>          INIT_LIST_HEAD(&cluster->cores);
>
> -       ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> -       if (ret < 0 && ret != -EINVAL) {
> -               dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n",
> -                       ret);
> -               return ret;
> +       if (!data->is_single_core) {
> +               ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
> +               if (ret < 0 && ret != -EINVAL) {
> +                       dev_err(dev, "invalid format for ti,cluster-mode, ret = %d\n", ret);
> +                       return ret;
> +               }
>          }
>
>          num_cores = of_get_available_child_count(np);
> -       if (num_cores != 2) {
> -               dev_err(dev, "MCU cluster requires both R5F cores to be enabled, num_cores = %d\n",
> +       if (num_cores != 2 && !data->is_single_core) {
> +               dev_err(dev, "MCU cluster requires both R5F cores to be enabled but num_cores is set to = %d\n",
> +                       num_cores);
> +               return -ENODEV;
> +       }
> +
> +       if (num_cores != 1 && data->is_single_core) {
> +               dev_err(dev, "SoC supports only single core R5 but num_cores is set to %d\n",
>                          num_cores);
>                  return -ENODEV;
>          }
> @@ -1760,18 +1780,28 @@ static const struct k3_r5_soc_data am65_j721e_soc_data = {
>          .tcm_is_double = false,
>          .tcm_ecc_autoinit = false,
>          .single_cpu_mode = false,
> +       .is_single_core = false,
>   };
>
>   static const struct k3_r5_soc_data j7200_j721s2_soc_data = {
>          .tcm_is_double = true,
>          .tcm_ecc_autoinit = true,
>          .single_cpu_mode = false,
> +       .is_single_core = false,
>   };
>
>   static const struct k3_r5_soc_data am64_soc_data = {
>          .tcm_is_double = true,
>          .tcm_ecc_autoinit = true,
>          .single_cpu_mode = true,
> +       .is_single_core = false,
> +};
> +
> +static const struct k3_r5_soc_data am62_soc_data = {
> +       .tcm_is_double = false,
> +       .tcm_ecc_autoinit = true,
> +       .single_cpu_mode = false,
> +       .is_single_core = true,
>   };
>
>   static const struct of_device_id k3_r5_of_match[] = {
> @@ -1779,6 +1809,7 @@ static const struct of_device_id k3_r5_of_match[] = {
>          { .compatible = "ti,j721e-r5fss", .data = &am65_j721e_soc_data, },
>          { .compatible = "ti,j7200-r5fss", .data = &j7200_j721s2_soc_data, },
>          { .compatible = "ti,am64-r5fss",  .data = &am64_soc_data, },
> +       { .compatible = "ti,am62-r5fss",  .data = &am62_soc_data, },
>          { .compatible = "ti,j721s2-r5fss",  .data = &j7200_j721s2_soc_data, },
>          { /* sentinel */ },
>   };
> --
> 2.17.1
>
