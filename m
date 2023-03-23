Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFCE6C7310
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCWW13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:27:27 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D417CF7;
        Thu, 23 Mar 2023 15:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1GYwKn0qH4eEXdB29JAxMGAPqXl9FIiH6olu7IsDjNC/BraMf2m1wtG0s3W1JPRiKK+1rzhfIeCqDSMuK/OrqL3HoaajNO8P2ALjYS56Uzevv/bSrZVZ16GLMIkXe8kHmUxZ2xbp/zJxdz9j9ae9vT9QrV2NEjmqoNZgdZP32pBCoa+fJ75eH1eXSTM1Oct5dhTZ5mpbkAsFplLbiVBZeEmNpRsZRUacjbB+guVRbqN5FgGqSzniEfzHw5fRiO0W0sywQHnL9nVMw0MThyZ0iHUzmHjYmmlFcFvMBqA/GSc3Kvac9YYwopu94/yV4xQIZKCvVD0bQTMuRBKYtrl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNT6THAsSAAAwx4TR5nAgmZGFX8qnKAXpy8jGQGZCFs=;
 b=aKc+CMf3opSPH9FWkJlfgS5wkrOS32v+EW0MdYpj8g2WndyHtzo8V8KuDz7P9D1T4+7sxqBIXJSIf6yiyb+fiDupftu7U3PRu4nO7YVzttFyrO53GD9BY16mPfmy9UB2oavgFYPuljrKNAEXC06JfjV2A88dFfsMHZlyn/j6izv79ZnnBC6ODcpk6iJ+rkMk00wZQku1slLOD3rHBSwVsZ6iDoczNLNQFlNkCcx66zQOmsdITyGHKNoqo9V7HI/8DlOOcz2RVhMPJbluKTXtfczngu65/eG+mipLO8Qz+36TJhk6LSIMBLycrMf8DBqugfBNAhFNFUF6hsqlni9Now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNT6THAsSAAAwx4TR5nAgmZGFX8qnKAXpy8jGQGZCFs=;
 b=iqRmmOQTHj405RGxlLs998WNe3aGzrnYBbijDti09miR+nWNTD023xJ/6jBporI22zYOXX5r/K/UCmkWd6j+LbPeAP61cwrcRFF1Wp5y0dkkfAJjxrxagiP7S+b3cDfy13B0NjkWyUzjdWlwDiGbJ+YT2AZO+OasQN00M9eG3IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 22:27:21 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 22:27:20 +0000
