Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89C26D53BC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjDCVjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjDCVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:39:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CC4C0C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5xYLEk9MOl4Mce+DcdbdpZ/NWa5uENAft+QCyd41YFScuT31U3XUTaq9kG8pVEJOaS3PQJzapl92PyHj+hIABlfMY5u9UYE8FvVzdAL+jLWri2DZ9cZh0CgaXug6t4Rag1553Xfw1okqRM5BRBJauQIcOkEw3tTw99J6n3MWIYeWHK1qgCjkdeJ4pZahra4wkU2yYn1LSNncsXfWBMz6D6xCxc9fczXR2h+ZRuJHzf2U1FdyGNBQ6RNdbWh6//KeijHHG2P/v8MKmFQyQQ4cB4tXpmVccCZTvG5UMhcNW9TYJswVcSO4J65j5Vcxur0Mmbvjp1qA6/iLiBQKpQ7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XQIoxEgpxl+pAf5mo78rMIbkh3B/fT21Hpcl4X3W4w=;
 b=L2NBERU6RVkmpbS85U2S6vsoTCFrwzuOsSeA3arl87mQPdaoqg2vpXaiSeI4UEGiG2A2mlFbJ2ZApk2inIkPMcgP9qNr3V1Ye5zRTh2CcTYHIa/9k7V/vTs4FuPyQQD71aRiSumJWocU95bOYBU8bQSr3KKyp6S+ONVLMplO8QvgQwzpnoPF5ZAwH9OckHYNjeKkd8pT17oQNOppgatjUkbBrgGSCjJQvd7F1vbDiONI4uanYQqDwydI6hYWffmpRtAph0RPwnyzy0bLa8TTlMaP6+D9GXbxNxBe2nRRKckgSdvitLnYWaHiF2QqowPMhrxmfj5F0oY23HY/saMQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XQIoxEgpxl+pAf5mo78rMIbkh3B/fT21Hpcl4X3W4w=;
 b=D4N6QpiBw9V26/W6JGoxv0DRXRx/eqWGKw0qOt8MOgtjhPxqqJ8PLfnI/bAzzuXZ6jymaKgWrzrusTeQxvj0puv38sykDLZ1+XqWsJIx0WQu3E7jPp96TZTGf2hsZ8aZiZKx5NHLYE/ZOOYlpQ3gZsMSPyGxvyZFyyOakp6iAHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.26; Mon, 3 Apr
 2023 21:36:43 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 21:36:43 +0000
