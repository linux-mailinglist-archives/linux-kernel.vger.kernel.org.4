Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310A6BB193
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjCOM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjCOM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:28:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415999BA64;
        Wed, 15 Mar 2023 05:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRZh0Yj6Wk1Zlo3k2KiLoHLvx2h2cOmZncvb9kjCb0Xk/7XHnVqJSK42/w6NWp0A3fWTHPM+XOTdl8v+9Qu6AyOQzwmodnKH5HtYAaYtCGJMTGfUYld0Gv2UPqJSW2vjphW8OCuhkwAyd+gBKLGVMXZ/Vkaq5h5xpzHZ/vCwQoeC1WxbYO68FbrFCcYddESd+KriiQaNfsDZSjYNmr90fo9T66I4rT1ja+ZoQXYBufkKjp7/ohZbXyov6VfhSwMml3Pf2RFipcqqMGvNmNQkYK2DJPtyKQFHtBrC/ryDs+bU94gMTE51PzWbCDOFu+/FOCoZ4lvBCDYxMUim0RR2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ86oH1stlIhCmCp8iXjIUa3vhOZkKyFcrbF6PRkIjI=;
 b=REaLorliXCbY46jBQk/3FZ5f0Xca2u/9GiDGrO/s7lHfOOhPTsXymaD/lJEphZCBXFaQjX2P/knTsZyue/61bQAu8gMzJBUaP56mxz2AdStO2IoTGq+KnCztBF0+ktgUcWuhl66dRVxtHzfbvS3zJ4osBkHPmf+lwZINxCklwr4djCzCTcE3QgwTzOFgdjrNBt9Lfaaqdo+LRRWda+gXx3MbCBmlOaNICAb+UysyyGrMi5FUB/UZe0WcUUS3AybEbQ9LhF2kK0ZRDMQ9TqriXMs3WlSuV5fpF2+b9xhVSTEMs1asNox2wyS06IjxCPuYDm4LKwuKwj4B9bbpPQ9Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ86oH1stlIhCmCp8iXjIUa3vhOZkKyFcrbF6PRkIjI=;
 b=pphA9KVwJraOhgn9OZ2W5JDSd1spcMcytslNMx4Ib/H8RojArw43fp/CMBO6W6Vpid+EywqF+9UZipH4ePhEe6ETjp+q0vYebXLA8ZQIJANbUlfetzsoSNLooOLequcjFIuhL/OCoJVoAEZMNWnQYOxhGbxcV8pKYJov0sJl80LWvYhAx8iulYMP5LFXpH5XiwH098Mtf4Eq+bxzIcwtIek091rKXVj+LxnP3jFHo5lc6z86b/hUUz83YHTSDF20U22doXmU1RWsLu5q4QscfvsY1nORYfBZ9b8CiEJtBUpcJ23D84OqCkU0mMOICISPuKk689wfMUSnpWeNyj1f4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 12:27:17 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 12:27:16 +0000
