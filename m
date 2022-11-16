Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489FA62CB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiKPUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:46:21 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121085E3E2;
        Wed, 16 Nov 2022 12:46:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbUBifmD+D+hZgKybrBae9feNYym8UR/9tiJ0HDAm/F1Gon4huWMCKqD2lD1xJxJ2zCIp9hd19Upfb9qpFb1YIAZYLgaQnIKxqZtN5V9ee0751cJF3KnIwc9dylyKvfDsmw+CM4HX1r/CRIFrksFAxEOjDn5cXsEZKOqwaBO4JC41Pu4T4r4ELQuVCPqIhe7GARydWGRSmxBLLp/N8TQXgmYbcBhWNx4fzOeSrNO1y0r6j8S5pzQlzVqqBJc1cXVrcSFCut6OAI8P8mo6PMMilAZZISvMBcUOqtsSVBFdsoTY4hYMXD47QSPHT9FsFyLlA502Rj7bOa+unovLPOicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IuFQg78kvCCPWHZ8TyoyKOMimKtfmy2tP/TiMjAjNM=;
 b=KlsWyIgxv6vMxvORJOkOxKsCRklxqpoL+hv4eJ8t03r1Y+5UXOQnMXc7SAxZW/CiEMYUXYmzMME/2adtP+IzTKJz/tucaH1KIrCK8rkn31dIoj6O/0EMfGksz0+fd4AFpMf2fl7/8CUhPO6RqPRzrG0CwiZ0bmT3aoqRcRDtBMCbe2u6mlybkLIooGq+NrxE+T7Jp8Kfne8FEnhcnR7gO/6X6g4pZMwx4Y4SNXAGiyN7xoibjELnWVEqgX9bPlqOaayEqVls1K5Y6ccSXUDEnPnNfooSk8jisln1GJMsYHBkV1Gyui1IAoNUMRpiFQcIe/BHjxovG/2SLgc/sN9c7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IuFQg78kvCCPWHZ8TyoyKOMimKtfmy2tP/TiMjAjNM=;
 b=Nrwos2D2aDAlqYU2P9jROR7Kejb/yk0TiSjmawW2BkebJcZtggelqHGlUuPu1GhZ5umZUuH+pYwV29k+J1TFr5jO/6LT5zJC/k7HAfsUIA+ba9nSMr7ddlHyNf5+4LEGTzCIMBJxOQXDz1QGpD/tMtsSNNdfA5yzGVtGWEzi7rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 20:46:17 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::300:1e64:e632:71c1]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::300:1e64:e632:71c1%3]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 20:46:17 +0000
Message-ID: <c96e7c58-e8f5-6c6c-f195-b975bbe643e4@amd.com>
Date:   Wed, 16 Nov 2022 12:46:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v11 0/6] Add Xilinx RPU subsystem support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@amd.com,
        bill.mills@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
 <20221116183814.GD61935@p14s>
