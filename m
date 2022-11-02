Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077EA616E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKBT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBT6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:58:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D7304;
        Wed,  2 Nov 2022 12:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHWCi7uLIIjEwLZ6Clr/1OBRjuw4in3pL5rHH/e6+3O13Uwe2ynlsOazhGuHery2pO16a7USSh0l0I4kjX18gwhWycy5Rp5E4VEu0V7AfWyr4Btxm114hRNE1mD3Gj3FgQmkYpC+8VtNq3p8+JKZfwnH0edsV1zAu+SevWyt6aNffIXo3c1Mxx9emqE1QlN5bO8GJ/eJHTYzF/2DBIJFYZna3wSBWCZjaBUNH7VUBm7mCnBpOi/oq28hIOkwY+aOrW3KXfaP91AXlb3n3nh/8WjKmTGem/+LsC0JHPv7vzjD2u9JHRteN/H9RRw3/W15siJ9IlU3qX3QrsATj5zqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZsPbX74W/9YM2WWIUmaQMQWELRqaOiZaDUYzwcKpdg=;
 b=bPYj75XIZoF5RE+mtc59iJOKcXAWri5ulmgC8xTy+IdHnA/j6wcwAu6IAudtMXqNMjBEbLGohCapBbe3ECixHVmHvw7fD6wBcCryIdj5hRYvWcOIwzDsFfuSupjs6H2mYDfgc+U6H6yF/ITwHnT8n7TT98mVa0uCmUkoWRvYq7GHdgOndP0ZDxKVv3EGFQQHEEiAi+mp++D57XwOLEnIWg1IyKGTw75i/sZwHkNO+Jr6DOMvOhbSyKmgPD9U4wGE2VduvQku9YOgc6UhmDEPvOwa/DZy0vPDy3sYcDiRXfWawBRB9vBy558GiRC0lvMEGwOkv5b5O75YTz8xJQFWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZsPbX74W/9YM2WWIUmaQMQWELRqaOiZaDUYzwcKpdg=;
 b=RwkbUNMzcd4ta+UkR7gJKuvt9WHSz5GbcLTps6emNKJNN2X3fgtmci38uWRUO3O6AOBheLQxWoTWr3NZp+z+X2BYMAZmySoUmoxlzHKQRRsVll4PJGuEe4PkCOBDetiSSyvfeEfM5sMdIo45rMHMdpuhmk+ouMspcNciOcV/Uqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 19:58:07 +0000
Received: from CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::f14b:589:2234:9f37]) by CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::f14b:589:2234:9f37%4]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 19:58:07 +0000
Message-ID: <bf6aab60-9aea-5c76-60e9-84f409cdb1eb@amd.com>
Date:   Wed, 2 Nov 2022 12:58:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
From:   tanmays@amd.com
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/6] Add Xilinx RPU subsystem support
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
 <20221102195330.GB1733006@p14s>