Message-ID: <4dda3890-e910-625e-e7ed-6b6c0bbbd9d4@nvidia.com>
Date:   Wed, 15 Mar 2023 07:27:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230314135128.2930580-1-sdonthineni@nvidia.com>
 <871qlqif9v.wl-maz@kernel.org>
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <871qlqif9v.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::26) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: e05ef8c6-3a55-435a-37d4-08db25509cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+WjBC2VjdcsAVt5s2hBTM5Bk0eyXcguymmS2UftvTGQ6rTLSW0ObwP88PdxAUesL2o6zsj7wRVMYyuGZpbXM/XMyyB7lLdwv9IAn1Phnt1r5c+IpbKgiexvoPBvlGKqD8+uVzm6jVMPDx2HbIOXmfVVQKzBj26rL3Pl9XuiMctWENb4iTV/Ycykr930I8ussF63CNJZqoAsFIuhfx0hz17ck9FN9fTvDodirX8+PReIo96RHMxKb7Sd4aNXTlgit3rN+8+i4r2fyUEx/MZmEW7e9MhqM4SIcqhi/pfO6rz0l1eblCHzO54ZXr3BXBsQdq7E4VtCA4ymE+uWVyklBXdFGyR1wq39rMGVvT5T9Y1u9HRBqbzA/OxOwVJsg791GvrWDgu389NpZrUwjBd9AV3ri9C1gDwpSWIrj8aude61l5R1zqXlupZgjUHBJ6wUDfevdWy6rrSv4urZ0YeltFQX903Cm/jpsq+ScTbl79xASvk6lXJ+4YG3VYbaXrJTyAHrkecv3enUkJKdh5L3oLcRbIF1NHfMhmSbV6mLFPCW7E1lTMSBBkapgGrguL4pfQz1FkBUcwBFobfQfy1/fR5cV1oqJvzGeabfnzRKcecQ0WFC3F1F34mVLLJ+hohh7NDQYK0MzrWBS+gUNGewVTd09Wi7sUOQKKP2/dV7oc/Xe1AtZhMXKXD9W5HlPR/zY2PJEtLa8kZElJPrm6szsgt4HIryxZGb4kgYB6M6kMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(31686004)(36756003)(4326008)(7416002)(8936002)(41300700001)(5660300002)(2906002)(38100700002)(86362001)(31696002)(478600001)(66476007)(8676002)(66556008)(6486002)(107886003)(66946007)(6916009)(54906003)(316002)(53546011)(2616005)(6506007)(6512007)(186003)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktKRHgvYi9nVDkvdUpZZ1V3SlFlTWg4NmJhend4U1B1aWJjWURlbkloUXd5?=
 =?utf-8?B?WjEyZWdYd0FDNU52L2I5RXlzQ1JhcjNUMVpPRWJJTHc2Y0tteWRiMTVNT3hN?=
 =?utf-8?B?NGdjb1Y1R0tDNEU3VmhFWFpIRUFLQms3WlNHWWJIcFhMVWUrVjhsTFZXaFNO?=
 =?utf-8?B?QUNkLy9STTVRZlAxUExYc2ZMajFkeEk1eEY2QnYvYy9OclgyZHJZdHNGcERn?=
 =?utf-8?B?ejRJNkxFa3pSOVBpY2k0d1hTenR4MklzdU5ReFFCUmNVVnhWY2E3R0Y3MGda?=
 =?utf-8?B?SitoV0ozL1BEOVJwUE5mMWdJRFNJazdPaDM4Nnd5UVY1Qlc0MTlVS2VjRDRK?=
 =?utf-8?B?WUhCMEtMYkJMdElmcW05OEhKZUhzOE15QkNtT2psaS9vSDl0QVNKdHNyZXh2?=
 =?utf-8?B?SmthaDlnQ1lmbDc0WVB3RUFWbkRrWG1EdThEZHA4N0l0bk4yeWw1czFZRTEr?=
 =?utf-8?B?UlhzbEJWK2FqcWxyWTJDblI1T05ic01WNUlTczFiZ3BacU1zMVR4VGF6QlRY?=
 =?utf-8?B?UVJVRyt3cDlWekgrRkVxOThxeTZPZFZQZEIyQlJtWjlLN05TdnFMNkxncGE2?=
 =?utf-8?B?Q25xdkZhWXFhOW9rek9WVGNFS1A0ZmJOUFdFUHdqYm40UHQxdjFjUmZkV2Qz?=
 =?utf-8?B?ZFJoRjdVMFdvYXZXYzBYNS9jTlRGRm1oVEFzT25KamVWQ2ZrMWFSRjA1aFVV?=
 =?utf-8?B?UjhnbVpnVUlnZzZ1dzFKVmhGamM3Tkh4V0llMjg3aGRDZm5QTXc5eDJhaU9k?=
 =?utf-8?B?VThweERyVEplOWVHcDZGQVlObW9BU3pnRW0xc1VFemtHNU1OY3ArcjdLc05H?=
 =?utf-8?B?c3EwdmUwRzg0WnAwNDNHTW1DS1dEK1dLdGlvWEhHTHhDMmwyZnQwVDAxYUs2?=
 =?utf-8?B?bDlra2FyVHN4TFBoU3VLZnl6L3MyVGRmcTVoMEhkYy9WcWtoRmFQOEdxajFZ?=
 =?utf-8?B?MFRzVHFLc2FjYlRndzZ4Mkp1QUdXOHR0UGVzMTUyek5UWUJMOTBXWVlHQm95?=
 =?utf-8?B?MlhrZkFpUmMyRUN0K09hbmdvUDZKK1plWEpTd3lVU1ZWektiWTRUTy9peVcy?=
 =?utf-8?B?cVVYNEJQanlFSGk2ZEdST01tSW5jeWUyTm9CWW5DZnZ3WWo3eHBDMExxbkN4?=
 =?utf-8?B?bWU3TDRoZWZ4RmZDZXZxaGRHR3lIZzJJTHNPcTNPZXA3N3VTdE1maUpQWkY1?=
 =?utf-8?B?Y1oxQk5uRmxYZTVqL0k0bUM2UnhVNGZQWS9tVTIrVVNXU2hEZVBocTFTUzJQ?=
 =?utf-8?B?cjY2S2tmZFExR2RtamxmTjllc2VzeGhiNktYRWplKzU0S2tEcVF0WlpRcSsy?=
 =?utf-8?B?ekFZSW5NY0poelp2d1ZpY0toZnZMZHJibVpRdlhyS3MzWVNSeVMyR1ArVncv?=
 =?utf-8?B?YXdCVkxxNkVvcGFRd3BDRmliZkNhTE1ZOW5PcHZIcGwyT2ZLV3VldzFjbnMx?=
 =?utf-8?B?bW1mV0h3NWpZOW5xT3ZxWmhTbEc3c1d6cHhITlA5RDl2cDRYRDFNMXhPZlYw?=
 =?utf-8?B?ME9FTXk0MVJyemRZeWU1Q1hYd1ZjemhlQ3RERWNTcjEyZWptS3E0Z285b1ht?=
 =?utf-8?B?WVlvS0cremVyTmxWb0Ywb0pwM3gwREI4S2ZzN2QxbUFWZW1yRng4blBIT0Jr?=
 =?utf-8?B?eUtKUHN4V0RLSGlrSzlCaGVqaXVtOWNIbVBqQUxtTHkwRFlxV1RwN3RLU2lO?=
 =?utf-8?B?SFkza3pvaGlsWmVYMHU3bmNxaGhoaXdJaW84SHZkR2ZCdXJIelZyL1hWaXpW?=
 =?utf-8?B?WlJHa0JhRWgvRUI2L1A1QytLazI3TkxOeW5IVExTVlZIaHJOTnUzUkV1ZkpS?=
 =?utf-8?B?OFJmSGJUc0l3bE90bUNmSlNDS2pmN1ZYWTlmSDlQZWViRDkzNWdKaHJaZDZy?=
 =?utf-8?B?cG5uZUlKN20wblVCT2sxcEpUWFB1cWo3TEZLQlRER2NmWk52VzFYRVk5LzFW?=
 =?utf-8?B?cTBlWGZ6dUJrQVJDQUN3Y01FdUIwZ1hBYUU4OXJzbUJGa2g0RlkvcDBPY2ha?=
 =?utf-8?B?NVd3OXBsR2lwS2FjRHRUTUJXd2tkWm93cXpDNHUwS0owZkt3TU0zcHVXcWt5?=
 =?utf-8?B?MkxPMDMyc2x5alR0WDJDeUVzcDhiaXlib08zTXRrV1dBVk10NmxmTm8ydjVD?=
 =?utf-8?B?SU9qVTAyZmFrS3hhZ2RHSVhBZSszM0FsalRTdUN6azJBZ3RBb3hyUjRhZmRE?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05ef8c6-3a55-435a-37d4-08db25509cfe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 12:27:16.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXU0jZE9SrG7KaQ2h1mKXk2NhZ2XDJcQ4k+C1rF+NXSyZKO83BTNrGFqjXL/zZhL6zvVahPnKAHFYzqJcQbhIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/15/23 03:34, Marc Zyngier wrote:
