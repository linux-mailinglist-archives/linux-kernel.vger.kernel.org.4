Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C697F70EAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbjEXBjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjEXBje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:39:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257A130;
        Tue, 23 May 2023 18:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA61dBvV32YO4DiN6ZUZ1cBwsyUgNRrfvWl6KFrN1eOnPg2FQligu4jJK6RCnGXReNrralPNvkYyURIMcWt/JaosWmqcC89LHrf+6uQgo9JnSz0PBJ9vOAp4oebipHxMFht8LACVjaWDhW4OtfNVNJfFePWRxCNUoVeXH2gvnaEklG7xcbFFFQ+8+8WJZelpdzyXXotBEqh/IqNFEH+jEe8aLNqL99/ava6Hr9UZ6vohNzR3uNMvIPdyNkAL81T3xdF5D4IKCN60owxakdyNPs1ol1sJbMxvYRSNqhLqU7ZFehGhL38odktGLqFwj7/ZjpPy5Ne0kKv3L4h76X+GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RlvWsH0rPTLCupkHcO3lmyy5hXKQ3qB8FkH7ba1y+g=;
 b=Oqx2OSmJ3VIw9vnXcdt5CeboqZXn+43q2WlMWWFeExA3K2OPHefmrqout18hg/FficP1hx2D8FsyWTfP/DZ0lyM1Lz4Uzr3yLJ+yU9m3hAxK8R9I6T6oJS95+Dt0mz3yQJ+Uo1IidDUiFpj5S6qUy44MBD9spL/a1bP3fWH26gEi2DxLBoEScI5c+ClyQDGHwsml4HuVlDS7SeTqTq0mXay6T18NSXnE3/j2qmY+eiiKAvfj2zlCVegAyXDAzEwKiaWUkHdfCUFkeCTfxzwz6bWQrcOxkAO9ZF0xT8jh1oIhY23O/ey6P/xeCzw5vQt+qCFwPIiH/A43MSFBQTGGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RlvWsH0rPTLCupkHcO3lmyy5hXKQ3qB8FkH7ba1y+g=;
 b=QPGsz+O6vm2aA2/t0x6ib3qrezavKTTrJgvWuHOd62raCD4DEuZExfYOWa16W7WqlDldaKZmhk3v4q1XRqRK+ecW8kBvOGXwPiNGmYr2eo154JfcVzuhJq6pRNqxuOPnZpBs4xFpk4JlWwWAAAy7BuaL8Q5b2UwggpnO66Y7Ktg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 01:39:30 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 01:39:30 +0000