Message-ID: <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
Date:   Mon, 3 Apr 2023 17:36:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
To:     Borislav Petkov <bp@alien8.de>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0959.namprd03.prod.outlook.com
 (2603:10b6:408:108::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 940c089a-9500-4a74-7f81-08db348b8498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5m1YVe4K31d0PZRL+48oeiMTi5u5QHScxlOCub/OK05v+JR/jd0yVehrqg0HBRLarM8JXADa97eSAzD6nhsyt9fnAu81ZEWqe5Sxrc2N6+0XmtCVUuiwEQFNcERztlLEVYOAaJMqQ8dtQGJ/NnoeFRuGwAN8CnSVirP59vaeBIsPVdldozdv7KjuA4Oq/lk2tlwiFJYEyxOHAjiUUDgR62ZTfSl6TukTHKviqpCzJca1AgnpAeJPCJUTes13bXqnfeenKUS0Lto1gR0Wg8FgSRCU7Y8j0kioTjMwfEshT8fmN7LfDdHfhAYpzrCCyNvYcaampRq9rHroV6YTnMwFsZSeaTyeXRL3OSqsiF7EXHxL5WGZPbUu78lilgb/uTEVEerh2WXdrf3On1WrjzvpGo/QhweTF4OQwp/cdbYwV8KJ+OA6Y/9vzc+8CO3cMsZ1D+cPfHvWlWbdU7g8wfxn+Sr4I+ZjuEB6rpdKvA9JKl31vBuQfV+S+RvoobKVBBN/H/Y+2r16cMiiMxVkkRBKY6db4Saek287hxeoQ/05NDUgPAO7/xBr93UrnMTCF30R2W+ro5jjBaEszhJfWKpyUha/2mRoJ+Sb393lzWGPsPpyyeJREKWNMiU/m/eUoz1UD4lT04iivxsaMsO5defvrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(36756003)(31696002)(86362001)(66946007)(66556008)(66476007)(316002)(4326008)(41300700001)(6916009)(6486002)(44832011)(38100700002)(8936002)(4744005)(2906002)(8676002)(5660300002)(53546011)(186003)(6512007)(26005)(6506007)(83380400001)(2616005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9nR092UjdURHIrVkYwMlZaTmpiYkdWOU80bUZEc1E0ZWxUdEFUcDZGZC8z?=
 =?utf-8?B?WmR4UndaVDU3VFZFdkhlZzAyb0cyeGNHQmFWdnFhenlOOVgxS2lMUHBlQ2pJ?=
 =?utf-8?B?eUY3TWRMaDZ0VXdoK2lsckVURmtJZit2RXRreElmWnZ1SUhZeFc3R3d0N0dM?=
 =?utf-8?B?L1oyUDhhSVU1YW1YWFE4QzJ0cnVZS3VlWWltYUFCV3dLRmwrUE9wV2Nwakx6?=
 =?utf-8?B?UDhLUGNrTUQ5VUpEbHZsOXY5M1M2akxRSWpIMGxrNGorbjE1ZFFhSDNCc0Ja?=
 =?utf-8?B?djdvNDZWSHlSU1lDOUJpM3hJQmpLaVE2b3NiMHVxdDVLZFFrdzh2Y1A2TDho?=
 =?utf-8?B?N0FjR0IzWW9JR3NFSGRKNnBIOGVNeHdGcHJRQ2J0ZXhDRE9nVCt0Qm9aUktK?=
 =?utf-8?B?d1ZHQlRmSzNydVlLY280RUVqUlRtT0ViS3YwZjBFNUozQ1IxN1dzaEd3N2NW?=
 =?utf-8?B?cjd3VEdjcExLaCtiZ01JZUxKbVAwWTFNbGRwYWcrTUlSN0ljeUg5c1ZESDgv?=
 =?utf-8?B?M3BmbW9lNjhLelUrbFpFQ256OVlGdFVlbGdLTTFkL0ZpTDBnSmpkZ2VEckg2?=
 =?utf-8?B?V1pmVGsyd0F2WG1LVmhxc0NNNG5KUSswQ3loeHNGZ1FhZ3ZldmcvcHVqN1FQ?=
 =?utf-8?B?eVFtUXl0ajZYZHpVWjl5OEdHYTQxWkI5MHprS3BlMWhZbm4valkyZkk5Q2Js?=
 =?utf-8?B?UjhuMmFQakltTkduY0pjUURSdlFSY1ZnWEFwM09RbHRsb2VhWXliaDhGWWh1?=
 =?utf-8?B?UG9ZaGhlRnUwVEkrUGRzVStmSXlFZzFHcGRGUnEyaWtRQXluSnV4OGx0NHBD?=
 =?utf-8?B?SmpvSVlpTWNzZml6eEpXSnVkb3FtUG1vaW1rSHR6Vk9WY01qQXkvdGRjRFUx?=
 =?utf-8?B?bWswMzJKR25yQTdrNGg3L0xKcW4wNUM1Y2R5NlNBWjlDY2V5cU9FRzhFaUdE?=
 =?utf-8?B?TVhEZk41SVZDNWNtb0xOU1NTcCtxUkEyUWNkc2FObmM3dHhWRzdoSEN5TWkr?=
 =?utf-8?B?emlqQllGdi9tbGxTQ0c3a3poZTRjUU9VTi9Od0pkWUNPVGRjY1ArUmhDMFY4?=
 =?utf-8?B?K2FVL2N5R0g0VnhjN1dxRU5sN0JJbm15NHRiNzgyWlRuNmJzRFgrNGZ3QU9t?=
 =?utf-8?B?U2tUVkVSWFhiR0U3RWlJWUJyV3lMTzN6blRQRFViNGJPOUxSNkpkbUNIR3lv?=
 =?utf-8?B?SGYwMDVOTDVITlZxMS9pYTJodmIxaEVzc0h4U1BzRXZ5dktveUw5R0FLR2FM?=
 =?utf-8?B?REU0bHhvTTc1dFFRL3oyaVhoUm50NCt5NXlCREFkR0FuQ3JXZ2dYT2x1QUVv?=
 =?utf-8?B?emVMNEZ4MVNySll0NDdCdFd0V1RHUGhLcWhnY3JvQ2xKcXRVVkN1RjFhSFcw?=
 =?utf-8?B?dHBFQmREWnE5aktPL0VHTzdVdnFPeU8rWHkvbDFkZ2dBWllXc1dHT0V0RWpO?=
 =?utf-8?B?d2JEVmt5MUh2bjVCZWEzb1dGb0NCakQ0aTJwb2N5Q3MyMWJScHNFQ000bXJ5?=
 =?utf-8?B?aFFvUzVQU1FKVWMvZVhJYm5kcTNRQjJ3bkJmZDlzUWkyQ0pJK1pmRDZXTTRN?=
 =?utf-8?B?T3B4MXlINXBmOUppTHFzS3FDOFVBRGV2OGxCUm9MRlRCNjFzT3lsbTFObGw2?=
 =?utf-8?B?Um16QnBpYXFNcnZvVHdMK2o0QzBNM1J6aEN1aDVEMFJPb3F4cUJveGFFdVh3?=
 =?utf-8?B?dnFDKzlDektuM2loOWhMTVVVVkMwdFN5bVpBL2I3eWg0REJjeGNRSVhSeWdE?=
 =?utf-8?B?dGhNa3FnNlZZK3hUT2t3VmhjamZjUlRPaVpHWlZSMWd0bmM4djhMSWdoVmE5?=
 =?utf-8?B?Tk9wMFJINGtVQjRVa2N3blhyU3FyMFQxTG5qQWtRQ000ZmcxVGhDL0w3cUx4?=
 =?utf-8?B?c1JLcW5oOUE3S0tNUXo4YlZzQW0xL2xuZ0FsQUJtcGNkZGZ4V0Yzd1cwc2N0?=
 =?utf-8?B?R1lrWnorbkk4YUVadnpodkQyN1k1dmNrbHF5QUtjUUdWNDcrcVowRWR1ZkMr?=
 =?utf-8?B?eE1LaTBjVFJlaGhtK000aVgreDE0cmp5ei9DUzkrOTNSTS80VStSWlZKeUc0?=
 =?utf-8?B?ZmxJM2prL3BxRjdLRGNzZllKTVd5bEp0cU0vYzNCZkxFeFIyQmZlTGs2K2ZS?=
 =?utf-8?Q?I9b6HASIopF3quLvw/IGIbdBB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940c089a-9500-4a74-7f81-08db348b8498
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:36:43.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k727oK4s/vMQ4HILzhI0Q3COkuVKWFsklFxB8kz+lp2lypIoai6ZrjESwG7KJqJjfhFXo2xhoUmC4T+GFC6BZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 16:36, Borislav Petkov wrote:
> On Mon, Apr 03, 2023 at 03:40:38PM -0400, Yazen Ghannam wrote:
>> I don't think pci_write_config*() sets the PCI Error response like
>> pci_read_config(), AFAICT.
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 4266b64631a4..c4caade434a7 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -181,6 +181,13 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
>  		pr_warn("Error %s SMN address 0x%x.\n",
>  			(write ? "writing to" : "reading from"), address);
>  
> +	if (!write) {
> +		if (PCI_POSSIBLE_ERROR(*value)) {
> +			err = -ENODEV;
> +			*value = 0;
> +		}
> +	}
> +
>  out_unlock:
>  	mutex_unlock(&smn_mutex);
>  
> 

Yes, that's fine. Should I send another revision?

Thanks,
Yazen