> Please don't duplicate existing code. There is already the required
> infrastructure in drivers/firmware/smccc/soc_id.c. All you need to do
> is:
> 
> - disassociate the SMCCC probing from the device registration
> 
> - probe the SOC_ID early
> 
> - add accessors for the relevant data
> 
> - select ARM_SMCCC_SOD_ID/ARM_SMCCC_DISCOVERY from the GICv3 Kconfig


I have not modified soc_id.c as it expects to be loaded as a module with
the use of module_init() and module_exit() functions. The exported symbols
in soc_id driver cannot be accessed from the built-in code.

Agree, the SOD-ID discovery code was duplicated.

Please guide me if the below approach is okay?

1) Probe the SOC-ID in arm_smccc_version_init() and export two functions
arm_smccc_get_soc_id_version() and arm_smccc_get_soc_id_revision().

--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;

  bool __ro_after_init smccc_trng_available = false;
  u64 __ro_after_init smccc_has_sve_hint = false;
+s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
+s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;

  void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
  {
+       struct arm_smccc_res res;
+
         smccc_version = version;
         smccc_conduit = conduit;

@@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
         if (IS_ENABLED(CONFIG_ARM64_SVE) &&
             smccc_version >= ARM_SMCCC_VERSION_1_3)
                 smccc_has_sve_hint = true;
+
+       if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
+           (smccc_conduit != SMCCC_CONDUIT_NONE)) {
+               arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+                                    ARM_SMCCC_ARCH_SOC_ID, &res);
+               if ((s32)res.a0 >= 0) {
+                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+                       smccc_soc_id_version = (s32)res.a0;
+                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+                       smccc_soc_id_revision = (s32)res.a0;
+               }
+       }
  }