In-Reply-To: <20221102195330.GB1733006@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To CH2PR12MB3688.namprd12.prod.outlook.com
 (2603:10b6:610:28::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3688:EE_|PH0PR12MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e77a73-2339-4264-fee4-08dabd0c8fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcj22IGCjnAyZHwTvM8EibZKjNEZ76btGgcAUDnnwK6n4aPFWZBFYNvoXkhMyjWFe1CpX/vZ5GUF5wWSoeYw2xlqIobdVdbQzGLltdsmaV6Yrw9pS+tV1MzJV+toLd0IMNsi4p36+yZasz7uMJukTGp1CpPLgd7uPx//pYmQIi5v8dhAQNwCxS8DdS3KnclKidNdPpEkEun1GetCQ7m8XaRvgH4IGEcd3wBCgiK0H3SvDa44HhdyTdt63wsppIIPpV20dHVDul0mtP7NSkpCCV0wfgLNEWn3bvFVh29FGfxlE4Ro2Edert7tn2+0yJc++e5thIn5dlCraDsNTa83BUOWPx9yHN+DuCSzKvFaGM91YkmzkBukZzQ+tOdmNKZ+PjN02EWQh0vXoI//+NpOHB/9Vak8Fbses/q+j6Z5xICw8JFIgEXUlL56HcrjZnrpBMYZOy1rGQKfbt22rgsPrQnkk6hCoEEEn2NbbSRzyR3zw2nQ+e9FsIN1a7f0BjW4cX8LWuGRfrjftsG0aKY06KHyK56IJB4RX+bRjVTtO2iBwOQhwZbXG8mhdW1jVKv4tAhZKFByTzo39L89AZ/gJLbJ+mLfuWu6iumZU3Inbi/q3RSvPy/CLwahopriLz70uFAfOvrm+851T/rJjK4AcgT9Shht7sq0Ihv720q+7wQVMLS7T/VGqOYuHMAE3I1JCKi5Kdj9RbnMAJDewIz9LlazZWAhqlGKRhxY1nRmBx7izq54t59+76MXMwnchSG2ZK5/Hjqs8LNWShlQsp3WgchXREXwC/TlKPHDDB2tAfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(31686004)(2906002)(66556008)(66946007)(6512007)(9686003)(6506007)(41300700001)(31696002)(66476007)(8936002)(5660300002)(110136005)(316002)(8676002)(36756003)(6666004)(921005)(6486002)(478600001)(38100700002)(53546011)(2616005)(83380400001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUR5SDR5anN1YzZJdlF4bzU4Ukdwa1h0ckU5NFlKWXBLcUUvMlhzdTZJREJQ?=
 =?utf-8?B?ekZuazFTbmVack5tdUtYdlZUdzA2UThKTDZNUTZwZmVhVlBtbUE0blB4d2Vi?=
 =?utf-8?B?bS9LNCtSdHJnVlZBYmdQc1VrUkZmZ3lmaDVGc0o1ZU5oeDE0VzN4d0hqTFhp?=
 =?utf-8?B?YXJvaG1yQWFXQ1pUWVUxTWgxOTVIbWxKQjluYUFuMldpUC9zMyt1VmorSVZR?=
 =?utf-8?B?VURnc2xLL0c2bE9DSWZId1hFdGdHTFRtTTdhOUZjMjdYZTVHVWQ2WUd5c1Ar?=
 =?utf-8?B?dTMvdVdwRC82bEkrQndnT2N1Ylo0WkVzK0RQWUxSdlB6ckp5ZnhMNDVCZHpB?=
 =?utf-8?B?MU41Yk1PanUwUGNNSHVudTcvODNJTDc1cVhGWWt6dWJSejY3OG1CSXdWUWl2?=
 =?utf-8?B?TXd6clNDbUlWYkc4SkF3RDBWT1hXWXZSdHBnYU5tWUZnZ2pBellBSjMxZmFx?=
 =?utf-8?B?ZVdmemRDN01NZEhNdEFLVndDeEpqN0dScXVqVmR5cXFDOXRuTllBZDVWQ1pV?=
 =?utf-8?B?Tnd5Um5RMndkUXAzZW1neTFvdDdZOWpwSGJFTGdOMTV1em9wMzdIYlNJbG52?=
 =?utf-8?B?cDV2QjF0SnRmWngxNnkvcG94Z1hsejhzK2pmSFROWGtqRFRnL0R3VjFhOXFw?=
 =?utf-8?B?VVMyKzRGaEwrMWVsRzZJRXVxZWh4RmhKZ3ZLaGR5MGlDRTlEV2RncUd5ZEZn?=
 =?utf-8?B?V0tTbGFTQ2dLVWljakJOaXI2NFUwenJqYUp6M2xyN1lUcXkvL2NmZUNhR2dO?=
 =?utf-8?B?NWFWZjRwV2dta3FPdnpGcUMrUnRrQ1RVNU5Sbit4eXhxVWpaYnQ1Yi85Vkh1?=
 =?utf-8?B?VFVPUktJdWpFaGFnVUNzaitZdFZYREx6S0ZSZDZWOXFMbk5BUlhQcmowMVR4?=
 =?utf-8?B?anJaWFI5YjFzQ2pNa3YrTERXTnM2MVV2Z3hRbXFwbXJRVFBqcUpkYXk4NTlM?=
 =?utf-8?B?b0gwOWZPNGJ6Mng4aDdnZjl5blF6T0pLbE9iN2QvVjNsazZqcnlMTzZWeVNO?=
 =?utf-8?B?TWNVVzBaUy9VR3FURFlFQ1pUclF2NW55MmRZc1FQd2ZaV2ZRNWV0YlJ3YUhT?=
 =?utf-8?B?NUZyQVQ5VWxoeGsxcXZHNHJzdmdPUlBmaVk5L3ZKMWlzWkRITzN3ajhkY2lW?=
 =?utf-8?B?QnlNVVZXSzRPT29uaVl3SGRxTWtNU29OSm50Kyt6SUZRUE1CKy9aWVNGNmxw?=
 =?utf-8?B?RVRSWG9FbHNpaG9odGdBcDVqb2lRR3kyT29kU2xxbFkyTksySzhvWmhOY2tF?=
 =?utf-8?B?UCtIakdXWTRIVU05WUFWUS9mR0dqelptS0gwdHVpRkJOUUFhclpvaERvNGZE?=
 =?utf-8?B?aEs4WVE4WDNRdFlmR1I4Tm1PakdYSFg0TjYzSHlWTFMyTlBLOVd3enQ0c2Zn?=
 =?utf-8?B?UW8zQVVLdC9UVnFHMU5qZWkrVmlqZHVLOEZXaW1KQ2dWZFRsQVhBbXlPbHFB?=
 =?utf-8?B?OUxLTExZNzlQZHovaG5TR3h2dzY0dFhZdkYwTlA4OUVuaWVBSG9qVjBsNW9X?=
 =?utf-8?B?cVJiWEFXTzJaLzVuL1JENHpKUjhkK1lWRktTc1FQa1V0MHZXUXZMNHRqaFp2?=
 =?utf-8?B?OG5YdGtQdHNCMEMwQURmK2N5eGFEWndwTGlhL1Q0SmE3Q2t6NHJ2dmlDdmpG?=
 =?utf-8?B?dElpamRPMjVoSC9DSHlLdTgreGtkZTQ5WHAvcUZKUGZla2h6c1ZtUHdnT3ox?=
 =?utf-8?B?UlRIOHBBRXZXVmJvS3BIdE5IN2NNcUJXbXdGTmM4amU0aUdpME81WE5TOXFz?=
 =?utf-8?B?RThRL3hGZ0xHOE81TFBlMVRmTHF2LzBxUzBJZW15djIzVlkrWXA3aEM3a0Ja?=
 =?utf-8?B?ZDRlUHh1U3NLTnNHanR6ZFVoakpLb1l0dzdQR1JWdk1GeTR5cDVFNVBGREU5?=
 =?utf-8?B?MWQrUS9sMW5mL3JPcVEwT0ZjVllYdm5yMTdNVEJtWndPWlhHVlI3cTZWSW5W?=
 =?utf-8?B?b3lEVFBKSm9rek9DTVJnREN5Skk3WDEzNVYyWmE4eVhkcW5la2grYWNtSTl0?=
 =?utf-8?B?YlErSkE5alQ5ekNpdy9lS1cvUXYycDdETDFQbnRhWnZmdE1KQWJHaU9kbCtu?=
 =?utf-8?B?V082aXQ2RUxQSVVjaE1uUHhwN0dORkIwOC8rUDdVQzliTmpuelVJN0hRZ3Bq?=
 =?utf-8?B?THlZWUZyNXFUOHQ3UHRRRVI4KzhVbW9RcmFmMFo3aXdVd1NnRVRqVVE4eVFZ?=
 =?utf-8?Q?IiIc/BEPOvNZOO91tYXLVzTHRyjjOH8gQ+hO1sVib8yI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e77a73-2339-4264-fee4-08dabd0c8fa7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 19:58:07.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx5pVXlbaMIo74AM34G/QolvWVHgqEX9jhNa3NcDZW7u0HNWBY6G/WnXzEBrZ17C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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
Sure, I will fix yesterday's comments and send new patch rebased on latest rproc-next.

Thanks,
Tanmay

On 11/2/22 12:53 PM, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> I am done reviewing this set.  Other than the comments from yesterday things
> look good.  There is also the fact that this set doesn't apply to the current
> rproc-next.
> 
> I hope to see another patchset from you in the coming 2 weeks so that can get
> this in for the v6.2 cycle.
> 
> Thanks,
> Mathieu
> 
> On Tue, Oct 11, 2022 at 02:24:55PM -0700, Tanmay Shah wrote:
> > This patch series adds bindings document for RPU subsystem found on Xilinx
> > ZynqMP platforms. It also adds device nodes and driver to enable RPU
> > subsystem in split mode and lockstep mode.
> >
> > Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
> > contains two arm cortex r5f cores. RPU subsystem can be configured in
> > split mode, lockstep mode and single-cpu mode.
> >
> > RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
> > In lockstep mode, all 4 banks are combined and total of 256KB memory is
> > made available to r5 core0. In split mode, both cores can access two
> > TCM banks i.e. 128 KB.
> >
> > RPU can also fetch data and execute instructions from DDR memory along with
> > TCM memory.
> > ---
> >
> > Changes in v10:
> >    - bindings: rename example node to remoteproc
> >    - dts: Rename node name to remoteproc
> >    - switch to AMD email ID
> >    - fix Kconfig unmet dependecy error reported by kernel test robot
> >    - fix r5_rproc object mem leak in function zynqmp_r5_add_rproc_core
> >    - add explanation of hardcoded TCM nodes
> >    - remove redundant ToDo comment
> >    - remove redundant check of tcm_bank_count and rmem_count
> >    - remove explicit free reserved_mem in zynqmp_r5_get_mem_region_node
> >    - fix leaked reference of child_dev during zynqmp_r5_cluster_init
> >      Also fix possible crash in exit path release_r5_cores
> >    - do not remove mem-region and tcm carveouts explicitly in case of failure.
> >      It will be deleted as part of rproc_del. This also simplifies logic to
> >      use rproc_add_carveout
> >    - fix documentation all over the driver
> >
> > Changes in v9:
> >    - bindings: remove power-domains property description
> >    - bindings: fix nitpicks in description of properties
> >    - dts: remove unused labels
> >    - replace devm_rproc_alloc with rproc_alloc
> >    - %s/until/while/r
> >    - %s/i > -1/i >=0/r
> >    - fix type of tcm_mode from int to enum rpu_tcm_comb
> >    - release &child_pdev->dev references
> >    - remove zynqmp_r5_core_exit()
> >    - undefined memory-region property isn't failure
> >    - remove tcm bank count check from ops
> >    - fix tcm bank turn-off sequence
> >    - fix parse_fw function documentation
> >    - do not use rproc_mem_entry_init on vdev0buffers
> >    - check tcm banks shouldn't be 0
> >    - declare variabls in reverse xmas tree order
> >    - remove extra line
> >
> > Changes in v8:
> >    - add 'items:' for sram property
> >
> > Changes in v7:
> >    - Add minItems in sram property
> >
> > Changes in v6:
> >    - Add maxItems to sram and memory-region property
> >
> > Changes in v5:
> >    - Add constraints of the possible values of xlnx,cluster-mode property
> >    - fix description of power-domains property for r5 core
> >    - Remove reg, address-cells and size-cells properties as it is not required
> >    - Fix description of mboxes property
> >    - Add description of each memory-region and remove old .txt binding link
> >      reference in the description
> >    - Remove optional reg property from r5fss node
> >    - Move r5fss node out of axi node
> >
> > Changes in v4:
> >    - Add memory-region, mboxes and mbox-names properties in dt-bindings example
> >    - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
> >    - Remove redundant header files
> >    - use dev_err_probe() to report errors during probe
> >    - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
> >    - Fix memory leaks all over the driver when resource allocation fails for any core
> >    - make cluster mode check only at one place
> >    - remove redundant initialization of variable
> >    - remove redundant use of of_node_put()
> >    - Fix Comment format problem
> >    - Assign offset of zynqmp_tcm_banks instead of duplicating it
> >    - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
> >    - Remove rproc_mem_entry object from r5_core
> >    - Use put_device() and rproc_del() APIs to fix memory leaks
> >    - Replace pr_* with dev_*. This was missed in v3, fix now.
> >    - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.
> >
> > Changes in v3:
> >    - Fix checkpatch script indentation warning
> >    - Remove unused variable from xilinx remoteproc driver
> >    - use C style comments, i.e /*...*/
> >    - Remove redundant debug information which can be derived using /proc/device-tree
> >    - Fix multiline comment format
> >    - s/"final fot TCM"/"final for TCM"
> >    - Function devm_kzalloc() does not return an code on error, just NULL.
> >      Remove redundant error check for this function throughout the driver.
> >    - Fix RPU mode configuration and add documentation accordingly
> >    - Get rid of the indentations to match function documentation style with rest of the driver
> >    - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
> >    - Use 'i' for the outer loop and 'j' for the inner one as per convention
> >    - Remove redundant error and NULL checks throughout the driver
> >    - Use devm_kcalloc() when more than one element is required
> >    - Add memory-regions carveouts during driver probe instead of parse_fw call
> >      This removes redundant copy of reserved_mem object in r5_core structure.
> >    - Fix memory leak by using of_node_put()
> >    - Fix indentation of tcm_mem_map function args
> >    - Remove redundant init of variables
> >    - Initialize tcm bank size variable for lockstep mode
> >    - Replace u32 with phys_addr_t for variable stroing memory bank address
> >    - Add documentation of TCM behavior in lockstep mode
> >    - Use dev_get_drvdata instead of platform driver API
> >    - Remove info level messages
> >    - Fix checkpatch.pl warnings
> >    - Add documentation for the Xilinx r5f platform to understand driver design
> >
> > Changes in v2:
> >    - Remove proprietary copyright footer from cover letter
> >
> >
> > Ben Levinsky (3):
> >    firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
> >      configuration.
> >    firmware: xilinx: Add shutdown/wakeup APIs
> >    firmware: xilinx: Add RPU configuration APIs
> >
> > Tanmay Shah (3):
> >    dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
> >    arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
> >    drivers: remoteproc: Add Xilinx r5 remoteproc driver
> >
> >   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  135 +++
> >   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   32 +
> >   drivers/firmware/xilinx/zynqmp.c              |   97 ++
> >   drivers/remoteproc/Kconfig                    |   13 +
> >   drivers/remoteproc/Makefile                   |    1 +
> >   drivers/remoteproc/xlnx_r5_remoteproc.c       | 1070 +++++++++++++++++
> >   include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
> >   include/linux/firmware/xlnx-zynqmp.h          |   60 +
> >   8 files changed, 1414 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> >   create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
> >
> >
> > base-commit: abac55caaeaaabd31763a7c8a79c4cc096b415ae
> > -- 
> > 2.25.1
> >
> 