Message-ID: <77c70014-ba6d-0488-609e-08cb8a0ee011@amd.com>
Date:   Tue, 23 May 2023 20:39:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/23] cxl/pci: Add support for RCH RAS error handling
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230523232214.55282-1-terry.bowman@amd.com>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4a098c-6836-426c-d427-08db5bf7b789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDmAGI1kCDwYNpl2+hrphWJZ0DZhLse5YKLVSaiZo2Re+yD5Wh06/aBKBFVdJZl+erF1lTCI0NJhwP27tjVaDzrnFYPn6NCvFQLHsvPpw7083t5D2EtOxTXCsA7AHKVqhHqIUo09DLuq9xGVESZWyNtMCY77pHMG+E4glOesyx8BWUdb45V4oF5oCDUKun7EJjVz+qgpvba0TIaPyN8ySKReXuTxTZjFcFv9wOPoSjKlqB4Ub9I7YqpaAE61+yyPRTWJlX8xQgbm+0d/EshlzrROitI/Do/NgzEEQ6KruO5Q7Aldk5UoN+OO/m+BpbuOSGcQzBpVltLmXzOzw3Qtzpm9xjK6gRm10KW35qWYU+3zJSH1hIRRADXFB2TieMwq/Z/5nFZj0rk5M6G5G787UfV7aI3+4Cge5hz/5LOSHpo2M7Nxz5YOIiTwRGdMeGQL2op8QnM0gW+UkTzSbODKd8+pMQ9tNi5rLwIY2+kgIXCNsc6T/eCmQROV6qDJl/exZaQa0v+DICCnMLPmpzVEnHUl6dH/r8vch1s2O3zVHkN16wzf31g0BGY6OVuQTJHXxSU/67Li8Nm8NLSSKIWlJYqY+QnpDPf4OXlrCP6taTbzkWSRqO4smAlJpYTMyQXky4PkIsrF/QbROs1omknWwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(41300700001)(6486002)(31696002)(66946007)(316002)(66556008)(66476007)(4326008)(8936002)(8676002)(5660300002)(31686004)(478600001)(86362001)(38100700002)(7416002)(53546011)(186003)(6512007)(6506007)(2906002)(2616005)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGd1TFlIL2hpQUxsT2J0VWdab2RNTjg4SDB0RnRrQ25pN1ZIa0pabEY2NkhD?=
 =?utf-8?B?RjVtK2RHSCtSZmVYbzVZK1plVktPTG9VUS9pYVdqWGxSc2plVG5mTHAyNHk1?=
 =?utf-8?B?eEdnREFzUEcrNVRJbGtTcDEwTVFmUmFoSlNKWElGK01PVEVROUhObTl6RGFa?=
 =?utf-8?B?cHRZOEltK1dleVpZdWNPVG16cFZmWk9pQU1CdU1yU2dPNUhKRW9MTno5SUN4?=
 =?utf-8?B?bHVFWUt3emtVUlR5WlFEU3hqR1V5ejRyVThlRWZQVGRuOTRkVDJoVzZnYW9u?=
 =?utf-8?B?ZUYwamtMQUsrbVBPdTRhbXdtRURERDZsQjR3RkFBajd6VUE4U3dnOXlEN0w2?=
 =?utf-8?B?bEJyUTBKQTBjeEUzUjV0OTB2bVR2ZTEwRkl1RkV2RitrbElwL1NKM3NiWHFX?=
 =?utf-8?B?MllpaGtJS2xEc00xaVFCNlF0ZkZjNHpuUGNxRG1jdThZMTBqbnRubHpubG93?=
 =?utf-8?B?ZHhETFNyM2cwMDBNQkFBR3BOazFkU0xxSSsybjQ5MVlRY2pUM3VaMlF0MWRJ?=
 =?utf-8?B?QkprQ2YwcHNhMlM3eU8xemRnL2lUMmEyMndReCt2SDRjcXNYTTh6Ri9CUFVx?=
 =?utf-8?B?YTBmZXNiZUdNZnJjWTh4S0tJUFhLZkNOcTFGVllWaWpWYUhDMXFYVnVOSlpk?=
 =?utf-8?B?V0I1dFNkUXl0b3dPTTVCSW1uWGJ2UEhzTGpmc254cTdGOEh4a1d3M3gyTGdG?=
 =?utf-8?B?eTdNNUdYSUQ4VytYSlVXaHRxZFdDa090dSsrZnVhRWRjVG5KZHZpREhhSUR2?=
 =?utf-8?B?Qzgra2xhcURDQktvQzd6MXh4aFI5d3l3azNCME15ZXI4bDFsaFkzeWtlN2c3?=
 =?utf-8?B?NUY1am9STjN0TVhIaW9IcVdwUlFRWjBXZ1FxVUFrL0d3NW9PTzdjWnpmQnN6?=
 =?utf-8?B?K2RPRUR3c09COWMrenI1SXpZTVpJU2pnR1Y3OFUralVRWURXMmFiczAyTlox?=
 =?utf-8?B?K0F5ZjdaaExJYjZHU09sc0pHY2d4Vld5bGRnRkN5Y2lnc3ZTMDRERExhalpn?=
 =?utf-8?B?Y1VSL0dIaHdncGNVMVBXZzZqYytwa0prdm1ubHE1b212bkVrdDlyQ3MxRXhH?=
 =?utf-8?B?QkN6aXg4ZjdpYzA1dXA0ZGpjeGJlSys1TU8yTDE2bUxMVlJJM3V2cStQNEFS?=
 =?utf-8?B?eU43UFlvSWRFRnlSV3NtK3o2Ynd0ZEdPVHpsL3lVOSs5TkFJdTZ5bjBmeHBw?=
 =?utf-8?B?cmZEdC9BTFBuUGtGb2dMeHorTG1kbXEvQUZiRDcvcmNuRVFLdXFOaEJ5VThQ?=
 =?utf-8?B?SndaU05hL1l4R0dRZ2tIOCtJMmRwRjZRSlpYOU4wKzBWNy9aNHJQSVNwb2JY?=
 =?utf-8?B?SzlMZU1yeWJzWkRiUjVNYXNVMmVEUmtDM3NaaUpKMzB4d0hNd2x3ZzM4WFdk?=
 =?utf-8?B?QjU2YWhyRm9lOTdwTnRHVUVNY25TRmR5ZThCc1lkVS9oZWNnbU1hM1EzZE5a?=
 =?utf-8?B?Z1ZXbStlZGxzcGc3NVBQUHVQazJZK2V5eUpTcjlkUHF0ZTdLalZNYXc4ZHhU?=
 =?utf-8?B?S1RXTUFlOU41ZzdyMlkyaEoxaGk5aDVGUU13aVVjVGhTQllMbkVLSytHYjd1?=
 =?utf-8?B?QXBpV092TEl4VFdJaFdFQ25ocGZnQkdsRXk2YlB5dHhTa2kxY04vNzRqMFlh?=
 =?utf-8?B?azZBd3hSYThDbU1oditwTXdERkw4a3p5NXNHWkpWbm1RWFhobjZmb2UvaGZw?=
 =?utf-8?B?Szl2Yk5KWFBTSGtMbk1TOXRQcHVhZ21RUzhWUmVOYlIybFZaaFdnZWFGaFAr?=
 =?utf-8?B?OU10RzAvMHlkY2xxSTFYdmcvcTBNUWo0cXVnb1dldHd6RXhzZnVpUmZtVk5U?=
 =?utf-8?B?R1V4UXBjeTR6ZWJrakxYZHlqMWZCcUJEVzYzZCsvUjlhamU5R0VyMGhpbm9H?=
 =?utf-8?B?czBRK0JubktYNHlFREo0Qnp1WTVhVUdzMm9tKzBSdVBXQjVGMHM2Y05tRzAz?=
 =?utf-8?B?VUh6Qkt0akJsdE9CbDJCZnpVTWFoRkZ5anJJNVpyZk80ekxWcTlCTkdVVzZK?=
 =?utf-8?B?TlYxYkIrWU5MRUd0M1F1dXh2WE5MQUlSS0MwTHNFaFZSQUlBRDNjV1RZS3c0?=
 =?utf-8?B?ZjZNWTNua2xmM3lZS0tuaFNnUnk0VStIREZHcFAxM3FwSzIrdlpFa2ZXKy8z?=
 =?utf-8?B?cEpoL1lpeEluOW5OVklYYllOUmp3VElpRXUyN3VUbDAxd2hEazc5NDgzNXg4?=
 =?utf-8?Q?RHT6LdVJKC/dWdMjXrFfmyOo7+ePMfJYlvuNMR8G5IPO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4a098c-6836-426c-d427-08db5bf7b789
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 01:39:29.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq5kxhWtJzAfsXzXie0hxMnwoyX+vZDRKa30D6n87R8WXFr7Eck7liKkFQ6GFjMLRY+eyoyXOnFwmPodI8vjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropped the change log somehow, Adding here.