Content-Language: en-US
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20221116183814.GD61935@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|BL1PR12MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac4e593-5ae6-4e2a-704f-08dac8139bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVmJjBUg1/zQo0GNTqFOxNSct9J7rMUqAoGt4r+yVq1K431D9ihZ23nKwPJBCFoCUrG1iwPNBid+rLVp96W1c/kN+jZNby/VGBjkAauC843pTfetvNxPqMkdL8be7Lcw+V2ZJ2vsw1XnMuUXpRNZh3gTXqRT0QDqINMSR+ZJ8nTsJPxaCKLb+haeKefdazzi5TJLDUlaMQQJ5eyRICEdtXRm+8aQk6ibzVXigVTueat4qh8Md0diNSbI3xXjpkCfr05psddb/qQjspx08HSyj0PSXQrWA1XG/A7Z3xndeRGRp0BVRC/dZIa85v5if/cb9afzi4lsR7YJ74GyiZHBeXE6zeg2Rz5+8eCJz8H/q4SQ/o4nQtTrjx0dnb82n3fYLgvgllWxUmIJ5aHytbrzhkxBHfqePh+kLnsf593MDR8UXe+sA0DZYtZgV+d8nEdF/VB04+BTysOt7lHUuJFoTKcqxzFNc/t8qwx9LijzREIghRAeQEefYrsCO5XuwYVJaHsCE7ASK+CXZTOVnUMhCO9onWGPwxzUNZiwyaMTRQynmRKRcU64EfbCCiQy0CSRxz9wxVgzu8rEBY5aWn2xo6BKJCLnEaK06qXOZf5b+k+leQXB1+wwlYtyaR46lIDZNtjb5rMz3E3u8fN2EF+igGXC1JtmLtcBsSUbDS2YJlMYw6FPgxSuHFA+SAmZubYpuoz1Cm5Q2K+3+lqCOW173cQtQDvX7ng6eMFUrBGlAn0B9rTDva1vlVO6RBSoix0L6TFhRFHZUmXbgiNGJOxBpFgppjdMZS9lU0KToxPNImA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(6636002)(36756003)(38100700002)(2616005)(66556008)(478600001)(6486002)(66946007)(66476007)(4326008)(2906002)(6512007)(8676002)(83380400001)(41300700001)(110136005)(5660300002)(316002)(31696002)(8936002)(6506007)(53546011)(6666004)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1VbVdkeEhCVXQ0RFJXNmY3WFZaMVAzZkV1TjV2aGNBazErZlpYOWtYY0tL?=
 =?utf-8?B?bnFCS1VQd016Y0NsdkVwcWVvUzVhcmcxbWNRQlpsY0JERmVvb3BMNndhS1J4?=
 =?utf-8?B?S1VxUDhVeGFFTnFpZUl1QXV0ejV3NnE5c1dtOUxManJKeER3emQzVFArU0Jj?=
 =?utf-8?B?RFVJbnVHaHB6MEFnYndsTkI1VVZGandtcFc3K25lSUtNT1g2VEt1bURFQkZE?=
 =?utf-8?B?Nk14Nk82RVBrNjlURW1WSE9qcXZ2K3p2SERXc1JoTG1wNmR6cE4zd2ZIQkI1?=
 =?utf-8?B?TG9kOWdTb1QrWGlSNjdGVDR6V1FEcUo2bVdzVWN3YnJnaWE2NitiUytDdExZ?=
 =?utf-8?B?eHdobFZuZ2hheTU2dEFidys5VzV5Z3lIVnhoM1pHQldESkdUSWdzN2ppYlFu?=
 =?utf-8?B?YmgzaGxUd3B0WGx0SHEyTzdpWWx0RTF6NE0xbmg2UHVYK2tzRmthRkI3QTFz?=
 =?utf-8?B?VmxKeHNNVWxTOG1HV0pmOU1QRnBRSngrelFIeEpkNEo5UmJpR21nWGxTeGsz?=
 =?utf-8?B?SVlMTlNZM2hrZm9tTXRTdlMxY0FnVXMwWjdYMlF5czRvNmdHd2JIcFhhbEFn?=
 =?utf-8?B?aVFOYUFLdWlUOEE5cnU4cWoyWkxhWVYzczUxdEFaVWt0MWIyanlzWkxOTFky?=
 =?utf-8?B?Rnc5ejRPejk4dDdDVzN0Z1d4NjNMaFJWV2NGaDNCa25ZZGE1ZUQ2aldQblls?=
 =?utf-8?B?VlRJVm8xcnpTdTZQRWV4enN1YkY5b0Q5SnpXY3o1WHYrak4zS1YySU9PUTRV?=
 =?utf-8?B?NGJRdDJVUFlhMEk0UFpLWmFuOFVscVBrRzQyeVFvK3FuSTRuTk5GbjljbGtD?=
 =?utf-8?B?NjcxeEZXeG9FenJ4UmJnZFdleHVYaEpWaGsvTC9xclg3TkMzYXljdmJlUHVq?=
 =?utf-8?B?Z2Q2WHlDREFKQWwxS3JwWUFDZHlTUHRxaEIzOStHL3pJTmxzWTB4Q1BkM3dq?=
 =?utf-8?B?L09mVXRkejVnWlBQYkJWRGJWUXkyZVFzME5jR083VndQeFNqSFVqRlM0blhz?=
 =?utf-8?B?UzJ4YUpUV0lXYlYyU1R0Z3JQaVhFZWVBbkdFdWlwV1dSN1FkQXhkQTNMbGtu?=
 =?utf-8?B?dFVOZnFXYnlWcnJ0eDEwclh0MU0raXduWUw5aUNOZW1XMTlrc1QvT2JweUJ1?=
 =?utf-8?B?S3V5alJraUROTHd3SlZ0WFNuZmE1TWlpaXdLMkVsb3ZNVWRmVHVUZEVWWTNW?=
 =?utf-8?B?S25wV0NVUUhTWFhSV2g4b1FpSC9qYnpBL0ZCZ2FTbVlhS2lFUTZ6dkVSYXNk?=
 =?utf-8?B?enJZaXNwWWNSYlpFWTAzVFJORkp4LzVhbE94Yy9zbHF6VjNSbUV6bXZ4dUlk?=
 =?utf-8?B?ZGgwUGFFd1V6NENrQXZ5R0NUZ05UKy9VNXlFdlBmYVR4czNNK0FoMXUyeC8x?=
 =?utf-8?B?bnUwRDJkZUlCYUhQT2djcmR2UWROK2RkTW85aHlXMytIL2pJa3RjYU9oMjNs?=
 =?utf-8?B?ZmFld1pLbUpYVndON3h5U0tkQUZVTmNRTVc2K2psckM5aHh6VytYMzJ3WlFT?=
 =?utf-8?B?UFV1aW1DZjczZ2Rhczk1SFVrQ2MwWitycU5hTG9RQWFQUml0NndjVktEY1RC?=
 =?utf-8?B?MXRYdmZpTHdWVThRQURJSUZyM2FyMElUOXIwYUpKcGlDZzROYUtaaHZkSVky?=
 =?utf-8?B?bU56d3dOOFMzaCswMWd5NWpMd1lTcFEyejJyWmVoNkZCWGFiOGhnVUdJa0Nk?=
 =?utf-8?B?dllYcS9RSEErdnM5MytxblBUdHhsTGZrUVloZXZ4VU1VN2xYNXZiNjRkdXhF?=
 =?utf-8?B?NDBGTEZLalJwRFV0VWdvM05QN051dVJVdEZFQ3NOWStjMjNLWFFUYjNiakRH?=
 =?utf-8?B?Qk0zV3hXaGdWV3RUTk9FWVo1QjFZSXk3L3ZzdFpFcWdqQlZ6VHZhRFh0eUVz?=
 =?utf-8?B?ZWF0c3greGZGSlZ1MmVLbThUYnorTVM3K2UyWEV0TVpUeVNPN2hsWkMvcG1s?=
 =?utf-8?B?UG5pb05ZK1ByZkRWdGRPVWhhVHdPbFM4RFhqNGN2VkFtYnRNRkUvLy9aUU9Z?=
 =?utf-8?B?V1R6aEEybmYvOUgyUjRMSEs3NXFkOGxFanBVRkdXS1RjSWdzeVNZWjlOZ0xx?=
 =?utf-8?B?NFcwRm9MMnFmRGNaODAyU0djckN0REZwUlM2U0JQeExYMExMc3pPZTd6OG5m?=
 =?utf-8?B?eG9sbjZ5MWgrbDdJcmVaVFFkb0dJSUNyalNhNjFYdUNBVUxQUlVDMjIxcmsw?=
 =?utf-8?Q?GSt/XGZSkjzDXTDMRiEGxfaUoxRbYeCuwsRV43kQm8/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac4e593-5ae6-4e2a-704f-08dac8139bfb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:46:17.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KajLXsrTaGTVl3jc/+AkBY111Y4GDj9KuJGe05vJwC31R/aZpgEI7SQBstjCOTd8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mathieu,