Message-ID: <b4215d67-a5c9-aa96-704e-101770127f25@amd.com>
Date:   Thu, 23 Mar 2023 17:27:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/5] cxl/pci: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Content-Language: en-US
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com, mahesh@linux.ibm.com,
        mahesh@linux.ibm.com, oohall@gmail.com
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-5-terry.bowman@amd.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230323213808.398039-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5a2793-4267-4de4-9450-08db2bedc476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm1rD161wCUVUK0TRvFpoAoB1UPom9S7HKVwuKh1Dsg3rSDP3/Ih2cAEjeLtJa2pvLBKVV3eS8ahRPBqS9jqf23Y1fkVvJOl5ZI/Q1V1c7hHOgsS0DP7Yl/HfPOj6N2e6S+WVrXxMlC8YzZVe+UKz8CGloGpts7I2MfdGAO9Djf3DcQCHa0490pBMYgVZwA9iH2lduArqlaFYCxWj272Sxu70W6Y0UrwLtYJdRnFblaFqLvfKOoZxfEsWATWpX7A+ngsvhkn7er9E9u7gBRdgiQlx6wQfXE7u9epN4LJfTKljBQHpj18u3yOwl//XFjrvS0vT9Z54DGkFV0XtKWvE6UikP1I5dSRbMoWxM6PsROCTPnR8ce2PPwolZ4IL42sxu0eJ5UQYaG4W8Ibz252/8x849t2HP/pqVBTog++bruKFbx4v11qd0kaOKhQ2kBj2f+E8YEaGR3nYK7HBn+4oCmtb8bYy+gv+cH7JmjsZ/TFHSMAlcR27457q1CufZPyO65t3UOFbxU64cKGtey3LBsH2hEXrruTo6kkCBdF/CuSsuTKRrd0vVMHw0QrH1IWxrNOPuDLEvVOWugYs+aEGKXxEmK6VOEgPPbUc03fhJHcl0yuBlY82evxuulkPIKhY7j73vGZGljbD/MKxr0+CE6AuRBwRIkXJiGSbIdgem/mJr5dCBRZ5c9ktqHr+8vtL+pvXrBsLl4oZbqzP/tHY33NB4KxnOb4TXb794mZRJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(5660300002)(8676002)(4326008)(66556008)(66946007)(66476007)(7416002)(41300700001)(316002)(8936002)(53546011)(6666004)(6512007)(6506007)(2616005)(186003)(478600001)(6486002)(966005)(86362001)(558084003)(31696002)(36756003)(921005)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZSQ2Y0SVBRRDJtRDg4RUdnY2JSMGR3Y1Vjd2hoTlZKQ2oyUGllQzlJVS81?=
 =?utf-8?B?SzBsZW1WbjVEaVNGK3o4RkVIM0ZmajNLeDY3N3NZM3BaTnJuK3E4TFVNMlQy?=
 =?utf-8?B?UzlxWGJyUXFKellwdC9GV1k2SkpWSkVxcXYzcExsL3A1elo3QVJmYkdTbHdJ?=
 =?utf-8?B?dmFscjk2ZEJJWWdHa3lFcTdmcTR2d1N2a3JnK25pUnpOSGtFMTZGQ0JsQllJ?=
 =?utf-8?B?cTZQVGxBRi93UXg1NFBYT3lWbjNxL3ZOeFZkc2h2UWlMWm5ZZ1ZXdmFUWEdN?=
 =?utf-8?B?S2ZCT3ltclV5Zk5NZ3U5SG4reDR6eU1pVzRlRVJ5a3ZmZk1SSjI5ODhzei9Y?=
 =?utf-8?B?ZmhZcGF6RExWaWlueDlkbCtGVUZsZC9UWXZuS2FMSW8vVmd5TnlBUkdWQ0RM?=
 =?utf-8?B?TlBXWTV3Znc3U2ZIbmtmQ0FjdjFNUy8zSVpXYmM3L1lsdXpkZVMvaWhqOFhp?=
 =?utf-8?B?cWdNNmZxWXZDVmhBS0JibzVoa01GMDlsS2VhM0dZaTdqbHlRUGlCanYyNEpS?=
 =?utf-8?B?cDJld3FtdXZydHVpWVIwT0pMNk01aHl4Tmt5dmROMXZYRUt3eU8wejFvZFg5?=
 =?utf-8?B?Ly82dncySnV0SFhhZjg3UWxLcmEzODhJaU1mNmp5T1lHMXU3OC9vM2JPRFp6?=
 =?utf-8?B?TDV4eTg0MXNDVVB4YnRDSVp4Y3IwaHNFSnJYdlU5d2V1MXlwaDlyZklTeXpL?=
 =?utf-8?B?QTZIc1dBZGFKN1d3ZHZMNEQxK2lxQU1iWkZvTzBRTm9mUTZhY2htTHhScklG?=
 =?utf-8?B?ZVpDcWVIQldNUlJsY1ZSOWtwb1V0VTliZ01qS2dmbU9jdWlNOFQ2VUlPd1Z3?=
 =?utf-8?B?S3dhbVFFS1lTa21yZ1h4TVFoMXN4Q0pBcmt5ZHdHSnBRaHJBQmVIY2dsZWpU?=
 =?utf-8?B?TFRQb0JiTHRHSTg2alpWWkNOcXFuZ0RLNU9OcHRQVVlYSkNMWG1QVEJDckd4?=
 =?utf-8?B?RzlXTDYzUlZ0Q1Q5YVZtNzJNdVNyVlY2eHFYQ1lVeG9DRDhiYlJGSWRVQ1Jt?=
 =?utf-8?B?VDBWTDVTTGpmU2ZXWW1wUkE5djVOcnp6ZkQ2bG0zUHQ2Y0h1TldleWpwOXZo?=
 =?utf-8?B?V2hvUDlUbHp5eU0ydG5zVWNZVDRQVjZ3aGdyaVF2UTNMazZreE9SZkU2eWNJ?=
 =?utf-8?B?MVJjTWp2dXdodEFybW9pYklsMXI4Qi8wek92a0FaUUZqL3BjWk5INXhvZ3h3?=
 =?utf-8?B?Y0ZEUlZLeThHWm1MUUFsTWpubXdjRTE5S0ZlMk1lSTJOWWxHWUlvSmMrU3JP?=
 =?utf-8?B?alpNd2FWbWtzcjRQODhLbGFUSUU4SG5sWEZ2UWdxeFFZdy83YTYzcVNSVTA3?=
 =?utf-8?B?Y21wQmFiVHpyeTdNcmZ4TGNMRmdYVkhDZDVpRTNNZ2VYMTZ2cUhQRWZqNExV?=
 =?utf-8?B?NDNUVFBPdU9iRGhwRXN0MFUzdHNwY0YzTTZFUFladERxL1BsQ3gwaVk4VVph?=
 =?utf-8?B?TXVpeFhnNUdOZTNEUTJVSElpazhQQUpJenVsL0FYT0Ruc3M2QzAwdzA2eWdt?=
 =?utf-8?B?TlpsY25QOG1xWnUzR2RXSXNDOXVhUjZiZGZzUkxjdXRSY1FYWlBIR1duV1JO?=
 =?utf-8?B?dGdzMWdSdHR5NktDUTZoOWJFODhyR3RLNTEyQk1WS2d6RHhtWHoyYkNFVGpQ?=
 =?utf-8?B?dXhyMElhak9wcHQzM1VJbGhiQ2tVMWpEckFvUkZOVnMvSG9JaDArcTRuY0lH?=
 =?utf-8?B?bjUrWlZlcXRkeTdOREZSZnpmeDNNSWVTanhYME1XN0JzaThBWTQ2Wjd1bzFz?=
 =?utf-8?B?UHlyU3FQQnZXa0tVc1FyQklzMHJBL0YxU2pJUzRzTTNnWWh0VmVnYmNQY2hV?=
 =?utf-8?B?a1hlaXlJc1VrN2liWU5qcDJpYzcyUWtqS1NyeGNIL0xnM3NZTEU1NkU0b3Yr?=
 =?utf-8?B?aFBiQy9PUnlHUlZxTFd0Ni9EdmtNTWRGK3dON2VSNmI1ZENtQ0JtTkQ4d3pu?=
 =?utf-8?B?M0hRTzZvU0VHVnFjekdtUmpqb3Bxc3gvdFhxM0I1NVBTaFcyb1kvUXYxWCtI?=
 =?utf-8?B?TVJQQTNQcTZmN05pZzZHREVORkgvbE1BMlNOQ3RpOGlZbGUyVzJXb2tTNTZq?=
 =?utf-8?B?MUFwL2ZwY2RMemxRVTIzbGNrMlVFd3h2U0VRV1h3TUFnNnVXOXVaUEVHR2sx?=
 =?utf-8?B?c05mSUc2c2k1MUpSOXpTYUFpN1dpb20xMWRRTlpyQ3ZpS2ZIVXVBQXM4dnBs?=
 =?utf-8?Q?Eylv0J1bVSSyATHHflOzfJyfiQa61ZxHjElZOLZTYnnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5a2793-4267-4de4-9450-08db2bedc476
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 22:27:20.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQcjf4aZi6cR8IawHYnzefxeXDy4yHaQfReB2NNoYqNamVz7db3kIlJ9th1rlUR9mV5OaI0UUvXaDCxHLuHV3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding PCI reviewers.

https://lore.kernel.org/all/20230323213808.398039-1-terry.bowman@amd.com/

On 3/23/23 16:38, Terry Bowman wrote:
> |errors (UIE/CIE) with the RCEC's source ID. A CXL handler must then|