Changes in V4:
 - Made port RAS register discovery common and called from
   __devm_cxl_add_dport().
 - Changed RCH AER register discovery to be called from
   __devm_cxl_add_dport().
 - Changed RAS and RCH AER register mapping to be called from
   __devm_cxl_add_dport().
 - Changed component register mapping to use common mapping,
   cxl_map_component_regs().
 - Added cxl_regs to 'struct cxl_dport' for providing RCH downstream port
   mapped registers used in error handler.
 - Refactored cxl_map_reg() to be like devm_cxl_iomap_block().
 - PCI/AER:
      - Removed patch for cper_mem_err_unpack().
      - Renamed cper_print_aer() to pci_print_aer().
      - Changed pci_print_aer() export to use
        EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL).
      - Improved description of PCIEAER_CXL option in Kconfig.
      - Renamed function to pci_aer_unmask_internal_errors(), added
        pcie_aer_is_native() check.
      - Improved comments and added spec refs.
      - Renamed functions to cxl_rch_handle_error*().
      - Modified cxl_rch_handle_error_iter() to only call the handler
        callbacks, this also simplifies refcounting of the pdev.
      - Refactored handle_error_source(), created pci_aer_handle_error().
      - Changed printk messages to pci_*() variants.
      - Added check for pcie_aer_is_native() to the RCEC.
      - Introduced function cxl_rch_enable_rcec().
      - Updated patch description ("PCI/AER: Forward RCH downstream
      port-detected errors to the CXL.mem dev handler").

Changes in V3:
 - Correct base commit in cover sheet.
 - Change hardcoded return 0 to NULL in regs.c.
 - Remove calls to pci_disable_pcie_error_reporting(pdev) and
   pci_enable_pcie_error_reporting(pdev) in mem.c;
 - Move RCEC interrupt unmask to PCIe port AER driver's probe.
   - Fixes missing PCIEAER and PCIEPORTBUS config option error.
 - Rename cxl_rcrb_setup() to cxl_setup_rcrb() in mem.c.
 - Update cper_mem_err_unpack() patch subject and description.

Changes in V2:
 - Refactor RCH initialization into cxl_mem driver.
   - Includes RCH RAS and AER register discovery and mapping.
 - Add RCEC protocol error interrupt forwarding to CXL endpoint
   handler.
 - Change AER and RAS logging to use existing trace routines.
 - Enable RCEC AER internal errors.

Regards,
Terry


On 5/23/23 18:21, Terry Bowman wrote:
> Patches #1 to #16 are a rework of the Component Register setup. This
> is needed to share multiple CXL capabilities (HDM and RAS) for the
> same component, also there can be different components implementing
> the same capability, finally RCH mode should be supported too. The
> general approach to solve this is to:
> 
>    * Unify code for components and capabilities in VH and RCH modes.
> 
>    * Early setup of the Component Register base address.
> 
>    * Create and store the register mappings to later use it for mapping
>      the capability I/O ranges.
> 
> Patches #17 to #23 enable CXL RCH error handling. These are needed because
> RCH downstream port protocol error handling is implemented uniquely and not
> currently supported. These patches address the following:
> 
>    * Discovery and mapping of RCH downstream port AER registers.
> 
>    * AER portdrv changes to support CXL RCH protocol errors. 
> 
>    * Interrupt setup specific to RCH mode: enabling RCEC internal
>      errors and disabling root port interrupts.
> 
> Dan Williams (1):
>   cxl/rch: Prepare for caching the MMIO mapped PCIe AER capability
> 
> Robert Richter (16):
>   cxl/acpi: Probe RCRB later during RCH downstream port creation
>   cxl: Rename member @dport of struct cxl_dport to @dev
>   cxl/core/regs: Add @dev to cxl_register_map
>   cxl/acpi: Moving add_host_bridge_uport() around
>   cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's
>     port
>   cxl/regs: Remove early capability checks in Component Register setup
>   cxl/pci: Early setup RCH dport component registers from RCRB
>   cxl/port: Store the port's Component Register mappings in struct
>     cxl_port
>   cxl/port: Store the downstream port's Component Register mappings in
>     struct cxl_dport
>   cxl/pci: Store the endpoint's Component Register mappings in struct
>     cxl_dev_state
>   cxl/hdm: Use stored Component Register mappings to map HDM decoder
>     capability
>   cxl/port: Remove Component Register base address from struct cxl_port
>   cxl/port: Remove Component Register base address from struct cxl_dport
>   cxl/pci: Remove Component Register base address from struct
>     cxl_dev_state
>   PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem
>     dev handler
>   PCI/AER: Unmask RCEC internal errors to enable RCH downstream port
>     error handling
> 
> Terry Bowman (6):
>   cxl/pci: Refactor component register discovery for reuse
>   cxl/pci: Add RCH downstream port AER register discovery
>   PCI/AER: Refactor cper_print_aer() for use by CXL driver module
>   cxl/pci: Update CXL error logging to use RAS register address
>   cxl/pci: Prepare for logging RCH downstream port protocol errors
>   cxl/pci: Add RCH downstream port error logging
> 
> base-commit: a70fc4ed20a6118837b0aecbbf789074935f473b
> 
>  drivers/cxl/acpi.c            | 191 +++++++++++++++++++---------------
>  drivers/cxl/core/hdm.c        |  59 +++++------
>  drivers/cxl/core/pci.c        | 140 ++++++++++++++++++++++---
>  drivers/cxl/core/port.c       | 157 ++++++++++++++++++++++++----
>  drivers/cxl/core/region.c     |   4 +-
>  drivers/cxl/core/regs.c       | 152 ++++++++++++++++++++++++---
>  drivers/cxl/cxl.h             |  56 ++++++----
>  drivers/cxl/cxlmem.h          |   5 +-
>  drivers/cxl/mem.c             |  16 +--
>  drivers/cxl/pci.c             | 109 +++++++------------
>  drivers/cxl/port.c            |   5 +-
>  drivers/pci/pcie/Kconfig      |  12 +++
>  drivers/pci/pcie/aer.c        | 173 ++++++++++++++++++++++++++++--
>  include/linux/aer.h           |   2 +-
>  tools/testing/cxl/Kbuild      |   2 +-
>  tools/testing/cxl/test/cxl.c  |  10 +-
>  tools/testing/cxl/test/mock.c |  12 +--
>  tools/testing/cxl/test/mock.h |   7 +-
>  18 files changed, 824 insertions(+), 288 deletions(-)
> 