Thanks for reviews.

On 11/16/22 10:38 AM, Mathieu Poirier wrote:
> Hi Tanmay,
>
> I think this patchset is ready to be merged.  Two things are missing though:
>
> Patches 1 and 2: We are missing a tag from one of the fellow in the DT brigade.
> They handle a lot of patches so let's give them time.
Sure.
>
> Patches 4 and 5: Michal's ack.  He already reviewed that code in the previous
> iteration but it wasn't added to this set, probably because you did some
> modification to get the patches to apply.  In that case it is usually fine to
> carry the tag since there isn't any modification to the code you are
> introducing.  But you aired on the side of caution and that is also fine.
> Please reach out to him again for another review.

Yes, I rebased on latest rproc-next and resolved merge conflict in those 
patches.

As it wasn't clean rebase, I removed Michal's Ack in case he prefer to 
review again.

I will reach out to him for reviews.

Thanks,

Tanmay

>
> Thanks,
> Mathieu
>
>
> On Mon, Nov 14, 2022 at 03:39:34PM -0800, Tanmay Shah wrote:
>> This patch series adds bindings document for RPU subsystem found on Xilinx
>> ZynqMP platforms. It also adds device nodes and driver to enable RPU
>> subsystem in split mode and lockstep mode.
>>
>> Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
>> contains two arm cortex r5f cores. RPU subsystem can be configured in
>> split mode, lockstep mode and single-cpu mode.
>>
>> RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
>> In lockstep mode, all 4 banks are combined and total of 256KB memory is
>> made available to r5 core0. In split mode, both cores can access two
>> TCM banks i.e. 128 KB.
>>
>> RPU can also fetch data and execute instructions from DDR memory along with
>> TCM memory.
>> ---
>>
>> Changes in v11:
>>    - rename binding filename to match with compatible string
>>    - change $id: value accordingly as well
>>    - Rebase on latest rproc-next branch and resolve merge conflicts
>>    - remove redundant < 0 check for function of_get_available_child_count()
>>    - return 'ret' variable rather than masking the real error code when
>>      parsing "xlnx,cluster-mode" property fails
>>    - remove redundant use of devm_free()
>>    - call  of_reserved_mem_device_release() to release reserved memory
>>      in case driver probe fails or driver is removed.
>>
>> Changes in v10:
>>    - bindings: rename example node to remoteproc
>>    - dts: Rename node name to remoteproc
>>    - switch to AMD email ID
>>    - fix Kconfig unmet dependecy error reported by kernel test robot
>>    - fix r5_rproc object mem leak in function zynqmp_r5_add_rproc_core
>>    - add explanation of hardcoded TCM nodes
>>    - remove redundant ToDo comment
>>    - remove redundant check of tcm_bank_count and rmem_count
>>    - remove explicit free reserved_mem in zynqmp_r5_get_mem_region_node
>>    - fix leaked reference of child_dev during zynqmp_r5_cluster_init
>>      Also fix possible crash in exit path release_r5_cores
>>    - do not remove mem-region and tcm carveouts explicitly in case of failure.
>>      It will be deleted as part of rproc_del. This also simplifies logic to
>>      use rproc_add_carveout
>>    - fix documentation all over the driver
>>
>> Changes in v9:
>>    - bindings: remove power-domains property description
>>    - bindings: fix nitpicks in description of properties
>>    - dts: remove unused labels
>>    - replace devm_rproc_alloc with rproc_alloc
>>    - %s/until/while/r
>>    - %s/i > -1/i >=0/r
>>    - fix type of tcm_mode from int to enum rpu_tcm_comb
>>    - release &child_pdev->dev references
>>    - remove zynqmp_r5_core_exit()
>>    - undefined memory-region property isn't failure
>>    - remove tcm bank count check from ops
>>    - fix tcm bank turn-off sequence
>>    - fix parse_fw function documentation
>>    - do not use rproc_mem_entry_init on vdev0buffers
>>    - check tcm banks shouldn't be 0
>>    - declare variabls in reverse xmas tree order
>>    - remove extra line
>>
>> Changes in v8:
>>    - add 'items:' for sram property
>>
>> Changes in v7:
>>    - Add minItems in sram property
>>
>> Changes in v6:
>>    - Add maxItems to sram and memory-region property
>>
>> Changes in v5:
>>    - Add constraints of the possible values of xlnx,cluster-mode property
>>    - fix description of power-domains property for r5 core
>>    - Remove reg, address-cells and size-cells properties as it is not required
>>    - Fix description of mboxes property
>>    - Add description of each memory-region and remove old .txt binding link
>>      reference in the description
>>    - Remove optional reg property from r5fss node
>>    - Move r5fss node out of axi node
>>
>> Changes in v4:
>>    - Add memory-region, mboxes and mbox-names properties in dt-bindings example
>>    - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
>>    - Remove redundant header files
>>    - use dev_err_probe() to report errors during probe
>>    - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
>>    - Fix memory leaks all over the driver when resource allocation fails for any core
>>    - make cluster mode check only at one place
>>    - remove redundant initialization of variable
>>    - remove redundant use of of_node_put()
>>    - Fix Comment format problem
>>    - Assign offset of zynqmp_tcm_banks instead of duplicating it
>>    - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
>>    - Remove rproc_mem_entry object from r5_core
>>    - Use put_device() and rproc_del() APIs to fix memory leaks
>>    - Replace pr_* with dev_*. This was missed in v3, fix now.
>>    - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.
>>
>> Changes in v3:
>>    - Fix checkpatch script indentation warning
>>    - Remove unused variable from xilinx remoteproc driver
>>    - use C style comments, i.e /*...*/
>>    - Remove redundant debug information which can be derived using /proc/device-tree
>>    - Fix multiline comment format
>>    - s/"final fot TCM"/"final for TCM"
>>    - Function devm_kzalloc() does not return an code on error, just NULL.
>>      Remove redundant error check for this function throughout the driver.
>>    - Fix RPU mode configuration and add documentation accordingly
>>    - Get rid of the indentations to match function documentation style with rest of the driver
>>    - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
>>    - Use 'i' for the outer loop and 'j' for the inner one as per convention
>>    - Remove redundant error and NULL checks throughout the driver
>>    - Use devm_kcalloc() when more than one element is required
>>    - Add memory-regions carveouts during driver probe instead of parse_fw call
>>      This removes redundant copy of reserved_mem object in r5_core structure.
>>    - Fix memory leak by using of_node_put()
>>    - Fix indentation of tcm_mem_map function args
>>    - Remove redundant init of variables
>>    - Initialize tcm bank size variable for lockstep mode
>>    - Replace u32 with phys_addr_t for variable stroing memory bank address
>>    - Add documentation of TCM behavior in lockstep mode
>>    - Use dev_get_drvdata instead of platform driver API
>>    - Remove info level messages
>>    - Fix checkpatch.pl warnings
>>    - Add documentation for the Xilinx r5f platform to understand driver design
>>
>> Changes in v2:
>>    - Remove proprietary copyright footer from cover letter
>>
>> Ben Levinsky (3):
>>    firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
>>      configuration.
>>    firmware: xilinx: Add shutdown/wakeup APIs
>>    firmware: xilinx: Add RPU configuration APIs
>>
>> Tanmay Shah (3):
>>    dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
>>    arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
>>    drivers: remoteproc: Add Xilinx r5 remoteproc driver
>>
>>   .../remoteproc/xlnx,zynqmp-r5fss.yaml         |  135 +++
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
>>   drivers/firmware/xilinx/zynqmp.c              |   97 ++
>>   drivers/remoteproc/Kconfig                    |   13 +
>>   drivers/remoteproc/Makefile                   |    1 +
>>   drivers/remoteproc/xlnx_r5_remoteproc.c       | 1067 +++++++++++++++++
>>   include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
>>   include/linux/firmware/xlnx-zynqmp.h          |   60 +
>>   8 files changed, 1412 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>   create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
>>
>>
>> base-commit: 6eed169c7fefd9cdbbccb5ba7a98470cc0c09c63
>> -- 
>> 2.25.1
>>