+s32 arm_smccc_get_soc_id_version(void)
+{
+       return smccc_soc_id_version;
+}
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_version);
+
+s32 arm_smccc_get_soc_id_revision(void)
+{
+       return smccc_soc_id_revision;
+}
+EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);


--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
+/**
+ * arm_smccc_get_soc_id_version()
+ *
+ * Returns the SOC ID version.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_version(void);

+/**
+ * arm_smccc_get_soc_id_revision()
+ *
+ * Returns the SOC ID revision.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_revision(void);


2) Use the exported functions in soc_id module.

--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -42,41 +42,23 @@ static int __init smccc_soc_init(void)
         if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
                 return 0;

-       if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
-               pr_err("%s: invalid SMCCC conduit\n", __func__);
-               return -EOPNOTSUPP;
-       }
-
-       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-                            ARM_SMCCC_ARCH_SOC_ID, &res);
-
-       if ((int)res.a0 == SMCCC_RET_NOT_SUPPORTED) {
+       soc_id_version = arm_smccc_get_soc_id_version();
+       if (soc_id_version == SMCCC_RET_NOT_SUPPORTED) {
                 pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
                 return 0;
         }

-       if ((int)res.a0 < 0) {
-               pr_info("ARCH_FEATURES(ARCH_SOC_ID) returned error: %lx\n",
-                       res.a0);
-               return -EINVAL;
-       }
-
-       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
-       if ((int)res.a0 < 0) {
+       if (soc_id_version < 0) {
                 pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
                 return -EINVAL;
         }

-       soc_id_version = res.a0;
-
-       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
-       if ((int)res.a0 < 0) {
+       soc_id_rev = arm_smccc_get_soc_id_revision();
+       if (soc_id_rev < 0) {
                 pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
                 return -EINVAL;
         }

-       soc_id_rev = res.a0;

Kconfig:
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -35,6 +35,7 @@ config ARM_GIC_V3
         select IRQ_DOMAIN_HIERARCHY
         select PARTITION_PERCPU
         select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
+       select HAVE_ARM_SMCCC_DISCOVERY

